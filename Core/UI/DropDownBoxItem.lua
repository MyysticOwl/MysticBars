import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "Turbine";
DropDownBoxItem = class( Turbine.UI.Control );
function DropDownBoxItem:Constructor(label,width)
	Turbine.UI.Control.Constructor( self );
	self.label = label;
	self:SetSize(width,20);
	self.text=Turbine.UI.Label();
	self.text:SetParent(self);
	self.text:SetSize(self:GetWidth(),20);
	self.text:SetPosition(0,0);
	self.text:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	self.text:SetFontStyle(Turbine.UI.FontStyle.None );
	self.text:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
	self.text:SetText(self.label);
	self.text:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	self.selected = false;
 	self:SetBackColorBlendMode(4);
	self.MouseEnter=function(sender,args)
		self.text:SetForeColor(Turbine.UI.Color(1,1,1));
		self.text:SetFontStyle(Turbine.UI.FontStyle.Outline );
		self.text:SetOutlineColor(Turbine.UI.Color(.69,.482,.015));
	end
	
	self.MouseLeave=function(sender,args)
		self.text:SetFontStyle(Turbine.UI.FontStyle.None);
		if (self.selected == true)then
			self.text:SetForeColor(Turbine.UI.Color(1,0.988,0.922,0.004));
		else
			self.text:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
		end
		
	end
 	self.Click = function(sender,args)
 	
 	end
 	
 	self.text.MouseDown=function(sender,args)
 		self.Click(sender,args);
 	end
 	
	self.setTextColor = function(colType)
		if (colType == 1)then
			self.text:SetForeColor(Turbine.UI.Color(1,0.988,0.922,0.004));
		else
			self.text:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
		end
	end
end