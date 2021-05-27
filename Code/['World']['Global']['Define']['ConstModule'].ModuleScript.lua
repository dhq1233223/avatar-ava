--- 全局常量的定义,全部定义在Const这张表下面,用于定义全局常量参数或者枚举类型
-- @module Constant Defines
-- @copyright Lilith Games, Avatar Team
local Const = {}

-- e.g. (need DELETE)
Const.MAX_PLAYERS = 4

-- 语言枚举
Const.LanguageEnum = {
    CHS = 'CHS', -- 简体中文
    CHT = 'CHT', -- 繁体中文
    EN = 'EN', -- 英文
    JP = 'JP' -- 日文
}

Const.PooledObjectState = {
    IDLE = 'IDLE', --空闲状态
    ALLOCATED = 'ALLOCATED', -- 使用中
    EVICTION = 'EVICTION', -- 在空闲队列中，并正在测试是否满足被释放的条件
    ABANDONED = 'ABANDONED', -- 已经废弃，将要/已经 被销毁
    RETURNING = 'RETURNING' -- 正在使用完毕，返回池中
}

return Const
