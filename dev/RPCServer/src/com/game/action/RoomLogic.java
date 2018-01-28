package com.game.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.alibaba.fastjson.JSON;
import com.game.Start;
import com.game.netty.GameHandler;
import com.model.game.server.RoomPlayer;
import com.model.game.server.RoomSettlement;
import com.model.game.server.RoomStatus;
import com.statics.StaticData;
import com.statics.TDoActType;
import com.statics.TScore;

import static com.statics.TDoActType.*;

/**
 * 房间逻辑
 * @author JOY122468462
 */
public class RoomLogic {
	private static final Map<String, Integer> scoreMap = new HashMap<>();
	/** 默认牌堆 **/
	private List<Integer> library;
	
	private RoomStatus room;
	
	/** 等待的动作列表 **/
	private List<Object[]> doActionList = new ArrayList<Object[]>();
	
	/** 根据顺序,进行动作排序 **/
	private final Comparator<Object[]> doActionAort = new Comparator<Object[]>() {
		@Override
		public int compare(Object[] o1, Object[] o2) {
			//uid, type, cards
			int v1 = getV((int)o1[1]);
			int v2 = getV((int)o2[1]);
			if(v1 != v2){
				//从小到大排序
				if(v1 < v2)return -1;
				return 1;
			}else if(room != null){
				int i1 = room.getPlayerIndexs().get(o1[0]);
				int i2 = room.getPlayerIndexs().get(o2[0]);
				int _i = room.getOutIndex();
				//按照座位，顺时针
				for (int i = 0; i < room.getMaxSize(); i++) {
					_i++;//不包括出牌的人,所以先+1
					if(_i >= room.getMaxSize())_i = 0;
					if(i1 == _i){
						v1 = i;
					}else if(i2 == _i){
						v2 = i;
					}
				}
			}
			if(v1 == v2)return 0;
			//从小到大排序
			if(v1 < v2)return -1;
			return 1;
		}
		protected int getV(int type) {
			//胡 > 杠 > 碰 > 吃
			if(type == hu){
				return 1;
			}else if(type == gang){
				return 10;
			}else if(type == peng){
				return 20;
			}
			return 999;
		}
	};
	private static final int getScoreValue(String key){
		Integer integer = scoreMap.get(key);
		if(null == integer)return 0;
		return integer;
	}
	@SuppressWarnings("unused")
	private void testDoAction() {
		room = new RoomStatus("1", 1, 0, null, 4, new String[]{"u1","u2","u3","u4"});
		room.setOutIndex(3);
		doActionList.add(new Object[]{"u2", hu, null});
		doActionList.add(new Object[]{"u4", hu, null});
		Collections.sort(doActionList, doActionAort);
		for (Object[] obj : doActionList) {
			System.out.println(obj[0]+","+obj[1]);
		}
	}

	public RoomLogic() {
	}
	public RoomLogic(String roomId, int roomType, int count, String types, int size, String players) {
		this.library = new ArrayList<>();
		String[] split = players.split(",");
		this.room = new RoomStatus(roomId, roomType, count, types, size, split);
	}


