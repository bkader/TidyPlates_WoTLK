local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "enUS", true)
if not L then return end

----------------------
--[[ commands.lua ]]--
----------------------

L["-->>|cffff0000DPS Plates Enabled|r<<--"] = true
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"] = true
L["|r spec and are now in your |cffff0000dpsing / healing|r role."] = true

L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = true
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"] = true
L["|r spec and are now in your |cff00ff00tanking|r role."] = true

L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = true
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = true

L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = true
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = true

------------------------------
--[[ TidyPlatesThreat.lua ]]--
------------------------------

L["|cff00ff00tanking|r"] = true
L["|cffff0000dpsing / healing|r"] = true

L["primary"] = true
L["secondary"] = true
L["unknown"] = true
L["Undetermined"] = true

L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = true

L["|cff89f559Your dual spec's have been set to |r"] = true
L["|cff89f559You are currently in your "] = true
L["|cff89f559 role.|r"] = true
L["|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"] = true
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = true
L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."] = true

L["Yes"] = true
L["Cancel"] = true
L["No"] = true

L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = true
L["|cff89f559Threat Plates:|r Welcome back |cff"] = true

L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = true
L[")|r, you are now in your |cff89F559"] = true
L["|r spec and are now in your "] = true
L[" role."] = true

-- Custom Nameplates
L["Shadow Fiend"] = true
L["Spirit Wolf"] = true
L["Ebon Gargoyle"] = true
L["Water Elemental"] = true
L["Treant"] = true
L["Viper"] = true
L["Venomous Snake"] = true
L["Army of the Dead Ghoul"] = true
L["Shadowy Apparition"] = true
L["Shambling Horror"] = true
L["Web Wrap"] = true
L["Immortal Guardian"] = true
L["Marked Immortal Guardian"] = true
L["Empowered Adherent"] = true
L["Deformed Fanatic"] = true
L["Reanimated Adherent"] = true
L["Reanimated Fanatic"] = true
L["Bone Spike"] = true
L["Onyxian Whelp"] = true
L["Gas Cloud"] = true
L["Volatile Ooze"] = true
L["Darnavan"] = true
L["Val'kyr Shadowguard"] = true
L["Kinetic Bomb"] = true
L["Lich King"] = true
L["Raging Spirit"] = true
L["Drudge Ghoul"] = true
L["Living Inferno"] = true
L["Living Ember"] = true
L["Fanged Pit Viper"] = true
L["Canal Crab"] = true
L["Muddy Crawfish"] = true

---------------------
--[[ options.lua ]]--
---------------------

L["None"] = true
L["Outline"] = true
L["Thick Outline"] = true
L["No Outline, Monochrome"] = true
L["Outline, Monochrome"] = true
L["Thick Outline, Monochrome"] = true

L["White List"] = true
L["Black List"] = true
L["White List (Mine)"] = true
L["Black List (Mine)"] = true
L["All Debuffs"] = true
L["All Debuffs (Mine)"] = true

-- Tab Titles
L["Nameplate Settings"] = true
L["Threat System"] = true
L["Widgets"] = true
L["Totem Nameplates"] = true
L["Custom Nameplates"] = true
L["About"] = true

------------------------
-- Nameplate Settings --
------------------------
L["General Settings"] = true
L["Hiding"] = true
L["Show Neutral"] = true
L["Show Normal"] = true
L["Show Elite"] = true
L["Show Boss"] = true

L["Blizzard Settings"] = true
L["Open Blizzard Settings"] = true

L["Friendly"] = true
L["Show Friends"] = true
L["Show Friendly Totems"] = true
L["Show Friendly Pets"] = true
L["Show Friendly Guardians"] = true

L["Enemy"] = true
L["Show Enemies"] = true
L["Show Enemy Totems"] = true
L["Show Enemy Pets"] = true
L["Show Enemy Guardians"] = true

