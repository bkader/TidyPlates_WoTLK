if GetLocale() ~= "frFR" then return end
local _, TidyPlates = ...
local L = TidyPlates.L

--[[ TidyPlatesPanel.lua ]]--
----------------------

L["No Automation"] = "Aucun"
L["Show during Combat, Hide when Combat ends"] = "Montrer pendant le combat, cacher hors combat"
L["Hide when Combat starts, Show when Combat ends"] = "Montrer hors combat, cacher pendant le combat"
L["Primary Theme:"] = "Style principal:"
L["Secondary Theme:"] = "Style secondaire:"
L["Please choose a theme for your Primary and Secondary Specializations. The appropriate theme will be automatically activated when you switch specs."] = "Veuillez choisir un style pour votre première et seconde spécialisations.. Chaque style sera utilisé en fonction de votre spec actuelle."
L["Enemy Nameplates:"] = "Nameplate enemies:"
L["Friendly Nameplates:"] = "Nameplates amis:"
L["Automation can automatically turn on or off Friendly and Enemy nameplates."] = "Automatisation peut montrer or cache les nameplates enemies or amis."
L["Blizzard Nameplate Motion & Visibility"] = "Motion et visibilité par défault des nameplates"
L["Show Non-Target Casting Bars (When Possible)"] = "Montrer la barre de cast d'autres enemies (Si possible)"
L["Enable Minimap Icon"] = "Montrer le bouton de la mini carte"
L["Reset Configuration"] = "Réinitialisation"
L["|cFFFF6600Tidy Plates: |cFFFFFFFFWidget file versions do not match. This may be caused by an issue with auto-updater software."] = "|cFFFF6600Tidy Plates: |cFFFFFFFFFichier widget invalide. Ceci peut être causé par le client de mise-à-jour automatique."
L["Please uninstall Tidy Plates, and then re-install. You do NOT need to clear your variables."] = "Veuillez réinstaller Tidy Plates. Vous n'avez PAS à supprimer vos données personnelles (variables)."
L["|cFFFF6600Tidy Plates: |cFFFF9900No Theme is Selected. |cFF77FF00Use |cFFFFFF00/tidyplates|cFF77FF00 to bring up the Theme Selection Window."] = "|cFFFF6600Tidy Plates: |cFFFF9900Aucun style choisi. |cFF77FF00Utilisez |cFFFFFF00/tidyplates|cFF77FF00 pour accéder à la configuration."

L.resetTidyPlanel = "%sResetting %sTidy Plates %sTheme Selection to Default"
L.commonResetPanel = "%sResetting %sTidy Plates Hub: %s%s %sConfiguration to Default"
L.resetTidyPlanelShift = "%sHolding down %sShift %swhile clicking %sReset Configuration %swill clear your saved settings, AND reload the user interface."
L.commonCopyPanel = "%sCopied %sTidy Plates Hub: %s%s %sTheme Values to Cache."
L.commonPastePanel = "%sPasted %sTidy Plates Hub: %s%s %sTheme Values from Cache."

----------------------
--[[ TankPanel.lua ]]--
----------------------

