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
    self.isCrouch = false
    self.jumpCount = localPlayer.JumpMaxCounts
    self.seatObj = nil
    self.stopInfo = {
        footIndex = 2,
        footDis = 0,
        speed = 0
    }
    self.actInfo = {
        anim = {},
        dur = {},
        speed = 1,
        layer = 0,
        transIn = 0,
        transOut = 0,
        isInterrupt = true,
        isLoop = false,
        speedScale = 1
    }

	self.actAnimMode = 1
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

---获取停步时哪只脚在前以及双脚间距
function PlayerActController:GetStopInfo()
    local lToe = localPlayer.Avatar.Bone_L_Toe0
    local rToe = localPlayer.Avatar.Bone_R_Toe0
    local toeDir = Vector2(lToe.Position.x - rToe.Position.x, lToe.Position.z - rToe.Position.z)
    local fDir = Vector2(localPlayer.Avatar.Forward.x, localPlayer.Avatar.Forward.z)
    self.stopInfo.footIndex = (Vector2.Angle(toeDir, fDir) < 90) and 2 or 1
    self.stopInfo.footDis = Vector2(lToe.Position.x - rToe.Position.x, lToe.Position.z - rToe.Position.z).Magnitude
    return self.stopInfo.footIndex == 2, self.stopInfo.footDis
end

---更新动作模式
function PlayerActController:UpdateActAnimMode()
    if
        self.actAnimMode ~= Config.PlayerActState[self.curState.stateName].Mode and
            Config.PlayerActState[self.curState.stateName].Mode ~= nil
     then
        self.actAnimMode = Config.PlayerActState[self.curState.stateName].Mode
        C.PlayerActAnimeGui:ActiveChildActBtn()
    end
end

---切换状态
function PlayerActController:Switch(_state)
    if _state and self.curState ~= _state then
        self.lastState = self.curState
        self.curState = _state
        self:UpdateActAnimMode()
        self.machine:GotoState(self.statesInMachine[_state.stateName])
        self:ResetTrigger()
    end
end

---获取动作信息
function PlayerActController:GetActInfo(_info)
    for k, v in pairs(_info) do
        self.actInfo[k] = v
    end
end


function PlayerActController:Update(dt)
    C.ControllerBase.Update(self, dt)
	--[[
    if localPlayer.Velocity.Magnitude > 0 then
        self.stopInfo.speed = localPlayer.Velocity.Magnitude
        print('Speed：'..localPlayer.Velocity.x)
    end]]
end

return PlayerActController
