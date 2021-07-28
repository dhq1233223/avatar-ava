local FlyEndState = class('FlyEndState', C.PlayerActState)

function FlyEndState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_hovertoland_02')
end
function FlyEndState:InitData()
    self:AddTransition('IdleState', self.controller.states['IdleState'], 0.8)
end

function FlyEndState:OnEnter()
    C.PlayerActState.OnEnter(self)
    localPlayer:StopMovementImmediately()
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.15, 0.15, true, false, 1)
end

function FlyEndState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function FlyEndState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return FlyEndState
