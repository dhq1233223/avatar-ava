local CrouchMoveState = class('CrouchMoveState', C.PlayerActState)

function CrouchMoveState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    local animRight = {
        {'anim_woman_crouch_idle_02', 0.0, 1.0},
        {'anim_woman_crouch_front_02', 0.25, 1.0}
    }
    local animLeft = {
        {'anim_woman_crouch_idle_01', 0.0, 1.0},
        {'anim_woman_crouch_front_01', 0.25, 1.0}
    }
    self.animRightNode = C.PlayerAnimMgr:Create1DClipNode(animRight, 'speedXZ')
    self.animLeftNode = C.PlayerAnimMgr:Create1DClipNode(animLeft, 'speedXZ')
end
function CrouchMoveState:InitData()
    self:AddTransition(
        'ToCrouchIdleState',
        self.controller.states['CrouchIdleState'],
        -1,
        function()
            return not self:MoveMonitor()
        end
    )
    self:AddTransition(
        'ToCrouchEndState',
        self.controller.states['CrouchEndState'],
        -1,
        function()
            return not self.controller.isCrouch
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

function CrouchMoveState:OnEnter()
    C.PlayerActState.OnEnter(self)
    if self.controller.foot == 1 then
        C.PlayerAnimMgr:Play(self.animRightNode, 0, 1, 0.2, 0.2, true, true, 1)
    else
        C.PlayerAnimMgr:Play(self.animLeftNode, 0, 1, 0.2, 0.2, true, true, 1)
    end
end

function CrouchMoveState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:SpeedMonitor(localPlayer.MaxWalkSpeedCrouched)
    self:Move()
end

function CrouchMoveState:OnLeave()
    C.PlayerActState.OnLeave(self)
    if not self:GetStopInfo() then
        self.controller.foot = 2
    else
        self.controller.foot = 1
    end
end

return CrouchMoveState
