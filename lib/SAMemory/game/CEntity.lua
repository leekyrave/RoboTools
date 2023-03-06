--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CPlaceable')
shared.require('RenderWare')
shared.require('CReference')

shared.ffidef[[
	struct CEntity {
		CPlaceable  Placeable;
		union {
			 RwObject *pRwObject;
			 RpClump  *pRwClump;
			 RpAtomic *pRwAtomic;
	 	};

	  unsigned int UsesCollision : 1;
	  unsigned int CollisionProcessed : 1;
	  unsigned int IsStatic : 1;
	  unsigned int HasContacted : 1;
	  unsigned int IsStuck : 1;
	  unsigned int IsInSafePosition : 1;
	  unsigned int WasPostponed : 1;
	  unsigned int IsVisible : 1;

	  unsigned int IsBIGBuilding : 1;
	  unsigned int RenderDamaged : 1;
	  unsigned int StreamingDontDelete : 1;
	  unsigned int RemoveFromWorld : 1;
	  unsigned int HasHitWall : 1;
	  unsigned int ImBeingRendered : 1;
	  unsigned int DrawLast :1;
	  unsigned int DistanceFade :1;

	  unsigned int DontCastShadowsOn : 1;
	  unsigned int Offscreen : 1;
	  unsigned int IsStaticWaitingForCollision : 1;
	  unsigned int DontStream : 1;
	  unsigned int Underwater : 1;
	  unsigned int HasPreRenderEffects : 1;
	  unsigned int IsTempBuilding : 1;
	  unsigned int DontUpdateHierarchy : 1;

	  unsigned int HasRoadsignText : 1;
	  unsigned int DisplayedSuperLowLOD : 1;
	  unsigned int IsProcObject : 1;
	  unsigned int BackfaceCulled : 1;
	  unsigned int LightObject : 1;
	  unsigned int UnimportantStream : 1;
	  unsigned int Tunnel : 1;
	  unsigned int TunnelTransition : 1;

	  unsigned short RandomSeed;
	  unsigned short ModelIndex;
	  CReference    *pReferences;
	  void          *pStreamingLink;
	  short 				 ScanCode;
	  char 					 IplIndex;
	  unsigned char AreaCode;
	  union {
			 int LodIndex;
			 CEntity *pLod;
	  };
	  unsigned char NumLodChildren;
	  unsigned char NumLodChildrenRendered;
	  unsigned char Type : 3;
	  unsigned char Status : 5;
	};
]]

shared.validate_size('CEntity', 0x38)
