require 'uio/BaseElement'
-- TODO These MUST go elsewhere TODO
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

UIO.Button = {};

function UIO.Button.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);
	local tw = 0;
	local th = 0;
	local text = "Foo";
	local onClick = nil;
	local arguments = nil;
	local textColor = {r=1, g=1, b=1, a=1};

	function self:prerender() -- {{{
		if self:isMouseOver() then
			self:drawRectangle('fill', 0, 0, w, h, self:getMouseOverBackgroundColor());
		else
			self:drawRectangle('fill', 0, 0, w, h, self:getBackgroundColor());
		end
		self:drawRectangle('line', 0, 0, w, h, self:getBorderColor());
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
		return onClick(table.unpack(arguments));
	end
	-- }}}

	self:setBorderColorRGBA(0.7, 0.7, 0.7, 1);
	self:setBackgroundColorRGBA(0, 0, 0, 1.0);
	self:setMouseOverBackgroundColorRGBA(0.3, 0.3, 0.3, 1.0);
	return self;
end
