local JumpBeginState = class('JumpBeginState', C.PlayerActState)

function JumpBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)

    local animsM = {
        {'anim_man_jump_begin_01', 0.0, 1.0},
        {'anim_man_jumpforward_begin_01', 0.5, 1.0}
    }
    local animsW = {
        {'anim_woman_jump_begin_01', 0.0, 1.0},
        {'anim_woman_jumpforward_begin_01', 0.5, 1.0}
    }

    C.PlayerAnimMgr:Create1DClipNode(animsM, 'speedXZ', _stateName, 1)
    C.PlayerAnimMgr:Create1DClipNode(animsW, 'speedXZ', _stateName, 2)
end
function JumpBeginState:InitData()
    self.isKeepMoving = false
    self:AddTransition('ToJumpRiseState', self.controller.states['JumpRiseState'], 0.1)
end

function JumpBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.1, 0.1, true, false, 1)
    if self:MoveMonitor() then
        self.isKeepMoving = true
    end
end

function JumpBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    if self.isKeepMoving then
        localPlayer:AddMovementInput(localPlayer.Forward * localPlayer.Velocity.Magnitude * 0.1)
        print(localPlayer.Forward * localPlayer.Velocity.Magnitude * 20)
    end
end

function JumpBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:Jump()
    self.isKeepMoving = false
end

return JumpBeginState
-- while wait(1) do localPlayer:Jump() end
-- localPlayer:Jump()