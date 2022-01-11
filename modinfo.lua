--The name of the mod displayed in the 'mods' screen.
name = "My item example" --Mod的名字

--A description of the mod.
description = "A simple item example" --Mod描述

author = "LongFei" --作者名
 
version = "0.1"  --Mod版本

api_version = 10  --mod的API版本

-- Compatible with both the base game, reign of giants, and dst
--以下几句，都是设置兼容性的，分别对应DS，ROG,SW和DST
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
dst_compatible = true
    
icon_atlas = ""--mod的图标设置
icon = ""--mod的图标图片

forumthread = ""  --MOD在klei论坛的下载地址，没有可以留空，但不可删除

--These let clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true
clients_only_mod = false

--This lets people search for servers with this mod by these tags
server_filter_tags = {"utility"}

-- ModConfiguration option
configuration_options =
{
	{
		name = "MAXSTACKSIZE",
		label = "Max stacksize",
		options =	{
						{description = "20", data = 20},
						{description = "40", data = 40},
						{description = "60", data = 60},
						{description = "80", data = 80},
						{description = "99", data = 99},
						{description = "120", data = 120},
						{description = "150", data = 150},
						{description = "200", data = 200},
						{description = "250", data = 250},
					},

		default = 99,
	},
}

priority = 0.00374550642
--priority = -9999 --mod的启动优先级，越低的越晚启动，一般不用设置，除非和其他MOD有冲突需要调整
