--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')

shared.ffidef[[
	enum e2dEffectType {
		EFFECT_LIGHT,
		EFFECT_PARTICLE,
		EFFECT_ATTRACTOR = 3,
		EFFECT_SUN_GLARE,
		EFFECT_FURNITUR,
		EFFECT_ENEX,
		EFFECT_ROADSIGN,
		EFFECT_SLOTMACHINE_WHEEL,
		EFFECT_COVER_POINT,
		EFFECT_ESCALATOR,
	};

	enum ePedAttractorType {
		PED_ATTRACTOR_ATM            = 0,
		PED_ATTRACTOR_SEAT           = 1,
		PED_ATTRACTOR_STOP           = 2,
		PED_ATTRACTOR_PIZZA          = 3,
		PED_ATTRACTOR_SHELTER        = 4,
		PED_ATTRACTOR_TRIGGER_SCRIPT = 5,
		PED_ATTRACTOR_LOOK_AT        = 6,
		PED_ATTRACTOR_SCRIPTED       = 7,
		PED_ATTRACTOR_PARK           = 8,
		PED_ATTRACTOR_STEP           = 9
	};

	struct tEffectLight {
		RwColor color;
		float fCoronaFarClip;
		float fPointlightRange;
		float fCoronaSize;
		float fShadowSize;
		unsigned short nFlags;
		unsigned char nCoronaFlashType;
		bool bCoronaEnableReflection;
		unsigned char nCoronaFlareType;
		unsigned char nShadowColorMultiplier;
		char nShadowZDistance;
		char offsetX;
		char offsetY;
		char offsetZ;
		char _pad2E[2];
		RwTexture *pCoronaTex;
		RwTexture *pShadowTex;
		int field_38;
		int field_3C;
	};

	struct tEffectParticle {
		char szName[24];
	};

	struct tEffectPedAttractor {
		RwV3D vecQueueDir;
		RwV3D vecUseDir;
		RwV3D vecForwardDir;
		unsigned char nAttractorType;
		unsigned char nPedExistingProbability;
		char field_36;
		unsigned char nFlags;
		char szScriptName[8];
	};

	struct tEffectEnEx {
		float fEnterAngle;
		RwV3D vecSize;
		RwV3D vecExitPosn;
		float fExitAngle;
		short nInteriorId;
		unsigned char nFlags1;
		unsigned char nSkyColor;
		char szInteriorName[8];
		unsigned char nTimeOn;
		unsigned char nTimeOff;
		unsigned char nFlags2;
	};

	struct tEffectRoadsign {
		RwV2D vecSize;
		float afRotation[3];
		unsigned short nFlags;
		char _pad26[2];
		char *pText;
		RpAtomic *pAtomic;
	};

	struct tEffectCoverPoint {
		RwV2D vecDirection;
		unsigned char nType;
		char _pad19[3];
	};

	struct tEffectEscalator {
		RwV3D vecBottom;
		RwV3D vecTop;
		RwV3D vecEnd;
		unsigned char nDirection;
		char _pad35[3];
	};

	struct C2dEffect {
		RwV3D vecPosn;
		unsigned int nType;
		union {
			struct tEffectLight light;
			struct tEffectParticle particle;
			struct tEffectPedAttractor pedAttractor;
			struct tEffectEnEx enEx;
			struct tEffectRoadsign roadsign;
			struct tEffectCoverPoint coverPoint;
			struct tEffectEscalator escalator;
		};
	};
]]

shared.validate_size('C2dEffect', 0x40)
