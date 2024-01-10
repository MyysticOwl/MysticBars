-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

TestBarService = class( MysticBars.Utils.Service );

TestBarService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TestBarService" );

function TestBarService:Constructor()
end

function TestBarService:RefreshBars()
	self.Log:Debug("RefreshBars");

	for key, value in pairs (RegisteredBars) do
		value:Refresh();
	end
end

function TestBarService:Add( barType, cBarID, cQuickslotID )
	self.Log:Debug("Add");
end

function TestBarService:Remove( barid, removeSettingsWhenNil )
	self.Log:Debug("Remove");
end

function TestBarService:Copy( barid, bartype )
	self.Log:Debug("Copy");
end

function TestBarService:Reset( barid )
	self.Log:Debug("Reset");
end

function TestBarService:Construct( storedBars, second )
	self.Log:Debug("Construct");
end

function TestBarService:GetBars()
	self.Log:Debug("GetBars");
	return RegisteredBars;
end

function TestBarService:ShowExtensionBarMenu( barid )
	self.Log:Debug("ShowExtensionBarMenu");
end

function TestBarService:Alive( barid )
	self.Log:Debug("Alive");
end

function TestBarService:ExtensionMousedOver()
end

function TestBarService:ExtensionMousedLeft()
end