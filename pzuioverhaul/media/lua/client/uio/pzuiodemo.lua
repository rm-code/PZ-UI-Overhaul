require 'uio/BaseElement'
require 'uio/Panel'
require 'uio/Draggable'
require 'uio/Titlebar'
require 'uio/Button'

function callback(par1, par2, par3)
	print("callback called with: "..tostring(par1)..", "..tostring(par2)..", "..tostring(par3));
end

local function pzuiodemo(player, context, items) -- {{{
	local panel = UIO.Panel.new(100, 100, 200, 150);

	local draggable = UIO.Draggable.new(0, 0, 200, 150);
	panel:addChild(draggable);

	local titlebar = UIO.Titlebar.new(0, 0, 200, 16);
	titlebar:setTitle("UI Demo");
	panel:addChild(titlebar);

	local button = UIO.Button.new(60, 36, 40, 20);
	button:setText("OK");
	button:setOnClick(callback, getSpecificPlayer(0):getForname(), getSpecificPlayer(0):getSurname(), "DIEDIEDIE");
	panel:addChild(button);

	panel:addToUIManager();
end
-- }}}

Events.OnFillInventoryObjectContextMenu.Add(pzuiodemo);
