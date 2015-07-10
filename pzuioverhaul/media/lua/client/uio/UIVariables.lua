-- Base Colors
local white = { r = 1.0, g = 1.0, b = 1.0 };
local greyA = { r = 0.9, g = 0.9, b = 0.9 };
local greyB = { r = 0.7, g = 0.7, b = 0.7 };
local greyC = { r = 0.6, g = 0.6, b = 0.6 };
local greyD = { r = 0.3, g = 0.3, b = 0.3 };
local greyE = { r = 0.2, g = 0.2, b = 0.2 };
local greyF = { r = 0.1, g = 0.1, b = 0.1 };
local black = { r = 0.0, g = 0.0, b = 0.0 };

local Base = {};
Base.textColor                = { r = white.r, g = white.g, b = white.b, a = 1.0 };
Base.borderColor              = { r = greyD.r, g = greyD.g, b = greyD.b, a = 1.0 };
Base.backgroundColor          = { r = black.r, g = black.g, b = black.b, a = 0.8 };
Base.backgroundColorMouseDown = { r = black.r, g = black.g, b = black.b, a = 0.8 };

local Button = {};
Button.textColor                = Base.textColor;
Button.borderColor              = { r = greyC.r, g = greyC.g, b = greyC.b, a = 1.0 };
Button.backgroundColor          = { r = greyF.r, g = greyF.g, b = greyF.b, a = 0.8 };
Button.backgroundColorMouseDown = { r = greyD.r, g = greyD.g, b = greyD.b, a = 0.8 };
Button.backgroundColorMouseOver = { r = greyE.r, g = greyE.g, b = greyE.b, a = 0.8 };

-- Register the elements in a global table
UIVariables = {};
UIVariables.Base = Base;
UIVariables.Button = Button;
