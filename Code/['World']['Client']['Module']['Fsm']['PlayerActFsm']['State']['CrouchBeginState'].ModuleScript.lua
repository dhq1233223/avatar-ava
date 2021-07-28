local CrouchBeginState = class('CrouchBeginState', C.PlayerActState)

function CrouchBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_standtocrouch_01')
end
function CrouchBeginState:InitData()
    self:AddTransition('ToCrouchIdleState', self.controller.states['CrouchIdleState'], 0.2)
end

function CrouchBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    --localPlayer:StopMovementImmediately()
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.1, 0.1, true, false, 1)
end

function CrouchBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function CrouchBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:Crouch()
end

return CrouchBeginState
