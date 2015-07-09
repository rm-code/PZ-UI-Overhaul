require 'uio/BaseElement'
require 'uio/Button'
require 'uio/Draggable'
require 'uio/Panel'
require 'uio/Resizable'
require 'uio/Titlebar'

function callback(par1, par2, par3)
	print("callback called with: "..tostring(par1)..", "..tostring(par2)..", "..tostring(par3));
end

local function pzuiodemo(player, context, items) -- {{{
	local panel = UIO.Panel.new(100, 100, 200, 200);

	local draggable = UIO.Draggable.new(0, 0, 200, 16);
	panel:addChild(draggable);

	local titlebar = UIO.Titlebar.new(0, 0, 200, 16);
	titlebar:setTitle("UI Demo");
	panel:addChild(titlebar);

	local button = UIO.Button.new(20, 40, 40, 40);
	button:setText("OK");
	button:setOnClick(callback, getSpecificPlayer(0):getForname(), getSpecificPlayer(0):getSurname(), "DIEDIEDIE");
	button:setAnchorTop(true);
	button:setAnchorLeft(true);
	panel:addChild(button);

	local label = UIO.Button.new(140, 140, 40, 40);
	label:setText("Label");
	label:setBorderColorRGBA(0, 0, 0, 0);
	label:setAnchorRight(true);
	label:setAnchorBottom(true);
	panel:addChild(label);

	local resizable = UIO.Resizable.new(0, panel:getHeight()-10, 200, 10);
	panel:addChild(resizable);

	panel:setMinH(30);
	panel:setMinW(30);
	panel:addToUIManager();
end
-- }}}

Events.OnFillInventoryObjectContextMenu.Add(pzuiodemo);
