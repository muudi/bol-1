--[[
	Changelog
	1.02 -- Add Harass Toggle
	
	1.04 -- fix
]]


if myHero.charName ~= "DrMundo" then return end

require "VPrediction"
require "SxOrbWalk"

assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQIKAAAABgBAAEFAAAAdQAABBkBAAGUAAAAKQACBBkBAAGVAAAAKQICBHwCAAAQAAAAEBgAAAGNsYXNzAAQNAAAAU2NyaXB0U3RhdHVzAAQHAAAAX19pbml0AAQLAAAAU2VuZFVwZGF0ZQACAAAAAgAAAAgAAAACAAotAAAAhkBAAMaAQAAGwUAABwFBAkFBAQAdgQABRsFAAEcBwQKBgQEAXYEAAYbBQACHAUEDwcEBAJ2BAAHGwUAAxwHBAwECAgDdgQABBsJAAAcCQQRBQgIAHYIAARYBAgLdAAABnYAAAAqAAIAKQACFhgBDAMHAAgCdgAABCoCAhQqAw4aGAEQAx8BCAMfAwwHdAIAAnYAAAAqAgIeMQEQAAYEEAJ1AgAGGwEQA5QAAAJ1AAAEfAIAAFAAAAAQFAAAAaHdpZAAEDQAAAEJhc2U2NEVuY29kZQAECQAAAHRvc3RyaW5nAAQDAAAAb3MABAcAAABnZXRlbnYABBUAAABQUk9DRVNTT1JfSURFTlRJRklFUgAECQAAAFVTRVJOQU1FAAQNAAAAQ09NUFVURVJOQU1FAAQQAAAAUFJPQ0VTU09SX0xFVkVMAAQTAAAAUFJPQ0VTU09SX1JFVklTSU9OAAQEAAAAS2V5AAQHAAAAc29ja2V0AAQIAAAAcmVxdWlyZQAECgAAAGdhbWVTdGF0ZQAABAQAAAB0Y3AABAcAAABhc3NlcnQABAsAAABTZW5kVXBkYXRlAAMAAAAAAADwPwQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawABAAAACAAAAAgAAAAAAAMFAAAABQAAAAwAQACBQAAAHUCAAR8AgAACAAAABAsAAABTZW5kVXBkYXRlAAMAAAAAAAAAQAAAAAABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAUAAAAIAAAACAAAAAgAAAAIAAAACAAAAAAAAAABAAAABQAAAHNlbGYAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAtAAAAAwAAAAMAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAAFAAAABQAAAAUAAAAFAAAABgAAAAYAAAAGAAAABgAAAAUAAAADAAAAAwAAAAYAAAAGAAAABgAAAAYAAAAGAAAABgAAAAYAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAIAAAACAAAAAgAAAAIAAAAAgAAAAUAAABzZWxmAAAAAAAtAAAAAgAAAGEAAAAAAC0AAAABAAAABQAAAF9FTlYACQAAAA4AAAACAA0XAAAAhwBAAIxAQAEBgQAAQcEAAJ1AAAKHAEAAjABBAQFBAQBHgUEAgcEBAMcBQgABwgEAQAKAAIHCAQDGQkIAx4LCBQHDAgAWAQMCnUCAAYcAQACMAEMBnUAAAR8AgAANAAAABAQAAAB0Y3AABAgAAABjb25uZWN0AAQRAAAAc2NyaXB0c3RhdHVzLm5ldAADAAAAAAAAVEAEBQAAAHNlbmQABAsAAABHRVQgL3N5bmMtAAQEAAAAS2V5AAQCAAAALQAEBQAAAGh3aWQABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAEJgAAACBIVFRQLzEuMA0KSG9zdDogc2NyaXB0c3RhdHVzLm5ldA0KDQoABAYAAABjbG9zZQAAAAAAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAXAAAACgAAAAoAAAAKAAAACgAAAAoAAAALAAAACwAAAAsAAAALAAAADAAAAAwAAAANAAAADQAAAA0AAAAOAAAADgAAAA4AAAAOAAAACwAAAA4AAAAOAAAADgAAAA4AAAACAAAABQAAAHNlbGYAAAAAABcAAAACAAAAYQAAAAAAFwAAAAEAAAAFAAAAX0VOVgABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAoAAAABAAAAAQAAAAEAAAACAAAACAAAAAIAAAAJAAAADgAAAAkAAAAOAAAAAAAAAAEAAAAFAAAAX0VOVgA="), nil, "bt", _ENV))() ScriptStatus("QDGEGIDJLGI") 

