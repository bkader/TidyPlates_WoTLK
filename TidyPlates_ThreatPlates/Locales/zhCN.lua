local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "zhCN", false)
if not L then return end

----------------------
--[[ commands.lua ]]--
----------------------

L["-->>|cffff0000DPS Plates Enabled|r<<--"] = "-->>|cffff0000伤害输出面板已启用|r<<--"
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r：伤害输出天赋改变检测，你现在启用了你的 |cff89F559"
L["|r spec and are now in your |cffff0000dpsing / healing|r role."] = "|r 天赋并且角色类型为 |cffff0000伤害输出/治疗者|r 角色。"

L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = "-->>|cff00ff00坦克面板已启用|r<<--"
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r：坦克天赋改变检测，你现在启用了你的 |cff89F559"
L["|r spec and are now in your |cff00ff00tanking|r role."] = "|r 天赋并且角色类型为 |cff00ff00坦克|r 角色。"

L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = "-->>姓名板重叠现在 |cff00ff00开启！|r<<--"
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = "-->>姓名板重叠现在 |cff00ff00关闭！|r<<--"

L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = "-->>Threat Plates聊天框反馈信息现在 |cff00ff00开启！|r<<--"
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = "-->>Threat Plates聊天框反馈信息现在 |cffff0000关闭！|r<<--嘘！！"

------------------------------
--[[ TidyPlatesThreat.lua ]]--
------------------------------

L["|cff00ff00tanking|r"] = "|cff00ff00坦克类型|r"
L["|cffff0000dpsing / healing|r"] = "|cffff0000伤害输出/治疗者类型|r"

L["primary"] = "主"
L["secondary"] = "副"
L["unknown"] = "未知"
L["Undetermined"] = "未确定"

L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = "|cff89f559欢迎使用 |rTidy Plates: |cff89f559Threat Plates!\n这是你第一次使用Threat Plates，你是一个：\n|r|cff"

L["|cff89f559Your dual spec's have been set to |r"] = "|cff89f559你的双天赋已被设置为 |r"
L["|cff89f559You are currently in your "] = "|cff89f559你现在正处于 "
L["|cff89f559 role.|r"] = "|cff89f559 角色。|r"
L["|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"] = "|cff89f559你的角色类型无法被确定。\n请在|rThreat Plates|cff89f559选项|r|cff89f559中设置你的双天赋。|r"
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = "|cff89f559可以通过输入 |r'/tptp'|cff89f559来找到剩余选项。|r"
L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."] = ":\n----------\n你希望 \n设置你的主题为 |cff89F559Threat Plates|r吗?\n\n点击 '|cff00ff00是|r' 将设置你的主题为Threat Plates并且重新载入插件。 \n 点击 '|cffff0000否|r' 将打开Tidy Plates选项。"

L["Yes"] = "是"
L["Cancel"] = "取消"
L["No"] = "否"

L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = "-->>|cffff0000从Tidy Plates选项中激活Threat Plates！|r<<--"
L["|cff89f559Threat Plates:|r Welcome back |cff"] = "|cff89f559Threat Plates:|r欢迎回来 |cff"

L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = "|cff89F559Threat Plates|r: 玩家天赋改变检测： |cff"
L[")|r, you are now in your |cff89F559"] = ")|r, 你现在启用了你的 |cff89F559"
L["|r spec and are now in your "] = "|r 天赋并且角色类型为 "
L[" role."] = " 角色。"

