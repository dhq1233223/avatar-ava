--- 游戏服务器主逻辑
-- @module Game Manager, Server-side
-- @copyright Lilith Games, Avatar Team
-- @author Yuancheng Zhang
local GameMgr, this =
    {
        isRun = false,
        dt = 0, -- delta time 每帧时间
        tt = 0 -- total time 游戏总时间
    },
    nil

--- 初始化
function GameMgr:Init()
    info('GameMgr:Init')
    this = self
    self:InitListeners()

    TimeMgr:Init()
    GameCsv:Init()

    -- TODO: 其他服务器模块初始化
    ExampleA:Init()
end

--- 初始化Game Manager自己的监听事件
function GameMgr:InitListeners()
    EventUtil.LinkConnects(world.S_Event, GameMgr, 'GameMgr', this)
end

--- Update函数
-- @param dt delta time 每帧时间
function GameMgr:Update(dt, tt)
    -- TODO: 其他服务器模块Update
    ExampleA:Update(dt, tt)
end

--- 开始Update
function GameMgr:StartUpdate()
    info('GameMgr:StartUpdate')
    if self.isRun then
        warn('GameMgr:StartUpdate 正在运行')
        return
    end

    self.isRun = true

    while (self.isRun) do
        self.dt = wait()
        self.tt = self.tt + self.dt
        self:Update(self.dt, self.tt)
    end
end

--- 停止Update
function GameMgr:StopUpdate()
    info('GameMgr:StopUpdate')
    self.isRun = false
end

--- TEST ONLY 处理Test01ServerEvent事件
-- 函数命名格式为 事件名 + 'Handler'
function GameMgr:Test01ServerEventHandler()
    test('收到Test01ServerEvent')
    self:StartUpdate()
end

--- TEST ONLY 处理Test02ServerEvent事件
-- 函数命名格式为 事件名 + 'Handler'
function GameMgr:Test02ServerEventHandler()
    test('收到Test02ServerEvent')
    test('GameCsv打印预加载的表格Example01,单一主键')
    table.dump(GameCsv.Test01)
    test('GameCsv打印预加载的表格Example02,多主键')
    table.dump(GameCsv.Test02)
    test('GameCsv打印预加载的表格Example02,单一主键,主键为Type')
    table.dump(GameCsv.Test03)
end

--- TEST ONLY 处理Test02ServerEvent事件
-- 函数命名格式为 事件名 + 'Handler'
function GameMgr:Test03ServerEventHandler()
    test('[信息] 收到Test03ServerEvent')
    self:StopUpdate()
end

return GameMgr