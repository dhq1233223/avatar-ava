local FlySprintEndState = class('FlySprintEndState', C.PlayerActState)

function FlySprintEndState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_man_flytohover_01', 1, _stateName, 1)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_flytohover_01', 1, _stateName, 2)
end
function FlySprintEndState:InitData()
    self:AddTransition('FlyMoveState', self.controller.states['FlyMoveState'], 0.5)
    self:AddTransition(
        'ToFlySprintEndState',
        self.controller.states['FlySprintEndState'],
        -1,
        function()
            return self:FloorMonitor(0.06)
        end
    )
end

function FlySprintEndState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, false, 1)
end

function FlySprintEndState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function FlySprintEndState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return FlySprintEndState
