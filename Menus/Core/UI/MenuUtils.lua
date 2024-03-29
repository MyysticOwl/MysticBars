-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

MenuUtils = class( Turbine.Object );

MenuUtils.list = { };
MenuUtils.index = 1;

local bgColor = Turbine.UI.Color(1,0.0,0.0,0.0);
unselectedColor = Turbine.UI.Color( 0.0, 0.0, 0.0 );
unselectedColor.A = 1.0;

MenuUtils.TRANSPARENT = Turbine.UI.Color(0,0,0,0); -- ARGB
MenuUtils.WHITE = Turbine.UI.Color(1,1,1);
MenuUtils.BLACK = Turbine.UI.Color(0,0,0);
MenuUtils.GREEN = Turbine.UI.Color(0.87,0.22,0.47,0.31);
MenuUtils.HDBLUE = Turbine.UI.Color(19/255,28/255,47/255);
MenuUtils.HDBLUELT = Turbine.UI.Color(70/255,78/255,97/255);
MenuUtils.YELLOW = Turbine.UI.Color(1,1,0);
MenuUtils.YELLOW2 = Turbine.UI.Color(184/255,151/255,53/255);
MenuUtils.RED = Turbine.UI.Color(0.42,0.24,0.24);
MenuUtils.GREY = Turbine.UI.Color(0.1,0.1,0.1);
MenuUtils.GREY2 = Turbine.UI.Color(0.5,0.5,0.5);
MenuUtils.GREY3 = Turbine.UI.Color(0.3,0.3,0.3);
MenuUtils.GREY4 = Turbine.UI.Color(0.8,0.8,0.8);
MenuUtils.TEAL = Turbine.UI.Color(60/255,227/255,220/255);
MenuUtils.BEIGE = Turbine.UI.Color(191/255,194/255,151/255);
MenuUtils.PURPLE = Turbine.UI.Color(200/255,46/255,200/255);
MenuUtils.LIGHTGREY = Turbine.UI.Color(0.3,0.3,0.3);
MenuUtils.ORANGE = Turbine.UI.Color(247/255,148/255,29/255);
MenuUtils.INGSUBCOLOR = Turbine.UI.Color.GreenYellow;
MenuUtils.MIDALIGN = Turbine.UI.ContentAlignment.MiddleCenter;
MenuUtils.RIGHTALIGN = Turbine.UI.ContentAlignment.MiddleRight;
MenuUtils.LEFTALIGN = Turbine.UI.ContentAlignment.MiddleLeft;
MenuUtils.TOPLEFT = Turbine.UI.ContentAlignment.TopLeft;
MenuUtils.BOTTOMLEFT = Turbine.UI.ContentAlignment.BottomLeft;

MenuUtils.BLEND_ALPHA = Turbine.UI.BlendMode.AlphaBlend;
MenuUtils.BLEND_COLOR = Turbine.UI.BlendMode.Color;
MenuUtils.BLEND_GRAYSCALE = Turbine.UI.BlendMode.Grayscale;
MenuUtils.BLEND_MULTIPLY = Turbine.UI.BlendMode.Multiply;
MenuUtils.BLEND_NONE = Turbine.UI.BlendMode.None;
MenuUtils.BLEND_NORMAL = Turbine.UI.BlendMode.Normal;
MenuUtils.BLEND_OVERLAY = Turbine.UI.BlendMode.Overlay;
MenuUtils.BLEND_SCREEN = Turbine.UI.BlendMode.Screen;

MenuUtils.TrajanPro18 = Turbine.UI.Lotro.Font.TrajanPro18;
MenuUtils.TrajanPro16 = Turbine.UI.Lotro.Font.TrajanPro16;
MenuUtils.TrajanPro15 = Turbine.UI.Lotro.Font.TrajanPro15;
MenuUtils.TrajanPro14 = Turbine.UI.Lotro.Font.TrajanPro14;
MenuUtils.TrajanPro13 = Turbine.UI.Lotro.Font.TrajanPro13;
MenuUtils.Verdana12 = Turbine.UI.Lotro.Font.Verdana12;
MenuUtils.Verdana14 = Turbine.UI.Lotro.Font.Verdana14;
MenuUtils.Verdana16 = Turbine.UI.Lotro.Font.Verdana16;
MenuUtils.Arial12 = Turbine.UI.Lotro.Font.Arial12;

RESOURCEDIR = "MysticBars/Menus/Core/Resources/"

