-- Set Global Table
ThreatPlatesWidgets = ThreatPlatesWidgets or {}
local Media = LibStub("LibSharedMedia-3.0")
local db

local PlayerGUID = UnitGUID("player")
TidyPlatesUtility:EnableGroupWatcher()
TidyPlatesWidgets:EnableAuraWatcher()
TidyPlatesWidgets:EnableTankWatch()

local ParseDebuffString
do
	local PrefixList = TidyPlatesHubHelpers.PrefixList

	local FilterFuncs = {}

	FilterFuncs[1] = function(debuff)
		return (debuff.duration < 600)
	end -- ALL

	FilterFuncs[2] = function(debuff)
		PlayerGUID = PlayerGUID or UnitGUID("player") -- just in case
		return (debuff.duration < 600 and debuff.caster == PlayerGUID)
	end -- MY

	FilterFuncs[3] = function(debuff)
		return false
	end -- NONE

	do
		local GetSpellInfo = GetSpellInfo
		local ccSpellsTable = {
			-- general
			[GetSpellInfo(118)] = true, -- Polymorph
			[GetSpellInfo(3355)] = true, -- Freezing Trap Effect
			[GetSpellInfo(6770)] = true, -- Sap
			[GetSpellInfo(6358)] = true, -- Seduction (succubus)
			[GetSpellInfo(60210)] = true, -- Freezing Arrow
			[GetSpellInfo(45524)] = true, -- Chains of Ice
			[GetSpellInfo(33786)] = true, -- Cyclone
			[GetSpellInfo(53308)] = true, -- Entangling Roots
			[GetSpellInfo(2637)] = true, -- Hibernate
			[GetSpellInfo(20066)] = true, -- Repentance
			[GetSpellInfo(9484)] = true, -- Shackle Undead
			[GetSpellInfo(51722)] = true, -- Dismantle
			[GetSpellInfo(710)] = true, -- Banish
			[GetSpellInfo(12809)] = true, -- Concussion Blow
			[GetSpellInfo(676)] = true, -- Disarm
			-- Death Knight
			[GetSpellInfo(47476)] = true, -- Strangulate
			[GetSpellInfo(49203)] = true, -- Hungering Cold
			[GetSpellInfo(47481)] = true, -- Gnaw
			[GetSpellInfo(49560)] = true, -- Death Grip
			-- Druid
			[GetSpellInfo(339)] = true, -- Entangling Roots
			[GetSpellInfo(8983)] = true, -- Bash
			[GetSpellInfo(16979)] = true, -- Feral Charge - Bear
			[GetSpellInfo(45334)] = true, -- Feral Charge Effect
			[GetSpellInfo(22570)] = true, -- Maim
			[GetSpellInfo(49803)] = true, -- Pounce
			-- Hunter
			[GetSpellInfo(5116)] = true, -- Concussive Shot
			[GetSpellInfo(19503)] = true, -- Scatter Shot
			[GetSpellInfo(19386)] = true, -- Wyvern Sting
			[GetSpellInfo(53548)] = true, -- Pin (Crab)
			[GetSpellInfo(4167)] = true, -- Web (Spider)
			[GetSpellInfo(55509)] = true, -- Venom Web Spray (Silithid)
			[GetSpellInfo(24394)] = true, -- Intimidation
			[GetSpellInfo(19577)] = true, -- Intimidation (stun)
			[GetSpellInfo(53568)] = true, -- Sonic Blast (Bat)
			[GetSpellInfo(53543)] = true, -- Snatch (Bird of Prey)
			[GetSpellInfo(50541)] = true, -- Clench (Scorpid)
			[GetSpellInfo(55492)] = true, -- Froststorm Breath (Chimaera)
			[GetSpellInfo(26090)] = true, -- Pummel (Gorilla)
			[GetSpellInfo(53575)] = true, -- Tendon Rip (Hyena)
			[GetSpellInfo(53589)] = true, -- Nether Shock (Nether Ray)
			[GetSpellInfo(53562)] = true, -- Ravage (Ravager)
			[GetSpellInfo(1513)] = true, -- Scare Beast
			[GetSpellInfo(64803)] = true, -- Entrapment
			-- Mage
			[GetSpellInfo(31661)] = true, -- Dragon's Breath
			[GetSpellInfo(44572)] = true, -- Deep Freeze
			[GetSpellInfo(122)] = true, -- Frost Nova
			[GetSpellInfo(33395)] = true, -- Freeze (Frost Water Elemental)
			[GetSpellInfo(55021)] = true, -- Silenced - Improved Counterspell
			-- Paladin
			[GetSpellInfo(853)] = true, -- Hammer of Justice
			[GetSpellInfo(10326)] = true, -- Turn Evil
			[GetSpellInfo(2812)] = true, -- Holy Wrath
			[GetSpellInfo(31935)] = true, -- Avengers Shield
			-- Priest
			[GetSpellInfo(8122)] = true, -- Psychic Scream
			[GetSpellInfo(605)] = true, -- Dominate Mind (Mind Control)
			[GetSpellInfo(15487)] = true, -- Silence
			[GetSpellInfo(64044)] = true, -- Psychic Horror
			-- Rogue
			[GetSpellInfo(408)] = true, -- Kidney Shot
			[GetSpellInfo(2094)] = true, -- Blind
			[GetSpellInfo(1833)] = true, -- Cheap Shot
			[GetSpellInfo(1776)] = true, -- Gouge
			[GetSpellInfo(1330)] = true, -- Garrote - Silence
			-- Shaman
			[GetSpellInfo(51514)] = true, -- Hex
			[GetSpellInfo(8056)] = true, -- Frost Shock
			[GetSpellInfo(64695)] = true, -- Earthgrab (Earthbind Totem with Storm, Earth and Fire talent)
			[GetSpellInfo(3600)] = true, -- Earthbind (Earthbind Totem)
			[GetSpellInfo(39796)] = true, -- Stoneclaw Stun (Stoneclaw Totem)
			[GetSpellInfo(8034)] = true, -- Frostbrand Weapon
			-- Warlock
			[GetSpellInfo(6215)] = true, -- Fear
			[GetSpellInfo(5484)] = true, -- Howl of Terror
			[GetSpellInfo(30283)] = true, -- Shadowfury
			[GetSpellInfo(22703)] = true, -- Infernal Awakening
			[GetSpellInfo(6789)] = true, -- Death Coil
			[GetSpellInfo(24259)] = true, -- Spell Lock
			-- Warrior
			[GetSpellInfo(5246)] = true, -- Initmidating Shout
			[GetSpellInfo(46968)] = true, -- Shockwave
			[GetSpellInfo(6552)] = true, -- Pummel
			[GetSpellInfo(58357)] = true, -- Heroic Throw silence
			[GetSpellInfo(7922)] = true, -- Charge
			[GetSpellInfo(47995)] = true, -- Intercept (Stun)
			[GetSpellInfo(12323)] = true, -- Piercing Howl
			-- Racials
			[GetSpellInfo(20549)] = true, -- War Stomp (Tauren)
			[GetSpellInfo(28730)] = true, -- Arcane Torrent (Bloodelf)
			[GetSpellInfo(47779)] = true, -- Arcane Torrent (Bloodelf)
			[GetSpellInfo(50613)] = true, -- Arcane Torrent (Bloodelf)
			-- Engineering
			[GetSpellInfo(67890)] = true -- Cobalt Frag Bomb
		}

		FilterFuncs[4] = function(debuff)
			return (debuff.duration < 600 and ccSpellsTable[debuff.name])
		end -- CC
	end

	FilterFuncs[5] = function(debuff)
		PlayerGUID = PlayerGUID or UnitGUID("player") -- just in case
		return (debuff.duration < 600 and debuff.caster ~= PlayerGUID)
	end -- OTHER

	function ParseDebuffString(debuff)
		local filterFunc = nil

		local _, _, prefix, suffix = string.find(debuff, "(%w+)[%s%p]*(.*)")
		if prefix then
			if PrefixList[prefix] then
				debuff = suffix
				filterFunc = FilterFuncs[PrefixList[prefix]]
			else
				debuff = prefix
				if suffix and suffix ~= "" then
					debuff = debuff .. " " .. suffix
				end
				filterFunc = FilterFuncs[1]
			end
		end

		return debuff, filterFunc
	end
