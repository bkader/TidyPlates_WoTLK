local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "zhTW", false)
if not L then return end

----------------------
--[[ commands.lua ]]--
----------------------

L["-->>|cffff0000DPS Plates Enabled|r<<--"] = "-->>|cffff0000傷害輸出面板已啟用|r<<--"
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r：傷害輸出天賦改變檢測，你現在啟用了你的 |cff89F559"
L["|r spec and are now in your |cffff0000dpsing / healing|r role."] = "|r 天賦並且角色類型為 |cffff0000傷害輸出/治療者|r 角色。"

L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = "-->>|cff00ff00坦克面板已啟用|r<<--"
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r：坦克天賦改變檢測，你現在啟用了你的 |cff89F559"
L["|r spec and are now in your |cff00ff00tanking|r role."] = "|r 天賦並且角色類型為 |cff00ff00坦克|r 角色。"

L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = "-->>姓名板重疊現在 |cff00ff00開啟！|r<<--"
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = "-->>姓名板重疊現在 |cff00ff00關閉！|r<<--"

L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = "-->>Threat Plates聊天框反饋信息現在 |cff00ff00開啟！|r<<--"
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = "-->>Threat Plates聊天框反饋信息現在 |cffff0000關閉！|r<<--噓！！"

------------------------------
--[[ TidyPlatesThreat.lua ]]--
------------------------------

L["|cff00ff00tanking|r"] = "|cff00ff00坦克類型|r"
L["|cffff0000dpsing / healing|r"] = "|cffff0000傷害輸出/治療者類型|r"

L["primary"] = "主要"
L["secondary"] = "第二"
L["unknown"] = "未知"
L["Undetermined"] = "未確定"

L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = "|cff89f559歡迎使用 |rTidy Plates: |cff89f559Threat Plates!\n這是你第一次使用Threat Plates，你是一個：\n|r|cff"

L["|cff89f559Your dual spec's have been set to |r"] = "|cff89f559你的雙天賦已被設置為 |r"
L["|cff89f559You are currently in your "] = "|cff89f559你現在正處於 "
L["|cff89f559 role.|r"] = "|cff89f559 角色。|r"
L["|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"] = "|cff89f559你的角色類型無法被確定。\n請在|rThreat Plates|cff89f559選項|r|cff89f559中設置你的雙天賦。|r"
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = "|cff89f559可以通過輸入 |r'/tptp'|cff89f559來找到剩餘選項。|r"
L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."] = ":\n----------\n你希望 \n設置你的主題為 |cff89F559Threat Plates|r嗎?\n\n點擊 '|cff00ff00是|r' 將設置你的主題為Threat Plates並且重新載入插件。 \n 點擊 '|cffff0000否|r' 將打開Tidy Plates選項。"

L["Yes"] = "是"
L["Cancel"] = "取消"
L["No"] = "否"

L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = "-->>|cffff0000從Tidy Plates選項中激活Threat Plates！|r<<--"
L["|cff89f559Threat Plates:|r Welcome back |cff"] = "|cff89f559Threat Plates:|r歡迎回來 |cff"

L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = "|cff89F559Threat Plates|r: 玩家天賦改變檢測： |cff"
L[")|r, you are now in your |cff89F559"] = ")|r, 你現在啟用了你的 |cff89F559"
L["|r spec and are now in your "] = "|r 天賦並且角色類型為 "
L[" role."] = " 角色。"

