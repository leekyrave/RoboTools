--[[
	Project: SA-MP API
	Author: LUCHARE
	Website: BlastHack.Net
	Copyright (c) 2018
]]

local mem = require( 'memory' )
local ffi = require( 'ffi' )

local module = {
	_version = 0.1, -- beta-0.1

	Version = nil,
	Handle 	= 0x0,
}

local offset = {
	stChatInfo  					= {['0_3_7-R1'] = 0x21A0E4, ['0_3_DL-R1'] = 0x2ACA10};
	stInputInfo 					= {['0_3_7-R1'] = 0x21A0E8, ['0_3_DL-R1'] = 0x2ACA14};
	stKillInfo  					= {['0_3_7-R1'] = 0x21A0EC, ['0_3_DL-R1'] = 0x2ACA18};
	stSAMP      					= {['0_3_7-R1'] = 0x21A0F8, ['0_3_DL-R1'] = 0x2ACA24};
	stScoreboardInfo  		= {['0_3_7-R1'] = 0x21A0B4, ['0_3_DL-R1'] = 0x2AC9DC};
	stDialogInfo      		= {['0_3_7-R1'] = 0x21A0B8, ['0_3_DL-R1'] = 0x2AC9E0};
	stGameInfo						= {['0_3_7-R1'] = 0x21A10C, ['0_3_DL-R1'] = 0x2ACA3C};

	fnAddChatCmd      		= {['0_3_7-R1'] = 0x065AD0, ['0_3_DL-R1'] = 0x0691B0};
	fnRequestSpawn				= {['0_3_7-R1'] = 0x003EC0, ['0_3_DL-R1'] = 0x003F40};
	fnSpawn								= {['0_3_7-R1'] = 0x003AD0, ['0_3_DL-R1'] = 0x003B20};
	fnAddChatMsg          = {['0_3_7-R1'] = 0x064010, ['0_3_DL-R1'] = 0x067650};
	fnSetInputMode        = {['0_3_7-R1'] = 0x09BD30, ['0_3_DL-R1'] = 0x0A0530};
	fnUnlockActorCam      = {['0_3_7-R1'] = 0x09BC10, ['0_3_DL-R1'] = 0x0A0410};
	fnUpdateScoreboard    = {['0_3_7-R1'] = 0x008A10, ['0_3_DL-R1'] = 0x008C00};
	fnTakeScreenshot      = {['0_3_7-R1'] = 0x070FC0, ['0_3_DL-R1'] = 0x075040};
	fnSay                 = {['0_3_7-R1'] = 0x0057F0, ['0_3_DL-R1'] = 0x005860};
	fnSendCmd							= {['0_3_7-R1'] = 0x065C60, ['0_3_DL-R1'] = 0x069340};
	fnSendInteriorChange  = {['0_3_7-R1'] = 0x005740, ['0_3_DL-R1'] = 0x0057C0};
	fnRequestClass        = {['0_3_7-R1'] = 0x0056A0, ['0_3_DL-R1'] = 0x005720};
	fnDisableScoreboard		= {['0_3_7-R1'] = 0x06A320, ['0_3_DL-R1'] = 0x06E410};
	fnSetSpecialAction    = {['0_3_7-R1'] = 0x0030C0, ['0_3_DL-R1'] = 0x003110};
};

local define = require( 'SA-MP API.samp.definitions' )

local function cast( struct )
	return ffi.cast( struct..'**', module.Handle + offset[struct][module.Version] )[0]
end

local function isSAMPAvailable()
	local result = true
	for k, v in pairs( offset ) do
		result = result and mem.getuint32( module.Handle + v[module.Version] ) ~= 0x0
	end
	return result
end

function module.GetIsAvailable()
	module.Handle = getModuleHandle( 'samp.dll' )
	if ( module.Handle == 0x0 ) then return false end
	local cmp =  mem.tohex( module.Handle + 0xBABE, 10, true )
	if ( cmp == 'F8036A004050518D4C24' ) then
		module.Version = '0_3_7-R1'
	elseif ( cmp == '528D44240C508D7E09E8' ) then
		module.Version = '0_3_DL-R1'
	else
		error( 'Unknown SA-MP Version.' )
	end
	return isSAMPAvailable()
end


function module.Get()
	if ( define ~= nil ) then define( module.Version ); define = nil end
	return {
		pChat 						 = cast( 'stChatInfo' ),
		pChatInput 			   = cast( 'stInputInfo' ),
		pKillList 				 = cast( 'stKillInfo' ),
		pBase 					 	 = cast( 'stSAMP' ),
		pScoreboard 			 = cast( 'stScoreboardInfo' ),
		pRecentDialog      = cast( 'stDialogInfo' ),
		pMisc              = cast( 'stGameInfo' ),

		-- see samp/%version%/enums.lua
		Enum = require( 'SA-MP API.samp.' .. module.Version .. '.enums' )
	}
end

module.string = ffi.string

function module.SendChat( text )
	if ( string.find( text, '^/' ) ) then
		module.SendCommand( text )
	else
		module.Say( text )
	end
end

function module.ToggleCursor( toggle )
	local mode = 0; if ( toggle ) then mode = 3 else module.UnlockActorCam() end
	module.SetInputMode( mode, not toggle )
end

