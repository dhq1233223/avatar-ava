--- 全局常量的定义,全部定义在Const这张表下面,用于定义全局常量参数或者枚举类型
-- @module Constant Defines
-- @copyright Lilith Games, Avatar Team
local Const = {}

-- 将全局变量Const替换成K
_G.K = Const

-- e.g. (need DELETE)
Const.MAX_PLAYERS = 4

-- 语言枚举F
Const.LanguageEnum = {
    CHS = 'CHS', -- 简体中文
    CHT = 'CHT', -- 繁体中文
    EN = 'EN', -- 英文
    JP = 'JP' -- 日文
}

-- FixedUpdate执行间隔
Const.FixedUpdateInterval = 1

return Const
