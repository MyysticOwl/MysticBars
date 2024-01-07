
Tooltip = class(Turbine.UI.Window);

function Tooltip:Constructor(control, text)
    Turbine.UI.Window.Constructor(self);
    self:SetMouseVisible(false);
    self:SetVisible(false);
    self:SetZOrder(10);
    
    -- center
    self.center = Turbine.UI.Control();
    self.center:SetParent(self);
    self.center:SetBackColor(dialogBackgroundColor);

    -- label
    self.label = MysticBars.Menus.Core.UI.Label();
    self.label:SetParent(self);
    self.label:SetMultiline(true);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.label:SetBackColor(dialogBackgroundColor);

    -- top left corner
    self.topLeft = Turbine.UI.Control();
    self.topLeft:SetParent(self);
    self.topLeft:SetSize(19, 19);
    self.topLeft:SetMouseVisible(false);
    self.topLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.topLeft:SetBackground(tooltipTopLeft);

    -- topRight
    self.topRight = Turbine.UI.Control();
    self.topRight:SetParent(self);
    self.topRight:SetSize(19, 19);
    self.topRight:SetMouseVisible(false);
    self.topRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.topRight:SetBackground(tooltipTopRight);
    
    -- bottomLeft
    self.bottomLeft = Turbine.UI.Control();
    self.bottomLeft:SetParent(self);
    self.bottomLeft:SetSize(19, 19);
    self.bottomLeft:SetMouseVisible(false);
    self.bottomLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottomLeft:SetBackground(tooltipBottomLeft);

    -- bottomRight
    self.bottomRight = Turbine.UI.Control();
    self.bottomRight:SetParent(self);
    self.bottomRight:SetSize(19, 19);
    self.bottomRight:SetMouseVisible(false);
    self.bottomRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottomRight:SetBackground(tooltipBottomRight);

    -- top side
    self.top = Turbine.UI.Control();
    self.top:SetParent(self);
    self.top:SetSize(0, 3);
    self.top:SetMouseVisible(false);
    self.top:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.top:SetBackground(tooltipMidTop);

    -- left side
    self.left = Turbine.UI.Control();
    self.left:SetParent(self);
    self.left:SetSize(3, 0);
    self.left:SetMouseVisible(false);
    self.left:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.left:SetBackground(tooltipMidLeft);

    -- right side
    self.right = Turbine.UI.Control();
    self.right:SetParent(self);
    self.right:SetSize(3, 0);
    self.right:SetMouseVisible(false);
    self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.right:SetBackground(tooltipMidRight);
    
    -- bottom side
    self.bottom = Turbine.UI.Control();
    self.bottom:SetParent(self);
    self.bottom:SetSize(0, 3);
    self.bottom:SetMouseVisible(false);
    self.bottom:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottom:SetBackground(tooltipMidBottom);
    
    -- initialize it
    if (text ~= nil) then
        self:SetText(text);
    end
    if (control ~= nil) then
        self:SetControl(control);
    end
end

function Tooltip:SetText(text)
    self.label:SetText(text);
    MysticBars.Utils.FontMetrics.DetermineLength(text, Turbine.UI.Lotro.Font.TrajanPro16, 480, Tooltip.Layout, self);
end

function Tooltip:SetControl(control)
    self.control = control;
    self.control.MouseHover = function(sender, args)
        if (self:IsVisible()) then
            return;
        end
        
        local x, y = Turbine.UI.Display.GetMousePosition();
        x = x + 32;
        y = y + 32;
        x, y = self:ValidatePosition(x, y, self:GetSize());
        self:SetPosition(x, y);
        self:SetVisible(true);
    end;
    
    self.control.MouseLeave = function(sender, args)
        self:SetVisible(false);
    end;
end

function Tooltip:Layout(width, height)
    self:SetSize(width + 14, height + 6);
end

function Tooltip:SetSize(width, height)
    -- turbine default tooltips are 480 in size
    width = math.max(width, 38);
    height = math.max(height, 22);

    Turbine.UI.Window.SetSize(self, width, height);
end

function Tooltip:SizeChanged(args)
    local width, height = self:GetSize();
    
    -- special case to prevent the shadows on the corners from overlapping
    if (height < 38) then
        self.topLeft:SetPosition(0, 0);
        self.top:SetPosition(19, 0);
        self.topRight:SetPosition(width - 19, 0);
        self.bottom:SetPosition(1, height - 3);
        self.left:SetPosition(0, 19);
        self.right:SetPosition(width - 3, 19);
        self.center:SetPosition(3, 3);
        self.label:SetPosition(7, 3);
        
        self.top:SetWidth(width - 38);
        self.bottom:SetWidth(width - 2);
        self.left:SetHeight(height - 22);
        self.right:SetHeight(height - 22);
        self.center:SetSize(width - 6, height - 6);
        self.label:SetSize(width - 14, height - 6);
        self.bottomLeft:SetSize(0, 0);
        self.bottomRight:SetSize(0, 0);
    else
        self.topLeft:SetPosition(0, 0);
        self.top:SetPosition(19, 0);
        self.topRight:SetPosition(width - 19, 0);
        self.bottomLeft:SetPosition(0, height - 19);
        self.bottom:SetPosition(19, height - 3);
        self.bottomRight:SetPosition(width - 19, height - 19);
        self.left:SetPosition(0, 19);
        self.right:SetPosition(width - 3, 19);
        self.center:SetPosition(3, 3);
        self.label:SetPosition(7, 3);
        
        self.top:SetWidth(width - 38);
        self.bottom:SetWidth(width - 38);
        self.left:SetHeight(height - 38);
        self.right:SetHeight(height - 38);
        self.center:SetSize(width - 6, height - 6);
        self.label:SetSize(width - 14, height - 6);
    end
end

function Tooltip:ValidatePosition(x, y, width, height)
    x = math.min(math.max(x, 0), Turbine.UI.Display:GetWidth() - width);
    y = math.min(math.max(y, 0), Turbine.UI.Display:GetHeight() - height);
    return x, y;
end
