local FlyMoveState = class('FlyMoveState', C.PlayerActState)

function FlyMoveState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    local animsM = {
        {'anim_man_hoverIdle_01', 0.0, 1.0},
        {'anim_man_hoveforward_01', 0.5, 1.0}
    }
    local animsW = {
        {'anim_woman_hoveridle_01', 0.0, 1.0},
        {'anim_woman_hoverforward_01', 0.5, 1.0}
    }
    C.PlayerAnimMgr:Create1DClipNode(animsM, 'speedXZ', _stateName, 1)
    C.PlayerAnimMgr:Create1DClipNode(animsW, 'speedXZ', _stateName, 2)
end
function FlyMoveState:InitData()
    self:AddTransition(
        'ToFlyIdleState',
        self.controller.states['FlyIdleState'],
        -1,
        function()
            return not self:MoveMonitor()
        end
    )
    self:AddTransition(
        'ToFlyEndState',
        self.controller.states['FlyEndState'],
        -1,
        function()
            return self:FloorMonitor(0.06)
        end
    )
    self:AddTransition(
        'ToFlySprintBeginState',
        self.controller.states['FlySprintBeginState'],
        -1,
        function()
            return C.PlayerControl.isSprint
        end
    )
end

function FlyMoveState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, true, 1)
end

function FlyMoveState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:SpeedMonitor(localPlayer.MaxFlySpeed)
    self:Fly()
end
function FlyMoveState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return FlyMoveState
