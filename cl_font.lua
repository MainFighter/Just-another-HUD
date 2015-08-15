-- Creates the font --
-- This is NEEDED or the HUD will not function --
local function CreateHUDFonts( i, font, name, weight )
	local CurrentFontSize = 12 + i * 2
	surface.CreateFont( name .. CurrentFontSize, {
		font 		= font,
		size 		= CurrentFontSize,
		weight 		= weight,
		blursize 	= 0,
		scanlines	= 0,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= false,
		outline 	= false,
	})
end

for i=1,20 do
	CreateHUDFonts( i, "Bebas Neue", "Anonymous_BebasNeue_", 100 )
end