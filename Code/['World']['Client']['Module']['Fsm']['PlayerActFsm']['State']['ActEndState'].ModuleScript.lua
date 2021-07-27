local ActEndState = class('ActEndState', C.PlayerActState)

function ActEndState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
end
function ActEndState:InitData()
end

function ActEndState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:CreateSingleClipNode(self.controller.actInfo.anim[3], 1, self.stateName)
    C.PlayerAnimMgr:Play(self.stateName, self.controller.actInfo.layer, 1, 0.2, 0.2, true, false, 1)
    self:AddTransition('ToIdleState', self.controller.states['IdleState'], self.controller.actInfo.dur[3])
end

function ActEndState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function ActEndState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.transitions = {}
end

return ActEndState