	/** 启动 **/
	public void start() {
		room.setStatus(true);
		
		restart();
	}
	/**  重新开始 **/
	private void restart() {
		room.setCount(room.getCount() + 1);
		room.setSetts(null);
		//初始化牌库
		this.library.clear();
		Collections.addAll(this.library, StaticData.library);
		//打乱顺序
		Collections.shuffle(this.library);
		int baopai = this.library.get(new Random().nextInt(this.library.size()));
		room.setBaopai(baopai);
		//发牌
		room.clear();
		RoomPlayer[] players = room.getPlayers();
		for(RoomPlayer player : players){
			List<Integer> hand = player.getHand();
			for(int j = 0;j < 13; j++){
				hand.add(headLibrary());
			}
			Collections.sort(hand);
			
			//GameHandler.send("room", "gs_putHand", uuid, hand);
		}
		doNext(1, room.getBankerIndex());
	}
	/**
	 * 轮到下一个人
	 * 1.发牌
	 * 2.等待这个玩家操作
	 * @param touchCard 摸牌类型:0=不操作;1=头顶摸;2=屁股摸
	 * @param nextIndex 轮到谁操作
	 */
	private void doNext(int touchCard, int nextIndex) {
		if(nextIndex >= room.getMaxSize()){
			nextIndex = 0;
		}
		room.setOutCard(-1);
		room.setOutIndex(nextIndex);
		RoomPlayer[] players = room.getPlayers();
		RoomPlayer doPlayer = players[room.getOutIndex()];
		//摸牌状态下才可以摸牌
		if(touchCard > 0){
			List<Integer> hand = doPlayer.getHand();
			int card;
			if(touchCard == 1){
				card = headLibrary();
			}else{
				card = tailLibrary();
			}
			hand.add(card);
			Collections.sort(hand);
			room.setGetCard(card);
		}
		//检测是否有暗杠|头顶杠|胡牌
		boolean gang = isAngang(doPlayer);
		boolean hupai = false;
		if(touchCard > 0){
			if(gang == false)gang = isTopgang(doPlayer);
			hupai = isHupai(doPlayer, -1);
		}
		doPlayer.getActions().clear();
		//吃,碰,杠,胡
		if(gang){
			doPlayer.getActions().add(TDoActType.gang);
		}
		if(hupai){
			doPlayer.getActions().add(TDoActType.hu);
		}
		room.getWaitPlayers().add(doPlayer.getUid());
		doPlayer.getActions().add(TDoActType.chupai);
		//同步数据
		GameHandler.send("room", "gs_updateGame", room);
	}


	/**
	 * 从牌堆里面摸一张牌
	 * @return -1=找不到牌
	 */
	private int headLibrary() {
		return this.library.remove(0);
	}
	/**
	 * 从末尾摸一张牌
	 * @return -1=找不到牌
	 */
	private int tailLibrary() {
		return this.library.remove(this.library.size()-1);
	}

	/**
	 * 是否暗杠
	 */
	public boolean isAngang(RoomPlayer players) {
		List<Integer> hand = players.getHand();
		int count = 0;
		int upCard = 0;
		int size = hand.size();
		for(int i = 0;i < size; i++){
			int card = hand.get(i);
			if(card != upCard){
				upCard = card;
				count = 1;
			}else{
				count++;
			}
			if(count >= 4)return true;
			//后面不足了,不需要继续检查
			if(i + (4-count) >= size)return false;
		}
		return false;
	}
	/**
	 * 是否有头顶杠
	 */
	private boolean isTopgang(RoomPlayer roomPlayer) {
		List<Integer> hand = roomPlayer.getHand();
		List<List<Integer>> top = roomPlayer.getTop();
		for (List<Integer> list : top) {
			//不是3张牌就直接跳过
			if(list.size() != 3)continue;
			//前面2个牌不一样,就直接跳过了
			if(list.get(0).equals(list.get(1)) == false)continue;
			
			for (Integer tmpCard : hand) {
				List<Integer> size = getCardsByCard(list, tmpCard, 3);
				if(size.size() >= 3){
					return true;
				}
			}
		}
		return false;
	}
	
