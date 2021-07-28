local JumpHighestState = class('JumpHighestState', C.PlayerActState)

function JumpHighestState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    local anims = {
        {'anim_woman_jumpforward_highest_01', 0.0, 1.0},
        {'anim_woman_jumpforward_highest_02', 0.3, 1.0}
    }
    self.animNode = C.PlayerAnimMgr:Create1DClipNode(anims, 'speedXZ')
end
function JumpHighestState:InitData()
    self:AddTransition('ToFallState', self.controller.states['FallState'], 0.5)
    self:AddTransition(
        'ToDoubleJumpState',
        self.controller.states['DoubleJumpState'],
        -1,
        function()
            return self.controller.triggers['DoubleJumpState']
        end
    )
    self:AddTransition(
        'ToDoubleJumpSprintState',
        self.controller.states['DoubleJumpSprintState'],
        -1,
        function()
            return self.controller.triggers['DoubleJumpSprintState']
        end
    )
end

function JumpHighestState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.1, 0.1, true, false, 1)
end

function JumpHighestState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Move()
    self:SpeedMonitor()
end

function JumpHighestState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return JumpHighestState
