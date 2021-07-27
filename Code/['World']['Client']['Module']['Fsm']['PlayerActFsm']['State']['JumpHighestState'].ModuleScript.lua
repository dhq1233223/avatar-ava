local JumpHighestState = class('JumpHighestState', C.PlayerActState)

function JumpHighestState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    local animsM = {
        {'anim_man_jumpforward_highest_01', 0.0, 1.0},
        {'anim_man_jumpforward_highest_02', 0.3, 1.0}
    }
    local animsW = {
        {'anim_woman_jumpforward_highest_01', 0.0, 1.0},
        {'anim_woman_jumpforward_highest_02', 0.3, 1.0}
    }
    C.PlayerAnimMgr:Create1DClipNode(animsM, 'speedXZ', _stateName, 1)
    C.PlayerAnimMgr:Create1DClipNode(animsW, 'speedXZ', _stateName, 2)
end
function JumpHighestState:InitData()
    self.isKeepMoving = false
    self:AddTransition('ToFallState', self.controller.states['FallState'], 0.4)
    self:AddTransition(
        'ToLandState',
        self.controller.states['LandState'],
        -1, 
        function()
            return self:FloorMonitor(0.5)
        end
    )
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
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.1, 0.2, true, false, 1)
    if self:MoveMonitor() then
        self.isKeepMoving = true
    end
end

function JumpHighestState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Move()
    self:SpeedMonitor()
    --[[if self.isKeepMoving then
        localPlayer:AddMovementInput(localPlayer.Forward * localPlayer.Velocity.Magnitude * 200)
    end]]
end

function JumpHighestState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.isKeepMoving = false
end

return JumpHighestState