	private List<Integer> tmpCards = new ArrayList<Integer>();
	/**
	 * 从cards里面找出所有card
	 * @param cards
	 * @param card
	 * @return
	 */
	public List<Integer> getCardsByCard(List<Integer> cards,int card,int size){
		tmpCards.clear();
		for (Integer tmp : cards) {
			if(tmp == card){
				tmpCards.add(tmp);
			}
			if(tmpCards.size() >= size)return tmpCards;
		}
		return tmpCards;
	}
	
	
	private boolean list_remove(List<Integer> cards, int card) {
		for (int i = 0; i < cards.size(); i++) {
			if(card == cards.get(i)){
				cards.remove(i);
				return true;
			}
		}
		return false;
	}
	/**
	 * 执行动作
	 * @param uid
	 * @param type 吃,碰,杠,胡,听,出牌,取消
	 * @param cards
	 */
	public void doAction(String uid, int type, int[] cards) {
		if(room.getWaitPlayers().contains(uid) == false){
			return;//没有轮到他
		}
		RoomPlayer doPlayer = room.getPlayer(uid);
		if(type > 0){
			boolean bl = false;
			for (int a : doPlayer.getActions()) {
				if(a == type){
					bl = true;
					break;
				}
			}
			if(bl == false)return;
			doPlayer.getActions().clear();
		}
		//如果只有1个动作,那么直接执行,不用等待
		if(room.getWaitPlayers().size() == 1 && doActionList.isEmpty()){
			room.getWaitPlayers().clear();
			doActionImpl(uid, type, cards);
		}else{
			//如果有多个动作，先储存起来，等所有动作都回来了，一次性执行
			room.getWaitPlayers().remove(uid);
			doActionList.add(new Object[]{uid, type, cards});
			if(room.getWaitPlayers().isEmpty()){
				//根据顺序,执行多个动作
				if(doActionList.size() > 1){
					Collections.sort(doActionList, doActionAort);
				}
				room.getWaitPlayers().clear();
				for (Object[] objs : doActionList) {
					//执行动作
					doActionImpl((String)objs[0], (int)objs[1], (int[])objs[2]);
					break;
				}
				doActionList.clear();
			}
		}
		
	}
	/**
	 * 执行动作-实现
	 * @param uid
	 * @param type
	 * @param cards
	 */
	private void doActionImpl(String uid, int type, int[] cards) {
		GameHandler.send("room", "gs_doAction", room.getRoomId(), uid, type);
		if(type == chi){
			doActionChi(uid, cards[0], cards[1]);
		}else if(type == peng){
			doActionPeng(uid);
		}else if(type == gang){
			doActionGang(uid, cards);
		}else if(type == hu){
			doActionHu(uid);
		}else if(type == ting){
			doActionTing(uid);
		}else if(type == quxiao){
			doActionQuxiao(uid);
		}else if(type == chupai){
			doActionChupai(uid, cards[0]);
		}		
	}

	/**
	 * 执行动作-取消
	 */
	private void doActionQuxiao(String uid) {
		// 什么都不干
		RoomPlayer player = room.getPlayer(uid);
		//下个人摸牌&轮到下一个人操作
		doNext(1, player.getIndex()+1);
	}

	/**
	 * 执行动作-听牌
	 */
	private void doActionTing(String uid) {
		RoomPlayer player = room.getPlayer(uid);
		player.setListen(true);
		//下个人摸牌&轮到下一个人操作
		doNext(1, player.getIndex()+1);
	}

	/**
	 * 执行动作-胡牌
	 */
	private void doActionHu(String uid) {
		//结算
		room.setStatus(false);
		
		int hupaiIndex = room.getPlayerIndexs().get(uid);
		RoomPlayer[] players = room.getPlayers();
		RoomSettlement[] setts = new RoomSettlement[players.length];
		for (int i = 0; i < setts.length; i++) {
			RoomSettlement set = new RoomSettlement();
			set.setUid(players[i].getUid());
			//类型;1=自摸;2=胡牌;3=放炮
			if(room.getOutIndex() == i && hupaiIndex == i){
				//如果摸牌的人是自己,并且胡牌的人也是自己
				set.setType(1);
			}else if(hupaiIndex == i){
				//如果胡牌的人是自己
				set.setType(2);
			}else if(room.getOutIndex() == i){
				//如果出牌的人是自己
				set.setType(3);
			}
			set.setScore(new int[3]);
			setts[i] = set;
		}
		for (int i = 0; i < setts.length; i++) {
			RoomSettlement set = setts[i];
			RoomPlayer player = room.getPlayers()[i];
			//（胡分、杠分、总计）
			int[] score = set.getScore();
			if(set.getType() == 1){
				//自摸=除了自己,其他人全部扣分
				for (int j = 0; j < setts.length; j++) {
					if(room.getGetCard() == room.getBaopai()){
						if(i == j){
							score[0] += TScore.mobao.getNum() * (room.getMaxSize() - 1);
						}else{
							score[0] -= TScore.mobao.getNum();
						}
					}else{
						if(i == j){
							score[0] += TScore.zimo.getNum() * (room.getMaxSize() - 1);
						}else{
							score[0] -= TScore.zimo.getNum();
						}
					}
				}
			}else if(set.getType() == 3){
				//点炮和点黑炮
				for (int j = 0; j < setts.length; j++) {
					if(player.isListen()){
						//点炮=上听后点炮，胡牌的人加分，其他三家都扣分
						if(j == hupaiIndex){
							score[0] += TScore.dianpao.getNum() * (room.getMaxSize() - 1);
						}else{
							score[0] -= TScore.dianpao.getNum();
						}
					}else{
						//点黑炮,自己扣分,胡牌加分,其他人不扣分
						if(j == hupaiIndex){
							score[0] += TScore.dianheipao.getNum();
						}else{
							score[0] -= TScore.dianheipao.getNum();
						}
					}
				}
				
			}
			score[1] = getGangfen(players[i]);
			score[2] = score[0] + score[1];
			set.setScore(score);
		}
		room.setSetts(setts);
		//同步数据
		GameHandler.send("room", "gs_updateGame", room);
	}
	/**
	 * 获取杠分
	 * @param player
	 * @return
	 */
	private int getGangfen(RoomPlayer player) {
		List<List<Integer>> top = player.getTop();
		if(null == top || top.isEmpty())return 0;
		int score = 0;
		for (List<Integer> list : top) {
			if(list.size()==4){
				if(list.get(0) > 0){
					score += getScoreValue("明杠");
				}else{
					score += getScoreValue("暗杠");
				}
			}
		}
		return score;
	}

