require 'uio/BaseElement'
require 'uio/UIVariables'

UIO.Panel = {};

function UIO.Panel.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local backgroundColor = UIVariables.Base.backgroundColor;
	local borderColor     = UIVariables.Base.borderColor;

	function self:prerender()
		self:drawRectangle('fill', 0, 0, self:getWidth(), self:getHeight(), backgroundColor);
		self:drawRectangle('line', 0, 0, self:getWidth(), self:getHeight(), borderColor);
	end

	return self;
end
