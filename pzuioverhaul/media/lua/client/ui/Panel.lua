require('ui.BaseElement');

Panel = {};

function Panel.new(x, y, w, h)
    local self = BaseElement.new(x, y, w, h);

    local bgColor = { r = 0.1, g = 0.1, b = 0.1, a = 0.5 };
    local borderColor = { r = 0.4, g = 0.4, b = 0.4, a = 0.8 };

    function self:prerender()
        self:drawRectangle('fill', x, y, w, h, bgColor);
        self:drawRectangle('line', x, y, w, h, borderColor);
    end

    return self;
end

return Panel;