-- Custom Nameplates
L["Shadow Fiend"] = "暗影惡魔"
L["Spirit Wolf"] = "幽靈狼"
L["Ebon Gargoyle"] = "黯黑石像鬼"
L["Water Elemental"] = "水元素"
L["Treant"] = "樹人"
L["Viper"] = "響尾蛇"
L["Venomous Snake"] = "毒蛇"
L["Army of the Dead Ghoul"] = "食屍鬼大軍"
L["Shadowy Apparition"] = "暗影幻靈"
L["Shambling Horror"] = "蹣跚的恐獸"
L["Web Wrap"] = "纏繞之網"
L["Immortal Guardian"] = "不朽守護者"
L["Marked Immortal Guardian"] = "標記的不朽守護者"
L["Empowered Adherent"] = "強化的擁護者"
L["Deformed Fanatic"] = "畸形的狂熱者"
L["Reanimated Adherent"] = "再活化的擁護者"
L["Reanimated Fanatic"] = "再活化的狂熱者"
L["Bone Spike"] = "骸骨尖刺"
L["Onyxian Whelp"] = "奧妮克希亞幼龍"
L["Gas Cloud"] = "毒氣雲"
L["Volatile Ooze"] = "暴躁軟泥怪"
L["Darnavan"] = "達納凡"
L["Val'kyr Shadowguard"] = "華爾琪影衛"
L["Kinetic Bomb"] = "動能炸彈"
L["Lich King"] = "巫妖王"
L["Raging Spirit"] = "狂怒的鬼魂"
L["Drudge Ghoul"] = "苦工食屍鬼"
L["Living Inferno"] = "燃燒的煉獄火"
L["Living Ember"] = "燃燒的餘燼"
L["Fanged Pit Viper"] = "尖牙深淵毒蛇"
L["Canal Crab"] = "運河蟹"
L["Muddy Crawfish"] = "泥濘螯蝦"

---------------------
--[[ options.lua ]]--
---------------------

L["None"] = "無"
L["Outline"] = "輪廓"
L["Thick Outline"] = "粗輪廓"
L["No Outline, Monochrome"] = "無輪廓，單色"
L["Outline, Monochrome"] = "輪廓，單色"
L["Thick Outline, Monochrome"] = "粗輪廓，單色"

L["White List"] = "白名單"
L["Black List"] = "黑名單"
L["White List (Mine)"] = "白名單（我的）"
L["Black List (Mine)"] = "黑名單（我的）"
L["All Debuffs"] = "所有減益狀態(Debuffs)"
L["All Debuffs (Mine)"] = "所有減益狀態(Debuffs)（我的）"

-- Tab Titles
L["Nameplate Settings"] = "姓名板選項"
L["Threat System"] = "仇恨系統"
L["Widgets"] = "組件"
L["Totem Nameplates"] = "圖騰姓名板"
L["Custom Nameplates"] = "自定義姓名板"
L["About"] = "關於"

------------------------
-- Nameplate Settings --
------------------------
L["General Settings"] = "一般設置"
L["Hiding"] = "隱藏"
L["Show Neutral"] = "顯示中立單位"
L["Show Normal"] = "顯示普通單位"
L["Show Elite"] = "顯示精英單位"
L["Show Boss"] = "顯示首領單位"

L["Blizzard Settings"] = "Blizzard設置"
L["Open Blizzard Settings"] = "開啟Blizzard設置"

L["Friendly"] = "友方單位"
L["Show Friends"] = "顯示友方單位"
L["Show Friendly Totems"] = "顯示友方圖騰"
L["Show Friendly Pets"] = "顯示友方寵物"
L["Show Friendly Guardians"] = "顯示友方守衛"

L["Enemy"] = "敵方"
L["Show Enemies"] = "顯示敵方單位"
L["Show Enemy Totems"] = "顯示敵方圖騰"
L["Show Enemy Pets"] = "顯示敵方寵物"
L["Show Enemy Guardians"] = "顯示敵方守衛"

