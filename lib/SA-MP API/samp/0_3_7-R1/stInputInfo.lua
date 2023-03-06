--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stInputBox {
		void	*pUnknown;
		unsigned char	bIsChatboxOpen;
		unsigned char	bIsMouseInChatbox;
		unsigned char	bMouseClick_related;
		unsigned char	unk;
		unsigned int	dwPosChatInput[2];
		unsigned char	unk2[263];
		int		iCursorPosition;
		unsigned char	unk3;
		int		iMarkedText_startPos;
		unsigned char	unk4[20];
		int		iMouseLeftButton;
	}__attribute__((packed));

	typedef void(__cdecl *CMDPROC)(char *);

	struct stInputInfo {
		void				*pD3DDevice;
		void				*pDXUTDialog;
		stInputBox			*pDXUTEditBox;
		CMDPROC				pCMDs[144];
		char				szCMDNames[144][33];
		int					iCMDCount;
		int					iInputEnabled;
		char				szInputBuffer[129];
		char				szRecallBufffer[10][129];
		char				szCurrentBuffer[129];
		int					iCurrentRecall;
		int					iTotalRecalls;
		CMDPROC				pszDefaultCMD;
	}__attribute__((packed));
]]