MenuUtils.ICONEXPANDALL = 0x4100027B;-- 16x16
MenuUtils.ICONEXPANDALLOVER = 0x4100027C;-- 16x16
MenuUtils.ICONCOLLAPSEALL = 0x4100027E;-- 16x16
MenuUtils.ICONCOLLAPSEALLOVER = 0x4100027F;-- 16x16
MenuUtils.ICONEXPAND = Turbine.UI.Graphic(RESOURCEDIR .. "expand_button.tga"); -- 16x16
MenuUtils.ICONCOLLAPSE = Turbine.UI.Graphic(RESOURCEDIR .. "collapse_button.tga");-- 16x16
MenuUtils.ICONCHECKED = Turbine.UI.Graphic(RESOURCEDIR .. "checkbox_02.tga"); -- 16x16
MenuUtils.ICONCHECKEDEMPTY = Turbine.UI.Graphic(RESOURCEDIR .. "checkbox_02_empty.tga");-- 16x16


function MenuUtils:AddTextBox( parentBox, text, x, y, thebgcolor, left, top )
	local tb = Turbine.UI.Lotro.TextBox();
	tb:SetParent( parentBox );
	tb:SetText( text );
	-- tb:SetFont( 1 );
	tb:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	tb:SetFontStyle(Turbine.UI.FontStyle.Outline);
	tb:SetBackColor( unselectedColor );
	tb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	tb:SetSize( x, y );
	tb:SetPosition( left, top );
	if ( thebgcolor == nil ) then
		tb:SetBackColor( bgColor );
	else
		tb:SetBackColor( thebgcolor );
	end

	return tb;
end

function MenuUtils:AddLabelBox( parentBox, text, x, y, thebgcolor, left, top )
	local lb = Turbine.UI.Label();
	lb:SetParent( parentBox );
	lb:SetText( text );
	lb:SetBackColor( unselectedColor );
	lb:SetTextAlignment( Turbine.UI.ContentAlignment.UpperLeft );
	lb:SetSize( x, y );
	lb:SetPosition( left, top );

	lb:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	lb:SetFontStyle(Turbine.UI.FontStyle.None );
	lb:SetForeColor(Turbine.UI.Color(0.8,0.86,0.77,0.37));

	if ( thebgcolor == nil ) then
		lb:SetBackColor( bgColor );
	else
		lb:SetBackColor( thebgcolor );
	end

	return lb;
end

function MenuUtils:AddButton( parentBox, text, w, h, mouseClick, left, top )
	local button = Turbine.UI.Lotro.Button();
	button:SetParent(parentBox);
	button:SetText( text );
	button:SetSize( w, h );
	button:SetPosition( left, top );
	button.MouseClick = mouseClick;

	return button;
end

function MenuUtils:AddComboBox( parentBox, visibleOptions, x, y, left, top )
	local combo = MysticBars.Menus.Core.UI.ComboBox();
	combo:SetSize( x, y );
	combo:SetPosition(left, top);
	combo:SetParent( parentBox );
	combo:SetNumberOfVisibleOptions(visibleOptions);

	return combo;
end

function MenuUtils:AddCheckedComboBox( parentBox, visibleOptions, x, y, left, top )
	local combo = MysticBars.Menus.Core.UI.CheckedComboBox();
	combo:SetSize( x, y );
	combo:SetPosition(left, top);
	combo:SetParent( parentBox );
	combo:SetNumberOfVisibleOptions(visibleOptions);

	return combo;
end

function MenuUtils:AddCategoryBox( parentBox, text, thebgcolor )
	local lb = Turbine.UI.Label();
	lb:SetParent( parentBox );
	lb:SetText( text );
	lb:SetSize( 365, 30 );
	lb:SetPosition( 50, 20 );

	lb:SetFont(Turbine.UI.Lotro.Font.TrajanProBold22);
	lb:SetFontStyle(Turbine.UI.FontStyle.Outline );
	lb:SetForeColor(Turbine.UI.Color(220/255, 220/255, 220/255));-- R:217 G:158 B:0 0.85, 0.51, 0  -- 220/255, 124/255, 101/255
	lb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	lb:SetOutlineColor(Turbine.UI.Color(0.75, 0, 0, 0));
	lb:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	lb:SetBackColorBlendMode( Turbine.UI.BlendMode.Overlay );
	lb:SetBackColor(self.GREEN);

	return lb;
end

function MenuUtils:AddItem(node)
	-- self.list[self.index] = node;
	-- self.index = self.index + 1;
end

