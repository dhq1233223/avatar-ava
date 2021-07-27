local SwimmingEndState = class('SwimmingEndState', C.PlayerActState)

function SwimmingEndState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_freestyletoidle_01', 1, _stateName .. 'Freestyle')
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_breaststroketoidle_01', 1, _stateName .. 'Breaststroke')
end

function SwimmingEndState:InitData()
    self:AddTransition('ToSwimIdleState', self.controller.states['SwimIdleState'], 0.5)
    self:AddTransition(
        'ToSwimEndState',
        self.controller.states['SwimEndState'],
        -1,
        function()
            return not self:SwimMonitor()
        end
    )
end

function SwimmingEndState:OnEnter()
    C.PlayerActState.OnEnter(self)
    if self:IsWaterSuface() then
        C.PlayerAnimMgr:Play(self.stateName .. 'Freestyle', 0, 1, 0.1, 0.1, true, false, 1)
    else
        C.PlayerAnimMgr:Play(self.stateName .. 'Breaststroke', 0, 1, 0.1, 0.1, true, false, 1)
    end
end

function SwimmingEndState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Swim(0.1)
end

function SwimmingEndState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return SwimmingEndState
