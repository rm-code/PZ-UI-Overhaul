require 'uio/BaseElement'
require 'uio/UIVariables'

UIO.Button = {};

function UIO.Button.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local textColor = UIVariables.Button.textColor;
	local borderColor = UIVariables.Button.borderColor;
	local backgroundColor = UIVariables.Button.backgroundColor;
	local backgroundColorMouseDown = UIVariables.Button.backgroundColorMouseDown;
	local backgroundColorMouseOver = UIVariables.Button.backgroundColorMouseOver;

	local tw = 0;
	local th = 0;
	local text = "Foo";
	local onClick = nil;
	local arguments = nil;
	local isMouseDown = false;

	function self:prerender() -- {{{
		if self:isMouseOver() then
			if isMouseDown then
				self:drawRectangle('fill', 0, 0, w, h, backgroundColorMouseDown);
			else
				self:drawRectangle('fill', 0, 0, w, h, backgroundColorMouseOver);
			end
		else
			self:drawRectangle('fill', 0, 0, w, h, backgroundColor);
		end
		self:drawRectangle('line', 0, 0, w, h, borderColor);
	end
	-- }}}
	function self:render() -- {{{
		self:drawText(text, (self:getWidth() - tw) / 2, (self:getHeight() - th) / 2, textColor);
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
		isMouseDown = false;

		if doCb then
			if onClick then
				onClick(table.unpack(arguments));
			end
		end
		return true;
	end
	-- }}}
	function self:onMouseDown(mX, mY) -- {{{
		isMouseDown = true;
		return true;
	end
	-- }}}
	function self:onMouseUpOutside(mX, mY) -- {{{
		isMouseDown = false;
		if parent then return parent:onMouseUpOutside(mX, mY) end
		return false;
	end
	-- }}}

	return self;
end