-- Custom Nameplates
L["Shadow Fiend"] = "暗影魔"
L["Spirit Wolf"] = "幽灵狼"
L["Ebon Gargoyle"] = "黑锋石像鬼"
L["Water Elemental"] = "水元素"
L["Treant"] = "树人"
L["Viper"] = "毒蛇"
L["Venomous Snake"] = "剧毒蛇"
L["Army of the Dead Ghoul"] = "亡者军团食尸鬼"
L["Shadowy Apparition"] = "暗影幻灵"-----Needs CWOW4.0 需要国服4.0
L["Shambling Horror"] = "蹒跚的血僵尸"
L["Web Wrap"] = "缠网"
L["Immortal Guardian"] = "不朽守护者"
L["Marked Immortal Guardian"] = "被标记的不朽守护者"
L["Empowered Adherent"] = "亢奋的追随者"
L["Deformed Fanatic"] = "畸形的狂热者"
L["Reanimated Adherent"] = "被复活的追随者"
L["Reanimated Fanatic"] = "被复活的狂热者"
L["Bone Spike"] = "骨针"
L["Onyxian Whelp"] = "奥妮克希亚雏龙"
L["Gas Cloud"] = "毒气之云"
L["Volatile Ooze"] = "不稳定的软泥怪"
L["Darnavan"] = "达尔纳文"
L["Val'kyr Shadowguard"] = "瓦格里暗影戒卫者"
L["Kinetic Bomb"] = "动力炸弹"
L["Lich King"] = "巫妖王"
L["Raging Spirit"] = "暴怒的灵魂"
L["Drudge Ghoul"] = "食尸鬼苦工"
L["Living Inferno"] = "燃烧的炼狱火"-----Needs CWOW RS 需要国服开RS
L["Living Ember"] = "燃烧的余烬"-----Needs CWOW RS 需要国服开RS
L["Fanged Pit Viper"] = "毒牙坑道蛇"
L["Canal Crab"] = "运河蟹"-----Needs CWOW RS 需要国服开RS
L["Muddy Crawfish"] = "沾泥龙虾"-----Needs CWOW RS 需要国服开RS

---------------------
--[[ options.lua ]]--
---------------------

L["None"] = "无"
L["Outline"] = "轮廓"
L["Thick Outline"] = "粗轮廓"
L["No Outline, Monochrome"] = "无轮廓，单色"
L["Outline, Monochrome"] = "轮廓，单色"
L["Thick Outline, Monochrome"] = "粗轮廓，单色"

L["White List"] = "白名单"
L["Black List"] = "黑名单"
L["White List (Mine)"] = "白名单（我的）"
L["Black List (Mine)"] = "黑名单（我的）"
L["All Debuffs"] = "所有减益状态(Debuffs)"
L["All Debuffs (Mine)"] = "所有减益状态(Debuffs)（我的）"

-- Tab Titles
L["Nameplate Settings"] = "姓名板选项"
L["Threat System"] = "仇恨系统"
L["Widgets"] = "组件"
L["Totem Nameplates"] = "图腾姓名板"
L["Custom Nameplates"] = "自定义姓名板"
L["About"] = "关于"

------------------------
-- Nameplate Settings --
------------------------
L["General Settings"] = "一般设置"
L["Hiding"] = "隐藏"
L["Show Neutral"] = "显示中立单位"
L["Show Normal"] = "显示普通单位"
L["Show Elite"] = "显示精英单位"
L["Show Boss"] = "显示首领单位"

L["Blizzard Settings"] = "Blizzard设置"
L["Open Blizzard Settings"] = "开启Blizzard设置"

L["Friendly"] = "友方单位"
L["Show Friends"] = "显示友方单位"
L["Show Friendly Totems"] = "显示友方图腾"
L["Show Friendly Pets"] = "显示友方宠物"
L["Show Friendly Guardians"] = "显示友方守卫"

L["Enemy"] = "敌方"
L["Show Enemies"] = "显示敌方单位"
L["Show Enemy Totems"] = "显示敌方图腾"
L["Show Enemy Pets"] = "显示敌方宠物"
L["Show Enemy Guardians"] = "显示敌方守卫"

