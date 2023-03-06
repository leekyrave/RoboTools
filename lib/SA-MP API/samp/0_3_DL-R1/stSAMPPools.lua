--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stPlayerPool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stVehiclePool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stPickupPool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stTextdrawPool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stTextLabelPool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stGangzonePool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stObjectPool'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stActorPool'

sys.ffi.cdef[[
	struct stSAMPPools {
		void                    	*pMenu;
		struct stActorPool				*pActor;
		struct stPlayerPool				*pPlayer;
		struct stVehiclePool			*pVehicle;
		struct stPickupPool				*pPickup;
		struct stObjectPool				*pObject;
		struct stGangzonePool			*pGangzone;
		struct stTextLabelPool		*pText3D;
		struct stTextdrawPool			*pTextdraw;
	}__attribute__ ((packed));
]]