local function SetCommand( idx, cmd, callback )
	local input = module.Get().pChatInput
	input.szCMDNames[idx] = cmd
	input.pCMDs[idx] = callback
	input.iCMDCount = input.iCMDCount + 1
end

function module.RegisterClientCommand( cmd, func, replaceOld )
	local input = module.Get().pChatInput
	local iCmdCount = input.iCMDCount

	if ( iCmdCount >= 144)  then error( 'The limit of client commands reached. Cannot register "' .. cmd .. '"' ); return end

	local callback = ffi.cast( 'CMDPROC', func )
	local cmdname = ffi.new( 'char[33]', cmd )

	for i = 0, 143 do
		if ( ffi.string( input.szCMDNames[i] ) == cmd ) then
			if ( input.pCMDs[i] ~= 0x0 --[[ nullptr ]] ) then
				if ( not replaceOld ) then
					error( 'Command "' .. cmd .. '" is already exists.' )
				end
				SetCommand( i, cmdname, callback ); return
			end
		end
	end

	SetCommand( iCmdCount, cmdname, callback )
end

function module.DeleteClientCommand( cmd )
	local reached = false
	local input = module.Get().pChatInput

	for i = 0, 143 do

		if ( ffi.string( input.szCMDNames[i] ) == cmd and not reached ) then
			input.iCMDCount = input.iCMDCount - 1
			reached = true
		end

		if ( reached ) then
			if ( i == 143 ) then return end
			input.szCMDNames[i] = input.szCMDNames[i + 1]
			input.pCMDs[i] = input.pCMDs[i + 1]
		end

	end
end

-- sa-mp vanilla functions
function module._RegisterClientCommand( cmd, func )
	local this = module.Get().pChatInput
	if ( this == 0x0 ) then return end
	local callback = ffi.cast( 'CMDPROC', func ) -- stInputInfo -> CMDPROC
	cmd = ffi.cast( 'char *', cmd )
	ffi.cast( 'void ( __thiscall * )( void *, char *, CMDPROC )', module.Handle + offset.fnAddChatCmd[module.Version] )( this, cmd, callback )
end

function module.TakeScreenshot()
	ffi.cast( 'void ( __cdecl * )( void )', module.Handle + offset.fnTakeScreenshot[module.Version] )( )
end

function module.RequestSpawn()
	local this = module.Get().pBase.pPools.pPlayer.pLocalPlayer
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void * )', module.Handle + offset.fnRequestSpawn[module.Version] )( this )
end

function module.Spawn()
	local this = module.Get().pBase.pPools.pPlayer.pLocalPlayer
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void * )', module.Handle + offset.fnSpawn[module.Version] )( this )
end

function module.SetInputMode( mode, disable_cursor )
	local this = module.Get().pMisc
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void *, unsigned int, bool )', module.Handle + offset.fnSetInputMode[module.Version] )( this, mode, disable_cursor )
end

function module.UnlockActorCam() -- use after cursor hiding
	local this = module.Get().pMisc
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void * )', module.Handle + offset.fnUnlockActorCam[module.Version] )( this )
end

function module.AddMessageToChat( msgType, msg, prefix, msgColor, prefixColor )
	local this = module.Get().pChat
	if ( this == 0x0 ) then return end
	msg = ffi.cast( 'const char *', msg )
	prefix = ffi.cast( 'const char *', prefix )
	ffi.cast( 'void ( __thiscall * )( void *, unsigned int, const char *, const char *, unsigned long, unsigned long )', module.Handle + offset.fnAddChatMsg[module.Version] )( this, msgType, msg, prefix, msgColor, prefixColor )
end

function module.UpdateScoreboardData()
	local this = module.Get().pBase
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void * )', module.Handle + offset.fnUpdateScoreboard[module.Version] )( this )
end

function module.Say( msg )
	local this = module.Get().pBase.pPools.pPlayer.pLocalPlayer
	if ( this == 0x0 ) then return end
	msg = ffi.cast( 'char *', msg )
	ffi.cast( 'void ( __thiscall * )( void *, char * )',  module.Handle + offset.fnSay[module.Version] )( this, msg )
end

function module.SendCommand( text )
	local this = module.Get().pChatInput
	if ( this == 0x0 ) then return end
	text = ffi.cast( 'char *', text )
	ffi.cast( 'void ( __thiscall * )( void *, char * )', module.Handle + offset.fnSendCmd[module.Version] )( this, text )
end

function module.SendInteriorChange( intId )
	local this = module.Get().pBase.pPools.pPlayer.pLocalPlayer
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void *, char )', module.Handle + offset.fnSendInteriorChange[module.Version] )( this, intId )
end

function module.RequestClass( classId )
	local this = module.Get().pBase.pPools.pPlayer.pLocalPlayer
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void *, int )', module.Handle + offset.fnRequestClass[module.Version] )( this, classId )
end

function module.DisableScoreboard( disable_cursor )
	local this = module.Get().pScoreboard
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void *, bool )', module.Handle + offset.fnDisableScoreboard[module.Version] )( this, disable_cursor )
end

function module.SetSpecialAction( actionId )
	local this = module.Get().pBase.pPools.pPlayer.pLocalPlayer
	if ( this == 0x0 ) then return end
	ffi.cast( 'void ( __thiscall * )( void *, char )', module.Handle + offset.fnSetSpecialAction[module.Version] )( this, actionId )
end

return module
