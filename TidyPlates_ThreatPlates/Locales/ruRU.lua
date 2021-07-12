local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "ruRU", false)
if not L then return end

-- translated by: SorenMills#3894

----------------------
--[[ commands.lua ]]--
----------------------

L["-->>|cffff0000DPS Plates Enabled|r<<--"] = "-->>|cffff0000DPS Plates Enabled|r<<--"
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r: обнаружен спек в ДПС, сейчас вы в |cff89F559"
L["|r spec and are now in your |cffff0000dpsing / healing|r role."] = "|r спек и сейчас вы в |cffff0000дпс / хил|r роли."

L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = "-->>|cff00ff00Tank Plates Enabled|r<<--"
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"] = "|cff89F559Threat Plates|r: обнаружен спек в Танк, сейчас вы в |cff89F559"
L["|r spec and are now in your |cff00ff00tanking|r role."] = "|r спек и сейчас вы в |cff00ff00танк|r роли."

L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = "-->>Наложение индикаторов здоровья |cff00ff00ВКЛ!|r<<--"
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = "-->>Наложение индикаторов здоровья |cffff0000ВЫКЛ!|r<<--"

L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = "-->>Threat Plates подробность установлена на |cff00ff00ON!|r<<--"
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = "-->>Threat Plates подробность установлена на |cffff0000OFF!|r<<-- shhh!!"

------------------------------
--[[ TidyPlatesThreat.lua ]]--
------------------------------

L["|cff00ff00tanking|r"] = "|cff00ff00танкование|r"
L["|cffff0000dpsing / healing|r"] = "|cffff0000дпс / хил|r"

L["primary"] = "основной"
L["secondary"] = "второстепенный"
L["unknown"] = "неизвестный"
L["Undetermined"] = "Неопределенный"

L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = "|cff89f559Добро пожаловать в |rTidy Plates: |cff89f559Threat Plates!\nЭто ваше первое использование Threat Plates и вы(n):\n|r|cff"

L["|cff89f559Your dual spec's have been set to |r"] = "|cff89f559Ваш дуал спек был установлен на |r"
L["|cff89f559You are currently in your "] = "|cff89f559Сейчас вы в "
L["|cff89f559 role.|r"] = "|cff89f559 роли.|r"
L["|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"] = "|cff89f559Не можем определить вашу роль.\nПожалуйся утановите ваши предпочтения в |rThreat Plates|cff89f559 опциях.|r"
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = "|cff89f559Для дополнительных настроек наберите команду |r'/tptp'|cff89F559.|r"
L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."] = ":\n----------\nХотели бы вы \nустановить тему на |cff89F559Threat Plates|r?\n\nНажатие '|cff00ff00Да|r' установит Threat Plates & перезагрузит интерфейс. \n Нажатие '|cffff0000Нет|r' откроет Tidy Plates настройки."

L["Yes"] = "Да"
L["Cancel"] = "Отмена"
L["No"] = "Нет"

L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = "-->>|cffff0000Активируйте Threat Plates через опции Tidy Plates!|r<<--"
L["|cff89f559Threat Plates:|r Welcome back |cff"] = "|cff89f559Threat Plates:|r С возвращением |cff"

L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = "|cff89F559Threat Plates|r: Обнаружена смена специализации: |cff"
L[")|r, you are now in your |cff89F559"] = ")|r, сейчас вы в |cff89F559"
L["|r spec and are now in your "] = "|r спеке в "
L[" role."] = " роли."

