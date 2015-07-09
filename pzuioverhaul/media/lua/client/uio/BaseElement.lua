-- TODO These MUST go elsewhere TODO
-- These are hotfixes for missing functionality in Kahlua
if table.pack == nil then
	table.pack = function(...)
		return { n = select("#", ...), ... }
	end
end
if table.unpack == nil then
	table.unpack = function(t, i)
		i = i or 1;
		if t[i] then
			return t[i], unpack(t, i + 1)
		end
	end
end
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

	local textColor = UIVariables.Base.textColor;
	local borderColor = UIVariables.Base.borderColor;
	local backgroundColor = UIVariables.Base.backgroundColor;
	local backgroundColorMouseOver = UIVariables.Base.backgroundColor;

	local anchor = {r=false, l=false, t=false, b=false};
	local joyPadFocus = nil;
	local mouseOver = false;

	local MIN_X = -1;
	local MIN_Y = -1;
	local MAX_X = -1; --getCore():getScreenWidth();
	local MAX_Y = -1; --getCore():getScreenHeight();
	local MIN_H = 1;
	local MIN_W = 1;
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
	function self:drawText(text, x, y, color, font) -- {{{ draw text
		color = color or self:getTextColor();
		jObj:DrawText(font or UIFont.Small, text, x, y, color.r, color.g, color.b, color.a);
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
		if parent then return parent:onMouseDown(x + mX, y + mY) end
		return false;
	end
	-- }}}
	function self:onMouseUp(mX, mY) -- {{{
		if parent then return parent:onMouseUp(x + mX, y + mY) end
		return false;
	end
	-- }}}
	function self:onMouseMove(mX, mY) -- {{{
		mouseOver = true;
		if parent then return parent:onMouseMove(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseDown(mX, mY) -- {{{
		if parent then return parent:onRightMouseDown(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseUp(mX, mY) -- {{{
		if parent then return parent:onRightMouseUp(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onMouseWheel(mW) -- {{{
		if parent then return parent:onRightMouseWheel(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseUpOutside(mX, mY) -- {{{
		if parent then return parent:onRightMouseUpOutside(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onRightMouseDownOutside(mX, mY) -- {{{
		if parent then return parent:onRightMouseDownOutside(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onMouseUpOutside(mX, mY) -- {{{
		if parent then return parent:onMouseUpOutside(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onMouseDownOutside(mX, mY) -- {{{
		if parent then return parent:onMouseDownOutside(x + mX, y+ mY) end
		return false;
	end
	-- }}}
	function self:onMouseMoveOutside(mX, mY) -- {{{
		mouseOver = false;
		-- if parent then return parent:onMouseMoveOutside(x + mX, y+ mY) end
		return true;
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
	function self:setMinH(mh) -- {{{
		MIN_H = mh;
		if MIN_H > self:getHeight() then
			self:setHeight(MIN_H);
		end
	end
	-- }}}
	function self:setMinW(mw) -- {{{
		MIN_W = mw;
		if MIN_W > self:getWidth() then
			self:setWidth(MIN_W);
		end
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
	function self:resize(nW, nH, anchorLeft, anchorTop, anchorRight, anchorBottom) -- {{{
		local oX, oY, oW, oH = x, y, w, h;
		nW = math.max(MIN_W, nW);
		nH = math.max(MIN_H, nH);

		if (anchor.l or anchorLeft) and (anchor.r or anchorRight) then
			-- do nothing
		else
			if not (anchor.l or anchorLeft) and not (anchor.r or anchorRight) then
				jObj:setWidth(math.max(MIN_W, w * nW / oW));
				w = jObj:getWidth();
				jObj:setX(x * w / oW);
				x = jObj:getX();
			else
				if (anchor.l or anchorLeft) then
					jObj:setWidth(math.max(MIN_W, nW));
					w = nW;
				else
					if (anchor.r or anchorRight) then
						local oldParentWidth = self:getParent():getWidth();
						oldParentWidth = oldParentWidth / (nW / oW);
						local oldOffset = oldParentWidth - oX;
						self:setX(self:getParent():getWidth() - oldOffset);
					end
				end
			end
		end

		if (anchor.t or anchorTop) and (anchor.b or anchorBottom) then
			-- do nothing
		else
			if not (anchor.t or anchorTop) and not (anchor.b or anchorBottom) then
				jObj:setHeight(math.max(MIN_H, h * nH / oH));
				h = jObj:getHeight();
				jObj:setY(y * h / oH);
				y = jObj:getY();
			else
				if (anchor.t or anchorTop) then
					jObj:setHeight(math.max(MIN_H, nH));
					h = nH;
				else
					if (anchor.b or anchorBottom) then
						local oldParentHeight = self:getParent():getHeight();
						oldParentHeight = oldParentHeight / (nH / oH);
						local oldOffset = oldParentHeight - oY;
						self:setY(self:getParent():getHeight() - oldOffset);
					end
				end
			end
		end

		for _,o in pairs(children) do
			o:resize(o:getWidth() * (w / oW), o:getHeight() * (h / oH));
		end
	end
	-- }}}
	function self:setWidth(nw) -- {{{
		nw = math.max(nw, MIN_W);
		local oldWidth = w;
		w = nw;
		jObj:setWidth(w);
		self:setX(x);

		for _,o in pairs(children) do
			o:setWidth(o:getWidth() * w / oldWidth);
			o:setX(o:getX() * w / oldWidth);
		end
	end
	-- }}}
	function self:setHeight(nh) -- {{{
		nh = math.max(nh, MIN_H);
		local oldHeight = h;
		h = nh;
		jObj:setHeight(h);
		self:setY(y);

		for _,o in pairs(children) do
			o:setHeight(o:getHeight() * h / oldHeight);
			o:setY(o:getY() * h / oldHeight);
		end
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
	function self:setTextColorRGBA(r, g, b, a) -- {{{
		textColor.r = r;
		textColor.g = g;
		textColor.b = b;
		textColor.a = a;
	end
	-- }}}
	function self:setTextColor(c) -- {{{
		textColor.r = c.r;
		textColor.g = c.g;
		textColor.b = c.b;
		textColor.a = c.a;
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
	function self:setMouseOverBackgroundColorRGBA(r, g, b, a) -- {{{
		backgroundColorMouseOver.r = r;
		backgroundColorMouseOver.g = g;
		backgroundColorMouseOver.b = b;
		backgroundColorMouseOver.a = a;
	end
	-- }}}
	function self:setMouseOverBackgroundColor(c) -- {{{
		backgroundColorMouseOver.r = c.r;
		backgroundColorMouseOver.g = c.g;
		backgroundColorMouseOver.b = c.b;
		backgroundColorMouseOver.a = c.a;
	end
	-- }}}
	function self:setAnchorBottom(bAnchor) -- {{{
		anchor.b = bAnchor;
	end
	-- }}}
	function self:setAnchorTop(bAnchor) -- {{{
		anchor.t = bAnchor;
	end
	-- }}}
	function self:setAnchorLeft(bAnchor) -- {{{
		anchor.l = bAnchor;
	end
	-- }}}
	function self:setAnchorRight(bAnchor) -- {{{
		anchor.r = bAnchor;
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
	function self:getTextColor() -- {{{
		retVal = {}; -- make sure textColor stays private
		retVal.r = textColor.r;
		retVal.g = textColor.g;
		retVal.b = textColor.b;
		retVal.a = textColor.a;
		return retVal;
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
	function self:getMouseOverBackgroundColor() -- {{{
		retVal = {}; -- make sure backgroundColor stays private
		retVal.r = backgroundColorMouseOver.r;
		retVal.g = backgroundColorMouseOver.g;
		retVal.b = backgroundColorMouseOver.b;
		retVal.a = backgroundColorMouseOver.a;
		return retVal;
	end
	-- }}}
	function self:isMouseOver() -- {{{
		return mouseOver;
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
