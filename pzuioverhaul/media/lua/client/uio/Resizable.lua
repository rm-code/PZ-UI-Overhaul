require 'uio/BaseElement'

UIO.Resizable = {};

function UIO.Resizable.new(x, y, w, h)
	local isDragging = false;
	local dragStart = { x = 0, y = 0 };
	local self = UIO.BaseElement.new(x, y, w, h);
	local titleBarBackground = getTexture("media/ui/Panel_TitleBar.png");
	local resizeImage = getTexture("media/ui/Panel_StatusBar_Resize.png");

	function self:onMouseDown(mX, mY) -- {{{
		local parent = self:getParent();
		if not parent then return false end
		isDragging = true;
		dragStart = { x = getMouseX(), y = getMouseY() };
		return true;
	end
	-- }}}
	function self:onMouseUp(mX, mY) -- {{{
		isDragging = false;
		return true;
	end
	-- }}}
	function self:onMouseUpOutside(mX, mY) -- {{{
		isDragging = false;
		return true;
	end
	-- }}}
	function self:onMouseMove(mX, mY) -- {{{
		local parent = self:getParent();
		if not parent then return false end
		mX = getMouseX();
		mY = getMouseY();
		if not isDragging then return parent:onMouseMove(mX, mY) end

		parent:resize(parent:getWidth() + (mX - dragStart.x), parent:getHeight() + (mY - dragStart.y), true, true, false, false);
		dragStart.x = mX;
		dragStart.y = mY;
	end
	-- }}}
	function self:onMouseMoveOutside(mX, mY) -- {{{
		local parent = self:getParent();
		if not parent then return false end
		mX = getMouseX();
		mY = getMouseY();
		if not isDragging then return parent:onMouseMoveOutside(mX, mY) end

		parent:resize(parent:getWidth() + (mX - dragStart.x), parent:getHeight() + (mY - dragStart.y), true, true, false, false);
		dragStart.x = mX;
		dragStart.y = mY;
	end
	-- }}}

	function self:prerender() -- {{{
		self:drawRectangle("fill", 0, 0, self:getWidth(), self:getHeight(), self:getBackgroundColor());
		self:drawTextureScaled(titleBarBackground, 1, 1, self:getWidth() - 1, self:getHeight() - 2);
		self:drawTextureScaled(resizeImage, self:getWidth()-9, self:getHeight()-9, 8, 8);
		self:drawRectangle("line", 0, 0, self:getWidth(), self:getHeight(), self:getBorderColor());
	end
	-- }}}

	self:setAnchorBottom(true);
	return self;
end
