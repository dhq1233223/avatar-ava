--- 玩家动作状态机控制器
-- @module  PlayerActController
-- @copyright Lilith Games, Avatar Team
-- @author Dead Ratman
local PlayerActController = class('PlayerActController', C.ControllerBase)

function PlayerActController:initialize( _stateMachineNode, _folder)
    C.ControllerBase.initialize(self, _stateMachineNode, _folder)
    self.triggers = {}
    for k, v in pairs(self.states) do
        self.triggers[k] = false
    end
    self.foot = 2
    self.isCrouch = false
    self.jumpCount = localPlayer.JumpMaxCount
end


function PlayerActController:CallTrigger(_stateName)
    if self.triggers[_stateName] == false then
        self.triggers[_stateName] = true
    end
end

function PlayerActController:ResetTrigger()
    for k, v in pairs(self.states) do
        self.triggers[k] = false
    end
end

---开关下蹲
function PlayerActController:SwitchCrouch()
    if self.isCrouch then
        self.isCrouch = false
    else
        self.isCrouch = true
    end
end

--切换状态
function PlayerActController:Switch(_state)
    if _state and self.curState ~= _state then
        self.lastState = self.curState
        self.curState = _state
        self.machine:GotoState(self.statesInMachine[_state.stateName])
        self:ResetTrigger()
    end
end

return PlayerActController
