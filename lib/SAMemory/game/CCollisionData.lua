--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CColSphere')
shared.require('CColBox')
shared.require('CColLine')
shared.require('CColDisk')
shared.require('CompressedVector')
shared.require('CColTriangle')
shared.require('CColTrianglePlane')

shared.ffidef[[
	struct CCollisionData {
		unsigned short     nNumSpheres;
    unsigned short     nNumBoxes;
    unsigned short     nNumTriangles;
    unsigned char      nNumLines;
    struct {
        unsigned char   bUsesDisks : 1;
        unsigned char   bNotEmpty : 1;
        unsigned char b03 : 1;
        unsigned char   bHasFaceGroups : 1;
        unsigned char   bHasShadow : 1;
    }                  nFlags;
    CColSphere        *pSpheres;
    CColBox           *pBoxes;
    union {
        CColLine      *pLines;
        CColDisk      *pDisks;
    };
    CompressedVector  *pVertices;
    CColTriangle      *pTriangles;
    CColTrianglePlane *pTrianglePlanes;
    unsigned int       nNumShadowTriangles;
    unsigned int       nNumShadowVertices;
    CompressedVector  *pShadowVertices;
    CColTriangle      *pShadowTriangles;
	};
]]

shared.validate_size('CCollisionData', 0x30)
