local ActBeginState = class('ActBeginState', C.PlayerActState)

function ActBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
end
function ActBeginState:InitData()
    self:AddAnyState(
        'ToActBeginState',
        -1,
        function()
            return self.controller.triggers['ActBeginState']
        end
    )
end

function ActBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:CreateSingleClipNode(self.controller.actInfo.anim[1], 1, self.stateName)
    C.PlayerAnimMgr:Play(self.stateName, self.controller.actInfo.layer, 1, 0.2, 0.2, true, false, 1)
    self:AddTransition('ToActState', self.controller.states['ActState'], self.controller.actInfo.dur[1])
end

function ActBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function ActBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.transitions = {}
end

return ActBeginState
