if myHero.charName ~= "Lulu" then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("VILJMOOPHPH") 

local version = 1.04
local AUTO_UPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/seanlol/bol/master/SEAN Lulu.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = LIB_PATH.."SEAN Lulu.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

local function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>SEAN Lulu:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
local function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>Welcome " .. GetUser() .. " Auth Successed By http://seanlol.com Have Good Game. </b>")end
if AUTO_UPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/seanlol/bol/master/version/SEAN Lulu.version")
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

require 'VPrediction'
require 'SxOrbWalk'
require 'sourceLib'

local HPred, SxO, STS = nil, nil, nil
local ts
local Qrance, Wrance, Erance, Rrance = 950, 650, 650, 900 
local Config = nil
local player = myHero
local enemyHeroes = GetEnemyHeroes()
local allyHeroes = GetAllyHeroes()
local enemyMinions = minionManager(MINION_ENEMY, 1500, myHero, MINION_SORT_MAXHEALTH_DEC)
local jungleMinions = minionManager(MINION_JUNGLE, 1500, myHero, MINION_SORT_MAXHEALTH_DEC)

local InterruptList = {
    { charName = "Caitlyn", spellName = "CaitlynAceintheHole"},
    { charName = "FiddleSticks", spellName = "Crowstorm"},
    { charName = "FiddleSticks", spellName = "DrainChannel"},
    { charName = "Galio", spellName = "GalioIdolOfDurand"},
    { charName = "Karthus", spellName = "FallenOne"},
    { charName = "Katarina", spellName = "KatarinaR"},
    { charName = "Lucian", spellName = "LucianR"},
    { charName = "Malzahar", spellName = "AlZaharNetherGrasp"},
    { charName = "MissFortune", spellName = "MissFortuneBulletTime"},
    { charName = "Nunu", spellName = "AbsoluteZero"},
    { charName = "Pantheon", spellName = "Pantheon_GrandSkyfall_Jump"},
    { charName = "Shen", spellName = "ShenStandUnited"},
    { charName = "Urgot", spellName = "UrgotSwap2"},
    { charName = "Varus", spellName = "VarusQ"},
    { charName = "Warwick", spellName = "InfiniteDuress"}
}
local ToInterrupt = {}

function OnLoad()
	
	VP		= VPrediction()
	STS		= SimpleTS()
	SxO		= SxOrbWalk()
	
	
	LoadMenu()
	
	for i = 1, heroManager.iCount do 
        local hero = heroManager:GetHero(i) 
		for _, champ in pairs(InterruptList) do 
			if hero.charName == champ.charName then 
				table.insert(ToInterrupt, champ.spellName) 
			end
        end 
    end 
end

function OnTick()
	if Config.combo.active then
		OnCombo()
	elseif Config.harass.active then
		OnHarass()
	elseif Config.lc.active then
		OnLineClear()
	end
	OnKillsteal()
	OnSpellcheck()
	if Config.ads.autor and Rready then
		if player.health < (player.maxHealth*(Config.ads.autorper*0.01)) and countEnemy(player, 200) >= 1 then
			CastSpell(_R, player)
		end
		for _, i in pairs (allyHeroes) do
			if i.health < (i.maxHealth*(Config.ads.autorper*0.01)) and countEnemy(i, 200) >= 1 then
				CastSpell(_R, i)
			end
		end
	end
end

function OnDraw()
	if Config.draw.drawq then DrawCircle(player.x, player.y, player.z, Qrance, 0xffff0000) end
	if Config.draw.draww then DrawCircle(player.x, player.y, player.z, Wrance, 0xffff0000) end
	if Config.draw.drawe then DrawCircle(player.x, player.y, player.z, Erance, 0xffff0000) end
	if Config.draw.drawr then DrawCircle(player.x, player.y, player.z, Rrance, 0xffff0000) end
end