----
L["Healthbar"] = "血量条"
L["Textures"] = "材质"
L["Show Border"] = "显示边框"
L["Normal Border"] = "普通单位边框"
L["Show Elite Border"] = "显示精英单位边框"
L["Elite Border"] = "精英单位边框"
L["Mouseover"] = "鼠标指向"
----
L["Placement"] = "位置"
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = "改变这些选项将改变姓名板的位置，然而鼠标指向区域却不会随之改变。|cffff0000请谨慎使用！|r"
L["Offset X"] = "X轴偏移"
L["Offset Y"] = "Y轴偏移"
L["X"] = "X轴"
L["Y"] = "Y轴"
L["Anchor"] = "锚点"
----
L["Coloring"] = "配色"
L["Enable Coloring"] = "启用配色"
L["Color HP by amount"] = "随血量值变色"
L["Changes the HP color depending on the amount of HP the nameplate shows."] = "随着姓名板显示的血量数值改变血量颜色。"
----
L["Class Coloring"] = "职业配色"
L["Enemy Class Colors"] = "敌方单位职业颜色"
L["Enable Enemy Class colors"] = "启用敌方单位职业颜色"
L["Friendly Class Colors"] = "友方单位职业颜色"
L["Enable Friendly Class Colors"] = "启用友方单位职业颜色"
L["Enable the showing of friendly player class color on hp bars."] = "启用血量条上友方玩家职业颜色的显示"
L["Friendly Caching"] = "友方单位缓存"
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = "这个选项允许你在游戏会话或者离开屏幕的姓名板中保存友方玩家职业信息。|cffff0000（更多的内存使用）"
----
L["Custom HP Color"] = "自定义血量颜色"
L["Enable Custom HP colors"] = "启用自定义血量颜色"
L["Friendly Color"] = "友方单位颜色"
L["Neutral Color"] = "中立单位颜色"
L["Enemy Color"] = "敌方单位颜色"
----
L["Raid Mark HP Color"] = "团队标记血量颜色"
L["Enable Raid Marked HP colors"] = "启用团队标记血量颜色"
L["Colors"] = "颜色"
----
L["Threat Colors"] = "仇恨颜色"
L["Show Threat Glow"] = "显示仇恨色彩"
L["|cff00ff00Low threat|r"] = "|cff00ff00低仇恨|r"
L["|cffffff00Medium threat|r"] = "|cffffff00中等仇恨|r"
L["|cffff0000High threat|r"] = "|cffff0000高仇恨|r"
L["|cffff0000Low threat|r"] = "|cffff0000低仇恨|r"
L["|cff00ff00High threat|r"] = "|cff00ff00高仇恨|r"
L["Low Threat"] = "低仇恨"
L["Medium Threat"] = "中等仇恨"
L["High Threat"] = "高仇恨"

----
L["Castbar"] = "施法条"
L["Enable"] = "启用"
L["Non-Target Castbars"] = "非当前目标施法条"
L["This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."] = "这个选项允许施法条功能尝试在你最近鼠标指向过的玩家或者生物姓名板上创建一个施法条。"
L["Interruptable Casts"] = "可打断的施法"
L["Shielded Coloring"] = "护盾配色"
L["Uninterruptable Casts"] = "不可打断的施法"

----
L["Alpha"] = "透明度"
L["Blizzard Target Fading"] = "Blizzard非目标淡出"
L["Enable Blizzard 'On-Target' Fading"] = "启用Blizzard非当前目标淡出"
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = "启用这个功能将允许你对非目标的姓名板进行透明度调节。"
L["Non-Target Alpha"] = "非目标透明度"
L["Alpha Settings"] = "透明度设置"

----
L["Scale"] = "缩放"
L["Scale Settings"] = "缩放设置"

