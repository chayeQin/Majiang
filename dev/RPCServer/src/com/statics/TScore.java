package com.statics;

public enum TScore {
	//-------基础分-------
	hupai(1),	//胡牌
	dianpao(1),	//点炮
	dianheipao(5),//点黑炮
	zimo(2),	//自摸
	mobao(3),	//摸宝
	guadafeng(3),//刮大风
	hongzhongmantianfei(3),//红中满天飞
	louhu(6),//漏胡
	
	//-------倍数-------
	piaohu(2),	//飘胡
	qixiaodui(2),	//七小对
	qingyise(2),	//清一色
	shoubayi(2),	//手把一
	yaoying(2);	//幺硬
	
	private int num;
	TScore(int num) {
		this.num = num;
	}
	public int getNum(){
		return this.num;
	}
}