end

local function FindDebuff(t, debuff)
	if t and debuff then
		for index, aura in ipairs(t) do
			-- no filter!
			if aura == debuff.name or tonumber(aura) == debuff.spellid then
				return true
			end

			local name, func = ParseDebuffString(aura)
			if (name == debuff.name or tonumber(name) == debuff.spellid) and func then
				return func(debuff)
			end
		end
	end
	return false
end

--DebuffFilterFunction
local function DebuffFilter(debuff)
	db = db or TidyPlatesThreat.db.profile

	local spellfound = nil
	if db.debuffWidget.mode == "prefix" then
		return FindDebuff(db.debuffWidget.filter, debuff)
	else
		for _, name in ipairs(db.debuffWidget.filter) do
			if name == debuff.name or tonumber(name) == debuff.spellid then
				spellfound = true
				break
			end
		end
	end

	if db.debuffWidget.mode == "whitelist" then
		return (spellfound == true)
	elseif db.debuffWidget.mode == "blacklist" then
		return (spellfound == nil)
	elseif db.debuffWidget.mode == "whitelistMine" then
		PlayerGUID = PlayerGUID or UnitGUID("player")
		return (spellfound and debuff.caster == PlayerGUID)
	elseif db.debuffWidget.mode == "blacklistMine" then
		PlayerGUID = PlayerGUID or UnitGUID("player")
		return (debuff.caster == PlayerGUID and spellfound == nil)
	elseif db.debuffWidget.mode == "allMine" then
		PlayerGUID = PlayerGUID or UnitGUID("player")
		return (debuff.caster == PlayerGUID)
	elseif db.debuffWidget.mode == "all" then
		return true
	end