----
L["Healthbar"] = true
L["Textures"] = true
L["Show Border"] = true
L["Normal Border"] = true
L["Show Elite Border"] = true
L["Elite Border"] = true
L["Mouseover"] = true
L["Width"] = true
L["Height"] = true
----
L["Placement"] = true
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = true
L["Offset X"] = true
L["Offset Y"] = true
L["X"] = true
L["Y"] = true
L["Anchor"] = true
----
L["Coloring"] = true
L["Enable Coloring"] = true
L["Color HP by amount"] = true
L["Changes the HP color depending on the amount of HP the nameplate shows."] = true
----
L["Class Coloring"] = true
L["Enemy Class Colors"] = true
L["Enable Enemy Class colors"] = true
L["Friendly Class Colors"] = true
L["Enable Friendly Class Colors"] = true
L["Enable the showing of friendly player class color on hp bars."] = true
L["Friendly Caching"] = true
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = true
L["Name Only"] = true
L["Show only names above friendly units."] = true
----
L["Custom HP Color"] = true
L["Enable Custom HP colors"] = true
L["Friendly Color"] = true
L["Neutral Color"] = true
L["Enemy Color"] = true
----
L["Raid Mark HP Color"] = true
L["Enable Raid Marked HP colors"] = true
L["Colors"] = true
----
L["Threat Colors"] = true
L["Show Threat Glow"] = true
L["|cff00ff00Low threat|r"] = true
L["|cffffff00Medium threat|r"] = true
L["|cffff0000High threat|r"] = true
L["|cffff0000Low threat|r"] = true
L["|cff00ff00High threat|r"] = true
L["Low Threat"] = true
L["Medium Threat"] = true
L["High Threat"] = true

----
L["Castbar"] = true
L["Enable"] = true
L["Non-Target Castbars"] = true
L["This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."] = true
L["Interruptable Casts"] = true
L["Shielded Coloring"] = true
L["Uninterruptable Casts"] = true

----
L["Alpha"] = true
L["Blizzard Target Fading"] = true
L["Enable Blizzard 'On-Target' Fading"] = true
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = true
L["Non-Target Alpha"] = true
L["Alpha Settings"] = true

----
L["Scale"] = true
L["Scale Settings"] = true

----
L["Name Text"] = true
L["Enable Name Text"] = true
L["Enables the showing of text on nameplates."] = true
L["Options"] = true
L["Font"] = true
L["Font Style"] = true
L["Set the outlining style of the text."] = true
L["Enable Shadow"] = true
L["Color"] = true
L["Text Bounds and Sizing"] = true
L["Font Size"] = true
L["Text Boundaries"] = true
L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."] = true
L["Text Width"] = true
L["Text Height"] = true
L["Horizontal Align"] = true
L["Vertical Align"] = true

----
L["Health Text"] = true
L["Enable Health Text"] = true
L["Display Settings"] = true
L["Text at Full HP"] = true
L["Display health text on targets with full HP."] = true
L["Percent Text"] = true
L["Display health percentage text."] = true
L["Amount Text"] = true
L["Display health amount text."] = true
L["Amount Text Formatting"] = true
L["Truncate Text"] = true
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = true
L["Max HP Text"] = true
L["This will format text to show both the maximum hp and current hp."] = true
L["Deficit Text"] = true
L["This will format text to show hp as a value the target is missing."] = true

----
L["Spell Text"] = true
L["Enable Spell Text"] = true

----
L["Level Text"] = true
L["Enable Level Text"] = true

----
L["Elite Icon"] = true
L["Enable Elite Icon"] = true
L["Enables the showing of the elite icon on nameplates."] = true
L["Texture"] = true
L["Preview"] = true
L["Elite Icon Style"] = true
L["Size"] = true

----
L["Skull Icon"] = true
L["Enable Skull Icon"] = true
L["Enables the showing of the skull icon on nameplates."] = true

----
L["Spell Icon"] = true
L["Enable Spell Icon"] = true
L["Enables the showing of the spell icon on nameplates."] = true

----
L["Raid Marks"] = true
L["Enable Raid Mark Icon"] = true
L["Enables the showing of the raid mark icon on nameplates."] = true

-------------------
-- Threat System --
-------------------

L["Enable Threat System"] = true

----
L["Additional Toggles"] = true
L["Ignore Non-Combat Threat"] = true
L["Disables threat feedback from mobs you're currently not in combat with."] = true
L["Show Neutral Threat"] = true
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = true
L["Show Normal Threat"] = true
L["Disables threat feedback from normal mobs."] = true
L["Show Elite Threat"] = true
L["Disables threat feedback from elite mobs."] = true
L["Show Boss Threat"] = true
L["Disables threat feedback from boss level mobs."] = true

