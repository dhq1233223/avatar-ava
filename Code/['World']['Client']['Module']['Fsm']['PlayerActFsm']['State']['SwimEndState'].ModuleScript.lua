local SwimEndState = class('SwimEndState', C.PlayerActState)

function SwimEndState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_sit_swim_goashore', 1, _stateName)
end

function SwimEndState:InitData()
    self:AddTransition('ToIdleState', self.controller.states['IdleState'], 0.8)
end

function SwimEndState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, false, 1)
    invoke(
        function()
            localPlayer:StopMovementImmediately()
        end,
        0.3
    )
end

function SwimEndState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function SwimEndState:OnLeave()
    C.PlayerActState.OnLeave(self)
    localPlayer:SetSwimming(false)
end

return SwimEndState
