--- 将Global.Module目录下每一个用到模块提前require,定义为全局变量
-- @script Module Defines
-- @copyright Lilith Games, Avatar Team

-- Game Defines
GAME_ID = 'X0000'
print('GAME_ID = ', GAME_ID)



-- Module Utility
ModuleUtil = require(Utility.ModuleUtilModule)



-- Utilities
LuaJsonUtil = require(Utility.LuaJsonUtilModule)
NetUtil = require(Utility.NetUtilModule)
CsvUtil = require(Utility.CsvUtilModule)
XlsUtil = require(Utility.XlsUtilModule)
EventUtil = require(Utility.EventUtilModule)
UUID = require(Utility.UuidModule)
TweenController = require(Utility.TweenControllerModule)
GlobalFunc = require(Utility.GlobalFuncModule)
LinkedList = Utility.LinkedListModule
ValueChangeUtil = require(Utility.ValueChangeUtilModule)
TimeUtil = require(Utility.TimeUtilModule)
CloudLogUtil = require(Utility.CloudLogUtilModule)
ObjPoolUtil = require(Utility.ObjPoolUtilModule)
SoundUtil = require(Utility.SoundUtilModule)

-- Init Utilities
TimeUtil.Init()
CloudLogUtil.Init(GAME_ID)

-- Framework
ModuleUtil.LoadModules(Framework)
ModuleUtil.LoadModules(Framework.Server)
ModuleUtil.LoadModules(Framework.Client)

-- Defines
ModuleUtil.LoadModules(Define)
-- Xls Config
ModuleUtil.LoadXlsModules(Xls, Config)

-- Server and Clinet Modules
ModuleUtil.LoadModules(Module.S_Module)
ModuleUtil.LoadModules(Module.Cls_Module)
ModuleUtil.LoadModules(Module.C_Module)

-- Plugin Modules
GuideSystem = require(world.Global.Plugin.FUNC_Guide.GuideSystemModule)