end
----------------
-- INITIALIZE --
----------------
local function OnInitialize(plate)
	db = db or TidyPlatesThreat.db.profile
	local w = plate.widgets
	-- Debuff Widget
	if db.debuffWidget.ON then
		if not w.WidgetDebuff then
			local widget = TidyPlatesWidgets.CreateAuraWidget(plate)
			widget:SetPoint("CENTER", plate, db.debuffWidget.x, db.debuffWidget.y)
			widget:SetScale(db.debuffWidget.scale)
			widget:SetFrameLevel(plate:GetFrameLevel() + 1)
			widget.Filter = DebuffFilter
			w.WidgetDebuff = widget
		end
	elseif w.WidgetDebuff then
		w.WidgetDebuff:Hide()
		w.WidgetDebuff = nil
	end

	-- Social Widget
	if db.socialWidget.ON then
		if not w.SocialArt then
			local widget = ThreatPlatesWidgets.CreateSocialWidget(plate)
			widget:SetFrameLevel(plate:GetFrameLevel() + 2)
			widget:SetHeight(db.socialWidget.scale)
			widget:SetWidth(db.socialWidget.scale)
			widget:SetPoint("CENTER", plate, db.socialWidget.anchor, db.socialWidget.x, db.socialWidget.y)
			w.SocialArt = widget
		end
	elseif w.SocialArt then
		w.SocialArt:Hide()
		w.SocialArt = nil
	end

	-- Totem Widget
	if db.totemWidget.ON then
		if not w.TotemIconWidget then
			local widget = ThreatPlatesWidgets.CreateTotemIconWidget(plate)
			widget:SetHeight(db.totemWidget.scale)
			widget:SetWidth(db.totemWidget.scale)
			widget:SetFrameLevel(plate:GetFrameLevel() + 1)
			widget:SetPoint(db.totemWidget.anchor, plate, (db.totemWidget.x), (db.totemWidget.y))
			w.TotemIconWidget = widget
		end
	elseif w.TotemIconWidget then
		w.TotemIconWidget:Hide()
		w.TotemIconWidget = nil
	end

	-- Unique Widget
	if db.uniqueWidget.ON then
		if not w.UniqueIconWidget then
			local widget = ThreatPlatesWidgets.CreateUniqueIconWidget(plate)
			widget:SetHeight(db.uniqueWidget.scale)
			widget:SetWidth(db.uniqueWidget.scale)
			widget:SetFrameLevel(plate:GetFrameLevel() + 1)
			widget:SetPoint(db.uniqueWidget.anchor, plate, (db.uniqueWidget.x), (db.uniqueWidget.y))
			w.UniqueIconWidget = widget
		end
	elseif w.UniqueIconWidget then
		w.UniqueIconWidget:Hide()
		w.UniqueIconWidget = nil
	end

	-- Target Widget
	if db.targetWidget.ON then
		if not w.TargetArt then
			local widget = ThreatPlatesWidgets.CreateTargetFrameArt(plate)
			widget:SetPoint("CENTER", plate, "CENTER", 0, 0)
			w.TargetArt = widget
		end
	elseif w.TargetArt then
		w.TargetArt:Hide()
		w.TargetArt = nil
	end

	-- Class Icon Widget
	if db.classWidget.ON then
		if not w.ClassIconWidget then
			local widget = ThreatPlatesWidgets.CreateClassIconWidget(plate)
			widget:SetHeight(db.classWidget.scale)
			widget:SetWidth(db.classWidget.scale)
			widget:SetPoint((db.classWidget.anchor), plate, (db.classWidget.x), (db.classWidget.y))
			w.ClassIconWidget = widget
		end
	elseif w.ClassIconWidget then
		w.ClassIconWidget:Hide()
		w.ClassIconWidget = nil
	end

	-- Elite Overlay Widget
	if db.settings.elitehealthborder.show then
		if not w.EliteOverlay then
			local widget = ThreatPlatesWidgets.CreateEliteFrameArtOverlay(plate)
			widget:SetPoint("CENTER", plate, "CENTER", 0, 0)
			w.EliteOverlay = widget
		end
	elseif w.EliteOverlay then
		w.EliteOverlay:Hide()
		w.EliteOverlay = nil
	end

	-- Threat Graphic Widget
	if db.threat.art.ON and db.threat.ON then
		if not w.ThreatArtWidget then
			local widget = ThreatPlatesWidgets.CreateThreatArtWidget(plate)
			widget:SetPoint("CENTER", plate, "CENTER", 0, 0)
			w.ThreatArtWidget = widget
		end
	elseif w.ThreatArtWidget then
		w.ThreatArtWidget:Hide()
		w.ThreatArtWidget = nil
	end

	-- Threat Line Widget
	if db.threatWidget.ON then
		if not w.ThreatLineWidget then
			local widget = TidyPlatesWidgets.CreateThreatLineWidget(plate)
			widget:SetPoint(db.threatWidget.anchor, plate, db.threatWidget.x, db.threatWidget.y)
			widget:SetFrameLevel(plate:GetFrameLevel() + 3)
			w.ThreatLineWidget = widget
		end
	elseif w.ThreatLineWidget then
		w.ThreatLineWidget:Hide()
		w.ThreatLineWidget = nil
	end

	-- Combo Point Widget
	if db.comboWidget.ON then
		if not w.ComboPoints then
			local widget = ThreatPlatesWidgets.CreateComboPointWidget(plate)
			widget:SetPoint("CENTER", plate, (db.comboWidget.x), db.comboWidget.y)
			w.ComboPoints = widget
		end
	elseif w.ComboPoints then
		w.ComboPoints:Hide()
		w.ComboPoints = nil
	end
