--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CWanted')
shared.require('CPedClothesDesc')
shared.require('RenderWare')
shared.require('CPed')
shared.require('CEntity')

shared.ffidef[[
	struct CPlayerData {
		CWanted *pWanted;
		CPedClothesDesc *pPedClothesDesc;
		CCopPed *pArrestingCop;
		RwV2D vecFightMovement;
		float fMoveBlendRatio;
		float fTimeCanRun;
		float fSprintEnergy;
		unsigned char nChosenWeapon;
		unsigned char nCarDangerCounter;
		char _pad0[2];
		unsigned int nStandStillTimer;
		unsigned int nHitAnimDelayTimer;
		float fAttackButtonCounter;
		void *pDangerCar;
		unsigned int bStoppedMoving : 1;
		unsigned int bAdrenaline : 1;
		unsigned int bHaveTargetSelected : 1;
		unsigned int bFreeAiming : 1;
		unsigned int bCanBeDamaged : 1;
		unsigned int bAllMeleeAttackPtsBlocked : 1;
		unsigned int bJustBeenSnacking : 1;
		unsigned int bRequireHandleBreath : 1;
		unsigned int bGroupStuffDisabled : 1;
		unsigned int bGroupAlwaysFollow : 1;
		unsigned int bGroupNeverFollow : 1;
		unsigned int bInVehicleDontAllowWeaponChange : 1;
		unsigned int bRenderWeapon : 1;
		unsigned int nPlayerGroup;
		unsigned int nAdrenalineEndTime;
		unsigned char nDrunkenness;
		unsigned char nFadeDrunkenness;
		unsigned char nDrugLevel;
		unsigned char nScriptLimitToGangSize;
		float fBreath;
		unsigned int nMeleeWeaponAnimReferenced;
		unsigned int nMeleeWeaponAnimReferencedExtra;
		float fFPSMoveHeading;
		float fLookPitch;
		float fSkateBoardSpeed;
		float fSkateBoardLean;
		RpAtomic *pSpecialAtomic;
		float fGunSpinSpeed;
		float fGunSpinAngle;
		unsigned int nLastTimeFiring;
		unsigned int nTargetBone;
		RwV3D vecTargetBoneOffset;
		unsigned int nBusFaresCollected;
		bool bPlayerSprintDisabled;
		bool bDontAllowWeaponChange;
		bool bForceInteriorLighting;
		char _pad1;
		unsigned short nPadDownPressedInMilliseconds;
		unsigned short nPadUpPressedInMilliseconds;
		unsigned char nWetness;
		bool bPlayersGangActive;
		unsigned char nWaterCoverPerc;
		char _pad2;
		float fWaterHeight;
		unsigned int nFireHSMissilePressedTime;
		CEntity *LastHSMissileTarget;
		unsigned int nModelIndexOfLastBuildingShot;
		unsigned int nLastHSMissileLOSTime : 31;
		unsigned int bLastHSMissileLOS : 1;
		CPed *pCurrentProstitutePed;
		CPed *pLastProstituteShagged;
	};
]]

shared.validate_size('CPlayerData', 0xAC)
