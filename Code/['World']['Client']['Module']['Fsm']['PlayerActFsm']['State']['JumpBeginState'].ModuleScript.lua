local JumpBeginState = class('JumpBeginState', C.PlayerActState)

function JumpBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jump_begin_01')
end
function JumpBeginState:InitData()
    self:AddTransition('ToJumpRiseState', self.controller.states['JumpRiseState'], 0.1)
end

function JumpBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0, 0, true, false, 0.6)
end

function JumpBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function JumpBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:Jump()
    if self:MoveMonitor() then
        localPlayer:AddImpulse(localPlayer.Forward * 200)
    end
end

return JumpBeginState
