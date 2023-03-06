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
	struct CWeaponInfo {
		 unsigned int   m_nWeaponFire;
		 float          m_fTargetRange;
		 float          m_fWeaponRange;
		 int            m_nModelId1;
		 int            m_nModelId2;
		 unsigned int   m_nSlot;
		 struct {
			 unsigned int bCanAim : 1;
			 unsigned int bAimWithArm : 1;
			 unsigned int b1stPerson : 1;
			 unsigned int bOnlyFreeAim : 1;
			 unsigned int bMoveAim : 1;
			 unsigned int bMoveFire : 1;
			 unsigned int b06 : 1;
			 unsigned int b07 : 1;
			 unsigned int bThrow : 1;
			 unsigned int bHeavy : 1;
			 unsigned int bContinuosFire : 1;
			 unsigned int bTwinPistol : 1;
			 unsigned int bReload : 1;
			 unsigned int bCrouchFire : 1;
			 unsigned int bReload2Start : 1;
			 unsigned int bLongReload : 1;
			 unsigned int bSlowdown : 1;
			 unsigned int bRandSpeed : 1;
			 unsigned int bExpands : 1;
		 } m_nFlags;
		 unsigned int   m_dwAnimGroup;
		 unsigned short m_nAmmoClip;
		 unsigned short m_nDamage;
		 RwV3D        	m_vecFireOffset;
		 unsigned int   m_nSkillLevel;
		 unsigned int   m_nReqStatLevel;
		 float          m_fAccuracy;
		 float          m_fMoveSpeed;
		 float          m_fAnimLoopStart;
		 float          m_fAnimLoopEnd;
		 unsigned int   m_nAnimLoopFire;
		 unsigned int   m_nAnimLoop2Start;
		 unsigned int   m_nAnimLoop2End;
		 unsigned int   m_nAnimLoop2Fire;
		 float          m_fBreakoutTime;
		 float          m_fSpeed;
		 float          m_fRadius;
		 float          m_fLifespan;
		 float          m_fSpread;
		 unsigned short m_nAimOffsetIndex;
		 unsigned char  m_nBaseCombo;
		 unsigned char  m_nNumCombos;
	};
]]

shared.validate_size('CWeaponInfo', 0x70)
