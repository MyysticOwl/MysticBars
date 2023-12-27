--[[ Fix this shit! Needs proper open()/close() functions, and supply a method to 
display listbox outside of class!]]--

import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "Turbine";
import "MyysticUI.Core.UI.DropDownBoxItem";
DropDownBox = class( Turbine.UI.Control );
function DropDownBox:Constructor(itemList)
	Turbine.UI.Control.Constructor( self);
	self.show = false;
	self.disabled = false;
	self.selectedIndex = 1;
	self.itemList=itemList;
  --self:SetPosition(0,0);
  self:SetSize(168,20);
  self.mainBox = Turbine.UI.Control();
  self.mainBox:SetParent(self);
  self.mainBox:SetSize(159,20);
  self.mainBox:SetBackColor(Turbine.UI.Color(0,0,0));
  self.mainBox:SetZOrder(20);
  self.text = Turbine.UI.Label();
	self.text:SetParent(self.mainBox);
	self.text:SetSize(self.mainBox:GetWidth(),self.mainBox:GetHeight());
	self.text:SetPosition(0,0);
	self.text:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	self.text:SetFontStyle(Turbine.UI.FontStyle.None );
	self.text:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
	self.text:SetText(self.itemList[self.selectedIndex]);
	self.text:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
 	self.text:SetZOrder(99);
  self.mb_ul = Turbine.UI.Control();
  self.mb_ul:SetParent(self.mainBox);
  self.mb_ul:SetPosition(0,0);
  self.mb_ul:SetSize(18,9);
  self.mb_ul:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ul.tga");
	self.mb_ml = Turbine.UI.Control();
  self.mb_ml:SetParent(self.mainBox);
  self.mb_ml:SetPosition(0,9);
  self.mb_ml:SetSize(18,1);
  self.mb_ml:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ml.tga");
	self.mb_ll = Turbine.UI.Control();
  self.mb_ll:SetParent(self.mainBox);
  self.mb_ll:SetPosition(0,10);
  self.mb_ll:SetSize(18,9);
  self.mb_ll:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ll.tga");
	self.mb_um = Turbine.UI.Control();
  self.mb_um:SetParent(self.mainBox);
  self.mb_um:SetPosition(18,0);
  self.mb_um:SetSize((self.mainBox:GetWidth()-36),9);
  self.mb_um:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_um.tga");
	self.mb_lm = Turbine.UI.Control();
  self.mb_lm:SetParent(self.mainBox);
  self.mb_lm:SetPosition(18,10);
  self.mb_lm:SetSize((self.mainBox:GetWidth()-36),10);
  self.mb_lm:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_lm.tga");
	self.mb_ur = Turbine.UI.Control();
  self.mb_ur:SetParent(self.mainBox);
  self.mb_ur:SetPosition((self.mainBox:GetWidth()-18),0);
  self.mb_ur:SetSize(18,9);
  self.mb_ur:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ur.tga");
	self.mb_mr = Turbine.UI.Control();
  self.mb_mr:SetParent(self.mainBox);
  self.mb_mr:SetPosition((self.mainBox:GetWidth()-18),9);
  self.mb_mr:SetSize(18,1);
  self.mb_mr:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_mr.tga");
	self.mb_lr = Turbine.UI.Control();
  self.mb_lr:SetParent(self.mainBox);
  self.mb_lr:SetPosition((self.mainBox:GetWidth()-18),10);
  self.mb_lr:SetSize(18,9);
  self.mb_lr:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_lr.tga");
	self.arrow = Turbine.UI.Control();
	self.arrow:SetParent(self.mainBox);
	self.arrow:SetPosition((self.mainBox:GetWidth()-16),3);
	self.arrow:SetSize(16,16);
	self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed.tga");
	self.arrow:SetBlendMode(4);
	self.listBox = Turbine.UI.Window();
	self.listBox:SetParent(self);
	self.listBox:SetWidth(169);
	self.listBox:SetPosition(0,21);
	self.listBox:SetZOrder(20);
	self.listBox:SetBackColor(Turbine.UI.Color(0,0,0));
	self.listBox:SetVisible( true );
	if (#self.itemList < 10)then
		self.listBox:SetHeight((#self.itemList*20)+8);
	else
		self.listBox:SetHeight(198);
	end
	self.listBox:SetVisible(false);
	self.listBox:SetBackColorBlendMode(0);
	self.lb_ul = Turbine.UI.Window();
  self.lb_ul:SetParent(self.listBox);
  self.lb_ul:SetPosition(0,0);
  self.lb_ul:SetSize(18,9);
  self.lb_ul:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ul.tga");
  self.lb_ul:SetVisible( true );
	self.lb_ml = Turbine.UI.Window();
  self.lb_ml:SetParent(self.listBox);
  self.lb_ml:SetPosition(0,9);
  self.lb_ml:SetSize(18,(self.listBox:GetHeight()-18));
  self.lb_ml:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ml.tga");
  self.lb_ml:SetVisible( true );
	self.lb_ll = Turbine.UI.Control();
  self.lb_ll:SetParent(self.listBox);
  self.lb_ll:SetPosition(0,(self.listBox:GetHeight()-9));
  self.lb_ll:SetSize(18,9);
  self.lb_ll:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ll.tga");
  self.lb_ll:SetBlendMode(4);
  self.lb_ll:SetVisible( true );
	self.lb_um = Turbine.UI.Window();
  self.lb_um:SetParent(self.listBox);
  self.lb_um:SetPosition(18,0);
  self.lb_um:SetSize((self.listBox:GetWidth()-36),9);
  self.lb_um:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_um.tga");
  self.lb_um:SetVisible( true );
	self.lb_lm = Turbine.UI.Window();
  self.lb_lm:SetParent(self.listBox);
  self.lb_lm:SetPosition(18,(self.listBox:GetHeight()-9));
  self.lb_lm:SetSize((self.listBox:GetWidth()-36),9);
	self.lb_lm:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_lm.tga");
	self.lb_lm:SetVisible( true );
	self.lb_ur = Turbine.UI.Control();
  self.lb_ur:SetParent(self.listBox);
  self.lb_ur:SetPosition((self.listBox:GetWidth()-18),0);
  self.lb_ur:SetSize(18,9);
  self.lb_ur:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_ur.tga");
  self.lb_ur:SetBlendMode(4);
	self.lb_mr = Turbine.UI.Window();
  self.lb_mr:SetParent(self.listBox);
  self.lb_mr:SetPosition((self.listBox:GetWidth()-18),9);
  self.lb_mr:SetSize(18,(self.listBox:GetHeight()-18));
  self.lb_mr:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_mr.tga");
  self.lb_mr:SetVisible( true );
	self.lb_lr = Turbine.UI.Control();
  self.lb_lr:SetParent(self.listBox);
  self.lb_lr:SetPosition((self.listBox:GetWidth()-18),(self.listBox:GetHeight()-9));
  self.lb_lr:SetSize(18,9);
  self.lb_lr:SetBlendMode(4);
  self.lb_lr:SetBackground("MyysticUI/Core/UI/Resources/ddbox_border_lr.tga");
	self.sb = Turbine.UI.Lotro.ScrollBar();
	self.sb:SetOrientation(Turbine.UI.Orientation.Vertical);
	self.sb:SetParent(self.listBox);
	self.sb:SetPosition(155,4);
	self.sb:SetSize(10,(self.listBox:GetHeight()-8));
	self.sb:SetZOrder(20);
	self.sp = Turbine.UI.ListBox();
	self.sp:SetParent(self.listBox);
	self.sp:SetSize((self.mainBox:GetWidth()-8),(self.listBox:GetHeight()-8));
	self.sp:SetPosition(4,4);
	self.sp:SetOrientation( Turbine.UI.Orientation.Horizontal );
	self.sp:SetMaxItemsPerLine(1);
	self.collection = {};	
		for i = 1, #self.itemList do
        local listItem = MyysticUI.Core.UI.DropDownBoxItem(self.itemList[i],(self.mainBox:GetWidth()-4));
        listItem:SetSize( self.sp:GetWidth(), 20 );
				self.sp:AddItem( listItem );
				self.collection[i]=listItem;
				self.collection[i].Click=function(sender,args)
					self.args = {}
					args["Name"]=self.itemList[i];
					args["Index"]=i;
					self.IndexChanged(self.sp,args);
					
					self.selectedIndex = i;
					self.update();
					self.listBox:SetVisible(false);
					self.show=false;
					self:SetHeight(20);
					self.mainBox.MouseLeave();
				end
      end
	self.Close=function()
				self.update();
				self.listBox:SetVisible(false);
				self.show=false;
				self:SetHeight(20);
				self.mainBox.MouseLeave();
	end

	self.sp:SetVerticalScrollBar(self.sb);

	if (self.disabled == true)then
		self.text:SetForeColor(Turbine.UI.Color(.749,.749,.749));
		self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed_ghosted.tga");
	end
	
	self.mainBox.MouseEnter =function(sender,args)
	
		if (self.disabled==false)then
			self.text:SetForeColor(Turbine.UI.Color(1,1,1));
			self.text:SetFontStyle(Turbine.UI.FontStyle.Outline );
			self.text:SetOutlineColor(Turbine.UI.Color(.69,.482,.015));
			if (self.show == false)then
				self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed_rollover.tga");
			else
				self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_open_rollover.tga");
			end
		end
	end

	self.Opening = function()
	
	end

	self.mainBox.MouseLeave =function(sender,args)
		if (self.disabled==false)then	
			self.text:SetFontStyle(Turbine.UI.FontStyle.None );
			
			if (self.show == false)then
				self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed.tga");
				self.text:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
			else
				self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_open.tga");
				self.text:SetForeColor(Turbine.UI.Color(1,0.988,0.922,0.004));
			end	
		end
	end
	

	
	self.text.MouseDown =function(sender,args)
		if (self.disabled==false)then
			if (self.show == false)then
				self.text:SetFontStyle(Turbine.UI.FontStyle.None );
				self.text:SetForeColor(Turbine.UI.Color(.475,.475,.475));
			else
			self.text:SetForeColor(Turbine.UI.Color(.827,.6,.165));
			self.text:SetFontStyle(Turbine.UI.FontStyle.Outline );
			self.text:SetOutlineColor(Turbine.UI.Color(1,1,1));
			end	
		end
	end
	
	self.text.MouseClick =function(sender,args)
		if (self.disabled==false)then
			self.text:SetForeColor(Turbine.UI.Color(1,1,1));
			self.text:SetFontStyle(Turbine.UI.FontStyle.Outline );
			self.text:SetOutlineColor(Turbine.UI.Color(.69,.482,.015));
			if (self.show == false)then
				self.show = true;
				self.update();
				self.listBox:SetVisible(true);
				self.Opening();
				self:SetHeight(self.listBox:GetHeight()+20);
				self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_open_rollover.tga");
			else
				self.show = false;
				self.listBox:SetVisible(false);
				self:SetHeight(20);
				self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed_rollover.tga");
			end	
		end
	end
	
	self.IndexChanged = function(sender,args)
	
	end
	
	self.SetIndex = function(index)
	self.selectedIndex = index;
	self.update(); 
	end
	
	self.GetIndex = function()
	
	return self.selectedIndex;
	end
	
	self.update = function()
		self.text:SetText(self.itemList[self.selectedIndex]);
		for i=1,#self.itemList do
			if (i == self.selectedIndex)then
				self.collection[i].setTextColor(1);
				self.collection[i].selected = true;
			else
				self.collection[i].setTextColor(0);
				self.collection[i].selected = false;
			end
		end
	end
	
	self.SetDisabled=function(bool)
		if(bool==false)then
			self.text:SetForeColor(Turbine.UI.Color(1,0.96,0.874,0.576));
			self.disabled=false;
			self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed.tga");
		else
			self.text:SetForeColor(Turbine.UI.Color(.749,.749,.749));
			self.arrow:SetBackground("MyysticUI/Core/UI/Resources/dropdown_arrow_closed_ghosted.tga");
			self.disabled=true;
			
		end
	end
	
end