-- Custom Nameplates
L["Shadow Fiend"] = "Исчадье тьмы"
L["Spirit Wolf"] = "Дух волка"
L["Ebon Gargoyle"] = "Вороная горгулья"
L["Water Elemental"] = "Водный элементаль"
L["Treant"] = "Древень"
L["Viper"] = "Гадюка"
L["Venomous Snake"] = "Ядовитая змея"
L["Army of the Dead Ghoul"] = "Вурдалак из войска мертвых"
L["Shadowy Apparition"] = "Сумеречный призрак"
L["Shambling Horror"] = "Шаркающий ужас"
L["Web Wrap"] = "Кокон"
L["Immortal Guardian"] = "Бессмертный страж"
L["Marked Immortal Guardian"] = "Выбранный бессмертный страж"
L["Empowered Adherent"] = "Могущественный последователь"
L["Deformed Fanatic"] = "Кособокий фанатик"
L["Reanimated Adherent"] = "Воскрешенный последователь"
L["Reanimated Fanatic"] = "Воскрешенный фанатик"
L["Bone Spike"] = "Костяной шип"
L["Onyxian Whelp"] = "Дракончик Ониксии"
L["Gas Cloud"] = "Облако газа"
L["Volatile Ooze"] = "Неустойчивый слизнюк"
L["Darnavan"] = "Дарнаван"
L["Val'kyr Shadowguard"] = "Валь'кира - страж Тьмы"
L["Kinetic Bomb"] = "Кинетическая бомба"
L["Lich King"] = "Король-лич"
L["Raging Spirit"] = "Гневный дух"
L["Drudge Ghoul"] = "Вурдалак-приспешник"
L["Living Inferno"] = "Живое адское пламя"
L["Living Ember"] = "Живой огонь"
L["Fanged Pit Viper"] = "Клыкастая глубинная гадюка"
L["Canal Crab"] = "Сточный краб"
L["Muddy Crawfish"] = "Ильный рак"

---------------------
--[[ options.lua ]]--
---------------------

L["None"] = "Без"
L["Outline"] = "Контур"
L["Thick Outline"] = "Жирный контур"
L["No Outline, Monochrome"] = "Без контура, Монохромный"
L["Outline, Monochrome"] = "Контур, Монохромный"
L["Thick Outline, Monochrome"] = "Жирный контур, Монохромный"

L["White List"] = "Белый список"
L["Black List"] = "Черный список"
L["White List (Mine)"] = "Белый список (Мой)"
L["Black List (Mine)"] = "Черный список (Мой)"
L["All Debuffs"] = "Все дебафы"
L["All Debuffs (Mine)"] = "Все дебафы (Мои)"

-- Tab Titles
L["Nameplate Settings"] = "Настройка неймплейтов"
L["Threat System"] = "модуль Угрозы"
L["Widgets"] = "Виджеты"
L["Totem Nameplates"] = "Неймплейты тотемов"
L["Custom Nameplates"] = "Свои неймплейты"
L["About"] = "...о авторах"

------------------------
-- Nameplate Settings --
------------------------
L["General Settings"] = "Основные настройки"
L["Hiding"] = "Скрытие"
L["Show Neutral"] = "Показывать нейтральных"
L["Show Normal"] = "Показывать нормальных"
L["Show Elite"] = "Показывать элиту"
L["Show Boss"] = "Показывать босса"

L["Blizzard Settings"] = "базовые настройки Близзард"
L["Open Blizzard Settings"] = "открыть базовые настройки Близзард"

L["Friendly"] = "Дружественные"
L["Show Friends"] = "Показывать дружественных"
L["Show Friendly Totems"] = "Показывать дружественные тотемы"
L["Show Friendly Pets"] = "Показывать дружественных петов"
L["Show Friendly Guardians"] = "Показывать дружественных стражей"

L["Enemy"] = "Враг"
L["Show Enemies"] = "Показывать врагов"
L["Show Enemy Totems"] = "Показывать вражеские тотемы"
L["Show Enemy Pets"] = "Показывать вражеских петов"
L["Show Enemy Guardians"] = "Показывать вражеских стражей"

