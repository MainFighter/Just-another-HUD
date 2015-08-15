--[[------------------------------------------------------------------------------------------------------
This HUD was made by Main Fighter (http://steamcommunity.com/profiles/76561198230883500/).
Please don't remove the credits. No one will see them besides you anyway! Thank you for understanding.

If you need help feel free to add me on steam.
]]--------------------------------------------------------------------------------------------------------

-- Yeah these are completely useless settings! Haha oh well --
AnonymousSrvSettings = {}
-- You should keep this enabled for the credit and so you can tell if its loaded or not! --
AnonymousSrvSettings.ServerLogMessage = true
-- This is mainly for people that have their own Force Download lua files if you don't keep it enabled --
AnonymousSrvSettings.ForceDownload = true

-- Loaded Message --
if AnonymousSrvSettings.ServerLogMessage then
	print("\n")
	MsgC(Color(255, 0, 0), " <=========> ")
	print("\n")
	MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "Just another HUD Loaded!\n")
	MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "Made by Main Fighter! http://steamcommunity.com/profiles/76561198230883500/\n")
	MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "Version: ") MsgC(Color(255,0,0), "0.1.4")
	print("\n")
	MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "Thank you for using my HUD! I love you <3\n")
	print("\n")
	MsgC(Color(255, 0, 0), " <=========> ") MsgC(Color(0,255,0))
	print("\n")
end

-- Forces the download of the fonts if you have a FastDL --
if AnonymousSrvSettings.ForceDownload then
	resource.AddFile("resource/fonts/bebasneue.otf")
	resource.AddFile("resource/fonts/bebasneue.ttf")
end
