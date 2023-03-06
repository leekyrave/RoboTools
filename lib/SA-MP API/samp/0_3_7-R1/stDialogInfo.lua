--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stDialogInfo {
		void	*m_pD3DDevice;
		int	iTextPoxX;
		int	iTextPoxY;
		unsigned int	uiDialogSizeX;
		unsigned int	uiDialogSizeY;
		int	iBtnOffsetX;
		int	iBtnOffsetY;
		void	*pDialog;
		void	*pList;
		void	*pEditBox;
		int	iIsActive;
		int	iType;
		unsigned int	DialogID;
		char		*pText;
		unsigned int	uiTextWidth;
		unsigned int	uiTextHeight;
		char		szCaption[65];
		int		bServerside;
	}__attribute__ ((packed));
]]
