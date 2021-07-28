--- 角色控制模块
--- @module Player Ctrl Module
--- @copyright Lilith Games, Avatar Team
--- @author Dead Ratman
local PlayerControl, this = ModuleUtil.New('PlayerControl', ClientBase)

--声明变量
local isDead = false
local forwardDir = Vector3.Forward
local rightDir = Vector3.Right
local horizontal = 0
local vertical = 0

-- PC端交互按键
local FORWARD_KEY = Enum.KeyCode.W
local BACK_KEY = Enum.KeyCode.S
local LEFT_KEY = Enum.KeyCode.A
local RIGHT_KEY = Enum.KeyCode.D
local JUMP_KEY = Enum.KeyCode.Space
local SPRINT_KEY = Enum.KeyCode.LeftShift
local UP_KEY = Enum.KeyCode.Q
local DOWN_KEY = Enum.KeyCode.E
local CROUCH_KEY = Enum.KeyCode.C
local FLY_KEY = Enum.KeyCode.F

-- 键盘的输入值
local moveForwardAxis = 0
local moveBackAxis = 0
local moveLeftAxis = 0
local moveRightAxis = 0
local upAxis = 0
local downAxis = 0

--- 初始化
function PlayerControl:Start()
    ----print('[PlayerControl] Init()')
    this:DataInit()
    this:EventBind()
end

--- 数据变量初始化
function PlayerControl:DataInit()
    this.finalDir = Vector3.Zero
    this.isSprint = false
    this.upright = 0
end

--- 节点事件绑定
function PlayerControl:EventBind()
    -- Keyboard Input
    Input.OnKeyDown:Connect(
        function()
            if Input.GetPressKeyData(JUMP_KEY) == 1 then
                this:PlayerJump()
            end
            if Input.GetPressKeyData(CROUCH_KEY) == 1 then
                this:PlayerCrouch()
            end
            if Input.GetPressKeyData(FLY_KEY) == 1 then
                this:PlayerFly()
            end
        end
    )
end

--获取按键盘时的移动方向最终取值
function GetKeyValue()
    moveForwardAxis = Input.GetPressKeyData(FORWARD_KEY) > 0 and 1 or 0
    moveBackAxis = Input.GetPressKeyData(BACK_KEY) > 0 and -1 or 0
    moveLeftAxis = Input.GetPressKeyData(LEFT_KEY) > 0 and 1 or 0
    moveRightAxis = Input.GetPressKeyData(RIGHT_KEY) > 0 and -1 or 0
    this.isSprint = Input.GetPressKeyData(SPRINT_KEY) == 2
    upAxis = Input.GetPressKeyData(UP_KEY) == 2 and 1 or 0
    downAxis = Input.GetPressKeyData(DOWN_KEY) == 2 and 1 or 0
    if localPlayer.State == Enum.CharacterState.Died then
        moveForwardAxis, moveBackAxis, moveLeftAxis, moveRightAxis = 0, 0, 0, 0
    end
end

-- 获取移动方向
function GetMoveDir()
    forwardDir = C.PlayerCam:IsFreeMode() and C.PlayerCam.curCamera:GetDeferredForward() or localPlayer.Forward
    forwardDir.y = 0
    rightDir = Vector3(0, 1, 0):Cross(forwardDir)
    horizontal = C.GuiControl.joystick.Horizontal
    vertical = C.GuiControl.joystick.Vertical
    this.upright = upAxis - downAxis
    if horizontal ~= 0 or vertical ~= 0 then
        this.finalDir = rightDir * horizontal + forwardDir * vertical
    else
        GetKeyValue()
        this.finalDir = forwardDir * (moveForwardAxis + moveBackAxis) - rightDir * (moveLeftAxis + moveRightAxis)
        if this.finalDir.Magnitude > 0 then
            this.finalDir = this.finalDir.Normalized
        end
    end
end

-- 跳跃逻辑
function PlayerControl:PlayerJump()
    --print('jumpCount', C.FsmMgr.playerActCtrl.jumpCount)
    C.FsmMgr.playerActCtrl:CallTrigger('SitEndState')
    -- C.FsmMgr.playerActCtrl:CallTrigger('LieDownEndState')
    if C.FsmMgr.playerActCtrl.jumpCount == 3 then
        C.FsmMgr.playerActCtrl:CallTrigger('JumpBeginState')
    elseif C.FsmMgr.playerActCtrl.jumpCount == 2 then
        C.FsmMgr.playerActCtrl:CallTrigger('DoubleJumpState')
    elseif C.FsmMgr.playerActCtrl.jumpCount == 1 then
        C.FsmMgr.playerActCtrl:CallTrigger('DoubleJumpSprintState')
    end
end

-- 下蹲逻辑
function PlayerControl:PlayerCrouch()
    C.FsmMgr.playerActCtrl:SwitchCrouch()
end

-- 飞行逻辑
function PlayerControl:PlayerFly()
    C.FsmMgr.playerActCtrl:CallTrigger('FlyBeginState')
end

function PlayerControl:Update(dt)
    GetMoveDir()
end

return PlayerControl
