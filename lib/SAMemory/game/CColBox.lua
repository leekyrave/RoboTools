local samem  = require 'SAMemory.shared'

shared.require('RenderWare')

shared.ffidef[[
	struct CColBox {
		RwBBox Box;
		unsigned char nMaterial;
		unsigned char nFlags;
		unsigned char nLighting;
		unsigned char nLight;
	};
]]

shared.validate_size('CColBox', 0x1C)
