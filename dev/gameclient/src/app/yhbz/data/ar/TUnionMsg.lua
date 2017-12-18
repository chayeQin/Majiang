-- Type_联盟消息文字表.xlsx
-- id=id,key=key,data=data,
local TUnionMsg = {
  [1] = {id=1,key="exit_union_msg",data="قام {1} بخروج الاتحاد."},
  [2] = {id=2,key="join_union_msg",data="قام {1} بانضمام إلى الاتحاد."},
  [3] = {id=3,key="atk_main_city",data="قلعة ({2}، {3}) الخاصة لـ{1}، تمت سرقتها من قبل {4}."},
  [4] = {id=4,key="atk_resource",data="{4}، {3}، {2}،من قبل {5} و{6}. التي تمت احتلالها من قبل {1}، يتم أخذها"},
  [5] = {id=5,key="place",data="{2} قام بوضع {1}."},
  [6] = {id=6,key="science_study",data="قام {1} ببدأ الدراسة في تكنولوجيا الاتحاد {2}."},
  [7] = {id=7,key="black_knight",data="قلعة {1}، تم تدميرها من قبل سفينة الفضاء الحربية."},
  [8] = {id=8,key="union_mark",data="الانتباه: قام قائد الاتحاد بتحديد الاحداثيات: X：{1} Y：{2}."},
  [9] = {id=9,key="union_kick",data="قام {1} بطرد {2} من الاتحاد."},
  [100] = {id=100,key="notice",data="قام بانضمام إلينا واجتهاد للمستقبل الباهر!"}
}
return TUnionMsg