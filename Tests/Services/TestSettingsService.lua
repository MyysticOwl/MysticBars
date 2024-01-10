-- CreaquickslotRowsted by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

TestSettingsService = class( MysticBars.Utils.Service );

TestSettingsService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TestSettingsService" );

function TestSettingsService:Constructor(settings, bars)
	self.Log:Debug("Constructor");
	if (settings == nil) then
		self.settings = {nextBarId=1};
	else
		self.settings = settings;
	end
	if (bars == nil) then
		self.bars = {};
	else
		self.bars = bars;
	end
end

function TestSettingsService:GetSettings()
	self.Log:Debug("GetSettings");
	return self.settings;
end

function TestSettingsService:LoadSettings( profile )
	self.Log:Debug("LoadSettings");

	return self.settings;
end

function TestSettingsService:SaveSettings( profile )
	self.Log:Debug("SaveSettings");
end

function TestSettingsService:LoadBuffs()
	self.Log:Debug("LoadBuffs");
	return {};
end

function TestSettingsService:SaveBuffs(buffs)
	self.Log:Debug("SaveBuffs");

	return {};
end

function TestSettingsService:GetBars( localBarType )
	self.Log:Debug("GetBars");
	return {};
end

function TestSettingsService:GetBarSettings( barId )
	self.Log:Debug("GetBarSettings");

	if (barId == nil) then
		return;
	end

	if (self.bars[barId] == nil) then
		local bar = { };
		bar.quickslots = { };
		bar.x = 103;
		bar.y = 161;
		bar.barType = 1;
		bar.quickslotCount = 5;
		bar.quickslotColumns = 5;
		bar.quickslotRows = bar.quickslotCount / bar.quickslotColumns;
		bar.visible = true;
		bar.locked = false;
		bar.onMouseOver = SHOW_EXTENSIONS;
		bar.opacity = 1.0;
		bar.quickslotSpacing = 1;
		bar.quickslotSize = 36;
		bar.useBackgroundColor = false;
		bar.backgroundColorRed = 0;
		bar.backgroundColorGreen = 0;
		bar.backgroundColorBlue = 0;
		bar.useFading = false;
		bar.fadeOpacity = 1;
		bar.events = { };
		bar.events.triggered = { };
		bar.events.triggered.healthTrigger = 0.25;
		bar.events.triggered.powerTrigger = 0.25;
		bar.events.triggered.triggerOnClassBuffActive = true;
		bar.events.inventory = { };
		bar.events.inventory.quantity = 50;
		self.bars[barId] = bar;
	end
	return self.bars[barId];
end

function TestSettingsService:MigrateTriggerParam(path, newpath, parameter)
	self.Log:Debug("MigrateTriggerParam");
end

function TestSettingsService:SetBarSettings(barSettings)
	self.Log:Debug("SetBarSettings");

	self.bars[barSettings.id] = barSettings;
end

function TestSettingsService:UpdateBarSettings(barid, updateCallback, completeCallback, force, doNotRefresh)
	self.Log:Debug("UpdateBarSettings");
end

function TestSettingsService:IncrementNextId()
	self.Log:Debug("IncrementNextId");

	self.settings.nextBarId = self.settings.nextBarId + 1;
end

function TestSettingsService:LoadHelper()
end

function TestSettingsService:SetWrapperSettings( theWrapperSettings )
	self.Log:Debug("SetWrapperSettings");
end

function TestSettingsService:GetProfiles()
	self.Log:Debug("GetProfiles");

	return {};
end

function TestSettingsService:GetProfileBars( profile )
	self.Log:Debug("GetProfileBars");

	return {};
end

function TestSettingsService:ResetAllBars()
	self.Log:Debug("ResetAllBars");
end


function TestSettingsService:CopyProfile( profileToCopy, copyType, barid, myBar )
	self.Log:Debug("CopyProfile");
end

function TestSettingsService:CopyBars(profileToCopy, copyType, barid, myBar)
	self.Log:Debug("CopyBars");
end

function TestSettingsService:CreatePath( copyProfile )
	self.Log:Debug("CreatePath");
end