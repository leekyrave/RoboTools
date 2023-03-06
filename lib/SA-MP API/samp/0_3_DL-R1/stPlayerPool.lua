--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stLocalPlayer'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stRemotePlayer'

sys.ffi.cdef[[
	struct stPlayerPool {
		unsigned short					sLocalPlayerID;
		void							*pVTBL_txtHandler;
		char							strLocalPlayerName[24];
		stLocalPlayer			*pLocalPlayer;
		unsigned int					ulMaxPlayerID;
		stRemotePlayer		*pRemotePlayer[1004];
		int								iIsListed[1004];
		int								bSavedCheckCollision[1004];
		int								iLocalPlayerPing;
		int								iLocalPlayerScore;
	} __attribute__ ((packed));
]]
