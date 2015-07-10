require 'uio/BaseElement'
require 'uio/UIVariables'

UIO.Button = {};
UIO.Button.Functions = {};

UIO.Button.Functions.render = function(self)--{{{
	self:drawText(self:getText(), (self:getWidth() - self:getTextWidth()) / 2, (self:getHeight() - self:getTextHeight()) / 2);
end
--}}}
UIO.Button.Functions.prerender = function(self) -- {{{
	if self:hasOnClick() then
		if self:getIsMouseOver() then
			if self:getIsMouseDown() then
				self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), self:getBackgroundColorMouseDown());
			else
				self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), self:getBackgroundColorMouseOver());
			end
		else
			self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), self:getBackgroundColor());
		end
	end
	self:drawRectangle('line', 0, 0, self:getWidth(), self:getHeight(), self:getBorderColor());
end
-- }}}
UIO.Button.Functions.onMouseUp = function(self, mX, mY) -- {{{
	local doCb = self:getIsMouseDown() and self:getIsMouseOver() and self:hasOnClick();

	if doCb then
		self:setIsMouseDown(false);
		self:doOnClick();
		return true;
	end
	return false;
end
-- }}}
UIO.Button.Functions.onMouseDown = function(self, mX, mY) -- {{{
	self:setIsMouseDown(true);
	return self:getIsMouseDown();
end
-- }}}
UIO.Button.Functions.onMouseUpOutside = function(self, mX, mY) -- {{{
	if self:getIsMouseDown() then
		self:setIsMouseDown(false);
		return true;
	end
	return false;
end
-- }}}
UIO.Button.Functions.onMouseMove = function(self, mX, mY) -- {{{
	self:setIsMouseOver(true);
	return true;
end
-- }}}
UIO.Button.Functions.onMouseMoveOutside = function(self, mX, mY) -- {{{
	self:setIsMouseOver(false);
	return true;
end
-- }}}

function UIO.Button.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local tw = 0;
	local th = 0;
	local text = "Foo";
	local onClick = nil;
	local arguments = nil;
	local isMouseDown = false;
	local isMouseOver = false;

	self.render = UIO.Button.Functions.render;
	self.prerender = UIO.Button.Functions.prerender;
	self.onMouseUp = UIO.Button.Functions.onMouseUp;
	self.onMouseDown = UIO.Button.Functions.onMouseDown;
	self.onMouseUpOutside = UIO.Button.Functions.onMouseUpOutside;
	self.onMouseMove = UIO.Button.Functions.onMouseMove;
	self.onMouseMoveOutside = UIO.Button.Functions.onMouseMoveOutside;

	function self:doOnClick() -- {{{
		onClick(table.unpack(arguments));
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
	function self:setText(nt) -- {{{
		text = nt;
		tw = getTextManager():MeasureStringX(UIFont.Small, text);
		th = getTextManager():MeasureStringY(UIFont.Small, text);
	end
	-- }}}
	function self:setIsMouseDown(_imd) -- {{{
		isMouseDown = _imd and self:hasOnClick();
	end
	-- }}}
	function self:setIsMouseOver(_imo) -- {{{
		isMouseOver = _imo;
	end
	-- }}}

	function self:getIsMouseDown() -- {{{
		return isMouseDown;
	end
	-- }}}
	function self:getIsMouseOver() -- {{{
		return isMouseOver;
	end
	-- }}}
	function self:getText()--{{{
		return text;
	end
--}}}
	function self:getTextWidth()--{{{
		return tw;
	end
--}}}
	function self:getTextHeight()--{{{
		return th;
	end
--}}}

	function self:hasOnClick()--{{{
		return onClick ~= nil;
	end
--}}}

	self:setTextColor(UIVariables.Button.textColor);
	self:setBorderColor(UIVariables.Button.borderColor);
	self:setBackgroundColor(UIVariables.Button.backgroundColor);
	self:setBackgroundColorMouseDown(UIVariables.Button.backgroundColor);
	self:setBackgroundColorMouseOver(UIVariables.Button.backgroundColorMouseOver);

	return self;
end