	/**
	 * 执行动作-杠
	 */
	private void doActionGang(String uid, int[] cards) {
		RoomPlayer player = room.getPlayer(uid);
		List<Integer> hand = player.getHand();
		List<List<Integer>> top = player.getTop();
		boolean ok = false;
		//如果有发送数据过来,说明是选择了暗杠 or 头顶杠
		if(cards != null && cards.length >= 1 && room.getOutIndex() == player.getIndex()){
			List<Integer> list = getCardsByCard(hand, cards[0], 4);
			if(list.size() >= 4){
				//手里3张扔掉
				list_remove(hand, room.getOutCard());
				list_remove(hand, room.getOutCard());
				list_remove(hand, room.getOutCard());
				//放入头顶中
				List<Integer> addList = new ArrayList<Integer>();
				addList.add(room.getOutCard());
				addList.add(room.getOutCard());
				addList.add(room.getOutCard());
				addList.add(room.getOutCard());
				top.add(addList);
				ok = true;
			}else{
				for (List<Integer> topList : top) {
					list = getCardsByCard(topList, cards[0], 3);
					if(list.size() >= 3){
						//扔掉手里1张,放入topList里面
						list_remove(hand, cards[0]);
						topList.add(cards[0]);
						ok = true;
						break;
					}
				}
			}
		}
		//杠牌顺序: 别人放手中杠 > 头顶摸杠 > 暗杠
		if(ok == false){
			//检测 别人放手中杠
			if(room.getOutIndex() != player.getIndex() 
					&& room.getOutCard() > 0){
				List<Integer> list = getCardsByCard(hand, room.getOutCard(), 3);
				if(list.size() >= 3){
					RoomPlayer p = room.getPlayers()[room.getOutIndex()];
					list_remove(p.getLose(), room.getOutCard());
					//手里3张扔掉
					list_remove(hand, room.getOutCard());
					list_remove(hand, room.getOutCard());
					list_remove(hand, room.getOutCard());
					//放入头顶中
					List<Integer> addList = new ArrayList<Integer>();
					addList.add(room.getOutCard());
					addList.add(room.getOutCard());
					addList.add(room.getOutCard());
					addList.add(room.getOutCard());
					player.getTop().add(addList);
					ok = true;
				}
			}
		}
		if(ok == false){
			//检测 头顶摸杠
			if(room.getOutIndex() == player.getIndex()){
				for (List<Integer> topList : top) {
					//不是3张牌就直接跳过
					if(topList.size() != 3)continue;
					//前面2个牌不一样,就直接跳过了
					if(topList.get(0).equals(topList.get(1)) == false)continue;
					
					for (Integer tmpCard : hand) {
						List<Integer> size = getCardsByCard(topList, tmpCard, 3);
						if(size.size() >= 3){
							list_remove(hand, tmpCard);
							topList.add(tmpCard);
							ok = true;
							break;
						}
					}
				}
			}
		}
		if(ok == false){
			//检测 暗杠
			if(room.getOutIndex() == player.getIndex()){
				int count = 0;
				int upCard = 0;
				int size = hand.size();
				for(int i = 0;i < size; i++){
					int card = hand.get(i);
					if(card != upCard){
						upCard = card;
						count = 1;
					}else{
						count++;
					}
					if(count >= 4){
						//手里3张扔掉
						list_remove(hand, card);
						list_remove(hand, card);
						list_remove(hand, card);
						//放入头顶中
						List<Integer> addList = new ArrayList<Integer>();
						addList.add(card);
						addList.add(card);
						addList.add(card);
						addList.add(card);
						player.getTop().add(addList);
						ok = true;
						break;
					}
					//后面不足了,不需要继续检查
					if(i + (4-count) >= size)break;
				}
			}
		}
		
		//屁股摸牌&轮到自己出牌了
		doNext(2, player.getIndex());
	}

