---对象池工具模块
---@class ObjPoolUtil
-- @copyright Lilith Games, Avatar Team
-- @author Yen Yuan
local ObjPoolMgr = {
    CREATE_OBJ_PER_FRAME = 1, -- 每帧最多创建几个物体
    poolList = {},
    createList = {},
}
local ObjPoolUtil = class('ObjPoolUtil')

-- 分帧生成
local creatCounter,tmpObj = 0,nil
local function SpawnObjFromList()
    for index, info in pairs(ObjPoolMgr.createList) do
        for i = 1, info.num do
            tmpObj = world:CreateInstance(info.obj,info.obj,ObjPoolMgr.poolList[info.obj].folder)
            if not tmpObj then
                error(string.format('[ObjPoolUtil] Archetype下没有名为%s的对象', self.obj))
            end
            tmpObj:SetActive(false)
            table.insert(ObjPoolMgr.poolList[info.obj].objList,tmpObj)
            creatCounter = creatCounter + 1
            if creatCounter >= ObjPoolMgr.CREATE_OBJ_PER_FRAME then
                wait()
                creatCounter = 0
            end
        end
        table.remove(ObjPoolMgr.createList, 1)
    end
    if #ObjPoolMgr.createList ~= 0 then
        SpawnObjFromList()
    end
end

function ObjPoolMgr.AddPool(_pool)
    ObjPoolMgr.poolList[_pool.obj] = _pool
end

local toBorrow
function ObjPoolMgr.Borrow()
end

function ObjPoolMgr.PreCreate(_obj, _num)
    table.insert(ObjPoolMgr.createList, {obj = _obj, num = _num or 1})
    if #ObjPoolMgr.createList == 1 then
        invoke(
            function()
                SpawnObjFromList()
                ObjPoolMgr.PoolPreSpawnComplete()
            end
        )
    end
end

function ObjPoolMgr.PoolPreSpawnComplete()
    print('[ObjPoolMgr] 队列中的物品创建完成')
    NetUtil.Fire_S('PoolPreSpawnCompleteSEvent')
    NetUtil.Broadcast('PoolPreSpawnCompleteCEvent')
end

---创建某一个对象的对象池
---@param _folder Object 管理的目录
---@param _objName string 对象的Archetype名
---@param _maxCount number 对象池最大上限，不填则为100
---@param _preSpawnCount number 预生成的数量
---@return ObjPoolUtil
function ObjPoolUtil:initialize(_objName, _folder, _maxCount, _preSpawnCount)
    if not _folder then
        _folder = world:CreateObject('FolderObject', _objName .. 'Pool', localPlayer and localPlayer.Local.Independent or world)
    end
    self.folder = _folder
    self.obj = _objName
    self.size = _maxCount or 100
    self.objList = {}
    print(string.format('[ObjPoolUtil] 创建了一个%s的对象池，目录为%s', _objName, _folder.Name))
    _preSpawnCount = _preSpawnCount or self.size
    ObjPoolMgr.AddPool(self)
    self:PreSpawn(_preSpawnCount)
end

function ObjPoolUtil:PreSpawn(_preSpawnCount)
    if _preSpawnCount == 0 then
        return
    end
    ObjPoolMgr.PreCreate(self.obj, _preSpawnCount)
end

function ObjPoolUtil:SpawnFromPool(_position, _rotation)
    -- ObjPoolMgr.Borrow(self.obj)
    if #self.objList == 0 then

    else
    end
    tmpObj = world:CreateInstance(self.obj,self.obj,self.folder)
    tmpObj:SetActive(false)
    table.insert(self.objList, tmpObj)
end

function ObjPoolUtil.GetProcess(_obj)
    return ObjPoolMgr.createCounter
end

---从池中创建对象到世界下
---@param _position Vector3
---@param _rotation EulerDegree
function ObjPoolUtil:Spawn(_position, _rotation)
    local realObj = nil
    if #self.pool == 0 then
        realObj = world:CreateInstance(self.obj, self.obj, self.folder, _position, _rotation)
        if realObj == nil then
            error(string.format('[ObjPoolUtil] Archetype下没有名为%s的对象', self.obj))
            return
        end
        return realObj
    else
        realObj = self.pool[1]
        self.pool[1].Position = _position
        self.pool[1].Rotation = _rotation or EulerDegree(0, 0, 0)
        self.pool[1].IsStatic = false
        self.pool[1]:SetActive(true)
        table.remove(self.pool, 1)
        return realObj
    end
end

---从世界中销毁对象到池中
---@param _obj Object
function ObjPoolUtil:Despawn(_obj)
    if _obj == nil then
        error('[ObjPoolUtil] 传入对象为空')
    elseif #self.pool > self.maxCount then
        print(string.format('[ObjPoolUtil] %s对象池已满，该对象会永久销毁', self.obj))
        _obj:Destroy()
    else
        table.insert(self.pool, _obj)
        _obj:SetActive(false)
        self.pool[1].IsStatic = true
    end
end

return ObjPoolUtil
