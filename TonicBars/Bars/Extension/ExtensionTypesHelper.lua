
TypeHelper = class();
function TypeHelper:Constructor()
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);
end

function TypeHelper:GetNewHunterTravelSettings( eBar )
	local barSettings = self.settingsService:GetBarSettings( eBar );
	barSettings.quickslotCount = 15;
	barSettings.barName = "Hunter Travel";
	
	self:MakeQuickslot( barSettings.quickslots[1], "0x7000A2C1" );
	self:MakeQuickslot( barSettings.quickslots[2], "0x70003F42" );
	self:MakeQuickslot( barSettings.quickslots[3], "0x70003F41" );
	self:MakeQuickslot( barSettings.quickslots[4], "0x7000A2C3" );
	self:MakeQuickslot( barSettings.quickslots[5], "0x7000A2C6" );
	self:MakeQuickslot( barSettings.quickslots[6], "0x70017C81" );
	
	
	self:MakeQuickslot( barSettings.quickslots[7], "0x70003F43" );
	self:MakeQuickslot( barSettings.quickslots[8], "0x7000A2C4" );
	self:MakeQuickslot( barSettings.quickslots[9], "0x700235EF" );
	self:MakeQuickslot( barSettings.quickslots[10], "0x7001F459" );
	self:MakeQuickslot( barSettings.quickslots[11], "0x7000A2C2" );
	self:MakeQuickslot( barSettings.quickslots[12], "0x70003F44" );
	self:MakeQuickslot( barSettings.quickslots[13], "0x70017C82" );
	
	self:MakeQuickslot( barSettings.quickslots[14], "0x7000A2C5" );
	self:MakeQuickslot( barSettings.quickslots[15], "0x70017C7A" );
	return barSettings;
end

function TypeHelper:MakeQuickslot( quickslot, data )
	quickslot = {};
	quickslot.Type = 6;
	quickslot.Data = data;
end