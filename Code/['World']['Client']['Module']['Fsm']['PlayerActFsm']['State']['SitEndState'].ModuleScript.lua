local SitEndState = class('SitEndState', C.PlayerActState)

function SitEndState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_sit_end', 1, _stateName)
end
function SitEndState:InitData()
    self:AddTransition('ToIdleState', self.controller.states['IdleState'], 1)
end

function SitEndState:OnEnter()
    C.PlayerActState.OnEnter(self)
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, false, 1)
end

function SitEndState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function SitEndState:OnLeave()

    C.PlayerActState.OnLeave(self)
    PlayerCam.curCamera.CameraMode = Enum.CameraMode.Smart

end

return SitEndState
