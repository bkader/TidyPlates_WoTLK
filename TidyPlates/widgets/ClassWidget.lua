local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesWidgets = _G.TidyPlatesWidgets

---------------
-- Class Widget
---------------
local classWidgetPath = "Interface\\Addons\\TidyPlatesWidgets\\ClassWidget\\"

local function UpdateClassWidget(self, unit, showFriendly)
    if unit then
		local class
        if showFriendly and unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
            class = TidyPlatesUtility.GroupMembers.Class[unit.name]
        elseif unit.type == "PLAYER" then
            class = unit.class
        end

        if class and class ~= "UNKNOWN" then
            self.Icon:SetTexture(classWidgetPath .. class)
            self:Show()
        else
            self:Hide()
        end
    end
end

local function CreateClassWidget(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(24)
    frame:SetHeight(24)
    frame.Icon = frame:CreateTexture(nil, "ARTWORK")
    frame.Icon:SetAllPoints(frame)
    frame:Hide()
    frame.Update = UpdateClassWidget
    return frame
end

TidyPlatesWidgets.CreateClassWidget = CreateClassWidget