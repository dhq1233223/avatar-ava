local SwimBeginState = class('SwimBeginState', C.PlayerActState)

function SwimBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_sit_swim_intowater', 1, _stateName)
end

function SwimBeginState:InitData()
    self:AddAnyState(
        'ToSwimBeginState',
        -1,
        function()
            return self:SwimMonitor() and not localPlayer:IsSwimming()
        end
    )
    self:AddTransition('ToSwimmingState', self.controller.states['SwimmingState'], 1)
    self:AddTransition(
        'ToSwimEndState',
        self.controller.states['SwimEndState'],
        -1,
        function()
            return not self:SwimMonitor()
        end
    )
end

function SwimBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    if not localPlayer:IsSwimming() then
        localPlayer:SetSwimming(true)
        localPlayer.RotationRate = EulerDegree(0, 240, 0)
    end
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, false, 1)
end

function SwimBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function SwimBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return SwimBeginState
