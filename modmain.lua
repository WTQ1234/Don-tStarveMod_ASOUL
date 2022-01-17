GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
	"diana",  --人物代码文件
	"diana_none",  --人物皮肤
}
---对比老版本 主要是增加了names图片 人物检查图标 还有人物的手臂修复（增加了上臂）
--人物动画里面有个SWAP_ICON 里面的图片是在检查时候人物头像那里显示用的


----2019.05.08 修复了 人物大图显示错误和检查图标显示错误

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/diana.tex" ), --存档图片
    Asset( "ATLAS", "images/saveslot_portraits/diana.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/diana.tex" ), --单机选人界面
    Asset( "ATLAS", "images/selectscreen_portraits/diana.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/diana_silho.tex" ), --单机未解锁界面
    Asset( "ATLAS", "images/selectscreen_portraits/diana_silho.xml" ),

    Asset( "IMAGE", "bigportraits/diana.tex" ), --人物大图（方形的那个）
    Asset( "ATLAS", "bigportraits/diana.xml" ),
	
	Asset( "IMAGE", "images/map_icons/diana.tex" ), --小地图
	Asset( "ATLAS", "images/map_icons/diana.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_diana.tex" ), --tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_diana.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_diana.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_diana.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_diana.tex" ), --人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_diana.xml" ),
	
	Asset( "IMAGE", "images/names_diana.tex" ),  --人物名字
    Asset( "ATLAS", "images/names_diana.xml" ),
	
    Asset( "IMAGE", "bigportraits/diana_none.tex" ),  --人物大图（椭圆的那个）
    Asset( "ATLAS", "bigportraits/diana_none.xml" ),

--[[---注意事项
1、目前官方自从熔炉之后人物的界面显示用的都是那个椭圆的图
2、官方人物目前的图片跟名字是分开的 
3、names_diana 和 diana_none 这两个文件需要特别注意！！！
这两文件每一次重新转换之后！需要到对应的xml里面改对应的名字 否则游戏里面无法显示
具体为：
降names_esctemplatxml 里面的 Element name="diana.tex" （也就是去掉names——）
将diana_none.xml 里面的 Element name="diana_none_oval" 也就是后面要加  _oval
（注意看修改的名字！不是两个都需要修改）
	]]
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

GLOBAL.PREFAB_SKINS["diana"] = {   --修复人物大图显示
	"diana_none",
}

modimport("main/myth_character_health.lua")
modimport("main/myth_character_language.lua")
modimport("main/myth_character_containers.lua")

AddMinimapAtlas("images/map_icons/diana.xml")  --增加小地图图标

-- --增加人物到mod人物列表的里面 性别为女性（MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
AddModCharacter("diana", "FEMALE")


--------------------------------  选人界面 ui相关
CHARACTER_BUTTON_OFFSET.diana = -50
CHARACTER_BUTTON_SCALE.diana = .3

--------------------------------  查看代码资源位置

local function GetBuild(inst)
	local strnn = ""
    local str = inst.entity:GetDebugString()
	
	if not str then
		return nil
	end
	local bank,build,anim = str:match("bank: (.+) build: (.+) anim: .+:(.+) Frame")
	
	if bank ~= nil and  build ~= nil then
		strnn = strnn.."动画: anim/"..bank..".zip"
		strnn = strnn.."\n".."贴图: anim/"..build..".zip"
	end
	return strnn 
end

AddClassPostConstruct("widgets/hoverer",function(self)
	local old_SetString = self.text.SetString
	self.text.SetString = function(text,str)
		local target = TheInput:GetHUDEntityUnderMouse()
		if target ~= nil then
			target = target.widget ~= nil and target.widget.parent ~= nil and target.widget.parent.item
		else
			target = TheInput:GetWorldEntityUnderMouse()
		end
		if target and target.entity ~= nil then
			if target.prefab ~= nil then
				str = str.."\n".."代码:"..target.prefab
			end
			local build = GetBuild(target)
			if build ~= nil then
				str = str.."\n"..build
			end
		end
		return old_SetString(text,str)
	end
end)
