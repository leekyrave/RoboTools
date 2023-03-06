--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stSAMPKeys {
		unsigned char keys_primaryFire : 1;
		unsigned char keys_horn__crouch : 1;
		unsigned char keys_secondaryFire__shoot : 1;
		unsigned char keys_accel__zoomOut : 1;
		unsigned char keys_enterExitCar : 1;
		unsigned char keys_decel__jump : 1;
		unsigned char keys_circleRight : 1;
		unsigned char keys_aim : 1;
		unsigned char keys_circleLeft : 1;
		unsigned char keys_landingGear__lookback : 1;
		unsigned char keys_unknown__walkSlow : 1;
		unsigned char keys_specialCtrlUp : 1;
		unsigned char keys_specialCtrlDown : 1;
		unsigned char keys_specialCtrlLeft : 1;
		unsigned char keys_specialCtrlRight : 1;
		unsigned char keys__unused : 1;
	};

	struct stOnFootData {
		unsigned short	sLeftRightKeys;
		unsigned short	sUpDownKeys;
		union {
			unsigned short			sKeys;
			stSAMPKeys	stSampKeys;
		};
		float		fPosition[3];
		float		fQuaternion[4];
		unsigned char		byteHealth;
		unsigned char		byteArmor;
		unsigned char		byteCurrentWeapon;
		unsigned char		byteSpecialAction;
		float		fMoveSpeed[3];
		float		fSurfingOffsets[3];
		unsigned short	sSurfingVehicleID;
		short		sCurrentAnimationID;
		short		sAnimFlags;
	};

	struct stInCarData {
		unsigned short	sVehicleID;
		unsigned short	sLeftRightKeys;
		unsigned short	sUpDownKeys;
		union {
			unsigned short			sKeys;
			struct stSAMPKeys	stSampKeys;
		};
		float		fQuaternion[4];
		float		fPosition[3];
		float		fMoveSpeed[3];
		float		fVehicleHealth;
		unsigned char		bytePlayerHealth;
		unsigned char		byteArmor;
		unsigned char		byteCurrentWeapon;
		unsigned char		byteSiren;
		unsigned char		byteLandingGearState;
		unsigned short	sTrailerID;
		union {
			unsigned short	HydraThrustAngle[2];
			float		fTrainSpeed;
			float       fBikeSideAngle;
		};
	};

	struct stAimData {
		unsigned char	byteCamMode;
		float	vecAimf1[3];
		float	vecAimPos[3];
		float	fAimZ;
		unsigned char	byteCamExtZoom : 6;
		unsigned char	byteWeaponState : 2;
		unsigned char	byteAspectRatio;
	};

	struct stTrailerData {
		unsigned short	sTrailerID;
		float		fPosition[3];
		float		fQuaternion[4];
		float		fSpeed[3];
		float		fSpin[3];
	};

	struct stPassengerData {
		unsigned short	sVehicleID;
		unsigned char		byteSeatID;
		unsigned char		byteCurrentWeapon;
		unsigned char		byteHealth;
		unsigned char		byteArmor;
		unsigned short	sLeftRightKeys;
		unsigned short	sUpDownKeys;
		union {
			unsigned short			sKeys;
			stSAMPKeys	stSampKeys;
		};
		float	fPosition[3];
	};

	struct stDamageData {
		unsigned short	sVehicleID_lastDamageProcessed;
		int				iBumperDamage;
		int				iDoorDamage;
		unsigned char		byteLightDamage;
		unsigned char		byteWheelDamage;
	};

	struct stSurfData {
		int			iIsSurfing;
		float		fSurfPosition[3];
		int			iUnk0;
		unsigned short	sSurfingVehicleID;
		unsigned int	ulSurfTick;
		struct stSAMPVehicle *pSurfingVehicle;
		int			iUnk1;
		int			iSurfMode;
	};

	struct stUnoccupiedData {
		int16_t sVehicleID;
		unsigned char byteSeatID;
		float	fRoll[3];
		float	fDirection[3];
		float	fPosition[3];
		float	fMoveSpeed[3];
		float	fTurnSpeed[3];
		float	fHealth;
	};

	struct stBulletData {
		unsigned char		byteType;
		unsigned short	sTargetID;
		float		fOrigin[3];
		float		fTarget[3];
		float		fCenter[3];
		unsigned char		byteWeaponID;
	};

	struct stSpectatorData {
		unsigned short	sLeftRightKeys;
		unsigned short	sUpDownKeys;
		union {
			unsigned short			sKeys;
			struct stSAMPKeys	stSampKeys;
		};
		float	fPosition[3];
	};

	struct stStatsData {
		int iMoney;
		int iAmmo;
	};

	struct stHeadSync {
		float	fHeadSync[3];
		int		iHeadSyncUpdateTick;
		int		iHeadSyncLookTick;
	};
]]
