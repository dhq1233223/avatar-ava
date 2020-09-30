--- 客户端模块基础类, Client Module Base Class
-- @module ClientBase, Client-side
-- @copyright Lilith Games, Avatar Team
-- @author Yuancheng Zhang
local ClientBase = class('ClientBase')

function ClientBase:GetSelf()
    return self
end

--- 加载的时候运行的代码
function ClientBase:InitDefault(_module)
    -- print(string.format('InitDefault:%s', self.name))
    -- 初始化默认监听事件
    LinkConnects(localPlayer.C_Event, _module, self)
end

return ClientBase
