local MoveState = class('MoveState', C.PlayerActState)

function MoveState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    local anims = {
        {'anim_woman_idle_01', 0.0, 1.0},
        {'anim_woman_walkfront_01', 0.15, 1.0},
        {'anim_woman_runfront_01', 0.5, 1.0},
        {'anim_woman_sprint_01', 1, 1.0}
    }
    self.animNode = C.PlayerAnimMgr:Create1DClipNode(anims, 'speedXZ')
end
function MoveState:InitData()
    self:AddTransition(
        'ToMoveStopState',
        self.controller.states['MoveStopState'],
        -1,
        function()
            return not self:MoveMonitor()
        end
    )
    self:AddTransition(
        'ToJumpBeginState',
        self.controller.states['JumpBeginState'],
        -1,
        function()
            return self.controller.triggers['JumpBeginState']
        end
    )
    self:AddTransition(
        'ToJumpHighestState',
        self.controller.states['JumpHighestState'],
        -1,
        function()
            return self.controller.triggers['JumpHighestState']
        end
    )
    self:AddTransition(
        'ToCrouchBeginState',
        self.controller.states['CrouchBeginState'],
        -1,
        function()
            return self.controller.isCrouch
        end
    )
    self:AddTransition(
        'ToFlyBeginState',
        self.controller.states['FlyBeginState'],
        -1,
        function()
            return self.controller.triggers['FlyBeginState']
        end
    )
end

function MoveState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.2, 0.2, true, true, 1)
end

function MoveState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:SpeedMonitor()
    self:Move(true)
    self:FallMonitor()
end
function MoveState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return MoveState
