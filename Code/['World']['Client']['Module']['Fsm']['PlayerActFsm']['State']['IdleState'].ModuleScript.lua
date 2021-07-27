local IdleState = class('IdleState', C.PlayerActState)

function IdleState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_man_idle_01', 1, _stateName, 1)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_idle_01', 1, _stateName, 2)
end

function IdleState:InitData()
    self:AddTransition(
        'ToMoveState',
        self.controller.states['MoveState'],
        -1,
        function()
            return self:MoveMonitor()
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
    self:AddTransition(
        'ToCrouchBeginState',
        self.controller.states['CrouchBeginState'],
        -1,
        function()
            return self.controller.isCrouch
        end
    )
    self:AddTransition(
        'ToFlyBeginState',
        self.controller.states['FlyBeginState'],
        -1,
        function()
            return self.controller.triggers['FlyBeginState']
        end
    )
end

function IdleState:OnEnter()
    C.PlayerActState.OnEnter(self)
    localPlayer.FollowTarget = nil
    localPlayer.CharacterWidth = 0.5
    localPlayer.CharacterHeight = 1.7
      
    localPlayer.Avatar.LocalPosition = Vector3.Zero
    localPlayer.RotationRate = EulerDegree(0, 540, 0)
    localPlayer:SetMovementMode(Enum.MovementMode.MOVE_Walking)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, true, 1)
    self:FallMonitor()
    self.controller.jumpCount = localPlayer.JumpMaxCount
end

function IdleState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function IdleState:OnLeave()
    C.PlayerActState.OnLeave(self)
    print(localPlayer.Rotation)

end

return IdleState
