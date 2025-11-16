AntiDeAMX();
stock UsunPolskieZnaki(text[])
{
	ForeachEx(i, strlen(text))
	{
	    if(text[i] == 'ê') text[i] = 'e';
	    if(text[i] == 'ó') text[i] = 'o';
	    if(text[i] == '¹') text[i] = 'a';
	    if(text[i] == 'œ') text[i] = 's';
	    if(text[i] == '³') text[i] = 'l';
	    if(text[i] == '¿') text[i] = 'z';
	    if(text[i] == 'Ÿ') text[i] = 'z';
	    if(text[i] == 'æ') text[i] = 'c';
	    if(text[i] == 'ñ') text[i] = 'n';
	}
}
stock NadajKare(idgraczad,idgraczan, typ, powod[], dni)
{
	if(WlaczNadajKare[idgraczad] == 0)
	{
		WlaczNadajKare[idgraczad] = 1;
		new nick[256], typs[256],typss[256], str[512], dnis[50];
		strdel(nick, 0, 256);
		strdel(typs, 0, 256);
		strdel(typss, 0, 256);
		strdel(str, 0, 512);
		strdel(dnis, 0, 50);
		if(!IsPlayerConnected(idgraczad))
		{
			return 1;
		}
		if(typ != 0 && typ != 1 && typ != 3 && typ != 2 && typ != 9)
		{
			if(Klatwa(idgraczad))
			{
				typ = 11;
				dni = 7;
			}
		}
		if(idgraczan == -1)
		{
			format(nick, sizeof(nick), "Nadajacy:  System");
		}else{
			format(nick, sizeof(nick), "Nadajacy:  %s", ZmianaNicku(idgraczan));
		}
		if(dni == -1)
		{
			format(dnis, sizeof(dnis), "na zawsze");
		}
		else
		{
			format(dnis, sizeof(dnis), "dni: %d", dni);
		}
		if(typ == 0) format(typs, sizeof(typs), "~r~~h~Kick");
		else if(typ == 1) format(typs, sizeof(typs), "~r~~h~Warn");
		else if(typ == 2) format(typs, sizeof(typs), "~r~~h~Ban (%s)",dnis);
		else if(typ == 3) format(typs, sizeof(typs), "~r~~h~Admin Jail");
		else if(typ == 4) format(typs, sizeof(typs), "~r~~h~Blokada postaci (%s)", dnis);
		else if(typ == 5) format(typs, sizeof(typs), "~r~~h~Blokada biegania ~w~(%s)", dnis);
		else if(typ == 6) format(typs, sizeof(typs), "~r~~h~Blokada prowadzenia pojazdow ~w~(%s)", dnis);
		else if(typ == 7) format(typs, sizeof(typs), "~r~~h~Blokada czatu OOC ~w~(%s)", dnis);
		else if(typ == 8) format(typs, sizeof(typs), "~r~~h~Blokada broni ~w~(%s)", dnis);
		else if(typ == 9 && dni >= 0) format(typs, sizeof(typs), "~r~~h~GameScore: +%s", dni);
		else if(typ == 10) format(typs, sizeof(typs), "~r~~h~Klatwa ~w~(%s)", dnis);
		else if(typ == 11) format(typs, sizeof(typs), "~r~~h~Ban w wyniku klatwy ~w~(%s)", dnis);
		else if(typ == 12&& dni <= 0) format(typs, sizeof(typs), "~r~~h~GameScore: -%s", dni);
		//
		if(typ == 0) format(typss, sizeof(typss), "Kick");
		else if(typ == 1) format(typss, sizeof(typss), "Warn");
		else if(typ == 2) format(typss, sizeof(typss), "Ban (%s)",dnis);
		else if(typ == 3) format(typss, sizeof(typss), "Admin Jail (%d)", dni);
		else if(typ == 4) format(typss, sizeof(typss), "Blokada postaci (%s)", dnis);
		else if(typ == 5) format(typss, sizeof(typss), "Blokada biegania (%s)", dnis);
		else if(typ == 6) format(typss, sizeof(typss), "Blokada prowadzenia pojazdow (%s)", dnis);
		else if(typ == 7) format(typss, sizeof(typss), "Blokada czatu OOC (%s)", dnis);
		else if(typ == 8) format(typss, sizeof(typss), "Blokada broni (%s)", dnis);
		else if(typ == 9 && dni >= 0) format(typss, sizeof(typss), "GameScore: +%s", dni);
		else if(typ == 10) format(typss, sizeof(typss), "Klatwa (%s)", dnis);
		else if(typ == 11) format(typss, sizeof(typss), "Ban w wyniku klatwy (%s)", dnis);
		else if(typ == 12&& dni <= 0) format(typss, sizeof(typss), "GameScore: -%s", dni);
		//
		new notka[256],notkaa[124];
		strdel(notka, 0, 256);
		strdel(notkaa, 0, 124);
		if(idgraczan == -1)
		{
		format(notkaa, sizeof(notkaa), "Systemu");
		}else{
		format(notkaa, sizeof(notkaa), "%s", ZmianaNicku(idgraczan));
		}
		format(notka, sizeof(notka), "{CC0000}Otrzymujesz karê (%s) od %s. Powód: %s", typss, notkaa, powod);
		SendClientMessage(idgraczad, 0xFFb00000, notka);
		format(str, sizeof(str), "~r~~h~%s~n~Gracz:  %s~n~%s~n~~y~~h~%s", typs, ZmianaNicku(idgraczad), nick, powod);
		TextDrawSetString(Textdrawodkar, str);
		TextDrawShowForAll(Textdrawodkar);
		Xkara = 5;
		new lipa;
		if(dni == -1)
		{
			lipa = -1;
		}
		else
		{
			lipa = (gettime()-CZAS_LETNI)+(86400*dni);
		}
		if(idgraczan == -1)
		{
			if(typ == 0 ||typ == 1||typ== 3||typ == 9||typ == 10||typ == 16)
			{
				DodajDoBazyKare(DaneGracza[idgraczad][gGUID], DaneGracza[idgraczad][gUID], typ, powod, gettime()-CZAS_LETNI, lipa, "Nie", -1);
			}
			else
			{
				DodajDoBazyKare(DaneGracza[idgraczad][gGUID], DaneGracza[idgraczad][gUID], typ, powod, gettime()-CZAS_LETNI, lipa, "Tak", -1);
			}
		}else{
			if(typ == 0 ||typ == 1||typ== 3||typ == 9||typ == 10||typ == 16)
			{
				DodajDoBazyKare(DaneGracza[idgraczad][gGUID], DaneGracza[idgraczad][gUID], typ, powod, gettime()-CZAS_LETNI, lipa, "Nie", DaneGracza[idgraczan][gGUID]);
			}
			else
			{
				DodajDoBazyKare(DaneGracza[idgraczad][gGUID], DaneGracza[idgraczad][gUID], typ, powod, gettime()-CZAS_LETNI, lipa, "Tak", DaneGracza[idgraczan][gGUID]);
			}
		}
		/*if(typ == 3)
		{
			Teleportuj(idgraczad, 1174.3706,-1180.3267,87.0350);
			SetPlayerVirtualWorld(idgraczad, idgraczad + 500);
			SetPlayerInterior(idgraczad, 0);
			DaneGracza[idgraczad][gAJ] = dni;
			if(DaneGracza[idgraczad][gAJ] == 1) format(str, sizeof(str), "~w~Pozostala: ~r~minuta.");
			else format(str, sizeof(str), "~w~Pozostalo: ~r~%d min.", DaneGracza[idgraczad][gAJ]);
			GameTextForPlayer(idgraczad, str, 10000, 1);
			ZapiszGracza(idgraczad);
		}*/
		if(typ == 0) format(typs, sizeof(typs), "~r~~h~Kick");
		else if(typ == 1) format(typs, sizeof(typs), "~r~~h~Warn");
		else if(typ == 2) format(typs, sizeof(typs), "~r~~h~Ban (%s)",dnis);
		else if(typ == 3) format(typs, sizeof(typs), "~r~~h~Admin Jail");
		else if(typ == 4) format(typs, sizeof(typs), "~r~~h~Blokada postaci (%s)", dnis);
		else if(typ == 5) format(typs, sizeof(typs), "~r~~h~Blokada biegania ~w~(%s)", dnis);
		else if(typ == 6) format(typs, sizeof(typs), "~r~~h~Blokada prowadzenia pojazdow ~w~(%s)", dnis);
		else if(typ == 7) format(typs, sizeof(typs), "~r~~h~Blokada czatu OOC ~w~(%s)", dnis);
		else if(typ == 8) format(typs, sizeof(typs), "~r~~h~Blokada broni ~w~(%s)", dnis);
		else if(typ == 9 && dni >= 0) format(typs, sizeof(typs), "~r~~h~GameScore: +%s", dni);
		else if(typ == 10) format(typs, sizeof(typs), "~r~~h~Klatwa ~w~(%s)", dnis);
		else if(typ == 11) format(typs, sizeof(typs), "~r~~h~Ban w wyniku klatwy ~w~(%s)", dnis);
		else if(typ == 12&& dni <= 0) format(typs, sizeof(typs), "~r~~h~GameScore: -%s", dni);
		if(typ == 2 || typ == 11)
		{
			DaneGracza[idgraczad][gBAN] = lipa;
			ZapiszGraczaGlobal(idgraczad, 4);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 0 || typ == 4)
		{
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 0 || typ == 4)
		{
			DaneGracza[idgraczad][gBAN] = lipa;
			ZapiszGraczaGlobal(idgraczad, 4);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 5)
		{
			ZapiszGraczaGlobal(idgraczad, 3);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 6)
		{
			ZapiszGraczaGlobal(idgraczad, 5);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 7)
		{
			ZapiszGraczaGlobal(idgraczad, 2);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 8)
		{
			ZapiszGraczaGlobal(idgraczad, 6);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 9)
		{
			ZapiszGraczaGlobal(idgraczad,1);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		else if(typ == 10)
		{
			ZapiszGraczaGlobal(idgraczad,7);
			SetTimerEx("KickujGracza",2000,0,"d",idgraczad);
		}
		SetTimerEx("WlaczKary", 3000, 0, "i", idgraczad);
	}
	return 1;
}
stock DodajDoBazyKare(guid, uid, typ, powod[], data, datad, mozliwosc[], guidn)
{
	UsunPLZnaki(powod);
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_kary` SET `GUID` = '%d', `UID_POSTACI` = '%d', `TYP` = '%d', `POWOD` = '%s', `DATA` = '%d', `DATA_DEZAKTYWACJI` = '%d', `MOZLIWOSC_APELACJI` = '%s', `GUID_NADAJACEGO` = '%d'", guid, uid, typ, powod, data, datad, mozliwosc, guidn);
	mysql_query(zapyt);
}
stock GraczPremium(playerid)
{
	new pkt = DaneGracza[playerid][gPREMIUM];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock BlokadaOOC(playerid)//gotowe
{
	new pkt = DaneGracza[playerid][gOOC];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock BlokadaRUN(playerid)//gotowe
{
	new pkt = DaneGracza[playerid][gRUN];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock BlokadaBAN(playerid)//gotowe
{
	new pkt = DaneGracza[playerid][gBAN];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock BlokadaVEH(playerid)//gotowe
{
	new pkt = DaneGracza[playerid][gVEH];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock BlokadaGUN(playerid)//gotowe
{
	new pkt = DaneGracza[playerid][gGUN];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock Klatwa(playerid)//gotowe
{
	new pkt = DaneGracza[playerid][gKLATWA];
	if(pkt > gettime()) return true;
	else if(pkt == -1) return true;
	else return false;
}
stock anty(text[])
{
	if(strfind(text,"OOC",true)!=-1 ||
	strfind(text,"Blokade",true)!=-1||
	strfind(text,"IC",true)!=-1)
	return true;
	return false;
}
