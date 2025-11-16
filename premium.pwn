#include <DOF2>
#include <O-Files>
new forma[256];

CMD:dajvip(playerid,params[])
{
	new userid, Days, Hours, timeVip, Msg[128];
	if (sscanf(params, "ddd", userid, Days, Hours)) return SendClientMessage(playerid, 0xFF0000AA, "Uzyj: /dajvip [ID gracza] [Dni] [Godziny]"),1;
	if (IsPlayerConnected(userid))
	{
	format(forma,sizeof forma,"Premium/%s.ini",PlayerName(userid));
	DOF_CreateFile(forma);
	timeVip = (Days * 86400) + (Hours * 3600) + gettime();
	DOF_SetInt(forma,"VipCzas",timeVip);
	format(Msg, 128, "Dosta³eœ Konto Premium na %i Dni i %i Godzin !", Days, Hours);
	SendClientMessage(userid, 0xFF0000AA, Msg);
	DOF_SetInt(forma,"Vip",1);
	DOF_SaveFile();
	}
	return 1;
}
stock PokazCzas(playerid)
{
	new CzasPrem, Days, Hours, Minutes;
	format(forma,sizeof forma,"Premium/%s.ini",PlayerName(playerid));
	CzasPrem = DOF_GetInt(forma,"VipCzas") - gettime();
	if (CzasPrem >= 86400)
	{
		Days = CzasPrem / 86400;
		CzasPrem = CzasPrem - (Days * 86400);
	}
	if (CzasPrem >= 3600)
	{
		Hours = CzasPrem / 3600;
		CzasPrem = CzasPrem - (Hours * 3600);
	}
	if (CzasPrem >= 60)
	{
		Minutes = CzasPrem / 60;
		CzasPrem = CzasPrem - (Minutes * 60);
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	UnderscoreToSpace(sendername);
    new ff[128];
	format(ff,sizeof ff,"Zalogowa³eœ siê jako %s (ID %d, UID %d) Posiadasz konto premium aktywne przez: %i Dni, %i Godzin, %i Minut.", sendername, playerid, PlayerInfo[playerid][UID], Days, Hours, Minutes);
	SendClientMessage(playerid,0xFFB931FF,ff);
}
stock IsVip(playerid)
{
	format(forma,sizeof forma,"Premium/%s.ini",PlayerName(playerid));
	if(DOF_FileExists(forma) && DOF_GetInt(forma,"Vip") == 1) return 1;
	return 0;
}
