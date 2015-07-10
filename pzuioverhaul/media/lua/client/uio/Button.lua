require 'uio/BaseElement'
require 'uio/UIVariables'

UIO.Button = {};

function UIO.Button.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local tw = 0;
	local th = 0;
	local text = "Foo";
	local onClick = nil;
	local arguments = nil;
	local isMouseDown = false;
	local backgroundColorMouseDown = UIVariables.Button.backgroundColorMouseDown;

	function self:prerender() -- {{{
		if onClick ~= nil then
			if self:isMouseOver() then
				if isMouseDown then
					self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), backgroundColorMouseDown);
				else
					self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), self:getMouseOverBackgroundColor());
				end
			else
				self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), self:getBackgroundColor());
			end
		end
		self:drawRectangle('line', 0, 0, self:getWidth(), self:getHeight(), self:getBorderColor());
	end
	-- }}}
	function self:render() -- {{{
		self:drawText(text, (self:getWidth() - tw) / 2, (self:getHeight() - th) / 2);
	end
	-- }}}

	function self:setText(nt) -- {{{
		text = nt;
		tw = getTextManager():MeasureStringX(UIFont.Small, text);
		th = getTextManager():MeasureStringY(UIFont.Small, text);
	end
	-- }}}
	function self:setOnClick(func, ...) -- {{{
		onClick = func;
		arguments = {};
		for i,v in pairs(table.pack(...)) do
			arguments[i] = v;
		end
	end
	-- }}}
	function self:onMouseUp(mX, mY) -- {{{
		local doCb = isMouseDown and self:isMouseOver();

		if doCb and onClick then
			isMouseDown = false;
			onClick(table.unpack(arguments));
			return true;
		end
		return false;
	end
	-- }}}
	function self:onMouseDown(mX, mY) -- {{{
		if onClick then
			isMouseDown = true;
			return true;
		end
		return false;
	end
	-- }}}
	function self:onMouseUpOutside(mX, mY) -- {{{
		if isMouseDown then
			isMouseDown = false;
			return true;
		end
		return false;
	end
	-- }}}

	self:setTextColor(UIVariables.Button.textColor);
	self:setBorderColor(UIVariables.Button.borderColor);
	self:setBackgroundColor(UIVariables.Button.backgroundColor);
	self:setMouseOverBackgroundColor(UIVariables.Button.backgroundColorMouseOver);

	return self;
end
