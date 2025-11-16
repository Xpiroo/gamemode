AntiDeAMX();
enum nInfo
{
	nUID,
	nID,
	nWlascicielP,
	nWlascicielD,
	nAdres[20],
	Float:nPowieszchnia,
	nTyp,
	nLiczbaMebli,
	Float:nX,
	Float:nY,
	Float:nZ,
 	nVW,
	nINT,
    Float:nXW,
    Float:nYW,
    Float:nZW,
	nVWW,
	nINTW,
	nStworzoneObiekty,
	nPickup,
	nUkryty,
	nZamek,
	nPrzejazd,
	nIconaID,
	nRadio[100],
	nSzafa,
	nAudio,
	nOdpis,
	nLiczbaNapisow,
	Float:nMX[2],
    Float:nMY[2],
    Float:nMZ[2],
    Float:na,
    Float:naw,
	nSwiatlo,
	nMapa,
	nElektryka[500],
	nBezpiecznik,
	nToken[256],
	nHotel,
	nObiekty[2048],
	nOplata
}
new NieruchomoscInfo[MAX_NIERUCHOMOSCI][nInfo];
forward WyjscieZBudynku(playerid, drzwiid, vehicle, vw);
public WyjscieZBudynku(playerid, drzwiid, vehicle, vw)
{
	if(vehicle != 0)
	{
		TextDrawHideForPlayer(playerid, Light);
		SetPlayerVirtualWorld(playerid, NieruchomoscInfo[drzwiid][nVW]);
		SetVehicleVirtualWorld(vehicle, NieruchomoscInfo[drzwiid][nVW]);
		SetVehiclePos(vehicle, NieruchomoscInfo[drzwiid][nX], NieruchomoscInfo[drzwiid][nY], NieruchomoscInfo[drzwiid][nZ]);
		SetVehicleZAngle(vehicle, NieruchomoscInfo[drzwiid][na]);
		SetPlayerInterior(playerid, NieruchomoscInfo[drzwiid][nINT]);
		LinkVehicleToInterior(vehicle, NieruchomoscInfo[drzwiid][nINT]);
		ForeachEx(x, IloscGraczy)
		{
		    if(GetPlayerVehicleID(KtoJestOnline[x]) == GetPlayerVehicleID(playerid) && !GraczPrzetrzymywany(KtoJestOnline[x]))
		    {
				SetPlayerVirtualWorld(KtoJestOnline[x], NieruchomoscInfo[drzwiid][nVW]);
				SetPlayerInterior(KtoJestOnline[x], NieruchomoscInfo[drzwiid][nINT]);
				if(Discman[KtoJestOnline[x]] == 0)
				{
					if(IsPlayerInAnyVehicle(KtoJestOnline[x]))
					{
						new vehicleid=GetPlayerVehicleID(KtoJestOnline[x]);
						new uid = SprawdzCarUID(vehicleid);
						if(PojazdInfo[uid][pAudioStream] == 0) 
						{
							StopAudioStreamForPlayer(KtoJestOnline[x]);
						}
					}
					else
					{
						StopAudioStreamForPlayer(KtoJestOnline[x]);
					}
				}
			}
		}
		return 1;
	}
	else
	{
		if(GraczPrzetrzymywany(playerid))
		{
			GameTextForPlayer(playerid, "~r~Osoby przetrzymywane nie moga przechodzic przez drzwi.", 3000, 5);
			return 0;
		}
		OstatnieDrzwi[playerid] = drzwiid;
		SetPlayerInterior(playerid, NieruchomoscInfo[drzwiid][nINT]);
		Teleportuj(playerid, NieruchomoscInfo[drzwiid][nX], NieruchomoscInfo[drzwiid][nY], NieruchomoscInfo[drzwiid][nZ]);
		SetPlayerFacingAngle(playerid, NieruchomoscInfo[drzwiid][na]);
		SetPlayerWeather(playerid, 2);
		SetPlayerVirtualWorld(playerid, vw);
		TextDrawHideForPlayer(playerid, Light);
		//StopAudioStreamForPlayer(playerid);
		if(Discman[playerid] == 0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid=GetPlayerVehicleID(playerid);
				new uid = SprawdzCarUID(vehicleid);
				if(PojazdInfo[uid][pAudioStream] == 0) 
				{
					StopAudioStreamForPlayer(playerid);
				}
			}
			else
			{
				StopAudioStreamForPlayer(playerid);
			}
		}
		Frezuj(playerid, 0);
		SetTimerEx("Frez", 3000, 0, "d", playerid);
	}
	return 1;
}
forward WejscieDoBudynku(playerid, drzwiid, vehicle, vw);
public WejscieDoBudynku(playerid, drzwiid, vehicle, vw)
{
	if(Rolki[playerid] != 0)
	{
		GameTextForPlayer(playerid, "~r~Nie mozesz z rolkami wchodzic do budynkow.", 3000, 5);
		return 1;
	}
	if(NieruchomoscInfo[drzwiid][nOplata] < gettime() && NieruchomoscInfo[drzwiid][nOplata] != -1)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten budynek nie jest {88b711}op³acony{DEDEDE} udaj siê do urzêdu aby op³aciæ czynsz.", "Zamknij", "");
		return 1;
	}
	if(vehicle != 0)
	{
	    OstatnieDrzwi[playerid] = drzwiid;
	    if(NieruchomoscInfo[drzwiid][nSwiatlo] == 1)
		{
			TextDrawShowForPlayer(playerid, Light);
		}
		SetPlayerVirtualWorld(playerid, NieruchomoscInfo[drzwiid][nVWW]);
		SetVehicleVirtualWorld(vehicle, NieruchomoscInfo[drzwiid][nVWW]);
		SetVehiclePos(vehicle, NieruchomoscInfo[drzwiid][nXW], NieruchomoscInfo[drzwiid][nYW], NieruchomoscInfo[drzwiid][nZW]);
		SetVehicleZAngle(vehicle, NieruchomoscInfo[drzwiid][naw]);
		SetPlayerInterior(playerid, NieruchomoscInfo[drzwiid][nINTW]);
		LinkVehicleToInterior(vehicle, NieruchomoscInfo[drzwiid][nINTW]);
		SetVehicleVelocity(vehicle, 0.0, 0.0, 0.1);
		ForeachEx(x, IloscGraczy)
		{
		    if(GetPlayerVehicleID(KtoJestOnline[x]) == GetPlayerVehicleID(playerid) && !GraczPrzetrzymywany(KtoJestOnline[x]))
		    {
				SetPlayerVirtualWorld(KtoJestOnline[x], NieruchomoscInfo[drzwiid][nVWW]);
				SetPlayerInterior(KtoJestOnline[x], NieruchomoscInfo[drzwiid][nINTW]);
				if(NieruchomoscInfo[drzwiid][nAudio] == 1)
				{
					if(Discman[KtoJestOnline[x]] == 0)
					{
						if(IsPlayerInAnyVehicle(KtoJestOnline[x]))
						{
							new vehicleid=GetPlayerVehicleID(KtoJestOnline[x]);
							new uid = SprawdzCarUID(vehicleid);
							if(PojazdInfo[uid][pAudioStream] == 0) 
							{
								if(GetPVarInt(KtoJestOnline[x],"spawn"))
								{
									DeletePVar(KtoJestOnline[x],"spawn");
								}
								StopAudioStreamForPlayer(KtoJestOnline[x]);
								PlayAudioStreamForPlayer(KtoJestOnline[x], NieruchomoscInfo[drzwiid][nRadio], 0, 0, 0, 14.0, 0);
							}
						}
						else
						{
							if(GetPVarInt(KtoJestOnline[x],"spawn"))
							{
								DeletePVar(KtoJestOnline[x],"spawn");
							}
							StopAudioStreamForPlayer(KtoJestOnline[x]);
							PlayAudioStreamForPlayer(KtoJestOnline[x], NieruchomoscInfo[drzwiid][nRadio], 0, 0, 0, 14.0, 0);
						}
					}
				}
			}
		}
	    return 1;
	}
	else
	{
		if(GraczPrzetrzymywany(playerid))
		{
			return 0;
		}
	    OstatnieDrzwi[playerid] = drzwiid;
	    if(NieruchomoscInfo[drzwiid][nSwiatlo] == 1)
		{
			TextDrawShowForPlayer(playerid, Light);
		}
		new uid = NieruchomoscInfo[drzwiid][nWlascicielD];
		if(GrupaInfo[uid][gTyp] == DZIALALNOSC_BANK)
		{
		    CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "Wlasnie wszedles do:~n~ ~g~Los Santos Bank~n~ ~w~wpisz ''~y~~h~/bank~w~'' aby zalozyc konto badz z niego skorzystac.");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		}
		if(GrupaInfo[uid][gTyp] == DZIALALNOSC_BINCO)
		{
		    CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "Wlasnie wszedles do:~n~ ~g~Sklepu z ubraniami~n~ ~w~wpisz ''~y~~h~/ubranie~w~'' aby kupiæ nowe ubranie.");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		}
		if(GrupaInfo[uid][gTyp] == DZIALALNOSC_247)
		{
		    CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "Wlasnie wszedles do:~n~ ~g~24/7~n~ ~w~wpisz ''~y~~h~/kup~w~'' aby cos kupic.");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		}
		if(GrupaInfo[uid][gTyp] == DZIALALNOSC_HOTEL)
		{
			new nazwadrzwis[254];
			format(nazwadrzwis, sizeof(nazwadrzwis), "Wlasnie wszedles do:~n~ ~g~Hotelu~n~ ~w~wpisz ''~y~~h~/pokoj~w~'' aby sie zameldowac.");
		    CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], nazwadrzwis);
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		}
		SetPlayerVirtualWorld(playerid, vw);
		SetPlayerInterior(playerid, NieruchomoscInfo[drzwiid][nINTW]);
		Teleportuj(playerid, NieruchomoscInfo[drzwiid][nXW], NieruchomoscInfo[drzwiid][nYW], NieruchomoscInfo[drzwiid][nZW]);
		SetPlayerWeather(playerid, 2);
		SetPlayerFacingAngle(playerid, NieruchomoscInfo[drzwiid][naw]);
		SetPlayerVirtualWorld(playerid, vw);
	}
	if(NieruchomoscInfo[drzwiid][nAudio] == 1)
	{
		if(Discman[playerid] == 0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid=GetPlayerVehicleID(playerid);
				new uid = SprawdzCarUID(vehicleid);
				if(PojazdInfo[uid][pAudioStream] == 0) 
				{
					if(GetPVarInt(playerid,"spawn"))
					{
						DeletePVar(playerid,"spawn");
					}
					StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid, NieruchomoscInfo[drzwiid][nRadio], 0, 0, 0, 14.0, 0);
				}
			}
			else
			{
				if(GetPVarInt(playerid,"spawn"))
				{
					DeletePVar(playerid,"spawn");
				}
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, NieruchomoscInfo[drzwiid][nRadio], 0, 0, 0, 14.0, 0);
			}
		}
	}
	Frezuj(playerid, 0);
	SetTimerEx("Frez", 3000, 0, "d", playerid);
	return 1;
}
public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	new nazwadrzwi[128];
	new uid = SprawdzDrzwiUID(pickupid);
	CzasWyswietlaniaTextuNaDrzwiach[playerid] = 2;
	if(NieruchomoscInfo[uid][nTyp] == 0 || NieruchomoscInfo[uid][nTyp] == 1 || NieruchomoscInfo[uid][nTyp] == 4)
	{
		if(NieruchomoscInfo[uid][nTyp] == 4)
		{
			format(nazwadrzwi, sizeof(nazwadrzwi), "%s~n~~n~~r~Uzyj przedmiotu badz~n~~n~~y~~h~wpisz /p ~n~[nazwa przedmiotu]", NieruchomoscInfo[uid][nAdres]);
		}
		else
		{
			if(NieruchomoscInfo[uid][nZamek] == 0)
			{
				format(nazwadrzwi, sizeof(nazwadrzwi), "%s~n~~n~~r~ZAMKNIETE~n~~n~~y~~h~LEWY ALT + ~k~~PED_SPRINT~", NieruchomoscInfo[uid][nAdres]);
			}
			else
			{
				format(nazwadrzwi, sizeof(nazwadrzwi), "%s~n~~n~~g~~h~OTWARTE~n~~n~~y~~h~LEWY ALT + ~k~~PED_SPRINT~", NieruchomoscInfo[uid][nAdres]);
			}
		}
 	}
	else if(NieruchomoscInfo[uid][nTyp] == 10)
	{
		format(nazwadrzwi, sizeof(nazwadrzwi), "%s~n~~n~~b~~h~~h~ZLOMOWISKO~n~~n~~y~~h~/zlomowisko", NieruchomoscInfo[uid][nAdres]);
	}
	else if(NieruchomoscInfo[uid][nTyp] == 11)
	{
		format(nazwadrzwi, sizeof(nazwadrzwi), "%s~n~~n~~b~~h~~h~Prace Dorywcza~n~~n~~y~~h~/praca", NieruchomoscInfo[uid][nAdres]);
	}
	else if(NieruchomoscInfo[uid][nTyp] == 20)
	{
		format(nazwadrzwi, sizeof(nazwadrzwi), "%s~n~~n~~b~~h~~h~%d$/doba~n~~n~~y~~h~/namiot", NieruchomoscInfo[uid][nAdres],NieruchomoscInfo[uid][nHotel]);
	}
 	else
 	{
 	    format(nazwadrzwi, sizeof(nazwadrzwi), "~n~~n~~b~~h~~h~HURTOWNIA~n~~n~~y~~h~");
 	}
	TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
	TextDrawSetString(TextNaDrzwi[playerid], nazwadrzwi);
	TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
	return 1;
}
CMD:drzwi(playerid, params[])
{
	//printf("U¿yta komenda drzwi");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new uid;
	strdel(tekst_global, 0, 2048);
	strdel(tekst_globals, 0, 2048);
	if(sscanf(params, "d", uid))
	{
		new vw = GetPlayerVirtualWorld(playerid);
		new id = -1;
		if(vw == 0)
		{
			for(new h = 0; h < sizeof(NieruchomoscInfo); h++)
			{
				if(NieruchomoscInfo[h][nUID] != 0)
				{
					if(Dystans(2.0, playerid, NieruchomoscInfo[h][nX], NieruchomoscInfo[h][nY], NieruchomoscInfo[h][nZ]) && NieruchomoscInfo[h][nVW] == GetPlayerVirtualWorld(playerid) || Dystans(3.0, playerid, NieruchomoscInfo[h][nXW], NieruchomoscInfo[h][nYW], NieruchomoscInfo[h][nZW]) && NieruchomoscInfo[h][nVWW] == GetPlayerVirtualWorld(playerid))
					{
						id = h;
					}
				}
			}
			if(id == -1)
			{
				id = 0;
			}
		}else{
			id = vw;
		}
		if(id == -1)
		{
		    GameTextForPlayer(playerid, "~r~~h~Obok ciebie nie znajduja sie zadne drzwi.", 3000, 5);
			return 1;
		}
		if(!ZarzadzanieBudynkiem(id, playerid))
		{
		    GameTextForPlayer(playerid, "~r~~h~Nie posiadasz uprawnien do tych drzwi.", 3000, 5);
		    return 0;
		}
		SetPVarInt(playerid, "uiddrzwi", id);
		format(tekst_global, sizeof(tekst_global), "{DEDEDE}Informacje Ogólne", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Poka¿ informacje", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup obiekt do budynku {DEDEDE}(500$)", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup napis do budynku {DEDEDE}(500$)", tekst_global);
		if(NieruchomoscInfo[id][nAudio] == -1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup system Audio do budynku {DEDEDE}(5000$)", tekst_global);
		}
		else if(NieruchomoscInfo[id][nAudio] == 0)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}W³ó¿ p³yte do systemu audio", tekst_global);
		}
		else if(NieruchomoscInfo[id][nAudio] == 1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Wy³¹cz p³ytê w stystemie audio", tekst_global);
		}
		if(NieruchomoscInfo[id][nSzafa] == -1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup szafe do budynku {DEDEDE}(4000$)", tekst_global);
		}
		else if(NieruchomoscInfo[id][nSzafa] == 0)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zajrzyj do szafy", tekst_global);
		}
		format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Zarz¹dzaj Budynkiem", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zmieñ wyœwietlan¹ nazwe budynku {DEDEDE}(100$)", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Edytuj wewnêtrzn¹ pozycje budynku", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}W{DEDEDE}(y){88b711}³¹cz przejazd pojazdami", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Przepisz budynek pod dzia³alnoœæ", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Sprzedaj budynek graczu", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Usuñ wszystkie obiekty w budynku", tekst_global);
		if(NieruchomoscInfo[id][nMapa] == 0)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Rozpocznij proces wczytywania obiektów", tekst_global);
		}
		else if(NieruchomoscInfo[id][nMapa] == 1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakoñcz proces wczytywania obiektów", tekst_global);
		}
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Usuñ ostatnio stworzony obiekt", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Umieœæ/Usuñ tabliczke na sprzeda¿", tekst_global);		
		if(NieruchomoscInfo[id][nTyp] == 0) 
		{
			format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Dodatkowe Opcje", tekst_global);
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Wynajmij mieszkanie", tekst_global);
	    }
		else
		{
			if(GrupaInfo[NieruchomoscInfo[id][nWlascicielD]][gTyp] == DZIALALNOSC_HOTEL || NieruchomoscInfo[id][nTyp] == 20)
			{
				format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Dodatkowe Opcje", tekst_global);
				format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Ustaw cene wynajmu pokoju", tekst_global);
			}
		}
		new rok, miesiac, dzien, godzina, minuta, sekunda;
		sekundytodata(NieruchomoscInfo[id][nOplata]-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
		format(tekst_globals, sizeof(tekst_globals), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}: (Op³ata do: %02d-%02d-%d, %02d:%02d)", dzien, miesiac, rok, godzina, minuta);
	    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE, DIALOG_STYLE_LIST, tekst_globals, tekst_global, "Wybierz", "Zamknij");
	}else{
		if(!ZarzadzanieBudynkiem(uid, playerid))
		{
		    GameTextForPlayer(playerid, "~r~~h~Nie posiadasz uprawnien do tych drzwi.", 3000, 5);
		    return 0;
		}
		SetPVarInt(playerid, "uiddrzwi", uid);
		format(tekst_global, sizeof(tekst_global), "{DEDEDE}Informacje Ogólne", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Poka¿ informacje", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup obiekt do budynku {DEDEDE}(500$)", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup napis do budynku {DEDEDE}(500$)", tekst_global);
		if(NieruchomoscInfo[uid][nAudio] == -1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup system Audio do budynku {DEDEDE}(5000$)", tekst_global);
		}
		else if(NieruchomoscInfo[uid][nAudio] == 0)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}W³ó¿ p³yte do systemu audio", tekst_global);
		}
		else if(NieruchomoscInfo[uid][nAudio] == 1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Wy³¹cz p³ytê w stystemie audio", tekst_global);
		}
		if(NieruchomoscInfo[uid][nSzafa] == -1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakup szafe do budynku {DEDEDE}(4000$)", tekst_global);
		}
		else if(NieruchomoscInfo[uid][nSzafa] == 0)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zajrzyj do szafy", tekst_global);
		}
		format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Zarz¹dzaj Budynkiem", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zmieñ wyœwietlan¹ nazwe budynku {DEDEDE}(100$)", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Edytuj wewnêtrzn¹ pozycje budynku", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}W{DEDEDE}(y){88b711}³¹cz przejazd pojazdami", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Przepisz budynek pod dzia³alnoœæ", tekst_global);
	    format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Sprzedaj budynek graczu", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Usuñ wszystkie obiekty w budynku", tekst_global);
		if(NieruchomoscInfo[uid][nMapa] == 0)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Rozpocznij proces wczytywania obiektów", tekst_global);
		}
		else if(NieruchomoscInfo[uid][nMapa] == 1)
		{
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Zakoñcz proces wczytywania obiektów", tekst_global);
		}
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Usuñ ostatnio stworzony obiekt", tekst_global);
		format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Umieœæ/Usuñ tabliczke na sprzeda¿", tekst_global);
		if(NieruchomoscInfo[uid][nTyp] == 0) 
		{
			format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Dodatkowe Opcje", tekst_global);
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Wynajmij mieszkanie", tekst_global);
	    }
		else
		{
			if(GrupaInfo[NieruchomoscInfo[uid][nWlascicielD]][gTyp] == DZIALALNOSC_HOTEL || NieruchomoscInfo[uid][nTyp] == 20)
			{
				format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Dodatkowe Opcje", tekst_global);
				format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}»  {88B711}Ustaw cene wynajmu pokoju", tekst_global);
			}
		}
		new rok, miesiac, dzien, godzina, minuta, sekunda;
		sekundytodata(NieruchomoscInfo[uid][nOplata]-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
		format(tekst_globals, sizeof(tekst_globals), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}: (Op³ata do: %02d-%02d-%d, %02d:%02d)", dzien, miesiac, rok, godzina, minuta);
	    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE, DIALOG_STYLE_LIST, tekst_globals, tekst_global, "Wybierz", "Zamknij");
	}
	return 1;
}
forward StworzDrzwi(playerid, ownerpostac, ownerdzialalnosc, adres[32], typ, pickup, Float:sx, Float:sy, Float:sz, Float:sxx, Float:syy, Float:szz, Float:m2);
public StworzDrzwi(playerid, ownerpostac, ownerdzialalnosc, adres[32], typ, pickup, Float:sx, Float:sy, Float:sz, Float:sxx, Float:syy, Float:szz, Float:m2)
{
    if(strlen(adres) >= 32) return 1;
	new Float:X, Float:Y, Float:Z, Int, Vw;
	GetPlayerPos(playerid, X, Y, Z);
	Int = GetPlayerInterior(playerid);
	Vw = GetPlayerVirtualWorld(playerid);
	new Float:angles;
	GetPlayerFacingAngle(playerid, angles);
    new itemid = GetFreeSQLUID("five_nieruchomosci", "ID");
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_nieruchomosci` (`ID`, `UID_POSTACI`, `ADRES`, `POWIERZCHNIA`, `TYP`, `X`, `Y`, `Z`, `VW`, `INT`, `XW`, `YW`, `ZW`, `VWW`, `INTW`, `STWORZONYCH_OBIEKTOW`, `PICKUP`, `UKRYTY`, `PRZEJAZD`, `URL`, `MX`, `MY`, `MZ`, `MXX`, `MYY`, `MZZ`, `A`, `AW`) VALUES ('%d', '%d', '%s', '%f', '%d', '%f', '%f', '%f', '%d', '%d', '%f', '%f', '%f', '%d', '%d', '%d', '%d', '%d', '%d', '%s', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f')",
	itemid, ownerpostac, adres, m2, typ, X, Y, Z, Vw, Int, 501.957794, -70.564796, 998.757812, itemid, 11, 0, pickup, 0, 0, "Brak plyty w systemie audio.", sx, sy, sz, sxx, syy, szz, angles, 0);
	mysql_check();
	mysql_query2(zapyt);
	format(zapyt2, sizeof(zapyt2), "INSERT INTO `five_elektryka` (`ID_NIERUCHOMOSCI`) VALUES ('%d')",
	itemid);
	mysql_check();
	mysql_query2(zapyt2);
	NieruchomoscInfo[itemid][naw] = 0;
	NieruchomoscInfo[itemid][na] = angles;
	NieruchomoscInfo[itemid][nXW] = sx;
    NieruchomoscInfo[itemid][nYW] = sy;
    NieruchomoscInfo[itemid][nZW] = sz;
	NieruchomoscInfo[itemid][nVWW] = itemid;
	format(NieruchomoscInfo[itemid][nAdres], 50, "%s", adres);
	NieruchomoscInfo[itemid][nUID] = itemid;
	NieruchomoscInfo[itemid][nWlascicielP] = ownerpostac;
	NieruchomoscInfo[itemid][nWlascicielD] = ownerdzialalnosc;
	NieruchomoscInfo[itemid][nPowieszchnia] = m2;
	NieruchomoscInfo[itemid][nTyp] = typ;
	NieruchomoscInfo[itemid][nLiczbaMebli] = 0;
	NieruchomoscInfo[itemid][nX] = X;
	NieruchomoscInfo[itemid][nY] = Y;
	NieruchomoscInfo[itemid][nZ] = Z;
	NieruchomoscInfo[itemid][nVW] = Vw;
	NieruchomoscInfo[itemid][nINT] = Int;
	NieruchomoscInfo[itemid][nStworzoneObiekty] = 0;
	NieruchomoscInfo[itemid][nPickup] = pickup;
	NieruchomoscInfo[itemid][nUkryty] = 0;
	NieruchomoscInfo[itemid][nZamek] = 0;
	NieruchomoscInfo[itemid][nPrzejazd] = 0;
	format(NieruchomoscInfo[itemid][nRadio], 100, "Brak plyty w systemie audio.");
	NieruchomoscInfo[itemid][nSzafa] = -1;
	NieruchomoscInfo[itemid][nAudio] = -1;
	NieruchomoscInfo[itemid][nMX][0] = sx;
	NieruchomoscInfo[itemid][nMY][0] = sy;
	NieruchomoscInfo[itemid][nMZ][0] = sz;
	NieruchomoscInfo[itemid][nMX][1] = sxx;
	NieruchomoscInfo[itemid][nMY][1] = syy;
	NieruchomoscInfo[itemid][nMZ][1] = szz;
	NieruchomoscInfo[itemid][nSwiatlo] = 0;
	NieruchomoscInfo[itemid][nMapa] = 0;
	if(NieruchomoscInfo[itemid][nVW] == 0)
	{
		if(NieruchomoscInfo[itemid][nWlascicielD] != 0)
		{
			new typa = GrupaInfo[NieruchomoscInfo[itemid][nWlascicielD]][gTyp];
			if(typa == 2 || typa == 11 || typa == 16)
			{
			
			}
			else
			{
				NieruchomoscInfo[itemid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[itemid][nX], NieruchomoscInfo[itemid][nY], NieruchomoscInfo[itemid][nZ], Ikonki[GrupaInfo[NieruchomoscInfo[itemid][nWlascicielD]][gTyp]][0], 0, NieruchomoscInfo[itemid][nVW]);
			}
		}
		else
		{
			if(NieruchomoscInfo[itemid][nTyp] == 0)
			{
				NieruchomoscInfo[itemid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[itemid][nX], NieruchomoscInfo[itemid][nY], NieruchomoscInfo[itemid][nZ], 31, 0, NieruchomoscInfo[itemid][nVW]);
			}
			else
			{
				NieruchomoscInfo[itemid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[itemid][nX], NieruchomoscInfo[itemid][nY], NieruchomoscInfo[itemid][nZ], 56, 0, NieruchomoscInfo[itemid][nVW]);
			}
		}
	}
	NieruchomoscInfo[itemid][nID] = CreateDynamicPickup(NieruchomoscInfo[itemid][nPickup], 1, NieruchomoscInfo[itemid][nX], NieruchomoscInfo[itemid][nY], NieruchomoscInfo[itemid][nZ], NieruchomoscInfo[itemid][nVW]);
	ZapiszNieruchomosc(itemid);
	mysql_free_result();
	return itemid;
}
forward SprawdzDrzwiUID(uid);
public SprawdzDrzwiUID(uid)
{
	for(new i = 1;i < MAX_NIERUCHOMOSCI; i++)
		if(NieruchomoscInfo[i][nID] == uid)
			return i;
	return 1;
}
forward ZaladujNieruchomosci();
public ZaladujNieruchomosci()
{
	new result[1024], i = 0;
    format(zapyt, sizeof(zapyt), "SELECT * FROM `five_nieruchomosci`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid, zero[248];
    	sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>ddds[20]fdds[50]ds[20]fffddfffdddddds[50]ddddffffffdffddd", NieruchomoscInfo[uid][nUID],
		    NieruchomoscInfo[uid][nWlascicielP],
		    NieruchomoscInfo[uid][nWlascicielD],
		    NieruchomoscInfo[uid][nAdres],
		    NieruchomoscInfo[uid][nPowieszchnia],
			NieruchomoscInfo[uid][nTyp],
			NieruchomoscInfo[uid][nOdpis],
			zero,
			NieruchomoscInfo[uid][nLiczbaMebli],
			zero,
			NieruchomoscInfo[uid][nX],
			NieruchomoscInfo[uid][nY],
			NieruchomoscInfo[uid][nZ],
			NieruchomoscInfo[uid][nVW],
		    NieruchomoscInfo[uid][nINT],
			NieruchomoscInfo[uid][nXW],
			NieruchomoscInfo[uid][nYW],
			NieruchomoscInfo[uid][nZW],
			NieruchomoscInfo[uid][nVWW],
		    NieruchomoscInfo[uid][nINTW],
			zero,
			NieruchomoscInfo[uid][nPickup],
		    NieruchomoscInfo[uid][nUkryty],
		    NieruchomoscInfo[uid][nPrzejazd],
			NieruchomoscInfo[uid][nRadio],
			NieruchomoscInfo[uid][nSzafa],
		    NieruchomoscInfo[uid][nAudio],
		    NieruchomoscInfo[uid][nZamek],
			NieruchomoscInfo[uid][nLiczbaNapisow],
			NieruchomoscInfo[uid][nMX][0],
			NieruchomoscInfo[uid][nMY][0],
			NieruchomoscInfo[uid][nMZ][0],
			NieruchomoscInfo[uid][nMX][1],
			NieruchomoscInfo[uid][nMY][1],
			NieruchomoscInfo[uid][nMZ][1],
			NieruchomoscInfo[uid][nSwiatlo],
			NieruchomoscInfo[uid][na],
			NieruchomoscInfo[uid][naw],
			NieruchomoscInfo[uid][nMapa],
			NieruchomoscInfo[uid][nHotel],
			NieruchomoscInfo[uid][nOplata]);
		if(NieruchomoscInfo[uid][nVW] != 0)
		{
			NieruchomoscInfo[uid][nOplata] = -1;
		}
		if(NieruchomoscInfo[uid][nUkryty] == 0)
		{
			NieruchomoscInfo[uid][nID] = CreateDynamicPickup(NieruchomoscInfo[uid][nPickup], 1, NieruchomoscInfo[uid][nX], NieruchomoscInfo[uid][nY], NieruchomoscInfo[uid][nZ],NieruchomoscInfo[uid][nVW]);
			if(NieruchomoscInfo[uid][nVW] == 0)
			{
				if(NieruchomoscInfo[uid][nWlascicielD] != 0)
				{
					new typ = GrupaInfo[NieruchomoscInfo[uid][nWlascicielD]][gTyp];
					if(typ == 2 || typ == 11 || typ == 16)
					{
					
					}
					else
					{
						NieruchomoscInfo[uid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uid][nX], NieruchomoscInfo[uid][nY], NieruchomoscInfo[uid][nZ], Ikonki[GrupaInfo[NieruchomoscInfo[uid][nWlascicielD]][gTyp]][0], 0, NieruchomoscInfo[uid][nVW]);
					}
				}
				else
				{
					if(NieruchomoscInfo[uid][nTyp] == 0)
					{
						NieruchomoscInfo[uid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uid][nX], NieruchomoscInfo[uid][nY], NieruchomoscInfo[uid][nZ], 31, 0, NieruchomoscInfo[uid][nVW]);
					}
					else
					{
						NieruchomoscInfo[uid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uid][nX], NieruchomoscInfo[uid][nY], NieruchomoscInfo[uid][nZ], 56, 0, NieruchomoscInfo[uid][nVW]);
					}
				}
			}
		}
		NieruchomoscInfo[uid][nMapa] = 0;
		i++;
	}
	mysql_free_result();
	//printf("Nieruchomosci       - %d", i);
}
stock DrzwiWBudynku(uid, Float:x, Float:y, Float:z)
{
	new highestx, highesty, lowestx, lowesty;
	new retarn = 1;
	if(NieruchomoscInfo[uid][nMX][0] > NieruchomoscInfo[uid][nMX][1])
	{
		highestx = 0;
		lowestx = 1;
	}
	else if(NieruchomoscInfo[uid][nMX][0] < NieruchomoscInfo[uid][nMX][1])
	{
		highestx = 1;
		lowestx = 0;
	}
	if(NieruchomoscInfo[uid][nMY][0] > NieruchomoscInfo[uid][nMY][1])
	{
		highesty = 0;
		lowesty = 1;
	}
	else if(NieruchomoscInfo[uid][nMY][0] < NieruchomoscInfo[uid][nMY][1])
	{
		highesty = 1;
		lowesty = 0;
	}
	if(NieruchomoscInfo[uid][nMX][highestx] > x && NieruchomoscInfo[uid][nMX][lowestx] < x)
	{
	    if(NieruchomoscInfo[uid][nMY][highesty] > y && NieruchomoscInfo[uid][nMY][lowesty] < y)
		{
		    if(z >= NieruchomoscInfo[uid][nMZ][0]-2 && z <= NieruchomoscInfo[uid][nMZ][1]+2)
			{
				retarn = 2;
			}
		}
 	}
	return retarn;
}
stock GraczWBudynku(playerid, uid)
{
	new highestx, highesty, lowestx, lowesty;
	new retarn = 1;
	if(NieruchomoscInfo[uid][nMX][0] > NieruchomoscInfo[uid][nMX][1])
	{
		highestx = 0;
		lowestx = 1;
	}
	else if(NieruchomoscInfo[uid][nMX][0] < NieruchomoscInfo[uid][nMX][1])
	{
		highestx = 1;
		lowestx = 0;
	}
	if(NieruchomoscInfo[uid][nMY][0] > NieruchomoscInfo[uid][nMY][1])
	{
		highesty = 0;
		lowesty = 1;
	}
	else if(NieruchomoscInfo[uid][nMY][0] < NieruchomoscInfo[uid][nMY][1])
	{
		highesty = 1;
		lowesty = 0;
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(NieruchomoscInfo[uid][nMX][highestx] > x && NieruchomoscInfo[uid][nMX][lowestx] < x)
	{
	    if(NieruchomoscInfo[uid][nMY][highesty] > y && NieruchomoscInfo[uid][nMY][lowesty] < y)
		{
		    if(z >= NieruchomoscInfo[uid][nMZ][0]-2 && z <= NieruchomoscInfo[uid][nMZ][1]+2)
			{
				retarn = 2;
			}
		}
 	}
	return retarn;
}
forward ZapiszNieruchomosc(uid);
public ZapiszNieruchomosc(uid)
{
	strdel(zapyt, 0, 1024);
	format(zapyt, sizeof(zapyt), "UPDATE `five_nieruchomosci` SET `UID_POSTACI` = '%d', `UID_DZIALALNOSCI` = '%d', `ADRES` = '%s', `POWIERZCHNIA` = '%f', `TYP` = '%d', `LICZBA_MEBLI` = '%d', `X` = '%f', `Y` = '%f', `Z` = '%f', `VW` = '%d', `INT` = '%d', `XW` = '%f', `YW` = '%f', `ZW` = '%f', `VWW` = '%d', `INTW` = '%d', `STWORZONYCH_OBIEKTOW` = '%d', `PICKUP` = '%d', `UKRYTY` = '%d', `PRZEJAZD` = '%d', `URL` = '%s', `ZAMEK` = '%d', `LNAPISOW` = '%d' WHERE `ID` = '%d'",
	NieruchomoscInfo[uid][nWlascicielP],
	NieruchomoscInfo[uid][nWlascicielD],
	NieruchomoscInfo[uid][nAdres],
	NieruchomoscInfo[uid][nPowieszchnia],
	NieruchomoscInfo[uid][nTyp],
	NieruchomoscInfo[uid][nLiczbaMebli],
	NieruchomoscInfo[uid][nX],
	NieruchomoscInfo[uid][nY],
	NieruchomoscInfo[uid][nZ],
	NieruchomoscInfo[uid][nVW],
	NieruchomoscInfo[uid][nINT],
	NieruchomoscInfo[uid][nXW],
	NieruchomoscInfo[uid][nYW],
	NieruchomoscInfo[uid][nZW],
	NieruchomoscInfo[uid][nVWW],
	NieruchomoscInfo[uid][nINTW],
	NieruchomoscInfo[uid][nStworzoneObiekty],
	NieruchomoscInfo[uid][nPickup],
	NieruchomoscInfo[uid][nUkryty],
	NieruchomoscInfo[uid][nPrzejazd],
	NieruchomoscInfo[uid][nRadio],
	NieruchomoscInfo[uid][nZamek],
	NieruchomoscInfo[uid][nLiczbaNapisow],
	uid);
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();

	strdel(zapyt, 0, 1024);
	format(zapyt, sizeof(zapyt), "UPDATE `five_nieruchomosci` SET `ODPIS` = '%d', `MX` = '%f', `MY` = '%f', `MZ` = '%f', `MXX` = '%f', `MYY` = '%f', `MZZ` = '%f', `SWIATLO` = '%d', `A` = '%f', `AW` = '%f', `Mapa` = '%d', `OPLATA` = '%d' WHERE `ID` = '%d'",
	NieruchomoscInfo[uid][nOdpis],
	NieruchomoscInfo[uid][nMX][0],
	NieruchomoscInfo[uid][nMY][0],
	NieruchomoscInfo[uid][nMZ][0],
	NieruchomoscInfo[uid][nMX][1],
	NieruchomoscInfo[uid][nMY][1],
	NieruchomoscInfo[uid][nMZ][1],
	NieruchomoscInfo[uid][nSwiatlo],
	NieruchomoscInfo[uid][na],
	NieruchomoscInfo[uid][naw],
	NieruchomoscInfo[uid][nMapa],
	NieruchomoscInfo[uid][nOplata],
	uid);
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();
	return 1;
}
stock UaktualnijObiektyWBudynku(vw)
{
	new sql3[200];
	format(sql3, sizeof(sql3), "SELECT `LICZBA_MEBLI`, `STWORZONYCH_OBIEKTOW` FROM `five_nieruchomosci` WHERE `ID` = '%d'", vw);
	mysql_query(sql3);
	mysql_store_result();
	mysql_fetch_row(sql3);
	sscanf(sql3, "p<|>dd", NieruchomoscInfo[vw][nLiczbaMebli],NieruchomoscInfo[vw][nStworzoneObiekty]);
	return 1;
}
forward UsunNieruchomosc(uid);
public UsunNieruchomosc(uid)
{
    new sql[100];
	format( sql, sizeof( sql ), "DELETE FROM `five_nieruchomosci` WHERE `ID` = %d", uid );
	mysql_query( sql );
	DestroyDynamicMapIcon(NieruchomoscInfo[uid][nIconaID]);
	ForeachEx(id, NieruchomoscInfo[uid][nStworzoneObiekty])
	{
		UsunObiekt(NieruchomoscInfo[uid][nObiekty][id]);
	}
	DestroyDynamicPickup(NieruchomoscInfo[uid][nID]);
	NieruchomoscInfo[uid][nID] = 0;
	NieruchomoscInfo[uid][nWlascicielP] = 0;
	NieruchomoscInfo[uid][nWlascicielD] = 0;
	NieruchomoscInfo[uid][nAdres] = 0;
	NieruchomoscInfo[uid][nPowieszchnia] = 0;
	NieruchomoscInfo[uid][nTyp] = 0;
	NieruchomoscInfo[uid][nLiczbaMebli] = 0;
	NieruchomoscInfo[uid][nX] = 0;
	NieruchomoscInfo[uid][nY] = 0;
	NieruchomoscInfo[uid][nZ] = 0;
	NieruchomoscInfo[uid][nVW] = 0;
	NieruchomoscInfo[uid][nINT] = 0;
	NieruchomoscInfo[uid][nXW] = 0;
	NieruchomoscInfo[uid][nYW] = 0;
	NieruchomoscInfo[uid][nZW] = 0;
	NieruchomoscInfo[uid][nVWW] = 0;
	NieruchomoscInfo[uid][nINTW] = 0;
	NieruchomoscInfo[uid][nStworzoneObiekty] = 0;
	NieruchomoscInfo[uid][nPickup] = 0;
	NieruchomoscInfo[uid][nUkryty] = 0;
	NieruchomoscInfo[uid][nPrzejazd] = 0;
	NieruchomoscInfo[uid][nRadio] = 0;
	NieruchomoscInfo[uid][nSzafa] = 0;
	NieruchomoscInfo[uid][nAudio] = 0;
	NieruchomoscInfo[uid][nZamek] = 0;
	NieruchomoscInfo[uid][nLiczbaNapisow] = 0;
	NieruchomoscInfo[uid][nOdpis] = 0;
	NieruchomoscInfo[uid][nMX][0] = 0;
	NieruchomoscInfo[uid][nMY][0] = 0;
	NieruchomoscInfo[uid][nMZ][0] = 0;
	NieruchomoscInfo[uid][nMX][1] = 0;
	NieruchomoscInfo[uid][nMY][1] = 0;
	NieruchomoscInfo[uid][nMZ][1] = 0;
	NieruchomoscInfo[uid][nSwiatlo] = 0;
	NieruchomoscInfo[uid][na] = 0;
	NieruchomoscInfo[uid][naw] = 0;
	NieruchomoscInfo[uid][nMapa] = 0;
	return 1;
}