local SwimmingStartState = class('SwimmingStartState', C.PlayerActState)

function SwimmingStartState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animFreestyleNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_human_idletofreestyle_01')
    self.animBreaststrokeNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_human_idletobreaststroke_01')
end

function SwimmingStartState:InitData()
    self:AddTransition('ToSwimmingState', self.controller.states['SwimmingState'], 1)
    self:AddTransition(
        'ToIdleState',
        self.controller.states['IdleState'],
        -1,
        function()
            return not self:SwimMonitor()
        end
    )
    self:AddTransition(
        'ToSwimIdleState',
        self.controller.states['SwimIdleState'],
        -1,
        function()
            return not self:MoveMonitor()
        end
    )
end

function SwimmingStartState:OnEnter()
    C.PlayerActState.OnEnter(self)
    if self:IsWaterSuface() then
        print('Freestyle')
        C.PlayerAnimMgr:Play(self.animFreestyleNode, 0, 1, 0.1, 0.1, true, false, 1)
    else
        C.PlayerAnimMgr:Play(self.animBreaststrokeNode, 0, 1, 0.1, 0.1, true, false, 1.5)
    end
end

function SwimmingStartState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Swim(0.1)
end

function SwimmingStartState:OnLeave()
    C.PlayerActState.OnLeave(self)
    if self:MoveMonitor() then
        localPlayer:AddImpulse(localPlayer.Forward * 400)
    end
end

return SwimmingStartState