function MenuUtils:AddCheckBox( parentBox, text, x, y, thebgcolor, left, top )
	local cb = Turbine.UI.Lotro.CheckBox();
	cb:SetParent( parentBox );
	cb:SetText( text );
	cb:SetForeColor(Slider.ItemColor);
    cb:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
	cb:SetBackColor( unselectedColor );
	cb:SetSize( x + 3, y + 10 );
	cb:SetPosition(left, top);

	if ( thebgcolor == nil ) then
		cb:SetBackColor( bgColor );
	else
		cb:SetBackColor( thebgcolor );
	end

	return cb;
end


function MenuUtils:AddColorPicker( parentBox, text, left, top )
	local colorCheckBox  = self:AddCheckBox( parentBox, text, selectionWidth + 150, selectionHeight, nil, 5, top );

	local color = MysticBars.Menus.Core.UI.ColorPicker()
	color:SetParent(parentBox);
	color:SetSize(200, 32);
	color:SetPosition(left, top);

	local colorPreviewBorder = Turbine.UI.Control();
	colorPreviewBorder:SetParent(parentBox);
	colorPreviewBorder:SetSize(25,25);
	colorPreviewBorder:SetPosition(left + 219, top - 1);
	colorPreviewBorder:SetBackColor(Turbine.UI.Color(0.5, 0.5, 0));

	local colorPreview = Turbine.UI.Control();
	colorPreview:SetParent(parentBox);
	colorPreview:SetSize(23,23);
	colorPreview:SetPosition(left + 220, top);

	local opacity = self:AddScrollBar( parentBox, 1, 0, 100, 200, selectionHeight + 20, nil, L["Opacity:"], left + 260, top, 25 );

	return colorCheckBox, color, colorPreview, colorPreviewBorder, opacity;
end

function MenuUtils:CreateCheckBoxCallback( control, barId, commandTable, callbackFunction )
	control.CheckedChanged = function( sender, args )
				SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(barId, function(barSettings)
			if ( control:IsChecked() == true ) then
				self:BuildItemFromCommandTable( barSettings, commandTable, true );
			else
				self:BuildItemFromCommandTable( barSettings, commandTable, nil );
			end
			return barSettings;
		end, function()
			if ( callbackFunction ~= nil ) then
				callbackFunction();
			end
		end);
	end
end

function MenuUtils:AddScrollBar( parentBox, value, minVal, maxVal, x, y, thebgcolor, text, left, top, valueLabelLeft )
	local sb = MysticBars.Menus.Core.UI.Slider();
	sb:SetParent( parentBox );
	sb:SetSize( x, y );
	sb:SetPosition(left, top);
	sb:SetValueLabelLeft(valueLabelLeft);
	sb:SetText(text);
	sb:SetValue( value );
	sb:SetMin( minVal ); -- SetMinimum
	sb:SetMax( maxVal ); -- SetMaximum
	sb:SetStep( 1 ); -- SetSmallChange & SetLargeChange
	if ( thebgcolor == nil ) then
		sb:SetBackColor( bgColor );
	else
		sb:SetBackColor( thebgcolor );
	end

	return sb;
end

function MenuUtils:CreateScrollBarCallback( control, barId, commandTable, add, divide, callbackFunction )
	control.ValueChanged = function( sender, args )
				SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(barId, function(barSettings)
			if ( add ~= nil ) then
				self:BuildItemFromCommandTable( barSettings, commandTable, control:GetValue() + add );
			elseif ( divide ~= nil ) then
				self:BuildItemFromCommandTable( barSettings, commandTable, control:GetValue() / divide );
			else
				self:BuildItemFromCommandTable( barSettings, commandTable, control:GetValue() );
			end
			return barSettings;
		end, function()
			if ( callbackFunction ~= nil ) then
				callbackFunction();
			end
		end);
	end
end

function MenuUtils:BuildItemFromCommandTable( obj, commandTable, value )
	for key=1, #commandTable, 1 do
		if ( key == #commandTable ) then
			obj[commandTable[key]] = value;
		else
			if ( obj[commandTable[key]] == nil ) then
				obj[commandTable[key]] = { };
			end
			obj = obj[commandTable[key]];
		end
	end
end

function _G.opairs( t, sort )
	local sortedKeys = { };
	local index = 1;

	local key;

	-- Generate a temp table of keys.
	for key in pairs( t ) do
		sortedKeys[index] = key;
		index = index + 1;
	end

	local sorter = sort or function( a, b )
		return a < b
	end;

	-- Sort the keys.
	table.sort( sortedKeys, sorter );

	local current = 0;

	-- Return an iterator that will step over the sorted
	-- keys and return the key and value.
	return function()
		current = current + 1;
		if ( current < index ) then
			local key = sortedKeys[current];
			return key, t[key];
		end
	end
end
