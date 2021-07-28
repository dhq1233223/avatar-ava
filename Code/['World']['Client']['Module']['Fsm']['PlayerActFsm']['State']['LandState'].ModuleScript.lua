local LandState = class('LandState', C.PlayerActState)

function LandState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animIdleNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jumptoidle_01')
    self.animMoveNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jumpforwardtorun_01')
end
function LandState:InitData()
    self:AddTransition(
        'ToFlyBeginState',
        self.controller.states['FlyBeginState'],
        -1,
        function()
            return self.controller.triggers['FlyBeginState']
        end
    )
end

function LandState:OnEnter()
    C.PlayerActState.OnEnter(self)
    local dir = PlayerCtrl.finalDir
    dir.y = 0
    if dir.Magnitude > 0 then
        self:AddTransition('ToMoveState', self.controller.states['MoveState'], 0.4)
        C.PlayerAnimMgr:Play(self.animMoveNode, 0, 1, 0.1, 0.1, true, false, 0.8)
    else
        self:AddTransition('ToIdleState', self.controller.states['IdleState'], 0.3)
        self:AddTransition(
            'ToMoveState',
            self.controller.states['MoveState'],
            -1,
            function()
                return self:MoveMonitor()
            end
        )
        C.PlayerAnimMgr:Play(self.animIdleNode, 0, 1, 0.1, 0.1, true, false, 1)
    end
    self.controller.jumpCount = localPlayer.JumpMaxCount
end

function LandState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Move()
end

function LandState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.transitions = {}
end

return LandState