local ts, enemyMinions
local SxO, VP = nil, nil
local QRange, WRange, ERange, RRange = 1000, 320, 225, 0
local WActive = false

local version = 1.04
local AUTO_UPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/seanlol/bol/master/SEAN Mundo.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = LIB_PATH.."SEAN Mundo.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

local function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>SEAN Mundo:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
local function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>Welcome " .. GetUser() .. " Auth Successed By http://seanlol.com Have Good Game. </b>")end
if AUTO_UPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/seanlol/bol/master/SEAN Mundo.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(version) < ServerVersion then
				AutoupdaterMsg("New version available"..ServerVersion)
				AutoupdaterMsg("Updating, please don't press F9")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () AutoupdaterMsg("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
			else
				AutoupdaterMsg("You have got the latest version ("..ServerVersion..")")
			end
		end
	else
		AutoupdaterMsg("Error downloading version info")
	end
end

function OnLoad()
	VP = VPrediction()
	SxO = SxOrbWalk()
	
	LoadMenu()
	
	ts = TargetSelector(TARGET_NEAR_MOUSE,1300)
	enemyMinions = minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_MAXHEALTH_DEC)
	
end

function OnTick()
	killsteal()
	Harass()
	Farm()
	Combo()
	R()
end

function OnDraw()
	if Config.draw.drawrrance then
		DrawCircle(myHero.x, myHero.y, myHero.z, QRange, 0x111111)
	end
end