----
L["Healthbar"] = "血量條"
L["Textures"] = "材質"
L["Show Border"] = "顯示邊框"
L["Normal Border"] = "普通單位邊框"
L["Show Elite Border"] = "顯示精英單位邊框"
L["Elite Border"] = "精英單位邊框"
L["Mouseover"] = "鼠標指向"
L["Width"] = "寬度"
L["Height"] = "高度"
----
L["Placement"] = "位置"
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = "改變這些選項將改變姓名板的位置，然而鼠標指向區域卻不會隨之改變。|cffff0000請謹慎使用！|r"
L["Offset X"] = "X軸偏移"
L["Offset Y"] = "Y軸偏移"
L["X"] = "X軸"
L["Y"] = "Y軸"
L["Anchor"] = "錨點"
----
L["Coloring"] = "配色"
L["Enable Coloring"] = "啟用配色"
L["Color HP by amount"] = "隨血量值變色"
L["Changes the HP color depending on the amount of HP the nameplate shows."] = "隨著姓名板顯示的血量數值改變血量顏色。"
----
L["Class Coloring"] = "職業配色"
L["Enemy Class Colors"] = "敵方單位職業顏色"
L["Enable Enemy Class colors"] = "啟用敵方單位職業顏色"
L["Friendly Class Colors"] = "友方單位職業顏色"
L["Enable Friendly Class Colors"] = "啟用友方單位職業顏色"
L["Enable the showing of friendly player class color on hp bars."] = "啟用血量條上友方玩家職業顏色的顯示"
L["Friendly Caching"] = "友方單位緩存"
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = "這個選項允許你在遊戲會話或者離開屏幕的姓名板中保存友方玩家職業信息。|cffff0000（更多的內存使用）"
L["Name Only"] = "Name Only"
L["Show only names above friendly units."] = "Show only names above friendly units."
----
L["Custom HP Color"] = "自定義血量顏色"
L["Enable Custom HP colors"] = "啟用自定義血量顏色"
L["Friendly Color"] = "友方單位顏色"
L["Neutral Color"] = "中立單位顏色"
L["Enemy Color"] = "敵方單位顏色"
----
L["Raid Mark HP Color"] = "團隊標記血量顏色"
L["Enable Raid Marked HP colors"] = "啟用團隊標記血量顏色"
L["Colors"] = "顏色"
----
L["Threat Colors"] = "仇恨顏色"
L["Show Threat Glow"] = "顯示仇恨色彩"
L["|cff00ff00Low threat|r"] = "|cff00ff00低仇恨|r"
L["|cffffff00Medium threat|r"] = "|cffffff00中等仇恨|r"
L["|cffff0000High threat|r"] = "|cffff0000高仇恨|r"
L["|cffff0000Low threat|r"] = "|cffff0000低仇恨|r"
L["|cff00ff00High threat|r"] = "|cff00ff00高仇恨|r"
L["Low Threat"] = "低仇恨"
L["Medium Threat"] = "中等仇恨"
L["High Threat"] = "高仇恨"

----
L["Castbar"] = "施法條"
L["Enable"] = "啟用"
L["Non-Target Castbars"] = "非當前目標施法條"
L["This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."] = "這個選項允許施法條功能嘗試在你最近鼠標指向過的玩家或者生物姓名板上創建一個施法條。"
L["Interruptable Casts"] = "可打斷的施法"
L["Shielded Coloring"] = "護盾配色"
L["Uninterruptable Casts"] = "不可打斷的施法"

----
L["Alpha"] = "透明度"
L["Blizzard Target Fading"] = "Blizzard非目標淡出"
L["Enable Blizzard 'On-Target' Fading"] = "啟用Blizzard非當前目標淡出"
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = "啟用這個功能將允許你對非目標的姓名板進行透明度調節。"
L["Non-Target Alpha"] = "非目標透明度"
L["Alpha Settings"] = "透明度設置"

----
L["Scale"] = "縮放"
L["Scale Settings"] = "縮放設置"

----
L["Name Text"] = "姓名文字"
L["Enable Name Text"] = "啟用姓名文字"
L["Enables the showing of text on nameplates."] = "在姓名板上啟用文字顯示。"
L["Options"] = "選項"
L["Font"] = "字體"
L["Font Style"] = "字體樣式"
L["Set the outlining style of the text."] = "設置姓名文字的輪廓樣式。"
L["Enable Shadow"] = "啟用陰影"
L["Color"] = "顏色"
L["Text Bounds and Sizing"] = "文字邊界與大小"
L["Font Size"] = "字體大小"
L["Text Boundaries"] = "文字邊界"
L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."] = "這些設置將定義文字放置在姓名板上的空間。\n過大的字體與高度不足將導致導致文字不可見。"
L["Text Width"] = "文字寬度"
L["Text Height"] = "文字高度"
L["Horizontal Align"] = "水平定位"
L["Vertical Align"] = "垂直定位"