----
L["Name Text"] = "姓名文字"
L["Enable Name Text"] = "启用姓名文字"
L["Enables the showing of text on nameplates."] = "在姓名板上启用文字显示。"
L["Options"] = "选项"
L["Font"] = "字体"
L["Font Style"] = "字体样式"
L["Set the outlining style of the text."] = "设置姓名文字的轮廓样式。"
L["Enable Shadow"] = "启用阴影"
L["Color"] = "颜色"
L["Text Bounds and Sizing"] = "文字边界与大小"
L["Font Size"] = "字体大小"
L["Text Boundaries"] = "文字边界"
L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."] = "这些设置将定义文字放置在姓名板上的空间。\n过大的字体与高度不足将导致导致文字不可见。"
L["Text Width"] = "文字宽度"
L["Text Height"] = "文字高度"
L["Horizontal Align"] = "水平定位"
L["Vertical Align"] = "垂直定位"

----
L["Health Text"] = "生命值文字"
L["Enable Health Text"] = "启用生命值文字"
L["Display Settings"] = "显示设置"
L["Text at Full HP"] = "满血血量文字"
L["Display health text on targets with full HP."] = "当目标满血时显示血量文字。"
L["Percent Text"] = "百分比文字"
L["Display health percentage text."] = "显示血量百分比文字。"
L["Amount Text"] = "数值文字"
L["Display health amount text."] = "显示血量值文字。"
L["Amount Text Formatting"] = "数值文字格式"
L["Truncate Text"] = "简化文字"
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = "这个设置将使用M与K来表示百万或一千以简化文字格式。禁用此选项将显示准确的血量值。"
L["Max HP Text"] = "最大血量文字"
L["This will format text to show both the maximum hp and current hp."] = "这个选项将设置文字格式以同时显示最大血量与当前血量。"
L["Deficit Text"] = "损失血量文字"
L["This will format text to show hp as a value the target is missing."] = "这个选项将设置文字格式来显示目标损失的血量值。"

----
L["Spell Text"] = "法术文字"
L["Enable Spell Text"] = "启用法术文字"

----
L["Level Text"] = "等级文字"
L["Enable Level Text"] = "启用等级文字"

----
L["Elite Icon"] = "精英图标"
L["Enable Elite Icon"] = "启用精英图标"
L["Enables the showing of the elite icon on nameplates."] = "启用姓名板上精英图标的显示。"
L["Texture"] = "材质"
L["Preview"] = "预览"
L["Elite Icon Style"] = "精英图标样式"
L["Size"] = "大小"

----
L["Skull Icon"] = "骷髅等级图标"
L["Enable Skull Icon"] = "启用骷髅等级图标"
L["Enables the showing of the skull icon on nameplates."] = "启用姓名板上骷髅等级图标的显示。"

----
L["Spell Icon"] = "法术图标"
L["Enable Spell Icon"] = "启用法术图标"
L["Enables the showing of the spell icon on nameplates."] = "启用姓名板上法术图标的显示。"

----
L["Raid Marks"] = "团队标记"
L["Enable Raid Mark Icon"] = "启用团队标记"
L["Enables the showing of the raid mark icon on nameplates."] = "启用姓名板上团队标记图标的显示。"

-------------------
-- Threat System --
-------------------

L["Enable Threat System"] = "启用仇恨系统"

----
L["Additional Toggles"] = "额外切换"
L["Ignore Non-Combat Threat"] = "忽略非战斗目标仇恨"
L["Disables threat feedback from mobs you're currently not in combat with."] = "禁用当前不在与你战斗的怪物的仇恨反馈。"
L["Show Neutral Threat"] = "显示中立单位仇恨"
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = "禁用中立怪物的仇恨反馈，除了首领与精英级别的单位。"
L["Show Normal Threat"] = "显示普通单位仇恨"
L["Disables threat feedback from normal mobs."] = "禁用普通怪物的仇恨反馈。"
L["Show Elite Threat"] = "显示精英单位仇恨"
L["Disables threat feedback from elite mobs."] = "禁用精英怪物的仇恨反馈。"
L["Show Boss Threat"] = "显示首领单位仇恨"
L["Disables threat feedback from boss level mobs."] = "禁用首领级别怪物的仇恨反馈。"

