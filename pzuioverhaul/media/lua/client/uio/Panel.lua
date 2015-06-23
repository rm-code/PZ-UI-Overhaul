require 'uio/BaseElement'

UIO.Panel = {};

function UIO.Panel.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local bgColor = { r = 0.1, g = 0.1, b = 0.1, a = 0.5 };
	local borderColor = { r = 0.4, g = 0.4, b = 0.4, a = 0.8 };

	function self:prerender()
		self:drawRectangle('fill', 0, 0, w, h, bgColor);
		self:drawRectangle('line', 0, 0, w, h, borderColor);
	end

	return self;
end
