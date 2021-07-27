--- 玩家动作状态
--- @class  PlayerActState
--- @copyright Lilith Games, Avatar Team
--- @author Dead Ratman
local PlayerActState = class('PlayerActState', C.StateBase)

--水体
local waterCol = world.Water
local waterData = {}
local file = nil

--Test_Begin
local lastCamAngle = Vector3(0,0,0)
local lastCamPosition = Vector3(0,0,0)
local tt = 0
--Test_End

function PlayerActState:initialize(_controller, _stateName)
    C.StateBase.initialize(self, _controller, _stateName)
	waterData = {
        rangeMin = waterCol.Position - Vector3(waterCol.Size.x / 2, waterCol.Size.y / 2, waterCol.Size.z / 2),
        rangeMax = waterCol.Position + Vector3(waterCol.Size.x / 2, waterCol.Size.y / 2, waterCol.Size.z / 2)
    }
end

--- 移动，每帧调用
--- @param _isSprint boolean 是否有冲刺输入
function PlayerActState:Move(_isSprint)
    _isSprint = _isSprint or false
    local dir = C.PlayerControl.finalDir
    dir.y = 0
    if _isSprint then
        if C.PlayerControl.isSprint then
            localPlayer:AddMovementInput(dir, 1)
        else
            localPlayer:AddMovementInput(dir, 0.5)
        end
    else
        localPlayer:AddMovementInput(dir, 0.5)
    end
end

--- 游泳，每帧调用
function PlayerActState:Swim()
    local lvY = self:MoveMonitor() and math.clamp((C.PlayerCam.playerGameCam.Forward.y + 0.2), -1, 1) or 0
    if self:IsWaterSuface() and lvY > 0 then
        lvY = -3 * localPlayer.Velocity.y
    elseif localPlayer.Position.y > waterData.rangeMax.y - 0.5 and lvY >= 0 then
        lvY = -3 * localPlayer.Velocity.y
    end
    if self:FloorMonitor(3) and lvY < 0 then
        lvY = 0
    end
    local dir = Vector3(C.PlayerControl.finalDir.x, lvY, C.PlayerControl.finalDir.z)
    
    localPlayer:AddMovementInput(dir, 1)
end

--- 飞行，每帧调用
function PlayerActState:Fly()
    local lvY = self:MoveMonitor() and math.clamp((C.PlayerCam.playerGameCam.Forward.y + 0.2), -1, 1) or 0
    local dir = Vector3(C.PlayerControl.finalDir.Normalized.x, lvY, C.PlayerControl.finalDir.Normalized.z)
    if C.PlayerControl.isSprint then
        localPlayer:AddMovementInput(dir, 1)
    else
        localPlayer:AddMovementInput(dir, 0.5)
    end
end

--- 上下沉浮，每帧调用
function PlayerActState:UpAndDown()
    local lvY = C.PlayerControl.upright
    if self:IsWaterSuface(1) and localPlayer.Position.y > waterData.rangeMax.y - 2 and lvY > 0 then
        lvY = 0
    end
    localPlayer:AddMovementInput(Vector3(0, lvY, 0))
end

--- 监听移动
--- @return boolean 是否移动 
function PlayerActState:MoveMonitor()
    local dir = C.PlayerControl.finalDir
    dir.y = 0
    if dir.Magnitude > 0 then
        return true
    else
        return false
    end
end

--- 地面监听
--- @param _dis boolean 距离地面的最大距离
--- @return boolean 是否落地 
function PlayerActState:FloorMonitor(_dis)
    if localPlayer.IsOnGround then
        return true
    end
    local startPos = localPlayer.Position
    local endPos = localPlayer.Position + Vector3.Down * (_dis or 0.01)
    local hitResult = Physics:RaycastAll(startPos, endPos, true)
    for i, v in pairs(hitResult.HitObjectAll) do
        if v.Block and v ~= localPlayer then
            return true
        end
    end
    return false
end

