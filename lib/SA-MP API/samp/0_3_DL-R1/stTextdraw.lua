--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stTextdraw {
		char		szText[800 + 1];
		char		szString[1600 + 2];
		float		fLetterWidth;
		float		fLetterHeight;
		unsigned int	dwLetterColor;
		unsigned char		byte_unk;
		unsigned char		byteCenter;
		unsigned char		byteBox;
		float		fBoxSizeX;
		float		fBoxSizeY;
		unsigned int	dwBoxColor;
		unsigned char		byteProportional;
		unsigned int	dwShadowColor;
		unsigned char		byteShadowSize;
		unsigned char		byteOutline;
		unsigned char		byteLeft;
		unsigned char		byteRight;
		int			iStyle;
		float		fX;
		float		fY;
		unsigned char		unk[8];
		unsigned int	dword99B;
		unsigned int	dword99F;
		unsigned int	index;
		unsigned char		byte9A7;
		unsigned short	sModel;
		float		fRot[3];
		float		fZoom;
		unsigned short	sColor[2];
		unsigned char		f9BE;
		unsigned char		byte9BF;
		unsigned char		byte9C0;
		unsigned int	dword9C1;
		unsigned int	dword9C5;
		unsigned int	dword9C9;
		unsigned int	dword9CD;
		unsigned char		byte9D1;
		unsigned int	dword9D2;
	}__attribute__ ((packed));
]]
