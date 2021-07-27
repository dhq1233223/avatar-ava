local LandState = class('LandState', C.PlayerActState)

function LandState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_man_jumptoidle_01', 1, _stateName .. 1, 1)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jumptoidle_01', 1, _stateName .. 1, 2)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_man_jumpforwardtorun_01', 1, _stateName .. 2, 1)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_jumpforwardtorun_01', 1, _stateName .. 2, 2)
end
function LandState:InitData()
    
end

function LandState:OnEnter()
    self.isKeepMoving = false
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName .. 1, 0, 1, 0.1, 0.1, true, false, 1)
    
    self:AddTransition(
        'ToFlyBeginState',
        self.controller.states['FlyBeginState'],
        -1,
        function()
            return self.controller.triggers['FlyBeginState']
        end
    )

    self:AddTransition(
        'ToJumpBeginState',
        self.controller.states['JumpBeginState'],
        -1,
        function()
            return self.controller.triggers['JumpBeginState']
        end
    )

    local dir = C.PlayerControl.finalDir
    dir.y = 0
    if dir.Magnitude > 0 then
        self:AddTransition('ToMoveState', self.controller.states['MoveState'], 0.4)
        localPlayer:AddImpulse(localPlayer.Forward * 10)
        C.PlayerAnimMgr:Play(self.stateName .. 2, 0, 1, 0.1, 0.1, true, false, 0.8)
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
        C.PlayerAnimMgr:Play(self.stateName .. 1, 0, 1, 0.1, 0.1, true, false, 0.8)
        if self:MoveMonitor() then
            self.isKeepMoving = true
            localPlayer:AddMovementInput(localPlayer.Forward * localPlayer.Velocity.Magnitude*200)
        end
    end
    self.controller.jumpCount = localPlayer.JumpMaxCount
end

function LandState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Move()
    --[[if self.isKeepMoving then
        localPlayer:AddMovementInput(localPlayer.Forward * localPlayer.Velocity.Magnitude*200)
    end]]
end

function LandState:OnLeave()
    C.PlayerActState.OnLeave(self)
    self.transitions = {}
end

return LandState
