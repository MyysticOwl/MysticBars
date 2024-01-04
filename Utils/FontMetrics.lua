import "Turbine.UI";

FontMetrics = class(Turbine.UI.Window);

FontMetrics.precision = 0.5;
FontMetrics.todo = {}; -- text sizes to calculate

function FontMetrics.FastRound(num, idp)
    local mult = 10 ^ (idp or 0);
    return math.floor(num * mult + 0.5) / mult;
end

function FontMetrics.DetermineLength(text, font, maxWidth, callback, object)
    table.insert(FontMetrics.todo, {text=text, font=font, maxWidth=maxWidth, callback=callback, object=object});
    FontMetrics.instance:SetVisible(true);
    FontMetrics.instance:SetWantsUpdates(true);
end

function FontMetrics:Constructor()
    Turbine.UI.Window.Constructor(self);
    
    -- used for width calculations
    self.widthLabel = Turbine.UI.Label();
    self.widthLabel:SetParent(self);
    self.widthLabel:SetSize(25, 25);
    self.widthLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.widthLabel:SetMultiline(false);
    self.widthLabel:SetMarkupEnabled(true);

    self.widthScroll = Turbine.UI.Lotro.ScrollBar();
    self.widthScroll:SetParent(self);
    self.widthScroll:SetSize(60, 10);
    self.widthScroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.widthLabel:SetHorizontalScrollBar(self.widthScroll);
    
    -- hide off screen
    self:SetPosition(-100, -100);
    self:SetSize(50, 50);
end

function FontMetrics:Update(args)
    for i = 1, #FontMetrics.todo, 1 do
        local info = FontMetrics.todo[i];
        local maxWidth = info.maxWidth;
        
        self.widthLabel:SetFont(info.font);
        self.widthLabel:SetText(info.text);

        local size = maxWidth;
        local increment = maxWidth;
        local count = 0;
        local multiline = false;
        
        while true do
            self.widthLabel:SetWidth(size);
            if (not self.widthScroll:IsVisible()) then
                size = size - increment;
                increment = increment / 2;
            elseif (increment == maxWidth) then
                multiline = true;
                break;
            elseif (increment < 512) then
                increment = increment / 2;
            end
            size = size + increment;
            count = count + 1;
            
            if (increment < FontMetrics.precision or count > 20) then
                break;
            end
        end
        
        size = FontMetrics.FastRound(size + FontMetrics.precision);
        if (not multiline) then
            maxWidth = size;
        end
        
        local heightControl = Turbine.UI.Control();
        heightControl:SetParent(self);
        heightControl:SetSize(50, 50);
        
        local heightLabel = Turbine.UI.Label();
        heightLabel:SetParent(heightControl);
        heightLabel:SetSize(25, 25);
        heightLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
        heightLabel:SetMultiline(true);
        heightLabel:SetMarkupEnabled(true);
    
        local heightScroll = Turbine.UI.Lotro.ScrollBar();
        heightScroll:SetParent(heightControl);
        heightScroll:SetSize(10, 60);
        heightScroll:SetZOrder(100);
        heightScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
        heightLabel:SetVerticalScrollBar(heightScroll);

        heightLabel:SetFont(info.font);
        heightLabel:SetText(info.text);
        heightLabel:SetWidth(maxWidth);
        
        increment = 512;
        count = 0;
        size = 16; -- start small and work our way up until it fits
        
        local start = true;
        heightControl.Update = function(sender, args)
            if (start) then
                start = false;
                return;
            end

            if (not heightScroll:IsVisible()) then
                size = size - increment;
                increment = increment / 2;
            elseif (increment < 512) then
                increment = increment / 2;
            end
            size = size + increment;
            heightLabel:SetHeight(size);

            count = count + 1;
            if (increment < FontMetrics.precision or count > 20) then
                size = FontMetrics.FastRound(size + FontMetrics.precision);
                info.callback(info.object, maxWidth, size);

                heightControl:SetWantsUpdates(false);
                heightControl.Update = nil;
                heightControl:SetParent(nil);
            end
        end
        heightControl:SetWantsUpdates(true);
    end
    
    FontMetrics.todo = {};
    self:SetWantsUpdates(false);
end

-- instance used to calculate metrics
FontMetrics.instance = FontMetrics();
