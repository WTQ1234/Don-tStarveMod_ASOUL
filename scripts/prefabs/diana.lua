local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- 初始物品
local start_inv = {
}

-- 定义水果种类
local fruits = {
	pomegranate = true,
	pomegranate_cooked = true,
	dragonfruit = true,
	dragonfruit_cooked = true,
	cave_banana = true,
	cave_banana_cooked = true,
	durian = true,
	durian_cooked = true,
	watermelon = true,
	watermelon_cooked = true,
	peach = true,
	peach_cooked = true,	
}

-- 当人物复活的时候
local function onbecamehuman(inst)
	-- 设置人物的移速（1表示1倍于wilson）
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "diana_speed_mod", 1)
	--（也可以用以前的那种
	--inst.components.locomotor.walkspeed = 4
	--inst.components.locomotor.runspeed = 6）
end
--当人物死亡的时候
local function onbecameghost(inst)
	-- 变成鬼魂的时候移除速度修正
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "diana_speed_mod")
end

-- 重载游戏或者生成一个玩家的时候
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


--这个函数将在服务器和客户端都会执行
--一般用于添加小地图标签等动画文件或者需要主客机都执行的组件（少数）
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "diana.tex" )
end

--------------------------------------  监听事件
local function OnEat(inst,data)
	if data and data.food then
		if  fruits[data.food.prefab] ~= nil then
			inst.components.sanity:DoDelta(6)
		end
		if  data.food.components.edible and data.food.components.edible.foodtype == FOODTYPE.MEAT then
			inst.components.talker:Say(STRINGS.MKONEATMEAT)
		end		
		if data.food.prefab == "peach_banquet" then
			inst.components.talker:Say("这一回让俺老孙吃个尽兴！")
		end
	end
end

-- 这里的的函数只在主机执行  一般组件之类的都写在这里
local master_postinit = function(inst)
	-- 人物音效
	inst.soundsname = "willow"

	inst.Transform:SetScale(1.5, 1.5, 1.5)

	-- 三维	
	inst.components.health:SetMaxHealth(TUNING.DIANA_HEALTH)
	inst.components.hunger:SetMax(TUNING.DIANA_HUNGER)
	inst.components.sanity:SetMax(TUNING.DIANA_SANITY)
	-- 伤害系数
    inst.components.combat.damagemultiplier = TUNING.DIANA_DAMAGE
	-- 饥饿速度
	inst.components.hunger:SetRate(TUNING.DIANA_HUNGER_RATE_MODIFIER * TUNING.WILSON_HUNGER_RATE)
	-- 食谱  todo 粘贴自warly.lua 需要测试
    if inst.components.eater ~= nil then
        inst.components.eater:SetPrefersEatingTag("preparedfood")
        inst.components.eater:SetPrefersEatingTag("pre-preparedfood")
    end

	-- 添加监听
	inst:ListenForEvent("oneat", OnEat)

	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("diana", prefabs, assets, common_postinit, master_postinit, start_inv)
