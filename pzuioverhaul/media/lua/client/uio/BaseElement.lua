local MAX_X = getCore():getScreenWidth();
local MAX_Y = getCore():getScreenHeight();
local maxID = -1;

UIO = {};
UIO.BaseElement = {};

function UIO.BaseElement.new(px, py, pw, ph)
	local self = {};
	local jObj = {};
	local parent = nil;
	local child = nil;
	local children = {};
	local ID = maxID + 1;
	maxID = ID;
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
		child = o;
		child:setParent(self);
		child:_addAsChildTo(jObj); -- required to keep objects private
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
	-- Setters
	-- ------------------------------------------------
	function self:setVisible(nv) -- {{{ set visibility
		jObj:setVisible(nv);
	end
	-- }}}
	function self:setX(nx) -- {{{
		x = clamp(0, nx, MAX_X - w);
		jObj:setX(x);
	end
	-- }}}
	function self:setY(ny) -- {{{
		y = clamp(0, ny, MAX_Y - h);
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
		self:setY(h);
	end
	-- }}}
	function self:setPosition(nx, ny) -- {{{
		x = clamp(0, nx, MAX_X - w);
		jObj:setX(x);
		y = clamp(0, ny, MAX_Y - h);
		jObj:setY(y);
	end
	-- }}}
	function self:setParent(o) -- {{{
		parent = o;
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
