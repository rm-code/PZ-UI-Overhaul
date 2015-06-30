require 'uio/BaseElement'

UIO.Titlebar = {};

function UIO.Titlebar.new(x, y, w, h)
	local self = UIO.BaseElement.new(x, y, w, h);

	local titleBarBackground = getTexture("media/ui/Panel_TitleBar.png");
	local textColor = {r = 1, g = 1, b = 1, a = 1};
	local collapsible = false;
	local isCollapsed = false;
	local title = "Window";
	
	function self:setTitle(t)
		title = t;
	end
	function self:prerender()
		self:drawRectangle("fill", 0, 0, self:getWidth(), self:getHeight(), self:getBackgroundColor());
		self:drawTextureScaled(titleBarBackground, 1, 1, self:getWidth() - 1, self:getHeight() - 2);
		self:drawRectangle("line", 0, 0, self:getWidth(), self:getHeight(), self:getBorderColor());

		self:drawTextCentered(title, self:getWidth() / 2, 1, textColor);
	end

	return self;
end
