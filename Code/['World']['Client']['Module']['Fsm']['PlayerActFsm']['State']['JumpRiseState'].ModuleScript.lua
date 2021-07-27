local JumpRiseState = class('JumpRiseState', C.PlayerActState)

function JumpRiseState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    local animsM = {
        {'anim_man_jump_riseuploop_01', 0.0, 1.0},
        {'anim_man_jumpforward_riseuploop_02', 0.5, 1.0}
    }
    local animsW = {
        {'anim_woman_jump_riseuploop_01', 0.0, 1.0},
        {'anim_woman_jumpforward_riseuploop_02', 0.5, 1.0}
    }
    C.PlayerAnimMgr:Create1DClipNode(animsM, 'speedXZ', _stateName, 1)
    C.PlayerAnimMgr:Create1DClipNode(animsW, 'speedXZ', _stateName, 2)
end
function JumpRiseState:InitData()
    self.isKeepMoving = false 
    self:AddTransition('ToJumpHighestState', self.controller.states['JumpHighestState'], 0.2)
end

function JumpRiseState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.1, 0.1, true, true, 1)
    self.controller.jumpCount = self.controller.jumpCount - 1
end

function JumpRiseState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:FallMonitor()
    self:Move()
    self:SpeedMonitor()
    --[[if self.isKeepMoving then
        localPlayer:AddMovementInput(localPlayer.Forward * localPlayer.Velocity.Magnitude*200)
    end]]
end

function JumpRiseState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.isKeepMoving = false
end

return JumpRiseState
