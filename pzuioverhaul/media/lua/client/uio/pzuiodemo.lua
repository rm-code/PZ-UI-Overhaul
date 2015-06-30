require 'uio/BaseElement'
require 'uio/Panel'
require 'uio/Draggable'
require 'uio/Titlebar'

local function pzuiodemo(player, context, items) -- {{{
	local panel = UIO.Panel.new(100, 100, 200, 150);

	local draggable = UIO.Draggable.new(0, 0, 200, 150);
	panel:addChild(draggable);

	local titlebar = UIO.Titlebar.new(0, 0, 200, 16);
	titlebar:setTitle("UI Demo");
	panel:addChild(titlebar);

	panel:addToUIManager();
end
-- }}}

Events.OnFillInventoryObjectContextMenu.Add(pzuiodemo);