----
L["Health Text"] = "生命值文字"
L["Enable Health Text"] = "啟用生命值文字"
L["Display Settings"] = "顯示設置"
L["Text at Full HP"] = "滿血血量文字"
L["Display health text on targets with full HP."] = "當目標滿血時顯示血量文字。"
L["Percent Text"] = "百分比文字"
L["Display health percentage text."] = "顯示血量百分比文字。"
L["Amount Text"] = "數值文字"
L["Display health amount text."] = "顯示血量值文字。"
L["Amount Text Formatting"] = "數值文字格式"
L["Truncate Text"] = "簡化文字"
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = "這個設置將使用M與K來表示百萬或一千以簡化文字格式。禁用此選項將顯示準確的血量值。"
L["Max HP Text"] = "最大血量文字"
L["This will format text to show both the maximum hp and current hp."] = "這個選項將設置文字格式以同時顯示最大血量與當前血量。"
L["Deficit Text"] = "損失血量文字"
L["This will format text to show hp as a value the target is missing."] = "這個選項將設置文字格式來顯示目標損失的血量值。"

----
L["Spell Text"] = "法術文字"
L["Enable Spell Text"] = "啟用法術文字"

----
L["Level Text"] = "等級文字"
L["Enable Level Text"] = "啟用等級文字"

----
L["Elite Icon"] = "精英圖標"
L["Enable Elite Icon"] = "啟用精英圖標"
L["Enables the showing of the elite icon on nameplates."] = "啟用姓名板上精英圖標的顯示。"
L["Texture"] = "材質"
L["Preview"] = "預覽"
L["Elite Icon Style"] = "精英圖標樣式"
L["Size"] = "大小"

----
L["Skull Icon"] = "骷髏等級圖標"
L["Enable Skull Icon"] = "啟用骷髏等級圖標"
L["Enables the showing of the skull icon on nameplates."] = "啟用姓名板上骷髏等級圖標的顯示。"

----
L["Spell Icon"] = "法術圖標"
L["Enable Spell Icon"] = "啟用法術圖標"
L["Enables the showing of the spell icon on nameplates."] = "啟用姓名板上法術圖標的顯示。"

----
L["Raid Marks"] = "團隊標記"
L["Enable Raid Mark Icon"] = "啟用團隊標記"
L["Enables the showing of the raid mark icon on nameplates."] = "啟用姓名板上團隊標記圖標的顯示。"

-------------------
-- Threat System --
-------------------

L["Enable Threat System"] = "啟用仇恨系統"

----
L["Additional Toggles"] = "額外切換"
L["Ignore Non-Combat Threat"] = "忽略非戰鬥目標仇恨"
L["Disables threat feedback from mobs you're currently not in combat with."] = "禁用當前不在與你戰鬥的怪物的仇恨反饋。"
L["Show Neutral Threat"] = "顯示中立單位仇恨"
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = "禁用中立怪物的仇恨反饋，除了首領與精英級別的單位。"
L["Show Normal Threat"] = "顯示普通單位仇恨"
L["Disables threat feedback from normal mobs."] = "禁用普通怪物的仇恨反饋。"
L["Show Elite Threat"] = "顯示精英單位仇恨"
L["Disables threat feedback from elite mobs."] = "禁用精英怪物的仇恨反饋。"
L["Show Boss Threat"] = "顯示首領單位仇恨"
L["Disables threat feedback from boss level mobs."] = "禁用首領級別怪物的仇恨反饋。"

