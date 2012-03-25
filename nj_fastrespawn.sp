/**
* vim: set ts=4 
* Author: withgod <noname@withgod.jp>
* GPL 2.0
* 
**/
#pragma semicolon 1

#include <sourcemod>
#include <tf2>

#define PLUGIN_VERSION "0.0.1"

new Handle:g_njFastRespawnEnable;

public Plugin:myinfo = 
{
	name = "nj_fastrespawn",
	author = "withgod",
	description = "fast respawn",
	version = PLUGIN_VERSION,
	url = "http://github.com/withgod/sm-nj_fastrespawn"
};

public OnPluginStart()
{
	g_njFastRespawnEnable = CreateConVar("nj_fastrespawn", "1", "fast respawn Enable/Disable (0 = disabled | 1 = enabled)", 0, true, 0.0, true, 1.0);
	
	CreateConVar("nj_fastrespawn_version", PLUGIN_VERSION, "nj fastrespawn Version", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	
	HookEvent("player_death", OnPlayerDead, EventHookMode_Pre);
}

public Action:OnPlayerDead(Handle:event, const String:name[], bool:dontBroadcast)
{
	if (GetConVarBool(g_njFastRespawnEnable))
	{
		new client  = GetClientOfUserId(GetEventInt(event, "userid"));
		CreateTimer(0.1, timerRespawn, client, 0);//fast respawn hack
	}
	return Plugin_Continue;
}

public Action:timerRespawn(Handle:timer, any:client)
{
    TF2_RespawnPlayer(client);
    return Plugin_Stop;
}

