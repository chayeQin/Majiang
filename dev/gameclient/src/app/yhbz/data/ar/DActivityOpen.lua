-- h_活动开启规则设定文字表.xlsx
-- id=活动类型,name=活动名称,desc=活动描述,
local DActivityOpen = {
  [1] = {id=1,name="مسابقة الافتتاح",desc="1. هناك فترات مختلفة لمسابقة الافتتاح. يمكنك الحصول على النقاط من خلال إكمال المهمات لكل التفرة. 2. عند وصول نقاطك إلى حد مطلوب، تحصل على الجوائز. 3. سيتم إعلان مراكز النقاط في كل الفترة. أفضل 100 اللاعبين سيحصلون على جوائز المراكز للفترة. 4. بعد المسابقة، سيتم ترتيب اللاعبين بناء على النقاط الإجمالية لجميع الفترات، وأفضل 100 اللاعبين سيحصلون على جوائز المراكز النهائية."},
  [2] = {id=2,name="مسابقة الوقت المحدود",desc="1. هناك فترات مختلفة لمسابقة الوقت المحدود. يمكنك الحصول على النقاط من خلال إكمال المهمات في كل الفترة. 2. عند وصول نقاطك إلى حد مطلوب، تحصل على الجوائز. 3. سيتم إعلان مراكز النقاط في كل الفترة. أفضل 100 اللاعبين سيحصلون على جوائز المراكز للفترة. 4. بعد المسابقة، سيتم ترتيب اللاعبين بناء على النقاط الإجمالية لجميع الفترات، وأفضل 100 اللاعبين سيحصلون على جوائز المراكز النهائية."},
  [3] = {id=3,name="حرب الفضاء",desc="1. عند بداية حرب الفضاء، الاتحاد بالمركز 4 و5، يمكن الأعضاء بدأ الحرب. 2. لا يمكن استخدام أداة حماية الحرب في هذه الفعالية. 3. كلما قمت بدفاع عن الهجوم من أساطيل السفن الأجنبية لأكبر عدد مرات، كلما حصلت على النقاط الأكثر. 4. إذا فشلت في دفاع عن مدينتك مرتين، لن تتعرض للهجوم من قبل الثقب الأسود. ويمكنك مساعدة أعضاء تحالفك. 5. إذا جميع الأعضاء فشلو في دفاع عن مدنهم مرتين، انتهت الفعالية. 6. أثناء الفعالية، يمكن كل لاعب بدأ الحرب مرة فقط. 7. أساطيل السفن الأجنبية لا تأخذ الموارد منك، تضرر أساطيلك القليلة. 8. لن تحصل على أي الجائزة إذا خرجت الاتحاد أثناء وقت الفعالية."},
  [4] = {id=4,name="اكتساب قلعة المجرة",desc="1. ستبدأ فعالية حرب الملك بعد 15 يوم من فتح السرفر. بعد ذلك، سنقوم بها في 4:00 يوم السبت. فقط يمكن أعضاء الاتحادات المشاركة فيها.\n2. هذه  الفعالية تجري لـ24 ساعة. بعد ذلك سيتم ترتيب الاتحادات والنقاط.\n3. بعد بداية الفعالية، يمكن جميع الاتحادات ازدحام قلعة المجرة ومحطة المجرة للحصول على النقاط.\n4. من خلال احتلال قلعة المجرة لدقيقة واحدة، سيحصل على 100 النقاط. أما احتلال محطة المجرة لدقيقة سيحصل على 35 النقاط.\n5. بعد الفعالية، الاتحاد الذي يحصل على أكثر النقاط سيحصل حقوق تعيين ملك المجرة.\n6. الاتحادات المشاركة الأخرى يحصلون على الجوائز بناء على نقاطها. سيتم إرسال الجوائز من خلال الرسائل بعد الفعالية.\n7. بعد الفعالية، يمكن قائد الاتحاد الفائز بمركز 1 أن يعين ملك المجرة ضمن 1 ساعة. إذا لم يقم بتعيينه، سيتم تعيين نفسه كملك المجرة بعد ساعة.\n8. عندما كانت قلعة المجرة في الحرب، يمكن أي اللاعب أن يهجم عليها.\n9. عند وصلت السفن الحربية إلى قلعة المجرة، إذا اتحادك يحتلها، ستساعد سفن أعضاءك.\n10. إذا الاتحاد الآخر يحتل القلعة، سيبدأ الحرب.\n11. عدد السفن الحربية التي يمكنك إرسالها متعلقة بسعة المسيرة ومستوى مركز القيادة."},
  [5] = {id=5,name="معارك المجرة",desc="1. القائد بالمستوى 15 أو أعلى يمكنه المشاركة في معارك المجرة. 2. بعد بداية الفعالية، سيتم انتقال المشتركين من جميع المجرات إلى ساحة معارك المجرة. 3. أثناء المعارك، لا يمكنك أن تهجم على المشتركين من نفس مجرتك. فقط يمكنك الهجوم على الذين من المجرات الأخرى. 4. ستحصل على النقاط عند قتل المشتركين من المجرات الأخرى. تكون المراكز النهائية بناء على النقاط الشخصية ونقاط الإجمالية للمجرة."},
  [6] = {id=6,name="معركة التنين",desc="1. عند بداية الفعالية، يمكن الاتحاد المركز 4 و5 دخولها. 2. ستنافس الاتحاد الآخر الذي يختاره النظام بشكل عشوائي. 3. الاتحاد الفائز ستدخل الجولة التالية. 4. ستحصل على جوائز الأدوات الكثيرة من المشاركة في معركة التنين."},
  [7] = {id=7,name="التزويد اليومي",desc="1، يمكن كل القائد الحصول على التزويد 4 مرات مجانا كل يوم عندما دخل اللعبة. 2، يمكنك استخدام كتاب التحديات في محطة المعارك، التي تحصل على كثير من مواد الأسلحة والادوات منها. 3، يمكنك استخدام الطاقة في معارك مع قرصان المجرة، الذي تحصل على عوامل التكنولوجيا وأمر النقيب والخ. 4، عندما تصل الطاقة الى الحد الأقصى فلا يمكنك الحصول على مزيد منها. تحصل مرة أخرى بعد استخدام الطاقة. 5، لا تنس أن تأخذ التزويد اليومي من مركز الفعالية بعد دخل اللعبة!"},
  [8] = {id=8,name="شحن الباقة الأحمر",desc="1. الباقة الأحمر، نسميها أموال السنة الجديدة أيضا، التي تلف بالورقة الأحمر، وهي تمنيات جميلة للأصغار من الأكبار عند عيد الربيع. 2. بعد شراء الباقة الأحمر، يمكنك أن تحدد عدد الناس الذين يمكنهم أخذ الباقة، وتحدد الشات الذي يريد أرسال الباقة إليه. 3. بعد أن تأخذ الباقة، تحصل على الماس بعدد معشوائي من جميع الماس في الباقة."},
  [9] = {id=9,name="الأسئلة مع الجوائز",desc="1. أثناء الفعالية، تكون 5 الفرص لك لتجيب الأسئلة كل يوم. وبعد جواب السؤال الواحد، يجب أن تنتظر لوقت معين حتى تجيب السؤال التالي. 2. مهما كان جوابك صحيحا أو خاطئا، ستحصل على الجوائز. وإذا يكون جوابك صحيحا، تحصل على الجوائز الأحسن. 3. تحصل على النقاط عندما كان جوابك صحيحا. وتحصل على النقاط الأكثر إذا كان جوابك صحيحة لمرات مستمرة. المراكز بناء على النقاط، وسيتم إرسال  الجوائز من خلال الرسائل بناء على المراكز."},
  [10] = {id=10,name="مهمة مع الجوائز",desc="1. ستحصل على الأدوات من خلال إكمال المهمات أثناء الفعالية. 2. سيتم إرسال الجوائز لك من الرسائل مباشرة بعد إكمال المهمات. 3. تكون المهمات المختلفة كل يوم. نرجو أن تتابع بها."},
  [11] = {id=11,name="التقليب المحظوظ",desc="1. اثناء الفعالية، يمكنك التقليب 3 مرات مجانية. بعد ذلك، يمكنك دفع الماس في التقليب أكثر مرات. 2. إذا ما قنعت بالجوائز، يمكنك تحديثها بالماس. 3. بعد التقليب، فقط يمكنك اختيار الجائزة الواحدة. وكل الجائزة قيمتها أكبر من الماس الذي تدفع. 4. هناك 3 مستويات للجوائز. كلما كان المستوى الأعلى، كلما كانت جوائزها أحسن، وكلما حصلت على النقاط الأعلى. 5. بعد الفعالية، سيتم إرسال الجوائز من خلال الرسائل بناء على النقاط الإجمالية."},
  [12] = {id=12,name="الغزاة",desc="1. أثناء الفعالية، ستظهر الكثير من السفن الحربية الأجنبية في خريطة المجرة. اهجم عليها ستحصل على جوائز الأدوات. 2. تكون السفن الحربية بمستويات مختلفة. وتكون قواتها مختلفة أيضا. 3. الجوائز التي تحصل عليها ستكون بناء على قوات السفن التي تهجم عليها. إذا دمرتها، حصلت على الجوائز الإضافية. 4. يمكنك الحصول على النقاط من خلال الهجوم على السفن وتدميرها. وسيتم إرسال الجوائز بناء على النقاط بعد الفعالية."},
  [13] = {id=13,name="فعالية يوم الحظ",desc="1، في فترة فعالية يوم الحظ، لديك الفرصة لحصول على مهارات الحظ. 2، تكون مهارات الحظ أنواع مختلفة: تقليل وقت بناء المباني، تقليل الموارد لبناء المباني وتقليل وقت لدراسة التكنولوجيا. 3، يوجد الوقت المحدد لمهارات الحظ. 4، لكل لاعب فرصة محدودة لحصول على مهارات الحظ كل يوم، اذا كنت الفرصة 0، لن تحصل على المهارات."},
  [14] = {id=14,name="انتزاع الكنز",desc="1. يمكنك الحصول على الأدوات النادرة من انتزاع الكنز باستخدام الماس. وهناك 10% التخفيض في 5 مرات. \n2. يمكنك تبديل الزعيم النادر وحطام الزعيم في متجر الكنز باستخدام الكريستال الذكي. ويتم تحديث متجر الكنز أحيانا. \n3. عندما حصلت على الأدوات بعدد مرات معين، ستحصل على الجوائز الإضافية. سيتم إعادة المرات في ساعة 00:00 كل يوم الاثنين. \n4. كلما قمت بانتزاع الكنز، سيتم زيادة نقاط الحظ. وعند امتلاء نقاط الحظ، تحصل على الجوائز النادرة. \n5. عندما حصلت على الجوائز النادرة، سيتم إعادة نقاط الحظ إلى صفر. \n6. إذا امتلكت الزعيم، عندما حصلت على الزعيم من انتزاع الكنز، سيتم تحويله إلى حطام الزعيم. \n7. سيتم تحديث جوائز انتزاع الكنز في ساعة 00:00 كل يوم الاثنين."}
}
return DActivityOpen