----
L["Set alpha settings for different threat reaction types."] = true
L["Enable Alpha Threat"] = true
L["Enable nameplates to change alpha depending on the levels you set below."] = true
L["|cff00ff00Tank|r"] = true
L["|cffff0000DPS/Healing|r"] = true
----
L["Marked Targets"] = true
L["Ignore Marked Targets"] = true
L["This will allow you to disabled threat alpha changes on marked targets."] = true
L["Ignored Alpha"] = true

----
L["Set scale settings for different threat reaction types."] = true
L["Enable Scale Threat"] = true
L["Enable nameplates to change scale depending on the levels you set below."] = true
L["This will allow you to disabled threat scale changes on marked targets."] = true
L["Ignored Scaling"] = true
----
L["Additional Adjustments"] = true
L["Enable Adjustments"] = true
L["This will allow you to add additional scaling changes to specific mob types."] = true

----
L["Toggles"] = true
L["Color HP by Threat"] = true
L["This allows HP color to be the same as the threat colors you set below."] = true

----
L["Dual Spec Roles"] = true
L["Set the role your primary and secondary spec represent."] = true
L["Primary Spec"] = true
L["Sets your primary spec to tanking."] = true
L["Sets your primary spec to DPS."] = true
L["Secondary Spec"] = true
L["Sets your secondary spec to tanking."] = true
L["Sets your secondary spec to DPS."] = true

----
L["Set threat textures and their coloring options here."] = true
L["These options are for the textures shown on nameplates at various threat levels."] = true
----
L["Art Options"] = true
L["Style"] = true
L["This will allow you to disabled threat art on marked targets."] = true

-------------
-- Widgets --
-------------

L["Class Icons"] = true
L["This widget will display class icons on nameplate with the settings you set below."] = true
L["Enable Friendly Icons"] = true
L["Enable the showing of friendly player class icons."] = true

----
L["Combo Points"] = true
L["This widget will display combo points on your target nameplate."] = true

----
L["Debuffs"] = true
L["This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."] = true
L["Sizing"] = true
L["Filtering"] = true
L["Mode"] = true
L["Filtered Debuffs"] = true

----
L["Social Widget"] = true
L["Enables the showing if indicator icons for friends, guildmates, and BNET Friends"] = true

----
L["Threat Line"] = true
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = true

----
L["Tanked Targets"] = true
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked. |cffff00ffRequires tanking role.|r"] = true

----
L["Target Highlight"] = true
L["Enables the showing of a texture on your target nameplate"] = true
L["Invert Texture"] = true

----------------------
-- Totem Nameplates --
----------------------

L["|cffffffffTotem Settings|r"] = true
L["Toggling"] = true
L["Hide Healthbars"] = true
----
L["Icon"] = true
L["Icon Size"] = true
L["Totem Alpha"] = true
L["Totem Scale"] = true
----
L["Show Nameplate"] = true
----
L["Health Coloring"] = true
L["Enable Custom Colors"] = true

-----------------------
-- Custom Nameplates --
-----------------------

L["|cffffffffGeneral Settings|r"] = true
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = true
----
L["Set Name"] = true
L["Use Target's Name"] = true
L["No target found."] = true
L["Clear"] = true
L["Copy"] = true
L["Copied!"] = true
L["Paste"] = true
L["Pasted!"] = true
L["Nothing to paste!"] = true
L["Restore Defaults"] = true
----
L["Use Custom Settings"] = true
L["Custom Settings"] = true
----
L["Disable Custom Alpha"] = true
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = true
L["Custom Alpha"] = true
----
L["Disable Custom Scale"] = true
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = true
L["Custom Scale"] = true
----
L["Allow Marked HP Coloring"] = true
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] =  true

----
L["Enable the showing of the custom nameplate icon for this nameplate."] = true
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = true
L["Set Icon"] = true

-----------
-- About --
-----------

L["\n\nThank you for supporting my work!\n"] = true
L["Click to Donate!"] = true
L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00bkader@mail.com|r"] = true

--------------------------------
-- Default Game Options Frame --
--------------------------------

L["You can access the "] = true
L[" options by typing: /tptp"] = true
L["Open Config"] = true

------------------------
-- Additional Stances --
------------------------
L["Presences"] = true
L["Shapeshifts"] = true
L["Auras"] = true
L["Stances"] = true