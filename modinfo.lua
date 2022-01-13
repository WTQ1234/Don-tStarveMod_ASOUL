local L = locale ~= "zh" and locale ~= "zhr" -- true 英文; false 中文

-- mod版本 上传mod需要两次的版本不一样
version = "0.0.1"
-- mod名字
name = L and "[ASOUL] Characters Diana" or "[ASOUL] 人物 王嘉然"
-- mod描述
description =
    L and "天使幼崽与魔王幼崽·篇\nThanks for using this mod!\n[version]" .. version .. "  [file]\n\nmods by ASOUL fans"
    or "天使幼崽与魔王幼崽·篇\n感谢订阅本mod!\n[版本]"..version.."  [文件]\n\nASOUL 粉丝自制二创"
-- 作者
author = "是敢敢呢"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 6
api_version_dst = 10


dst_compatible = true                   -- 兼容联机
dont_starve_compatible = false          -- 不兼容原版
reign_of_giants_compatible = false      -- 不兼容巨人DLC
shipwrecked_compatible = false          -- 不兼容海难DLC

all_clients_require_mod = true --所有人mod
-- client_only_mod = true

icon_atlas = "modicon.xml" -- mod图标
icon = "modicon.tex"

priority = -1000000000 --后加载

-- 服务器列表标签
server_filter_tags = L and { "ASOUL: characters" } or { "ASOUL: 人物" }

-- mod设置
configuration_options =
{
    L and {
        name = 'Skillbadge',
        label = 'Skill badge',
        hover = 'Show skill badge',
        options =
        {
            {description = 'Yes', data = true},
            {description = 'No', data = false},
        },
        default = true
    } or {
        name = 'Skillbadge',
        label = '角色技能按钮',
        hover = '是否显示角色技能的按钮',
        options =
        {
            {description = '是', data = true},
            {description = '否', data = false},
        },
        default = true
    },
}

--兼容动态加载mod
-- StaticAssetsReg = {'monkey_king', 'myth_skins_prefab'}