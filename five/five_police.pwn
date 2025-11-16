AntiDeAMX();
enum objBlokada
{
	bloSAMP,
	Float:bloPozX,
	Float:bloPozY,
	Float:bloPozZ,
	Float:bloRotX,
	Float:bloRotY,
	Float:bloRotZ,
	blovWorld,
	bloModel
}
new BlokadaInfo[MAX_BLOKAD][objBlokada];
enum objKolczatka
{
	kSAMP,
	Float:kPozX,
	Float:kPozY,
	Float:kPozZ,
	Float:kRotX,
	Float:kRotY,
	Float:kRotZ,
	kvWorld,
	kModel,
	kUzyta
}
new KolczatkaInfo[MAX_KOLCZATEK][objKolczatka];
enum gKartoteka
{
	kID,
	kUID,
	kUIDN,
	kNick[64],
	kNickN[64],
	kGUID,
	kGUIDN,
	kData[64],
	kGodzina[64],
	kPowod[124],
	kTyp
}
new KartotekaInfo[MAX_KARTOTEKA][gKartoteka];
forward UsunKartoteka(uid);
public UsunKartoteka(uid)
{
	format(zapyt, sizeof(zapyt), "DELETE FROM `five_kartoteka` WHERE `ID` = '%d'", uid);
	mysql_check();
	mysql_query2(zapyt);
	KartotekaInfo[uid][kID] = 0;
	KartotekaInfo[uid][kUID] = 0;
	KartotekaInfo[uid][kUIDN] = 0;
	KartotekaInfo[uid][kGUID] = 0;
	KartotekaInfo[uid][kGUIDN] = 0;
	KartotekaInfo[uid][kTyp] = 0;
	mysql_free_result();
	return 1;
}
new typ_wpisu_kartoteka[3][124] =
{
	{"Wpis"},
	{"Mandat"},
	{"Przetrzymanie"}
};
forward ZaladujKartoteki();
public ZaladujKartoteki()
{
	new sql[ 500 ], id = false;
	mysql_query( "SELECT * FROM `five_kartoteka`" );
	mysql_store_result( );
	while( mysql_fetch_row( sql ) )
	{
	    sscanf( sql, "p<|>i", id );
	    sscanf( sql, "p<|>ddddds[64]s[64]s[64]s[64]s[124]d",
	    KartotekaInfo[id ][kID],
	    KartotekaInfo[id][kUID],
	    KartotekaInfo[id][kUIDN],
		KartotekaInfo[id][kGUID],
		KartotekaInfo[id][kGUIDN],
		KartotekaInfo[id][kNick],
		KartotekaInfo[id][kNickN],
		KartotekaInfo[id][kData],
		KartotekaInfo[id][kGodzina],
		KartotekaInfo[id][kPowod],
		KartotekaInfo[id][kTyp]
	    );
	}
	mysql_free_result( );
	//printf("Kartoteki   - %d", id);
	return 1;
}

