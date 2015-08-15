--[[------------------------------------------------------------------------------------------------------
This HUD was made by Main Fighter (http://steamcommunity.com/profiles/76561198230883500/).
Please don't remove the credits. No one will see them besides you anyway! Thank you for understanding.

If you need help feel free to add me on steam.

Current Version: 0.1.4
]]--------------------------------------------------------------------------------------------------------

-- Settings --
-- Settings are still a work in progress --
local AnonymousSettings = {}

-- Set the Multiplier that LevelSystemConfiguration.XPMult is set to in the levels configuration --
AnonymousSettings.LevelsMultiplier = 1.5

-- Disbaled different parts of the HUD --
AnonymousSettings.Modules = {
	["rank"]	= true,
	["health"] 	= true,
	["armor"]	= true,
	["level"]	= true,
	["ammo"]	= true,
	["version"] = true, -- Version checker (Coming Soon)
}

-- Change the launguage of the HUD just makes it easier for you --
AnonymousSettings.Language = {
	['steamid'] = "SteamID",
	["health"]	= "Health: ", -- If you want a space between text and the percentage do this "Health: " see the space!
	["armor"]	= "Armor: ", -- If you want a space between text and the percentage do this "Armor: " see the space!
	["level"]	= "Level",
	["exp"] 	= "Next Level",
	["wallet"]	= "Wallet",
	["salary"]	= "Salary",
	["job"]		= "Occupation",
}

--[[----------------------------------------------------------------------
Do not touch anything under this line unless you know what you are doing!
Do not touch anything under this line unless you know what you are doing!
Do not touch anything under this line unless you know what you are doing!
Do not touch anything under this line unless you know what you are doing!
]]------------------------------------------------------------------------

-- Version Number (Do not change) --
AnonymousSettings.Version = ""

-- Disabled Default HUD Elements --
-- You shouldn't touch these unless you know what you are doing! --
local HideElementsTable = { 
 	-- DarkRP 
 	["DarkRP_HUD"]				= false, 
 	["DarkRP_EntityDisplay"] 	= false, 
 	["DarkRP_ZombieInfo"] 		= false, 
 	["DarkRP_LocalPlayerHUD"] 	= true, 
 	["DarkRP_Hungermod"] 		= true, 
 	["DarkRP_Agenda"] 			= true, 
 	-- GMod 
 	["CHudHealth"]				= true, 
 	["CHudBattery"]				= true, 
 	["CHudSuitPower"]			= true, 
 	["CHudAmmo"]				= true,
 	["CHudSecondaryAmmo"]		= true,
} 

local function HideElements( element )
	if HideElementsTable[ element ] then
		return false
	end
end
hook.Add ("HUDShouldDraw", "HideElements", HideElements)

-- Formating Money Numbers --
function FormatNumber( n )
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)	
	end
	return n
end

-- Making bordered boxes --
function draw.BorderedBox( bordersize, x, y, w, h, color )
	-- Background
	draw.RoundedBox( 0, x, y, w, h, Color( color.r, color.g, color.b, 150 ) )

	-- Border - Side
	draw.RoundedBox( 0, x-1, y-1, 2, h+3, Color( 0, 0, 0, 250 ) )
	draw.RoundedBox( 0, x+w, y-1, 2, h+3, Color( 0, 0, 0, 250 ) )

	-- Border - Top
	draw.RoundedBox( 0, x, y-1, w, 2, Color( 0, 0, 0, 250 ) )
	draw.RoundedBox( 0, x, y+h, w, 2, Color( 0, 0, 0, 250 ) )
end

