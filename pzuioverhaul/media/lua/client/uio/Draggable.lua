require 'uio/BaseElement'

UIO.Draggable = {};

function UIO.Draggable.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local isDragging = false;
	local dragStart = { x = 0, y = 0 };

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
	function self:onMouseMove(mX, mY) -- {{{
		local parent = self:getParent();
		if not parent then return false end
		mX = getMouseX();
		mY = getMouseY();
		if not isDragging then return parent:onMouseMove(mX, mY) end

		parent:setPosition(parent:getX() + (mX - dragStart.x), parent:getY() + (mY - dragStart.y));
		dragStart.x = mX;
		dragStart.y = mY;
	end
	-- }}}
	function self:onMouseUpOutside(mX, mY) -- {{{
		local parent = self:getParent();
		if not parent then return false end
		if isDragging then
			isDragging = false;
			return true;
		end
		return parent:onMouseUpOutside(mX, mY);
	end
	-- }}}
	function self:onMouseMoveOutside(mX, mY) -- {{{
		local parent = self:getParent();
		if not parent then return false end
		mX = getMouseX();
		mY = getMouseY();
		if not isDragging then return parent:onMouseMoveOutside(mX, mY) end

		parent:setPosition(parent:getX() + (mX - dragStart.x), parent:getY() + (mY - dragStart.y));
		dragStart.x = mX;
		dragStart.y = mY;
	end
	-- }}}

	return self;
end
