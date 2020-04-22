--- 游戏服务器主逻辑
-- @module Game Manager, Server-side
-- @copyright Lilith Games, Avatar Team
-- @author XXX, XXXX
local GameMgr, this =
    {
        isRun = false,
        dt = 0, -- delta time 每帧时间
        tt = 0 -- total time 游戏总时间
    },
    nil

--- 初始化
function GameMgr:Init()
    print('[信息] GameMgr:Init')
    this = self
    self:InitListeners()

    -- TODO: 其他服务器模块初始化
    ExampleA:Init()
    CsvConfig:Init()
end

--- 初始化Game Manager自己的监听事件
function GameMgr:InitListeners()
    EventUtil.LinkConnects(world.S_Event, GameMgr, 'GameMgr', this)
end

--- Update函数
-- @param dt delta time 每帧时间
function GameMgr:Update(dt)
    -- TODO: 其他服务器模块Update
    ExampleA:Update(dt)
end

function GameMgr:StartUpdate()
    print('[信息] GameMgr:StartUpdate')
    if self.isRun then
        print('[警告] GameMgr:StartUpdate 正在运行')
        return
    end

    self.isRun = true

    while (self.isRun) do
        self.dt = wait()
        self.tt = self.tt + self.dt
        self:Update(self.dt)
    end
end

function GameMgr:StopUpdate()
    print('[信息] GameMgr:StopUpdate')
    self.isRun = false
end

--- TEST ONLY 处理Example01CustomEvent事件
-- 函数命名格式为 事件名 + 'Handler'
function GameMgr:Example01CustomEventHandler()
    print('[信息] 收到Example01CustomEvent')
    self:StartUpdate()
end

--- TEST ONLY 处理Example02CustomEvent事件
-- 函数命名格式为 事件名 + 'Handler'
function GameMgr:Example02CustomEventHandler()
    print('[信息] 收到Example02CustomEvent')
    print('打印预加载的表格Example01,单一主键')
    table.dump(CsvConfig.Example01)
    print('打印预加载的表格Example01,多主键')
    table.dump(CsvConfig.Example02)
end

--- TEST ONLY 处理Example02CustomEvent事件
-- 函数命名格式为 事件名 + 'Handler'
function GameMgr:Example03CustomEventHandler()
    print('[信息] 收到Example03CustomEvent')
    self:StopUpdate()
end

return GameMgr
