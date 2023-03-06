--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('eCamMode')
shared.require('CVehicle')
shared.require('CPed')

shared.ffidef[[
	struct CCam {
		bool          bBelowMinDist;
		bool          bBehindPlayerDesired;
		bool          bCamLookingAtVector;
		bool          bCollisionChecksOn;
		bool          bFixingBeta;
		bool          bTheHeightFixerVehicleIsATrain;
		bool          bLookBehindCamWasInFront;
		bool          bLookingBehind;
		bool          bLookingLeft;
		bool          bLookingRight;
		bool          bResetStatics;
		bool          bRotating;
		eCamMode      nMode;
		unsigned int  nFinishTime;
		unsigned int  nDoCollisionChecksOnFrameNum;
		unsigned int  nDoCollisionCheckEveryNumOfFrames;
		unsigned int  nFrameNumWereAt;
		unsigned int  nRunningVectorArrayPos;
		unsigned int  nRunningVectorCounter;
		unsigned int  nDirectionWasLooking;
		float         fMaxRoleAngle;
		float         fRoll;
		float         fRollSpeed;
		float         fSyphonModeTargetZOffSet;
		float         fAmountFractionObscured;
		float         fAlphaSpeedOverOneFrame;
		float         fBetaSpeedOverOneFrame;
		float         fBufferedTargetBeta;
		float         fBufferedTargetOrientation;
		float         fBufferedTargetOrientationSpeed;
		float         fCamBufferedHeight;
		float         fCamBufferedHeightSpeed;
		float         fCloseInPedHeightOffset;
		float         fCloseInPedHeightOffsetSpeed;
		float         fCloseInCarHeightOffset;
		float         fCloseInCarHeightOffsetSpeed;
		float         fDimensionOfHighestNearCar;
		float         fDistanceBeforeChanges;
		float         fFovSpeedOverOneFrame;
		float         fMinDistAwayFromCamWhenInterPolating;
		float         fPedBetweenCameraHeightOffset;
		float         fPlayerInFrontSyphonAngleOffSet;
		float         fRadiusForDead;
		float         fRealGroundDist;
		float         fTargetBeta;
		float         fTimeElapsedFloat;
		float         fTilt;
		float         fTiltSpeed;
		float         fTransitionBeta;
		float         fTrueBeta;
		float         fTrueAlpha;
		float         fInitialPlayerOrientation;
		float         fVerticalAngle;
		float         fAlphaSpeed;
		float         fFOV;
		float         fFOVSpeed;
		float         fHorizontalAngle;
		float         fBetaSpeed;
		float         fDistance;
		float         fDistanceSpeed;
		float         fCaMinDistance;
		float         fCaMaxDistance;
		float         fSpeedVar;
		float         fCameraHeightMultiplier;
		float         fTargetZoomGroundOne;
		float         fTargetZoomGroundTwo;
		float         fTargetZoomGroundThree;
		float         fTargetZoomOneZExtra;
		float         fTargetZoomTwoZExtra;
		float         fTargetZoomTwoInteriorZExtra;
		float         fTargetZoomThreeZExtra;
		float         fTargetZoomZCloseIn;
		float         fMinRealGroundDist;
		float         fTargetCloseInDist;
		float         fBeta_Targeting;
		float         fX_Targetting;
		float         fY_Targetting;
		CVehicle     *pCarWeAreFocussingOn;
		CVehicle     *pCarWeAreFocussingOnI;
		float         fCamBumpedHorz;
		float         fCamBumpedVert;
		unsigned int  nCamBumpedTime;
		RwV3D       vecSourceSpeedOverOneFrame;
		RwV3D       vecTargetSpeedOverOneFrame;
		RwV3D       vecUpOverOneFrame;
		RwV3D       vecTargetCoorsForFudgeInter;
		RwV3D       vecCamFixedModeVector;
		RwV3D       vecCamFixedModeSource;
		RwV3D       vecCamFixedModeUpOffSet;
		RwV3D       vecLastAboveWaterCamPosition;
		RwV3D       vecBufferedPlayerBodyOffset;
		RwV3D       vecFront;
		RwV3D       vecSource;
		RwV3D       vecSourceBeforeLookBehind;
		RwV3D       vecUp;
		RwV3D       avecPreviousVectors[2];
		RwV3D       avecTargetHistoryPos[4];
		unsigned int  anTargetHistoryTime[4];
		unsigned int  nCurrentHistoryPoints;
		CEntity      *pCamTargetEntity;
		float         fCameraDistance;
		float         fIdealAlpha;
		float         fPlayerVelocity;
		CVehicle     *pLastCarEntered;
		CPed         *pLastPedLookedAt;
		bool          bFirstPersonRunAboutActive;
	};
]]

shared.validate_size('CCam', 0x238)
