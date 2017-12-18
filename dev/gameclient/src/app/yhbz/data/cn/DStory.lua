-- J_剧情配置表文字表.xlsx
-- id=自增ID,name=名称,text=对话,
local DStory = {
  [1] = {id=1,name="1",text="贾斯丁，报告你所在的位置！"},
  [2] = {id=2,name="贾斯丁",text="{1}大人，北极星探险队已经进入白羊座星系领域，正准备降落到白羊a行星进行探索！"},
  [3] = {id=3,name="1",text="此行的目的是探索未知的新能源，一切以安全为重，遇到危险及时撤退。"},
  [4] = {id=4,name="贾斯丁",text="明白，{1}大人，我们一定会完成任务，顺利发掘有用的星际能源！"},
  [5] = {id=5,name="察克*李",text="贾斯丁，飞船已做好降落准备，随时可以降落！"},
  [6] = {id=6,name="贾斯丁",text="好的，准备降落到白羊a行星！"},
  [7] = {id=7,name="贾斯丁",text="没想到十二黄道星系果然存在着未知生物，诺克，舰艇损失如何？"},
  [8] = {id=8,name="诺克",text="还好反应及时，并未造成大量损耗，可以继续进行探索工作。"},
  [9] = {id=9,name="贾斯丁",text="那就好，大家做好一级备战准备，看来这次星际之旅必定艰难重重啊。"},
  [10] = {id=10,name="三口智子",text="贾斯丁，前面就是白羊b行星，发现不明飞行物，我们还是如期登录吗？"},
  [11] = {id=11,name="贾斯丁",text="你能想办法联络一下它们，看看是什么人吗？"},
  [12] = {id=12,name="三口智子",text="我尝试和它们沟通一下吧。"},
  [13] = {id=13,name="察克*李",text="不好，有敌袭，这次还没等我们降落呢，对方就开始发动攻击了！"},
  [14] = {id=14,name="贾斯丁",text="不要慌，准备迎战。"},
  [15] = {id=15,name="克里斯蒂娜",text="贾斯丁，我们俘获了一艘敌人的战舰，战舰上的驾驶员居然是外星人。"},
  [16] = {id=16,name="贾斯丁",text="是已知的外星生物吗？"},
  [17] = {id=17,name="克里斯蒂娜",text="不是，是未知的外星生物，而且从战舰的文明程度来看 ，都要优于已知的外星生物。"},
  [18] = {id=18,name="贾斯丁",text="看来传闻是真的，十二黄道星系存在强大的外星生物，我们要处处小心了。"},
  [19] = {id=19,name="察克*李",text="前面就是白羊c行星了，这是一个颗主行星，外星生物的大本营可能会在这里。"},
  [20] = {id=20,name="贾斯丁",text="告诉大家小心，缓慢前进，随时准备战斗。"},
  [21] = {id=21,name="三口智子",text="贾斯丁，外星生物的指挥官要求与我们进行当面对话。"},
  [22] = {id=22,name="贾斯丁",text="居然要求和我们对话？难道是被我们打怕了？"},
  [23] = {id=23,name="察克*李",text="也有可能是敌人的阴谋，外星生物的智商都很高。"},
  [24] = {id=24,name="贾斯丁",text="不管怎么样？先谈谈再说，如果对方没有敌意，和平共处是最好的。"},
  [25] = {id=25,name="三口智子",text="恩，那我去回复他们，约定对话时间。"},
  [26] = {id=26,name="贾斯丁",text="智子，是约了对方今天在白羊d行星进行当面对话吗？"},
  [27] = {id=27,name="三口智子",text="恩，是的，就是今天。"},
  [28] = {id=28,name="贾斯丁",text="怎么到现在他们还没出现了？难道有什么阴谋？"},
  [29] = {id=29,name="察克*李",text="貌似不太对路，还是先撤退再说吧。"},
  [30] = {id=30,name="三口智子",text="看来是来不及了，有敌舰出现了。"},
  [31] = {id=31,name="贾斯丁",text="你们是什么人？你们并非外星生物啊。"},
  [32] = {id=32,name="杰克",text="说你傻你还真傻。什么外星生物，我是大名鼎鼎的杰克船长。"},
  [33] = {id=33,name="贾斯丁",text="原来是星际海盗，难道你们想在这里打劫我们。"},
  [34] = {id=34,name="杰克",text="我是来告诉你们，黄道十二星座可不是谁都能来的，识相的，就赶快滚回去。"},
  [35] = {id=35,name="贾斯丁",text="一个到处被通缉的星际海盗，何以口出狂言，战舰列队。"},
  [36] = {id=36,name="贾斯丁",text="哼，上次被那狂妄的杰克逃掉了，一个小小的星际海盗，为何有如此大自信呢？"},
  [37] = {id=37,name="察克*李",text="海盗们都是无利不起早的，看来这里肯定有很多丰富的资源。"},
  [38] = {id=38,name="贾斯丁",text="我也是这么想的，今天继续探查白羊星系。"},
  [39] = {id=39,name="贾斯丁",text="你们为何攻击我们？你们是杰克船长的同伙吗？"},
  [40] = {id=40,name="艾丽斯",text="你们这些入侵者，这里是白羊星系的领地，人类是不能随便进入的。"},
  [41] = {id=41,name="三口智子",text="这次真的是外星生物，和上次我们俘获的外星战舰是一样的。"},
  [42] = {id=42,name="艾丽斯",text="赶快离开我们的星系，否则我们将不会再客气了。"},
  [43] = {id=43,name="贾斯丁",text="我们并无恶意，并不想与你们进行战争，我们只是想开采少量的能源，维持我们堡垒的正常运作。"},
  [44] = {id=44,name="艾丽斯",text="你们这些打着和平共处幌子的骗子，其实就是来掠夺我们的资源。"},
  [45] = {id=45,name="贾斯丁",text="我们可以以物易物，和平交易，我们可以谈谈。"},
  [46] = {id=46,name="艾丽斯",text="你们肯定是和那些星际海盗是一伙的，别想蒙骗我们，受死吧。"},
  [47] = {id=47,name="贾斯丁",text="你看，我们真的不是那些星际海盗，他们是被我们通缉的罪犯，我们也再追捕他们。"},
  [48] = {id=48,name="艾丽斯",text="你们真的不是海盗，那好，他们在我们星系四处掠夺，可每次我们赶到，他们早就溜之大吉了。"},
  [49] = {id=49,name="艾丽斯",text="如果你们能够将他们抓住，并且交给我们，我们可以与你们和平共处。"},
  [50] = {id=50,name="贾斯丁",text="好，他们不但掠夺你们，也四处掠夺我们人类的星际堡垒，抓住他们是我们的职责，就交给我们吧。"},
  [51] = {id=51,name="杰克",text="你们这些该死的探险队，你们为什么老是追着我们屁股后面跑。"},
  [52] = {id=52,name="贾斯丁",text="你们这些星际海盗，四处横行掠夺，联盟早就发布了追捕令，这次我们是来追捕你们的。"},
  [53] = {id=53,name="杰克",text="哈哈，好笑，星际战警都奈何不了我们，何况你们一支小小的探险队。"},
  [54] = {id=54,name="贾斯丁",text="是吗？那就来比划比划，看我们能不能抓到你们。"},
  [55] = {id=55,name="贾斯丁",text="没想到他们战斗力不怎么样，跑起来可挺快。"},
  [56] = {id=56,name="诺克",text="他们的战舰虽然火力并不是很猛，但是加速器都是通过改良的，加速度非常快，可以快速移动。"},
  [57] = {id=57,name="诺克",text="就连星际战警的巡航舰都未必能追上他们，想抓住他们可有点难度啊。"},
  [58] = {id=58,name="贾斯丁",text="那我们就只能采用计谋，来个瓮中捉鳖。"},
  [59] = {id=59,name="杰克",text="怎么又是你们，你们真是阴魂不散啊。"},
  [60] = {id=60,name="贾斯丁",text="你们四处作恶，我是代表正义来抓捕你们的。"},
  [61] = {id=61,name="杰克",text="说的这么冠冕堂皇，其实都是伪君子而已，反正你们也抓不到我。"},
  [62] = {id=62,name="贾斯丁",text="是吗？呵呵，那就看看谁能笑到最后吧。"},
  [63] = {id=63,name="杰克",text="怎么可能？为什么你们能追上来？"},
  [64] = {id=64,name="贾斯丁",text="哈哈，这次你是跑不掉的，我们已经在四周布下了磁力场方阵，你们的加速器被干扰了。"},
  [65] = {id=65,name="杰克",text="你们怎么知道我肯定会经过这里？"},
  [66] = {id=66,name="贾斯丁",text="这有多难？这里有大量能源的消息就是我们散布的，你们知道这消息，还不自己入瓮。"},
  [67] = {id=67,name="杰克",text="这次算是栽在你们手上了，不过你们别高兴太早。"},
  [68] = {id=68,name="贾斯丁",text="杰克船长就交给你们了，你答应我们的事不知道如何？"},
  [69] = {id=69,name="艾丽斯",text="以后你们可以在白羊星系的白羊π行星进行开采，作为条件，你们必须把开采的50%能源交给我们。"},
  [70] = {id=70,name="贾斯丁",text="这没问题，希望我们以后能和平共处。"},
  [71] = {id=71,name="艾丽斯",text="你们可要小心，这里可是是非之地，随时都有可能有侵略者来掠夺。"},
  [72] = {id=72,name="察克*李",text="有敌袭，难道是来救杰克的？"},
  [73] = {id=73,name="杰克",text="呵呵，我就说你们不要高兴太早，克鲁伊夫，你来的有点晚啊。"},
  [74] = {id=74,name="克鲁伊夫",text="你这个惹是生非的家伙，来是给我惹麻烦，这可是我最后一次救你了。"},
  [75] = {id=75,name="贾斯丁",text="你们是谁？杰克可是星际重犯，你们这样可是会受到联盟通缉的。"},
  [76] = {id=76,name="克鲁伊夫",text="吓唬谁呢？联盟算什么？我们俄罗斯黑手党谁都不怕。"},
  [77] = {id=77,name="贾斯丁",text="什么？你们居然是黑手党的人。"},
  [78] = {id=78,name="克鲁伊夫",text="懒得搭理你，这次算你们走运，我还有要事，下次可就没那么幸运了。"},
  [79] = {id=79,name="艾丽斯",text="他们是比杰克更可恶的人，金牛星系的已经被他们操纵了，如果你们要前往金牛星系，可要小心了。"},
  [80] = {id=80,name="贾斯丁",text="多谢提醒，不如虎穴焉得虎子，我倒要去金牛星系看看，这些黑手党有什么能耐。"},
  [81] = {id=81,name="贾斯丁",text="{1}大人，开采部队已经在白羊π行星建立了能源挖掘基地，我们准备前往金牛星系。"},
  [82] = {id=82,name="1",text="听说俄罗斯黑手党在金牛星系势力庞大，你们要多加小心。"},
  [83] = {id=83,name="贾斯丁",text="请放心，我们小心的。"},
  [84] = {id=84,name="察克*李",text="贾斯丁，前面就是金牛c行星，我们准备降落吗？"},
  [85] = {id=85,name="贾斯丁",text="准备降落，全员做好战斗准备，估计会有人来欢迎我们。"},
  [86] = {id=86,name="贾斯丁",text="我果然没猜错，初入贵境，就受到热烈欢迎啊。"},
  [87] = {id=87,name="安斯艾尔",text="你们就是克鲁伊夫说的坏人吧？"},
  [88] = {id=88,name="克里斯蒂娜",text="这年头怎么贼喊抓贼啊，他们才是万恶不赦的坏人。"},
  [89] = {id=89,name="安斯艾尔",text="别妖言惑众了，克鲁伊夫对我们可好了，帮我们挖掘能源，还给我们好吃的饼干。"},
  [90] = {id=90,name="克里斯蒂娜",text="呃，原来金牛星系的外星人都是吃货啊，一块饼干就打发了。"},
  [91] = {id=91,name="贾斯丁",text="金牛星系的原著民实在太好骗了，他们对克鲁伊夫非常信任，完全不相信我们的话。"},
  [92] = {id=92,name="察克*李",text="问题是他们还非常强大，软的不行，硬的也不行，这可怎么办？"},
  [93] = {id=93,name="贾斯丁",text="想要打败他们，只能想办法让克鲁伊夫原形毕露，只有拆散他们，才有机会获胜。"},
  [94] = {id=94,name="巴拉克",text="星际巡逻舰队指挥官巴拉克，你们是什么人？为什么突然攻击我们？"},
  [95] = {id=95,name="贾斯丁",text="误会误会，我们是北极星探险队，是来十二星系探险的，我以为你们是克鲁伊夫的舰队。"},
  [96] = {id=96,name="巴拉克",text="哦？你是说俄罗斯黑手党的克鲁伊夫？你知道他们在哪？"},
  [97] = {id=97,name="贾斯丁",text="是啊，他和星际海盗杰克船长都藏身在金牛座星系。"},
  [98] = {id=98,name="巴拉克",text="两大通缉要犯都在这里，你们愿意协助我捉拿他们吗？"},
  [99] = {id=99,name="贾斯丁",text="可是他们深得金牛星系外星生物的支持，要抓他们，有点难度啊。除非能瓦解他们之间的同盟。"},
  [100] = {id=100,name="巴拉克",text="这好办，由我们来假装攻击金牛星系基地，克鲁伊夫肯定不敢出来援助，然后你们再来援助金牛星系。"},
  [101] = {id=101,name="贾斯丁",text="可是金牛星系的武力很强啊，你们未必能逼出克鲁伊夫。"},
  [102] = {id=102,name="巴拉克",text="这你就放心吧，看我们的。"},
  [103] = {id=103,name="安斯艾尔",text="你们为什么要攻击我们？我们是爱好和平的金牛星系原著民啊。"},
  [104] = {id=104,name="巴拉克",text="我们是星际巡逻舰队，是来捉拿克鲁伊夫的，乖乖的就把他交出来。"},
  [105] = {id=105,name="安斯艾尔",text="克鲁伊夫是我们的朋友，我们是不会把他叫出来的。"},
  [106] = {id=106,name="巴拉克",text="那我们只能来强的了，受死吧。"},
  [107] = {id=107,name="安斯艾尔",text="哈哈，你还不知道我们的强大吧，居然敢口出狂言。咦？头好痛，你们做了什么？"},
  [108] = {id=108,name="巴拉克",text="我们早就知道你们金牛星系的弱点，只要用磁控波即可干扰你们的脑神经。"},
  [109] = {id=109,name="安斯艾尔",text="克鲁伊夫，快来救我们。"},
  [110] = {id=110,name="贾斯丁",text="克鲁伊夫已经逃走了，让我们来帮你们。"},
  [111] = {id=111,name="安斯艾尔",text="谢谢你们，要不是你们，我们就惨了。"},
  [112] = {id=112,name="贾斯丁",text="我们是真心想和你们成为朋友，但前提是要把克鲁伊夫赶出金牛星系，你知道他们在哪里吗？"},
  [113] = {id=113,name="安斯艾尔",text="只有在危难的时候才能看清楚谁是真正的朋友，好吧，他在金牛l行星，在那可以找到他们。"},
  [114] = {id=114,name="贾斯丁",text="谢谢，等赶走克鲁伊夫，我们再来和你们谈合作的事。"},
  [115] = {id=115,name="贾斯丁",text="克鲁伊夫就躲在金牛l行星，我们赶快去抓他们吧。"},
  [116] = {id=116,name="巴拉克",text="我们已经准备好了，随时可以进攻。"},
  [117] = {id=117,name="贾斯丁",text="好的，战舰起飞，开始进攻。"},
  [118] = {id=118,name="克鲁伊夫",text="没想到最后还是栽在你们手里。"},
  [119] = {id=119,name="巴拉克",text="你们到处为非作歹，联盟早已发布通缉令，赶快随我们回去受审吧。"},
  [120] = {id=120,name="克鲁伊夫",text="哈哈，你以为抓住我就行了吗？百慕大肯定不会任由你们抓住我的，等着吧。"},
  [121] = {id=121,name="贾斯丁",text="百慕大是什么鬼？"},
  [122] = {id=122,name="克鲁伊夫",text="哈哈，到时候你们就知道了，黄道十二星系并没有你们想的这么简单，你们会后悔的。"},
  [123] = {id=123,name="贾斯丁",text="谢谢你们的帮助，我们已经将克鲁伊夫赶出金牛星系了。"},
  [124] = {id=124,name="安斯艾尔",text="唉，他不在了，就没人帮我们开采能源了，我们虽然科技很发达，但是对开采却一窍不通。"},
  [125] = {id=125,name="贾斯丁",text="以后就由我们来帮你们开采能源吧，开采量的50%归你们，你看怎么样？"},
  [126] = {id=126,name="安斯艾尔",text="真的吗？那真是太好了，以前克鲁伊夫只会给我们10%，你们真是好人。"},
  [127] = {id=127,name="贾斯丁",text="希望我们合作愉快！"},
  [128] = {id=128,name="察克*李",text="不好了，有人来奇袭。需要赶快迎战。"},
  [129] = {id=129,name="贾斯丁",text="你们是什么人？为什么袭击我们？"},
  [130] = {id=130,name="克里夫",text="你们竟然敢和百慕大作对，你们的好日子到头了。"},
  [131] = {id=131,name="贾斯丁",text="你们是百慕大？"},
  [132] = {id=132,name="克里夫",text="百慕大可是你们这些小星际堡垒得罪不起的，今天来只是给你们一个警告，以后别再多管闲事。"},
  [133] = {id=133,name="贾斯丁",text="别走，给我说清楚。"},
  [134] = {id=134,name="克里夫",text="想知道更多？有本事来双子星系。"},
  [135] = {id=135,name="克里斯蒂娜",text="我们真的要去双子星系吗？这摆明就是个陷阱啊。"},
  [136] = {id=136,name="贾斯丁",text="我们的任务本来就是要探索所有黄道十二星系，就算没有这次的事件，我们都要来双子星系的。"},
  [137] = {id=137,name="克里斯蒂娜",text="但是正因为有百慕大的原因，我们是否应该放弃双子星系的探索呢？"},
  [138] = {id=138,name="贾斯丁",text="我们探险队本来就要面对很多困难，不能因为困难就退缩，走吧，伙伴们。"},
  [139] = {id=139,name="克里斯蒂娜",text="好吧，指挥官，我们一起共同进退。"},
  [140] = {id=140,name="杰斯克",text="你们是谁？你们是三口组的人吗？"},
  [141] = {id=141,name="贾斯丁",text="我们是北极星探险队，不是什么三口组，你们是什么人？"},
  [142] = {id=142,name="杰斯克",text="我是亚迪斯太空堡垒探险队的指挥官杰斯克，也是来探险的。"},
  [143] = {id=143,name="贾斯丁",text="你们说的三口组是什么？"},
  [144] = {id=144,name="杰斯克",text="三口组是日本民族的黑帮组织，我们刚才受到了他们的攻击，千辛万苦才逃出来。"},
  [145] = {id=145,name="贾斯丁",text="看来双子星系也并不太平啊，我们结伴同行吧。"},
  [146] = {id=146,name="杰斯克",text="那真是太好了。"},
  [147] = {id=147,name="杰斯克",text="前面是双子f行星，上次我们就是在这里被三口组伏击的。"},
  [148] = {id=148,name="贾斯丁",text="大家要小心，双子星系四处都充满诡异的气息，敌人在暗，我们在明，慢慢前行。"},
  [149] = {id=149,name="克里夫",text="我们又见面了，贾斯丁队长，没想到你们真的敢跑来双子星系。"},
  [150] = {id=150,name="贾斯丁",text="是你？百慕大？"},
  [151] = {id=151,name="杰斯克",text="他就是三口组的老大，我们之前就是受到他们的伏击。"},
  [152] = {id=152,name="贾斯丁",text="你们到底是什么人？百慕大又是什么？"},
  [153] = {id=153,name="克里夫",text="既然你们已经进入双子星系，那就别想逃出去了，我会慢慢陪你们玩。"},
  [154] = {id=154,name="贾斯丁",text="大家小心，我们已经受到对方四次伏击，而且每次他们都是攻击完就消失无踪。"},
  [155] = {id=155,name="杰斯克",text="双子星系非常诡异，对方的舰队一下子就不见了，好像凭空消失了一样。"},
  [156] = {id=156,name="威廉姆斯",text="我觉得这里应该是有二次元虫洞，敌人通过虫洞快速出现在我们面前对我们攻击， 然后又从虫洞逃离。"},
  [157] = {id=157,name="杰斯克",text="二次元虫洞？那怎么办？我们如何能躲过他们的偷袭？"},
  [158] = {id=158,name="威廉姆斯",text="二次元虫洞附近都会有很强的电磁波干扰，使用电磁波干扰探测器能提前预防，但是效果不一定很好。"},
  [159] = {id=159,name="杰斯克",text="小心，前面又出现敌人的舰队了"},
  [160] = {id=160,name="杰斯克",text="这样下去可不是办法，敌人一次次攻打我们，最好的办法还是迅速离开双子星系，不然就得全军覆没了。"},
  [161] = {id=161,name="贾斯丁",text="迅速撤离双子星系是个办法，但我们现在位于双子星系的中心地带，想撤离也不是易事。"},
  [162] = {id=162,name="威廉姆斯",text="不要慌，我们已经开启了电磁波干扰探测器的，如果附近有虫洞，我们也能发现。"},
  [163] = {id=163,name="威廉姆斯",text="我们可以赶在他们攻击我们之前，利用虫洞传送到别的地方去。"},
  [164] = {id=164,name="杰斯克",text="可是我们不知道虫洞连接到什么地方，万一去到敌人的大本营不是自投罗网吗？"},
  [165] = {id=165,name="贾斯丁",text="换个思路，我们可以埋伏在虫洞附近，等待敌人出现，然后将他们一举击溃。"},
  [166] = {id=166,name="杰斯克",text="这倒是个好办法，就这么办。"},
  [167] = {id=167,name="贾斯丁",text="终于被我们逮到你了，这次看你们怎么跑。"},
  [168] = {id=168,name="克里夫",text="没想到，你们居然能发现这里的虫洞，而且还提前做好了埋伏。"},
  [169] = {id=169,name="贾斯丁",text="这叫以其人之道还治其人之身，我们也被给伏击惨了，也叫你尝尝被人伏击的滋味。"},
  [170] = {id=170,name="克里夫",text="那就来看看你有没有这个本事吧。"},
  [171] = {id=171,name="克里夫",text="没想到你们的探险队也有这么高的战斗力，居然能打败我们三口组的精英舰队。"},
  [172] = {id=172,name="贾斯丁",text="我们两支探险队合作，当然所向披靡，乖乖就擒吧，我要把你们交给星际巡逻舰队。"},
  [173] = {id=173,name="克里夫",text="天真的家伙，你以为这就能抓住我吗？在这里，我们比你们更熟悉，再见了。"},
  [174] = {id=174,name="杰斯克",text="可恶，居然给他们逃掉了，没想到附近还有隐藏的虫洞。"},
  [175] = {id=175,name="贾斯丁",text="没关系，我相信我们还会再见面的。"},
  [176] = {id=176,name="察克*李",text="贾斯丁，我们已经进入巨蟹星系，前面就是巨蟹c行星了。"},
  [177] = {id=177,name="贾斯丁",text="自从和杰斯克分道扬镳以后，一路上风平浪静，也没再遇到三口组的人。"},
  [178] = {id=178,name="察克*李",text="是啊，不过巨蟹星系气氛很诡异啊 ，感觉到处都是哀怨的气息。"},
  [179] = {id=179,name="贾斯丁",text="我也感受到了，这里怨气很重，大家要小心。"},
  [180] = {id=180,name="贾斯丁",text="你们是什么人？为什么会在这里？"},
  [181] = {id=181,name="克拉伦斯",text="我们是巨蟹星人，世代生活在巨蟹星系。"},
  [182] = {id=182,name="贾斯丁",text="既然你们是巨蟹星人，为何如此狼狈？"},
  [183] = {id=183,name="克拉伦斯",text="我们的族长被莫利斯囚禁起来了，我们的族人只能任由莫利斯的差遣，在此挖掘能源。"},
  [184] = {id=184,name="贾斯丁",text="不要害怕，我们帮你们救出你们的族长。"},
  [185] = {id=185,name="察克*李",text="前面就是巨蟹星人族长被囚禁的巨蟹f行星，四处戒备非常森严，要想悄无声息救出族长难度很高啊。"},
  [186] = {id=186,name="贾斯丁",text="恩，只能智取不能强攻，不然容易打草惊蛇。"},
  [187] = {id=187,name="察克*李",text="那我们如何是好呢？"},
  [188] = {id=188,name="贾斯丁",text="我们只能假装前来采集的探险队，然后与对方发生冲突，然后把对方主力引开再行动。"},
  [189] = {id=189,name="察克*李",text="这倒是个办法，就这么办吧。"},
  [190] = {id=190,name="贾斯丁",text="没想到敌人的守卫如此森严，基地里居然还有这么多守卫。"},
  [191] = {id=191,name="察克*李",text="这如何是好？上次行动失败，敌人已经提高警惕了。"},
  [192] = {id=192,name="贾斯丁",text="软的不行，只能来硬的了，先离开这里再说，然后向星际巡逻舰队求助。"},
  [193] = {id=193,name="贾斯丁",text="巴拉克，你终于来了，我们遇到了棘手的事，希望你能来帮忙。"},
  [194] = {id=194,name="巴拉克",text="什么棘手的事？说来听听。"},
  [195] = {id=195,name="贾斯丁",text="巨蟹星人的族长被一个叫做莫利斯的囚禁了，巨蟹星人都成为了他的奴隶。"},
  [196] = {id=196,name="巴拉克",text="莫利斯，难道是大毒枭莫利斯，我可找他很久了，没想到躲在这里，这次我们一起联手抓住他。"},
  [197] = {id=197,name="察克*李",text="舰长，有一波敌人的舰艇围了过来。"},
  [198] = {id=198,name="巴拉克",text="来的正好，先抓几个小喽喽，打听打听情况再说。"},
  [199] = {id=199,name="巴拉克",text="前面就是莫利斯藏身的地方。我们负责主攻，你们负责接应，千万别给他们逃了。"},
  [200] = {id=200,name="贾斯丁",text="没问题，这次一定要救出老族长，解放巨蟹星人。"},
  [201] = {id=201,name="莫利斯",text="没想到是你们，巴拉克 ，你怎么会在这里。"},
  [202] = {id=202,name="巴拉克",text="我已经找你很久了，没想到你躲在这里，这次真是得来全不费工夫。"},
  [203] = {id=203,name="莫利斯",text="哼，你们以为这样就能奈何的了我，老族长还在我手上呢，大不了来个鱼死网破。"},
  [204] = {id=204,name="巴拉克",text="你可不要乱来！"},
  [205] = {id=205,name="莫利斯",text="赶快给我让出一条路来，不然我就杀了老族长。"},
  [206] = {id=206,name="贾斯丁",text="唉，这都给他跑了。幸好老族长终于就出来了。"},
  [207] = {id=207,name="巴拉克",text="放心，他跑不掉的。"},
  [208] = {id=208,name="巴拉克",text="我在莫利斯的舰艇上安装了追踪器，他就躲在这里，这次一定能抓住他。"},
  [209] = {id=209,name="贾斯丁",text="真是太好了，这次一定要将他一网打尽。"},
  [210] = {id=210,name="克拉伦斯",text="谢谢你们，是你们解救了我们巨蟹星人，你们永远是我们的朋友。"},
  [211] = {id=211,name="贾斯丁",text="不要客气，这本来就是我们应该做的。"},
  [212] = {id=212,name="克拉伦斯",text="巨蟹星系永远欢迎你们前来做客，这里的能源也任由你们开采。"},
  [213] = {id=213,name="贾斯丁",text="那真是太好了，好人终归有好报啊。"}
}
return DStory