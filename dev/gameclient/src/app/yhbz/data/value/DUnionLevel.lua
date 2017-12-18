-- l_联盟等级权限.xlsx
-- id=编号,lv=等级,autoJoin=自动加入,notice=公告,refuse=拒绝,approve=审批,transfer=转让盟主,reduce=降低等级,kick=踢出联盟,invite=邀请迁城,replace=取代盟主,toShop=联盟道具加入商城,
local DUnionLevel = {
  [1] = {id=1,lv=5,autoJoin=1,notice=1,refuse=1,approve=1,transfer=1,reduce=1,kick=1,invite=1,replace=0,toShop=1},
  [2] = {id=2,lv=4,autoJoin=1,notice=1,refuse=1,approve=1,transfer=0,reduce=1,kick=1,invite=1,replace=1,toShop=1},
  [3] = {id=3,lv=3,autoJoin=1,notice=1,refuse=1,approve=1,transfer=0,reduce=1,kick=0,invite=1,replace=1,toShop=0},
  [4] = {id=4,lv=2,autoJoin=0,notice=0,refuse=0,approve=0,transfer=0,reduce=0,kick=0,invite=0,replace=0,toShop=0},
  [5] = {id=5,lv=1,autoJoin=0,notice=0,refuse=0,approve=0,transfer=0,reduce=0,kick=0,invite=0,replace=0,toShop=0}
}
return DUnionLevel