----
L["Set alpha settings for different threat reaction types."] = "对不同的仇恨反应类型设置透明度。"
L["Enable Alpha Threat"] = "启用仇恨透明度"
L["Enable nameplates to change alpha depending on the levels you set below."] = "依据你在下面所设置的仇恨等级，启用姓名板透明度改变。"
L["|cff00ff00Tank|r"] = "|cff00ff00坦克|r"
L["|cffff0000DPS/Healing|r"] = "|cffff0000伤害输出/治疗者|r"
----
L["Marked Targets"] = "被标记的目标"
L["Ignore Marked Targets"] = "忽略被标记的目标"
L["This will allow you to disabled threat alpha changes on marked targets."] = "这将允许你在被标记的目标上禁用仇恨透明度改变。"
L["Ignored Alpha"] = "被忽略单位的透明度"

----
L["Set scale settings for different threat reaction types."] = "对不同的仇恨反应类型设置缩放。"
L["Enable Scale Threat"] = "启用仇恨缩放"
L["Enable nameplates to change scale depending on the levels you set below."] = "依据你在下面所设置的仇恨等级，启用姓名板缩放改变。"
L["This will allow you to disabled threat scale changes on marked targets."] = "这将允许你在被标记的目标上禁用仇恨缩放改变。"
L["Ignored Scaling"] = "被忽略单位的缩放"
----
L["Additional Adjustments"] = "额外调节"
L["Enable Adjustments"] = "启用调节"
L["This will allow you to add additional scaling changes to specific mob types."] = "这将允许你对特殊的怪物类型增加额外的缩放改变。"

----
L["Toggles"] = "切换"
L["Color HP by Threat"] = "仇恨血量颜色"
L["This allows HP color to be the same as the threat colors you set below."] = "这将允许血量颜色与你在下面所设置的仇恨颜色相同。"

----
L["Dual Spec Roles"] = "双天赋角色"
L["Set the role your primary and secondary spec represent."] = "设置你的主天赋与副天赋所代表的角色。"
L["Primary Spec"] = "主天赋"
L["Sets your primary spec to tanking."] = "设置你的主天赋为坦克类型。"
L["Sets your primary spec to DPS."] = "设置你的主天赋为伤害输出类型。"
L["Secondary Spec"] = "副天赋"
L["Sets your secondary spec to tanking."] = "设置你的副天赋为坦克类型。"
L["Sets your secondary spec to DPS."] = "设置你的副天赋为伤害输出类型。"

----
L["Set threat textures and their coloring options here."] = "在这里设置仇恨材质与它们的配色选项。"
L["These options are for the textures shown on nameplates at various threat levels."] = "这些选项用来对不同的仇恨等级设置材质。"
----
L["Art Options"] = "艺术选项"
L["Style"] = "样式"
L["This will allow you to disabled threat art on marked targets."] = "这将允许你在被标记的目标上禁用仇恨艺术材质。"

-------------
-- Widgets --
-------------

L["Class Icons"] = "职业图标"
L["This widget will display class icons on nameplate with the settings you set below."] = "这个组件将依据你在下面的设置在姓名板上显示职业图标。"
L["Enable Friendly Icons"] = "启用友方单位图标"
L["Enable the showing of friendly player class icons."] = "启用友方玩家职业图标的显示。"

----
L["Combo Points"] = "连击点"
L["This widget will display combo points on your target nameplate."] = "这个组件将在你的姓名板上显示连击点。"

----
L["Debuffs"] = "减益状态(Debuffs)"
L["This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."] = "这个组件将在你的目标姓名板与你最近鼠标指向过的其他单位姓名板上显示符合你过滤条件的减益状态(Debuffs)。"
L["Sizing"] = "大小"
L["Filtering"] = "过滤"
L["Mode"] = "模式"
L["Filtered Debuffs"] = "滤过的减益状态(Debuffs)"

----
L["Social Widget"] = "社交组件"
L["Enables the showing if indicator icons for friends, guildmates, and BNET Friends"] = "启用对于好友，公会成员与战网好友的指示器图标的显示。"

