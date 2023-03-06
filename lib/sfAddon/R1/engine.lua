local module = {}

local ffi = require "ffi"
local memory = require "memory"

ffi.cdef[[
    struct stSAMP
    {
        void					*pUnk0;
        void			        *pServerInfo;
        uint8_t					byteSpace[24];
        char					szIP[257];
        char					szHostname[259];
        bool					bNametagStatus;
        uint32_t				ulPort;
        uint32_t				ulMapIcons[100];
        int						iLanMode;
        int						iGameState;
        uint32_t				ulConnectTick;
        struct stServerPresets	*pSettings;
        void					*pRakClientInterface;
        void		            *pPools;
    }__attribute__ ((packed));

    struct stPlayerPool
    {
        uint32_t				ulMaxPlayerID;
        uint16_t				sLocalPlayerID;
        void					*pVTBL_txtHandler;
        const char*				strLocalPlayerName;
        struct stLocalPlayer	*pLocalPlayer;
        int						iLocalPlayerPing;
        int						iLocalPlayerScore;
        struct stRemotePlayer	*pRemotePlayer[1004];
        int						iIsListed[1004];
        uint32_t				dwPlayerIP[1004];
    }__attribute__ ((packed));

    struct stLocalPlayer
    {
        struct stSAMPPed		*pSAMP_Actor;
        uint16_t				sCurrentAnimID;
        uint16_t				sAnimFlags;
        uint32_t				ulUnk0;
        int						iIsActive;
        int						iIsWasted;
        uint16_t				sCurrentVehicleID;
        uint16_t				sLastVehicleID;
        struct stOnFootData		*onFootData;
        struct stPassengerData	*passengerData;
        struct stTrailerData	*trailerData;
        struct stInCarData		*inCarData;
        struct stAimData		*aimData;
        uint8_t					byteTeamID;
        int						iSpawnSkin;
        uint8_t					byteUnk1;
        float					fSpawnPos[3];
        float					fSpawnRot;
        int						iSpawnWeapon[3];
        int						iSpawnAmmo[3];
        int						iIsActorAlive;
        int						iSpawnClassLoaded;
        uint32_t				ulSpawnSelectionTick;
        uint32_t				ulSpawnSelectionStart;
        int						iIsSpectating;
        uint8_t					byteTeamID2;
        uint16_t				usUnk2;
        uint32_t				ulSendTick;
        uint32_t				ulSpectateTick;
        uint32_t				ulAimTick;
        uint32_t				ulStatsUpdateTick;
        uint32_t				ulWeapUpdateTick;
        uint16_t				sAimingAtPid;
        uint16_t				usUnk3;
        uint8_t					byteCurrentWeapon;
        uint8_t					byteWeaponInventory[13];
        int						iWeaponAmmo[13];
        int						iPassengerDriveBy;
        uint8_t					byteCurrentInterior;
        int						iIsInRCVehicle;
        uint16_t				sTargetObjectID;
        uint16_t				sTargetVehicleID;
        uint16_t				sTargetPlayerID;
        struct stHeadSync		*headSyncData;
        uint32_t				ulHeadSyncTick;
        int					    byteSpace3[260];
        struct stSurfData		*surfData;
        int						iClassSelectionOnDeath;
        int						iSpawnClassID;
        int						iRequestToSpawn;
        int						iIsInSpawnScreen;
        uint32_t				ulUnk4;
        uint8_t					byteSpectateMode;
        uint8_t					byteSpectateType;
        int						iSpectateID;
        int						iInitiatedSpectating;
        struct stDamageData		*vehicleDamageData;
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

    struct stAudio
	{
		int	iSoundState; // 0 - Finished, 1 - Loaded, 2 - Playing
	}__attribute__ ((packed));

	struct stCamera
	{
		void*	pEntity;
		struct CMatrix_Padded* matrix;
	}__attribute__ ((packed));

	struct stGameInfo
	{
		struct stAudio*	    pAudio;
		struct stCamera*	pCamera;
		struct stSAMPPed*	pLocalPlayerPed;
		float		        fCheckpointPos[3];
		float		        fCheckpointExtent[3];
		int			        bCheckpointsEnabled;
		uint32_t		    dwCheckpointMarker;
		float		        fRaceCheckpointPos[3];
		float		        fRaceCheckpointNext[3];
		float		        m_fRaceCheckpointSize;
		uint8_t		        byteRaceType;
		int			        bRaceCheckpointsEnabled;
		uint32_t		    dwRaceCheckpointMarker;
		uint32_t		    dwRaceCheckpointHandle;
		int			        iCursorMode;
		uint32_t	        ulUnk1;
		int			        bClockEnabled;
		uint32_t	        ulUnk2;
		int			        bHeadMove;
		uint32_t		    ulFpsLimit;
		uint8_t		        byteUnk3;
		uint8_t		        byteVehicleModels[212];
    }__attribute__ ((packed));
    
    typedef void(__cdecl *CMDPROC)(char *);
    struct stInputInfo
    {
        void				*pD3DDevice;
        void				*pDXUTDialog;
        struct stInputBox	*pDXUTEditBox;
        CMDPROC				pCMDs[144];
        char				szCMDNames[144][33];
        int					iCMDCount;
        int					iInputEnabled;
        char				szInputBuffer[129];
        char				szRecallBufffer[10][129];
        char				szCurrentBuffer[129];
        int					iCurrentRecall;
        int					iTotalRecalls;
        CMDPROC				pszDefaultCMD;
    }__attribute__ ((packed));

    struct stChatInfo
    {
        int					pagesize;
        char				*pLastMsgText;
        int					iChatWindowMode;
        uint8_t				bTimestamps;
        uint32_t			m_iLogFileExist;
        char				logFilePathChatLog[256];
        void				*pGameUI;
        void				*pEditBackground;
        void				*pDXUTScrollBar;
        uint32_t			clTextColor;
        uint32_t			clInfoColor;
        uint32_t			clDebugColor;
        uint32_t			m_lChatWindowBottom;
        struct stChatEntry	*chatEntry[100];
        struct stFontRenderer *m_pFontRenderer;
        void			    *m_pChatTextSprite;
        void			    *m_pSprite;
        void	            *m_pD3DDevice;
        int				    m_iRenderMode;
        void	            *pID3DXRenderToSurface;
        void	            *m_pTexture;
        void	            *pSurface;
        void		        *pD3DDisplayMode;
        int					iUnk1[3];
        int					iUnk2;
        int					m_iRedraw;
        int					m_nPrevScrollBarPosition;
        int					m_iFontSizeY;
        int					m_iTimestampWidth;
        int					m_iTimeStampTextOffset;
    }__attribute__ ((packed));

    struct stScoreboardInfo
    {
        int					iIsEnabled;
        int					iPlayersCount;
        float				fTextOffset[2];
        float				fScalar;
        float				fSize[2];
        float				fUnk0[5];
        void	            *pDirectDevice;
        void	            *pDialog;
        void                *pList;
        int					iOffset;
        int					iIsSorted;
    }__attribute__ ((packed));
]]

module._AUTHOR = "seven.eXe"
module._VERSION = "1.3"
module._SAMPVER = "SA:MP 0_3_7_R1"

local function getSampInfo()
    return ffi.cast('struct stSAMP*', sampGetSampInfoPtr())
end

local function getMiscInfo()
    return ffi.cast('struct stGameInfo*', sampGetMiscInfoPtr())
end

local function getInputInfo()
    return ffi.cast('struct stInputInfo*', sampGetInputInfoPtr())
end

local function getChatInfo()
    return ffi.cast('struct stChatInfo*', sampGetChatInfoPtr())
end

local function getPlayerPool()
    return ffi.cast('struct stPlayerPool*', sampGetPlayerPoolPtr())
end

function module.sampIsAudioStreamPlaying()
    return memory.read(sampGetBase() + 0x12E690, 4, true)
end

function module.sampIsAudioStream3D()
    return memory.read(sampGetBase() + 0x12E6A0, 4, true)
end

function module.sampGetAudioStreamRadius()
    return memory.getfloat(sampGetBase() + 0x1027BC, true)
end

function module.sampSendLog(type, text, prefix)
    type = ffi.cast("int", type)
    text = ffi.cast("const char*", text)
    prefix = ffi.cast("const char*", prefix)
    ffi.cast('void (__thiscall *)(void *, int, const char*, const char*)', sampGetBase() + 0x63C00)(getChatInfo(), type, text, prefix)
end

function module.sampSetLocalColor(d3dColor)
    d3dColor = ffi.cast("uint32_t", d3dColor)
    ffi.cast('void (__thiscall *)(void *, uint32_t)', sampGetBase() + 0x3D40)(getPlayerPool().pLocalPlayer, d3dColor)
end

function module.sampGetTimestamp()
    return getChatInfo().bTimestamps
end

function module.sampSetTimestampStatus(status)
    status = ffi.cast("uint8_t", status)
    getChatInfo().bTimestamps = status
end

function module.sampGetChatMode()
    return getChatInfo().iChatWindowMode
end

function module.sampSetChatMode(mode)
    mode = ffi.cast("int", mode)
    getChatInfo().iChatWindowMode = mode
end

function module.sampGetCurrentPagesize()
    return getChatInfo().pagesize
end

function module.sampSetPagesize(psize) -- updated on 1.3
    psize = ffi.cast("int", psize)
    ffi.cast('void (__thiscall *)(void *, int)', sampGetBase() + 0x636D0)(getChatInfo(), psize)
end

function module.sampGetCommandNameByNumber(cmdNum)
    cmdNum = ffi.cast("int", cmdNum)
    return "/"..ffi.string(getInputInfo().szCMDNames[cmdNum])
end

function module.sampSetCommandNameByNumber(commandName, cmdNum)
    cmdNum = ffi.cast("int", cmdNum)
    commandName = ffi.cast("char", commandName)
    getInputInfo().szCMDNames[cmdNum] = commandName
end

function module.sampGetFPSLimit()
    return getMiscInfo().ulFpsLimit
end

function module.sampGetHeadMoveStatus()
    return getMiscInfo().bHeadMove
end

function module.sampSetHeadMoveStatus(bhead)
    bhead = ffi.cast("int", bhead)
    getMiscInfo().bHeadMove = bhead
end

function module.sampSetFPSLimit(limit)
    --if limit < 20 or limit > 90 then return error("Invalid FPS Limit") end
    -- all limits are required (but /fpslimit required 20 to 90)
    limit = ffi.cast("uint32_t", limit)
    getMiscInfo().ulFpsLimit = limit
end

function module.sampGetNametagStatus()
    return getSampInfo().bNametagStatus
end

function module.sampGetLanMode()
    return getSampInfo().iLanMode
end

function module.sampGetCJWalkStatus()
    return getSampInfo().pSettings.byteCJWalk
end

function module.sampGetWorldBoundaries()
    return getSampInfo().pSettings.fWorldBoundaries[1], SampInfo.pSettings.fWorldBoundaries[2], SampInfo.pSettings.fWorldBoundaries[3], SampInfo.pSettings.fWorldBoundaries[4]
end

function module.sampGetGlobalGravity()
    return getSampInfo().pSettings.fGravity
end

function module.sampGetStatusDisableInteriorEnterExits()
    return getSampInfo().pSettings.byteDisableInteriorEnterExits
end

function module.sampGetNametagRenderDistance()
    return getSampInfo().pSettings.fNameTagsDistance
end

function module.sampGetNametagsRenderStatusBehindWalls()
    return getSampInfo().pSettings.byteNoNametagsBehindWalls
end

function module.sampSetNametagStatus(value)
    value = ffi.cast("bool", value)
    getSampInfo().bNametagStatus = value
end

function module.sampSetWorldBoundaries(x_max, x_min, y_max, y_min)
    x_max, x_min, y_max, y_min = ffi.cast("float", x_max, x_min, y_max, y_min)
    getSampInfo().pSettings.fWorldBoundaries[1], SampInfo.pSettings.fWorldBoundaries[2], SampInfo.pSettings.fWorldBoundaries[3], SampInfo.pSettings.fWorldBoundaries[4] = x_max, x_min, y_max, y_min
end

function module.sampSetNametagRenderDistance(distance)
    distance = ffi.cast("float", distance)
    getSampInfo().pSettings.fNameTagsDistance = distance
end

function module.sampSetNametagsRenderStatusBehindWalls(status)
    status = ffi.cast("uint8_t", status)
    getSampInfo().pSettings.byteNoNametagsBehindWalls = status
end

return module