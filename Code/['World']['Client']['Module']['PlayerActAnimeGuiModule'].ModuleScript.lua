--- 角色社交动作UI模块
--- @module Player Cam Module
--- @copyright Lilith Games, Avatar Team
--- @author Dead Ratman

local PlayerActAnimeGui, this = ModuleUtil.New('PlayerActAnimeGui', ClientBase)

local sitBtn, actBtn, childActBtnList
local actAnimTable = {}

--- 初始化
function PlayerActAnimeGui:Start()
    this:NodeRef()
    this:DataInit()
    this:EventBind()
end

--- 节点引用
function PlayerActAnimeGui:NodeRef()
    sitBtn = localPlayer.Local.ControlGui.SitBtn
    actBtn = localPlayer.Local.ControlGui.ActBtn
    childActBtnList = actBtn.Panel:GetChildren()
end

--- 数据变量初始化
function PlayerActAnimeGui:DataInit()
end

--- 节点事件绑定
function PlayerActAnimeGui:EventBind()
    actBtn.OnClick:Connect(
        function()
            actBtn.Panel:SetActive(not actBtn.Panel.ActiveSelf)
            if actBtn.Panel.ActiveSelf then
                self:ActiveChildActBtn()
            end
        end
    )
end

---激活子按钮
function PlayerActAnimeGui:ActiveChildActBtn()
    actAnimTable = {}
    for k, v in pairs(Config.ActAnim) do
        if v.Mode == C.FsmMgr.playerActCtrl.actAnimMode then
            table.insert(actAnimTable, v)
        end
    end
    if #actAnimTable == 0 then
        actBtn.Panel:SetActive(false)
        return
    end
    for i = 1, #childActBtnList do
        childActBtnList[i]:SetActive(false)
        childActBtnList[i].OnClick:Clear()
        if i <= #actAnimTable then
            childActBtnList[i].ActAnimNameText.Text = Config.ActAnim[actAnimTable[i].ID].ShowName
            childActBtnList[i]:SetActive(true)
            childActBtnList[i].OnClick:Connect(
                function()
                    this:PlayActAnim(actAnimTable[i].ID)
                end
            )
        end
    end
    return
end

function PlayerActAnimeGui:PlayActAnim(_id)
    C.FsmMgr.playerActCtrl:GetActInfo(Config.ActAnim[_id])
    C.FsmMgr.playerActCtrl:CallTrigger('ActBeginState')
end

return PlayerActAnimeGui
