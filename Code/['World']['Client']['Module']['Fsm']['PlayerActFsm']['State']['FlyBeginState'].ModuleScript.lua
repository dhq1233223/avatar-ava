local FlyBeginState = class('FlyBeginState', C.PlayerActState)

function FlyBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jumptohover_01')
end
function FlyBeginState:InitData()
    self:AddTransition('ToFlyIdleState', self.controller.states['FlyIdleState'], 0.4)
end

function FlyBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    localPlayer:StopMovementImmediately()
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.1, 0.1, true, false, 1)
end

function FlyBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function FlyBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:LaunchCharacter(Vector3(0, 5, 0), false, false)
    wait()
end

return FlyBeginState
