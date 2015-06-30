require 'uio/BaseElement'

UIO.Panel = {};

function UIO.Panel.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	function self:prerender()
		self:drawRectangle('fill', 0, 0, w, h, self:getBackgroundColor());
		self:drawRectangle('line', 0, 0, w, h, self:getBorderColor());
	end

	self:setBackgroundColorRGBA(0.1, 0.1, 0.1, 0.5);
	self:setBorderColorRGBA(0.4, 0.4, 0.4, 0.8);
	return self;
end