--- 墙面监听
--- @param _dis boolean 
--- @return boolean 前方有无墙
function PlayerActState:WallMonitor()
    local startPos = localPlayer.Position +  Vector3.Up * 0.1
    local endPos = localPlayer.Position + Vector3.Up * 0.1 + localPlayer.Forward.Normalized* 0.5
    local hitResult = Physics:RaycastAll(startPos, endPos, true)
    for i, v in pairs(hitResult.HitObjectAll) do
        if v.Block and v ~= localPlayer then
            return true
        end
    end
    return false
end

--- 监听游泳
--- @return boolean 是否满足游泳条件 
function PlayerActState:SwimMonitor()
    if
        localPlayer.Position.x > waterData.rangeMin.x and localPlayer.Position.x < waterData.rangeMax.x and
            localPlayer.Position.y > waterData.rangeMin.y and
            localPlayer.Position.y < waterData.rangeMax.y and
            localPlayer.Position.z > waterData.rangeMin.z and
            localPlayer.Position.z < waterData.rangeMax.z
     then
        if self:FloorMonitor(0.05) and localPlayer.Position.y > waterData.rangeMax.y - 0.2 then
            return false
        end
        return true
    else
        return false
    end
end


---监听速度 更新speedY speedXZ speedX
function PlayerActState:SpeedMonitor(_maxSpeed)
    local velocity = localPlayer.Velocity
    localPlayer.Avatar:SetParamValue('speedY', math.clamp((velocity.y / 10), -1, 1))
    velocity.y = 0
    localPlayer.Avatar:SetParamValue(
        'speedXZ',
        math.clamp((velocity.Magnitude / (_maxSpeed or localPlayer.MaxWalkSpeed)), 0, 1)
    )
    velocity = math.cos(math.rad(Vector3.Angle(velocity, localPlayer.Left))) * velocity.Magnitude
    localPlayer.Avatar:SetParamValue('speedX', math.clamp((velocity / (_maxSpeed or localPlayer.MaxWalkSpeed)), -1, 1))
end

--- 监听下落状态
function PlayerActState:FallMonitor()
    if not self:FloorMonitor(0.5) and localPlayer.Velocity.y < 0.5 and not localPlayer.IsOnGround then
        self.controller:CallTrigger('JumpHighestState')
    end
end

---是否在水面
function PlayerActState:IsWaterSuface(_dis)
    if localPlayer.Position.y > waterData.rangeMax.y - (_dis or 0.25) then
        return true
    else
        return false
    end
end

--[[
--- 镜头是否需要更新
function PlayerActState:CamZoomMonitor()
    -- 跳跃时禁用Zoom
    if Config.PlayerActState[C.FsmMgr.playerActCtrl.curState.stateName].Mode == 4
    or Config.PlayerActState[C.FsmMgr.playerActCtrl.curState.stateName].Mode == 5
    or C.FsmMgr.playerActCtrl.curState.stateName == 'LandState'
    then
        -- print(C.FsmMgr.playerActCtrl.curState.stateName..' NO ZOOM')
        return false
    else 
        return true
    end
end]]

---镜头更新
function PlayerActState:CamUpdate()
    --[[if not self.CamZoomMonitor() then return end]]
    local maxFov = 0
    local changeSpeed = localPlayer.Velocity.Magnitude
    if changeSpeed > 20 then
        maxFov = 90
    elseif changeSpeed > 10 then
        maxFov = 75
    elseif changeSpeed > 5 then
        maxFov = 70
    elseif changeSpeed > 1 then
        maxFov = 65
    else
        maxFov = 60
        changeSpeed = -20
    end
    changeSpeed = changeSpeed / 100
    C.PlayerCam:CameraFOVZoom(changeSpeed, maxFov)
end

function Vec32Str(_v3)
    return '('.._v3.x..','.._v3.y..','.._v3.z..')'
end

function PlayerActState:OnUpdate()
    C.StateBase.OnUpdate(self)
    self:CamUpdate()
end

return PlayerActState
