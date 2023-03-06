--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_7-R1.stLocalPlayer'
sys.safely_include 'SA-MP API.samp.0_3_7-R1.stRemotePlayer'

sys.ffi.cdef[[
	struct stPlayerPool {
		unsigned int					ulMaxPlayerID;
		unsigned short					sLocalPlayerID;
		void					 		*pVTBL_txtHandler;
		char							strLocalPlayerName[24];
		stLocalPlayer			*pLocalPlayer;
		int								iLocalPlayerPing;
		int								iLocalPlayerScore;
		stRemotePlayer		*pRemotePlayer[1004];
		int								iIsListed[1004];
		unsigned int			dwPlayerIP[1004];
	} __attribute__ ((packed));
]]