	/**
	 * 执行动作-碰牌
	 */
	private void doActionPeng(String uid) {
		RoomPlayer p = room.getPlayers()[room.getOutIndex()];
		list_remove(p.getLose(), room.getOutCard());
		
		RoomPlayer player = room.getPlayer(uid);
		List<Integer> hand = player.getHand();
		list_remove(hand, room.getOutCard());
		list_remove(hand, room.getOutCard());
		List<Integer> addList = new ArrayList<Integer>();
		addList.add(room.getOutCard());
		addList.add(room.getOutCard());
		addList.add(room.getOutCard());
		player.getTop().add(addList);
		//轮到自己出牌了
		doNext(0, player.getIndex());
	}

	/**
	 * 执行动作-吃牌
	 * @param doCard1 牌1
	 * @param doCard2 牌2
	 */
	private void doActionChi(String uid, int doCard1, int doCard2) {
		RoomPlayer p = room.getPlayers()[room.getOutIndex()];
		list_remove(p.getLose(), room.getOutCard());
		
		RoomPlayer player = room.getPlayer(uid);
		List<Integer> hand = player.getHand();
		list_remove(hand, doCard1);
		list_remove(hand, doCard2);
		List<Integer> addList = new ArrayList<Integer>();
		addList.add(doCard1);
		addList.add(doCard2);
		addList.add(room.getOutCard());
		player.getTop().add(addList);
		//轮到自己出牌了
		doNext(0, player.getIndex());
	}

	/**
	 * 执行动作5-出牌
	 * @param doUid
	 * @param doCard
	 */
	private void doActionChupai(String doUid, int doCard) {
		RoomPlayer player = room.getPlayer(doUid);
		room.setOutCard(doCard);
		room.setOutIndex(player.getIndex());
		list_remove(player.getHand(), doCard);
		player.getLose().add(doCard);
		//检测玩家状态
		checkPlayerStatus();
		//如果没有玩家有意义
		if(room.getWaitPlayers().isEmpty()){
			//下个人摸牌&操作
			doNext(1, player.getIndex()+1);
		}else{
			//否则更新服务器房间状态
			GameHandler.send("room", "gs_updateGame", room);
		}
	}

	/**
	 * 检查玩家的状态
	 * 是否有吃,碰,杠,胡
	 */
	private void checkPlayerStatus() {
		RoomPlayer[] players = room.getPlayers();
		for(int i = 0;i < players.length;i++){
			if(i == room.getOutIndex()){
				continue;//跳过出牌的人
			}
			int outIndex = room.getOutIndex();
			int outCard = room.getOutCard();
			RoomPlayer player = players[i];
			boolean chi = false;
			//出牌的人，是我的上一家，才能吃
			if((i == 0 && outIndex == 3) || outIndex == i - 1)chi = isChipai(player, outCard);
			boolean peng = isPengpai(player, outCard);
			boolean gang = isGangpai(player, outCard);
			boolean hu = isHupai(player, outCard);
			if(chi){
				player.getActions().add(TDoActType.chi);
			}
			if(peng){
				player.getActions().add(TDoActType.peng);
			}
			if(gang){
				player.getActions().add(TDoActType.gang);
			}
			if(hu){
				player.getActions().add(TDoActType.hu);
			}
			if(player.getActions().isEmpty() == false){
				room.getWaitPlayers().add(player.getUid());	
			}
		}
	}
	/**
	 * 是否可以杠牌
	 * @param uid
	 * @param outCard 出的牌
	 * @return
	 */
	private boolean isGangpai(RoomPlayer player, int outCard) {
		List<Integer> tmp = new ArrayList<>(player.getHand());
		//只有3张牌不能杠
		if(tmp.size() <= 3)return false;
		//找出3个一样的outCard
		List<Integer> list = getCardsByCard(tmp, outCard, 3);
		return list.size() >= 3;
	}

