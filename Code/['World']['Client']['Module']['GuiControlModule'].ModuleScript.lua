--- 玩家控制UI模块
--- @module Player GuiControll, client-side
--- @copyright Lilith Games, Avatar Team
--- @author Dead Ratman
local GuiControl, this = ModuleUtil.New('GuiControl', ClientBase)

-- 手机端交互UI
local gui

function GuiControl:Start()
    --print('[GuiControl] Init()')
    self:InitGui()
    self:InitListener()
end

function GuiControl:InitGui()
    gui = localPlayer.Local.ControlGui
    this.joystick = gui.Joystick
    this.touchScreen = gui.TouchFig
    this.jumpBtn = gui.JumpBtn
    this.sitBtn = gui.SitBtn
    this.sitDownBtn = gui.SitDownBtn
end

function GuiControl:InitListener()
    -- GUI
    this.touchScreen.OnTouched:Connect(
        function(touchInfo)
            C.PlayerCam:CameraMove(touchInfo)
        end
    )
    this.touchScreen.OnPinchStay:Connect(
        function(pos1, pos2, deltaSize, pinchSpeed)
            C.PlayerCam:CameraZoom(pos1, pos2, deltaSize, pinchSpeed)
        end
    )
    this.jumpBtn.OnDown:Connect(
        function()
            C.PlayerControl:PlayerJump()
        end
    )
end

function testSit()
    FsmMgr.playerActCtrl:CallTrigger('SitBeginState')
end

function GuiControl:Update(dt)
end

return GuiControl