----
L["Threat Line"] = "仇恨线"
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = "这个组件将在你目标姓名板或者最近鼠标指向过的姓名板上显示一个小条，这个小条将显示相对于其他玩家你的当前仇恨。"

----
L["Tanked Targets"] = "坦克组件"
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked.|cffff00ffRequires tanking role.|r"] = "这个组件将显示一个用来指示单位当前是否被坦住的盾或匕首。|cffff00ff需要坦克角色。|r"

----
L["Target Highlight"] = "目标高亮"
L["Enables the showing of a texture on your target nameplate"] = "启用在你当前目标姓名板上一种材质的显示"

----------------------
-- Totem Nameplates --
----------------------

L["|cffffffffTotem Settings|r"] = "|cffffffff图腾设置|r"
L["Toggling"] = "切换"
L["Hide Healthbars"] = "隐藏生命条"
----
L["Icon"] = "图标"
L["Icon Size"] = "图标大小"
L["Totem Alpha"] = "图腾透明度"
L["Totem Scale"] = "图腾缩放"
----
L["Show Nameplate"] = "显示姓名板"
----
L["Health Coloring"] = "生命值配色"
L["Enable Custom Colors"] = "启用自定义颜色"

-----------------------
-- Custom Nameplates --
-----------------------

L["|cffffffffGeneral Settings|r"] = "|cffffffff一般设置|r"
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = "禁用此选项将关闭所有图标，而不会对每个姓名板的自定义设置造成破坏。"
----
L["Set Name"] = "设置名字"
L["Use Target's Name"] = "使用目标名字"
L["No target found."] = "未发现目标。"
L["Clear"] = "清除"
L["Copy"] = "复制"
L["Copied!"] = "已复制！"
L["Paste"] = "粘贴"
L["Pasted!"] = "已粘贴！"
L["Nothing to paste!"] = "无可粘贴内容！"
L["Restore Defaults"] = "还原默认值"
----
L["Use Custom Settings"] = "使用自定义设置"
L["Custom Settings"] = "自定义设置"
----
L["Disable Custom Alpha"] = "禁用自定义透明度"
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = "对此姓名板禁用自定义透明度设置，使用正常透明度设置代替"
L["Custom Alpha"] = "自定义透明度"
----
L["Disable Custom Scale"] = "禁用自定义缩放"
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = "对此姓名板禁用自定义缩放设置，使用正常缩放设置代替"
L["Custom Scale"] = "自定义缩放"
----
L["Allow Marked HP Coloring"] = "允许被标记目标的血量配色"
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] = "如果姓名板有一个团队标记，那麽允许团队标记血量颜色设置代替自定义血量设置"

----
L["Enable the showing of the custom nameplate icon for this nameplate."] = "对此姓名板启用自定义姓名板图标的显示。"
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = "直接输入图标材质的路径，使用'\\'来分开目录文件夹，或使用法术ID。"
L["Set Icon"] = "设置图标"

-----------
-- About --
-----------

L["\n\nThank you for supporting my work!\n"] = "\n\n感谢对我工作的支持！\n"
L["Click to Donate!"] = "点击以捐赠！"
L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00Shamtasticle@gmail.com|r\n\n--Suicidal Katt"] = "TidyPlates的清晰且易于使用的姓名板主题。\n\n请随时通过电子邮件联繫我 |cff00ff00Shamtasticle@gmail.com|r\n\n--Suicidal Katt"

--------------------------------
-- Default Game Options Frame --
--------------------------------

L["You can access the "] = "你可以进入"
L[" options by typing: /tptp"] = "选项通过输入：/tptp"
L["Open Config"] = "打开设置"

------------------------
-- Additional Stances --
------------------------
L["Presences"] = "灵气"
L["Shapeshifts"] = "形态"
L["Auras"] = "光环"
L["Stances"] = "姿态"