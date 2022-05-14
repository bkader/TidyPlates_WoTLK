----------------------------------
-- Helpers
----------------------------------
local PrefixList = {
	["ALL"] = 1,
	["All"] = 1,
	["all"] = 1,
	["MY"] = 2,
	["My"] = 2,
	["my"] = 2,
	["NO"] = 3,
	["No"] = 3,
	["no"] = 3,
	["CC"] = 4,
	["cc"] = 4,
	["OTHER"] = 5,
	["Other"] = 5,
	["other"] = 5
}

local function CallForStyleUpdate()
	for name, theme in pairs(TidyPlatesThemeList) do
		if theme.OnApplyThemeCustomization then
			theme.OnApplyThemeCustomization()
		end
	end
end

local function GetPanelValues(panel, targetTable, cloneTable)
	for index in pairs(targetTable) do
		if panel[index] then
			targetTable[index] = panel[index]:GetValue()
			cloneTable[index] = targetTable[index]
		end
	end
end

local function SetPanelValues(panel, sourceTable)
	for index, value in pairs(sourceTable) do
		if panel[index] then
			panel[index]:SetValue(value)
		end
	end
end

local function GetSavedVariables(targetTable, cloneTable)
	for i, v in pairs(targetTable) do
		if cloneTable[i] ~= nil then
			targetTable[i] = cloneTable[i]
		end
	end
end

local function ListToTable(...)
	local t = {}
	for index = 1, select("#", ...) do
		local line = select(index, ...)
		if line ~= "" then
			t[index] = line
		end
	end
	return t
end

local function ConvertStringToTable(source, target)
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)

	for index = 1, #source do
		local str = temp[index]
		if str then
			target[str] = true
		end
	end
end

local function ConvertDebuffListTable(source, target, order)
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)
	if order then
		order = wipe(order)
	end

	for index = 1, #temp do
		local str = temp[index]
		local item
		local _, _, prefix, suffix = string.find(str, "(%w+)[%s%p]*(.*)")
		if prefix then
			if PrefixList[prefix] then
				item = suffix
				target[item] = PrefixList[prefix]
			else -- If no prefix is listed, assume 1
				item = prefix
				if suffix and suffix ~= "" then
					item = item .. " " .. suffix
				end
				target[item] = 1
			end
			if order then
				order[item] = index
			end
		end
	end
end

local playerGUID
local function PlayerGUID()
	if not playerGUID then
		playerGUID = UnitGUID("player")
	end
	return playerGUID
end

TidyPlatesHubHelpers = {}
TidyPlatesHubHelpers.PrefixList = PrefixList
TidyPlatesHubHelpers.CallForStyleUpdate = CallForStyleUpdate
TidyPlatesHubHelpers.GetPanelValues = GetPanelValues
TidyPlatesHubHelpers.SetPanelValues = SetPanelValues
TidyPlatesHubHelpers.GetSavedVariables = GetSavedVariables
TidyPlatesHubHelpers.ListToTable = ListToTable
TidyPlatesHubHelpers.ConvertStringToTable = ConvertStringToTable
TidyPlatesHubHelpers.ConvertDebuffListTable = ConvertDebuffListTable
TidyPlatesHubHelpers.PlayerGUID = PlayerGUID