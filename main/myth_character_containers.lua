local containers = require "containers"
local params = containers.params

--------------------------------------------------------------------------
--[[ 杨戬快递鹰 ]]
--------------------------------------------------------------------------

params.yangjian_buzzard =
{
    widget =
    {
        slotpos = {Vector3(80 - 80 * 2 + 80, 0, 0)},
        animbank = "ui_chest_3x3",
        animbuild = "ui_yangjian_buzzard_1x1",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

function params.yangjian_buzzard.itemtestfn(container, item, slot)
    return  not item:HasTag("irreplaceable")
end

--------------------------------------------------------------------------
--[[ 捣药罐 ]]
--------------------------------------------------------------------------

local items_pestle_special = { --没有新鲜度，但能放进捣药罐的物品
    spidergland = true,
    powder_m_takeiteasy = true,
    powder_m_becomestar = true,
    powder_m_charged = true,
    powder_m_improvehealth = true,
    powder_m_lifeelixir = true,
    powder_m_coldeye = true,
    powder_m_hypnoticherb = true,
}

local items_pestle_ban = { --有新鲜度，但不可以放进捣药罐的物品
    peach = true,
    bigpeach = true,
    peach_cooked = true,
    lotus_flower = true,
    lotus_flower_cooked = true,
    ice = true,
    royal_jelly = true,
    glommerflower = true,
}

params.medicine_pestle_myth = {
    widget = {
        slotpos = {
            Vector3(0, 32 + 4, 0),
            Vector3(0, -(32 + 4), 0)
        },
        animbank = "ui_cookpot_1x2",
        animbuild = "ui_cookpot_1x2",
        pos = Vector3(200, 0, 0),
        side_align_tip = 100
    },
    acceptsstacks = false,
    type = "cooker"
}

function params.medicine_pestle_myth.itemtestfn(container, item, slot)
    if items_pestle_special[item.prefab] or item:HasTag("yes_pestle_myth") then
        return true
    end
    if not items_pestle_ban[item.prefab] and (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled"))
        and not item:HasTag("_health")
        and not item:HasTag("preparedfood")
        and not item:HasTag("meat")
        and not item:HasTag("fish")
        and not item.replica.equippable
    then
        return true
    end
    return false
end

--------------------------------------------------------------------------
--[[ 采药篓 ]]
--------------------------------------------------------------------------

local items_basket_special = { --没有新鲜度，但能放进采药篓的物品
    spidergland = true,
    powder_m_takeiteasy = true,
    powder_m_becomestar = true,
    powder_m_charged = true,
    powder_m_improvehealth = true,
    powder_m_lifeelixir = true,
    powder_m_coldeye = true,
    powder_m_hypnoticherb = true,
    goldnugget = true,
    lightninggoathorn = true,
    feather_canary = true,
    minotaurhorn = true,
    deerclops_eyeball = true,
    deer_antler1 = true, deer_antler2 = true, deer_antler3 = true,
    beefalowool = true,
    mandrake = true,
}

params.myth_bamboo_basket =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_piggyback_2x6",
        animbuild = "ui_piggyback_2x6",
        pos = Vector3(-5, -50, 0),
    },
    issidewidget = true,
    type = "pack",
    openlimit = 1,
}

for y = 0, 5 do
    table.insert(params.myth_bamboo_basket.widget.slotpos, Vector3(-162, -75 * y + 170, 0))
    table.insert(params.myth_bamboo_basket.widget.slotpos, Vector3(-162 + 75, -75 * y + 170, 0))
end

function params.myth_bamboo_basket.itemtestfn(container, item, slot)
    if items_basket_special[item.prefab] or item:HasTag("yes_basket_myth") then
        return true
    end

    if not items_pestle_ban[item.prefab] and (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled"))
        and not item:HasTag("_health")
        and not item:HasTag("preparedfood")
        and not item:HasTag("meat")
        and not item:HasTag("fish")
        and not item.replica.equippable
    then
        return true
    end
    return false
end
params.myth_bamboo_basket.priorityfn = params.myth_bamboo_basket.itemtestfn

--------------------------------------------------------------------------
--[[ 无常管帽 ]]
--------------------------------------------------------------------------

local yyyy =  math.ceil(GetMaxItemSlots(TheNet:GetServerGameMode())/20)*80 -20 --兼容多层物品栏用

params.hat_commissioner_black =
{
    widget =
    {
        slotpos =
        {
            Vector3(0,   32 + 4,  0),
            Vector3(0, -(32 + 4), 0),
        },
        animbank = "ui_cookpot_1x2",
        animbuild = "ui_cookpot_1x2",
        pos = Vector3(106, yyyy, 0),
    },
    usespecificslotsforitems = true,
    type = "hand_inv",
}
function params.hat_commissioner_black.itemtestfn(container, item, slot)
	return (slot == nil and item:HasTag("soul_lost"))
		or (slot == 1 and item:HasTag("soul_ghast"))
		or (slot == 2 and item:HasTag("soul_specter"))
end
params.hat_commissioner_black.priorityfn = params.hat_commissioner_black.itemtestfn

-----

params.hat_commissioner_white =
{
    widget =
    {
        slotpos =
        {
            Vector3(0,   32 + 4,  0),
            Vector3(0, -(32 + 4), 0),
        },
        animbank = "ui_cookpot_1x2",
        animbuild = "ui_cookpot_1x2",
        pos = Vector3(106, yyyy, 0),
    },
    usespecificslotsforitems = true,
    type = "hand_inv",
}
function params.hat_commissioner_white.itemtestfn(container, item, slot)
	return (slot == nil and item:HasTag("soul_lost"))
		or (slot == 1 and item:HasTag("soul_specter"))
		or (slot == 2 and item:HasTag("soul_ghast"))
end
params.hat_commissioner_white.priorityfn = params.hat_commissioner_white.itemtestfn

params.madameweb_armor =
{

    widget =
    {
        slotpos =
        {
            Vector3(0,   32 + 4,  0),
            Vector3(0, -(32 + 4), 0),
        },
        animbank = "ui_cookpot_1x2",
        animbuild = "ui_cookpot_1x2",
        pos = Vector3(60, yyyy, 0),
    },
    --usespecificslotsforitems = true,
    type = "hand_inv",
}

function params.madameweb_armor.itemtestfn(container, item, slot)
	return item:HasTag("silkcontaineritem") or item:HasTag("spider")
end

--------------------
--------------------

params.madameweb_silkcocoon_container =
{
    widget =
    {
        slotpos =
        {
            Vector3(0, 0, 0),
        },
        animbank = "ui_bundle_2x2",
        animbuild = "ui_bundle_2x2",
        pos = Vector3(200, 0, 0),
        side_align_tip = 120,
        buttoninfo =
        {
            text = STRINGS.ACTIONS.WRAPBUNDLE,
            position = Vector3(0, -100, 0),
        }
    },
    type = "cooker",
}

function params.madameweb_silkcocoon_container.itemtestfn(container, item, slot)
    return not (item:HasTag("irreplaceable") or item:HasTag("_container") or item:HasTag("bundle") or item:HasTag("nobundling"))
end

function params.madameweb_silkcocoon_container.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.WRAPBUNDLE):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.WRAPBUNDLE.code, inst, ACTIONS.WRAPBUNDLE.mod_name)
    end
end

function params.madameweb_silkcocoon_container.widget.buttoninfo.validfn(inst)
    return inst.replica.container ~= nil and not inst.replica.container:IsEmpty()
end

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end