	/**
	 * 是否可用碰牌
	 * @param uid
	 * @param outCard 出的牌
	 * @return
	 */
	public boolean isPengpai(RoomPlayer player, int outCard) {
		List<Integer> tmp = new ArrayList<>(player.getHand());
		//只有2张牌不能碰
		if(tmp.size() <= 2)return false;
		//找出2个一样的outCard
		List<Integer> list = getCardsByCard(tmp, outCard, 2);
		return list.size() >= 2;
	}

	/**
	 * 是否可用吃牌
	 * @param player
	 * @param outCard 出的牌
	 * @return
	 */
	public boolean isChipai(RoomPlayer player, int outCard) {
		List<Integer> tmp = new ArrayList<>(player.getHand());
		//只有2张牌不能吃
		if(tmp.size() <= 2)return false;
		//包含顺子就可以吃,-2~2
		int count = 0;
		for(int i = -2;i <= 2;i++){
			if(i == 0)continue;
			if(tmp.contains(i + outCard)){
				count++;
			}else{
				count = 0;
			}
			if(count >= 2)return true;
		}
		return false;
	}
	/**
	 * 是否胡牌
	 * @param player
	 * @param outCard 打出的牌,-1=自己摸牌
	 * @return
	 */
	public boolean isHupai(RoomPlayer player, int outCard){
		//听了牌才可以胡牌
		if(player.isListen() == false){
			return false;
		}
		List<Integer> tmp = new ArrayList<>(player.getHand());
		if(outCard > 0){
			tmp.add(outCard);
			//排序
			Collections.sort(tmp);			
		}
		//只有2张牌，一样的话，就胡牌
		if(tmp.size() == 2){
			return tmp.get(0) == tmp.get(1);
		}
		
		//临时存放牌型数据
		List<Integer> tmpCards = new ArrayList<>();
		//依据牌的顺序从左到右依次分出将牌
		for (int i = 0; i < tmp.size(); i++){
			tmpCards.clear();
			tmpCards.addAll(tmp);
			int tmpCard = tmp.get(i);
			List<Integer> tmpJiang = getCardsByCard(tmpCards, tmpCard, 2);
			//如果可以做将牌
			if(tmpJiang.size() >= 2){
				//防止重复判断,所以加2
				i += tmpJiang.size();
				//删除掉将牌,继续判断
				list_remove(tmpCards, tmpCard);
				list_remove(tmpCards, tmpCard);
				//检测是否能胡牌
				if(isHupai(tmpCards))return true;
			}
		}
		return false;			
	}
	/**
	 * 是否能够胡牌
	 * @param tmpCards
	 * @return
	 */
	private boolean isHupai(List<Integer> tmpCards) {
		if(tmpCards.isEmpty())return true;
		for (Integer c : tmpCards) {
			//找出克子牌(3个一样的)
			List<Integer> tmpKezi = getCardsByCard(tmpCards, c, 3);
			if(tmpKezi.size() == 3){
				list_remove(tmpCards, c);
				list_remove(tmpCards, c);
				list_remove(tmpCards, c);
				return isHupai(tmpCards);
			}else{
				//找出顺子
				if(tmpCards.contains(c+1) && tmpCards.contains(c+2)){
					list_remove(tmpCards, c);
					list_remove(tmpCards, c+1);
					list_remove(tmpCards, c+2);
					return isHupai(tmpCards);
				}
			}
		}
		return false;
	}
}
