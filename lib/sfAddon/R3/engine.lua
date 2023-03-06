local module = {}

local ffi = require "ffi"
local memory = require "memory"

local sa_addrs = {
    0x26E8C8, -- CChat
    0x26E8CC, -- CInput
    0x26E8D0, -- CDeathWindow
    0x26E894, -- CScoreboard
    0x26E898, -- CDialog
    0x26E8F4 -- CGame
}

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

    typedef void(__cdecl *CMDPROC)(char *);
    struct stInputInfo
    {
        void              *m_pDevice;
        void              *m_pGameUI;
        void              *m_pEditbox;
        CMDPROC           m_commandProc[144];
        char              m_szCommandName[144][32 + 1];
        int               m_nCommandCount;
        int               m_bEnabled;
        char              m_szInput[129];
        char              m_szRecallBufffer[10][129];
        char              m_szCurrentBuffer[129];
        int               m_nCurrentRecall;
        int               m_nTotalRecall;
        CMDPROC           m_defaultCommand;
    }__attribute__ ((packed));

    struct stChatInfo
    {
        unsigned int    m_nPageSize;
        char*           m_szLastMessage;
        int             m_nMode;
        bool            m_bTimestamps;
        int             m_bDoesLogExist;
        char            m_szLogPath[261];
        void*           m_pGameUi;
        void*           m_pEditbox;
        void*           m_pScrollbar;
        uint32_t        m_textColor; 
        uint32_t        m_infoColor;
        uint32_t        m_debugColor;
        uint32_t        m_nWindowBottom;
        struct stChatEntry *chatEntry[100];
        struct CFonts*  m_pFontRenderer;
        void*           m_pTextSprite;
        void*           m_pSprite;
        void*           m_pDevice;
        int             m_bRenderToSurface;
        void*           m_pRenderToSurface;
        void*           m_pTexture;
        void*           m_pSurface;
        void*           m_displayMode;
        int             pad_[2];
        int             m_bRedraw;
        long            m_nScrollbarPos;
        long            m_nCharHeight;
        long            m_nTimestampWidth;
    }__attribute__ ((packed));

    struct stGameInfo
    {
        struct stAudio      *m_pAudio;
        struct stCamera*    *m_pCamera;
        struct stSAMPPed*   *m_pPlayerPed;
        float               m_currentPosition[3]; // race checkpoints
        float               m_nextPosition[3];
        float               m_fSize;
        char                m_nType;
        int                 m_bEnabled;
        void                *m_marker;
        void                *m_handle;
        float               m_position[3]; // standart checkpoints
        float               m_size[3];
        int                 m_bEnabled;
        void                *m_handle;
        int                 field_61;
        int                 m_bHeadMove;
        int                 m_nFrameLimiter;
        int                 m_nCursorMode;
        unsigned int        m_nInputEnableWaitFrames;
        int                 m_bClockEnabled;
        char                field_6d;
        bool                m_aKeepLoadedVehicleModels[212];
    }__attribute__ ((packed));
    
    struct stPlayerPool
    {
        int          m_nLargestId;
        void         *m_pObject[1004];
        int          m_bNotEmpty[1004];
        int          m_bPrevCollisionFlag[1004];
        int          m_nPing;
        int          m_nScore;
        int          m_nId;
        const char*  m_szName;
        struct stLocalPlayer *m_pObject;
    }__attribute__ ((packed));
]]

module._AUTHOR = "seven.eXe"
module._VERSION = "1.3"
module._SAMPVER = "SA:MP 0_3_7_R3"

local function getSampInfo()
    return ffi.cast('struct stSAMP**', getModuleHandle("samp.dll") + 0x26E8DC)[0]
end

local function getInputInfo()
    return ffi.cast('struct stInputInfo**', getModuleHandle("samp.dll") + 0x26E8CC)[0]
end

local function getChatInfo()
    return ffi.cast('struct stChatInfo**', getModuleHandle("samp.dll") + 0x26E8C8)[0]
end

local function getMiscInfo()
    return ffi.cast('struct stGameInfo**', getModuleHandle("samp.dll") + 0x26E8F4)[0]
end

function module.sampGetTimestamp()
    return getChatInfo().m_bTimestamps
end

function module.sampSetTimestampStatus(status)
    status = ffi.cast("bool", status)
    getChatInfo().m_bTimestamps = status
end

function module.sampGetChatMode()
    return getChatInfo().m_nMode
end

function module.sampSetChatMode(mode) -- bugged in R3!! (maybe crash or destroy chat)
    mode = ffi.cast("int", mode)
    getChatInfo().m_nMode = mode
end

function module.sampGetCurrentPagesize()
    return getChatInfo().m_nPageSize
end

function module.sampSetPagesize(psize)
    psize = ffi.cast("int", psize)
    ffi.cast('void (__thiscall *)(void *, int)', getModuleHandle("samp.dll") + 0x66B20)(getChatInfo(), psize)
end

function module.sampGetFPSLimit()
    return getMiscInfo().m_nFrameLimiter
end

function module.sampGetHeadMoveStatus()
    return getMiscInfo().m_bHeadMove
end

function module.sampSetHeadMoveStatus(bhead)
    bhead = ffi.cast("int", bhead)
    getMiscInfo().m_bHeadMove = bhead
end

function module.sampSetFPSLimit(limit)
    --if limit < 20 or limit > 90 then return error("Invalid FPS Limit") end
    -- all limits are required (but /fpslimit required 20 to 90)
    limit = ffi.cast("int", limit)
    getMiscInfo().m_nFrameLimiter = limit
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

function module.sampGetCommandNameByNumber(cmdNum)
    cmdNum = ffi.cast("int", cmdNum)
    return "/"..ffi.string(getInputInfo().m_szCommandName[cmdNum])
end

function module.sampGetServerPort()
    return getSampInfo().m_nPort
end

function module.sampGetCurrentGamestate()
    return getSampInfo().m_nGameState
end

function module.isSAMPAvailable()
    local SAHandle = getModuleHandle("samp.dll")
    local result = true
    for k, v in pairs(sa_addrs) do
        result = result and memory.getuint32(SAHandle + v) ~= 0x0
    end
    return result
end

function module.sampAddChatMessage(text, color)
    text = ffi.cast("const char*", text)
    color = ffi.cast("uint32_t", color)
    ffi.cast('void (__thiscall *)(void *, uint32_t, const char*)', getModuleHandle("samp.dll") + 0x679F0)(getChatInfo(), color, text)
end

--if SAMP has been crashed with this function, use sampDeleteChatCommand(cmdName) in onExitScript callback
function module.sampRegisterChatCommand(cmdName, cmdCallback)
    cmdCallback = ffi.cast('CMDPROC', cmdCallback)
	cmdName = ffi.cast('char *', cmdName)
	ffi.cast('void (__thiscall *)(void *, char *, CMDPROC)', getModuleHandle("samp.dll") + 0x69000)(getInputInfo(), cmdName, cmdCallback)
end

function module.sampDeleteChatCommand(cmdName) -- from SA-MP API
	local reached = false
	for i = 0, 143 do
		if ffi.string(getInputInfo().m_szCommandName[i]) == cmdName and not reached then
			getInputInfo().m_nCommandCount = getInputInfo().m_nCommandCount - 1
			reached = true
		end
		if reached then
			if i == 143 then return end
			getInputInfo().m_szCommandName[i] = getInputInfo().m_szCommandName[i + 1]
			getInputInfo().m_commandProc[i] = getInputInfo().m_commandProc[i + 1]
		end
	end
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