function LoadMenu()
	Config = MenuWrapper("[SEAN] " .. player.charName, "unique" .. player.charName:gsub("%s+", ""))
	
		Config:SetTargetSelector(STS)
		Config = Config:GetHandle()
		
			Config:addSubMenu("오브워크설정", "orbwalk")
			SxO:LoadToMenu(Config.orbwalk)
			Config:addSubMenu("스킬콤보설정", "combo")
			Config.combo:addParam("active", "스킬콤보사용", SCRIPT_PARAM_ONKEYDOWN, false, 32)
			Config.combo:addParam("useq", "반짝반짝 창(Q)사용", SCRIPT_PARAM_ONOFF, true)
			--Config.combo:addParam("usew", "변덕쟁이(W)사용", SCRIPT_PARAM_ONOFF, true)
			Config.combo:addParam("usee", "도와줘픽스!(E)사용", SCRIPT_PARAM_ONOFF, true)
			Config.combo:addParam("user", "급성장(R)사용", SCRIPT_PARAM_ONOFF, true)
			
		Config:addSubMenu("견제스킬설정", "harass")
			Config.harass:addParam("active", "견제스킬사용", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			Config.harass:addParam("useq", "반짝반짝 창(Q)사용", SCRIPT_PARAM_ONOFF, true)
			Config.harass:addParam("usew", "변덕쟁이(W)사용", SCRIPT_PARAM_ONOFF, true)
			--Config.harass:addParam("usee", "도와줘픽스!(E)사용", SCRIPT_PARAM_ONOFF, true)
			
		Config:addSubMenu("라인클리어설정", "lc")
			Config.lc:addParam("active", "라인클리어사용", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
			Config.lc:addParam("useq", "반짝반짝 창(Q)사용", SCRIPT_PARAM_ONOFF, true)
			
		Config:addSubMenu("기타기능설정","ads")
			--Config.ads:addParam("autow", "자동쉴드(E)사용", SCRIPT_PARAM_ONOFF, false)
			Config.ads:addParam("interrupt", "스킬캔슬(W)사용", SCRIPT_PARAM_ONOFF, true)
			Config.ads:addParam("smartr", "스마트궁(R)사용", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
			Config.ads:addParam("autor", "자동급성장(R)사용", SCRIPT_PARAM_ONOFF, true)
			Config.ads:addParam("autorper", "자동체력비례(R)%사용", SCRIPT_PARAM_SLICE, 30, 1, 100, 0)
			
		Config:addSubMenu("스킬범위설정", "draw")
			Config.draw:addParam("drawq", "반짝반짝 창(Q)표시", SCRIPT_PARAM_ONOFF, true)
			Config.draw:addParam("draww", "변덕쟁이(W)표시", SCRIPT_PARAM_ONOFF, true)
			Config.draw:addParam("drawe", "도와줘픽스!(E)표시", SCRIPT_PARAM_ONOFF, true)
			Config.draw:addParam("drawr", "급성장(R)표시", SCRIPT_PARAM_ONOFF, true)
		Config:addSubMenu("스크립트정보", "info")
			Config.info:addParam("infoproduce", "스크립트 \193\166\192\219\192\218 : SEAN", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infover", "스크립트 \185\246\192\252 : 1.28", 5, "")
			Config.info:addParam("infotrans", "\199\209\177\219\185\248\191\170 : SEAN", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infosite", "홈페이지 : Seanlol.com", SCRIPT_PARAM_INFO, "")
			Config.info:addParam("infokaka", "카카오톡 : seanlol", SCRIPT_PARAM_INFO, "")
end

function OnCombo()
	local Target = STS:GetTarget(Qrance)
	if Target ~= nil then
		if Config.combo.usee and Eready then
			CastSpell(_E, Target)
		end
		if Config.combo.useq and GetDistance(Target, player) < Qrance then
			local CastPosition, HitChance, Position = VP:GetLineCastPosition(Target, 0.25,60,950, 1600, myHero, false)
			if CastPosition and HitChance >= 2 then
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		end
		if Config.combo.user and Rready then
			SamrtR()
		end
	end
end

function OnHarass()
	local Target = STS:GetTarget(Qrance+Erance)
	if Target ~= nil then
		if GetDistance(Target, player) < Qrance then
			if Config.harass.usew and Eready then
				CastSpell(_W, Target)
			end
			if Config.harass.useq and Qrance then
				local CastPosition, HitChance, Position = VP:GetLineCastPosition(Target, 0.25,60,950, 1600, myHero, false)
				if CastPosition and HitChance >= 2 then
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
			end
		elseif GetDistance(Target, player) < Qrance+Erance then
			SmartW(Target)
			local CastPosition, HitChance, Position = VP:GetLineCastPosition(Target, 0.25,60,950, 1600, myHero, false)
			if CastPosition and HitChance >= 2 then
				DelayAction(function() CastSpell(_Q, CastPosition.x, CastPosition.z) end, 0.5)
			end
		end
	end
end

function OnLineClear()
	enemyMinions:update()
	local minion
	for _, minion in pairs(enemyMinions.objects) do
		if Config.lc.useq then
			local CastPosition, HitChance, Position = VP:GetLineCastPosition(minion, 0.25,60,950, 1600, myHero, false)
			if CastPosition and HitChance >= 2 then
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		end
	end
end

function SamrtR()
	if Rready then
		if countEnemy(player, 200) >= Config.ads.smartr then
			CastSpell(_R, player)
		end
		for _, i in pairs (allyHeroes) do
			if countEnemy(i, 200) >= Config.ads.smartr and GetDistance(i, player) < Rrance then
				CastSpell(_R, i)
			end
		end
	end
end

function countEnemy(allyHero, range)
	local nearEnemy = 0
	for i, e in pairs(enemyHeroes) do
		if GetDistance(allyHero, e) < range then
			nearEnemy = nearEnemy + 1
		end
	end
	return nearEnemy
end

function OnKillsteal()
end

function SmartW(target)
	enemyMinions:update()
	for i, minion in pairs(enemyMinions.objects) do
		if GetDistance(minion, player) < Erance and GetDistance(minion, target) < Qrance and getDmg("E", minion, player) < minion.health and minion ~= nil then
			CastSpell(_E, minion)
		end
	end
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
	
	if myHero:CanUseSpell(_Q) == READY then
		Rready = true
	else
		Rready = false
	end
end

function OnProcessSpell(unit, spell)
	if #ToInterrupt > 0 and WReady then
		for _, ability in pairs(ToInterrupt) do
			if spell.name == ability and unit.team ~= myHero.team and GetDistance(unit) < SpellW.Range then
				CastSpell(_W, unit.x, unit.z)
			end
		end
	end
end
