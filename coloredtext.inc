#if defined _textcolor_included
  #endinput
#endif
#define _textcolor_included

#include <a_samp>

new color[MAX_PLAYERS];

stock SendColoredTextToAll(playerid, COLOR, string[], string2[])
{
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
	
	new pformat[MAX_PLAYER_NAME];
	format(pformat,sizeof(pformat),"%s",string);
	color[playerid] = GetPlayerColor(playerid);

	SetPlayerName(playerid, pformat);
	SetPlayerColor(playerid, COLOR);

	SendPlayerMessageToAll(playerid, string2);
	printf("%s: %s", pformat, string2);

	SetPlayerName(playerid, PlayerName);
	SetPlayerColor(playerid, color[playerid]);	
	return 1;
}
/*
native SendColoredTextToAll(playerid, COLOR, string[], string2[]);
*/