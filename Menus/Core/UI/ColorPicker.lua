ColorPicker = class(Turbine.UI.Control)

function ColorPicker:Constructor()
	Turbine.UI.Control.Constructor(self);

	self:SetBackground("MysticBars/Menus/Core/Resources/picker.tga");
	self:SetVisible(true);
	self:SetZOrder(5);
end

function ColorPicker:GetColorFromCoord(X,Y)
	local blockXvalue = (math.floor(self:GetWidth()/3));
	local blockYvalue = (math.floor(self:GetHeight()/2));

	local curColor = Turbine.UI.Color();
	curColor.A = 1.0;
	local myX=X
	local myY=Y
	local curRed = 0;
	local curGreen = 0;
	local curBlue = 0;

	if (myX >= 0) and (myX < blockXvalue) then

		-- First color block = red to green
		curRed = 255-((255/blockXvalue)*myX);
		curGreen = (255/blockXvalue)*myX;
		curBlue = 0;

	elseif (myX >= blockXvalue) and (myX < (2*blockXvalue)) then

		-- Second color block = green to blue
		curRed = 0;
		curGreen = 255-((255/blockXvalue)*(myX - blockXvalue));
		curBlue = (255/blockXvalue)*(myX - blockXvalue);

	elseif (myX >= (2*blockXvalue)) then

		-- Third color block = blue to red
		curRed = (255/blockXvalue)*(myX - 2*blockXvalue);
		curGreen = 0;
		curBlue = 255-((255/blockXvalue)*(myX - 2*blockXvalue));

	end

	if myY <= blockYvalue then

		-- In the top block, so fade from black to full color
		curRed = curRed * (myY/blockYvalue);
		curGreen = curGreen * (myY/blockYvalue);
		curBlue = curBlue * (myY/blockYvalue);

	else

		-- In the bottom block, so fade from full color to white
		curRed = curRed + ((myY - blockYvalue) * ((255 - curRed)/(blockYvalue)));
		curGreen = curGreen + ((myY - blockYvalue) * ((255 - curGreen)/(blockYvalue)));
		curBlue = curBlue + ((myY - blockYvalue) * ((255 - curBlue)/(blockYvalue)));

	end

	curColor.A = 1;
	curColor.R = self:ValidColorRange((1/255) * curRed);
	curColor.G = self:ValidColorRange((1/255) * curGreen);
	curColor.B = self:ValidColorRange((1/255) * curBlue);
	return curColor;
end

function ColorPicker:MouseMove(args)
	if args.X <= self:GetWidth() then
		self.mColor = self:GetColorFromCoord(args.X, args.Y)
	end
end

function ColorPicker:MouseClick(args)
	self.colorString = self:GetColorFromCoord(args.X, args.Y)
	self:SetColors(self.colorString.A, self.colorString.R, self.colorString.G, self.colorString.B);

	if (args.Button == Turbine.UI.MouseButton.Left) then
		if (self.LeftClick ~= nil) then
			self:LeftClick()
		end
	end
end

function ColorPicker:SetColors(a, r, g, b)
	self.colRGB =
	{
	["A"] = math.floor(255*self:ValidColorRange(a));
	["R"] = math.floor(255*self:ValidColorRange(r));
	["G"] = math.floor(255*self:ValidColorRange(g));
	["B"] = math.floor(255*self:ValidColorRange(b));
	};

	self.colHex =
	{
	["A"] = self:DEC_HEX(math.floor(255*self:ValidColorRange(a)));
	["R"] = self:DEC_HEX(math.floor(255*self:ValidColorRange(r)));
	["G"] = self:DEC_HEX(math.floor(255*self:ValidColorRange(g)));
	["B"] = self:DEC_HEX(math.floor(255*self:ValidColorRange(b)));
	};

	self.colTurbine =
	{
	["A"] = self:ValidColorRange(a);
	["R"] = self:ValidColorRange(r);
	["G"] = self:ValidColorRange(g);
	["B"] = self:ValidColorRange(b);
	};
end

function ColorPicker:GetTurbineColor()
	return Turbine.UI.Color(self.colTurbine.R, self.colTurbine.G, self.colTurbine.B);
end

function ColorPicker:GetHexColor()
	return tostring(self.colHex.R .. self.colHex.G .. self.colHex.B);
end

function ColorPicker:GetRGBColor()
	return self.colRGB.R, self.colRGB.G, self.colRGB.B;
end

function ColorPicker:ValidColorRange(colorValue)
	if (colorValue < 0) then
		return 0;
	elseif (colorValue > 1) then
		return 1;
	else
		return colorValue;
	end
end

function ColorPicker:DEC_HEX(IN)
	local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
		if IN == 0 then return "00" end;
		while IN>0 do
		I=I+1
		IN,D=math.floor(IN/B),math.mod(IN,B)+1
		OUT=string.sub(K,D,D)..OUT
	end
	if string.len(OUT) == 1 then OUT = "0" .. OUT end;
	return OUT
end
