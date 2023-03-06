--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')
shared.require('CEntity')
shared.require('CRealTimeShadow')

shared.ffidef[[
	struct CPhysical {
		CEntity        Entity;
		int 					 field_38;
		unsigned int   LastCollisionTime;
		struct {
			unsigned int b01 : 1;
			unsigned int ApplyGravity : 1;
			unsigned int DisableCollisionForce : 1;
			unsigned int Collidable : 1;
			unsigned int DisableTurnForce : 1;
			unsigned int DisableMoveForce : 1;
			unsigned int InfiniteMass : 1;
			unsigned int DisableZ : 1;

			unsigned int SubmergedInWater : 1;
			unsigned int OnSolidSurface : 1;
			unsigned int Broken : 1;
			unsigned int b12 : 1;
			unsigned int b13 : 1;
			unsigned int DontApplySpeed : 1;
			unsigned int b15 : 1;
			unsigned int b16 : 1;

			unsigned int b17 : 1;
			unsigned int b18 : 1;
			unsigned int BulletProof : 1;
			unsigned int FireProof : 1;
			unsigned int CollisionProof : 1;
			unsigned int MeeleProof : 1;
			unsigned int Invulnerable : 1;
			unsigned int ExplosionProof : 1;

			unsigned int b25 : 1;
			unsigned int AttachedToEntity : 1;
			unsigned int b27 : 1;
			unsigned int TouchingWater : 1;
			unsigned int CanBeCollidedWith : 1;
			unsigned int Destroyed : 1;
			unsigned int b31 : 1;
			unsigned int b32 : 1;
		} PhysicalFlags;
		RwV3D         	   MoveSpeed;
    RwV3D         	   TurnSpeed;
    RwV3D         	   FrictionMoveSpeed;
    RwV3D         	   FrictionTurnSpeed;
    RwV3D          	   Force;
    RwV3D          	   Torque;
    float              Mass;
    float              TurnMass;
    float              VelocityFrequency;
    float              AirResistance;
    float              Elasticity;
    float              BuoyancyConstant;
    RwV3D              CentreOfMass;
    void              *CollisionList;
    void              *MovingList;
    char 							 field_B8;
    unsigned char      NumEntitiesCollided;
    unsigned char      ContactSurface;
    char 							 field_BB;
    struct CEntity    *CollidedEntities[6];
    float              MovingSpeed;
    float              DamageIntensity;
    struct CEntity    *DamageEntity;
    RwV3D              LastCollisionImpactVelocity;
    RwV3D              LastCollisionPosn;
    unsigned short     PieceType;
    short 						 field_FA;
    CPhysical  				*AttachedTo;
    RwV3D              AttachOffset;
    RwV3D              AttachedEntityPosn;
    float        			 AttachedEntityRotation[4];
    struct CEntity    *EntityIgnoredCollision;
    float              ContactSurfaceBrightness;
    float              DynamicLighting;
    CRealTimeShadow   *ShadowData;
	};
]]

shared.validate_size('CPhysical', 0x138)
