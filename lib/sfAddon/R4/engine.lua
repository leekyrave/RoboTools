local module = {}

local ffi = require "ffi"

module._AUTHOR = "seven.eXe"
module._VERSION = "1.3"
module._SAMPVER = "SA:MP 0_3_7_R4"

ffi.cdef[[
    struct stSAMP
    {
        char                    pad_0[44];
        void                    *m_pRakClient;
        char                    m_szHostAddress[257];
        char                    m_szHostname[257];
        bool                    m_bDisableCollision;
        bool                    m_bUpdateCameraTarget;
        bool                    m_bNametagStatus;
        int                     m_nPort;
        int                     m_bLanMode;
        int                     m_aMapIcons[100];
        int                     m_nGameState;
        uint32_t                m_lastConnectAttempt;
        struct stServerPresets  *m_pSettings;
        char                    pad_2[5];
        struct stSAMPPools      *m_pPools;
    }__attribute__ ((packed));

    struct stServerPresets
    {
        uint8_t                 byteCJWalk;
        int                     m_iDeathDropMoney;
        float	                fWorldBoundaries[4];
        bool                    m_bAllowWeapons;
        float	                fGravity;
        uint8_t                 byteDisableInteriorEnterExits;
        uint32_t                ulVehicleFriendlyFire;
        bool                    m_byteHoldTime;
        bool                    m_bInstagib;
        bool                    m_bZoneNames;
        bool                    m_byteFriendlyFire;
        int		                iClassesAvailable;
        float	                fNameTagsDistance;
        bool                    m_bManualVehicleEngineAndLight;
        uint8_t                 byteWorldTime_Hour;
        uint8_t                 byteWorldTime_Minute;
        uint8_t                 byteWeather;
        uint8_t                 byteNoNametagsBehindWalls;
        int                     iPlayerMarkersMode;
        float	                fGlobalChatRadiusLimit;
        uint8_t                 byteShowNameTags;
        bool                    m_bLimitGlobalChatRadius;
    }__attribute__ ((packed));
]]

local function getSampInfo()
    return ffi.cast('struct stSAMP**', getModuleHandle("samp.dll") + 0x26EA0C)[0]
end

function module.sampGetCJWalkStatus()
    return getSampInfo().m_pSettings.byteCJWalk
end

function module.sampGetGlobalGravity()
    return getSampInfo().m_pSettings.fGravity
end

function module.sampGetStatusDisableInteriorEnterExits()
    return getSampInfo().m_pSettings.byteDisableInteriorEnterExits
end

function module.sampGetNametagRenderDistance()
    return getSampInfo().m_pSettings.fNameTagsDistance
end

function module.sampGetNametagsRenderStatusBehindWalls()
    return getSampInfo().m_pSettings.byteNoNametagsBehindWalls
end

function module.sampSetNametagStatus(value)
    value = ffi.cast("bool", value)
    getSampInfo().m_bNametagStatus = value
end

function module.sampSetNametagRenderDistance(distance)
    distance = ffi.cast("float", distance)
    getSampInfo().m_pSettings.fNameTagsDistance = distance
end

function module.sampSetNametagsRenderStatusBehindWalls(status)
    status = ffi.cast("uint8_t", status)
    getSampInfo().m_pSettings.byteNoNametagsBehindWalls = status
end

function module.sampGetServerPort()
    return getSampInfo().m_nPort
end

function module.sampGetCurrentGamestate()
    return getSampInfo().m_nGameState
end

function module.sampGetCollisionStatus()
    return getSampInfo().m_bDisableCollision
end

function module.sampSetCollisionStatus(status)
    status = ffi.cast("bool", status)
    getSampInfo().m_bDisableCollision = status
end

function module.sampGetServerAddress()
    return ffi.string(getSampInfo().m_szHostAddress)
end

function module.sampGetServerHostname()
    return ffi.string(getSampInfo().m_szHostname)
end

function module.sampGetLanMode()
    return getSampInfo().m_bLanMode
end

function module.sampGetNametagStatus()
    return getSampInfo().m_bNametagStatus
end

return module