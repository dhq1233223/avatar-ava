local DoubleJumpSprintState = class('DoubleJumpSprintState', C.PlayerActState)

function DoubleJumpSprintState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_doublejump_02')
end
function DoubleJumpSprintState:InitData()
    self:AddTransition('ToFallState', self.controller.states['FallState'], 0.6)
end

function DoubleJumpSprintState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.animNode, 0, 1, 0.1, 0.1, true, false, 1)
    self.controller.jumpCount = self.controller.jumpCount - 1
    localPlayer:LaunchCharacter(Vector3(0, 10, 0) + localPlayer.Forward * 5, false, false)
end

function DoubleJumpSprintState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function DoubleJumpSprintState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return DoubleJumpSprintState