end
--------------------
-- CONTEXT UPDATE --
--------------------
local function OnContextUpdate(plate, unit)
	db = db or TidyPlatesThreat.db.profile
	local w = plate.widgets
	-- Debuff Widget
	if db.debuffWidget.ON then
		if not w.WidgetDebuff then
			OnInitialize(plate)
		end
		w.WidgetDebuff:SetScale(db.debuffWidget.scale)
		w.WidgetDebuff:SetPoint(db.debuffWidget.anchor, plate, db.debuffWidget.x, db.debuffWidget.y)
		w.WidgetDebuff:UpdateContext(unit)
	end

	-- Combo Point Widget
	if db.comboWidget.ON then
		if not w.ComboPoints then
			OnInitialize(plate)
		end
		w.ComboPoints:SetPoint("CENTER", plate, (db.comboWidget.x), db.comboWidget.y)
		w.ComboPoints:UpdateContext(unit)
	end

	--Threat Line Widget
	if db.threatWidget.ON and unit.class == "UNKNOWN" then
		if not w.ThreatLineWidget then
			OnInitialize(plate)
		end
		w.ThreatLineWidget:SetPoint("CENTER", plate, (db.threatWidget.x), db.threatWidget.y)
		w.ThreatLineWidget:UpdateContext(unit)
	end
