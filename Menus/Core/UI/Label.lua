import "Turbine.UI";

Label = class(Turbine.UI.Label);

function Label:Constructor()
    Turbine.UI.Label.Constructor(self);

    self:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self:SetForeColor(control2LightColor);
    self:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
end

function Label:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    self:SetForeColor(enabled and control2LightColor or controlDisabledColor);
end
