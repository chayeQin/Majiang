-- z_主动技能表文字表.xlsx
-- id=编号,name=名称,desc=描述,
local DInitiativeSkill = {
  [1] = {id=1,name="Immediate Returen",desc="Active skill. Calling all the troops outside of your fortress to return within 1 seconds. Troops in rallied marches are not included."},
  [2] = {id=2,name="General mobilization",desc="Active skill. Makes it increase marching capactity by 10% for 1 hour."},
  [3] = {id=3,name="Help",desc="Active skill, the first solo battle after using this skill(only when you attack other Commander's Fortress and camping troops). Warships lost will be damaged and sent to Maintenance Center instead of destroyed, until the Maintenance Center are full."},
  [4] = {id=4,name="Bumper Harvest",desc="Active skill. Makes it so all your resource plots immediately yield 5 hours of income."},
  [5] = {id=5,name="Mad Coleection",desc="Active skill.SpeedUp collecting speed of resources by 100% for 2 hours."},
  [6] = {id=6,name="Resource Protection",desc="Active skill. Makes it so that all the resources in your fortress can't be plundered for 2 hours."},
  [7] = {id=7,name="Energetic",desc="Active Skill. Get 30 AP immediately."},
  [8] = {id=8,name="Quick Defense",desc="Active skill. Get 500 DefenseTower immediately. Type of tower would be chosen from one of your highest level DefenseWeapons."},
  [9] = {id=9,name="Time Trap",desc="Active skill. Enemies who detect or attack you will get 5 times of marching time. (only effective before being detected or attacked. Uneffective on battles outside of fortress). Last for 30 minutes."}
}
return DInitiativeSkill