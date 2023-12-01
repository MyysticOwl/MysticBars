-- Created by Digital_Utopia
-- Copied due to lack of fully functioning Checkbox in the current Beta API. 
-- Thanks Digital_Utopia!
--
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

import "Turbine.UI";
import "MyysticBars.Utils.Class";

CheckBox = class( Turbine.UI.Control );
function CheckBox:Constructor()
	Turbine.UI.Control.Constructor( self );
	self.checkBox = Turbine.UI.Control();
	self.checkBox:SetParent(self);
	self.checkBox:SetSize(16,16);
	self.checkBox:SetPosition(0,0);
	self.checkBox:SetZOrder(20);
	self.checkBox:SetBlendMode(7);
	self.IsChecked = false;
	self.checkStr="_empty";
	self.IsDisabled = false;
	self.disStr=""
	self.boxSize=2; 
	self:SetSize(250,16);
	self.title=Turbine.UI.Label();
	self.title:SetParent(self);
	self:SetBackColor(Turbine.UI.Color(.9,0,0,0));
	self.title:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	self.title:SetFontStyle(Turbine.UI.FontStyle.None );
	self.title:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
	self.title:SetText("Awesome Box");
	self.title:SetSize(230,16)
	self.title:SetPosition(17,0);
	self.title:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	
	function self:updateBG()
		self.bgStr = "MyysticBars/UI/Resources/checkbox_02";
		if(self.checkStr~=nil)then
			self.bgStr=self.bgStr..self.checkStr;
		end
		if(self.disStr~=nil)then
			self.bgStr=self.bgStr..self.disStr;
		end
		self.bgStr=self.bgStr..".tga";
		self.checkBox:SetBackground(self.bgStr);
	end
	self:updateBG();
	
	
	function self:SetDisabled(dis)
		if (dis==true)then
			self.IsDisabled=true;
			self.disStr="_ghosted";
			self:updateBG();
		else
			self.IsDisabled=false;
			self.disStr="";
			self:updateBG();
		end
	end
	
	function self:GetDisabled()
		return self.IsDisabled;
	end
	
	function self:SetChecked(chk)
		if (chk == true)then
	  		self.IsChecked = true
	  		self.checkStr="";
	  		self:updateBG();
	  	else
	  		self.IsChecked = false
	  		self.checkStr="_empty";
	  		self:updateBG();
	 	end
	end
	
	function self:SetText(text)
		self.title:SetText(text)
	end
	
	function self:GetText(text)
		return self.title:GetText();
	end
	function self:GetChecked()
		return self.IsChecked;
	end
	
	self.checkBox.MouseClick = function(sender,args)
	if(self.IsDisabled==false)then
		if(self.IsChecked==false)then
			self:SetChecked(true);
		else
			self:SetChecked(false);
		end
	end
	self:CheckedCallback();
end
self.MouseClick = self.checkBox.MouseClick;
self.title.MouseClick = self.checkBox.MouseClick;

end