----
L["Healthbar"] = "Индикатор здоровья"
L["Textures"] = "Текстуры"
L["Show Border"] = "Показывать границу"
L["Normal Border"] = "Нормальная граница"
L["Show Elite Border"] = "Показывать границу элиты"
L["Elite Border"] = "Граница элиты"
L["Mouseover"] = "Наведение мыши"
L["Width"] = "Ширина"
L["Height"] = "Высота"
----
L["Placement"] = "Расположение"
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = "Изменение этих настроек изменит положение неймплейтов, однако область наведения указателя мыши не изменится. |cffff0000Use with caution!|r"
L["Offset X"] = "Положение X"
L["Offset Y"] = "Положение Y"
L["X"] = "X"
L["Y"] = "Y"
L["Anchor"] = "Якорь"
----
L["Coloring"] = "Окрашивание"
L["Enable Coloring"] = "Включить окрашивание"
L["Color HP by amount"] = "Цвет зависит от кол-ва здоровья"
L["Changes the HP color depending on the amount of HP the nameplate shows."] = "Изменяет цвет здоровья в зависимости от кол-ва."
----
L["Class Coloring"] = "Цвет класса"
L["Enemy Class Colors"] = "Цвета класса врагов"
L["Enable Enemy Class colors"] = "Включить цвета класса врагов"
L["Friendly Class Colors"] = "Цвета класса союзников"
L["Enable Friendly Class Colors"] = "Включить цвета класса союзников"
L["Enable the showing of friendly player class color on hp bars."] = "Включает показ цветов класса на индикаторах союзников."
L["Friendly Caching"] = "Кэшировать цвета класса союзников"
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = "Это позволяет сохранять информацию о цветах класса союзников между игровыми сессиями или когда индикаторы исчезают с экрана.|cffff0000(Uses more memory)"
L["Name Only"] = "Name Only"
L["Show only names above friendly units."] = "Show only names above friendly units."
----
L["Custom HP Color"] = "Свои цвета индикаторов"
L["Enable Custom HP colors"] = "Включить свои цвета"
L["Friendly Color"] = "Цвет для союзников"
L["Neutral Color"] = "Цвет для нейтралов"
L["Enemy Color"] = "Цвет врагов"
----
L["Raid Mark HP Color"] = "Цвета меток рейда"
L["Enable Raid Marked HP colors"] = "Включить цвета меток рейда"
L["Colors"] = "Цвета"
----
L["Threat Colors"] = "Цвета угрозы"
L["Show Threat Glow"] = "Показать сияние"
L["|cff00ff00Low threat|r"] = "|cff00ff00Низкая угроза|r"
L["|cffffff00Medium threat|r"] = "|cffffff00Средняя угроза|r"
L["|cffff0000High threat|r"] = "|cffff0000Высокая угроза|r"
L["|cffff0000Low threat|r"] = "|cffff0000Низкая угроза|r"
L["|cff00ff00High threat|r"] = "|cff00ff00Высокая угроза|r"
L["Low Threat"] = "Низкая угроза"
L["Medium Threat"] = "Средняя угроза"
L["High Threat"] = "Высокая угроза"

----
L["Castbar"] = "Полоса заклинаний"
L["Enable"] = "Включить"
L["Non-Target Castbars"] = "Показывать даже вне цели"
L["This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."] = "Это позволяет кастбару попытаться создать бар на индикаторах игроков или существ, над которыми вы недавно провели указателем.."
L["Interruptable Casts"] = "Прерываемые заклинания"
L["Shielded Coloring"] = "Цвет для защищенных"
L["Uninterruptable Casts"] = "Не прерываемые заклинания"

----
L["Alpha"] = "Прозрачность"
L["Blizzard Target Fading"] = "Близовское затухание для цели"
L["Enable Blizzard 'On-Target' Fading"] = "Включить Близовское 'On-Target' Затухание"
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = "Включение этой опции позволит установить прозрачность для индикаторов вне цели."
L["Non-Target Alpha"] = "Прозраччность вне цели"
L["Alpha Settings"] = "Настройки прозрачности"

----
L["Scale"] = "Размер"
L["Scale Settings"] = "Настройки размера"

