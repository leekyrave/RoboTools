--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')
shared.require('CVehicle')
shared.require('CEntity')
shared.require('CDoor')
shared.require('FxSystem_c')
shared.require('tBoatHandlingData')

shared.ffidef[[
	enum eBoatNodes {
		BOAT_NODE_NONE = 0,
		BOAT_MOVING = 1,
		BOAT_WINDSCREEN = 2,
		BOAT_RUDDER = 3,
		BOAT_FLAP_LEFT = 4,
		BOAT_FLAP_RIGHT = 5,
		BOAT_REARFLAP_LEFT = 6,
		BOAT_REARFLAP_RIGHT = 7,
		BOAT_STATIC_PROP = 8,
		BOAT_MOVING_PROP = 9,
		BOAT_STATIC_PROP_2 = 10,
		BOAT_MOVING_PROP_2 = 11,
		BOAT_NUM_NODES
	};

	struct CBoat {
		CVehicle           Vehicle;
		float              fMovingHiRotation;
		float              fPropSpeed;
		float              fPropRotation;
		struct {
				unsigned char bOnWater : 1;
				unsigned char bMovingOnWater : 1;
				unsigned char bAnchored : 1;
		} nBoatFlags;
		char _pad5AD[3];
		RwFrame           *aBoatNodes[12];
		CDoor              boatFlap;
		tBoatHandlingData *pBoatHandling;
		float              fAnchoredAngle;
		int                nAttackPlayerTime;
		int field_604;
		float              fBurningTimer;
		CEntity           *pWhoDestroyedMe;
		RwV3D            vecBoatMoveForce;
		RwV3D            vecBoatTurnForce;
		FxSystem_c        *apPropSplashFx[2];
		RwV3D            vecWaterDamping;
		char field_63C;
		unsigned char      nPadNumber;
		char _pad63E[2];
		float              fWaterResistance;
		short              nNumWaterTrailPoints;
		char _pad646[2];
		RwV2D          avecWakePoints[32];
		float              afWakePointLifeTime[32];
		unsigned char      anWakePointIntensity[32];
	};
]]

shared.validate_size('CBoat', 0x7E8)