end
-------------------
-- NORMAL UPDATE --
-------------------
local function OnUpdate(plate, unit)
	db = db or TidyPlatesThreat.db.profile
	local w = plate.widgets
	-- Target Art
	if db.targetWidget.ON then
		if not w.TargetArt then
			OnInitialize(plate)
		end
		w.TargetArt:Update(unit)
	end

	-- Elite Overlay
	if db.settings.elitehealthborder.show then
		if not w.EliteOverlay then
			OnInitialize(plate)
		end
		w.EliteOverlay:Update(unit)
	end

	-- Social Widget Textures
	if db.socialWidget.ON then
		if not w.SocialArt then
			OnInitialize(plate)
		end
		w.SocialArt:SetHeight(db.socialWidget.scale)
		w.SocialArt:SetWidth(db.socialWidget.scale)
		w.SocialArt:SetPoint("CENTER", plate, db.socialWidget.anchor, db.socialWidget.x, db.socialWidget.y)
		w.SocialArt:Update(unit)
	end
	-- Class Icons
	if db.classWidget.ON then
		if not w.ClassIconWidget then
			OnInitialize(plate)
		end
		w.ClassIconWidget:SetHeight(db.classWidget.scale)
		w.ClassIconWidget:SetWidth(db.classWidget.scale)
		w.ClassIconWidget:SetPoint((db.classWidget.anchor), plate, (db.classWidget.x), (db.classWidget.y))
		w.ClassIconWidget:Update(unit)
	end
	-- Totem Icons
	if db.totemWidget.ON then
		if not w.TotemIconWidget then
			OnInitialize(plate)
		end
		w.TotemIconWidget:SetHeight(db.totemWidget.scale)
		w.TotemIconWidget:SetWidth(db.totemWidget.scale)
		w.TotemIconWidget:SetPoint(db.totemWidget.anchor, plate, (db.totemWidget.x), (db.totemWidget.y))
		w.TotemIconWidget:Update(unit)
	end
	-- Unique Icons
	if db.uniqueWidget.ON then
		if not w.UniqueIconWidget then
			OnInitialize(plate)
		end
		w.UniqueIconWidget:SetHeight(db.uniqueWidget.scale)
		w.UniqueIconWidget:SetWidth(db.uniqueWidget.scale)
		w.UniqueIconWidget:SetPoint(db.uniqueWidget.anchor, plate, (db.uniqueWidget.x), (db.uniqueWidget.y))
		w.UniqueIconWidget:Update(unit)
	end
	-- Threat Widget
	if db.threat.ON and db.threat.art.ON then
		if not w.ThreatArtWidget then
			OnInitialize(plate)
		end
		w.ThreatArtWidget:Update(unit)
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		local arg1 = ...
		if arg1 == "TidyPlates_ThreatPlates" then
			TidyPlatesThemeList["Threat Plates"].OnInitialize = OnInitialize
			TidyPlatesThemeList["Threat Plates"].OnUpdate = OnUpdate
			TidyPlatesThemeList["Threat Plates"].OnContextUpdate = OnContextUpdate
		end
	end
end)
f:RegisterEvent("ADDON_LOADED")