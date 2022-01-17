local assets =
{
	Asset( "ANIM", "anim/diana.zip" ),
	Asset( "ANIM", "anim/ghost_diana_build.zip" ),
}

local skins =
{
	normal_skin = "diana",
	ghost_skin = "ghost_diana_build",
}

local base_prefab = "diana"

local tags = {"BASE" ,"diana", "CHARACTER"}

return CreatePrefabSkin("diana_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	skin_tags = tags,
	
	build_name_override = "diana",
	rarity = "Character",
})