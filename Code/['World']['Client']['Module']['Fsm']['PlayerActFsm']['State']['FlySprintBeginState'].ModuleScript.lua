local FlySprintBeginState = class('FlySprintBeginState', C.PlayerActState)

function FlySprintBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_hovertofly_01')
    self.animNode:AddAnimationEvent(0.5):Connect(
        function()
            if self:MoveMonitor() then
                localPlayer:AddImpulse(localPlayer.Forward * 500)
            end
        end
    )
end
function FlySprintBeginState:InitData()
    self:AddTransition('ToFlySprintState', self.controller.states['FlySprintState'], 0.6)
    self:AddTransition(
        'ToFlyEndState',
        self.controller.states['FlyEndState'],
        -1,
        function()
            return self:FloorMonitor(0.06)
        end
    )
end

function FlySprintBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.2, 0.2, true, false, 0.8)
end

function FlySprintBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function FlySprintBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return FlySprintBeginState
