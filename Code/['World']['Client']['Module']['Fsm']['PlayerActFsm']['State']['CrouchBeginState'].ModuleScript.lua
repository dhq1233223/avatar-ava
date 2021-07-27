local CrouchBeginState = class('CrouchBeginState', C.PlayerActState)

function CrouchBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_man_standtocrouch_01', 1, _stateName, 1)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_standtocrouch_01', 1, _stateName, 2)
end
function CrouchBeginState:InitData()
    self:AddTransition('ToCrouchIdleState', self.controller.states['CrouchIdleState'], 0.2)
end

function CrouchBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    --localPlayer:StopMovementImmediately()
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.1, 0.1, true, false, 1)
end

function CrouchBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function CrouchBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:Crouch()
end

return CrouchBeginState
