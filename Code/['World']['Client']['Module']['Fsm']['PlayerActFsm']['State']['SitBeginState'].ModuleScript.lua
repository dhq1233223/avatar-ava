local SitBeginState = class('SitBeginState', C.PlayerActState)

function SitBeginState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    C.PlayerAnimMgr:CreateSingleClipNode('anim_human_sit_begin', 1, _stateName)
end
function SitBeginState:InitData()
    self:AddAnyState(
        'ToSitBeginState',
        -1,
        function()
            return self.controller.triggers['SitBeginState']
        end
    )
    self:AddTransition('ToSitState', self.controller.states['SitState'], 1)
end

function SitBeginState:OnEnter()
    C.PlayerActState.OnEnter(self)
    localPlayer.Rotation = self.controller.seatObj.Rotation
    -- localPlayer.FollowTarget = self.controller.seatObj
    C.PlayerAnimMgr:Play(self.stateName, 0, 1, 0.2, 0.2, true, false, 1)
    PlayerCam.curCamera.CameraMode = Enum.CameraMode.Social
end

function SitBeginState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function SitBeginState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return SitBeginState