----
L["Name Text"] = "Текст имени"
L["Enable Name Text"] = "Включить отображение имени"
L["Enables the showing of text on nameplates."] = "Включает отображение текста на индикаторах."
L["Options"] = "Опции"
L["Font"] = "Шрифт"
L["Font Style"] = "Стиль шрифта"
L["Set the outlining style of the text."] = "Настройте стиль текста."
L["Enable Shadow"] = "Включить тень"
L["Color"] = "Цвет"
L["Text Bounds and Sizing"] = "Привязки текста и размер"
L["Font Size"] = "Размер шрифта"
L["Text Boundaries"] = "Привязки текста"
L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."] = "Эти настройки определят пространство, которое можно поместить на индикаторе.\nЕсли шрифт слишком большого размера и ему не будет хватать высоты для отображения, то текст будет не видно."
L["Text Width"] = "Ширина текста"
L["Text Height"] = "Высота текста"
L["Horizontal Align"] = "Горизонтальное выравнивание"
L["Vertical Align"] = "Вертикальное выравнивание"

----
L["Health Text"] = "Текст здоровья"
L["Enable Health Text"] = "Включить отображение текста"
L["Display Settings"] = "Настройки отображение"
L["Text at Full HP"] = "Текст при полном здоровье"
L["Display health text on targets with full HP."] = "Отображает кол-во при полном здоровье цели."
L["Percent Text"] = "Проценты"
L["Display health percentage text."] = "Отображает процент здоровья."
L["Amount Text"] = "Количество"
L["Display health amount text."] = "Отображать количество здоровья."
L["Amount Text Formatting"] = "Формат отображения кол-ва"
L["Truncate Text"] = "Сокращенно"
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = "Это сократит отображаемые цифры используя М или К для миллионов и тысяч. Отключение данного пункта уберет сокращения."
L["Max HP Text"] = "Отображение максимального кол-ва"
L["This will format text to show both the maximum hp and current hp."] = "Этот пунк покажет оба текста, максимальное и текущее кол-во здоровья."
L["Deficit Text"] = "Дефицит здоровья"
L["This will format text to show hp as a value the target is missing."] = "Этот текст показывает кол-во здоровья, которое цель потеряла."

----
L["Spell Text"] = "Текст заклинания"
L["Enable Spell Text"] = "Включить текст заклинания"

----
L["Level Text"] = "Текст уровня"
L["Enable Level Text"] = "Включить текст уровня"

----
L["Elite Icon"] = "Иконка элиты"
L["Enable Elite Icon"] = "Включить иконку элиты"
L["Enables the showing of the elite icon on nameplates."] = "Включение отображения иконки элиты."
L["Texture"] = "Текстура"
L["Preview"] = "Предпросмотрт"
L["Elite Icon Style"] = "Стиль иконки"
L["Size"] = "Размер"

----
L["Skull Icon"] = "Иконка черепа"
L["Enable Skull Icon"] = "Включить иконку-череп"
L["Enables the showing of the skull icon on nameplates."] = "Включить отображение иконки-черепа на индикаторах."

----
L["Spell Icon"] = "Иконка заклинания"
L["Enable Spell Icon"] = "Включить иконку заклинания"
L["Enables the showing of the spell icon on nameplates."] = "Включает отображение иконки заклинания на индикаторах."

----
L["Raid Marks"] = "Метки рейда"
L["Enable Raid Mark Icon"] = "Включить иконку меток рейда"
L["Enables the showing of the raid mark icon on nameplates."] = "Включает отображение иконок меток рейда на индикаторах."

-------------------
-- Threat System --
-------------------

L["Enable Threat System"] = "Включить систему Угрозы"

----
L["Additional Toggles"] = "Дополнительные функции"
L["Ignore Non-Combat Threat"] = "Игнорировать угрозу от целей вне боя"
L["Disables threat feedback from mobs you're currently not in combat with."] = "Отключает отображение угрозы от целей которые не в бою с вами."
L["Show Neutral Threat"] = "Показ угрозы от нейтралов"
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = "Исключает показ угрозы от нейтралов включая боссов и элиту."
L["Show Normal Threat"] = "Показ угрозы от обычных"
L["Disables threat feedback from normal mobs."] = "Исключает показ угрозы от обычных мобов."
L["Show Elite Threat"] = "Показ угрозы от элит"
L["Disables threat feedback from elite mobs."] = "Исключает показ угрозы от элитных мобов."
L["Show Boss Threat"] = "Показ угрозы боссов"
L["Disables threat feedback from boss level mobs."] = "Исключает показ угрозы от боссов."

