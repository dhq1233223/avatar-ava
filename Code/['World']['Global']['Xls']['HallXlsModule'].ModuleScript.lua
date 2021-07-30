--- This file is generated by ava-x2l.exe,
--- Don't change it manaully.
--- @copyright Lilith Games, Project Da Vinci(Avatar Team)
--- @see Official Website: https://www.projectdavinci.com/
--- @see Dev Framework: https://github.com/lilith-avatar/avatar-ava
--- @see X2L Tool: https://github.com/lilith-avatar/avatar-ava-xls2lua
--- source file: ./Xls/Hall.xls

local HallXls = {
    [1001] = {
        ObjId = 1001,
        Name = 'Light',
        Des = '点光源',
        TargetAc = nil,
        MaxVc = nil,
        TargetDownAngle = nil,
        TargetDownTime = nil,
        TargetStayTime = nil,
        RubberScale = nil,
        RubberScaleTime = nil,
        RubberShakeTime = nil,
        RubberShakeStrength = nil,
        ArrowColor = nil,
        ArrowChangeTime = nil
    },
    [1002] = {
        ObjId = 1002,
        Name = 'SpotLight',
        Des = '射灯',
        TargetAc = nil,
        MaxVc = nil,
        TargetDownAngle = nil,
        TargetDownTime = nil,
        TargetStayTime = nil,
        RubberScale = nil,
        RubberScaleTime = nil,
        RubberShakeTime = nil,
        RubberShakeStrength = nil,
        ArrowColor = nil,
        ArrowChangeTime = nil
    },
    [1003] = {
        ObjId = 1003,
        Name = 'Range',
        Des = '靶场',
        TargetAc = 0.02,
        MaxVc = 2.0,
        TargetDownAngle = EulerDegree(90, 124, 0),
        TargetDownTime = 0.3,
        TargetStayTime = 1.0,
        RubberScale = nil,
        RubberScaleTime = nil,
        RubberShakeTime = nil,
        RubberShakeStrength = nil,
        ArrowColor = nil,
        ArrowChangeTime = nil
    },
    [1004] = {
        ObjId = 1004,
        Name = 'Rubber',
        Des = '橡胶体',
        TargetAc = nil,
        MaxVc = nil,
        TargetDownAngle = nil,
        TargetDownTime = nil,
        TargetStayTime = nil,
        RubberScale = Vector3(0.9, 0.9, 0.9),
        RubberScaleTime = 0.6,
        RubberShakeTime = 0.4,
        RubberShakeStrength = 5.0,
        ArrowColor = nil,
        ArrowChangeTime = nil
    },
    [1005] = {
        ObjId = 1005,
        Name = 'RubberNew',
        Des = '新橡胶体',
        TargetAc = nil,
        MaxVc = nil,
        TargetDownAngle = nil,
        TargetDownTime = nil,
        TargetStayTime = nil,
        RubberScale = Vector3(1.5, 1.5, 1.5),
        RubberScaleTime = 0.6,
        RubberShakeTime = 0.4,
        RubberShakeStrength = 5.0,
        ArrowColor = nil,
        ArrowChangeTime = nil
    },
    [1006] = {
        ObjId = 1006,
        Name = 'Arrow',
        Des = '箭头',
        TargetAc = nil,
        MaxVc = nil,
        TargetDownAngle = nil,
        TargetDownTime = nil,
        TargetStayTime = nil,
        RubberScale = nil,
        RubberScaleTime = nil,
        RubberShakeTime = nil,
        RubberShakeStrength = nil,
        ArrowColor = {Color(117,64,35,150), Color(163,127,38, 180), Color(209,169,41,210), Color(255,255,44,255)},
        ArrowChangeTime = 0.35
    }
}

return HallXls