forward PrzyObiekcieBlo(playerid, model, wykonanie);
public PrzyObiekcieBlo(playerid, model, wykonanie)
{
	new find = 0, Float:radius = 0.2;
	for(new i = 0; i < wykonanie; i++)
	{
		ForeachEx(h, 20)
		{
			if(Dystans(radius, playerid, BlokadaInfo[h][bloPozX],BlokadaInfo[h][bloPozY],BlokadaInfo[h][bloPozZ]) && GetPlayerVirtualWorld(playerid) == BlokadaInfo[h][blovWorld])
			{
				find = h;
				if(BlokadaInfo[find][bloModel] == model){
				break;
				}
			}
		}
		radius+=0.5;
	}
	if(BlokadaInfo[find][bloModel] == model)
	{
	    return find;
	}
	else
	{
	    return 0;
	}
}
CMD:skuj(playerid,cmdtext[])
{
	//printf("U¿yta komenda skuj");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 26))
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	/*if(DaneGracza[playerid][gKajdankiS] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gKajdanki] != -1)
	{
		return 0;
	}*/
	new playerid2;
	if(sscanf(cmdtext, "i", playerid2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}skuæ{DEDEDE} gracza wpisz: {88b711}/skuj [id gracza]", "Zamknij", "");
		return 1;
	}
	if(!PlayerObokPlayera(playerid, playerid2, 3))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}skuæ{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
		return 1;
	}
	if(zalogowany[playerid2] == false)
    {
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}skuæ{DEDEDE} nie znajduje siê obok Ciebie.", "Zamknij", "");
        return 0;
    }
	if(playerid == playerid2) return 1;
	if(DaneGracza[playerid][gSznur] != -1)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego próbujesz {88b711}skuæ{DEDEDE} jest zwi¹zany!", "Zamknij", "");
		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid2) &&  GetPlayerState(playerid2) == PLAYER_STATE_DRIVER)
	{
		return 0;
	}
	if(DaneGracza[playerid2][gKajdanki] == -1)
	{
		if(DaneGracza[playerid2][gBW] != 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego próbujesz {88b711}skuæ{DEDEDE} jest nieprzytomny!", "Zamknij", "");
		new str[250];
	    DaneGracza[playerid2][gKajdanki] = playerid;
		DaneGracza[playerid][gKajdankiS] = 1;
		SetPlayerSpecialAction(playerid2,SPECIAL_ACTION_CUFFED);
		SetPlayerAttachedObject(playerid2, 1, 19418, 6,0.0,0.04,-0.01,0.0,0.0,90.0);
		if(IsPlayerInAnyVehicle(playerid2))
		{
		Frezuj(playerid2, 0);
		format(str, sizeof(str), "przykuwa %s do pojazdu.", ZmianaNicku(playerid2));
		}else{
		format(str, sizeof(str), "za³o¿y³ kajdanki %s na rêce.", ZmianaNicku(playerid2));
		}
	    cmd_fasdasfdfive(playerid, str);
	}
	else
	{
		new str[250];
	    DaneGracza[playerid2][gKajdanki] = -1;
		DaneGracza[playerid][gKajdankiS] = 0;
		SetPlayerSpecialAction(playerid2,SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(playerid2, 1);
	    Frezuj(playerid2, 1);
	  	format(str, sizeof(str), "zdj¹³ kajdanki z r¹k %s.", ZmianaNicku(playerid2));
	    cmd_fasdasfdfive(playerid, str);
	}
	return 1;
}
CMD:przeszukaj(playerid,cmdtext[])
{
	//printf("U¿yta komenda przeszukaj");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!UprawnienieNaSluzbie(playerid, U_PRZESZUKANIE))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby przeszukaæ {88b711}gracz{DEDEDE} musisz wejœæ na s³u¿bê dzia³alnoœci, która posiada uprawnienia do przeszukiwania postaci.", "Zamknij", "");
		return 1;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		new playerid2;
		if(sscanf(cmdtext, "i", playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}przeszukaæ{DEDEDE} gracza wpisz: {88b711}/przeszukaj [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!PlayerObokPlayera(playerid, playerid2, 2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}przeszukaæ{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}przeszukaæ{DEDEDE} nie znajduje siê obok Ciebie.", "Zamknij", "");
			return 0;
		}
		if(playerid == playerid2) return 1;
		new str[124];
		format(str, sizeof(str), "przeszuka³ %s.", ZmianaNicku(playerid2));
		cmd_fasdasfdfive(playerid, str);
		Przedmioty(playerid, playerid2, DIALOG_INFO, "{DEDEDE}"VER" » Przedmioty:", TYP_WLASCICIEL, 0);
	}
	else
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new uid = SprawdzCarUID(vehicleid);
		new str[124];
		format(str, sizeof(str), "przeszuka³ pojazd %s.", GetVehicleModelName(PojazdInfo[uid][pModel]));
		cmd_fasdasfdfive(playerid, str);
		Przedmioty(playerid, playerid, DIALOG_INFO, "{DEDEDE}"VER" » Przedmioty » Pojazd:", TYP_AUTO, uid);
	}
	return 1;
}
CMD:blokada(playerid,cmdtext[])
{
	//printf("U¿yta komenda blokada");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new metekst_global[128];
	if(sscanf(cmdtext, "s[128]", metekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}blokade{DEDEDE} drogow¹ wpisz: {88b711}/blokada [stworz, usun]", "Zamknij", "");
		return 1;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz {88b711}uprawnieñ{DEDEDE} do zarzadzania blokadami drogowymi b¹dŸ nie jesteœ na {88b711}s³u¿bie{DEDEDE} odpowiedniej dzia³alnoœci!", "Zamknij", "");
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
	{
		if(!ZarzadzanieBlokadami(playerid) && GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz {88b711}uprawnieñ{DEDEDE} do zarzadzania blokadami drogowymi!", "Zamknij", "");
			return 1;
		}
		else
		{
			if(ComparisonString(metekst_global, "stworz"))
			{
				new find = -1;
				for(new i = 0; i < MAX_BLOKAD; i++)
				{
					if(BlokadaInfo[i][bloSAMP] == 0)
					{
						find = i;
					}
				}
				if(find != -1)
				{
					new Float:posx, Float:posy, Float:posz, Float:rotz;
					GetPlayerPos(playerid, posx, posy, posz);
					GetPlayerFacingAngle(playerid, rotz);
					if(rotz < 360.0 && rotz > 270.0)
					{
						posx = posx + 1.5;
						posy = posy + 1.5;
					}
					else if(rotz < 270.0 && rotz > 180.0)
					{
						posx = posx + 1.5;
						posy = posy - 1.5;
					}
					else if(rotz < 270.0 && rotz > 90.0)
					{
						posx = posx - 1.5;
						posy = posy - 1.5;
					}
					else if(rotz < 180.0 && rotz > 0.0)
					{
						posx = posx - 1.5;
						posy = posy + 1.5;
					}
					else if(rotz < 90.0 && rotz > 0.0 || rotz < 360.0 && rotz > 270.0)
					{
						posx = posx + 1.5;
						posy = posy + 1.5;
					}
					new id = CreateDynamicObject(3578, posx, posy, posz-0.5, 0, 0, rotz);
					BlokadaInfo[find][bloSAMP] = id;
					BlokadaInfo[find][bloPozX] = posx;
					BlokadaInfo[find][bloPozY] = posy;
					BlokadaInfo[find][bloPozZ] = posz;
					BlokadaInfo[find][bloRotX] = 0;
					BlokadaInfo[find][bloRotY] = 0;
					BlokadaInfo[find][bloRotZ] = rotz;
					BlokadaInfo[find][blovWorld] = GetPlayerVirtualWorld(playerid);
					BlokadaInfo[find][bloModel] = 3578;
					Streamer_Update(playerid);
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Limit blokad drogowych zosta³ wykorzystany, stworzenie kolenej bedzie {88b711}mozliwe{DEDEDE} po usuniêciu wczesniejszych!", "Zamknij", "");
					return 1;
				}
			}
			else if(ComparisonString(metekst_global, "usun"))
			{
				new id_blokady = PrzyObiekcieBlo(playerid, 3578, 8);
				if(id_blokady != 0)
				{
					new usun = BlokadaInfo[id_blokady][bloSAMP];
					DestroyDynamicObject(usun);
					BlokadaInfo[id_blokady][bloSAMP] = 0;
					BlokadaInfo[id_blokady][bloPozX] = 0;
					BlokadaInfo[id_blokady][bloPozY] = 0;
					BlokadaInfo[id_blokady][bloPozZ] = 0;
					BlokadaInfo[id_blokady][bloRotX] = 0;
					BlokadaInfo[id_blokady][bloRotY] = 0;
					BlokadaInfo[id_blokady][bloRotZ] = 0;
					BlokadaInfo[id_blokady][blovWorld] = 0;
					BlokadaInfo[id_blokady][bloModel] = 0;
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Znajdujesz sie zbyt daleko {88b711}obiektu{DEDEDE} blokady drogowej!", "Zamknij", "");
					return 1;
				}
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}blokade{DEDEDE} drogow¹ wpisz: {88b711}/blokada [stworz, usun]", "Zamknij", "");
				return 1;
			}
		}
	}
	return 1;
}
CMD:blokuj(playerid,cmdtext[])
{
	//printf("U¿yta komenda blokuj");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 27))
	{
		return 0;
	}
	new litry, powod[256];
	if(sscanf(cmdtext, "ds[256]", litry, powod))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby na³o¿yæ {88b711}blokade{DEDEDE} na ko³o pojazdu wpisz: {88b711}/blokuj [kwota] [powód]", "Zamknij", "");
		return 1;
	}
	if(litry < 0 || litry > 10000)
	{
		GameTextForPlayer(playerid, "~r~Podana kwota jest niepoprawna!", 3000, 5);
		return 0;
	}
	new vec = GetClosestVehicle(playerid, 15);
    new vehc = SprawdzCarUID(vec);
    if(vec == INVALID_VEHICLE_ID)
    {
        GameTextForPlayer(playerid, "~r~Nie stoisz przy zadnym pojezdzie!", 3000, 5);
	    return 1;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		GameTextForPlayer(playerid, "~r~Nie mozesz znajdowac sie w pojezdzie!", 3000, 5);
		return 0;
	}
	if(NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 28))
	{
		PojazdInfo[vehc][pBlokada] = litry;
	}
	else
	{
		PojazdInfo[vehc][pBlokada] += litry;
	}
	GetVehiclePos(vec, PojazdInfo[vehc][pX], PojazdInfo[vehc][pY], PojazdInfo[vehc][pZ]);
 	GetVehicleZAngle(vec, PojazdInfo[vehc][pAngle]);
	ZapiszPojazd(vehc, 1);
	StworzPojazd(vehc, -1);
	OnPlayerText(playerid, "-szukaj");
	Transakcja(T_BLOKADAK, DaneGracza[playerid][gUID], PojazdInfo[vehc][pOwnerPostac], DaneGracza[playerid][gGUID], PojazdInfo[vehc][pOwnerDzialalnosc], litry, vehc, vec, -1, powod, gettime()-CZAS_LETNI);
	new strss[256];
	format(strss, sizeof(strss), "Nalo¿y³eœ blokade na pojazd %s, kwota: %d$, powód: %s.",GetVehicleModelName(PojazdInfo[vehc][pModel]), PojazdInfo[vehc][pBlokada], powod);
	SendClientMessage(playerid, 0xFFb00000, strss);
	StworzPojazd(vehc, -1);
	return 1;
}
CMD:alkomat(playerid, params[])
{
	//printf("U¿yta komenda alkomat");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 29))
	{
		return 0;
	}
	//new vw = GetPlayerVirtualWorld(playerid);
	/*if(IsPlayerInAnyVehicle(playerid))
	{
		new vehids = GetPlayerVehicleID(playerid);
		new uipd = SprawdzCarUID(vehids);
		if(GrupaInfo[PojazdInfo[uipd][pOwnerDzialalnosc]][gTyp] != DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd nie nale¿y do {88b711}Police Departament{DEDEDE}.", "Zamknij", "");
			return 0;
		}
	}
	else
	{
		if(vw == 0)
		{
			return 0;
		}
		if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz siê w budynku który nale¿y do {88b711}Police Departament{DEDEDE}.", "Zamknij", "");
			return 0;
		}
	}*/
	new playerid2;
	if(sscanf(params, "i", playerid2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ {88b711}alkomatu{DEDEDE} wpisz: {88b711}/alkomat [id gracza]", "Zamknij", "");
		return 1;
	}
	if(!PlayerObokPlayera(playerid, playerid2, 2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chesz sprawdziæ alkomatem {88b711}nie{DEDEDE} znajduje siê obok Ciebie.", "Zamknij", "");
		return 1;
	}
	if(zalogowany[playerid2] == false)
    {
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chesz sprawdziæ alkomatem {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
        return 0;
    }
	new Float: promil = 0;
	if(GetPlayerDrunkLevel(playerid2) >= 1000) promil = 0.1;
	if(GetPlayerDrunkLevel(playerid2) >= 1400) promil = 0.2;
	if(GetPlayerDrunkLevel(playerid2) >= 1800) promil = 0.3;
	if(GetPlayerDrunkLevel(playerid2) >= 2200) promil = 0.4;
	if(GetPlayerDrunkLevel(playerid2) >= 2600) promil = 0.5;
	if(GetPlayerDrunkLevel(playerid2) >= 3600) promil = 0.6;
	if(GetPlayerDrunkLevel(playerid2) >= 4000) promil = 0.7;
	if(GetPlayerDrunkLevel(playerid2) >= 4400) promil = 0.8;
	if(GetPlayerDrunkLevel(playerid2) >= 4800) promil = 0.9;
	if(GetPlayerDrunkLevel(playerid2) >= 5200) promil = 1.0;
	if(GetPlayerDrunkLevel(playerid2) >= 5600) promil = 1.1;
	if(GetPlayerDrunkLevel(playerid2) >= 6000) promil = 1.2;
	if(GetPlayerDrunkLevel(playerid2) >= 6400) promil = 1.3;
	if(GetPlayerDrunkLevel(playerid2) >= 6800) promil = 1.4;
	if(GetPlayerDrunkLevel(playerid2) >= 7200) promil = 1.5;
	if(GetPlayerDrunkLevel(playerid2) >= 7600) promil = 1.6;
	if(GetPlayerDrunkLevel(playerid2) >= 8000) promil = 1.7;
	if(GetPlayerDrunkLevel(playerid2) >= 8400) promil = 1.8;
	if(GetPlayerDrunkLevel(playerid2) >= 8800) promil = 1.9;
	if(GetPlayerDrunkLevel(playerid2) >= 9200) promil = 2.0;
	if(GetPlayerDrunkLevel(playerid2) >= 9600) promil = 2.1;
	if(GetPlayerDrunkLevel(playerid2) >= 10000) promil = 2.2;
	if(GetPlayerDrunkLevel(playerid2) >= 10400) promil = 2.3;
	if(GetPlayerDrunkLevel(playerid2) >= 10800) promil = 2.4;
	if(GetPlayerDrunkLevel(playerid2) >= 11200) promil = 2.5;
	if(GetPlayerDrunkLevel(playerid2) >= 11600) promil = 2.6;
	if(GetPlayerDrunkLevel(playerid2) >= 12000) promil = 2.7;
	if(GetPlayerDrunkLevel(playerid2) >= 12400) promil = 2.8;
	if(GetPlayerDrunkLevel(playerid2) >= 12800) promil = 2.9;
	if(GetPlayerDrunkLevel(playerid2) >= 13200) promil = 3.0;
	if(GetPlayerDrunkLevel(playerid2) >= 13600) promil = 3.1;
	if(GetPlayerDrunkLevel(playerid2) >= 14000) promil = 3.2;
	if(GetPlayerDrunkLevel(playerid2) >= 14400) promil = 3.3;
	if(GetPlayerDrunkLevel(playerid2) >= 14800) promil = 3.4;
	if(GetPlayerDrunkLevel(playerid2) >= 15200) promil = 3.5;
	if(GetPlayerDrunkLevel(playerid2) >= 15600) promil = 3.6;
	if(GetPlayerDrunkLevel(playerid2) >= 16000) promil = 3.7;
	if(GetPlayerDrunkLevel(playerid2) >= 16400) promil = 3.8;
	if(GetPlayerDrunkLevel(playerid2) >= 16800) promil = 3.9;
	if(GetPlayerDrunkLevel(playerid2) >= 17200) promil = 4.0;
	cmd_fasdasfdfive(playerid, "chwyta za alkomat nastêpnie przyk³ada go do ust zatrzymanego.");
	new strss[256];
	format(strss, sizeof(strss), "Pomiar: %s. Czytnik wykaza³ %0.1f promili.", ZmianaNicku(playerid2),promil);
	SendClientMessage(playerid, 0xFFb00000, strss);
	return 1;
}
CMD:przetrzymaj(playerid, params[])
{
	//printf("U¿yta komenda przetrzymaj");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!MaUprawnieie(playerid, 37))
	{
		return 0;
	}
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw != 0)
	{
		if(!OtwieranieBudynku(GetPlayerVirtualWorld(playerid), playerid))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz kluczy do tych drzwi.", 3000, 5);
			return 0;
		}
	}
	else
	{
		return 0;
	}
	new playerid2, czas, typ[24], powod[256];
	if(sscanf(params, "dds[24]s[256]", playerid2, czas, typ, powod))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}przetrzymaæ{DEDEDE} gracza wpisz: {88b711}/przetrzymaj [id gracza] [czas] [typ - d, h, m] [powód]\n{DEDEDE}Przyk³ad: /przetrzymaj 7 30 d Uciekinier\nTypy: d - dni, h - godzin, m - minut", "Zamknij", "");
		return 1;
	}
	if(playerid == playerid2) return 1;
	if(czas <= 0)
	{
		return 0;
	}
	if(ComparisonString(typ, "m") || ComparisonString(typ, "h") || ComparisonString(typ, "d") || ComparisonString(typ, "M") || ComparisonString(typ, "H") || ComparisonString(typ, "D"))
	{
		if(!PlayerObokPlayera(playerid, playerid2, 2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}przetrzymaæ{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}przetrzymaæ{DEDEDE} nie znajduje siê obok Ciebie.", "Zamknij", "");
			return 0;
		}
		if(strlen(powod) < 3)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}przetrzymaæ{DEDEDE} gracza wpisz: {88b711}/przetrzymaj [id gracza] [czas] [typ - d, h, m] [powód]\n{DEDEDE}Przyk³ad: /przetrzymaj 7 30 d Uciekinier\nTypy: d - dni, h - godzin, m - minut", "Zamknij", "");
			return 0;
		}
		if(!GraczPrzetrzymywany(playerid2))
		{
			if(ComparisonString(typ, "d") || ComparisonString(typ, "D"))
			{
				DaneGracza[playerid2][gPrzetrzmanie] = (gettime()-CZAS_LETNI)+(86400*czas);
			}
			else if(ComparisonString(typ, "m") || ComparisonString(typ, "M"))
			{
				DaneGracza[playerid2][gPrzetrzmanie] = (gettime()-CZAS_LETNI)+(60*czas);
			}
			else if(ComparisonString(typ, "h") || ComparisonString(typ, "H"))
			{
				DaneGracza[playerid2][gPrzetrzmanie] = (gettime()-CZAS_LETNI)+(3600*czas);
			}
			GetPlayerPos(playerid2,DaneGracza[playerid2][gPX],DaneGracza[playerid2][gPY],DaneGracza[playerid2][gPZ]);
			DaneGracza[playerid2][gPUID] = vw;
			ZapiszGracza(playerid2);
			RefreshNick(playerid2);
			new strss[256];
			new rok, miesiac, dzien, godzina, minuta, sekunda;
			sekundytodata(DaneGracza[playerid2][gPrzetrzmanie]-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
			format(strss, sizeof(strss), "{CC0000}Zosta³eœ przetrzymany przez gracza: %s (ID:%d) do: %02d-%02d-%d, %02d:%02d, powód: %s",ZmianaNicku(playerid), playerid,dzien, miesiac, rok, godzina, minuta, powod);
			SendClientMessage(playerid2, 0xFFb00000, strss);
			DodajKartoteke(playerid, playerid2, 2, powod);
			if(NieruchomoscInfo[vw][nWlascicielD] != 0)
			{
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == NieruchomoscInfo[vw][nWlascicielD])
					{
						new strs[256];
						format(strs, sizeof(strs), "{CC0000}Gracz %s (ID: %d) przetrzymuje gracza: %s (ID:%d) do: %02d-%02d-%d, %02d:%02d, powód: %s",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2,dzien, miesiac, rok, godzina, minuta, powod);
						SendClientMessage(KtoJestOnline[i], 0xFFb00000, strs);
					}
				}
			}else{
				new strs[256];
				format(strs, sizeof(strs), "{CC0000}Gracz %s (ID: %d) przetrzymuje gracza: %s (ID:%d) do: %02d-%02d-%d, %02d:%02d, powód: %s",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2,dzien, miesiac, rok, godzina, minuta, powod);
				SendClientMessage(playerid, 0xFFb00000, strs);
			}
		}
		else
		{
			if(!MaUprawnieie(playerid, 38))
			{
				GameTextForPlayer(playerid, "~r~Nie masz uprawnien do zdejmowania przetrzymania.", 3000, 5);
				return 0;
			}
			DaneGracza[playerid2][gPrzetrzmanie] = 0;
			ZapiszGracza(playerid2);
			RefreshNick(playerid2);
			new strss[256];
			format(strss, sizeof(strss), "{CC0000}Zosta³eœ uwolniony przez gracza: %s (ID:%d), powód: %s",ZmianaNicku(playerid), playerid, powod);
			SendClientMessage(playerid2, 0xFFb00000, strss);
			if(NieruchomoscInfo[vw][nWlascicielD] != 0)
			{
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == NieruchomoscInfo[vw][nWlascicielD] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == NieruchomoscInfo[vw][nWlascicielD])
					{
						new strs[256];
						format(strs, sizeof(strs), "{CC0000}Gracz %s (ID: %d) zdejmuje przetrzymanie graczu: %s (ID:%d), powód: %s",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2, powod);
						SendClientMessage(KtoJestOnline[i], 0xFFb00000, strs);
					}
				}
			}else{
				new strs[256];
				format(strs, sizeof(strs), "{CC0000}Gracz %s (ID: %d) zdejmuje przetrzymanie graczu: %s (ID:%d), powód: %s",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2, powod);
				SendClientMessage(playerid, 0xFFb00000, strs);
			}
		}
	}else{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}przetrzymaæ{DEDEDE} gracza wpisz: {88b711}/przetrzymaj [id gracza] [czas] [typ - d, h, m] [powód]\n{DEDEDE}Przyk³ad: /przetrzymaj 7 30 d Uciekinier\nTypy: d - dni, h - godzin, m - minut", "Zamknij", "");
	}
	return 1;
}
CMD:kartoteka(playerid, params[])
{
	//printf("U¿yta komenda kartoteka");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 30))
	{
		return 0;
	}
	new vw = GetPlayerVirtualWorld(playerid);
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehids = GetPlayerVehicleID(playerid);
		new uipd = SprawdzCarUID(vehids);
		if(GrupaInfo[PojazdInfo[uipd][pOwnerDzialalnosc]][gTyp] != DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd nie nale¿y do {88b711}Police Departament{DEDEDE}.", "Zamknij", "");
			return 0;
		}
	}
	else
	{
		if(vw == 0)
		{
			return 0;
		}
		if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz siê w budynku który nale¿y do {88b711}Police Departament{DEDEDE}.", "Zamknij", "");
			return 0;
		}
	}
	new playerid2;
	if(sscanf(params, "i", playerid2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby sprawdziæ {88b711}kartoteke{DEDEDE} gracza: {88b711}/kartoteka [id gracza]", "Zamknij", "");
		return 1;
	}
	if(zalogowany[playerid2] == false)
    {
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz sprawdziæ kartoteke {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
        return 0;
    }
	new	wpisy[512], find = 0;
	ForeachEx(i, MAX_KARTOTEKA)
	{
	    if(KartotekaInfo[i][kUID] == DaneGracza[playerid2][gUID])
	    {
			format(wpisy, sizeof(wpisy), "%s\n%d\t[%s]\t%s", wpisy, KartotekaInfo[i][kID], KartotekaInfo[i][kData], KartotekaInfo[i][kPowod]);
			find++;
		}
	}
	if(find > 0) 
	{
		new	wpisys[512];
		format(wpisys, sizeof(wpisys), "Gracz: %s, Wpisów: %d, Pkt: %d/24", ZmianaNicku(playerid2), find, DaneGracza[playerid2][gPktKarne]);
		dShowPlayerDialog(playerid, DIALOG_KARTOTEKA_OPCJE, DIALOG_STYLE_LIST, wpisys, wpisy, "Wiecej", "Zamknij");
	}
	else 
	{
		new	wpisyss[512];
		new	wpisys[512];
		format(wpisyss, sizeof(wpisyss), "Gracz %s nie posiada wpisów w kartotece.\nAb dodaæ nowy wpis wciœnij guzik ''Dodaj''", ZmianaNicku(playerid2));
		format(wpisys, sizeof(wpisys), "Gracz: %s, Wpisów: %d, Pkt: %d/24", ZmianaNicku(playerid2), find, DaneGracza[playerid2][gPktKarne]);
		dShowPlayerDialog(playerid, DIALOG_KARTOTEKA_WPIS, DIALOG_STYLE_MSGBOX, wpisys,wpisyss, "Dodaj", "Zamknij");
	}
	SetPVarInt(playerid, "IDKART", playerid2);
	return 1;
}
forward DodajKartoteke(playerid, playerid2, typ, powod[]);
public DodajKartoteke(playerid, playerid2, typ, powod[])
{
	if(zalogowany[playerid2] == false)
    {
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz dodaæ wpisz do kartoteki {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
        return 0;
    }
	new	data[124];
	new Rok, Miesiac, Dzien;
	getdate(Rok, Miesiac, Dzien);
	format(data, sizeof(data), "%02d:%02d:%d", Dzien, Miesiac, Rok);
	new	godz[124];
	new godzina, minuta;
	gettime(godzina, minuta);
	format(godz, sizeof(godz), "%02d:%02d", godzina, minuta);
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_kartoteka` (`UID_GRACZA`, `UID_NADAJACEGO`, `GUID_GRACZA`, `GUID_NADAJACEGO`, `NICK_GRACZA`, `NICK_NADAJACEGO`, `DATA`, `GODZINA`, `POWOD`, `TYP`) VALUES ('%d', '%d', '%d', '%d', '%s', '%s', '%s', '%s', '%s', '%d')",
	DaneGracza[playerid2][gUID], DaneGracza[playerid][gUID], DaneGracza[playerid2][gGUID], DaneGracza[playerid][gGUID], ZmianaNicku(playerid2), ZmianaNicku(playerid), data, godz, powod, typ);
	mysql_check();
	mysql_query2(zapyt);
	new uid = mysql_insert_id();
	KartotekaInfo[uid][kID] = uid;
	KartotekaInfo[uid][kUID] = DaneGracza[playerid2][gUID];
	KartotekaInfo[uid][kUIDN] = DaneGracza[playerid][gUID];
	format(KartotekaInfo[uid][kNick], 124, "%s", ZmianaNicku(playerid2));
	format(KartotekaInfo[uid][kNickN], 124, "%s", ZmianaNicku(playerid));
	KartotekaInfo[uid][kGUID] = DaneGracza[playerid2][gGUID];
	KartotekaInfo[uid][kGUIDN] = DaneGracza[playerid][gGUID];
	format(KartotekaInfo[uid][kData], 124, "%s", data);
	format(KartotekaInfo[uid][kGodzina], 124, "%s", godz);
	format(KartotekaInfo[uid][kPowod], 256, "%s", powod);
	KartotekaInfo[uid][kTyp] = typ;
	mysql_free_result();
	return uid;
}
stock GraczPrzetrzymywany(playerid)
{
	new pkt = DaneGracza[playerid][gPrzetrzmanie];
	if(pkt > gettime()-CZAS_LETNI) return true;
	else return false;
}
CMD:kolczatka(playerid,cmdtext[])
{
	//printf("U¿yta komenda kolczatka");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!MaUprawnieie(playerid, 39))
	{
		return 1;
	}
	new	comm1[32], comm2[128];
	if(sscanf(cmdtext, "s[32]S()[128]", comm1, comm2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}kolaczatke{DEDEDE} wpisz: {88b711}/kolczatka [stworz, usun]", "Zamknij", "");
		return 1;
	}
	if(!strcmp(comm1,"stworz",true))
	{
		new typ;
		if(sscanf(comm2, "d", typ))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}kolaczatke{DEDEDE} wpisz: {88b711} /kolczatka stworz [kolczatka (1-5)]", "Zamknij", "");
			return 1;
		}
		if(typ <= 0 || typ >= 6)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}kolaczatke{DEDEDE} wpisz: {88b711} /kolczatka stworz [kolczatka (1-5)]", "Zamknij", "");
			return 0;
		}
		if(KolczatkaInfo[typ][kModel] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ tej {88b711}kolczatki{DEDEDE} ktoœ w³aœnie u¿ywa.", "Zamknij", "");
			return 0;
		}
		new Float: x, Float: y, Float: z, Float: a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		GetXYInFrontOfPoint(x, y, a, 5.2);
		KolczatkaInfo[typ][kSAMP] = CreateDynamicObject(2892, x, y, z - 1, 0, 0, a);
		KolczatkaInfo[typ][kUzyta] = 1;
		KolczatkaInfo[typ][kPozX] = x;
		KolczatkaInfo[typ][kPozY] = y;
		KolczatkaInfo[typ][kPozZ] = z;
		KolczatkaInfo[typ][kRotX] = 0;
		KolczatkaInfo[typ][kRotY] = 0;
		KolczatkaInfo[typ][kRotZ] = a;
		KolczatkaInfo[typ][kvWorld] = GetPlayerVirtualWorld(playerid);
		KolczatkaInfo[typ][kModel] = 2892;
		Streamer_Update(playerid);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Kolczatka zosta³a {88b711}stworzona{DEDEDE}.", "Zamknij", "");
	}
	if(!strcmp(comm1,"usun",true))
	{
		new typ;
		if(sscanf(comm2, "d", typ))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}usun¹æ{DEDEDE} kolczatke wpisz: {88b711}/kolczatka usun [kolczatka (1-5)]", "Zamknij", "");
			return 1;
		}
		if(typ <= 0 || typ > 5)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}usun¹æ{DEDEDE} kolczatke wpisz: {88b711}/kolczatka usun [kolczatka (1-5)]", "Zamknij", "");
			return 0;
		}
		if(KolczatkaInfo[typ][kModel] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Taka kolczatka {88b711}nie{DEDEDE} zosta³a stworzona.", "Zamknij", "");
			return 0;
		}
		DestroyDynamicObject(KolczatkaInfo[typ][kSAMP]);
		KolczatkaInfo[typ][kSAMP] = 0;
		KolczatkaInfo[typ][kPozX] = 0;
		KolczatkaInfo[typ][kPozY] = 0;
		KolczatkaInfo[typ][kPozZ] = 0;
		KolczatkaInfo[typ][kUzyta] = 0;
		KolczatkaInfo[typ][kRotX] = 0;
		KolczatkaInfo[typ][kRotY] = 0;
		KolczatkaInfo[typ][kRotZ] = 0;
		KolczatkaInfo[typ][kvWorld] = 0;
		KolczatkaInfo[typ][kModel] = 0;
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Kolczatka zosta³a {88b711}usuniêta{DEDEDE}.", "Zamknij", "");
			
	}
	return 1;
}
stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) {
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}