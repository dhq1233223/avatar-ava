local CrouchIdleState = class('CrouchIdleState', C.PlayerActState)

function CrouchIdleState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animRightNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_crouch_idle_02')
    self.animLeftNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_woman_crouch_idle_01')
end
function CrouchIdleState:InitData()
    self:AddTransition(
        'ToCrouchMoveState',
        self.controller.states['CrouchMoveState'],
        -1,
        function()
            return self:MoveMonitor()
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

function CrouchIdleState:OnEnter()
    C.PlayerActState.OnEnter(self)
    if self.controller.foot == 1 then
        C.PlayerAnimMgr:Play(self.animRightNode, 0, 1, 0.2, 0.2, true, true, 1)
    else
        C.PlayerAnimMgr:Play(self.animLeftNode, 0, 1, 0.2, 0.2, true, true, 1)
    end
end

function CrouchIdleState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
end

function CrouchIdleState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return CrouchIdleState
