TidyPlatesWidgets = {}

----------------------
-- HideIn() - Registers a callback, which hides the specified frame in X seconds
----------------------
do
	local Framelist = {} -- Key = Frame, Value = Expiration Time
	local Watcherframe = CreateFrame("Frame")
	local WatcherframeActive = false
	local select = select
	local timeToUpdate = 0

	local function CheckFramelist(self)
		local curTime = GetTime()
		if curTime < timeToUpdate then
			return
		end
		local framecount = 0
		timeToUpdate = curTime + 1
		-- Cycle through the watchlist, hiding frames which are timed-out
		for frame, expiration in pairs(Framelist) do
			if expiration < curTime then
				frame:Hide()
				Framelist[frame] = nil
			else
				framecount = framecount + 1
			end
		end
		-- If no more frames to watch, unregister the OnUpdate script
		if framecount == 0 then
			Watcherframe:SetScript("OnUpdate", nil)
		end
	end

	function TidyPlatesWidgets:HideIn(frame, expiration)
		-- Register Frame
		Framelist[frame] = expiration
		-- Init Watchframe
		if not WatcherframeActive then
			Watcherframe:SetScript("OnUpdate", CheckFramelist)
			WatcherframeActive = true
		end
	end
end

----------------------
-- PolledHideIn() - Registers a callback, which polls the frame until it expires, then hides the frame and removes the callback
----------------------

do
	local PolledHideIn
	local Framelist = {} -- Key = Frame, Value = Expiration Time
	local Watcherframe = CreateFrame("Frame")
	local WatcherframeActive = false
	local select = select
	local timeToUpdate = 0

	local function CheckFramelist(self)
		local curTime = GetTime()
		if curTime < timeToUpdate then
			return
		end
		local framecount = 0
		timeToUpdate = curTime + 1
		-- Cycle through the watchlist, hiding frames which are timed-out
		for frame, expiration in pairs(Framelist) do
			-- If expired...
			if expiration < curTime then
				-- If active...
				frame:Hide()
				Framelist[frame] = nil
				TidyPlates:RequestDelegateUpdate() -- Request an Update on Delegate functions, so we can catch when auras fall off
			else
				-- Update the frame
				if frame.Poll then
					frame:Poll(expiration)
				end
				framecount = framecount + 1
			end
		end
		-- If no more frames to watch, unregister the OnUpdate script
		if framecount == 0 then
			Watcherframe:SetScript("OnUpdate", nil)
			WatcherframeActive = false
		end
	end

	function PolledHideIn(frame, expiration)
		if expiration == 0 then
			frame:Hide()
			Framelist[frame] = nil
		else
			--print("Hiding in", expiration - GetTime())
			Framelist[frame] = expiration
			frame:Show()

			if not WatcherframeActive then
				Watcherframe:SetScript("OnUpdate", CheckFramelist)
				WatcherframeActive = true
			end
		end
	end

	TidyPlatesWidgets.PolledHideIn = PolledHideIn
end

---------------------
-- Reset/Nil Tidy Plates Widget Frames
---------------------
do
	local Plate, plateIndex, WorldFrameChildren, WidgetChildren, widgetIndex
	local function ResetWidgets()
		WorldFrameChildren = {WorldFrame:GetChildren()}
		for plateIndex = 1, #WorldFrameChildren do
			Plate = WorldFrameChildren[plateIndex]
			if Plate.extended and Plate.extended.widgets then
				for widgetIndex, widget in pairs(Plate.extended.widgets) do
					widget:Hide()
					Plate.extended.widgets[widgetIndex] = nil
				end
			end
		end
	end
	TidyPlatesWidgets.ResetWidgets = ResetWidgets
end