L["Default"] = "Par défault"
L["Text Only"] = "Texte"
L["Bars during Combat"] = "Barres pendant le combat"
L["Bars on Active/Damaged Units"] = "Barres sur les unités actives/attaquées"
L["Bars on Elite Units"] = "Barres sur les élites"
L["Bars on Marked Units"] = "Barres sur les unités marquées"
L["Bars on Players"] = "Barres sur joueurs"
L["None"] = "Aucun"
L["Percent Health"] = "Poucetange"
L["Exact health"] = "HP exact"
L["Health Deficit"] = "HP Déficit"
L["Health Total & Percent"] = "HP Total et Poucetange"
L["Target Of"] = "Cible de"
L["Approximate Health"] = "HP approximatif"
L["Show All"] = "Montrer tout"
L["Show These... "] = "Montrer les suivants..."
L["Show All Mine "] = "Montrer tous les miens"
L["Show My... "] = "Montrer mes..."
L["By Prefix..."] = "Par préfixe"
L["By Low Threat"] = "Par menace basse"
L["By Mouseover"] = "Par souris dessus"
L["By Debuff Widget"] = "Par widget des debuffs"
L["By Enemy"] = "Par enemie"
L["By NPC"] = "Par PNJ"
L["By Raid Icon"] = "Par marque de raid"
L["By Active/Damaged"] = "Par active/attaqué"
L["By Elite"] = "Par élite"
L["By Target"] = "Par Cible"
L["By Class"] = "Par classe"
L["By Threat"] = "Par menace"
L["By Reaction"] = "Par réaction"
L["Threat Wheel"] = "Roue de menace"
L["Opacity"] = "Opacité"
L["Current Target Opacity:"] = "Opacité de la cible:"
L["Non-Target Opacity:"] = "Opacité des autres unités:"
L["Opacity Spotlight Mode:"] = "Mode d'opacité spotlight:"
L["Spotlight Opacity:"] = "Opacité spotlight:"
-- L["Bring Casting Units to Target Opacity"] = ""
L["Use Target Opacity When No Target Exists"] = "Utiliser l'opacité de cible si aucune cible présente"
L["Filtered Unit Opacity:"] = "Opcité des unités filtrées:"
L["Filter Neutral Units"] = "Filtrer les unités neutres"
L["Filter Non-Elite"] = "Filtrer les non-élites"
L["Filter Inactive"] = "Filtrer les unités inactive"
L["Filter By Unit Name:"] = "Filtrer par nom d'unité:"
L["Scale"] = "Échelle"
L["Normal Scale:"] = "Échelle normale:"
L["Scale Spotlight Mode:"] = "Échelle de mode spotlight:"
L["Spotlight Scale:"] = "Échelle de spotlight:"
L["Ignore Neutral Units"] = "Ignorer les unités neutres"
L["Ignore Non-Elite Units"] = "Ignorer les unités non-élites"
L["Ignore Inactive Units"] = "Ignorer les unités inactives"
L["Text"] = "Text"
L["Name Text Color Mode:"] = "Couleur du texte:"
L["Health Text:"] = "Texte de HP:"
L["Show Level Text"] = "Montrer le niveau"
L["Use Default Blizzard Font"] = "Utiliser la police par défault"
L["Color"] = "Couleur"
L["Health Bar Color Mode:"] = "Couleur de la barre de vie"
L["Warning Glow/Border Mode:"] = "Mode de bordure:"
L["Threat Colors:"] = "Couleurs de menace:"
L["Attacking Me"] = "M'attaquant"
L["Losing Aggro"] = "Perte d'aggro"
L["Attacking Others"] = "Attaquant les autres"
L["Attacking Another Tank"] = "Attaquant un autre tank"
-- L["Show Warning around Group Members with Aggro"] = true
-- L["Show Class Color for Party and Raid Members"] = true
-- L["Widgets"] = true
-- L["Show Highlight on Current Target"] = true
L["Show Elite Indicator"] = "Montrer l'icone d'élite"
L["Show Enemy Class Icons"] = "Afficher les classes des enemies"
L["Show Party Member Class Icons"] = "Afficher les classes des membres du groupe"
L["Show Totem Icons"] = "Montrer les icones des totems"
L["Show Combo Points"] = "Montrer les points combo"
L["Show Threat Indicator"] = "Montrer l'indicator de menace"
L["Threat Indicator:"] = "Indicator de menace:"
L["Show Party Range Warning"] = "Avertissement de distance"
L["Range:"] = "Distance:"
L["Show My Debuff Timers"] = "Montrer la durée de mes debuffs"
L["Debuff Filter:"] = "Filtre des debuffs:"
L["Debuff Names:"] = "Noms des debuffs:"
-- L["WidgetsDebuffTrackList_Description"] = [[
-- Tip: |cffCCCCCCDebuffs should be listed with the exact name, or a spell ID number.
-- You can use the prefixes, "My" or "All", to distinguish personal damage spells from global crowd control spells.
-- Auras at the top of the list will get displayed before lower ones.|r
-- ]]
-- L["Frame"] = true
L["Vertical Position of Artwork:"] = "Position verticale de la texture:"
L["Paste"] = "Coller"
L["Copy"] = "Copier"
L["Reset"] = "Rétablir"

----------------------
--[[ DamagePanel.lua ]]--
----------------------

L["Show All Debuffs"] = "Tous les debuffs"
L["Show Specific Debuffs... "] = "Debuffs spécifics"
L["Show All My Debuffs "] = "Tous mes debuffs"
L["Show My Specific Debuffs... "] = "Mes debuffs spécifics"
L["By High Threat"] = "Par menace"
L["Gaining Aggro"] = "Gain d'aggro"
L["Show Warning on Group Members with Aggro"] = "Alerte quand un membre du groupe a aggro"