----
L["Set alpha settings for different threat reaction types."] = "對不同的仇恨反應類型設置透明度。"
L["Enable Alpha Threat"] = "啟用仇恨透明度"
L["Enable nameplates to change alpha depending on the levels you set below."] = "依據你在下面所設置的仇恨等級，啟用姓名板透明度改變。"
L["|cff00ff00Tank|r"] = "|cff00ff00坦克|r"
L["|cffff0000DPS/Healing|r"] = "|cffff0000傷害輸出/治療者|r"
----
L["Marked Targets"] = "被標記的目標"
L["Ignore Marked Targets"] = "忽略被標記的目標"
L["This will allow you to disabled threat alpha changes on marked targets."] = "這將允許你在被標記的目標上禁用仇恨透明度改變。"
L["Ignored Alpha"] = "被忽略單位的透明度"

----
L["Set scale settings for different threat reaction types."] = "對不同的仇恨反應類型設置縮放。"
L["Enable Scale Threat"] = "啟用仇恨縮放"
L["Enable nameplates to change scale depending on the levels you set below."] = "依據你在下面所設置的仇恨等級，啟用姓名板縮放改變。"
L["This will allow you to disabled threat scale changes on marked targets."] = "這將允許你在被標記的目標上禁用仇恨縮放改變。"
L["Ignored Scaling"] = "被忽略單位的縮放"
----
L["Additional Adjustments"] = "額外調節"
L["Enable Adjustments"] = "啟用調節"
L["This will allow you to add additional scaling changes to specific mob types."] = "這將允許你對特殊的怪物類型增加額外的縮放改變。"

----
L["Toggles"] = "切換"
L["Color HP by Threat"] = "仇恨血量顏色"
L["This allows HP color to be the same as the threat colors you set below."] = "這將允許血量顏色與你在下面所設置的仇恨顏色相同。"

----
L["Dual Spec Roles"] = "雙天賦角色"
L["Set the role your primary and secondary spec represent."] = "設置你的主要天賦與第二天賦所代表的角色。"
L["Primary Spec"] = "主要天賦"
L["Sets your primary spec to tanking."] = "設置你的主要天賦為坦克類型。"
L["Sets your primary spec to DPS."] = "設置你的主要天賦為傷害輸出類型。"
L["Secondary Spec"] = "第二天賦"
L["Sets your secondary spec to tanking."] = "設置你的第二天賦為坦克類型。"
L["Sets your secondary spec to DPS."] = "設置你的第二天賦為傷害輸出類型。"

----
L["Set threat textures and their coloring options here."] = "在這裡設置仇恨材質與它們的配色選項。"
L["These options are for the textures shown on nameplates at various threat levels."] = "這些選項用來對不同的仇恨等級設置材質。"
----
L["Art Options"] = "藝術選項"
L["Style"] = "樣式"
L["This will allow you to disabled threat art on marked targets."] = "這將允許你在被標記的目標上禁用仇恨藝術材質。"

-------------
-- Widgets --
-------------

L["Class Icons"] = "職業圖標"
L["This widget will display class icons on nameplate with the settings you set below."] = "這個組件將依據你在下面的設置在姓名板上顯示職業圖標。"
L["Enable Friendly Icons"] = "啟用友方單位圖標"
L["Enable the showing of friendly player class icons."] = "啟用友方玩家職業圖標的顯示。"

----
L["Combo Points"] = "連擊點"
L["This widget will display combo points on your target nameplate."] = "這個組件將在你的姓名板上顯示連擊點。"

----
L["Debuffs"] = "減益狀態(Debuffs)"
L["This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."] = "這個組件將在你的目標姓名板與你最近鼠標指向過的其他單位姓名板上顯示符合你過濾條件的減益狀態(Debuffs)。"
L["Sizing"] = "大小"
L["Filtering"] = "過濾"
L["Mode"] = "模式"
L["Filtered Debuffs"] = "濾過的減益狀態(Debuffs)"

