--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stFontRenderer {
		void		*pChatFont;
		void		*pLittleFont;
		void		*pChatShadowFont;
		void		*pLittleShadowFont;
		void		*pCarNumberFont;
		void 		*pTempSprite;
		void		*pD3DDevice;
		char		*pszTextBuffer;
	} __attribute__ ((packed));
]]
