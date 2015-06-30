
UIO = {};
UIO.maxID = -1;
UIO.BaseElement = {};

function UIO.BaseElement.new(px, py, pw, ph)
	local self = {};
	local jObj = {};
	local parent = nil;
	local children = {};
	local ID = UIO.maxID + 1;
	UIO.maxID = ID;

	local borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	local backgroundColor = {r=0.1, g=0.1, b=0.1, a=0.5};
	local joyPadFocus = nil;

	local MIN_X = -1;
	local MIN_Y = -1;
	local MAX_X = -1; --getCore():getScreenWidth();
	local MAX_Y = -1; --getCore():getScreenHeight();
	local x = px;
	local y = py;
	local w = pw;
	local h = ph;

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
	function self:drawTextCentered(text, x, y, color, font) -- {{{ draw text centered horizontally
		jObj:DrawTextCentre(font or UIFont.Small, text, x, y, color.r, color.g, color.b, color.a);
	end
	-- }}}
	function self:drawTexture(texture, x, y) -- {{{
		jObj:DrawTexture(texture, x, y, 1);
	end
	-- }}}
	function self:drawTextureTinted(texture, x, y, color) -- {{{
		jObj:DrawTextureColor(texture, x, y, color.r, color.g, color.b, color.a);
	end
	-- }}}
	function self:drawTextureScaled(texture, x, y, w, h) -- {{{
		jObj:DrawTextureScaled(texture, x, y, w, h, 1);
	end
	-- }}}
	function self:drawTextureScaledTinted(texture, x, y, w, h, color) -- {{{
		jObj:DrawTextureScaledColor(texture, x, y, w, h, color.r, color.g, color.b, color.a);
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
	function self:_addAsChildTo(o) -- {{{
		o:AddChild(jObj);
	end
	-- }}}
	function self:addChild(o) -- {{{
		children[o:getID()] = o;
		o:setParent(self);
		o:_addAsChildTo(jObj); -- required to keep objects private
	end
	-- }}}
	function self:onMouseDown(mX, mY) -- {{{
		if parent then return parent:onMouseDown(mX, mY) end
		return false;
	end
	-- }}}
	function self:onMouseUp(mX, mY) -- {{{
		if parent then return parent:onMouseUp(mX, mY) end
		return false;
	end
	-- }}}
	function self:onMouseMove(mX, mY) -- {{{
		if parent then return parent:onMouseMove(mX, mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseDown(mX, mY) -- {{{
		if parent then return parent:onRightMouseDown(mX, mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseUp(mX, mY) -- {{{
		if parent then return parent:onRightMouseUp(mX, mY) end
		return false;
	end
	-- }}}
	function self:onMouseWheel(mW) -- {{{
		if parent then return parent:onRightMouseWheel(mX, mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseUpOutside(mX, mY) -- {{{
		if parent then return parent:onRightMouseUpOutside(mX, mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseDownOutside(mX, mY) -- {{{
		if parent then return parent:onRightMouseDownOutside(mX, mY) end
		return false;
	end
	-- }}}
	function self:onMouseUpOutside(mX, mY) -- {{{
		if parent then return parent:onMouseUpOutside(mX, mY) end
		return false;
	end
	-- }}}
	function self:onMouseDownOutside(mX, mY) -- {{{
		if parent then return parent:onMouseDownOutside(mX, mY) end
		return false;
	end
	-- }}}
	function self:onMouseMoveOutside(mX, mY) -- {{{
		if parent then return parent:onMouseMoveOutside(mX, mY) end
		return false;
	end
	-- }}}
	-- ------------------------------------------------
	-- Joypad Functions -- TODO
	-- ------------------------------------------------
	function self:onLoseJoypadFocus(joypadData) -- {{{
		joyPadFocus = nil;
	end
	-- }}}
	function self:onGainJoypadFocus(joypadData) -- {{{
		joyPadFocus = joypadData;
	end
	-- }}}
	function self:onJoypadDown(button) -- {{{
	end
	-- }}}
	function self:onJoypadDirUp() -- {{{
	end
	-- }}}
	function self:onJoypadDirDown() -- {{{
	end
	-- }}}
	function self:onJoypadDirLeft() -- {{{
	end
	-- }}}
	function self:onJoypadDirRight() -- {{{
	end
	-- }}}
	-- ------------------------------------------------
	-- Setters
	-- ------------------------------------------------
	function self:setVisible(nv) -- {{{ set visibility
		jObj:setVisible(nv);
	end
	-- }}}
	function self:setMinX(mx) -- {{{
		MIN_X = mx;
	end
	-- }}}
	function self:setMaxX(mx) -- {{{
		MAX_X = mx;
	end
	-- }}}
	function self:setMinY(my) -- {{{
		MIN_Y = my;
	end
	-- }}}
	function self:setMaxY(my) -- {{{
		MAX_Y = my;
	end
	-- }}}
	function self:setX(nx) -- {{{
		if MIN_X > -1 and MAX_X > -1 then
			x = clamp(MIN_X, nx, MAX_X - w);
		else
			x = nx;
		end
		jObj:setX(x);
	end
	-- }}}
	function self:setY(ny) -- {{{
		if MIN_Y > -1 and MAX_Y > -1 then
			y = clamp(MIN_Y, ny, MAX_Y - h);
		else
			y = ny;
		end
		jObj:setY(y);
	end
	-- }}}
	function self:setWidth(nw) -- {{{
		w = nw;
		jObj:setWidth(w);
		self:setX(x);
	end
	-- }}}
	function self:setHeight(nh) -- {{{
		h = nh;
		jObj:setHeight(h);
		self:setY(y);
	end
	-- }}}
	function self:setPosition(nx, ny) -- {{{
		self:setX(nx);
		self:setY(ny);
	end
	-- }}}
	function self:setParent(o) -- {{{
		parent = o;
	end
	-- }}}
	function self:setBorderColorRGBA(r, g, b, a) -- {{{
		borderColor.r = r;
		borderColor.g = g;
		borderColor.b = b;
		borderColor.a = a;
	end
	-- }}}
	function self:setBorderColor(c) -- {{{
		borderColor.r = c.r;
		borderColor.g = c.g;
		borderColor.b = c.b;
		borderColor.a = c.a;
	end
	-- }}}
	function self:setBackgroundColorRGBA(r, g, b, a) -- {{{
		backgroundColor.r = r;
		backgroundColor.g = g;
		backgroundColor.b = b;
		backgroundColor.a = a;
	end
	-- }}}
	function self:setBackgroundColor(c) -- {{{
		backgroundColor.r = c.r;
		backgroundColor.g = c.g;
		backgroundColor.b = c.b;
		backgroundColor.a = c.a;
	end
	-- }}}
	-- ------------------------------------------------
	-- Getters
	-- ------------------------------------------------
	function self:isVisible() -- {{{
		return jObj:isVisible();
	end
	-- }}}
	function self:getID() -- {{{
		return ID;
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
	function self:getWidth() -- {{{
		return w;
	end
	-- }}}
	function self:getHeight() -- {{{
		return h;
	end
	-- }}}
	function self:getPosition() -- {{{
		return x, y;
	end
	-- }}}
	function self:getParent() -- {{{
		return parent;
	end
	-- }}}
	function self:getBorderColor() -- {{{
		retVal = {}; -- make sure borderColor stays private
		retVal.r = borderColor.r;
		retVal.g = borderColor.g;
		retVal.b = borderColor.b;
		retVal.a = borderColor.a;
		return retVal;
	end
	-- }}}
	function self:getBackgroundColor() -- {{{
		retVal = {}; -- make sure backgroundColor stays private
		retVal.r = backgroundColor.r;
		retVal.g = backgroundColor.g;
		retVal.b = backgroundColor.b;
		retVal.a = backgroundColor.a;
		return retVal;
	end
	-- }}}

	-- Create a java instance.
	jObj = UIElement.new(self);
	-- Clamp the position values so the UI can't be moved offscreen.
	self:setPosition(x, y); -- also sets it on jObj
	self:setWidth(w);
	self:setHeight(h);

	jObj:setAnchorLeft(false);
	jObj:setAnchorRight(false);
	jObj:setAnchorTop(false);
	jObj:setAnchorBottom(false);

	return self;
end
