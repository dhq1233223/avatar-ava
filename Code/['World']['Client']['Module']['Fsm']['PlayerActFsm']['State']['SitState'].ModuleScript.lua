local SitState = class('SitState', C.PlayerActState)

function SitState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_sit_loop', 1, _stateName)
end
function SitState:InitData()
    self:AddTransition(
        'ToSitEndState',
        self.controller.states['SitEndState'],
        -1,
        function()
            return self.controller.triggers['SitEndState']
        end
    )
end

function SitState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, true, 1)
end

function SitState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function SitState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return SitState
