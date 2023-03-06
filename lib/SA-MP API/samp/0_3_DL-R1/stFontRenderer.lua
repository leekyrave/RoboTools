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
		void	*m_pChatFont;
		void	*m_pLittleFont;
		void	*m_pChatShadowFont;
		void	*m_pLittleShadowFont;
		void	*m_pCarNumberFont;
		void  *m_pTempSprite;
		void	*m_pD3DDevice;
		char	*m_pszTextBuffer;
	}__attribute__ ((packed));
]]