function LoadMenu()
	Config = scriptConfig("SEAN Mundo", "Dr.Mundo")
		Config:addSubMenu("스킬콤보설정", "combo")
			Config.combo:addParam("combo", "스킬콤보사용", SCRIPT_PARAM_ONKEYDOWN, false, 32)
			Config.combo:addParam("useQ", "대형식칼(Q)사용", SCRIPT_PARAM_ONOFF, true)
			Config.combo:addParam("useW", "타오르는고통(W)사용", SCRIPT_PARAM_ONOFF, true)
			Config.combo:addParam("useE", "피학증(E)사용", SCRIPT_PARAM_ONOFF, true)
			
		Config:addSubMenu("스킬견제설정", "harass")
			Config.harass:addParam("harasstoggle", "버튼식견제키", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("X"))
			Config.harass:addParam("harass", "견제키설정", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			Config.harass:addParam("useQ", "대형식칼(Q)사용", SCRIPT_PARAM_ONOFF, true)
		
		Config:addSubMenu("스킬파밍설정", "farm")
			Config.farm:addParam("farm", "스킬파밍사용",  SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
			Config.farm:addParam("useQ", "대형식칼(Q)사용", SCRIPT_PARAM_ONOFF, true)
			--Config.farm:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
			
		Config:addSubMenu("기타기능설정", "ads")
			Config.ads:addParam("ks", "대형식칼(Q)킬스틸", SCRIPT_PARAM_ONOFF, true)
			Config.ads:addParam("user", "가학증(R)사용", SCRIPT_PARAM_ONOFF, true)
			Config.ads:addParam("per", "체력 % 이하 가학증(R)사용", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)
			
		Config:addSubMenu("스킬범위설정", "draw")
			Config.draw:addParam("drawrrance", "대형식칼(Q)사거리", SCRIPT_PARAM_ONOFF, true)
			--Config.draw:addParam("drawaarance", "draw AA rance", SCRIPT_PARAM_ONOFF, true)
			
		Config:addSubMenu("오브워크설정", "orbWalk")
			SxO:LoadToMenu(Config.orbWalk)
		Config:addSubMenu("스크립트정보", "info")
			Config.info:addParam("infoproduce", "스크립트 \193\166\192\219\192\218 : SEAN", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infover", "스크립트 \185\246\192\252 : 1.04", 5, "")
			Config.info:addParam("infotrans", "\199\209\177\219\185\248\191\170 : SEAN", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infosite", "홈페이지 : Seanlol.com", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infokaka", "카카오톡 : seanlol", SCRIPT_PARAM_INFO, "")
end

function Farm()
	if Config.farm.farm then
		enemyMinions:update()
		for i, minion in ipairs(enemyMinions.objects) do
			if ValidTarget(minion) and GetDistance(minion) <= QRange and myHero:CanUseSpell(_Q) == READY and getDmg("Q", minion, myHero) > minion.health and Config.farm.useQ then
				local CastPosition,  HitChance,  Position = VP:GetLineCastPosition(minion, 0.5, 75, 1000, 1500, myHero, true)
				if HitChance >= 2 and GetDistance(CastPosition) < 1000 then
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
			end
		end
	end
end

function Harass()
	if Config.harass.harass or Config.harass.harasstoggle then
		if ValidTarget(ts.target, QRange) and myHero:CanUseSpell(_Q) == READY then
			for i, target in pairs(GetEnemyHeroes()) do
			local CastPosition,  HitChance,  Position = VP:GetLineCastPosition(ts.target, 0.5, 75, 1000, 1500, myHero, true)
				if HitChance >= 2 and GetDistance(CastPosition) < 1300 then
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
			end
        end
	end
end

function Combo()
	if Config.combo.combo then
		ts:update()
		if ValidTarget(ts.target, QRange) and myHero:CanUseSpell(_Q) == READY and Config.combo.useQ then
			for i, target in pairs(GetEnemyHeroes()) do
				local CastPosition,  HitChance,  Position = VP:GetLineCastPosition(ts.target, 0.5, 75, 1000, 1500, myHero, true)
            	if HitChance >= 2 and GetDistance(CastPosition) < 1000 then
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
			end
		end

		if not WActive and myHero:CanUseSpell(_W) == READY and CountEnemyHeroInRange(WRange) >= 1 and Config.combo.useW then
			CastSpell(_W)
			else 
	
			if WActive and CountEnemyHeroInRange(WRange) == 0 and Config.combo.useW then
				CastSpell(_W)
			end
		end

		if CountEnemyHeroInRange(ERange) >= 1 and myHero:CanUseSpell(_E) == READY and Config.combo.useE then
			CastSpell(_E)
		end
	end
end

function R()
	if Config.ads.user then
		if myHero.health < (myHero.maxHealth*(Config.ads.per*0.01)) then
			if myHero:CanUseSpell(_R) then
				CastSpell(_R)
			end
		end
	end
end

function killsteal()
	local i, Champion
	for i, Champion in pairs(GetEnemyHeroes()) do
		if ValidTarget(Champion) then
			if getDmg("Q", Champion, myHero) > Champion.health and Config.ads.ks then
				local CastPosition,  HitChance,  Position = VP:GetLineCastPosition(Champion, 0.5, 75, 1000, 1500, myHero, true)
            	if HitChance >= 2 and GetDistance(CastPosition) < 1000 then
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
			end
		end
	end
end

function OnApplyBuff(source, unit, buff)
    if unit and unit.isMe and buff.name == "BurningAgony" then 
        WActive = true
    end
end

function OnRemoveBuff(unit, buff)
    if unit and unit.isMe and buff.name == "BurningAgony" then 
        WActive = false
    end
end