----
L["Social Widget"] = "社交組件"
L["Enables the showing if indicator icons for friends, guildmates, and BNET Friends"] = "啟用對於好友，公會成員與戰網好友的指示器圖標的顯示。"

----
L["Threat Line"] = "仇恨線"
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = "這個組件將在你目標姓名板或者最近鼠標指向過的姓名板上顯示一個小條，這個小條將顯示相對於其他玩家你的當前仇恨。"

----
L["Tanked Targets"] = "坦克組件"
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked. |cffff00ffRequires tanking role.|r"] = "這個組件將顯示一個用來指示單位當前是否被坦住的盾或匕首。|cffff00ff需要坦克角色。|r"

----
L["Target Highlight"] = "目標高亮"
L["Enables the showing of a texture on your target nameplate"] = "啟用在你當前目標姓名板上一種材質的顯示"

----------------------
-- Totem Nameplates --
----------------------

L["|cffffffffTotem Settings|r"] = "|cffffffff圖騰設置|r"
L["Toggling"] = "切換"
L["Hide Healthbars"] = "隱藏生命條"
----
L["Icon"] = "圖標"
L["Icon Size"] = "圖標大小"
L["Totem Alpha"] = "圖騰透明度"
L["Totem Scale"] = "圖騰縮放"
----
L["Show Nameplate"] = "顯示姓名板"
----
L["Health Coloring"] = "生命值配色"
L["Enable Custom Colors"] = "啟用自定義顏色"

-----------------------
-- Custom Nameplates --
-----------------------

L["|cffffffffGeneral Settings|r"] = "|cffffffff一般設置|r"
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = "禁用此選項將關閉所有圖標，而不會對每個姓名板的自定義設置造成破壞。"
----
L["Set Name"] = "設置名字"
L["Use Target's Name"] = "使用目標名字"
L["No target found."] = "未發現目標。"
L["Clear"] = "清除"
L["Copy"] = "複製"
L["Copied!"] = "已複製！"
L["Paste"] = "粘貼"
L["Pasted!"] = "已粘貼！"
L["Nothing to paste!"] = "無可粘貼內容！"
L["Restore Defaults"] = "還原默認值"
----
L["Use Custom Settings"] = "使用自定義設置"
L["Custom Settings"] = "自定義設置"
----
L["Disable Custom Alpha"] = "禁用自定義透明度"
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = "對此姓名板禁用自定義透明度設置，使用正常透明度設置代替"
L["Custom Alpha"] = "自定義透明度"
----
L["Disable Custom Scale"] = "禁用自定義縮放"
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = "對此姓名板禁用自定義縮放設置，使用正常縮放設置代替"
L["Custom Scale"] = "自定義縮放"
----
L["Allow Marked HP Coloring"] = "允許被標記目標的血量配色"
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] = "如果姓名板有一個團隊標記，那麼允許團隊標記血量顏色設置代替自定義血量設置"

----
L["Enable the showing of the custom nameplate icon for this nameplate."] = "對此姓名板啟用自定義姓名板圖標的顯示。"
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = "直接輸入圖標材質的路徑，使用'\\'來分開目錄文件夾，或使用法術ID。"
L["Set Icon"] = "設置圖標"

-----------
-- About --
-----------

L["\n\nThank you for supporting my work!\n"] = "\n\n感謝對我工作的支持！\n"
L["Click to Donate!"] = "點擊以捐贈！"
L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00bkader@mail.com|r"] = "TidyPlates的清晰且易於使用的姓名板主題。\n\n請隨時通過電子郵件聯繫我 |cff00ff00bkader@mail.com|r"

--------------------------------
-- Default Game Options Frame --
--------------------------------

L["You can access the "] = "你可以進入"
L[" options by typing: /tptp"] = "選項通過輸入：/tptp"
L["Open Config"] = "打開設置"

------------------------
-- Additional Stances --
------------------------
L["Presences"] = "領域"
L["Shapeshifts"] = "形態"
L["Auras"] = "光環"
L["Stances"] = "姿態"