----
L["Set alpha settings for different threat reaction types."] = "Установить настройки прозрачности для разных уровней угрозы."
L["Enable Alpha Threat"] = "Включить прозрачность от угрозы"
L["Enable nameplates to change alpha depending on the levels you set below."] = "Включает изменение прозрачности индикаторов в зависимости от настроек ниже."
L["|cff00ff00Tank|r"] = "|cff00ff00Танк|r"
L["|cffff0000DPS/Healing|r"] = "|cffff0000ДПС/Лекарь|r"
----
L["Marked Targets"] = "Отмеченные цели"
L["Ignore Marked Targets"] = "Игнорировать отмеченные целы"
L["This will allow you to disabled threat alpha changes on marked targets."] = "Это позволит вам отключить изменение прозрачности на отмеченных рейд метками целях."
L["Ignored Alpha"] = "Игнорируемые"

----
L["Set scale settings for different threat reaction types."] = "Устанавливает размер индикаторов для разных типов угрозы."
L["Enable Scale Threat"] = "Включить размер от Угрозы"
L["Enable nameplates to change scale depending on the levels you set below."] = "Включает изменение размера от уровня угрозы установленного ниже."
L["This will allow you to disabled threat scale changes on marked targets."] = "Это позволит вам отключить изменения размера от угрозы на отмеченных целях."
L["Ignored Scaling"] = "Игнорируемые"
----
L["Additional Adjustments"] = "Дополнительные настройки"
L["Enable Adjustments"] = "Включить дополнения"
L["This will allow you to add additional scaling changes to specific mob types."] = "Это позволит вам добавить дополнительные изменения размера для указанных типов существ."

----
L["Toggles"] = "Функции"
L["Color HP by Threat"] = "Цвет индикаторов от угрозы"
L["This allows HP color to be the same as the threat colors you set below."] = "Это позволит цвету индикатора быть того же цвета что и цвет угрозы установленный ниже."

----
L["Dual Spec Roles"] = "Двойная специализация"
L["Set the role your primary and secondary spec represent."] = "Устанавливает ваш основной и дополнительный спек."
L["Primary Spec"] = "Основной спек"
L["Sets your primary spec to tanking."] = "Устанавливает ваш основной спек как Танкование."
L["Sets your primary spec to DPS."] = "Устанавливает ваш основной спек как ДПС."
L["Secondary Spec"] = "Дополнительный спек"
L["Sets your secondary spec to tanking."] = "Устанавливает ваш дополнительный спек как Танкование."
L["Sets your secondary spec to DPS."] = "Устанавливает ваш дополнительный спек как ДПС."

----
L["Set threat textures and their coloring options here."] = "Настройка текстур и цвета угрозы."
L["These options are for the textures shown on nameplates at various threat levels."] = "Эти настройки для текстур, отображаемых на индикаторах на разных уровнях угрозы."
----
L["Art Options"] = "Настройка графики"
L["Style"] = "Стиль"
L["This will allow you to disabled threat art on marked targets."] = "Это позволит вам отключить индикаторы угрозы на отмеченных целях."

-------------
-- Widgets --
-------------

L["Class Icons"] = "Иконки классов"
L["This widget will display class icons on nameplate with the settings you set below."] = "Этот виджет покажет иконки классов на индикаторах с настройками установленными ниже."
L["Enable Friendly Icons"] = "Включить иконки союзников"
L["Enable the showing of friendly player class icons."] = "Включает отображение иконок класса на союзниках."

----
L["Combo Points"] = "Комбо поинты"
L["This widget will display combo points on your target nameplate."] = "Этот виджет покажет комбо поинты на индикаторах."

----
L["Debuffs"] = "Дебафы"
L["This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."] = "Этот виджет покажет дебафы, которые соответствуют вашим фильтрам на индикаторах целей и других рядом."
L["Sizing"] = "Размер"
L["Filtering"] = "Фильтры"
L["Mode"] = "Режим"
L["Filtered Debuffs"] = "Отфильтрованные"

