local MAX_X = getCore():getScreenWidth();
local MAX_Y = getCore():getScreenHeight();

UIO = {};
UIO.BaseElement = {};

function UIO.BaseElement.new(x, y, w, h)
    local self = {};
		local jObj = {};

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------
    local function clamp(min, val, max) -- {{{ clamp value to valid range
        return math.max(min, math.min(val, max));
    end
		-- }}}
    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------
    function self:addToUIManager() -- {{{ add element to UI
        UIManager.AddUI(jObj);
    end
		-- }}}
    function self:drawRectangle(mode, x, y, w, h, color) -- {{{ draw a rectangle, filled or line
        if mode == 'fill' then
            jObj:DrawTextureScaledColor(nil, x, y, w, h, color.r, color.g, color.b, color.a);
        elseif mode == 'line' then
            jObj:DrawTextureScaledColor(nil, x, y, w, 1, color.r, color.g, color.b, color.a);
            jObj:DrawTextureScaledColor(nil, x, y, 1, h, color.r, color.g, color.b, color.a);
            jObj:DrawTextureScaledColor(nil, x + w, y, 1, h, color.r, color.g, color.b, color.a);
            jObj:DrawTextureScaledColor(nil, x, y + h, w, 1, color.r, color.g, color.b, color.a);
        end
    end
		-- }}}
    function self:close() -- {{{ remove window from UI Manager
        self:setVisible(false);
        UIManager.RemoveElement(jObj);
    end
		-- }}}
    function self:toggle() -- {{{ toggle visibility
        self:setVisible(not jObj:isVisible());
    end
		-- }}}
    -- ------------------------------------------------
    -- Setters
    -- ------------------------------------------------
    function self:setVisible(nv) -- {{{ set visibility
        jObj:setVisible(nv);
    end
		-- }}}
    function self:setX(nx) -- {{{
        x = clamp(0, nx + w, MAX_X);
    end
		-- }}}
    function self:setY(ny) -- {{{
        y = clamp(0, ny + h, MAX_Y);
    end
		-- }}}
    function self:setPosition(nx, ny) -- {{{
        x = clamp(0, nx + w, MAX_X);
        y = clamp(0, ny + h, MAX_Y);
    end
		-- }}}
    -- ------------------------------------------------
    -- Getters
    -- ------------------------------------------------
    function self:isVisible() -- {{{
        return jObj:isVisible();
    end
		-- }}}
    function self:getX() -- {{{
        return x;
    end
		-- }}}
    function self:getY() -- {{{
        return y;
    end
		-- }}}
    function self:getPosition() -- {{{
        return x, y;
    end
		-- }}}

    -- Create a java instance.
    jObj = UIElement.new(self);
    -- Clamp the position values so the UI can't be moved offscreen.
    self:setPosition(x, y);

    jObj:setX(x);
    jObj:setY(y);
    jObj:setWidth(w);
    jObj:setHeight(h);
    jObj:setAnchorLeft(false);
    jObj:setAnchorRight(false);
    jObj:setAnchorTop(false);
    jObj:setAnchorBottom(false);

    return self;
end
