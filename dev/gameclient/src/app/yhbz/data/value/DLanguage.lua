-- J_交流语言.xlsx
-- id=编号,pic=图片ID,explain=文字说明,open=可设置为系统语言,remark=策划备注,locale=地区代码,lib=字库,
local DLanguage = {
  [1] = {id=1,pic=1,explain="中文(简体)",open=1,remark="简体中文",locale="cn",lib="text/msyh"},
  [2] = {id=2,pic=1,explain="中文(繁体)",open=0,remark="繁体中文",locale="tw",lib="text/msyh"},
  [3] = {id=3,pic=3,explain="英语",open=0,remark="英语",locale="en",lib="text/msyh"},
  [5] = {id=5,pic=5,explain="西班牙语",open=0,remark="西班牙语",locale="sp",lib=""},
  [32] = {id=32,pic=32,explain="阿拉伯语",open=0,remark="阿拉伯语",locale="ar",lib=""}
}
return DLanguage