local ActState = class('ActState', C.PlayerActState)

function ActState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_sit_loop', 1, _stateName)
end
function ActState:InitData()
end

function ActState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:CreateSingleClipNode(self.controller.actInfo.anim[2], self.controller.actInfo.speed, self.stateName)
    C.PlayerAnimMgr:Play(
        self.stateName,
        self.controller.actInfo.layer,
        1,
        self.controller.actInfo.transIn,
        self.controller.actInfo.transOut,
        self.controller.actInfo.isInterrupt,
        self.controller.actInfo.isLoop,
        self.controller.actInfo.speedScale
    )
    self:AddTransition(
        'ToActEndState',
        self.controller.states['ActEndState'],
        self.controller.actInfo.dur[2],
        function()
            return self:MoveMonitor()
        end
    )
end

function ActState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function ActState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.transitions = {}
end

return ActState
