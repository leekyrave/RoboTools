--[[
	Project: unnamed multihack

	Author: LUCHARE


	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local module = {}

module.DialogStyle = {
	MsgBox = 0,
	Input = 1,
	List = 2,
	Password = 3,
	Tablist = 4,
	TablistHeaders = 5
};

module.Limits = {
	MaxActors = 1000,
	MaxPlayers = 1004,
	MaxVehicles = 2000,
	MaxPickups = 4096,
	MaxObjects = 2100,
	MaxGangzones = 1024,
	Max3DTexts = 2048,
	MaxTextdraws = 2048,
	MaxPlayerTextdraws = 256,
	MaxClientCmds = 144,
	MaxMenus = 128,
	MaxPlayerName = 24,
	NicknameLength = 20,
	MaxMapicons = 100
};

module.MessageType = {
	None = 0,
	Chat = 2,
	Info = 4,
	Debug = 8
};

module.ChatDisplayMode = {
	Off = 0,
	Light = 1,
	Full = 2
};

module.GameState = {
	WaitConnect = 9,
	Connecting = 13,
	AwaitJoin = 15,
	Connected = 14,
	Restarting = 18
};

module.PlayerState ={
	None = 0,
	Wasted = 17,
	Passenger = 18,
	Driver = 19,
	Wasted = 32,
	Spawned = 31
};

module.MarkersMode = {
	Off = 0,
	Global = 1,
	Streamed = 2
};

module.SpecialAction = {
	None = 0,
	Duck = 1,
	UseJetpack = 2,
	EnterVehicle = 3,
	ExitVehicle = 4,
	Dance1 = 5,
	Dance2 = 6,
	Dance3 = 7,
	Dance4 = 8,
	Handsup = 9,
	UseCellphone = 10,
	Sitting = 11,
	StopUseCellphone = 12,
	DrinkBeer = 20,
	SmokeCiggy = 21,
	DrinkWine = 22,
	DrinkSprunk = 23,
	Cuffed = 24,
	Carry = 25
};

return module
