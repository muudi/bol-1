if myHero.charName ~= "Blitzcrank" then return end

local version = 1.02
local AUTO_UPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/seanlol/bol/master/Sean Blitz.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = LIB_PATH.."SEAN Blitz.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

local function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>SEAN Blitzcrank:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
local function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>Welcome " .. GetUser() .. " Auth Successed By http://seanlol.com Have Good Game. </b>")end

if AUTO_UPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/seanlol/bol/master/Sean Blitz.version")
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

require 'HPrediction'
require "SxOrbWalk"

local ts
local player = myHero

function OnLoad()
	HPred = HPrediction()
	SxO = SxOrbWalk()
	
	Spell_Q.collisionM['Blitzcrank'] = true
	Spell_Q.collisionH['Blitzcrank'] = true
	Spell_Q.delay['Blitzcrank'] = 0.25
	Spell_Q.range['Blitzcrank'] = 925
	Spell_Q.speed['Blitzcrank'] = 1800
	Spell_Q.type['Blitzcrank'] = "DelayLine"
	Spell_Q.width['Blitzcrank'] = 140
	

  
	ts = TargetSelector(TARGET_MOST_AD, 1000)
	
	LoadMenu()
end

function OnTick()
	Combo()
	OnSpellcheck()
	
	  if GetLeastHealthAround() < Config.ag.agper then return end

    -- AutoGrab
    for _, enemy in ipairs(GetEnemyHeroes()) do
        if ValidTarget(enemy, 1500) and Config.targets[enemy.charName] == 2 and Config.ag.useq then
            local Pos, HitChance = HPred:GetPredict("Q", enemy, myHero)
            
            if hitChance >= 1 and  _GetDistanceSqr(Pos) < 925 then
                if not CheckHeroCollision(Pos) then
                    CastSpell(_Q, Pos.x, Pos.z)
                    return
                end
            elseif hitChance >= 1 and _GetDistanceSqr(Pos) < 925 then
                if _GetDistanceSqr(Pos) > 300 * 300 and not CheckHeroCollision(Pos) then
                    CastSpell(_Q, Pos.x, Pos.z)
                    return
                end
            end
        end
    end
end

function LoadMenu()
	Config = scriptConfig("SEAN Blitz", "SEAN 블리츠크랭크")
		Config:addSubMenu("스킬콤보설정", "combo")
			Config.combo:addParam("active", "콤보사용", SCRIPT_PARAM_ONKEYDOWN, false, 32)
			Config.combo:addParam("usee", "자동 폭주(E)사용", SCRIPT_PARAM_ONOFF, true)
			Config.combo:addParam("user", "자동 정전기장(R)사용", SCRIPT_PARAM_ONOFF, true)
			
		
		Config:addSubMenu("안티타겟설정", "targets")
        for i, enemy in ipairs(GetEnemyHeroes()) do
            Config.targets:addParam(enemy.charName, enemy.charName, SCRIPT_PARAM_LIST, 2, {"그랩금지", "그랩허용"})
        end
		
		Config:addSubMenu("자동그랩설정", "ag")
			Config.ag:addParam("useg", "자동그랩(Q)사용", SCRIPT_PARAM_ONOFF, true)
			Config.ag:addParam("agper", "체력비례 그랩불가 < %", SCRIPT_PARAM_SLICE, 0, 0, 100)
		
		Config:addSubMenu("스킬범위설정", "draw")
			Config.draw:addParam("drawqrance", "로켓손(Q)표시", SCRIPT_PARAM_ONOFF, true)
		Config:addSubMenu("오브워크설정", "orbwalk")
			SxO:LoadToMenu(Config.orbwalk)
		Config:addSubMenu("스크립트정보", "info")
			Config.info:addParam("infoproduce", "스크립트 \193\166\192\219\192\218 : SEAN", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infover", "스크립트 \185\246\192\252 : 1.02", 5, "")
			Config.info:addParam("infotrans", "\199\209\177\219\185\248\191\170 : SEAN", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infosite", "홈페이지 : Seanlol.com", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infokaka", "카카오톡 : seanlol", SCRIPT_PARAM_INFO, "")
end

function OnDraw()
	if Config.draw.drawqrance then
		DrawCircle(myHero.x, myHero.y, myHero.z, 925, 0xFFFF0000)
	end
end

function Combo()
	if Config.combo.active then
		ts:update()
		if ts.target ~= nil then
			local Target = ts.target
			if GetDistance(ts.target, myHero) < 925 and Qready and Config.targets[Target.charName] > 1 then
				local Pos, HitChance = HPred:GetPredict("Q", ts.target, myHero)
				if HitChance >= 1 then
					CastSpell(_Q, Pos.x, Pos.z)
				end
			end
			if GetDistance(ts.target, myHero) < 125 and Config.combo.usee and Eready then
				CastSpell(_E)
				myHero:Attack(Target)
			end
			if GetDistance(ts.target, myHero) < 600 and Config.combo.user and Rready and Eready == false  then
				CastSpell(_R)
			end
		end
	end
end

function CheckHeroCollision(pos)

    for i, enemy in ipairs(GetEnemyHeroes()) do
        if ValidTarget(enemy) and _GetDistanceSqr(enemy) < math.pow(925 * 1.5, 2) and menu.targets[enemy.charName] == 1 then
            local proj1, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(player), pos, Vector(enemy))
            if (_GetDistanceSqr(enemy, proj1) <= math.pow(enemy.minBBox * 2 + 70, 2)) then
                return true
            end
        end
    end
    return false

end

function OnTargetInterruptable(unit, spell)
    -- Don't grab on low health
    if GetLeastHealthAround() < Config.ag.agper then return end

    if Rready and GetDistance(unit, myHero) < 600 then
        CastSpell(_R)
    end
end

function OnTargetGapclosing(unit, spell)
    -- Don't grab on low health
    if GetLeastHealthAround() < Config.ag.agper then return end

    if Qready then
        CastSpell(_Q, unit.x, unit.z)
    end
end

function GetLeastHealthAround()

    local ph = player.health / player.maxHealth * 100
    for i, ally in ipairs(GetAllyHeroes()) do
        local ah = ally.health / ally.maxHealth * 100
        if ah <= ph and not ally.dead and _GetDistance(ally) < 700 * 700 then
            ph = ah
        end
    end
    return ph

end

function OnSpellcheck()
	if myHero:CanUseSpell(_Q) == READY then
		Qready = true
	else
		Qready = false
	end
	
	if myHero:CanUseSpell(_W) == READY then
		Wready = true
	else
		Wready = false
	end
	
	if myHero:CanUseSpell(_E) == READY then
		Eready = true
	else
		Eready = false
	end
	
	if myHero:CanUseSpell(_R) == READY then
		Rready = true
	else
		Rready = false
	end
end
