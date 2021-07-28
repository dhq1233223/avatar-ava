local SwimmingState = class('SwimmingState', C.PlayerActState)

local isSufaceWater = true

function SwimmingState:initialize(_controller, _stateName)
    C.PlayerActState.initialize(self, _controller, _stateName)
    self.animFreestyleNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_human_swim_freestyle_01')
    self.animBreaststrokeNode = C.PlayerAnimMgr:CreateSingleClipNode('anim_human_swim_breaststroke_01')
end

function SwimmingState:InitData()
    self:AddTransition(
        'ToSwimmingEndState',
        self.controller.states['SwimmingEndState'],
        -1,
        function()
            return not self:MoveMonitor()
        end
    )
    self:AddTransition(
        'ToIdleState',
        self.controller.states['IdleState'],
        -1,
        function()
            return not self:SwimMonitor()
        end
    )
end

function SwimmingState:OnEnter()
    C.PlayerActState.OnEnter(self)
    isSufaceWater = self:IsWaterSuface()
    if isSufaceWater then
        C.PlayerAnimMgr:Play(self.animFreestyleNode, 0, 1, 0.3, 0.3, true, true, 1)
    else
        C.PlayerAnimMgr:Play(self.animBreaststrokeNode, 0, 1, 0.3, 0.3, true, true, 1)
    end
end

function SwimmingState:OnUpdate(dt)
    C.PlayerActState.OnUpdate(self, dt)
    self:Swim()
    if isSufaceWater ~= self:IsWaterSuface() then
        self:OnEnter()
    end
end

function SwimmingState:OnLeave()
    C.PlayerActState.OnLeave(self)
end

return SwimmingState
