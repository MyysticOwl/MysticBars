-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Tonic.Utils.Class";

AutoListBox = class( Turbine.UI.ListBox );

function AutoListBox:Constructor( optionalWidth, optionalHeight )
	Turbine.UI.ListBox.Constructor(self);

	self.defaultWidth = optionalWidth;
	self.defaultHeight = optionalHeight;
	self:SetDefaultSize();

	self.ItemAdded = function(sender, args)
		self:AddToSize( args.Item );
	end
end

-- function AutoListBox:ClearItems()
-- 	Turbine.UI.ListBox.ClearItems(self);
-- 	-- for i=1, self:GetItemCount(), 1 do
-- 	-- 	self:RemoveItemAt( i );
-- 	-- end
-- end

function AutoListBox:SetDefaultSize()
	if ( self.defaultWidth ~= nil ) then
		self.width = self.defaultWidth;
	else
		self.width = 0;
	end
	if ( self.defaultHeight ~= nil ) then
		self.height = self.defaultHeight;
	else
		self.height = 0;
	end
end

-- This should be called after a change in orentation 
-- as that is not an event that we can listen to.
function AutoListBox:ReconfigureSize()
	self:SetDefaultSize();
	
	for i = 1, self:GetItemCount() do
		self:AddToSize( self:GetItem(i) );
	end
end

function AutoListBox:AddToSize( item )
	if ( self:GetOrientation() == Turbine.UI.Orientation.Vertical ) then
		if ( self.width < item:GetWidth() ) then
			self.width = item:GetWidth();
		end
		self.height = self.height + item:GetHeight();
	else
		if ( self.height < item:GetHeight() ) then
			self.height = item:GetHeight();
		end
		self.width = self.width + item:GetWidth();
	end
	self:SetSize( self.width, self.height );
end