-- Making HUD --
local function HUDMain()
	-- Defining Varaibles --
	local PlayerName = LocalPlayer():Nick() or "Undefined"
	local PlayerSteamID = LocalPlayer():SteamID() or "Undefined"
	local PlayerRank = LocalPlayer():GetNWString("usergroup") or "Undefined"
	local PlayerHealth = LocalPlayer():Health() or 0
	local PlayerArmor = LocalPlayer():Armor() or 0
	local PlayerJob  = LocalPlayer():getDarkRPVar("job") or "Undefined"
	local PlayerWallet = "$"..FormatNumber(LocalPlayer():getDarkRPVar("money")) or 0
	local PlayerSalary = "$"..FormatNumber(LocalPlayer():getDarkRPVar("salary")) or 0
	local PlayerLevel = LocalPlayer():getDarkRPVar('level') or 0
	local PlayerEXP = LocalPlayer():getDarkRPVar('xp') or 0

	-- Left Backgroud --
	draw.BorderedBox(0, 10, ScrH() - 135, 250, 125, Color(0, 0, 0, 220))

	-- Divider Left Background
	draw.BorderedBox(0, 20, ScrH() - 72.5, 225, 5, Color(0, 0, 0, 220))

	-- Right Backgroud --
	draw.BorderedBox(0, 270, ScrH() - 135, 250, 125, Color(0, 0, 0, 220))

	-- Turning EXP into percentage --
	local EXPPercent = ((PlayerEXP or 0)/(((10+(((PlayerLevel or 1)*((PlayerLevel or 1)+1)*90))))*AnonymousSettings.LevelsMultiplier))
	
	local EXPPercent2 = EXPPercent*100
	EXPPercent2 = math.Round(EXPPercent2)
	EXPPercent2 = math.Clamp(EXPPercent2, 0, 99)

	-- Name --
	draw.BorderedBox(0, 10, ScrH() - 170, 250, 25, Color(0, 0, 0))	
	draw.DrawText(PlayerName, "Anonymous_BebasNeue_30", 135, ScrH() - 171, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

	-- SteamID --
	-- This whole SteamID thing is tempoary --
	if AnonymousSettings.Modules['level'] == false then
		draw.DrawText(AnonymousSettings.Language["steamid"], "Anonymous_BebasNeue_20", 395, ScrH() - 125, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)	
		draw.DrawText(PlayerSteamID, "Anonymous_BebasNeue_30", 395, ScrH() - 109, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	-- Rank --
	if AnonymousSettings.Modules["rank"] then
		draw.BorderedBox(0, 270, ScrH() - 170, 250, 25, Color(0, 0, 0))
		draw.DrawText(PlayerRank, "Anonymous_BebasNeue_30", 395, ScrH() - 171, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	-- Health --
	if AnonymousSettings.Modules["health"] then
		draw.BorderedBox(0, 277.5, ScrH() - 72.5, 235, 25, Color(0,0,0,255))

		local HealthBar = PlayerHealth

		if PlayerHealth > 100 then HealthBar = 100 end
		if PlayerHealth < 0 then HealthBar = 0 end
				
		if HealthBar != 0 then
			draw.BorderedBox(0, 277.5, ScrH() - 72.5, (235) * HealthBar / 100, 25, Color(170, 0, 0, 255))
		end
		draw.DrawText(AnonymousSettings.Language["health"]..PlayerHealth.."%", "Anonymous_BebasNeue_20", 395, ScrH() - 68.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	-- Armor --
	if AnonymousSettings.Modules["armor"] then
		draw.BorderedBox(0, 277.5, ScrH() - 40, 235, 25, Color(0,0,0,255))

		local ArmorBar = PlayerArmor

		if PlayerArmor > 100 then ArmorBar = 100 end
		if PlayerArmor < 0 then ArmorBar = 0 end
				
		if ArmorBar != 0 then
			draw.BorderedBox(0, 277.5, ScrH() - 40, (235) * ArmorBar / 100, 25, Color(0, 0, 170, 255))
		end
		draw.DrawText(AnonymousSettings.Language["armor"]..PlayerArmor.."%", "Anonymous_BebasNeue_20", 395, ScrH() - 36.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	-- Job --
	draw.DrawText(AnonymousSettings.Language["job"], "Anonymous_BebasNeue_20", 135, ScrH() - 60, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)	
	draw.DrawText(PlayerJob, "Anonymous_BebasNeue_30", 135, ScrH() - 44, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

	-- Wallet --
	draw.DrawText(AnonymousSettings.Language["wallet"], "Anonymous_BebasNeue_20", 72.5, ScrH() - 125, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)	
	draw.DrawText(PlayerWallet, "Anonymous_BebasNeue_30", 72.5, ScrH() - 109, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

	-- Salary --
	draw.DrawText(AnonymousSettings.Language["salary"], "Anonymous_BebasNeue_20", 187.5, ScrH() - 125, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)	
	draw.DrawText(PlayerSalary, "Anonymous_BebasNeue_30", 187.5, ScrH() - 109, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

	-- Levels --
	if AnonymousSettings.Modules["level"] then
		draw.DrawText(AnonymousSettings.Language["level"], "Anonymous_BebasNeue_20", 332.5, ScrH() - 125, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)	
		draw.DrawText(PlayerLevel, "Anonymous_BebasNeue_30", 332.5, ScrH() - 109, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

		-- EXP --
		draw.DrawText(AnonymousSettings.Language["exp"], "Anonymous_BebasNeue_20", 457.5, ScrH() - 125, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)	
		draw.DrawText(EXPPercent2.."%", "Anonymous_BebasNeue_30", 457.5, ScrH() - 109, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end
end
hook.Add("HUDPaint", "HUDMain", HUDMain)

function HUDAmmo()
	-- For Settings (Leave it here) --
	if not AnonymousSettings.Modules['ammo'] then return end

	-- Variables --
	local ActiveWeapon = LocalPlayer():GetActiveWeapon()
	local PlayerAlive = LocalPlayer():Alive()

	-- Check to see if player has a weapon out and if player is alive --
	if not ActiveWeapon or not IsValid( ActiveWeapon ) or not PlayerAlive then return end

	-- Ammo Variables --
	local CurrentClip = ActiveWeapon:Clip1()
	local CurrentAmmo = LocalPlayer():GetAmmoCount( ActiveWeapon:GetPrimaryAmmoType() )

	-- Only allows ammo to display is ammo is more than 0 --
	if CurrentClip == -1 or CurrentClip <= 0 and CurrentAmmo <= 0 then return end

	-- Main Background --
	draw.BorderedBox(0, 540, ScrH() - 60, 100, 50, Color(0, 0, 0, 220))

	-- Left Box --
	draw.BorderedBox(0, 545, ScrH() - 55, 40, 40, Color(0, 0, 0, 220))

	-- Right Box --
	draw.BorderedBox(0, 595, ScrH() - 55, 40, 40, Color(0, 0, 0, 220))

	-- Help tip "Ammo" --
	draw.BorderedBox(0, 570, ScrH() - 90, 38, 20, Color(0, 0, 0, 220))
	draw.DrawText("Ammo", "Anonymous_BebasNeue_20", 590, ScrH() - 88, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

	draw.DrawText(CurrentClip, "Anonymous_BebasNeue_30", 565, ScrH() - 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	draw.DrawText(CurrentAmmo, "Anonymous_BebasNeue_30", 615, ScrH() - 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
end
hook.Add( "HUDPaint", "HUDAmmo", HUDAmmo )

local agendaText
local function Agenda()

	-- Variables --
	local agenda = LocalPlayer():getAgendaTable()
	if not agenda then return end

	agendaText = agendaText or DarkRP.textWrap((LocalPlayer():getDarkRPVar("agenda") or ""):gsub("//", "\n"):gsub("\\n", "\n"), "DarkRPHUD1", 440)

	-- Background --
	draw.BorderedBox( 0, 10, 10, 460, 110, Color(0, 0, 0, 255) )
	draw.BorderedBox( 0, 15, 15, 460 - 10, 20, Color(0, 0, 0, 255) )

	-- Text --
	draw.DrawText( string.lower( agenda.Title ), "Anonymous_BebasNeue_24", 235, 14, Color( 255, 255, 255, 255 ), 1 )
	draw.DrawNonParsedText( string.lower( agendaText ), "Anonymous_BebasNeue_22", 20, 40, Color( 255, 255, 255, 255 ), 0)

end
hook.Add( "HUDPaint", "Agenda", Agenda )

hook.Add("DarkRPVarChanged", "anonymous_agendaHUD", function(ply, var, _, new)

	if ply ~= LocalPlayer() then return end
	if var == "agenda" and new then
		agendaText = DarkRP.textWrap(new:gsub("//", "\n"):gsub("\\n", "\n"), "Anonymous_BebasNeue_22", 440)
	else
		agendaText = nil
	end

end)