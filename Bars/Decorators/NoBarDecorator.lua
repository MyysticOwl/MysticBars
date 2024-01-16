-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

NoBarDecorator = class();

NoBarDecorator.Log = MysticBars.Utils.Logging.LogManager.GetLogger("WindowBarDecorator");

function NoBarDecorator:Constructor(childWindow, barSettings)
	self.Log:Debug("Constructor");

	self.childWindow = childWindow;
	self.barSettings = barSettings;
end

function NoBarDecorator:Create()
	self.Log:Debug("Create");

end

function NoBarDecorator:NormalModeRefresh( barSettings )
	self.childWindow:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
	self.childWindow:SetVisible(false);

	-- if (barSettings.decorators.none.backColor == true) then
	-- 	self.childWindow:SetBackColor(Turbine.UI.Color(barSettings.decorators.none.backColorA, barSettings.decorators.none.backColorR, barSettings.decorators.none.backColorG, barSettings.decorators.none.backColorB));
	-- else
	-- 	self.childWindow:SetBackColor(Turbine.UI.Color(0.7, 0, 0, 0));
	-- end
end

function NoBarDecorator:EditModeRefresh( barSettings )
	self.childWindow:SetBackColor(Turbine.UI.Color(1,1,1,0));
	self.childWindow:SetVisible(true);
	self.childWindow.quickslotList:SetVisible(true);
end

function NoBarDecorator:SetVisible(visible)
	if (self.childWindow ~= nil) then
		self.childWindow:SetVisible(visible);
		self.childWindow.quickslotList:SetVisible(visible);
	end
end

function NoBarDecorator:SetBackColor(color)
	self.Log:Debug("SetBackColor");

	self.childWindow:SetBackColor(color);
end

function NoBarDecorator:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self.childWindow:SetBackColor(color);
end

function NoBarDecorator:Remove()
	self.Log:Debug("Remove");

	self.childWindow.SizeChanged = nil;
	self.childWindow:SetParent(nil);

	collectgarbage();
end
