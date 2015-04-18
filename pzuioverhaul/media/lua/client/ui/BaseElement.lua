local maxW = getCore():getScreenWidth();
local maxH = getCore():getScreenHeight();

BaseElement = {};

function BaseElement.new(x, y, w, h)
    local self = {};

    -- Clamp the position values so the UI can't be moved offscreen.
    x = math.max(0, math.min(x, maxW - w));
    y = math.max(0, math.min(y, maxH - h));

    -- Create a java instance.
    local jObj = UIElement.new(self);
    jObj:setX(x);
    jObj:setY(y);
    jObj:setWidth(w);
    jObj:setHeight(h);
    jObj:setAnchorLeft(false);
    jObj:setAnchorRight(false);
    jObj:setAnchorTop(false);
    jObj:setAnchorBottom(false);

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:addToUIManager()
        UIManager.AddUI(jObj);
    end

    function self:drawRectangle(mode, x, y, w, h, color)
        if mode == 'fill' then
            jObj:DrawTextureScaledColor(nil, x, y, w, h, color.r, color.g, color.b, color.a);
        elseif mode == 'line' then
            jObj:DrawTextureScaledColor(nil, x, y, w, 1, color.r, color.g, color.b, color.a);
            jObj:DrawTextureScaledColor(nil, x, y, 1, h, color.r, color.g, color.b, color.a);
            jObj:DrawTextureScaledColor(nil, x + w, y, 1, h, color.r, color.g, color.b, color.a);
            jObj:DrawTextureScaledColor(nil, x, y + h, w, 1, color.r, color.g, color.b, color.a);
        end
    end

    function self:setVisible(nv)
        jObj:setVisible(nv);
    end

    function self:toggle()
        jObj:setVisible(not jObj:isVisible());
    end

    return self;
end

return BaseElement;