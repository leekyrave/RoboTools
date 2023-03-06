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

shared.ffidef[[
	struct CNodeAddress {
		short wAreaId;
		short wNodeId;
	};

	struct CCarPathLinkAddress {
		short wCarPathLinkId : 10;
		short wAreaId : 6;
	};

	struct CAutoPilot {
		CNodeAddress         currentAddress;
		CNodeAddress         startingRouteNode;
		CNodeAddress field_8;
		int field_C;
		unsigned int         nSpeedScaleFactor;
		CCarPathLinkAddress  nCurrentPathNodeInfo;
		CCarPathLinkAddress  nNextPathNodeInfo;
		CCarPathLinkAddress  nPreviousPathNodeInfo;
		char field_1A[2];
		unsigned int         nTimeToStartMission;
		unsigned int         nTimeSwitchedToRealPhysics;
		char field_24;
		char _smthCurr;
		char _smthNext;
		char                 nCurrentLane;
		char                 nNextLane;
		char                 nCarDrivingStyle;
		char                 nCarMission;
		char                 nTempAction;
		unsigned int         nTempActionTime;
		unsigned int _someStartTime;
		char field_34;
		char field_35;
		char field_36[2];
		float field_38;
		float                fMaxTrafficSpeed;
		char nCruiseSpeed;
		char field_41;
		char field_42[2];
		float field_44;
		char field_48[1];
		char field_49;
		char field_4A;
		unsigned char        nCarCtrlFlags;
		char field_4C;
		char                 nStraightLineDistance;
		char field_4E;
		char field_4F;
		char field_50;
		char field_51;
		char field_52[10];
		RwV3D              vecDestinationCoors;
		CNodeAddress         aPathFindNodesInfo[8];
		unsigned short       nPathFindNodesCount;
		char field_8A[2];
		struct CVehicle      *pTargetCar;
		struct CEntity       *pCarWeMakingSlowDownFor;
		char field_94;
		char field_95;
		short field_96;
	};
]]

shared.validate_size('CAutoPilot', 0x98)
