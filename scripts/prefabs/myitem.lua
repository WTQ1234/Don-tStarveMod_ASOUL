-- prefab 名称应当与modmain中注册的名称一致
local assets=
{ 
    Asset("ANIM", "anim/myitem_build.zip"),--这个是放在地上的动画文件
    Asset("ANIM", "anim/swap_myitem_build.zip"), --这个是手上动画
    Asset("ATLAS", "images/inventoryimages/myitem.xml"),--物品栏图标的xml
    Asset("IMAGE", "images/inventoryimages/myitem.tex"),--物品栏图标的图片
}
--目前我还弄不清楚下面这代码的具体意义，但就先这样空着吧，不能随意乱删，因为有一定的格式要求
local prefabs = 
{
}
local function OnEquip(inst, owner) --当你把武器装备到手上时，会触发这个函数
    owner.AnimState:OverrideSymbol("swap_object", "swap_myitem_build", "swap_myitem")--这句话的含义是，用swap_myitem_build这个文件里的swap_myitem这个symbol，覆盖人物的swap_object这个symbol。swap_object，是人物身上的一个symbol，swap_myitem_build，则是我们之前准备好的，用于手持武器的build，swap_myitem就是存放手持武器的图片的文件夹的名字，mod tools自动把它输出为一个symbol。
    owner.AnimState:Show("ARM_carry") --显示持物手
    owner.AnimState:Hide("ARM_normal") --隐藏普通的手
end
local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") --隐藏持物手
    owner.AnimState:Show("ARM_normal") --显示普通的手
end
local function fn()--这个函数就是实际创建物体的函数，上面所有定义到的函数，变量，都需要直接或者间接地在这个函数中使用，才能起作用
    local inst = CreateEntity()--创建一个实体，常见的各种inst，根源就是在这里。
    local trans = inst.entity:AddTransform()--给实体添加转换组件，这主要涉及的是空间位置的转换和获取
    local anim = inst.entity:AddAnimState()--给实体添加动画组件，从而实体能在游戏上显示出来。
    MakeInventoryPhysics(inst)--给实体设定为"物品"的物理属性，这是一个写在data\scripts\standardcomponents里的标准函数，类似的还有MakeCharacterPhysics，就是设定"人物"的物理属性，基本上所有会动的生物，都会有MakeCharacterPhysics

    anim:SetBank("myitem_bank")--设置实体的bank，此处是指放在地上的时候，下同
    anim:SetBuild("myitem_build")--设置实体的build
    anim:PlayAnimation("idle")--设置实体播放的动画

    inst:AddComponent("inventoryitem")--添加物品栏物品组件，只有有了这个组件，你才能把这个物品捡起放到物品栏里。
    inst.components.inventoryitem.imagename = "myitem" --物品栏图片的名字
    inst.components.inventoryitem.atlasname = "images/inventoryimages/myitem.xml"--物品栏图片的xml文件。为什么会有这么两句呢？在单个文件下也许会迷惑，但如果换成一个张大图就容易理解了。举个例子，游戏的操作界面,HUD，你可以在data\images下找到HUD.tex，用textool打开就会看到是一整张大的图片，包含了整个操作界面的所有图片，xml就是用来切割分块这张大的图片，并分别给它们重新命名的，新的命名就会被前面的imagename 使用。
    inst:AddComponent("equippable")--添加可装备组件，有了这个组件，你才能装备物品
    inst.components.equippable:SetOnEquip( OnEquip ) -- 设定物品在装备和卸下时执行的函数。在前面定义的两个函数是OnEquip，OnUnequip里，我们主要是围绕着改变人物外形设定了一些基本代码。 在装上的时候，会让人物的持物手显示出来，普通手隐藏，卸下时则反过来。需要注意的是，OnEquip，OnUnequip都是本地函数，要想让它们发挥作用，就必须要通过这里的组件接口来实现。
    inst.components.equippable:SetOnUnequip( OnUnequip )

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(damage)--设置武器的攻击力damage

    inst:AddComponent("finiteuses")--添加有限耐久组件，按次数算
    inst.components.finiteuses:SetMaxUses(MaxUse)--设置最大耐久MaxUse
    inst.components.finiteuses:SetUses(CanUse)--设置当前耐久CanUse

    print(11111)
    return inst
end
return Prefab("common/inventory/myitem", fn, assets, prefabs)--最后，返回这个实体到modmain里注册。Prefab这个函数，第一个参数只需要看最后一个/后面的部分，视为这个prefab的ID，fn则是上面定义的fn，是这个物品的创建函数，assets，对应上面的assets，主要是用于注册美术资源，如果你在这里注册了相应的美术资源，就不需要在modmain里再注册一次。prefabs，目前还未明确具体的作用。
