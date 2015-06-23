require 'uio/BaseElement'
require 'uio/Panel'
require 'uio/Draggable'

local function pzuiodemo(player, context, items) -- {{{
	local panel = UIO.Panel.new(100, 100, 200, 150);

	local draggable = UIO.Draggable.new(0, 0, 200, 150);
	panel:addChild(draggable);

	panel:addToUIManager();
end
-- }}}

Events.OnFillInventoryObjectContextMenu.Add(pzuiodemo);