----
L["Social Widget"] = "Социальный виджет"
L["Enables the showing if indicator icons for friends, guildmates, and BNET Friends"] = "Включает отображение индикаторов иконок для друзей, согильдийцев и БатлНЕТ друзей"

----
L["Threat Line"] = "Полоска угрозы"
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = "Этот виджет покажет маленькую полоску, которая будет отображать вашу угрозу к текущей цели в сравнении с другими игроками атакующими ее."

----
L["Tanked Targets"] = "Танко-цели"
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked.|cffff00ffRequires tanking role.|r"] = "Этот виджет покажет маленький щит или кинжал означающие, что текущая цель танкуется кем либо.|cffff00ffТребуется роль Танк.|r"

----
L["Target Highlight"] = "Подсветка цели"
L["Enables the showing of a texture on your target nameplate"] = "Включает показ текстуры на вашей цели"

----------------------
-- Totem Nameplates --
----------------------

L["|cffffffffTotem Settings|r"] = "|cffffffffНастройка тотемов|r"
L["Toggling"] = "Функции"
L["Hide Healthbars"] = "Скрыть индикаторы здоровья"
----
L["Icon"] = "Иконка"
L["Icon Size"] = "Размер иконки"
L["Totem Alpha"] = "Прозрачность тотема"
L["Totem Scale"] = "Размер тотема"
----
L["Show Nameplate"] = "Показать индикатор"
----
L["Health Coloring"] = "Цвет индикатора здоровья"
L["Enable Custom Colors"] = "Включить свои цвета"

-----------------------
-- Custom Nameplates --
-----------------------

L["|cffffffffGeneral Settings|r"] = "|cffffffffОсновные настройки|r"
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = "Отключение этой функции отключит все иконки без ущерба для пользовательских настроек."
----
L["Set Name"] = "Назначить имя"
L["Use Target's Name"] = "Использовать имя цели"
L["No target found."] = "Цель не найдена."
L["Clear"] = "Очистить"
L["Copy"] = "Копировать"
L["Copied!"] = "Скопировано!"
L["Paste"] = "Вставить"
L["Pasted!"] = "Вставлено!"
L["Nothing to paste!"] = "Нечего вставить!"
L["Restore Defaults"] = "Восстановить умолчания"
----
L["Use Custom Settings"] = "Использовать свой цвет"
L["Custom Settings"] = "Свои натсройки"
----
L["Disable Custom Alpha"] = "Отключить свою прозрачность"
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = "Отключает пользовательские настройки прозрачности и вместо этого использует обычные настройки."
L["Custom Alpha"] = "Своя прозрачность"
----
L["Disable Custom Scale"] = "Отключить свой размер"
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = "Отключает свой размер для текущего индикатора и использует нормальные настройки."
L["Custom Scale"] = "Свой размер"
----
L["Allow Marked HP Coloring"] = "Разрешить цвет для отмеченных целей"
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] = "Разрешает отмеченным рейд метками использовать свой цвет вместо установленного."

----
L["Enable the showing of the custom nameplate icon for this nameplate."] = "Включает отображение своей иконки для текущего индикатора."
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = "Укажите прямой путь до текстуры с иконкой используя '\\' для разделения дирректорий, или используйте spellid."
L["Set Icon"] = "Установить иконку"

-----------
-- About --
-----------

L["\n\nThank you for supporting my work!\n"] = "\n\nСпасибо за поддержку!\n"
L["Click to Donate!"] = "Поддержать автора!"
L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00bkader@mail.com|r"] = "Легко и просто используйте эту тему для TidyPlates.\n\nМожете связаться со мной по мылу |cff00ff00bkader@mail.com|r"

--------------------------------
-- Default Game Options Frame --
--------------------------------

L["You can access the "] = "Вы можете получить доступ к "
L[" options by typing: /tptp"] = " опциям набрав: /tptp"
L["Open Config"] = "Открыть настройки"

------------------------
-- Additional Stances --
------------------------
L["Presences"] = "Власти"
L["Shapeshifts"] = "Формы"
L["Auras"] = "Ауры"
L["Stances"] = "Стойки"