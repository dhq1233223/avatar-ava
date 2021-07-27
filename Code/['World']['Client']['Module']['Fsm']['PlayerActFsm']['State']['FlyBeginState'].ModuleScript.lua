local FlyBeginState = class('FlyBeginState', C.PlayerActState)

function FlyBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_man_jumptohover_01', 1, _stateName, 1)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jumptohover_01', 1, _stateName, 2)
end
function FlyBeginState:InitData()
    self:AddTransition('ToFlyIdleState', self.controller.states['FlyIdleState'], 0.4)
end

function FlyBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    localPlayer:StopMovementImmediately()
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.1, 0.1, true, false, 1)
end

function FlyBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function FlyBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:AddImpulse(localPlayer.Up * 500)
    wait()
end

return FlyBeginState
