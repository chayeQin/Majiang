-- h_活动开启规则设定文字表.xlsx
-- id=活动类型,name=活动名称,desc=活动描述,
local DActivityOpen = {
  [1] = {id=1,name="The Opening Match",desc="1. New Server Match is divided into multiple stages. Completing the tasks of stages will get scores.\n2.You will get stage rewards if you reach score requirement.\n3. We will present a rank list of points during different stages. Top 100 players will get a stage-rank rewards.\n4. After the event, Top-100 players will get a total-rank rewards according to the total points you get during all stages."},
  [2] = {id=2,name="Time-Limited Match",desc="1. The Time-Limited Match is divided into multiple stages. Completing the tasks of stages will get scores.\n2.You will get stage rewards if you reach score requirement.\n3. We will present a rank list of points during different stages. Top 100 players will get a stage-rank rewards.\n4. After the event, Top-100 players will get a total-rank rewards according to the total points you get during all stages."},
  [3] = {id=3,name="Space War",desc="1. When the Space War activity starts, R4 and R5 Alliance Members can choose to start Space War.\n2. War guard props are invalid for Space War.\n3. The more chances against the alien fleet, the more points you get.\n4. You will not be attacked by black hole any more if you failed to defend your city twice. You can choose to help your alliance member.\n5. The event will be over if all alliance members have failed to defend their cities twice. \n6. Each federation can only open once during the event.  \n7. Alien fleet will not take your resources. His attack will only do a little harm to your fleet. \n8. You will not get rewards if you leave federation during the event."},
  [4] = {id=4,name="Battle of Mastership",desc="1. The first Battle of Mastership will be released 15 days after opening one server which will be started at 4 p.m. on each Saturday. Players who joined in the federation can take part in it. \n2. The event lasts for 24 hours. \n3. All federations can plunder Galaxy Fortress and Base Station. Occupying construction can get points.\n4. Anyone who occupies Galaxy Federation will get 100 points of each minute. Anyone who occupies Galaxy Base Station will get 35 points of each minute. \n5. No.1 federation will get distributive authority of Galxy Overlord. \n6. Other federations will get points according to the rule. Reward will be sent out via mail. \n7. Chief of the winner federation will apoint Galaxy Overlord within 1 hour. If not, the chief will become Galaxy overlord after 1 hour. \n8. Anyone can send out troops to Galaxy Fortress when it is in a state of contention. \n9. After sending out troops, if the occupier is your own federation, you can do assistance. \n10. If the occupier is not your federation, you can start a battle. \n11. The maximum fleet quantity is decided by the marching upper limit of occupier and level of Strategy Center."},
  [5] = {id=5,name="Galaxy Battlefield",desc="1. Commanders whose fortress is level 15 or above can enter Galaxy Battlefield.\n2. When the event starts, commanders of all galaxies will be transferred to Galaxy Battlefield. \n3. In Galaxy Battlefield, commanders can only attack those who are of different galaxies.\n4. Attack commanders of other galaxies and you will get points. Rewards will be given according to Personal Points Rank and Galaxy Points Rank."},
  [6] = {id=6,name="Dragon Battle",desc="1. When the event starts, R4 and R5 alliance members can enter Dragon Battle.\n2. You will be matched by system randomly. The winner will enter the next round.\n3. Joinning Dragon Battle will bring you a large quantity of props rewards."},
  [7] = {id=7,name="Daily Supply",desc="1. Commander can get four free supplies daily which can be collected after login. \n2. Challenge book can be used to attack battle instance where drops a large number of equipment materials and props. \n3. HP can be used to fight against galatic pirates which drops  technology factors and Commander order. \n4. HP has reached the upper limit and cannot be received now. Please use HP first and receive again. \n5. Don't forget to receive daily supply after login!"},
  [8] = {id=8,name="Red Envelope",desc="1.Red envelope, also known as New Year's money, is the money wrapped in red paper from the elders to children in Chinese Lunar New Year. It brings new year's blessing and good luck to them. \n2. After buying a red envelope, you can choose the member who can receive your red envelopes and the channel. \n3. Members will receive ramdom amount of diamonds, the total value is total number of diamonds in red envelopes.\n4.After buying, they can not get diamonds, but can receive their own red envelopes, grab red envelope in the diamond."},
  [9] = {id=9,name="Prize-giving Quiz",desc="1. You have 5 chances of answering questions during the event. There will be a cool down time between two quizzes. \n2. You will get reward even if you fail to answer the quiz. The more scores the more valuable reward. \n3. You will get points if you answer questions correctly. Points will be taken as ranking standard. \n4. Rewards will be sent out by e-mail according to the rank after event."},
  [10] = {id=10,name="Prize-giving Mission",desc="1. You will get items if you complete mission during the event. \n2. Rewards will be sent out by e-mail after completing mission. \n3. There will be different missions everyday. Please check it."},
  [11] = {id=11,name="Lucky flop",desc="1. There will be 3 free chances of flopping everyday during the event. You can spend diamonds to flop after free chances. \n2. If you are not satisfied with the reward. You can spend some diamonds refreshing rewards. \n3. Only one reward can be chosen once. The value of three rewards is higher than diamonds. \n4. Rewards will be divided into three levels. The higher the level, the higher the value. There will be different points for different levels. \n5. Rewards will be sent out by e-mail according to the rank after event."},
  [12] = {id=12,name="Invasion",desc="1. There will be a large amount of Alien warships on galaxy map during the event. Attacking alien warships will get items. \n2. Alien warship will be divided into several levels. Degree of difficulty varies from different levels. \n3. Reward is related with HP of attacking alien warships. Killing will get extra rewards. \n4. Attacking and killing alien warships can get points. Rewards will be sent out according to the rank after event."},
  [13] = {id=13,name="Lucky day",desc="1. There is a chance to get lucky BUFF during Lucky day event. \n2. Lucky BUFF is divided into several types, including reduce construction upgrading time, construction upgrading consumption time and technology research time. \n3. There is a time limit of Locky BUFF. It is no longer valid when time is up. \n4. There is a limit time to get lucky BUFF every day. You will no longer get lucky BUFF after using up chances."},
  [14] = {id=14,name="Diamond Looting",desc="1.Commanders can get rare tools by with diamonds in diamong looting and can get a 10% discount after 5 times.\n2.Commanders can exchage the rare officer or officer pieces with smart crystal in diamond looting store and the store will update irregularly;\n  3.When the total times of diamond looting reaches a certain number, commander can get a additional reward. The total times will be reset at 00:00 every Monday; \n4.Commander can get a certain amount of lucky point every time of diamond looting. There must be a rare stuff when the bar of lucky point is full.\n5.Once commander get the rare stuff, the lucky point will be reset to zero and calculate again.\n6.If commander gets a repeat officer in diamond looting then it will convert to officer pieces;\n7.The reward of diamong looting will be reset at 00:00 every Monday;"}
}
return DActivityOpen