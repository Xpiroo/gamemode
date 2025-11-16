AntiDeAMX();
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dDialogid[playerid]!=dialogid)
	{
	    NadajKare(playerid,-1, 2, "Anty Cheat System (OnDialogResponse)", 30);
	    return 1;
	}
	dDialogid[playerid]=0;
    A_CHAR(inputtext); //Zamienia % na # w tekscie GUI
////////////////////////////////////////////////////////////////////////////////
    if(dialogid == DIALOG_MAIN)
    {
        switch(listitem)
        {
			case 0: 
			{
				if(!response)
				{
					return 1;
				}
				dShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Fotoradary{88b711}:","{DEDEDE}Podaj ograniczenie {88b711}prÍdkoúci{DEDEDE} w kilometrach.","Dalej","Zamknij");
			}
			case 1:
			{
				new cam = GetClosestCamera(playerid);
				if(cam == -1) return 1;
				SetPVarInt(playerid,"selected",cam);
				dShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,"{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Fotoradary{88b711}:","Zmiany kπta\nZmiany zakresu\nZmiena limitu szybkoúci","Akceptuj","Zamknij");
			}
			case 2:
			{
				new cam = GetClosestCamera(playerid);
				if(cam == -1) return 1;
				UsunFotoradar(cam);
			 	SendClientMessage(playerid,COLOR_GREEN,"Fotoradar zosta≥ usuniÍty.");
			 	DeletePVar(playerid,"selected");
			}
	    }
	    if(!response) {
		DeletePVar(playerid,"Zakres");
		DeletePVar(playerid,"Limit");
		DeletePVar(playerid,"Kara pieniÍøna");
		DeletePVar(playerid,"Dobieranie");
		return 1;
		}
	}
	if(dialogid == DIALOG_EDYTOR)
	{
	    if(!response)
		{
			DaneGracza[playerid][gEdytor] = 1;
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:","{DEDEDE}W≥πczy≥eú edytor typu {88b711}SAMP{DEDEDE}.", "Zamknij", "" );
			return 1;
		}else{
			DaneGracza[playerid][gEdytor] = 0;
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:","{DEDEDE}W≥πczy≥eú edytor typu {88b711}MTA{DEDEDE}.", "Zamknij", "" );
		}
		ZapiszGracza(playerid);
	}
	if(dialogid == DIALOG_LIMIT)
	{
	    if(!response) {
		DeletePVar(playerid,"Zakres");
		DeletePVar(playerid,"Limit");
		DeletePVar(playerid,"Kara pieniÍøna");
		DeletePVar(playerid,"Dobieranie");
		return 1;
		}
		if(!strlen(inputtext)) return dShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Fotoradary{88b711}:","{DEDEDE}Podaj ograniczenie {88b711}prÍdkoúci{DEDEDE} w kilometrach.","Dalej","Zamknij");
		SetPVarInt(playerid,"range",12);
		SetPVarInt(playerid,"limit",strval(inputtext));
	    SetPVarInt(playerid,"fine",strval(inputtext));
		new Float:x,Float:y,Float:z,Float:angle;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,angle);
		angle = angle + 180;if(angle > 360){angle = angle - 360;}
		new id = CreateSpeedCam(x,y,z -3,angle,GetPVarInt(playerid,"range"),GetPVarInt(playerid,"limit"),GetPVarInt(playerid,"fine"),0);
		Teleportuj(playerid,x,y+2,z);
		DeletePVar(playerid,"range");
		DeletePVar(playerid,"limit");
		DeletePVar(playerid,"fine");
		SetPVarInt(playerid,"selected",id);
	}
	if(dialogid == DIALOG_WB)
	{
		new uid = GetPVarInt(playerid, "UIDPB");
		if(LakierujeCzas[playerid] != 0 && PrzedmiotInfo[uid][pWar1] == 41)
		{
			PoziomLakieru[playerid] = PrzedmiotInfo[uid][pWar2];
		}
		MozeBanowac[playerid] = 1;
		AntyCheatBroni[playerid] = 1;
		KillTimer(TimerAntyCheat[playerid]);
		TimerAntyCheat[playerid] = SetTimerEx("WlaczAntyCheata",5000,0,"d",playerid);
		DaneGracza[playerid][gBronUID] = uid;
		DaneGracza[playerid][gBronAmmo] = PrzedmiotInfo[uid][pWar1];
	    PrzedmiotInfo[uid][pUzywany] = 1;
		PosiadanaBron[playerid] = PrzedmiotInfo[uid][pWar1];
		SetPVarInt(playerid, "UzywanaBron", PrzedmiotInfo[uid][pWar1]);
		SetPVarInt(playerid, "UzywanaBronUID", uid);
		dDajBron(playerid, PrzedmiotInfo[uid][pWar1], PrzedmiotInfo[uid][pWar2]);
		ZapiszGracza(playerid);
		strdel(tekst_global, 0, 2048);
		format(tekst_global, sizeof(tekst_global), "wyciπgnπ≥ broÒ %s z %s.", PrzedmiotInfo[uid][pNazwa], inputtext);
		cmd_fasdasfdfive(playerid, tekst_global);
	}
	if(dialogid == DIALOG_TAG)
	{
		new find = Tag[playerid];
		if(!response) 
		{
			ObiektInfo[find][gZajety] = 0;
			return 1;
		}
		if(strlen(inputtext) < 10)
		{
			dShowPlayerDialog(playerid, DIALOG_TAG, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Rozpoczπ≥eú proces {88b711}tagowania{DEDEDE} poniøej wpisz tag jaki ma siÍ pokazaÊ po {88b711}zakoÒczeniu{DEDEDE} tego procesu.\n{88b711}Tag powinien zawieraÊ przynajmniej 10 znakÛw.", "Zatwierdz", "Zamknij");
			return 1;
		}
		SetPVarString(playerid,"tagnapis",inputtext);
		new bron_uid = GetPVarInt(playerid, "UzywanaBronUID");
		PoziomLakieru[playerid] = PrzedmiotInfo[bron_uid][pWar2];
		LakierujeCzas[playerid] = 1;
		PJ[playerid] = 0;
		SetPVarInt(playerid, "TAGDUTY", DaneGracza[playerid][gSluzba]);
		UpdateDynamic3DTextLabelText(ObiektInfo[find][objNapis], 0xC2A2DAFF, "Rozpoczynanie tagowania");
	}
	if(dialogid == DIALOG_WYSCIG_OPCJE)
	{
		if(!response) {
			return 1;
		}
	    switch(listitem)
	    {
	        case 0: 
			{
				if(DaneGracza[playerid][gSluzba] == 0)
				{
					GameTextForPlayer(playerid, "~r~Nie znajdujesz sie na sluzbie organizacji.", 3000, 5);
					return 0;
				}
				new find, list_race[256];
				ForeachEx(i, MAX_WYSCIG)
				{
					if(WyscigInfo[i][StworzylTrase] == DaneGracza[playerid][gSluzba] && WyscigInfo[i][TrasaNR] == 0)
					{
						format(list_race, sizeof(list_race), "%s\n%d\t{dedede}%s", list_race, WyscigInfo[i][wUID], WyscigInfo[i][wNazwa]);
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_WYSCIG_DOLACZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Trasy dzia≥alnoúci{88b711}:", list_race, "Do≥πcz", "Zamknij");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada stworzonych tras wyúcigowych.", "Zamknij", "");
			}
	        case 1:
			{
				if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], 44)) 
				{
					GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
					return 0;
				}
				dShowPlayerDialog(playerid, DIALOG_WYSCIG_STWORZ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Tworzenie trasy wyúcigowej{88b711}:", "{DEDEDE}Podaj nazwe {88b711}trasy{DEDEDE}, ktÛrπ chcesz stworzyÊ nastÍpnie wciúnij ''{88b711}Dalej{DEDEDE}''\n", "Dalej", "Zamknij");
			}
			case 2:
			{
				if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], 46)) 
				{
					GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
					return 0;
				}
				if(DaneGracza[playerid][gWyscig] == 0)
				{
					GameTextForPlayer(playerid, "~r~Aktualnie nie uczestniczysz w zadnym wyscigu.", 3000, 5);
					return 0;
				}
				new race = DaneGracza[playerid][gWyscig];
				WyscigInfo[race][wMiejsce] = 0;
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gWyscig] == DaneGracza[playerid][gWyscig])
					{
						new str[256];
						format(str, sizeof(str), "~g~Organizator:~w~~n~ %s ~r~rozpoczal wyscig: ~w~%s~n~zacznie sie za 10 sekund.", ZmianaNicku(playerid), WyscigInfo[race][wNazwa]);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[i]] = 20;
						TextDrawHideForPlayer(KtoJestOnline[i], TextNaDrzwi[KtoJestOnline[i]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[i]], str);
						TextDrawShowForPlayer(KtoJestOnline[i], TextNaDrzwi[KtoJestOnline[i]]);

						DaneGracza[playerid][gCheckopintID] = 0;
						//SetPlayerCheckpoint(KtoJestOnline[i], WyscigInfo[race][wX], WyscigInfo[race][wY], WyscigInfo[race][wZ], 8);
						new nextto = SzukajCheckpointu(1, WyscigInfo[DaneGracza[KtoJestOnline[i]][gWyscig]][StworzylTrase],WyscigInfo[DaneGracza[KtoJestOnline[i]][gWyscig]][wNazwa]);
						SetPlayerRaceCheckpoint(KtoJestOnline[i],0,WyscigInfo[race][wX], WyscigInfo[race][wY], WyscigInfo[race][wZ],WyscigInfo[nextto][wX], WyscigInfo[nextto][wY], WyscigInfo[nextto][wZ],8);
			
						DaneGracza[KtoJestOnline[i]][gKoniecWyscigu] = 0;
						DaneGracza[KtoJestOnline[i]][gRaceTimeStart] = 10;
						Frezuj(KtoJestOnline[i], 0);
						format(str, sizeof(str), "~w~%d", DaneGracza[KtoJestOnline[i]][gRaceTimeStart]);
						GameTextForPlayer(KtoJestOnline[i], str, 1000, 4);
					}
				}
			}
			case 3: 
			{
				if(DaneGracza[playerid][gSluzba] == 0)
				{
					GameTextForPlayer(playerid, "~r~Nie znajdujesz sie na sluzbie organizacji.", 3000, 5);
					return 0;
				}
				new find, list_race[256];
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gWyscig] == DaneGracza[playerid][gWyscig] && playerid != KtoJestOnline[i])
					{
						format(list_race, sizeof(list_race), "%s\n%d\t{dedede}%s", list_race, KtoJestOnline[i], ZmianaNicku(KtoJestOnline[i]));
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_WYSCIG_WYRZUC, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista uczestnikÛw{88b711}:", list_race, "Wyrzuc", "Zamknij");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nikt nie naleøy do tego wyúcigu.", "Zamknij", "");
			}
	    }
	}
	if(dialogid == DIALOG_WYSCIG_DOLACZ)
	{
		if(!response) {
		return 1;
		}
		if(Pracuje[playerid] != 0)
		{
			GameTextForPlayer(playerid, "~r~Aktualnie sprzatasz ulice. Anuluj zlecenie, aby dolaczyc do wyscigu.", 3000, 5);
			return 0;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			GameTextForPlayer(playerid, "~r~Nie znajdujesz sie na sluzbie organizacji.", 3000, 5);
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], 45))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(DaneGracza[playerid][gTworzyWyscig] != 0) 
		{
			GameTextForPlayer(playerid, "~r~Aktualnie tworzysz jakis wyscig.", 3000, 5);
			return 1;
		}
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby do≥πczyÊ{88b711} do trasy{DEDEDE} musisz siÍ znajdowaÊ w pojezdzie.", "Zamknij", "");
		if(DaneGracza[playerid][gWyscig] != 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}uczestniczysz{DEDEDE} juø w jakimú wyúcigu", "Zamknij", "");
		new uid = strval(inputtext);
		//ZaladujWyscig(WyscigInfo[uid][wNazwa]);
		new str[256];
		if(uid <= 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}System nie zarejestrowa≥ takiej {88b711}trasy{DEDEDE} wyúcigowej.", "Zamknij", "");
		format(str, sizeof(str), "~g~Dolaczyles do wyscigu: ~w~%s~n~Teraz mozesz zapraszac uczestnikow.", WyscigInfo[uid][wNazwa]);
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], str);
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		DaneGracza[playerid][gWyscig] = WyscigInfo[uid][wUID];
		new texts[124];
		format(texts, sizeof(texts), "{DEDEDE}** Gracz: %s do≥πczy≥ do wyúcigu.", ZmianaNicku(playerid));
		KomuninikatWyscig(playerid,texts);
	}
	if(dialogid == DIALOG_ZABIERZ)
	{
		if(!response) {
		return 1;
		}
		new uid = strval(inputtext);
		if(PrzedmiotInfo[uid][pUzywany] != 0)
		{
			UzywanieItemu(GetPVarInt(playerid, "IDZAB"), uid);
		}
		PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
		ZapiszPrzedmiot(uid);
		strdel(tekst_global, 0, 2048);
		format(tekst_global, sizeof(tekst_global), "{DEDEDE}Gracz: {88b711}%s{DEDEDE} zabra≥ ci przedmiot: {88b711}%s{DEDEDE}.", ZmianaNicku(playerid), PrzedmiotInfo[uid][pNazwa]);
		SendClientMessage(GetPVarInt(playerid, "IDZAB"), KOLOR, tekst_global);
		new przelew[124];
		format(przelew, sizeof(przelew), "[ZABIERZ] Gracz: %s (ID:%d) zabra≥ przedmiot graczu: %s (ID:%d, %s)",ZmianaNicku(playerid), playerid, ZmianaNicku(GetPVarInt(playerid, "IDZAB")), GetPVarInt(playerid, "IDZAB"), PrzedmiotInfo[uid][pNazwa]);
		KomunikatAdmin(1, przelew);
	}
	if(dialogid == DIALOG_WYSCIG_WYRZUC)
	{
		if(!response) {
		return 1;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			GameTextForPlayer(playerid, "~r~Nie znajdujesz sie na sluzbie organizacji.", 3000, 5);
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYSCIG_WYPROS))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		new uid = strval(inputtext);
		new texts[256];
		format(texts, sizeof(texts), "{DEDEDE}** Zosta≥eú wyproszony z wyúcigu przez gracza: %s.", ZmianaNicku(playerid));
		SendClientMessage(uid, 0xFFb00000, texts);
		cmd_opusc(uid, "");
	}
	if(dialogid == DIALOG_WYSCIG_STWORZ)
	{
		if(!response) {
		return 1;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			GameTextForPlayer(playerid, "~r~Nie znajdujesz sie na sluzbie organizacji.", 3000, 5);
			return 0;
		}
		//if(GrupaInfo[DaneGracza[playerid][gSluzba]][gSaldo] < 1000)
		//{
		//	GameTextForPlayer(playerid, "~r~Brak potrzebnych srodkow na koncie grupy.", 3000, 5);
		//	return 0;
		//}
		if(DaneGracza[playerid][gTworzyWyscig] != 0) 
		{
			GameTextForPlayer(playerid, "~r~Aktualnie tworzysz juz jakis wyscig.", 3000, 5);
			return 1;
		}
		if(!strlen(inputtext))
		{
			dShowPlayerDialog(playerid, DIALOG_WYSCIG_STWORZ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Tworzenie trasy wyúcigowej{88b711}:", "{DEDEDE}Podaj nazwe {88b711}trasy{DEDEDE}, ktÛrπ chcesz stworzyÊ nastÍpnie wciúnij ''{88b711}Dalej{DEDEDE}''\n", "Dalej", "Zamknij");
			return 0;
		}
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyÊ{88b711}nowπ trase{DEDEDE} musisz siÍ znajdowaÊ w pojezdzie.", "Zamknij", "");
		if(DaneGracza[playerid][gWyscig] != 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b7711}uczestniczysz{DEDEDE} juø w jakimú wyúcigu", "Zamknij", "");
		new zroc = 0;
		if(zroc != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_WYSCIG_STWORZ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Tworzenie trasy wyúcigowej{88b711}:", "{DEDEDE}Podaj nazwe {88b711}trasy{DEDEDE}, ktÛrπ chcesz stworzyÊ nastÍpnie wciúnij ''{88b711}Dalej{DEDEDE}''\n\n{CC0000}Trasa o takiej nazwie juø istnieje.", "Dalej", "Zamknij");
			return 0;
		}
		new Float: x, Float: y, Float: z;
		GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
		strtolower(inputtext);
		inputtext[0] = toupper(inputtext[0]);
		ForeachEx(i, MAX_WYSCIG)
		{
			if(ComparisonString(WyscigInfo[i][wNazwa], inputtext))
			{
				zroc = i;
				break;
			}
		}
		format(DaneGracza[playerid][gTworzyWyscigNazwa], 124, "%s", inputtext);
		new dz;
		switch(DutyNR[playerid])
		{
			case 1: 
				dz = DaneGracza[playerid][gDzialalnosc1];
			case 2: 
				dz = DaneGracza[playerid][gDzialalnosc2];
			case 3: 
				dz = DaneGracza[playerid][gDzialalnosc3];
			case 4: 
				dz = DaneGracza[playerid][gDzialalnosc4];
			case 5: 
				dz = DaneGracza[playerid][gDzialalnosc5];
			case 6: 
				dz = DaneGracza[playerid][gDzialalnosc6];
		}
		TrasaDuty[playerid] = dz;
		DaneGracza[playerid][gTworzyWyscig] = DodajWyscig(x, y, z, DaneGracza[playerid][gTworzyWyscigCP], dz, DaneGracza[playerid][gTworzyWyscigNazwa]);
		TrasaDutyNr[playerid] = DaneGracza[playerid][gTworzyWyscig];
		new str[256];
		format(str, sizeof(str), "Tworzenie wyscigu zostalo rozpoczete. Jedz po mapie i tworz CheckPointy za pomoca spacji.~n~~n~~r~CheckPoint: ~w~%d/20~n~~n~~b~~h~Nazwa: ~n~~w~%s", DaneGracza[playerid][gTworzyWyscigCP], DaneGracza[playerid][gTworzyWyscigNazwa]);
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 60;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], str);
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		//GrupaInfo[DaneGracza[playerid][gSluzba]][gSaldo] -= 1000;
		//ZapiszSaldo(DaneGracza[playerid][gSluzba]);
		return 1;
	}
	if(dialogid == DIALOG_EDIT)
	{
	    switch(listitem)
	    {
	        case 0: dShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","ProszÍ wpisaÊ nowy kπt","Akceptuj","Zamknij");
	        case 1: dShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy zakres","Akceptuj","Zamknij");
	        case 2: dShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy limit prÍdkoúci","Akceptuj","Zamknij");
			case 6:
			{
				UsunFotoradar(GetPVarInt(playerid,"selected"));
			 	SendClientMessage(playerid,COLOR_GREEN,"Fotoradar zosta≥ usuniÍty.");
			 	DeletePVar(playerid,"selected");
			}
	    }
	    if(!response) {
		DeletePVar(playerid,"Zakres");
		DeletePVar(playerid,"Limit");
		DeletePVar(playerid,"Kara pieniÍøna");
		DeletePVar(playerid,"Dobieranie");
		return 1;
		}
	}
	if(dialogid == DIALOG_EANGLE)
	{
	    if(!strlen(inputtext)) return dShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","ProszÍ wpisaÊ nowy kπt","Akceptuj","Zamknij");
	    new id = GetPVarInt(playerid,"selected");
	    new rot = strval(inputtext);
	    rot = rot + 180;
	    if (rot > 360)
	    {
	        rot = rot - 360;
	    }
        FotoInfo[id][_rot] = rot;
        SetDynamicObjectRot(FotoInfo[id][_objectid],0,0,rot);
        ZapiszFotoradary(id);
	    SendClientMessageEx(playerid,COLOR_GREEN,"sisis","Kπt fotoradaruID ",id," zosta≥o pomyúlnie zaktualizowane do ",strval(inputtext),".");
	    if(!response) {
		DeletePVar(playerid,"Zakres");
		DeletePVar(playerid,"Limit");
		DeletePVar(playerid,"Kara pieniÍøna");
		DeletePVar(playerid,"Dobieranie");
		return 1;
		}
	}
	if(dialogid == DIALOG_ERANGE)
	{
	    if(!strlen(inputtext)) return dShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy zakres","Akceptuj","Zamknij");
	    new id = GetPVarInt(playerid,"selected");
		FotoInfo[id][_range] = strval(inputtext);
		ZapiszFotoradary(id);
	    SendClientMessageEx(playerid,COLOR_GREEN,"sisis","Zakres fotoradaruID ",id," zosta≥o pomyúlnie zaktualizowane do ",strval(inputtext),".");
	    if(!response) {
		DeletePVar(playerid,"Zakres");
		DeletePVar(playerid,"Limit");
		DeletePVar(playerid,"Kara pieniÍøna");
		DeletePVar(playerid,"Dobieranie");
		return 1;
		}
	}
	if(dialogid == DIALOG_ELIMIT)
	{
	    if(!response) {
		DeletePVar(playerid,"Zakres");
		DeletePVar(playerid,"Limit");
		DeletePVar(playerid,"Kara pieniÍøna");
		DeletePVar(playerid,"Dobieranie");
		return 1;
		}
	    if(!strlen(inputtext)) return dShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy limit prÍdkoúci","Akceptuj","Zamknij");
	    new id = GetPVarInt(playerid,"selected");
		FotoInfo[id][_limit] = strval(inputtext);
		ZapiszFotoradary(id);
	    SendClientMessageEx(playerid,COLOR_GREEN,"sisis","Limit prÍdkoúci fotoradaruID ",id," zosta≥o pomyúlnie zaktualizowane do ",strval(inputtext),".");
	}
////////////////////////////////////////////////////////////////////////////////
	if(dialogid == DIALOG_ANIM)
	{
       	if(response)
		{
			new found = 0;
			ForeachEx(i, MAX_ANIM)
			{
				if(!isnull(AnimInfo[i][CMD]))
				{
					if(!strcmp(inputtext, AnimInfo[i][CMD], true))
					{
						if(AnimInfo[i][Toggle] == 2) SetPlayerSpecialAction(playerid, AnimInfo[i][Loop]);
						else
						{
							ApplyAnimation(playerid, AnimInfo[i][Lib], AnimInfo[i][Name], AnimInfo[i][Speed], AnimInfo[i][Loop], AnimInfo[i][Lock][0], AnimInfo[i][Lock][1], AnimInfo[i][Freeze], AnimInfo[i][aTime], 1);
							SetPVarInt(playerid, "PlayAnim", 0);
							animacja[playerid] = 1;
							if(AnimInfo[i][Toggle] == 1) SetPVarInt(playerid, "PlayAnim", 1);
						}
						found++;
					}
				}
			}
			if(found == 0) PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}
	
	if(dialogid == DIALOG_ITEM_NOTES)
    {
        new uz = GetPVarInt(playerid, "UzytyItem");
        if(response)
        {
            if(strlen(inputtext)<3||strlen(inputtext)>124)
			{
                dShowPlayerDialog(playerid, DIALOG_ITEM_NOTES, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz treúÊ jaka ma zostaÊ ukazana na karteczce:\n{88b711}Od 3 do 124 znakÛw.", "Zapisz", "Anuluj");
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Karteczka znajduje siÍ w twoim ekwipunku.", "Zamknij", "");
				DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, P_KARTECZKA, 0, 0, "Karteczka", DaneGracza[playerid][gUID], 0, gettime()+(24*60*60*2), 0, 0, 0, inputtext);
				PrzedmiotInfo[uz][pWar1]--;
				if(PrzedmiotInfo[uz][pWar1] == 0)
				{
					UsunPrzedmiot(uz);
				}
				else
				{
					ZapiszPrzedmiot(uz);
				}
			}
		}
        else
        {
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_MANIPULATION_VEH)
	{
	    if(response)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new veh = SprawdzCarUID(vehicleid);
			if(listitem == 1)
			{
				if(!Wlascicielpojazdu(vehicleid, playerid))
				{
					return 0;
				}
			    new lights,doors,bonnet,boot,objective,engine,alarm;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(!lights)
				{
					SetVehicleParamsEx(vehicleid,engine,true,alarm,doors,bonnet,boot,objective);
				}
				else
				{
					SetVehicleParamsEx(vehicleid,engine,false,alarm,doors,bonnet,boot,objective);
					return 1;
				}

			}
			if(listitem == 2)
			{
				if(!Wlascicielpojazdu(vehicleid, playerid))
				{
					return 0;
				}
			    new lights,doors,bonnet,boot,objective,engine,alarm;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(!bonnet)
				{
					SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,true,boot,objective);
				}
				else
				{
					SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,false,boot,objective);
					return 1;
				}

			}
			if(listitem == 3)
			{
				if(!Wlascicielpojazdu(vehicleid, playerid))
				{
					return 0;
				}
			    new lights,doors,bonnet,boot,objective,engine,alarm;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(!boot)
				{
					SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,true,objective);
				}
				else
				{
					SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,false,objective);
					return 1;
				}

			}
			if(listitem == 4)
			{
				if(!WlascicielpojazduBezWYP(vehicleid, playerid))
				{
					return 0;
				}
				new items_list[256], item_list[256], find;
				ForeachEx(itemid, MAX_PRZEDMIOT)
				{
					if(PrzedmiotInfo[itemid][pTyp] == P_TUNING && PrzedmiotInfo[itemid][pTypWlas] == TYP_AUTO && PrzedmiotInfo[itemid][pOwner] == SprawdzCarUID(GetPlayerVehicleID(playerid)) && PrzedmiotInfo[itemid][pWar2] == 1)
					{
						format(item_list, sizeof(item_list), "%d\t%s", PrzedmiotInfo[itemid][pUID], PrzedmiotInfo[itemid][pNazwa]);
						format(items_list, sizeof(items_list), "%s\n%s", items_list, item_list);
						find++;
					}
				}
				if(find == 0) dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie {88b711}znaleziono{DEDEDE} øadnych komponentÛw.", "Zamknij", "");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", items_list, "Zamknij", "");
			}
			/*if(listitem == 5)
			{
				if(!GraczPremium(playerid))
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta funkcja wymaga {FFFF00}Konta Premium.", "Zamknij", "");
					return 1;
				}
				if(PojazdInfo[veh][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[veh][pOwnerDzialalnosc] == 0 || WlascicielGrupyOwner(veh, playerid))
				{
					dShowPlayerDialog(playerid, DIALOG_REJESTR_UNIK, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Tablice rejestracyjne{88b711}:","{DEDEDE}Wpisz nazwÍ {88b711}unikalnej{DEDEDE} tablicy rejestracyjnej.", "Dalej", "Zamknij" );
				}else{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten {88b711}pojazd{DEDEDE} nie naleøy do ciebie - bπdz nie jesteú {88b711}ownerem{DEDEDE}  grupy do ktÛrej naleøy pojazd.", "Zamknij", "");
				}
			}*/
			if(listitem == 5)
			{
				if(!WlascicielpojazduBezWYP(vehicleid, playerid))
				{
					return 0;
				}
				if(PojazdInfo[veh][pAukcja] != 0)
				{
					GameTextForPlayer(playerid, "~r~Ten pojazd jest wystawiony na aukcji.", 3000, 5);
					return 0;
				}
				POD_DZIALALNOSC(playerid, DIALOG_PODPISZ_VEH);
			}
			if(listitem == 6)
			{
				if(!Wlascicielpojazdu(vehicleid, playerid))
				{
					return 0;
				}
				if(PojazdInfo[veh][pSzyba] == 0)
				{
					PojazdInfo[veh][pSzyba] = 1;
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Zamknales szyby w pojezdzie od teraz tylko krzyk bedzie slyszany po za autem.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				else
				{
					PojazdInfo[veh][pSzyba] = 0;
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Otworzyles szyby w pojezdzie od teraz wszystko co powiesz bedzie slychac poza autem.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				ZapiszPojazd(veh, 1);
			}
			if(listitem == 7)
			{
				if(!Wlascicielpojazdu(vehicleid, playerid))
				{
					return 0;
				}
				if(PojazdInfo[veh][pGaz] == 0)
				{
					return 0;
				}
				if(PojazdInfo[veh][pGaz] == 1)
				{
					PojazdInfo[veh][pGaz] = 2;
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Przelaczyles spalanie na gaz.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				else
				{
					PojazdInfo[veh][pGaz] = 1;
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Przelaczyles spalanie na benzyne.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				ZapiszPojazd(veh, 1);
			}
		}
	    return 1;
	}
	if(dialogid == DIALOG_INFO_BP)
	{
	    if(!response)
	    {
	        Kick(playerid);
			return 0;
	    }
	    dShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Panel Logowania{88b711}:", "{DEDEDE}W poniøsze pole wprowadz {88b711}nowy{DEDEDE} nick, po \nczym zatwierdz przyciskiem '{88b711}ZmieÒ{DEDEDE}'.", "ZmieÒ", "WrÛÊ");
	    return 1;
	}
	if(dialogid == DIALOG_NICK)
	{
		if(response)
	    {
    	    if(strfind(inputtext, "_", true) <= 0)
		    {
			    GameTextForPlayer(playerid, "~n~~n~~n~~n~~r~Niepoprawny nick.~n~~w~Nick postaci nie zostal zmieniony", 2000, 5);
				dShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Panel Logowania{88b711}:", "{DEDEDE}W poniøsze pole wprowadz {88b711}nowy{DEDEDE} nick, po \nczym zatwierdz przyciskiem '{88b711}ZmieÒ{DEDEDE}'.", "ZmieÒ", "WrÛÊ");
				return 1;
			}
			if(strlen(inputtext) == 0)
			{
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~r~Niepoprawny nick.~n~~w~Nick postaci nie zostal zmieniony", 2000, 5);
				dShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Panel Logowania{88b711}:", "{DEDEDE}W poniøsze pole wprowadz {88b711}nowy{DEDEDE} nick, po \nczym zatwierdz przyciskiem '{88b711}ZmieÒ{DEDEDE}'.", "ZmieÒ", "WrÛÊ");
			}
			else
			{
				strtolower(inputtext);
				new imien[50], nazwisko[50], tekst_global1[50];
				sscanf(inputtext, "p<_>s[50]s[50]",imien,nazwisko);
				imien[0] = toupper(imien[0]);
				nazwisko[0] = toupper(nazwisko[0]);
				format(tekst_global1, sizeof(tekst_global1), "%s_%s", imien,nazwisko);
				SetPlayerName(playerid, tekst_global1);
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~y~Nick postaci zostal zmieniony", 2000, 5);
				OnPlayerDisconnect(playerid, -1);
				OnPlayerConnect(playerid);
   			}
		}
        else
		{
        	OnPlayerDisconnect(playerid, -1);
			OnPlayerConnect(playerid);
		}
	}
	if( dialogid == DIALOG_REJESTR_UNIK )
	{
		if( !response )
		    return 1;
        new vehicleid = GetPlayerVehicleID(playerid);
		new indexveh = SprawdzCarUID(vehicleid);
		if( !strlen( inputtext ) || strlen( inputtext ) > 10 )
		    return dShowPlayerDialog(playerid, DIALOG_REJESTR_UNIK, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Tablica rejestracyjna{88b711}:","{DEDEDE}Wpisz nazwÍ {88b711}unikalnej{DEDEDE} tablicy rejestracyjnej.\n{ff0000}Maxymalnie {88b711}1-10{DEDEDE} znakÛw.", "Dalej", "Zamknij" );
        A_KOL(inputtext);
        A_KOLS(inputtext);
		SetVehicleNumberPlate(vehicleid, inputtext);
		strmid(PojazdInfo[indexveh][pTablice], inputtext, 0, 64, 64);
		ZapiszPojazd(indexveh, 1);
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Tablica rejestracyjna{88b711}:", "{DEDEDE}Aby wprowadziÊ {88b711}zmiany{DEDEDE} w pojezdzie zaleca siÍ unspawn i spawn pojazdu.", "Zatwierdz", "Zamknij" );
	}
	if(dialogid == DIALOG_LOGIN)
	{
		if(response)
		{
           	if(strlen(inputtext) > 32)
			{
				new str2[256];
    			format(str2, sizeof(str2), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerÛw Role Play!\n\n{DEDEDE}PrÛbujesz zalogowaÊ siÍ na PostaÊ:{88B711} %s\n{DEDEDE}Wpisz swoje has≥o(Globalne) i kliknij ''Zaloguj'' aby sie zalogowaÊ!",ImieGracza2(playerid));
				dShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Panel Logowania{88b711}:", str2, "Zaloguj", "Wyjdz");
			}
			else
			{
                new sql3[200];
				format(sql3, sizeof(sql3), "SELECT `password`, `salt`, `premium`, `ooc`, `run`, `ban`, `veh`, `gun`, `username`, `GAMESCORE`, `usergroup`, `POZIOM_ADMINISTRACJI`, `klatwa`, `SLUZBA` FROM `five_users` WHERE `uid` = '%d'", DaneGracza[playerid][gGUID]);
				mysql_query(sql3);
				mysql_store_result();
				mysql_fetch_row(sql3);
				sscanf(sql3, "p<|>s[124]s[124]dddddds[124]ddddd", DaneGracza[playerid][gHASLO]
                    ,DaneGracza[playerid][gSALT]
                    ,DaneGracza[playerid][gPREMIUM]
                    ,DaneGracza[playerid][gOOC]
                    ,DaneGracza[playerid][gRUN]
                    ,DaneGracza[playerid][gBAN]
                    ,DaneGracza[playerid][gVEH]
                    ,DaneGracza[playerid][gGUN]
					,DaneGracza[playerid][nickOOC]
					,DaneGracza[playerid][gGAMESCORE]
					,DaneGracza[playerid][gAdmGroup]
					,DaneGracza[playerid][gAdmLVL]
					,DaneGracza[playerid][gKLATWA]
					,DaneGracza[playerid][gSLUZBAA]
				);
				if(DaneGracza[playerid][gAdmGroup] == 16)
				{
					DaneGracza[playerid][gAdmGroup] = 11;
				}
                new hassh[150];
          		format(hassh, sizeof(hassh), "%s%s", MD5_Hash(DaneGracza[playerid][gSALT]), MD5_Hash(inputtext));
		  		Logowanie(playerid, hassh);
			}
			return 1;
		}
		else
		{
           	dShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Panel Logowania{88b711}:", "{DEDEDE}W poniøsze pole wprowadz nowy nick, po \nczym zatwierdz przyciskiem 'ZmieÒ'.", "ZmieÒ", "WrÛÊ");
		}
		return 1;
	}
	if(dialogid == DIALOG_PODPISZ_VEH)
	{
	    if(response)
		{
		    new vehicleid = GetPlayerVehicleID(playerid);
			new veh = SprawdzCarUID(vehicleid);
  			if(PojazdInfo[veh][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[veh][pOwnerDzialalnosc] == 0)
  			{
			    new uid = strval(inputtext);
			    SetPVarInt(playerid, "PodpisanieAuta", uid);
				dShowPlayerDialog(playerid, DIALOG_PODPISZ_VEH_ACC, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy na pewno chcesz {88b711}podpisaÊ{DEDEDE} pojazd pod dzia≥alnoúÊ?\nPamiÍtaj jeúli zatwierdzisz nie bÍdzie {88b711}odwrotu{DEDEDE} - auta juø nie bÍdziesz mÛg≥ odpisaÊ.", "Tak", "Nie");
			}else{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}uprawnieÒ{DEDEDE} do podpisania tego auta pod dzia≥alnoúÊ gospodarczπ.", "Zamknij", "");
			}
		}
		else return 1;
	}
	if(dialogid == DIALOG_PODPISZ_VEH_ACC)
	{
	    if(response)
		{
		    new uid = GetPVarInt(playerid, "PodpisanieAuta");
		    new vehicleid = GetPlayerVehicleID(playerid);
			new veh = SprawdzCarUID(vehicleid);
			if(uid == 1)
			{
		    PojazdInfo[veh][pOwnerPostac] = 0;
			PojazdInfo[veh][pOwnerDzialalnosc] = DaneGracza[playerid][gDzialalnosc1];
			}
			else if(uid == 2)
			{
			PojazdInfo[veh][pOwnerPostac] = 0;
			PojazdInfo[veh][pOwnerDzialalnosc] = DaneGracza[playerid][gDzialalnosc2];
			}
			else if(uid == 3)
			{
            PojazdInfo[veh][pOwnerPostac] = 0;
			PojazdInfo[veh][pOwnerDzialalnosc] = DaneGracza[playerid][gDzialalnosc3];
			}
			else if(uid == 4)
			{
            PojazdInfo[veh][pOwnerPostac] = 0;
			PojazdInfo[veh][pOwnerDzialalnosc] = DaneGracza[playerid][gDzialalnosc4];
			}
			else if(uid == 5)
			{
            PojazdInfo[veh][pOwnerPostac] = 0;
			PojazdInfo[veh][pOwnerDzialalnosc] = DaneGracza[playerid][gDzialalnosc5];
			}
			else if(uid == 6)
			{
            PojazdInfo[veh][pOwnerPostac] = 0;
			PojazdInfo[veh][pOwnerDzialalnosc] = DaneGracza[playerid][gDzialalnosc6];
			}
			ZapiszPojazd(veh, 2);
			DeletePVar(playerid,"PodpisanieAuta");
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd zosta≥ prawid≥owo {88b711}przypisany{DEDEDE} do dzia≥alnoúci.", "Zamknij", "");
		}
		else
		{
		
		}
		return 1;
	}
	if(dialogid == DIALOG_VEH_SPAWN)
	{
	    if(response)
		{
			if(spawns[playerid] >= 2)
			{
				dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:" ,"{DEDEDE}Nie posiadasz {88b711}konta premium{DEDEDE} aby zespawnowaÊ wiÍcej pojazdÛw.", "Zamknij", "" );
				return 0;
			}
		    new uid = strval(inputtext);
		    StworzPojazd(uid, playerid);
		}
		else return 1;
	}
	if(dialogid == DIALOG_VEH_SPAWN_DZ)
	{
		new uid = strval(inputtext);
		if(response)
		{
			if(PojazdInfo[uid][pSpawn] != 0)
			{
				new siedzi = -1;
				for(new is=0; is< IloscGraczy; is++)
				{
					if(GetPlayerVehicleID(KtoJestOnline[is]) == PojazdInfo[uid][pID])
					{
						siedzi = KtoJestOnline[is];
						break;
					}
				}
				if(siedzi != -1)
				{
					strdel(tekst_globals, 0, 2048);
					format(tekst_globals, sizeof(tekst_globals), "~r~W tym pojezdzie znajduje sie: ~y~%s (Id: %d)", ZmianaNicku(siedzi), siedzi);
					GameTextForPlayer(playerid, tekst_globals, 3000, 5);
				}
				else
				{
					StworzPojazd(uid, playerid);
				}
			}
			else
			{
				StworzPojazd(uid, playerid);
			}
		}
		else
		{
			SetPVarInt(playerid, "OPCJAPOJAZDY", uid);
			dShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Pojazdy {88b711}ª {FFFFFF}Opcje{88b711}:", "1.\t{DEDEDE}ª {88b711}Namierz\n2.\t{DEDEDE}ª {88b711}Zresetuj na spawnpoint\n3.\t{DEDEDE}ª {88b711}Skasuj ca≥kowicie\n4.\t{DEDEDE}ª {88b711}Odpisz", "Wybierz", "Zamknij");
		}
	}
	if(dialogid == DIALOG_PALIWKO)
	{
	    if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new vehicleid=GetPlayerVehicleID(playerid);
					new uid = SprawdzCarUID(vehicleid);
					PojazdInfo[uid][pTypPaliwa] = 1;
					ZapiszPojazd(uid, 1);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Rodzaj paliwa twojego {88b711}pojazdu{DEDEDE} zosta≥ zmieniony na diesel.", "Zamknij", "");
				}
				case 1:
				{
					new vehicleid=GetPlayerVehicleID(playerid);
					new uid = SprawdzCarUID(vehicleid);
					PojazdInfo[uid][pTypPaliwa] = 2;
					ZapiszPojazd(uid, 1);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Rodzaj paliwa twojego {88b711}pojazdu{DEDEDE} zosta≥ zmieniony na benzyne.", "Zamknij", "");
				}
			}
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
		}
		return 1;
	}
	if(dialogid == DIALOG_VEH_NAMIERZ)
	{
	    if(response)
		{
		    new uid = strval(inputtext);
		    new Float:X, Float:Y, Float:Z;
		    GetVehiclePos(PojazdInfo[uid][pID], X, Y, Z);
		    SetPlayerCheckpoint(playerid, X, Y, Z, 5.0);
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazd {88b711}:", "{DEDEDE}Pojazd zosta≥ namierzony. Wpisz {88b711}komendÍ{DEDEDE} ponownie, aby {88b711}wy≥πczyÊ{DEDEDE} radar!", "Zamknij", "");
		}
		return 1;
	}
	if(dialogid == DIALOG_GZ)
	{
		if( !response ) return 1;
    	switch(listitem)
    	{
			case 0:
    	    {
       			dShowPlayerDialog(playerid, DIALOG_GZ_D, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "Podaj nazwe terenu:", "Dalej", "Zamknij");
			}
			case 1:
    	    {
       			DaneGracza[playerid][gTeren] = GraczNaTerenie(playerid);
				GangZonePL[playerid] = true;
			}	
		}
		return 1;
	}
	if(dialogid == DIALOG_GZ_D)
	{
		if( !response ) return 1;
    	if(strlen(inputtext) < 3)
		{
			dShowPlayerDialog(playerid, DIALOG_GZ_D, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "Podaj nazwe terenu:", "Dalej", "Zamknij");
			return 0;
		}
		new Float:AX, Float:AY, Float:AZ;
		GetPlayerPos(playerid, AX, AY, AZ);
		DaneGracza[playerid][gTeren] = DodajTeren(AX, AY, inputtext);
		GangZonePL[playerid] = true;
		return 1;
	}
	if(dialogid == DIALOG_LEK)
	{
	    new idGracza = strval(inputtext);
        new nr = GetPVarInt(playerid, "Lek");
		UstawHP(idGracza,15);
		Frezuj(idGracza, true);
		ClearAnimations(idGracza);
		ApplyAnimation(idGracza, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
		SetCameraBehindPlayer(idGracza);
		DaneGracza[idGracza][gBW] = 0;
		if(DaneGracza[idGracza][gGlod] <= 20)
		{
			DaneGracza[idGracza][gGlod] = 20;
			SetProgressBarValue(PasekGlodu[idGracza], DaneGracza[idGracza][gGlod]);
			ShowProgressBarForPlayer(idGracza, PasekGlodu[idGracza]);
		}
		Uderzony(idGracza, 0x8fef55FF);
        UsunPrzedmiot(nr);
		new str[256];
		format(str, sizeof(str), "aplikuje lek %s.", ZmianaNicku(idGracza));
        cmd_fasdasfdfive(playerid, str);
		ZapiszGracza(idGracza);
	}
	if(dialogid == DIALOG_KONTAKT_ZAPROS)
	{
		if( !response ) return 0;
	    new idGracza = strval(inputtext);
        Oferuj(playerid, idGracza, 0, 0, 0, 0, OFEROWANIE_KONTAKT, 0,"", 0);
	}
	if(dialogid == DIALOG_WEZ_PACZKE)
	{
		if( !response ) return 0;
		new uid = strval(inputtext);\
		if(PaczkaInfo[uid][xZAJETY] != 0)
		{
			new id_gr = -1;
			ForeachEx(playerida, IloscGraczy)
			{
				if(IsPlayerConnected(KtoJestOnline[playerida]) && DaneGracza[KtoJestOnline[playerida]][gUID] == PaczkaInfo[uid][xZAJETY])
				{
					id_gr = KtoJestOnline[playerida];
					break;
				}
			}
			new budka_lista[256];
			strdel(budka_lista, 0, 256);
			if(id_gr != -1) 
			{
				format(budka_lista, sizeof(budka_lista), "{DEDEDE}Ta paczka jest dostarczana przez: {88b711}%s{DEDEDE}.", ZmianaNicku(id_gr));
			}
			else 
			{
				format(budka_lista, sizeof(budka_lista), "{DEDEDE}Ta paczka jest dostarczana przez: {88b711}Brak gracza{DEDEDE}.");
				PaczkaInfo[uid][xZAJETY] = 0;
			}
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", budka_lista, "Zamknij", "");	
		}
		else
		{
			DaneGracza[playerid][gPaczkaUID] = uid;
			PaczkaInfo[uid][xZAJETY] = DaneGracza[playerid][gUID];
			DaneGracza[playerid][gPaczkaM] = 1;
			strdel(tekst_global, 0, 2048);
			format(tekst_global, sizeof(tekst_global), "~w~Numer paczki: ~r~%d~n~~w~Adresat: ~r~%s~n~~n~~w~Miejsce dostarczenia:~n~~w~%s",PaczkaInfo[uid][xUID],PaczkaInfo[uid][xNICK], NieruchomoscInfo[PaczkaInfo[uid][xMIEJSCED]][nAdres]);
			TextDrawSetString(OBJ[playerid], tekst_global);
			TextDrawShowForPlayer(playerid, OBJ[playerid]);
			new id = PaczkaInfo[uid][xHURT];
			SetPlayerCheckpoint(playerid, NieruchomoscInfo[id][nX], NieruchomoscInfo[id][nY], NieruchomoscInfo[id][nZ], 5.0);
		}
	}
	if(dialogid == DIALOG_PRACA)
	{
		if( !response ) return 0;
		switch(listitem)
		{
			case 0: 
			{
				DaneGracza[playerid][gPracaTyp] = PRACA_WEDKARZ;
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje przyjπ≥eú prace {88b711}wÍdkarza{DEDEDE}.\nAby rozpoczπÊ prace udaj siÍ na Molo z Ko≥em.", "Zamknij", "");	
			}
			case 1: 
			{
				DaneGracza[playerid][gPracaTyp] = PRACA_TANKER;
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje przyjπ≥eú prace {88b711}pomocnika na stacji benzynowej{DEDEDE}.\nAby rozpoczπÊ prace udaj siÍ na pobliskπ stacje.", "Zamknij", "");	
			}
			case 2: 
			{
				DaneGracza[playerid][gPracaTyp] = PRACA_ZAMIATACZ;
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje przyjπ≥eú prace {88b711}sprzπtacza ulic{DEDEDE}.\nAby rozpoczπÊ prace udaj siÍ do pojazdu Sweeper.", "Zamknij", "");	
			}
			case 3: 
			{
				DaneGracza[playerid][gPracaTyp] = PRACA_KURIER;
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje przyjπ≥eú prace {88b711}kuriera{DEDEDE}.\nAby rozpoczπÊ prace wpisz /paczka.", "Zamknij", "");	
			}
		}
		ZapiszGracza(playerid);
		return 1;
	}
	if(dialogid == DIALOG_TELEFON)
	{
		if( !response ) return 0;
		switch(listitem)
		{
			case 0: 
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					if(DaneGracza[playerid][gTelefon] != 0)
					{
						GameTextForPlayer(playerid, "~r~Masz juz aktywny jeden telefon.", 3000, 5);
						return 0;
					}
					DaneGracza[playerid][gTelefon] = 4456781+PrzedmiotInfo[id_przedmiotu][pUID];
					PrzedmiotInfo[id_przedmiotu][pUzywany] = 1;
					ZapiszGracza(playerid);
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Aktywowales swoj telefon.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				else
				{
					if(Dzwoni[playerid] != 0)
					{
						GameTextForPlayer(playerid, "~r~Aktualnie wykonujesz polaczenie.", 3000, 5);
						return 0;
					}
					DaneGracza[playerid][gTelefon] = 0;
					PrzedmiotInfo[id_przedmiotu][pUzywany] = 0;
					ZapiszGracza(playerid);
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Wylaczyles swoj telefon.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				ZapiszPrzedmiot(id_przedmiotu);
			}
			case 1:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				new find = 0, budka_lista[512];
				ForeachEx(i, MAX_GROUP)
				{
					if(GrupaInfo[i][gUID] != 0)
					{
						if(GrupaInfo[i][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[i][gTyp] == DZIALALNOSC_SANNEWS || GrupaInfo[i][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[i][gTyp] == DZIALALNOSC_RZADOWA)
							{
							new findduty = 0;
							ForeachEx(playeridg, IloscGraczy)
							{
								if(DaneGracza[KtoJestOnline[playeridg]][gSluzba] == GrupaInfo[i][gUID])
								{
									findduty++;
								}
							}
							if(findduty != 0)
							{
								format(budka_lista, sizeof(budka_lista), "%s\n%d\t{DEDEDE}ª  {88b711}%s {DEDEDE}(Osoby na s≥uøbie: %d)", budka_lista, GrupaInfo[i][gUID], GrupaInfo[i][gNazwa], findduty);
								find++;
							}
						}
					}
				}
				if(find != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_TELEFON_SL, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", budka_lista, "Wybierz", "Zamknij");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", "{DEDEDE}Aktualnie nie ma s≥uøb {88b711}porzπdkowych{DEDEDE} na s≥uøbie.", "Zamknij", "");
				}
			}
			case 2:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				new find = 0, budka_lista[1024];
				ForeachEx(i, MAX_GROUP)
				{
					if(GrupaInfo[i][gUID] != 0)
					{
						if(GrupaInfo[i][gTyp] != DZIALALNOSC_SANNEWS && GrupaInfo[i][gTyp] != DZIALALNOSC_POLICYJNA && GrupaInfo[i][gTyp] != DZIALALNOSC_ZMOTORYZOWANA && GrupaInfo[i][gTyp] != DZIALALNOSC_MAFIE && GrupaInfo[i][gTyp] != DZIALALNOSC_RODZINKA && GrupaInfo[i][gTyp] != DZIALALNOSC_MEDYCZNA && GrupaInfo[i][gTyp] != DZIALALNOSC_GANGI && GrupaInfo[i][gTyp] != DZIALALNOSC_RZADOWA)
						{
							new findduty = 0;
							ForeachEx(playeridg, IloscGraczy)
							{
								if(DaneGracza[KtoJestOnline[playeridg]][gSluzba] == GrupaInfo[i][gUID])
								{
									findduty++;
								}
							}
							if(findduty != 0)
							{
								format(budka_lista, sizeof(budka_lista), "%s\n%d\t{DEDEDE}ª  {88b711}%s {DEDEDE}(Osoby na s≥uøbie: %d)", budka_lista, GrupaInfo[i][gUID], GrupaInfo[i][gNazwa], findduty);
								find++;
							}
						}
					}
				}
				if(find != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_TELEFON_SL, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", budka_lista, "Wybierz", "Zamknij");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", "{DEDEDE}Aktualnie nie ma øadnych {88b711}dzia≥alnoúci{DEDEDE} na s≥uøbie.", "Wybierz", "Zamknij");
				}
			}
			case 3:
			{
				new dol[1024];
				strdel(dol, 0, 1024);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Policyjna", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Zmotoryzowana", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Mechaniczna", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia 27/7", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Elektryczna", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Gastronomiczna", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Mafi/Szajek", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Medyczna", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Gangowa", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia Felg", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia SpoilerÛw", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia WydechÛw", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia ProgÛw", dol);
				format(dol, sizeof(dol), "%s\n{DEDEDE}ª  {88B711}Hurtownia ZderzakÛw", dol);
				dShowPlayerDialog(playerid, DIALOG_ZAMOW_PACZKE, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", dol, "Wybierz", "Zamknij");
			}
			case 4:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				if(Dzwoni[playerid] != 0)
				{
					GameTextForPlayer(playerid, "~r~Aktualnie wykonujesz juz polaczenie.", 3000, 5);
					return 0;
				}
				dShowPlayerDialog(playerid, DIALOG_TELEFON_DZWON_KAL, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}numer{DEDEDE}, do ktÛrego chcesz siÍ dodzwoniÊ.", "ZadzwoÒ", "Zamknij");
			}
			case 5:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				dShowPlayerDialog(playerid, DIALOG_TELEFON_SMS_KAL, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}numer{DEDEDE}, do ktÛrego chcesz wys≥aÊ wiadomoúÊ.", "Zatwierdz", "Zamknij");
			}
			case 6:
			{
				if(Dzwoni[playerid] != 0)
				{
					GameTextForPlayer(playerid, "~r~Aktualnie wykonujesz juz polaczenie.", 3000, 5);
					return 0;
				}
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				new find = 0, budka_lista[1024];
				ForeachEx(i, MAX_KONTAKTOW)
				{
					if(Kontakt[i][kPrzedmiot] == id_przedmiotu)
					{
						format(budka_lista, sizeof(budka_lista), "%s\n%d\t%d\t%s", budka_lista, Kontakt[i][kUID], Kontakt[i][kNumer], Kontakt[i][kNazwa]);
						find++;
					}
				}
				if(find != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_TELEFON_DZWON_K, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", budka_lista, "Wybierz", "Zamknij");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", "{DEDEDE}Nie masz zapisanych øadnych kontaktÛw.", "Zamknij", "");
				}
			}
			case 7:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				new find = 0, budka_lista[1024];
				ForeachEx(i, MAX_KONTAKTOW)
				{
					if(Kontakt[i][kPrzedmiot] == id_przedmiotu)
					{
						format(budka_lista, sizeof(budka_lista), "%s\n%d\t%d\t%s", budka_lista, Kontakt[i][kUID], Kontakt[i][kNumer], Kontakt[i][kNazwa]);
						find++;
					}
				}
				if(find != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_TELEFON_SMS_K, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", budka_lista, "Wybierz", "Zamknij");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", "{DEDEDE}Nie masz zapisanych øadnych kontaktÛw.", "Zamknij", "");
				}
			}
			case 8:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				new find = 0, budka_lista[1024];
				ForeachEx(i, MAX_KONTAKTOW)
				{
					if(Kontakt[i][kPrzedmiot] == id_przedmiotu)
					{
						format(budka_lista, sizeof(budka_lista), "%s\n%d\t%d\t%s", budka_lista, Kontakt[i][kUID], Kontakt[i][kNumer], Kontakt[i][kNazwa]);
						find++;
					}
				}
				if(find != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_TELEFON_USUN, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", budka_lista, "UsuÒ", "Zamknij");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Telefon{88b711}:", "{DEDEDE}Nie masz zapisanych øadnych kontaktÛw.", "Zamknij", "");
				}
			}
			case 9:
			{
				new id_przedmiotu = GetPVarInt( playerid, "UzytyItem");
				if(PrzedmiotInfo[id_przedmiotu][pUzywany] == 0)
				{
					GameTextForPlayer(playerid, "~r~Ten telefon jest wylaczony.", 3000, 5);
					return 0;
				}
				new found = 0;
				strdel(tekst_global, 0, 2048);
				ForeachEx(i, IloscGraczy)
				{
					if(PlayerObokPlayera(playerid, KtoJestOnline[i], 15) && KtoJestOnline[i] != playerid && zalogowany[KtoJestOnline[i]] == true && DaneGracza[KtoJestOnline[i]][gTelefon] != 0)
					{
						format(tekst_global, sizeof(tekst_global), "%s\n%d\t%s", tekst_global, KtoJestOnline[i], ZmianaNicku(KtoJestOnline[i]));
						found++;
					}
				}
				if(found != 0) dShowPlayerDialog(playerid, DIALOG_KONTAKT_ZAPROS, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", tekst_global, "Zaproú", "Zamknij");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz siÍ obok {88b711}gracza{DEDEDE}, bπdz ta osoba nie ma w≥πczonego telefonu.", "Zamknij", "");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_ZAMOW_PACZKE)
	{
		if(!response)
		{
			return 1;
		}
		switch( listitem )
		{
			case 0:
			{
				Hurtownia(playerid, 5, DZIALALNOSC_POLICYJNA, 17, GetPlayerVirtualWorld(playerid));
			}
			case 1:
			{
				Hurtownia(playerid, 13, DZIALALNOSC_ZMOTORYZOWANA, 66, GetPlayerVirtualWorld(playerid));
			}
			case 2:
			{
				Hurtownia(playerid, 3, DZIALALNOSC_WARSZTAT, 6, GetPlayerVirtualWorld(playerid));
			}
			case 3:
			{
				Hurtownia(playerid, 6, DZIALALNOSC_247, 18, GetPlayerVirtualWorld(playerid));
			}
			case 4:
			{
				Hurtownia(playerid, 7, DZIALALNOSC_ELEKTRTYKA, 20, GetPlayerVirtualWorld(playerid));
			}
			case 5:
			{
				Hurtownia(playerid, 8, DZIALALNOSC_GASTRONOMIA, 36, GetPlayerVirtualWorld(playerid));
			}
			case 6:
			{
				Hurtownia(playerid, 14, DZIALALNOSC_MAFIE, 67, GetPlayerVirtualWorld(playerid));
			}
			case 7:
			{
				Hurtownia(playerid, 12, DZIALALNOSC_MEDYCZNA, 41, GetPlayerVirtualWorld(playerid));
			}
			case 8:
			{
				Hurtownia(playerid, 9, DZIALALNOSC_GANGI, 10, GetPlayerVirtualWorld(playerid));
			}
			case 9:
			{
				Hurtownia(playerid, 21, DZIALALNOSC_ZMOTORYZOWANA, 10, GetPlayerVirtualWorld(playerid));
			}
			case 10:
			{
				Hurtownia(playerid, 22, DZIALALNOSC_ZMOTORYZOWANA, 10, GetPlayerVirtualWorld(playerid));
			}
			case 11:
			{
				Hurtownia(playerid, 23, DZIALALNOSC_ZMOTORYZOWANA, 10, GetPlayerVirtualWorld(playerid));
			}
			case 12:
			{
				Hurtownia(playerid, 24, DZIALALNOSC_ZMOTORYZOWANA, 10, GetPlayerVirtualWorld(playerid));
			}
			case 13:
			{
				Hurtownia(playerid, 25, DZIALALNOSC_ZMOTORYZOWANA, 10, GetPlayerVirtualWorld(playerid));
			}
		}
	}
	if(dialogid == DIALOG_TELEFON_DZWON_K)
	{
		if(!response)
		{
		
		}
		else
		{
			new a = 0;
			new uid = strval(inputtext);
			ForeachEx(id, IloscGraczy)
			{
				if(DaneGracza[KtoJestOnline[id]][gTelefon] == Kontakt[uid][kNumer] && zalogowany[KtoJestOnline[id]] == true)
				{
					if(Dzwoni[KtoJestOnline[id]] == 1)
					{
						new strsa[256];
						format(strsa, sizeof(strsa), "{ff6600}** S≥ychaÊ sygna≥ zajÍtoúci.");
						SendClientMessage(playerid, 0xFFb00000, strsa);
						a++;
						break;
					}
					else
					{
						new strs[256];
						format(strs, sizeof(strs), "{ff6600}** Oczekujπce po≥aczenie od numeru {DEDEDE}%d{ff6600}.", DaneGracza[playerid][gTelefon]);
						SendClientMessage(KtoJestOnline[id], 0xFFb00000, strs);
						Dzwoni[KtoJestOnline[id]] = -1;
						DzwoniID[KtoJestOnline[id]] = playerid;
						DzwoniID[playerid] = KtoJestOnline[id];
						Dzwoni[playerid] = 1;
						dzwon[playerid] = SetTimerEx("Dzwonie", 10000, 0, "i", playerid);
						new strsa[256];
						format(strsa, sizeof(strsa), "{ff6600}** Dzwonisz pod numer {DEDEDE}%d{ff6600}.", DaneGracza[KtoJestOnline[id]][gTelefon]);
						SendClientMessage(playerid, 0xFFb00000, strsa);
						a++;
						break;
					}
				}
			}
			if(a == 0)
			{
				new strsa[256];
				format(strsa, sizeof(strsa), "{ff6600}** Brak sygna≥u.");
				SendClientMessage(playerid, 0xFFb00000, strsa);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_USUN)
	{
		if(!response)
		{
		
		}
		else
		{
			new uid = strval(inputtext);
			UsunKontakt(uid);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Kontat zosta≥ usuniÍty z listy.", "Zamknij", "");
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_DZWON_KAL)
	{
		if(!response)
		{
		
		}
		else
		{
			if(strval(inputtext) > 4456781)
			{	
				new a = 0;
				new uid = strval(inputtext);
				ForeachEx(id, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[id]][gTelefon] == uid && zalogowany[KtoJestOnline[id]] == true)
					{
						if(Dzwoni[KtoJestOnline[id]] == 1)
						{
							new strsa[256];
							format(strsa, sizeof(strsa), "{ff6600}** S≥ychaÊ sygna≥ zajÍtoúci.");
							SendClientMessage(playerid, 0xFFb00000, strsa);
							a++;
							break;
						}
						else
						{
							new strs[256];
							format(strs, sizeof(strs), "{ff6600}** Oczekujπce po≥aczenie od numeru {DEDEDE}%d{ff6600}.", DaneGracza[playerid][gTelefon]);
							SendClientMessage(KtoJestOnline[id], 0xFFb00000, strs);
							Dzwoni[KtoJestOnline[id]] = -1;
							DzwoniID[KtoJestOnline[id]] = playerid;
							DzwoniID[playerid] = KtoJestOnline[id];
							Dzwoni[playerid] = 1;
							dzwon[playerid] = SetTimerEx("Dzwonie", 10000, 0, "i", playerid);
							new strsa[256];
							format(strsa, sizeof(strsa), "{ff6600}** Dzwonisz pod numer {DEDEDE}%d{ff6600}.", DaneGracza[KtoJestOnline[id]][gTelefon]);
							SendClientMessage(playerid, 0xFFb00000, strsa);
							a++;
							break;
						}
					}
				}
				if(a == 0)
				{
					new strsa[256];
					format(strsa, sizeof(strsa), "{ff6600}** Brak sygna≥u.");
					SendClientMessage(playerid, 0xFFb00000, strsa);
				}
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podany numer jest nieprawid≥owy.", "Zamknij", "");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_SMS_KAL)
	{
		if(!response)
		{
		
		}
		else
		{
			if(strval(inputtext) > 4456781)
			{
				SetPVarInt(playerid, "uidgra", strval(inputtext));
				new ids = GetPVarInt(playerid, "uidgra");
				SetPVarInt(playerid, "uidnumere", ids);
				dShowPlayerDialog(playerid, DIALOG_TELEFON_SMS_KL, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} sms'a nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podany numer jest nieprawid≥owy.", "Zamknij", "");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_SMS_K)
	{
		if(!response)
		{
		
		}
		else
		{
			SetPVarInt(playerid, "uidgra", strval(inputtext));
			new ids = GetPVarInt(playerid, "uidgra");
			SetPVarInt(playerid, "uidnumere", Kontakt[ids][kNumer]);
			dShowPlayerDialog(playerid, DIALOG_TELEFON_SMS_KL, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} sms'a nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_SMS_K)
	{
		if(!response)
		{
		
		}
		else
		{
			SetPVarInt(playerid, "uidgra", strval(inputtext));
			new ids = GetPVarInt(playerid, "uidgra");
			SetPVarInt(playerid, "uidnumere", Kontakt[ids][kNumer]);
			dShowPlayerDialog(playerid, DIALOG_TELEFON_SMS_KL, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} sms'a nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_SMS_KL)
	{
		if(!response)
		{
		
		}
		else
		{
			new ids = GetPVarInt(playerid, "uidnumere"), a = 0;
			ForeachEx(i, IloscGraczy)
			{
				if(DaneGracza[KtoJestOnline[i]][gTelefon] == ids)
				{
					new strs[256];
					format(strs, sizeof(strs), "{ff6600}** SMS od numeru {DEDEDE}%d{ff6600}.", DaneGracza[playerid][gTelefon]);
					SendClientMessage(KtoJestOnline[i], 0xFFb00000, strs);
					new strss[256];
					format(strss, sizeof(strss), "{ff6600}WiadomoúÊ: {DEDEDE}%s{ff6600}.",inputtext);
					SendClientMessage(KtoJestOnline[i], 0xFFb00000, strss);
					cmd_do(KtoJestOnline[i], "Otrzyma≥ wiadomoúÊ SMS");
					new strsa[256];
					format(strsa, sizeof(strsa), "{ff6600}** Wys≥a≥eú SMS pod numer {DEDEDE}%d{ff6600}.", DaneGracza[i][gTelefon]);
					SendClientMessage(playerid, 0xFFb00000, strsa);
					new strssa[256];
					format(strssa, sizeof(strssa), "{ff6600}WiadomoúÊ: {DEDEDE}%s{ff6600}.",inputtext);
					SendClientMessage(playerid, 0xFFb00000, strssa);
					cmd_fasdasfdfive(playerid, "wysy≥a SMS'a ze swojego telefonu.");
					a++;
					break;
				}
			}
			if(a == 0)
			{
				new strsa[256];
				format(strsa, sizeof(strsa), "{ff6600}** Wys≥a≥eú SMS pod numer {DEDEDE}%d{ff6600}.", ids);
				SendClientMessage(playerid, 0xFFb00000, strsa);
				new strssa[256];
				format(strssa, sizeof(strssa), "{ff6600}WiadomoúÊ: Brak raportu dorÍczenia.");
				SendClientMessage(playerid, 0xFFb00000, strssa);
			}
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}SMS {88b711}zosta≥{DEDEDE} wys≥any.", "Zamknij", "");
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_SL)
	{
		if(!response)
		{
		
		}
		else
		{
			SetPVarInt(playerid, "uidgr", strval(inputtext));
			dShowPlayerDialog(playerid, DIALOG_TELEFON_SL_ZG, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} zg≥oszenia nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
		}
		return 1;
	}
	if(dialogid == DIALOG_TELEFON_SL_ZG)
	{
		if(!response)
		{
		
		}
		else
		{
			if(strlen(inputtext) < 3)
			{
				dShowPlayerDialog(playerid, DIALOG_TELEFON_SL_ZG, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} zg≥oszenia nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
				return 0;
			}
			ForeachEx(i, IloscGraczy)
			{
				if(DaneGracza[KtoJestOnline[i]][gSluzba]  == GetPVarInt(playerid, "uidgr"))
				{
					new strs[256];
					format(strs, sizeof(strs), "{ff6600}** Zg≥oszenie od {DEDEDE}%s{ff6600} (ID: {DEDEDE}%d{ff6600}), z telefonu nr: {DEDEDE}%d{ff6600}.",ZmianaNicku(playerid), playerid, DaneGracza[playerid][gTelefon]);
					SendClientMessage(KtoJestOnline[i], 0xFFb00000, strs);
					new strss[256];
					format(strss, sizeof(strss), "{ff6600}WiadomoúÊ: {DEDEDE}%s{ff6600}.",inputtext);
					SendClientMessage(KtoJestOnline[i], 0xFFb00000, strss);
				}
			}
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zg≥oszenie {88b711}zosta≥o{DEDEDE} wys≥ane.", "Zamknij", "");
		}
		return 1;
	}
	if( dialogid == DIALOG_ATTACH_EDITREPLACE )
	{
        if(response)
		{
			EditAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"));
		}
        else
		{		
			RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"));
			format(zapyt, sizeof(zapyt), "DELETE FROM `five_dodadtki` WHERE `UID` = '%d' AND `index` = '%d'", DaneGracza[playerid][gUID], GetPVarInt(playerid, "AttachmentIndexSel"));
			mysql_query(zapyt);
			if(GetPVarInt(playerid, "AttachmentIndexSel") == 7)
			{
				DaneGracza[playerid][gPrzyczepiony1] = 0;
			}
			if(GetPVarInt(playerid, "AttachmentIndexSel") == 8)
			{
				DaneGracza[playerid][gPrzyczepiony2] = 0;
			}
			DeletePVar(playerid, "AttachmentIndexSel");
		}
        return 1;
    }
	if( dialogid == DIALOG_ATTACH_MODEL_SELECTION )
	{
        if(response)
        {
			strdel(tekst_global, 0, 2048);
            if(GetPVarInt(playerid, "AttachmentUsed") == 1) EditAttachedObject(playerid, listitem);
            else
            {
                SetPVarInt(playerid, "AttachmentModelSel", AttachmentObjects[listitem][attachmodel]);
                for(new x;x<sizeof(AttachmentBones);x++)
                {
                    format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}%s", tekst_global, AttachmentBones[x]);
                }
				dShowPlayerDialog(playerid, DIALOG_ATTACH_BONE_SELECTION, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", tekst_global, "Edytuj", "Zamknij");
            }
        }
        else DeletePVar(playerid, "AttachmentIndexSel");
        return 1;
    }
	if( dialogid == DIALOG_ATTACH_BONE_SELECTION )
	{
        if(response)
        {
            SetPlayerAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"), GetPVarInt(playerid, "AttachmentModelSel"), listitem+1);
            EditAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"));
        }
        DeletePVar(playerid, "AttachmentIndexSel");
        DeletePVar(playerid, "AttachmentModelSel");
        return 1;
    }
	if( dialogid == DIALOG_ATTACH_INDEX_SELECTION )
	{
		if( !response )
	        return 0;

		switch( listitem )
		{
			case 0:
			{
				strdel(tekst_global, 0, 2048);
				if(IsPlayerAttachedObjectSlotUsed(playerid, 7))
				{
					dShowPlayerDialog(playerid, DIALOG_ATTACH_EDITREPLACE, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten slot jest zajÍty.", "Edytuj", "UsuÒ");
				}
				else
				{
					for(new x;x<sizeof(AttachmentObjects);x++)
					{
						format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}%s", tekst_global, AttachmentObjects[x][attachname]);
					}
					dShowPlayerDialog(playerid, DIALOG_ATTACH_MODEL_SELECTION, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", tekst_global, "Wybierz", "Zamknij");
				}
				SetPVarInt(playerid, "AttachmentIndexSel", 7);
			}
			case 1:
			{
				strdel(tekst_global, 0, 2048);
				if(IsPlayerAttachedObjectSlotUsed(playerid, 8))
				{
					dShowPlayerDialog(playerid, DIALOG_ATTACH_EDITREPLACE, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten slot jest zajÍty.", "Edytuj", "UsuÒ");
				}
				else
				{
					for(new x;x<sizeof(AttachmentObjects);x++)
					{
						format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}%s", tekst_global, AttachmentObjects[x][attachname]);
					}
					dShowPlayerDialog(playerid, DIALOG_ATTACH_MODEL_SELECTION, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", tekst_global, "Wybierz", "Zamknij");
				}
				SetPVarInt(playerid, "AttachmentIndexSel", 8);
			}
        }
	}
	if( dialogid == DIALOG_SWEEPER )
	{
	    if( !response )
		{
			RemovePlayerFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
			Pracuje[playerid] = 0;
		}
		else
		{
			new nr_trasy;
			new rand = random(5);
			if(rand == 0) nr_trasy = 20;
			if(rand == 1) nr_trasy = 60;
			if(rand == 2) nr_trasy = 130;
			if(rand == 3) nr_trasy = 234;
			if(rand == 4) nr_trasy = 255;
			else nr_trasy = 106;
			new vehicleid = GetPlayerVehicleID(playerid);
			new vehc = SprawdzCarUID(vehicleid);
			Pracuje[playerid] = vehicleid;
			DaneGracza[playerid][gWyscig] = nr_trasy;
			DaneGracza[playerid][gCheckopintID] = 0;
			new nextto = SzukajCheckpointu(1, WyscigInfo[DaneGracza[playerid][gWyscig]][StworzylTrase],WyscigInfo[DaneGracza[playerid][gWyscig]][wNazwa]);
			SetPlayerRaceCheckpoint(playerid,0,WyscigInfo[nr_trasy][wX], WyscigInfo[nr_trasy][wY], WyscigInfo[nr_trasy][wZ],WyscigInfo[nextto][wX], WyscigInfo[nextto][wY], WyscigInfo[nextto][wZ],8);
			DaneGracza[playerid][gKoniecWyscigu] = 0;
			PojazdInfo[vehc][pPaliwo] = 100;
			PojazdInfo[vehc][pSilnik] = 1;
			new lights,bonnet,boot,objective,alarm;
			SetVehicleParamsEx(vehicleid,true,lights,alarm,true,bonnet,boot,objective);
			TextDrawHideForPlayer(playerid,Licznik[playerid]);
			//PojazdInfo[vehc][pTimer] = SetTimerEx("MinusPaliwo", 30000, 1, "i", vehicleid);
			DaneGracza[playerid][gSwp] = 60;
		}
	}
	if( dialogid == DIALOG_BUS )
	{
	    if( !response )
	        return 1;
		new
		    uid = strval( inputtext ), czas, koszt,dis;
		dis = GetPlayerDistanceToPoint( playerid, Przystanek[ uid ][ busPozX ],
		Przystanek[ uid ][ busPozY ], Przystanek[ uid ][ busPozZ ] );
		if(DaneGracza[playerid][gCZAS_ONLINE] < 3 * 60 * 60)
		{
			koszt = 0;
		}
		else
		{
			koszt 	= dis/17000;
		}
		czas    = dis/12000;
		new taksiarz = 0;
		ForeachEx(i, IloscGraczy)
		{
			if(DaneGracza[KtoJestOnline[i]][gSluzba] != 0 && GrupaInfo[DaneGracza[KtoJestOnline[i]][gSluzba]][gTyp] == DZIALALNOSC_TAXI && !GraczJestAFK(KtoJestOnline[i]))
			{
				taksiarz = 1;
				break;
			}
		}
		if(taksiarz == 0 && koszt > 20)
		{
			koszt = koszt/4;
		}
		SetPVarInt( playerid, "BusKoszt", koszt );
		SetPVarInt( playerid, "BusCzas", czas );
		SetPVarInt( playerid, "BusDo", uid );
		SetPVarInt( playerid, "BusPrzystanek", GetPlayerBusStop( playerid ) );
		strdel(tekst_global, 0, 2048);
		format( tekst_global, sizeof( tekst_global ), "{DEDEDE}Trasa: {88b711}%s {DEDEDE}ª {88b711}%s\n\
		{DEDEDE}Czas: {88b711}%d{DEDEDE} min. {88b711}%d{DEDEDE} s\n\
		{DEDEDE}Koszt: {88b711}%d{DEDEDE}$ (do 3h darmowy przejazd)", Przystanek[ GetPlayerBusStop( playerid ) ][ busText ],
		Przystanek[ uid ][ busText ], czas / 60, czas % 60, koszt );
		dShowPlayerDialog( playerid, DIALOG_BUS_BILET, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bilet {88b711}:",
		tekst_global, "Kup", "Zamknij" );

	}

	if( dialogid == DIALOG_BUS_BILET )
	{
	    if( !response )
	    {
	        DeletePVar( playerid, "BusKoszt" );
	        DeletePVar( playerid, "BusCzas" );
	        DeletePVar( playerid, "BusPrzystanek" );
	        DeletePVar( playerid, "BusDo" );
	        return 1;
		}

		if( GetPVarInt( playerid, "BusKoszt" ) > GetPlayerMoney( playerid ) )
		{
		    DeletePVar( playerid, "BusKoszt" );
	        DeletePVar( playerid, "BusCzas" );
	        DeletePVar( playerid, "BusDo" );
	        DeletePVar( playerid, "BusPrzystanek" );
	        return dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:","{DEDEDE}Nie posiadasz {88b711}wystarczajπcej{DEDEDE} iloúci pieniÍdzy na {88b711}zakup{DEDEDE} biletu.", "Zamknij", "" );
		}

		SetTimerEx( "BusStart", 33000, 0, "i", playerid );
		GameTextForPlayer( playerid, "~y~~h~autobus pojawi sie~n~~y~~h~za okolo ~b~~h~pol minuty.",3000, 5);

	}
	if( dialogid == DIALOG_NOWYBUS_CZ1 )
	{
		if( !response )
		    return 1;

		if( !strlen( inputtext ) || strlen( inputtext ) > 32 )
		    return dShowPlayerDialog( playerid, DIALOG_NOWYBUS_CZ1, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przystanek {88b711}:",
		            "{DEDEDE}Zbyt {88b711}krÛtka{DEDEDE} lub zbyt {88b711}d≥uga{DEDEDE} nazwa przystanku.\n\
		            Wpisz poprawnπ nazwÍ.", "Dalej", "Zamknij" );
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos( playerid, x, y, z );
		GetPlayerFacingAngle( playerid, a );
		new id = StworzPrzystanek( inputtext, x, y, z, a );
		strdel(tekst_global, 0, 2048);
		format( tekst_global, sizeof( tekst_global ), "{DEDEDE}Utworzono przystanek {88b711}%d. %s",
		id, Przystanek[ id ][ busText ] );
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przystanek {88b711}:",tekst_global, "Zamknij", "" );
	}
	if( dialogid == DIALOG_BUS_EDIT )
	{
	    if( !response )
	        return DeletePVar( playerid, "BusPoz" );

		switch( listitem )
		{
		    case 0, 1, 2, 3, 4, 5:
		        return cmd_abus( playerid, "edytuj" );

			case 6:
			    return 	dShowPlayerDialog( playerid, DIALOG_BUS_EDITZAPISZ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przystanek {88b711}:",
			            "{DEDEDE}Wpisz {88b711}nowπ{DEDEDE} nazwÍ przystanku.", "Dalej", "Zamknij" );

			case 7:
				return dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przystanek {88b711}:","{DEDEDE}Ustaw siÍ w nowej {88b711}pozycji{DEDEDE} przystanku i wpisz {88b711}/abus.", "Zamknij", "" );

			case 8:
			{
			    UsunPrzystanek( GetPVarInt( playerid, "BusPoz" ) );
			    dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przystanek {88b711}:","{DEDEDE}UsuniÍto {88b711}przystanek{DEDEDE}.", "Zamknij", "" );
			    DeletePVar( playerid, "BusPoz" );
			}
		}
	}
	if( dialogid == DIALOG_BUS_EDITZAPISZ )
	{
	    if( !response )
	        return DeletePVar( playerid, "BusPoz" );

		if( !strlen( inputtext ) || strlen( inputtext ) > 32 )
		    return 	dShowPlayerDialog( playerid, DIALOG_BUS_EDITZAPISZ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przystanek {88b711}:",
			        "{DEDEDE}Wpisana przez Ciebie nazwa jest {88b711}niepoprawna{DEDEDE}.\n\
					SprÛbuj ponownie, nie przekraczajπc limitu {88b711}32{DEDEDE} znakÛw.", "Dalej", "Zamknij" );

		new
		    id = GetPVarInt( playerid, "BusPoz" )
		;
		format( Przystanek[ id ][ busText ], 32, "%s", inputtext );
		ZapiszPrzystanek( id );
		strdel(tekst_global, 0, 2048);
		format( tekst_global, 100, "Przystanek %d. %s\n\
		{88b711}Aby kupiÊ bilet, wpisz /bus",
		id, Przystanek[ id ][ busText ] );

		UpdateDynamic3DTextLabelText( Przystanek[ id ][ busTag ], SZARY, tekst_global );

		DeletePVar( playerid, "BusPoz" );
	}
	if(dialogid == DIALOG_PRZEDZMIOTY)
	{
	    if(response)
		{
		    SetPVarInt( playerid, "UzytyItem", strval(inputtext));
 	        dShowPlayerDialog(playerid, DIALOG_PRZEDZMIOT_OPCJE, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przedmioty {88b711}ª {FFFFFF}Opcje {88b711}:", "{DEDEDE}ª  {88B711}Uøyj\n{DEDEDE}ª  {88B711}Od≥Ûø\n{DEDEDE}ª  {88B711}W≥Ûø do szafy\n{DEDEDE}ª  {88B711}W≥Ûø do torby\n{DEDEDE}ª  {88B711}Daj przedmiot graczu\n{DEDEDE}ª  {88B711}W≥Ûü do magazynu\n{DEDEDE}ª  {88B711}W≥Ûü do craftingu\n{DEDEDE}ª  {88B711}W≥Ûü do grila\n{DEDEDE}ª  {88B711}Zniszcz przedmiot", "Wybierz", "Zamknij");
		}
		else
		{
			//DeletePVar(playerid, "UzytyItem");
		}
		return 1;
	}
	if(dialogid == DIALOG_GRIL)
	{
	    if( !response )
	        return 1;
		SetPVarInt( playerid, "UzytyItemGril", strval(inputtext));
 	    dShowPlayerDialog(playerid, DIALOG_GRIL_OPCJE, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przedmioty na grilu{88b711}ª {FFFFFF}Opcje {88b711}:", "{DEDEDE}ª  {88B711}Wyciπgnij sk≥adnik\n{DEDEDE}ª  {88B711}Griluj sk≥adniki", "Wybierz", "Zamknij");
		return 1;
	}
	if(dialogid == DIALOG_CRAFT)
	{
	    if( !response )
	        return 1;
		SetPVarInt( playerid, "UzytyItemCraft", strval(inputtext));
 	    dShowPlayerDialog(playerid, DIALOG_CRAFT_OPCJE, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przedmioty na stole{88b711}ª {FFFFFF}Opcje {88b711}:", "{DEDEDE}ª  {88B711}Wyciπgnij sk≥adnik\n{DEDEDE}ª  {88B711}Zmieszaj sk≥adniki", "Wybierz", "Zamknij");
		return 1;
	}
	if( dialogid == DIALOG_CRAFT_OPCJE )
	{
		new uid = GetPVarInt(playerid, "UzytyItemCraft");
		if( !response )
	        return 1;
		switch(listitem)
		{
		    case 0:
			{
				PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
				PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
				ZapiszPrzedmiot(uid);
				GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wyciagniety z craftingu.", 3000, 5);
			}
			case 1:
			{
				new wcraft[64], ip= 0;
				ForeachEx(i, MAX_PRZEDMIOT)
				{
					if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDCRAFT") && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
					{
						wcraft[ip] = i;
						ip++;
						//if(ip > 2) break;
					}
				}
				if(ip < 3)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby uøyÊ craftingu na stole muszπ siÍ znajdowaÊ minimum {88b711}3{DEDEDE} sk≥adniki.", "Zamknij", "");
					return 0;
				}
				if(ip > 3)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby uøyÊ craftingu na stole muszπ siÍ znajdowaÊ maximum {88b711}3{DEDEDE} sk≥adniki.", "Zamknij", "");
					return 0;
				}
				new a,b,c;
				a = wcraft[0];
				b = wcraft[1];
				c = wcraft[2];
				if(PrzedmiotInfo[a][pTyp] == PrzedmiotInfo[b][pTyp] && PrzedmiotInfo[a][pTyp] == PrzedmiotInfo[c][pTyp] && PrzedmiotInfo[b][pTyp] == PrzedmiotInfo[c][pTyp])
				{
					if(PrzedmiotInfo[a][pWar1] != PrzedmiotInfo[b][pWar1] && PrzedmiotInfo[a][pWar1] != PrzedmiotInfo[c][pWar1] && PrzedmiotInfo[b][pWar1] != PrzedmiotInfo[c][pWar1])
					{
						if(PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_MARYCHA && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_AMFA &&
						PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_KOKA && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_EXTASA && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_LSD &&
						PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_GRZYBY && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_HERA && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_MEFEDRON)
						{
							ForeachEx(i, MAX_PRZEDMIOT)
							{
								if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDCRAFT") && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
								{
									UsunPrzedmiot(i);
								}
							}
							dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Mieszanie sk≥adnikÛw {88b711}zakoÒczone niepowodzeniem, sk≥adniki nie pasujπ do siebie.", "Zamknij", "");
							return 0;
						}
						new nazwan[256], typ;
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_MARYCHA)
						{
							format(nazwan, sizeof(nazwan), "Marihuana");
							typ = P_SKLADNIK_MARYCHA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_AMFA)
						{
							format(nazwan, sizeof(nazwan), "Amfetamina");
							typ = P_SKLADNIK_AMFA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_KOKA)
						{
							format(nazwan, sizeof(nazwan), "Kokaina");
							typ = P_SKLADNIK_KOKA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_EXTASA)
						{
							format(nazwan, sizeof(nazwan), "Extasa");
							typ = P_SKLADNIK_EXTASA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_LSD)
						{
							format(nazwan, sizeof(nazwan), "LSD");
							typ = P_SKLADNIK_LSD;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_GRZYBY)
						{
							format(nazwan, sizeof(nazwan), "Grzybki");
							typ = P_SKLADNIK_GRZYBY;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_HERA)
						{
							format(nazwan, sizeof(nazwan), "Heroina");
							typ = P_SKLADNIK_HERA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_MEFEDRON)
						{
							format(nazwan, sizeof(nazwan), "Mefedron");
							typ = P_SKLADNIK_MEFEDRON;
						}
						ForeachEx(i, MAX_PRZEDMIOT)
						{
							if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDCRAFT") && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
							{
								UsunPrzedmiot(i);
							}
						}
						DodajPrzedmiot(GetPVarInt( playerid, "UIDCRAFT"), TYP_CRAFT, P_NARKOTYKI, typ, 1, nazwan, -1, 0, -1, 0, 0, 0, "");
						Przedmioty(playerid, playerid, DIALOG_CRAFT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przedmioty na stole{88b711}:", TYP_CRAFT, GetPVarInt( playerid, "UIDCRAFT"));
						GameTextForPlayer(playerid, "~y~Skladniki zostaly ~w~zmieszane.", 3000, 5);
					}
					else
					{
						ForeachEx(i, MAX_PRZEDMIOT)
						{
							if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDCRAFT") && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
							{
								UsunPrzedmiot(i);
							}
						}
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Mieszanie sk≥adnikÛw {88b711}zakoÒczone niepowodzeniem, sk≥adniki nie pasujπ do siebie.", "Zamknij", "");
					}
				}
				else
				{
					ForeachEx(i, MAX_PRZEDMIOT)
					{
						if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDCRAFT") && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
						{
							UsunPrzedmiot(i);
						}
					}
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Mieszanie sk≥adnikÛw {88b711}zakoÒczone niepowodzeniem, sk≥adniki nie pasujπ do siebie.", "Zamknij", "");
				}
			}
		}
	}
	if( dialogid == DIALOG_GRIL_OPCJE )
	{
		new uid = GetPVarInt(playerid, "UzytyItemGril");
		if( !response )
	        return 1;
		switch(listitem)
		{
		    case 0:
			{
				PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
				PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
				ZapiszPrzedmiot(uid);
				GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wyciagniety z grila.", 3000, 5);
			}
			case 1:
			{
				new wcraft[64], ip= 0;
				ForeachEx(i, MAX_PRZEDMIOT)
				{
					if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDGRIL") && PrzedmiotInfo[i][pTypWlas] == TYP_GRIL && PrzedmiotInfo[i][pUID] != 0)
					{
						wcraft[ip] = i;
						ip++;
						//if(ip > 2) break;
					}
				}
				if(ip < 3)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby uøyÊ grila muszπ siÍ w nim znajdowaÊ minimum {88b711}3{DEDEDE} sk≥adniki.", "Zamknij", "");
					return 0;
				}
				if(ip > 3)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby uøyÊ grila muszπ siÍ w nim znajdowaÊ maximum {88b711}3{DEDEDE} sk≥adniki.", "Zamknij", "");
					return 0;
				}
				new a,b,c;
				a = wcraft[0];
				b = wcraft[1];
				c = wcraft[2];
				if(PrzedmiotInfo[a][pTyp] == PrzedmiotInfo[b][pTyp] && PrzedmiotInfo[a][pTyp] == PrzedmiotInfo[c][pTyp] && PrzedmiotInfo[b][pTyp] == PrzedmiotInfo[c][pTyp])
				{
					if(PrzedmiotInfo[a][pWar1] != PrzedmiotInfo[b][pWar1] && PrzedmiotInfo[a][pWar1] != PrzedmiotInfo[c][pWar1] && PrzedmiotInfo[b][pWar1] != PrzedmiotInfo[c][pWar1])
					{
						if(PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_KIELBA && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_SASZLYK &&
						PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_KARKOWKA && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_KURCZAK && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_TOST &&
						PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_BOCZEK && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_STEK && PrzedmiotInfo[wcraft[0]][pTyp] != P_SKLADNIK_ZIEMNIAKI)
						{
							ForeachEx(i, MAX_PRZEDMIOT)
							{
								if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDGRIL") && PrzedmiotInfo[i][pTypWlas] == TYP_GRIL && PrzedmiotInfo[i][pUID] != 0)
								{
									UsunPrzedmiot(i);
								}
							}
							dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Grilowanie sk≥adnikÛw {88b711}zakoÒczone niepowodzeniem, sk≥adniki nie pasujπ do siebie.", "Zamknij", "");
							return 0;
						}
						new nazwan[256], typ;
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_KIELBA)
						{
							format(nazwan, sizeof(nazwan), "Kielbasa z grila");
							typ = P_SKLADNIK_KIELBA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_SASZLYK)
						{
							format(nazwan, sizeof(nazwan), "Saszlyk z grila");
							typ = P_SKLADNIK_SASZLYK;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_KARKOWKA)
						{
							format(nazwan, sizeof(nazwan), "Karkowka z grila");
							typ = P_SKLADNIK_KARKOWKA;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_KURCZAK)
						{
							format(nazwan, sizeof(nazwan), "Kurczak z grila");
							typ = P_SKLADNIK_KURCZAK;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_TOST)
						{
							format(nazwan, sizeof(nazwan), "Tost z grila");
							typ = P_SKLADNIK_TOST;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_BOCZEK)
						{
							format(nazwan, sizeof(nazwan), "Boczek z grila");
							typ = P_SKLADNIK_BOCZEK;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_STEK)
						{
							format(nazwan, sizeof(nazwan), "Stek z grila");
							typ = P_SKLADNIK_STEK;
						}
						if(PrzedmiotInfo[wcraft[0]][pTyp] == P_SKLADNIK_ZIEMNIAKI)
						{
							format(nazwan, sizeof(nazwan), "Ziemniaki z grila");
							typ = P_SKLADNIK_ZIEMNIAKI;
						}
						ForeachEx(i, MAX_PRZEDMIOT)
						{
							if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDGRIL") && PrzedmiotInfo[i][pTypWlas] == TYP_GRIL && PrzedmiotInfo[i][pUID] != 0)
							{
								UsunPrzedmiot(i);
							}
						}
						DodajPrzedmiot(GetPVarInt( playerid, "UIDGRIL"), TYP_GRIL, P_ZARCIE, typ, 10, nazwan, -1, 0, -1, 0, 0, 0, "");
						Przedmioty(playerid, playerid, DIALOG_GRIL, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Przedmioty z grila{88b711}:", TYP_GRIL, GetPVarInt( playerid, "UIDGRIL"));
						GameTextForPlayer(playerid, "~y~Skladniki zostaly ~w~zgrilowane.", 3000, 5);
					}
					else
					{
						ForeachEx(i, MAX_PRZEDMIOT)
						{
							if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDGRIL") && PrzedmiotInfo[i][pTypWlas] == TYP_GRIL && PrzedmiotInfo[i][pUID] != 0)
							{
								UsunPrzedmiot(i);
							}
						}
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Grilowanie sk≥adnikÛw {88b711}zakoÒczone niepowodzeniem, sk≥adniki nie pasujπ do siebie.", "Zamknij", "");
					}
				}
				else
				{
					ForeachEx(i, MAX_PRZEDMIOT)
					{
						if(PrzedmiotInfo[i][pOwner] == GetPVarInt( playerid, "UIDCRAFT") && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
						{
							UsunPrzedmiot(i);
						}
					}
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Mieszanie sk≥adnikÛw {88b711}zakoÒczone niepowodzeniem, sk≥adniki nie pasujπ do siebie.", "Zamknij", "");
				}
			}
		}
	}
	if( dialogid == DIALOG_PRZEDZMIOT_OPCJE )
	{
	    new uid = GetPVarInt(playerid, "UzytyItem");
	    if( !response )
	        return 1;
		switch(listitem)
		{
		    case 0:
			{
			    if(PrzedmiotInfo[uid][pTyp] == P_PACZKA)
			    {
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do {88b711}magazynu{DEDEDE} swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze {88b711}dwa{DEDEDE} dni\nTen {88b711}przedmiot{DEDEDE} zostanie skasowany.", "Zamknij", "");
					return 0;
				}
			    UzywanieItemu(playerid, GetPVarInt(playerid, "UzytyItem"));
		        return 1;
			}
			case 1:
			{
			    if(PrzedmiotInfo[uid][pTyp] == P_PACZKA)
			    {
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do {88b711}magazynu{DEDEDE} swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze {88b711}dwa{DEDEDE} dni\nTen {88b711}przedmiot{DEDEDE} zostanie skasowany.", "Zamknij", "");
					return 0;
				}
				if(PrzedmiotInfo[uid][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz tego {88b711}zrobiÊ{DEDEDE} poniewaø przedmiot jest uøywany.", "Zamknij", "");
					return 0;
				}
			    OdkladanieItemu(playerid, GetPVarInt(playerid, "UzytyItem"));
		        return 1;
			}
			case 2:
			{
				if(PrzedmiotInfo[uid][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz w≥oøyÊ tego {88b711}przedmiotu{DEDEDE} do szafy poniewaø jest uøywany.", "Zamknij", "");
					return 0;
				}
			    if(PrzedmiotInfo[uid][pTyp] == P_PACZKA)
			    {
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do {88b711}magazynu{DEDEDE} swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze {88b711}dwa{DEDEDE} dni\nTen {88b711}przedmiot{DEDEDE} zostanie skasowany.", "Zamknij", "");
					return 0;
				}
				new vw = GetPlayerVirtualWorld(playerid);
				if(vw == 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie {88b711}znajdujesz{DEDEDE} siÍ w budynku.", "Zamknij", "");
					return 0;
				}
				if(NieruchomoscInfo[vw][nSzafa] == -1)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}W tym {88b711}budynku{DEDEDE} nie ma szafy.", "Zamknij", "");
					return 0;
				}
				if(DaneGracza[playerid][gBW] > 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz uøywaÊ tej {88b711}komendy{DEDEDE}, gdy jesteú nieprzytomny.", "Zamknij", "");
					return 0;
				}
				if(!ZarzadzanieSzafa(vw, playerid))
				{
					GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
					return 0;
				}
				PrzedmiotInfo[uid][pTypWlas] = TYP_SZAFA;
				PrzedmiotInfo[uid][pOwner] = vw;
				ZapiszPrzedmiot(uid);
				DeletePVar(playerid, "UzytyItem");
				GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wlozony do szafy.", 3000, 5);
				return 1;
			}
			case 3:
			{
			    new found = 0;
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pTyp] == P_TORBA)
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz {88b711}w≥oøyÊ{DEDEDE} torby do torby.", "Zamknij", "");
				    return 0;
				}
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz w≥oøyÊ tego {88b711}przedmiotu{DEDEDE} do torby poniewaø jest uøywany.", "Zamknij", "");
					return 0;
				}
				strdel(tekst_global, 0, 2048);
				ForeachEx(i, MAX_PRZEDMIOT)
				{
					if(PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pTyp] == P_TORBA && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL)
					{
						format(tekst_global, sizeof(tekst_global), "%s\n%d\t%s", tekst_global, PrzedmiotInfo[i][pUID], PrzedmiotInfo[i][pNazwa]);
						found++;
					}
				}
				if(found != 0) dShowPlayerDialog(playerid, DIALOG_TORBA_WLOZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Torby {88b711}:", tekst_global, "Wybierz", "Zamknij");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Torby {88b711}:", "{DEDEDE}Nie {88b711}posiadasz{DEDEDE} przy sobie torby.", "Zamknij", "");
				return 1;
			}
			case 4:
			{
				SetPVarInt(playerid, "Wybrany", GetPVarInt(playerid, "UzytyItem"));
				if(PrzedmiotInfo[uid][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz tego {88b711}zrobiÊ{DEDEDE} poniewaø przedmiot jest uøywany.", "Zamknij", "");
					return 0;
				}
			    if(response)
				{
					strdel(tekst_global, 0, 2048);
					new found = 0;
					ForeachEx(i, IloscGraczy)
					{
					    if(DaneGracza[KtoJestOnline[i]][gUID] && PlayerObokPlayera(playerid, KtoJestOnline[i], 5) && KtoJestOnline[i] != playerid)
					    {
							format(tekst_global, sizeof(tekst_global), "%s\n%d\t%s", tekst_global, KtoJestOnline[i], ZmianaNicku(KtoJestOnline[i]));
							found++;
						}
					}
					if(found != 0) dShowPlayerDialog(playerid, DIALOG_OFER_GR_ITEM, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", tekst_global, "Zatwierdz", "Zamknij");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nikt {88b711}obok Ciebie nie stoi.", "Zamknij", "");
				}	
				return 1;
			}
			case 5:
			{
			    /*new vw = GetPlayerVirtualWorld(playerid);
			    if(PrzedmiotInfo[uid][pTyp] != P_PACZKA)
			    {
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ta opcja jest {88b711}dostÍpna{DEDEDE} tylko dla paczek.", "Zamknij", "");
					return 0;
				}
				if(vw == 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie {88b711}znajdujesz{DEDEDE} siÍ w budynku.", "Zamknij", "");
					return 0;
				}
				if(NieruchomoscInfo[vw][nWlascicielD] != PrzedmiotInfo[uid][pWar2])
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten budynek nie jest {88b711}w≥asnoúciπ{DEDEDE} dzia≥alnoúci do ktÛrej naleøy paczka.", "Zamknij", "");
					return 0;
				}
                DodajDoMagazynu(PrzedmiotInfo[uid][pWar2], PrzedmiotInfo[uid][pWar1], PrzedmiotInfo[uid][pStworzylUID], PrzedmiotInfo[uid][pWar4], PrzedmiotInfo[uid][pNazwa], PrzedmiotInfo[uid][pCenas], PrzedmiotInfo[uid][pObject]);
				UsunPrzedmiot(uid);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Paczka zosta≥a {88b711}od≥oøona{DEDEDE} pomyúlnie.", "Zamknij", "");
			    return 1;*/
			}
			case 6:
			{
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pTyp] == P_PACZKA)
			    {
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do {88b711}magazynu{DEDEDE} swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze {88b711}dwa{DEDEDE} dni\nTen {88b711}przedmiot{DEDEDE} zostanie skasowany.", "Zamknij", "");
					return 0;
				}
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz w≥oøyÊ tego {88b711}przedmiotu{DEDEDE} do craftingu poniewaø jest uøywany.", "Zamknij", "");
					return 0;
				}
				new find = 0;
				new uid_budynku = GetPlayerVirtualWorld(playerid);
				ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
				{
					if(Dystans(1.5, playerid, ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozZ]) && GetPlayerVirtualWorld(playerid) == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld] && ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][gZajety] == 0 && ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objModel] == 2419)
					{
						find = NieruchomoscInfo[uid_budynku][nObiekty][h];
						break;
					}
				}
				if(ObiektInfo[find][objModel] == 2419)
				{
					new uz = GetPVarInt(playerid, "UzytyItem");
					PrzedmiotInfo[uz][pTypWlas] = TYP_CRAFT;
					PrzedmiotInfo[uz][pOwner] = find;
					ZapiszPrzedmiot(uz);
					GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wlozony do craftingu.", 3000, 5);
					DeletePVar(playerid, "UzytyItem");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteú zbyt daleko od {88b711}modelu{DEDEDE} sto≥u do craftingu (obiekt id: {88b711}2419{DEDEDE}).", "Zamknij", "");
				}
				return 1;
			}
			case 7:
			{
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pTyp] == P_PACZKA)
			    {
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do {88b711}magazynu{DEDEDE} swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze {88b711}dwa{DEDEDE} dni\nTen {88b711}przedmiot{DEDEDE} zostanie skasowany.", "Zamknij", "");
					return 0;
				}
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz w≥oøyÊ tego {88b711}przedmiotu{DEDEDE} do craftingu poniewaø jest uøywany.", "Zamknij", "");
					return 0;
				}
				new find = 0;
				find = PrzyObiekcie(playerid, 1481, 5);
				if(find != 0)
				{
					new uz = GetPVarInt(playerid, "UzytyItem");
					PrzedmiotInfo[uz][pTypWlas] = TYP_GRIL;
					PrzedmiotInfo[uz][pOwner] = find;
					ZapiszPrzedmiot(uz);
					GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wlozony do grila.", 3000, 5);
					DeletePVar(playerid, "UzytyItem");
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteú zbyt daleko od {88b711}modelu{DEDEDE} grila (obiekt id: {88b711}1481{DEDEDE}).", "Zamknij", "");
				}
				return 1;
			}
			case 8:
			{
				if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pUzywany] != 0)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz w≥oøyÊ tego {88b711}przedmiotu{DEDEDE} do torby poniewaø jest uøywany.", "Zamknij", "");
					return 0;
				}
				dShowPlayerDialog(playerid, DIALOG_PRZEDMIOT_DEL, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Czy na pewno chcesz {88b711}usunπÊ{DEDEDE} przedmiot?", "Tak", "Nie");
				return 1;
			}
		}
	}
	if(dialogid == DIALOG_PRZEDMIOT_DEL)
    {
        if(response)
        {
			if(PrzedmiotInfo[GetPVarInt(playerid, "UzytyItem")][pTyp] == P_TORBA)
			{
				ForeachEx(id, MAX_PRZEDMIOT)
				{
					if(PrzedmiotInfo[id][pOwner] == GetPVarInt(playerid, "UzytyItem") && PrzedmiotInfo[id][pTypWlas] == TYP_TORBA && PrzedmiotInfo[id][pUID] != 0)
					{
						UsunPrzedmiot(id);
					}
				}
			}
			UsunPrzedmiot(GetPVarInt(playerid, "UzytyItem"));
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Przedmiot zosta≥ {88b711}usuniÍty{DEDEDE}.", "Zamknij", "");
        }
        else
        {
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_OFER_GR_ITEM)
	{
		if( !response )
	        return 1;
		new gracz = strval(inputtext);
		SetPVarInt(playerid, "GraczItem", gracz);
		dShowPlayerDialog(playerid, DIALOG_OFER_GR_ITEM_CENA, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Wpisz kwote za jakπ chcesz {88b711}sprzedaÊ{DEDEDE} przedmiot:", "Zatwierdz", "Zamknij");
		return 1;
	}
	if(dialogid == DIALOG_OFER_GR_ITEM_CENA)
	{
		if( !response )
	        return 1;
		if(strval(inputtext) < 0)
		{
			dShowPlayerDialog(playerid, DIALOG_OFER_GR_ITEM_CENA, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Wpisz kwote za jakπ chcesz {88b711}sprzedaÊ{DEDEDE} przedmiot:", "Zatwierdz", "Zamknij");
			return 1;
		}
		Oferuj(playerid, GetPVarInt(playerid, "GraczItem"), GetPVarInt(playerid, "Wybrany"), 0, 0, 0, OFEROWANIE_PRZEDMIOTU, strval(inputtext), "", 0);
		return 1;
	}
	if(dialogid == DIALOG_TORBA_WYCIAGNIJ)
	{
		if( !response )
	        return 1;
		new uid = strval(inputtext);
		PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
		PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
	    ZapiszPrzedmiot(uid);
		GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wyciagniety z torby.", 3000, 5);
		return 1;
	}
	if(dialogid == DIALOG_DISC_WL)
	{
	    if( !response )
	        return 1;
	    new uid = strval(inputtext);
	    new uz = GetPVarInt(playerid, "UzytyItem");
		format(PrzedmiotInfo[uid][pWar3], 50, "%s", PrzedmiotInfo[uz][pWar3]);
		DeletePVar(playerid, "UzytyItem");
	    ZapiszPrzedmiot(uid);
	    GameTextForPlayer(playerid, "~y~Plyta zostala ~w~wlozona do discmana.", 3000, 5);
	    return 1;
	}
	if(dialogid == DIALOG_STATS)
	{
	    if( !response )
	        return 1;
	    if(listitem == 18)
		{
			new str[512];
			strdel(str, 0, 512);
			format(str, sizeof(str), "%s\n%s", str, "Brak");
			format(str, sizeof(str), "%s\n%s", str, AnimInfo[1][CMD]);
			format(str, sizeof(str), "%s\n%s", str, AnimInfo[2][CMD]);
			format(str, sizeof(str), "%s\n%s", str, AnimInfo[3][CMD]);
			format(str, sizeof(str), "%s\n%s", str, AnimInfo[4][CMD]);
			format(str, sizeof(str), "%s\n%s", str, AnimInfo[5][CMD]);
			dShowPlayerDialog(playerid, DIALOG_ANIM_CHODZENIA, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Animacje{88b711}:", str, "Uøyj", "Zamknij");
		}
	    return 1;
	}
	if(dialogid == DIALOG_ANIM_CHODZENIA)
	{
	    if( !response )
	        return 1;
		if(listitem == 0) DaneGracza[playerid][gTYPCHODZENIA] = 0;
	    if(listitem == 1) DaneGracza[playerid][gTYPCHODZENIA] = 1;
		if(listitem == 2) DaneGracza[playerid][gTYPCHODZENIA] = 2;
		if(listitem == 3) DaneGracza[playerid][gTYPCHODZENIA] = 3;
		if(listitem == 4) DaneGracza[playerid][gTYPCHODZENIA] = 4;
		if(listitem == 5) DaneGracza[playerid][gTYPCHODZENIA] = 5;
		ZapiszGracza(playerid);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Animacje{88b711}:", "{DEDEDE}Wybra≥eú nowy styl chodzenia.", "Zamknij", "");
	    return 1;
	}
	if(dialogid == DIALOG_TORBA_WLOZ)
	{
	    if( !response )
	        return 1;
	    new uid = strval(inputtext);
	    new uz = GetPVarInt(playerid, "UzytyItem");
	    PrzedmiotInfo[uz][pTypWlas] = TYP_TORBA;
		PrzedmiotInfo[uz][pOwner] = uid;
		DeletePVar(playerid, "UzytyItem");
	    ZapiszPrzedmiot(uz);
	    GameTextForPlayer(playerid, "~y~Przedmiot zostal ~w~wlozony do torby.", 3000, 5);
	    return 1;
	}
	if(dialogid == DIALOG_OFFER_TUNING)
	{
	    if(!response )
	        return 1;
		new cena, idGracza;
	    sscanf(inputtext, "dd", idGracza, cena);
		if(idGracza == playerid) return 1;
		if(!PlayerObokPlayera(playerid, idGracza, 5))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Musisz siÍ znajdowaÊ {88b711}obok{DEDEDE} gracza, aby mu coú oferowaÊ.", "Zamknij", "");
			return 0;
		}
		if(zalogowany[idGracza] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(idGracza))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} znajduje siÍ w pojezdzie.", "Zamknij", "");
			return 0;
		}
		if(!Wlascicielpojazdu(GetPlayerVehicleID(idGracza), idGracza))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w≥aúcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
			return 0;
		}
		if(cena <= 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Wprowadzona {88b711}kwota{DEDEDE} jest niepoprawna.", "Zamknij", "");
			return 0;
		}
		if(Jednoslady(GetPlayerVehicleID(idGracza)))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Nie moøesz tego zrobiÊ dla tego pojazdu.", "Zamknij", "");
			return 0;
		}
		/*NaprawiaID[playerid] = idGracza;
		NaprawianieCena[playerid] = cena;
		NaprawiaVeh[playerid] = GetPlayerVehicleID(idGracza);
		NaprawianieVW[playerid] = GetVehicleVirtualWorld(GetPlayerVehicleID(idGracza));
		NaprawiaIUID[playerid] = -2;
		Oferuj(playerid, idGracza, -2, GetPVarInt(playerid, "UzytyItem"), 0, 0, OFEROWANIE_TUNE_VEH, cena, "", 0);
		*/
		new uz = GetPVarInt(playerid, "UzytyItem");
		NaprawiaID[playerid] = idGracza;
		NaprawianieCena[playerid] = cena;
		NaprawiaVeh[playerid] = GetPlayerVehicleID(idGracza);
		NaprawianieVW[playerid] = GetVehicleVirtualWorld(GetPlayerVehicleID(idGracza));
		NaprawiaIUID[playerid] = uz;
		Oferuj(playerid, idGracza, uz, 0, 0, 0, OFEROWANIE_NAP_VEH, cena, "", 0);
	    return 1;
	}
	if(dialogid == DIALOG_HOLOWANIE)
	{
	    if( !response )
	        return 1;
		new uz = GetPVarInt(playerid, "UzytyItem");
		new cena, idGracza;
	    sscanf(inputtext, "dd", idGracza, cena);
		if(idGracza == playerid) return 1;
		if(!PlayerObokPlayera(playerid, idGracza, 40))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Musisz siÍ znajdowaÊ {88b711}obok{DEDEDE} gracza, aby mu coú oferowaÊ.", "Zamknij", "");
			return 0;
		}
		if(zalogowany[idGracza] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(idGracza))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} znajduje siÍ w pojezdzie.", "Zamknij", "");
			return 0;
		}
		if(GetPlayerState(idGracza) != PLAYER_STATE_PASSENGER)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie moøe{DEDEDE} znajdywaÊ siÍ za kierownicπ.", "Zamknij", "");
			return 0;
		}
		if(!Wlascicielpojazdu(GetPlayerVehicleID(idGracza), idGracza))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w≥aúcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
			return 0;
		}
		if(cena <= 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Wprowadzona {88b711}kwota{DEDEDE} jest niepoprawna.", "Zamknij", "");
			return 0;
		}
		Oferuj(playerid, idGracza, GetPlayerVehicleID(idGracza), SprawdzCarUID(GetPlayerVehicleID(idGracza)), uz, 0, OFEROWANIE_HOLOWANIA, cena, "", 0);
	    return 1;
	}
	if(dialogid == DIALOG_OFFER_NAPRAWE)
	{
	    if( !response )
	        return 1;
		new cena, idGracza;
	    sscanf(inputtext, "dd", idGracza, cena);
		if(idGracza == playerid) return 1;
		if(!PlayerObokPlayera(playerid, idGracza, 5))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Musisz siÍ znajdowaÊ {88b711}obok{DEDEDE} gracza, aby mu coú oferowaÊ.", "Zamknij", "");
			return 0;
		}
		if(zalogowany[idGracza] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(idGracza))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} znajduje siÍ w pojezdzie.", "Zamknij", "");
			return 0;
		}
		if(!Wlascicielpojazdu(GetPlayerVehicleID(idGracza), idGracza))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w≥aúcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
			return 0;
		}
		if(cena <= 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Wprowadzona {88b711}kwota{DEDEDE} jest niepoprawna.", "Zamknij", "");
			return 0;
		}
	    new uz = GetPVarInt(playerid, "UzytyItem");
		NaprawiaID[playerid] = idGracza;
		NaprawianieCena[playerid] = cena;
		NaprawiaVeh[playerid] = GetPlayerVehicleID(idGracza);
		NaprawianieVW[playerid] = GetVehicleVirtualWorld(GetPlayerVehicleID(idGracza));
		NaprawiaIUID[playerid] = uz;
		Oferuj(playerid, idGracza, uz, 0, 0, 0, OFEROWANIE_NAP_VEH, cena, "", 0);
	    return 1;
	}
	if(dialogid == DIALOG_STWORZ_DZ)
	{
	    if( !response )
		{
			DeletePVar(playerid, "IDDZGR");
			DeletePVar(playerid, "NAZWADZST");
		    return 1;
		}
		new zmien[25];
		strdel(zmien, 0, 25);
		GetPVarString(playerid, "NAZWADZST", zmien, 25);
		switch(listitem)
		{
		    case 0:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
			    Oferuj(playerid, id_gracza, DZIALALNOSC_WARSZTAT, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 3500,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
			case 1:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
				Oferuj(playerid, id_gracza, DZIALALNOSC_247, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 2500,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
			case 2:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
				Oferuj(playerid, id_gracza, DZIALALNOSC_ELEKTRTYKA, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 2000,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
			case 3:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
				Oferuj(playerid, id_gracza, DZIALALNOSC_GASTRONOMIA, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 5000,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
			case 4:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
				Oferuj(playerid, id_gracza, DZIALALNOSC_HOTEL, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 1500,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
			case 5:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
				Oferuj(playerid, id_gracza, DZIALALNOSC_TAXI, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 1200,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
			case 6:
			{
				new id_gracza = GetPVarInt(playerid, "IDDZGR");
				Oferuj(playerid, id_gracza, DZIALALNOSC_SILOWNIA, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DZIALA, 3000,zmien, 0);
				DeletePVar(playerid, "IDDZGR");
				DeletePVar(playerid, "NAZWADZST");
		        return 1;
			}
		}
	}
	if(dialogid == DIALOG_POJAZD_OPCJE_DZ)
	{
	    new uid = GetPVarInt(playerid, "OPCJAPOJAZDY");
	    if( !response )
	        return 1;
		switch(listitem)
		{
		    case 0:
			{
			    if(PojazdInfo[uid][pSpawn] == 0)
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby namierzyÊ {88b711}pojazd{DEDEDE} musi on byÊ zespawnowany.", "Zamknij", "");
				    return 0;
				}
			    new Float:X, Float:Y, Float:Z;
			    GetVehiclePos(PojazdInfo[uid][pID], X, Y, Z);
			    SetPlayerCheckpoint(playerid, X, Y, Z, 5.0);
		        return 1;
			}
			case 1:
			{
				if(!ZarzadzaniePojazdami(uid, playerid))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Brak {88b711}uprawnieÒ{DEDEDE} do tej opcji", "Zamknij", "");
				    return 0;
				}
				if(PojazdInfo[uid][pSpawn] != 0)
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby {88b711}zresetowaÊ{DEDEDE} pojazd na s{88b711}pawnpoint{DEDEDE} musi on byÊ unspawnowany.", "Zamknij", "");
				    return 0;
				}
			    dShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_RESET, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Czy aby na pewno chesz {88b711}zresetowaÊ{DEDEDE} spawnpoint swojego pojazdu?\nPamiÍtaj zresetowanie pozycji {88b711}pojazdu{DEDEDE} wiπøe siÍ z na≥oøeniem blokady na ko≥o o wartoúci {88b711}100{DEDEDE}$", "Tak", "Nie");
		        return 1;
			}
			case 2:
			{
				if(PojazdInfo[uid][pSpawn] != 0)
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby usunπÊ {88b711}pojazd{DEDEDE} musi on byÊ unspawnowany.", "Zamknij", "");
				    return 0;
				}
			    if(!WlascicielGrupyOwnerUID(uid, playerid))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Brak {88b711}uprawnieÒ{DEDEDE} do tej opcji", "Zamknij", "");
				    return 0;
				}
			    dShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_DEL, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Czy aby na pewno chesz {88b711}usunπÊ{DEDEDE} swÛj pojazd z dzia≥alnoúci?\nPamiÍtaj ta {88b711}opcja{DEDEDE} nie jest odwracalna.", "Tak", "Nie");
		        return 1;
			}
			case 3:
			{
				if(!ZarzadzaniePojazdamiDlaDz(uid, playerid, DZIALALNOSC_ZMOTORYZOWANA))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ta opcja jest {88b711}dostÍpna{DEDEDE} tylko dla dzia≥alnoúci przestÍpczych.", "Zamknij", "");
				    return 0;
				}
				if(PojazdInfo[uid][pSpawn] == 0)
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby odpisaÊ {88b711}pojazd{DEDEDE} musi on byÊ zespawnowany.", "Zamknij", "");
				    return 0;
				}
			    dShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_ODPISZ, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ta opcja jest {88b711}niedostÍpna{DEDEDE} dla graczy.", "Zamknij", "");
		        return 1;
			}
		}
	}
	if(dialogid == DIALOG_POJAZD_OPCJE_RESET)
	{
	    if(!response)
		{
		    return 0;
		}
		new uid = GetPVarInt(playerid, "OPCJAPOJAZDY");
		if(PojazdInfo[uid][pSpawn] != 0)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby zresetowaÊ {88b711}pojazd{DEDEDE} musi on byÊ odspawnowany.", "Zamknij", "");
		    return 0;
		}
		PojazdInfo[uid][pBlokada] = 100;
		PojazdInfo[uid][pX] = 929.5447;
		PojazdInfo[uid][pY] = -1221.7166;
		PojazdInfo[uid][pZ] = 16.8016;
		new rok, miesiac, dzien, godzina, minuta, sekunda;
		sekundytodata(gettime()-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
		printf("[UID_POJAZDU:%d][%02d-%02d-%d, %02d:%02d][Reset Pojazdu] Gracz: %s (UID: %d, GUID: %d) zresetowal pojazd (UID: %d) na spawnpoint.[KONIEC_LOGU]",uid, dzien, miesiac, rok, godzina, minuta, ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID], uid);
		//Transakcja(T_VRESET, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 100, uid, -1, -1, "-", gettime()-CZAS_LETNI);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Pojazd zosta≥ {88b711}zresetowany{DEDEDE} na spawnpoint.", "Zamknij", "");
	    return 1;
	}
	if(dialogid == DIALOG_ITEM_CD)
    {
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
            format(PrzedmiotInfo[uid2][pWar3], 124, "%s", inputtext);
		    dShowPlayerDialog(playerid, DIALOG_ITEM_CD2, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Teraz moøesz nadaÊ nazwe {88b711}nagranej{DEDEDE} p≥ycie:", "Zapisz", "Wyjdz");
        }
        else
        {
			format(PrzedmiotInfo[uid2][pWar3], 124, "", inputtext);
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_WEDKA_ZYLKA)
    {
        new uid = strval(inputtext);
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
			if(PrzedmiotInfo[uid][pWar2] != 0)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ta wÍdka {88b711}posiada{DEDEDE} juø nawiniÍtπ øy≥ke.", "Zamknij", "");
				return 0;
			}
            PrzedmiotInfo[uid][pWar2] = 1;
		    UsunPrzedmiot(uid2);
			ZapiszPrzedmiot(uid);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Øy≥ka zosta≥a {88b711}nawiniÍta{DEDEDE} na twojπ wÍdke.", "Zamknij", "");
        }
        else
        {
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_WEDKA_PRZYNETA)
    {
        new uid = strval(inputtext);
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
			if(PrzedmiotInfo[uid2][pWar1] == 1)
			{
				if(!ComparisonString(PrzedmiotInfo[uid][pWar3], "A"))
				{
					PrzedmiotInfo[uid][pWar4] = PrzedmiotInfo[uid2][pWar2];
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Stara przyneta jest inna niz wybrana przez Ciebie, wiec zostala zamieniona na nowa.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				else
				{
					PrzedmiotInfo[uid][pWar4] += PrzedmiotInfo[uid2][pWar2];
				}
				format(PrzedmiotInfo[uid][pWar3], 124, "A");
			}
			if(PrzedmiotInfo[uid2][pWar1] == 2)
			{
				if(!ComparisonString(PrzedmiotInfo[uid][pWar3], "B"))
				{
					PrzedmiotInfo[uid][pWar4] = PrzedmiotInfo[uid2][pWar2];
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Stara przyneta jest inna niz wybrana przez Ciebie, wiec zostala zamieniona na nowa.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				else
				{
					PrzedmiotInfo[uid][pWar4] += PrzedmiotInfo[uid2][pWar2];
				}
				format(PrzedmiotInfo[uid][pWar3], 124, "B");
			}
			if(PrzedmiotInfo[uid2][pWar1] == 3)
			{
				if(!ComparisonString(PrzedmiotInfo[uid][pWar3], "C"))
				{
					PrzedmiotInfo[uid][pWar4] = PrzedmiotInfo[uid2][pWar2];
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Stara przyneta jest inna niz wybrana przez Ciebie, wiec zostala zamieniona na nowa.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
				else
				{
					PrzedmiotInfo[uid][pWar4] += PrzedmiotInfo[uid2][pWar2];
				}
				format(PrzedmiotInfo[uid][pWar3], 124, "C");
			}
            PrzedmiotInfo[uid][pWar4] += PrzedmiotInfo[uid2][pWar2];
		    UsunPrzedmiot(uid2);
			ZapiszPrzedmiot(uid);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}PrzynÍta zosta≥a {88b711}na≥oøona{DEDEDE} na haczyk.", "Zamknij", "");
        }
        else
        {
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_WEDKA_HACZYK)
    {
        new uid = strval(inputtext);
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
			if(PrzedmiotInfo[uid][pWar1] != 0)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ta wÍdka {88b711}posiada juø haczyk.", "Zamknij", "");
				return 0;
			}
            PrzedmiotInfo[uid][pWar1] = 1;
		    UsunPrzedmiot(uid2);
			ZapiszPrzedmiot(uid);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Haczyk zosta≥ {88b711}przywiπzoany{DEDEDE} do øy≥ki..", "Zamknij", "");
        }
        else
        {
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_AMMO_NALADUJ)
    {
        new uid = strval(inputtext);
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
			if(PrzedmiotInfo[uid][pUzywany] != 0)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Przedmiot do ktÛrego chcesz za≥adowaÊ {88b711}amunicje{DEDEDE} nie moøe byÊ uøywany.", "Zamknij", "");
				return 0;
			}
            PrzedmiotInfo[uid][pWar2] += PrzedmiotInfo[uid2][pWar2];
		    UsunPrzedmiot(uid2);
			ZapiszPrzedmiot(uid);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Amunicja zosta≥a {88b711}w≥oøona{DEDEDE} do magazynku.", "Zamknij", "");
        }
        else
        {
            return 1;
        }
        return 1;
    }
    if(dialogid == DIALOG_ITEM_CD2)
    {
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
            format(PrzedmiotInfo[uid2][pNazwa], 32, "CD: %s", inputtext);
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}P≥ytka zosta≥a {88b711}nagrana pomyúlnie.", "Zamknij", "");
		    ZapiszPrzedmiot(uid2);
		}
        else
        {
            return 1;
        }
        return 1;
    }
	if(dialogid == DIALOG_POJAZD_OPCJE_DEL)
	{
	    if(!response)
		{
		    return 0;
		}
		new uid = GetPVarInt(playerid, "OPCJAPOJAZDY");
		UsunPojazd(uid);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Pojazd zosta≥ {88b711}usuniÍty{DEDEDE}.", "Zamknij", "");
	    return 1;
	}
	if(dialogid == DIALOG_POJAZD_OPCJE_ODPISZ)
	{
	    if(!response)
		{
		    return 0;
		}
		new uid = GetPVarInt(playerid, "OPCJAPOJAZDY");
		if(PojazdInfo[uid][pSpawn] == 0)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Aby {88b711}zresetowaÊ{DEDEDE} pojazd musi on byÊ zespawnowany.", "Zamknij", "");
		    return 0;
		}
		PojazdInfo[uid][pOwnerPostac] = DaneGracza[playerid][gUID];
		//Transakcja(T_VODP, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uid, PojazdInfo[uid][pOwnerDzialalnosc], -1, "-", gettime()-CZAS_LETNI);
		new rok, miesiac, dzien, godzina, minuta, sekunda;
		sekundytodata(gettime()-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
		printf("[UID_POJAZDU:%d][%02d-%02d-%d, %02d:%02d][Odpisanie Pojazdu] Gracz: %s (UID: %d, GUID: %d) odpisal pojazd (UID: %d) z dzia≥alnosci (UID: %d).[KONIEC_LOGU]",uid, dzien, miesiac, rok, godzina, minuta, ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID], uid, PojazdInfo[uid][pOwnerDzialalnosc]);
		PojazdInfo[uid][pOwnerDzialalnosc] = 0;
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Pojazd zosta≥ {88b711}odpisany{DEDEDE} od dzia≥alnoúci.", "Zamknij", "");
	    return 1;
	}
	if(dialogid == DIALOG_PRZEDZMIOTY_PODNIES)
	{
	    if(response)
		{
		    new uid = strval(inputtext);
		    if(!IsPlayerInRangeOfPoint(playerid, 3, PrzedmiotInfo[uid][pX], PrzedmiotInfo[uid][pY], PrzedmiotInfo[uid][pZ]) && PrzedmiotInfo[uid][pTypWlas] != TYP_ULICA)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten przedmiot nie {88b711}znajduje{DEDEDE} siÍ obok Ciebie!", "Zamknij", "");
			    return 1;
			}
			PrzedmiotInfo[uid][pX] = 0;
			PrzedmiotInfo[uid][pY] = 0;
			PrzedmiotInfo[uid][pZ] = 0;
			PrzedmiotInfo[uid][pVW] = 0;
			PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
			PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
			DestroyDynamicObject(PrzedmiotInfo[uid][pIDOB]);
		    ZapiszPrzedmiot(uid);
			strdel(tekst_global, 0, 2048);
		    Transakcja(T_IPODNIES, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uid, PrzedmiotInfo[uid][pTyp], PrzedmiotInfo[uid][pWar1], "-", gettime()-CZAS_LETNI);
		    format(tekst_global, sizeof(tekst_global), "* %s podnosi przedmiot %s.", ZmianaNicku(playerid), PrzedmiotInfo[uid][pNazwa]);
			SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, tekst_global, 10);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		}
		else return 1;
	}
	if(dialogid == DIALOG_PRZEDZMIOTY_PODNIES_VEH)
	{
	    if(response)
		{
			strdel(tekst_global, 0, 2048);
		    new uid = strval(inputtext);
			PrzedmiotInfo[uid][pX] = 0;
			PrzedmiotInfo[uid][pY] = 0;
			PrzedmiotInfo[uid][pZ] = 0;
			PrzedmiotInfo[uid][pVW] = 0;
			PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
			PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
		    ZapiszPrzedmiot(uid);
		    Transakcja(T_IPODNIES, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uid, PrzedmiotInfo[uid][pTyp], PrzedmiotInfo[uid][pWar1], "-", gettime()-CZAS_LETNI);
		    format(tekst_global, sizeof(tekst_global), "* %s podnosi przedmiot %s.", ZmianaNicku(playerid), PrzedmiotInfo[uid][pNazwa]);
			SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, tekst_global, 10);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		}
		else return 1;
	}
	if(dialogid == DIALOG_DZIALALNOSCI)//{DEDEDE}ª  {88B711}Uøyj
	{
	    if(response)
		{
			if(listitem > 2)
			{
				if(!GraczPremium(playerid))
				{
					return 0;
				}
			}
		    SetPVarInt(playerid, "NRZLISTY", strval(inputtext));
		    dShowPlayerDialog(playerid, DIALOG_DZIALALNOSCI_OPCJE, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}:", "{DEDEDE}ª  {88B711}Wejdz na s≥uøbe\n{DEDEDE}ª  {88B711}Informacje\n{DEDEDE}ª  {88B711}Magazyn\n{DEDEDE}ª  {88B711}Pracownicy\n{DEDEDE}ª  {88B711}Zadania dzia≥alnoúci\n{DEDEDE}ª  {88B711}Pojazdy dzia≥alnoúci\n{DEDEDE}ª  {88B711}Namierz pojazdy dzia≥alnoúci", "Wybierz", "Zamknij");
		}
		else return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE)
	{
	    if(response)
		{
			switch(listitem)
			{
				case 1:
				{
        			new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					strdel(tekst_global, 0, 2048);
					format(tekst_global, sizeof(tekst_global), "%s~y~%s~n~~n~~p~Owner:~w~ %d:%d  UID: %d  Obiekty: %d~n~~r~Wejscie:~w~ %0.02f,  %0.02f,  %0.02f", tekst_global,NieruchomoscInfo[uids][nAdres],NieruchomoscInfo[uids][nWlascicielP],NieruchomoscInfo[uids][nWlascicielD],NieruchomoscInfo[uids][nUID],NieruchomoscInfo[uids][nLiczbaMebli],NieruchomoscInfo[uids][nX],NieruchomoscInfo[uids][nY],NieruchomoscInfo[uids][nZ],NieruchomoscInfo[uids][nXW],NieruchomoscInfo[uids][nYW],NieruchomoscInfo[uids][nZW]);
					format(tekst_global, sizeof(tekst_global), "%s~n~~r~Wyjscie:~w~ %0.02f,  %0.02f,  %0.02f", tekst_global,NieruchomoscInfo[uids][nXW],NieruchomoscInfo[uids][nYW],NieruchomoscInfo[uids][nZW]);
					format(tekst_global, sizeof(tekst_global), "%s~n~~n~~b~Vw: ~w~%d~b~  Int:~w~ %d~n~~b~Zew. Vw: ~w~%d~b~  Zew.Int: ~w~%d~n~~b~Stw. obiekty: ~w~%d", tekst_global,NieruchomoscInfo[uids][nVW],NieruchomoscInfo[uids][nINT],NieruchomoscInfo[uids][nVWW],NieruchomoscInfo[uids][nINTW],NieruchomoscInfo[uids][nStworzoneObiekty]);
					TextDrawSetString(OBJ[playerid], tekst_global);
					TextDrawShowForPlayer(playerid, OBJ[playerid]);
					SetTimerEx("NapisUsunsV",15000,0,"d",playerid);
					return 1;
				}
				case 2:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_OB, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy na pewno chcesz {88b711}dokupiÊ{DEDEDE} obiekt do tego budynku?", "Tak", "Nie");
					return 1;
				}
				case 3:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_NP, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy na pewno chcesz {88b711}dokupiÊ{DEDEDE} napis do tego budynku?", "Tak", "Nie");
					return 1;
				}
				case 4:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    if(NieruchomoscInfo[uids][nAudio] == -1)
				    {
				    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_HIFI, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy chcesz zakupiÊ {88b711}System Audio{DEDEDE} za kwote {88b711}5000{DEDEDE}$?", "Tak", "Nie");
				    }
				    if(NieruchomoscInfo[uids][nAudio] == 0)
				    {
				        new found = 0;
						strdel(tekst_global, 0, 2048);
						ForeachEx(i, MAX_PRZEDMIOT)
						{
							if(PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL&& PrzedmiotInfo[i][pTyp] == P_CD && !ComparisonString(PrzedmiotInfo[i][pWar3], ""))
							{
								format(tekst_global, sizeof(tekst_global), "%s\n%d\t%s", tekst_global, PrzedmiotInfo[i][pUID], PrzedmiotInfo[i][pNazwa]);
								found++;
							}
						}
						if(found != 0) dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_CD, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", tekst_global, "Wybierz", "Zamknij");
						else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz przy {88b711}sobie{DEDEDE} p≥ytek CD.", "Zamknij", "");
				    }
				    if(NieruchomoscInfo[uids][nAudio] == 1)
				    {
				        foreach(Player, i)
						{
				            if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
				            {
								if(Discman[i] == 0)
								{
									if(IsPlayerInAnyVehicle(i))
									{
										new vehicleid=GetPlayerVehicleID(i);
										new uid = SprawdzCarUID(vehicleid);
										if(PojazdInfo[uid][pAudioStream] == 0) 
										{
											StopAudioStreamForPlayer(i);
										}
									}
									else
									{
										StopAudioStreamForPlayer(i);
									}
								}
								NieruchomoscInfo[uids][nAudio] = 0;
								ZapiszNieruchomosc(uids);
		    				}
						}
						return 1;
					}
				}
				case 5:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					if(NieruchomoscInfo[uids][nSzafa] == -1)
				    {
						dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SZAFA, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "Czy chcesz zakupiÊ {88b711}szafe{DEDEDE} za kwote {88b711}4000{DEDEDE}$?", "Tak", "Nie");
					}
					else
					{
						if(!ZarzadzanieSzafa(GetPlayerVirtualWorld(playerid), playerid))
						{
							GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
							return 0;
						}
						Przedmioty(playerid, playerid, DIALOG_SZAFA, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Szafa{88b711}:", TYP_SZAFA, uids);
					}
					return 1;
				}
				case 7:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WN, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz nowπ {88b711}nazwe{DEDEDE} w pole niøej max {88b711}3-15{DEDEDE} znaki.", "Zatwierdz", "Zamknij");
					return 1;
				}
				case 8:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WP, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy na pewno chcesz zmieniÊ {88b711}standardowy{DEDEDE} spawn budynku?\nJeúli tak przepisz s≥owo: ''{88b711}potwierdzam{DEDEDE}'' w poniøsze pole.", "Tak", "Nie");
					return 1;
				}
				case 9:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_PP, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy chcesz {88b711}w≥πczyÊ{DEDEDE} przejazd pojazdami?", "W≥πcz", "Wy≥πcz");
					return 1;
				}
				case 10:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    if(NieruchomoscInfo[uids][nWlascicielD] != 0)
				    {
					    if(NieruchomoscInfo[uids][nOdpis] == 1)
						{
						    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten budynek {88b711}nie{DEDEDE} moøe zostaÊ odpisany.", "Zamknij", "");
			 				return 0;
						}
						if(GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gOwnerUID] == DaneGracza[playerid][gUID])
						{
							dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_BP, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "0.\t{88b711}ª {DEDEDE}Przepisz budynek na tπ postaÊ.", "Wybierz", "Zamknij");
							return 1;
						}
						else
						{
							dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie moøesz odpisaÊ tego budnku, poniewaø {88b711}nie jesteú{DEDEDE} w≥asicicelem dzia≥alnoúci do ktÛrej jest on podpisany.", "Zamknij", "");
							return 0;
						}
					}
					else
					{
						/*if(NieruchomoscInfo[uids][nVW] == 0)
						{
							new poprawnosc = 0;
							ForeachEx(i, NieruchomoscInfo[uids][nStworzoneObiekty])
							{
								if(ObiektInfo[NieruchomoscInfo[uids][nObiekty][i]][objModel] == 1958 && ObiektInfo[NieruchomoscInfo[uids][nObiekty][i]][objvWorld] == NieruchomoscInfo[uids][nVWW])
								{
									poprawnosc = 1;
									break;
								}
							}
							if(DaneGracza[playerid][gAdmGroup] == 4)
							{
								poprawnosc = 1;
							}
							if(poprawnosc == 0)
							{
								dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W tym budynku nie ma zamontowanej {88b711}instalacji elektrycznej{DEDEDE} dlatego nie moøe zostaÊ nigdzie przypisany!\nWezwij elektryka aby rozwmiπzaÊ ten problem.", "Zamknij", "");
								return 0;
							}
							POD_DZIALALNOSC(playerid, DIALOG_PODPISZ_BUDYNEK);
						}
						else
						{
							POD_DZIALALNOSC(playerid, DIALOG_PODPISZ_BUDYNEK);
						}*/
						POD_DZIALALNOSC(playerid, DIALOG_PODPISZ_BUDYNEK);
				    }
					return 1;
				}
				case 11:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
				    if(NieruchomoscInfo[uids][nWlascicielP] == DaneGracza[playerid][gUID] && NieruchomoscInfo[uids][nWlascicielD] == 0 || DaneGracza[playerid][gAdmGroup] == 4)
				    {
						dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SP, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz {88b711}kwote{DEDEDE} za jakπ chcesz sprzedaÊ budynek:", "Zatwierdz", "Zamknij");
					}else{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten {88b711}budynek{DEDEDE} nie naleøy do ciebie.", "Zamknij", "");
					}
					return 1;
				}
				case 12:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					if(OwnerDzialalnosci(uids, playerid))
					{
						dShowPlayerDialog(playerid, DIALOG_TOKKEN, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy aby na pewno chcesz {88b711}usunπÊ{DEDEDE} wszystkie obiekty naleøπce do tej nieruchomoúci?", "Dalej", "Zamknij");
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
					}

				    return 1;
				}
				case 13:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
				    if(!GraczPremium(playerid))
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta funkcja wymaga {FFFF00}Konta Premium.", "Zamknij", "");
						return 0;
					}
					if(NieruchomoscInfo[uids][nMapa] == 0)
					{
					    if(GraczWbudynku(uids) != -1)
					    {
					        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie moøesz tego {88b711}zrobiÊ{DEDEDE} poniewaø ktoú uøywa {88b711}edytora{DEDEDE} w budynku.", "Zamknij", "");

							return 0;
					    }
					    NieruchomoscInfo[uids][nMapa] = 1;
					    ZapiszNieruchomosc(uids);
					    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Teraz moøesz siÍ udaÊ do {88b711}panelu{DEDEDE} dzia≥alnoúci gospodarczych na forum, aby wgraÊ {88b711}mapÍ{DEDEDE} obiektÛw.", "Zamknij", "");
					}else{
					    UaktualnijObiektyWBudynku(uids);
					    UnloadObject(uids);
	    				LoadObject(uids);
	    				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Mapa {88b711}obiektÛw{DEDEDE} zosta≥a wczytana.", "Zamknij", "");
	    				NieruchomoscInfo[uids][nMapa] = 0;
					    ZapiszNieruchomosc(uids);
					}
				    return 1;
				}
				case 14:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
					if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					if(NieruchomoscInfo[uids][nStworzoneObiekty] == 0)
					{
						GameTextForPlayer(playerid, "~r~W tym budynku nie ma stworzonych obiektow.", 3000, 5);
						return 0;
					}
					//SELECT * FROM mybb_users ORDER BY gamepoint DESC LIMIT 10
					format(zapyt, sizeof(zapyt), "SELECT `ID` FROM `five_obiekty` WHERE `vw` = '%d' ORDER BY `CZAS` DESC LIMIT 1", uids);
					mysql_query(zapyt);
					mysql_store_result();
					mysql_fetch_row(zapyt);
					new models;
					sscanf(zapyt, "p<|>d", models);
					UsunObiekt(models);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ostatni {88b711}obiekt{DEDEDE} zosta≥ skasowany.", "Zamknij", "");
					ZapiszNieruchomosc(uids);
				}
				case 15:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
					if(NieruchomoscInfo[uids][nOdpis] == 1)
					{
					    GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			 			return 0;
					}
					if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					if(NieruchomoscInfo[uids][nPickup] == 19470)
					{
						if(NieruchomoscInfo[uids][nTyp] == 0)
						{
							NieruchomoscInfo[uids][nPickup] = 1273;
						}
						else
						{
							NieruchomoscInfo[uids][nPickup] = 1239;
						}
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Z drzwi zosta≥a usuniÍta tabliczka: Na Sprzedaø.", "Zamknij", "");
					}
					else
					{
						NieruchomoscInfo[uids][nPickup] = 19470;
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Na drzwiach zosta≥a ustawiona tabliczka: Na Sprzedaø.", "Zamknij", "");
					}
					ZapiszNieruchomosc(uids);
					DestroyDynamicPickup(NieruchomoscInfo[uids][nID]);
					NieruchomoscInfo[uids][nID] = CreateDynamicPickup(NieruchomoscInfo[uids][nPickup], 1, NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], NieruchomoscInfo[uids][nVW]);
			
				}
				case 17:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥aúciciel budynku w≥aúnie wgrywa {88b711}mape obiektÛw{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostÍpna{DEDEDE} do czasu zakoÒczenia tej operacji.", "Zamknij", "");
						return 0;
					}
					if(NieruchomoscInfo[uids][nTyp] == 0)
					{
						new found = 0;
						strdel(tekst_global, 0, 2048);
						ForeachEx(i, IloscGraczy)
						{
							if(DaneGracza[KtoJestOnline[i]][gUID] && PlayerObokPlayera(playerid, KtoJestOnline[i], 5))
							{
								format(tekst_global, sizeof(tekst_global), "%s\n%d\t%s", tekst_global, KtoJestOnline[i], ZmianaNicku(KtoJestOnline[i]));
								found++;
							}
						}
						if(found != 0) dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WNAJEM, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Wynajem{88b711}:", tekst_global, "Wynajmij", "Zamknij");
						else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby wynajπÊ graczu {88b711}pokÛj{DEDEDE} musi siÍ znajdowaÊ obok ciebie.", "Okej", "Zamknij");
				    }
					else
					{
						if(GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gTyp] == DZIALALNOSC_HOTEL)
						{
							dShowPlayerDialog(playerid, DIALOG_HOTEL_CENA, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz kwote za jakπ ma siÍ {88b711}wynajmowaÊ{DEDEDE} pokÛj w twoim hotelu.\nKwota nie powinna przekraczaÊ {88b711}200{DEDEDE}$", "Zatwierdz", "Zamknij");		
						}
					}
					return 1;
				}
			}
   		}
		else
		{
			return 0;
		}
	}//strval(inputtext)
	if(dialogid == DIALOG_PW2)
	{
		strdel(tekst_global, 0, 2048);
		if(!response) return 0;
		new clickedplayerid = strval(inputtext);
		format(tekst_global, sizeof(tekst_global), "{DEDEDE}WiadomoúÊ do {88b711}gracza{DEDEDE} %s:", ZmianaNicku(clickedplayerid), clickedplayerid);
		dShowPlayerDialog(playerid,DIALOG_PW,DIALOG_STYLE_INPUT,"{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:",tekst_global,"Wyúlij","Zamknij");
		SetPVarInt(playerid, "PM", clickedplayerid);
		return 1;
	}
	if(dialogid == DIALOG_PW)
	{
		if(!response) return 0;
		strdel(tekst_global, 0, 2048);
		format(tekst_global, sizeof(tekst_global), "%d %s", GetPVarInt(playerid, "PM"), inputtext);
		cmd_w(playerid, tekst_global);
		return 1;
	}
	if(dialogid == DIALOG_TOKKEN)
	{
	    if(response)
		{
			new uids = GetPVarInt(playerid, "uiddrzwi");
			format(NieruchomoscInfo[uids][nToken], 256, "%s", TOKKEN(random(1000)));
			format(tekst_global, sizeof(tekst_global), "TwÛj token to: %s", NieruchomoscInfo[uids][nToken]);
			PwForum(DaneGracza[playerid][gGUID], DaneGracza[playerid][gGUID], 9, "Token", tekst_global, gettime()-CZAS_LETNI);
		    dShowPlayerDialog(playerid, DIALOG_TOKKEN_V2, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy na pewno chcesz {88b711}usunπÊ{DEDEDE} wszystkie obiekty w tej nieruchomoúci?\nJeúli tak przepisz {88b711}token{DEDEDE} ktÛry zosta≥ wys≥any na forum jako prywatna wiadomoúÊ:", "Zatwierdz", "Zamknij");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_TOKKEN_V2)
	{
	    if(response)
		{
			new uids = GetPVarInt(playerid, "uiddrzwi");
			if(!ComparisonString(inputtext, NieruchomoscInfo[uids][nToken]))
			{
			    dShowPlayerDialog(playerid, DIALOG_TOKKEN_V2, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czy na pewno chcesz {88b711}usunπÊ{DEDEDE} wszystkie obiekty w tej nieruchomoúci?\nJeúli tak przepisz {88b711}token{DEDEDE} ktÛry zosta≥ wys≥any na forum jako prywatna wiadomoúÊ:", "Zatwierdz", "Zamknij");
			    return 0;
			}
			SkasujIntek(uids);
			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Interior {88b711}budynku{DEDEDE} zosta≥ skasowany.", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_CD)
	{
	    if(response)
		{
		    new idp = strval(inputtext);
            new uids = GetPVarInt(playerid, "uiddrzwi");
            format(NieruchomoscInfo[uids][nRadio], 100, "%s", PrzedmiotInfo[idp][pWar3]);
            foreach(Player, i)
			{
	            if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
	            {
					if(Discman[i] == 0)
					{
						if(IsPlayerInAnyVehicle(i))
						{
							new vehicleid=GetPlayerVehicleID(i);
							new uid = SprawdzCarUID(vehicleid);
							if(PojazdInfo[uid][pAudioStream] == 0) 
							{
								StopAudioStreamForPlayer(i);
								PlayAudioStreamForPlayer(i, NieruchomoscInfo[uids][nRadio], 0, 0, 0, 14.0, 0);
							}
						}
						else
						{
							StopAudioStreamForPlayer(i);
							PlayAudioStreamForPlayer(i, NieruchomoscInfo[uids][nRadio], 0, 0, 0, 14.0, 0);
						}
					}
				}
			}
			NieruchomoscInfo[uids][nAudio] = 1;
   			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}P≥yta zosta≥a {88b711}w≥oøona{DEDEDE} do systmu audio.", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_WP)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			strtolower(inputtext);
			if(!ComparisonString(inputtext, "potwierdzam"))
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}èle {88b711}przepisana{DEDEDE} treúÊ.", "Zamknij", "");
			    return 0;
			}
			new Float:pXs, Float:pYs, Float:pZs, Float:angle;
			GetPlayerPos(playerid, pXs, pYs, pZs);
			GetPlayerFacingAngle(playerid, angle);
			NieruchomoscInfo[uids][nXW] = pXs;
			NieruchomoscInfo[uids][nYW] = pYs;
			NieruchomoscInfo[uids][nZW] = pZs;
			NieruchomoscInfo[uids][naw] = angle;
			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Standardowy {88b711}spawn{DEDEDE} budynku zosta≥ zmienieony.", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_WNAJEM)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			Oferuj(playerid, strval(inputtext), 0, 0, uids, 0, OFEROWANIE_WYNAJMU, 0, "", 0);
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_SP)
	{
	    if(response)
		{
			if(strval(inputtext) < 0)
			{
				dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SP, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz kwote za jakπ chcesz {88b711}sprzedaÊ{DEDEDE} budynek:\nKwota musi byÊ {88b711}wiÍksza{DEDEDE} od 0.", "Zatwierdz", "Zamknij");
				return 1;
			}
            SetPVarInt(playerid, "CenaBudynku",strval(inputtext));
            new found = 0;
			strdel(tekst_global, 0, 2048);
			ForeachEx(i, IloscGraczy)
			{
			    if(DaneGracza[KtoJestOnline[i]][gUID] && PlayerObokPlayera(playerid, KtoJestOnline[i], 5) && KtoJestOnline[i] != playerid)
			    {
					format(tekst_global, sizeof(tekst_global), "%s\n%d\t%s", tekst_global, KtoJestOnline[i], ZmianaNicku(KtoJestOnline[i]));
					found++;
				}
			}
			if(found != 0) dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SP_G, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}NieruchomoúÊ{88b711}:", tekst_global, "Oferuj", "Zamknij");
			else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nikt {88b711}obok{DEDEDE} Ciebie siÍ nie znajduje.", "Okej", "Zamknij");
	    }
	    return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_SP_G)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
		    Transakcja(T_HOFFER, DaneGracza[playerid][gUID], DaneGracza[strval(inputtext)][gUID], DaneGracza[playerid][gGUID], DaneGracza[strval(inputtext)][gGUID], GetPVarInt(playerid, "CenaBudynku"), uids, -1, -1, "-", gettime()-CZAS_LETNI);
			Oferuj(playerid, strval(inputtext), 0, 0, uids, 0, OFEROWANIE_BUDYNKU, GetPVarInt(playerid, "CenaBudynku"), "", 0);
	    }
	    return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_WN)
	{
	    if(response)
		{
			if(strlen(inputtext) > 15 || strlen(inputtext) < 3)
			{
				dShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WN, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz nowπ {88b711}nazwe{DEDEDE} w pole niøej max {88b711}3-15{DEDEDE} znaki.", "Zatwierdz", "Zamknij");
				return 1;
			}
			if(DaneGracza[playerid][gPORTFEL] < 100)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie staÊ ciÍ na {88b711}zmiane{DEDEDE} nazwy tego budynku.", "Zamknij", "");
			    return 1;
			}
			Dodajkase(playerid, -100);
			new uids = GetPVarInt(playerid, "uiddrzwi");
			format(NieruchomoscInfo[uids][nAdres], 50, "%s", inputtext);
   			ZapiszNieruchomosc(uids);
   			Transakcja(T_HZMNAZWY, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 100, uids, -1, -1, inputtext, gettime()-CZAS_LETNI);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nazwa {88b711}budynku{DEDEDE} zosta≥a zmieniona. Kwota ktÛra zosta≥a pobrana to {88b711}100{DEDEDE}$.", "Zamknij", "");
	    }
	    return 1;
	}
	if(dialogid == DIALOG_PODPISZ_BUDYNEK)
	{
	    if(response)
		{
		    new uid = strval(inputtext);
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			if(uid == 1)
			{
		    NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc1];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc1], -1, "-", gettime()-CZAS_LETNI);
			}
			else if(uid == 2)
			{
			NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc2];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc2], -1, "-", gettime()-CZAS_LETNI);
			}
			else if(uid == 3)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc3];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc3], -1, "-", gettime()-CZAS_LETNI);
			}
			else if(uid == 4)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc4];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc4], -1, "-", gettime()-CZAS_LETNI);
			}
			else if(uid == 5)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc5];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc5], -1, "-", gettime()-CZAS_LETNI);
			}
			else if(uid == 6)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc6];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc6], -1, "-", gettime()-CZAS_LETNI);
			}
			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Budynek zosta≥ {88b711}podpisany{DEDEDE} pod dzia≥alnoúÊ.", "Zamknij", "");
			DestroyDynamicMapIcon(NieruchomoscInfo[uids][nIconaID]);
			if(NieruchomoscInfo[uids][nVW] == 0)
			{
				if(NieruchomoscInfo[uids][nWlascicielD] != 0)
				{
					new typ = GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gTyp];
					if(typ == 2 || typ == 11 || typ == 16)
					{
					
					}
					else
					{
						NieruchomoscInfo[uids][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], Ikonki[GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gTyp]][0], 0, NieruchomoscInfo[uids][nVW]);
					}
				}
				else
				{
					if(NieruchomoscInfo[uids][nTyp] == 0)
					{
						NieruchomoscInfo[uids][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], 31, 0, NieruchomoscInfo[uids][nVW]);
					}
					else
					{
						NieruchomoscInfo[uids][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], 56, 0, NieruchomoscInfo[uids][nVW]);
					}
				}
			}
		}
		else
		{
        	//dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Anulowa≥eú transakcje pomyúlnie.", "Zamknij", "");
		}
		return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_BP)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			NieruchomoscInfo[uids][nWlascicielP] = DaneGracza[playerid][gUID];
			Transakcja(T_HODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, NieruchomoscInfo[uids][nWlascicielD], -1, "-", gettime()-CZAS_LETNI);
			NieruchomoscInfo[uids][nWlascicielD] = 0;
			ZapiszNieruchomosc(uids);
			if(NieruchomoscInfo[uids][nVW] == 0)
			{
				if(NieruchomoscInfo[uids][nWlascicielD] != 0)
				{
					new typ = GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gTyp];
					if(typ == 2 || typ == 11 || typ == 16)
					{
					
					}
					else
					{
						NieruchomoscInfo[uids][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], Ikonki[GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gTyp]][0], 0, NieruchomoscInfo[uids][nVW]);
					}
				}
				else
				{
					if(NieruchomoscInfo[uids][nTyp] == 0)
					{
						NieruchomoscInfo[uids][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], 31, 0, NieruchomoscInfo[uids][nVW]);
					}
					else
					{
						NieruchomoscInfo[uids][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[uids][nX], NieruchomoscInfo[uids][nY], NieruchomoscInfo[uids][nZ], 56, 0, NieruchomoscInfo[uids][nVW]);
					}
				}
			}
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Budynek zosta≥ {88b711}przepisany{DEDEDE} na tπ postaÊ.", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_PP)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			NieruchomoscInfo[uids][nPrzejazd] = 1;
			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥πczy≥eú przejazd {88b711}pojazdami{DEDEDE} w tym budynku.", "Zamknij", "");
   		}
		else
		{
			new uids = GetPVarInt(playerid, "uiddrzwi");
			NieruchomoscInfo[uids][nPrzejazd] = 0;
			ZapiszNieruchomosc(uids);
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wy≥πczy≥eú przejazd {88b711}pojazdami{DEDEDE} w tym budynku.", "Zamknij", "");
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_OB)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
		    new obiekty = NieruchomoscInfo[uids][nLiczbaMebli] + NieruchomoscInfo[uids][nStworzoneObiekty];
		    if(obiekty >= 500 )
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten budynek osiπgnπ≥ {88b711}maxymalnπ{DEDEDE} iloúÊ obiektÛw na budynek ({88b711}500{DEDEDE}).", "Zamknij", "");
			    return 0;
			}
			if(DaneGracza[playerid][gPORTFEL] < 500)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie staÊ ciÍ na {88b711}zakup{DEDEDE} obiektu do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -500);
			Transakcja(T_HOBIEKT, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 500, uids, -1, -1, "-", gettime()-CZAS_LETNI);
			NieruchomoscInfo[uids][nLiczbaMebli]++;
			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zakupi≥eú jeden {88b711}obiekt{DEDEDE} do budynku za kwote {88b711}500{DEDEDE}$", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_HIFI)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			if(DaneGracza[playerid][gPORTFEL] < 5000)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie staÊ ciÍ na {88b711}zakup{DEDEDE} systemu audio do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -5000);
			Transakcja(T_HAUDIO, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 5000, uids, -1, -1, "-", gettime()-CZAS_LETNI);
			NieruchomoscInfo[uids][nAudio] = 0;
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt), "UPDATE `five_nieruchomosci` SET `AUDIO` = '%d' WHERE `ID` = '%d'",
			NieruchomoscInfo[uids][nAudio],
			uids);
			mysql_check();
			mysql_query2(zapyt);
			mysql_free_result();
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zakupi≥eú system audio do swojego {88b711}budynku{DEDEDE} za kwote {88b711}5000{DEDEDE}$", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_SZAFA)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			if(DaneGracza[playerid][gPORTFEL] < 4000)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie staÊ ciÍ na {88b711}zakup{DEDEDE} szafy do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -4000);
			Transakcja(T_HSZAFA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 4000, uids, -1, -1, "-", gettime()-CZAS_LETNI);
			NieruchomoscInfo[uids][nSzafa] = 0;
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt), "UPDATE `five_nieruchomosci` SET `SZAFA` = '%d' WHERE `ID` = '%d'",
			NieruchomoscInfo[uids][nSzafa],
			uids);
			mysql_check();
			mysql_query2(zapyt);
			mysql_free_result();
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zakupi≥eú {88b711}szafe{DEDEDE} do swojego budynku za kwote {88b711}4000{DEDEDE}$", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_NP)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			if(DaneGracza[playerid][gPORTFEL] < 500)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie staÊ ciÍ na zakup {88b711}napisu{DEDEDE} do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -500);
			Transakcja(T_HNAPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 500, uids, -1, -1, "-", gettime()-CZAS_LETNI);
			NieruchomoscInfo[uids][nLiczbaNapisow]++;
			ZapiszNieruchomosc(uids);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zakupi≥eú jeden {88b711}napis{DEDEDE} do budynku za kwote {88b711}500{DEDEDE}$", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_HOTEL_PRZED)
	{
		if(!response)
		{
			cmd_wymelduj(playerid, "");
		}	
		else
		{
		new uids = GetPVarInt(playerid, "CENAPRZ");
		if(DaneGracza[playerid][gPORTFEL] < NieruchomoscInfo[uids][nHotel])
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz wystarczajπcej {88b711}gotÛwki{DEDEDE} aby wynajπÊ pokÛj w tym Hotelu.", "Zamknij", "");
			return 0;
		}
		DaneGracza[playerid][gZamHot] = gettime() + (86400*3);
		Dodajkase(playerid, -NieruchomoscInfo[uids][nHotel]);
		GrupaInfo[NieruchomoscInfo[uids][nWlascicielD]][gSaldo] += NieruchomoscInfo[uids][nHotel];
		ZapiszSaldo(NieruchomoscInfo[uids][nWlascicielD]);
		DaneGracza[playerid][gWynajem] = NieruchomoscInfo[uids][nUID];
		ZapiszGracza(playerid);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje {88b711}przed≥uøy≥eú{DEDEDE} pobyt w Hotelu.", "Zamknij", "");
		}
	}
	if(dialogid == DIALOG_HOTEL_CENA)
	{
	    if( !response )
	        return 1;
		new uids = GetPVarInt(playerid, "uiddrzwi");
		new cena = strval(inputtext);
		if(cena > 200 || cena < 0)
		{
			dShowPlayerDialog(playerid, DIALOG_HOTEL_CENA, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz kwote za jakπ ma siÍ {88b711}wynajmowaÊ{DEDEDE} pokÛj w twoim hotelu.\nKwota nie powinna przekraczaÊ {88b711}200{DEDEDE}$", "Zatwierdz", "Zamknij");			
			return 0;
		}
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nowa cena wynajmu {88b711}pokoju{DEDEDE} zosta≥a ustawiona.", "Zatwierdz", "Zamknij");			
		NieruchomoscInfo[uids][nHotel] = cena;
		ZapiszNieruchomosc(uids);
	}
	if(dialogid == DIALOG_BANKOMAT)
	{
	    if( !response )
	        return 1;
        switch(listitem)
		{
			case 0:
			{
				if(DaneGracza[playerid][gSTAN_KONTA] >= 5000)
				{
					if(!Osiagniecia(playerid, OSIAGNIECIE_5K))
					{
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Uczciwe zarobione pieniadze (5000$) ~g~+100GS");
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
						DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_5K] = 1;
						DaneGracza[playerid][gGAMESCORE] += 100;
						SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
						ZapiszGraczaGlobal(playerid, 1);
					}
				}
				if(DaneGracza[playerid][gSTAN_KONTA] >= 25000)
				{
					if(!Osiagniecia(playerid, OSIAGNIECIE_25K))
					{
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Bogacz (25000$) ~g~+1000GS");
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
						DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_25K] = 1;
						DaneGracza[playerid][gGAMESCORE] += 1000;
						SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
						ZapiszGraczaGlobal(playerid, 1);
					}
				}
			    new stri[256];
   			 	format(stri, sizeof(stri), "{DEDEDE}TwÛj stan konta to: {88b711}%d{DEDEDE}$",DaneGracza[playerid][gSTAN_KONTA]);
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", stri, "Zamknij", "");
				return 1;
			}
			case 1:
			{
				dShowPlayerDialog(playerid, DIALOG_BANKOMAT_WYPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wyp≥aciÊ:", "Wyplac", "Zamknij");
				return 1;
			}
			case 2:
			{
				dShowPlayerDialog(playerid, DIALOG_BANKOMAT_WPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} do jakπ chcesz wp≥aciÊ:", "Wplac", "Zamknij");
				return 1;
			}
			case 3:
			{
				dShowPlayerDialog(playerid, DIALOG_BANKOMAT_PRZELEW, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}numer{DEDEDE} konta na ktÛry chcesz {88b711}przelaÊ{DEDEDE} swoje pieniπdze:\nnp: 789456123  - koszt jednego przelewu wynosi: 10$", "Dalej", "Zamknij");
				return 1;
			}
			case 4:
			{
				new found = 0, grupa_bank[512];
				for(new i = 1; i < MAX_GROUP; i++)
				{
					if(DaneGracza[playerid][gDzialalnosc1] == i || DaneGracza[playerid][gDzialalnosc2] == i || DaneGracza[playerid][gDzialalnosc3] == i || DaneGracza[playerid][gDzialalnosc4] == i || DaneGracza[playerid][gDzialalnosc5] == i || DaneGracza[playerid][gDzialalnosc6] == i)
					{
						if(found == 0)
						{
							format(grupa_bank, sizeof(grupa_bank), "%d\t{DEDEDE}ª {88b711}%s",GrupaInfo[i][gUID], GrupaInfo[i][gNazwa]);
						}
						else
						{
							format(grupa_bank, sizeof(grupa_bank), "%s\n%d\t{DEDEDE}ª {88b711}%s", grupa_bank, GrupaInfo[i][gUID], GrupaInfo[i][gNazwa]);
						}
						found++;
					}
				}
				if(found != 0) dShowPlayerDialog(playerid, DIALOG_BANK_GRUPA, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", grupa_bank, "Wybierz", "Zamknij");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie jesteú {88b711}w zπdnej{DEDEDE} dzia≥alnoúci gospodarczej.", "Zamknij", "");
				return 1;
			}
			case 5:
			{
				if(DaneGracza[playerid][gDzialalnosc1] == 0 && DaneGracza[playerid][gDzialalnosc2] == 0 && DaneGracza[playerid][gDzialalnosc3] == 0 && DaneGracza[playerid][gDzialalnosc4] == 0 && DaneGracza[playerid][gDzialalnosc5] == 0 && DaneGracza[playerid][gDzialalnosc6] == 0)
				{
					if(DaneGracza[playerid][gZasilek] > gettime())
					{
						GameTextForPlayer(playerid, "~r~Odebrales juz zasilek, pamietaj zasilek mozna odebrac raz na 24h.", 3000, 5);
					}
					else
					{
						DaneGracza[playerid][gZasilek] = gettime() + (24*60*60);
						Dodajkase(playerid, 50);
						GameTextForPlayer(playerid, "~w~Odebrales zasilek: ~g~~h~+50$.", 3000, 5);
						ZapiszGracza(playerid);
					}
				}
				else
				{
					GameTextForPlayer(playerid, "~r~Zasilek moga odebrac tylko osoby bezrobotne.", 3000, 5);
				}
				return 1;
			}
		}
	}
	if(dialogid == DIALOG_HOTEL)
	{
		if( !response )
			return 1;
		new vw = GetPlayerVirtualWorld(playerid);
		if(DaneGracza[playerid][gPORTFEL] < (NieruchomoscInfo[vw][nHotel]+50))
		{
			dShowPlayerDialog(playerid, DIALOG_HOTEL, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz wystarczajπcej {88b711}gotÛwki{DEDEDE} aby wynajπÊ pokÛj w tym Hotelu.", "Zamknij", "");
			return 0;
		}
		if(!Osiagniecia(playerid, OSIAGNIECIE_ZAMELDOWANIE))
		{
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Zameldowanie ~g~+20GS");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
			DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_ZAMELDOWANIE] = 1;
			DaneGracza[playerid][gGAMESCORE] += 20;
			SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
			ZapiszGraczaGlobal(playerid, 1);
		}
		DaneGracza[playerid][gZamHot] = gettime() + (86400*3);
		Dodajkase(playerid, -(NieruchomoscInfo[vw][nHotel]+50));
		GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gSaldo] += (NieruchomoscInfo[vw][nHotel]+50);
		ZapiszSaldo(NieruchomoscInfo[vw][nWlascicielD]);
		DaneGracza[playerid][gWynajem] = NieruchomoscInfo[vw][nUID];
		ZapiszGracza(playerid);
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `WYNAJEM`='%d' WHERE `ID`='%d'", DaneGracza[playerid][gWynajem], DaneGracza[playerid][gUID]);
	    mysql_query(zapyt);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje {88b711}zameldowa≥eú{DEDEDE} siÍ w Hotelu.", "Zamknij", "");
	}
	if(dialogid == DIALOG_SZAFA)
	{
		if( !response )
			return 1;
		new uid = strval(inputtext);
		if(PrzedmiotInfo[uid][pTypWlas] != TYP_SZAFA || PrzedmiotInfo[uid][pOwner] != GetPlayerVirtualWorld(playerid))
		{
			GameTextForPlayer(playerid, "~r~Brak przedmiotu.", 3000, 5);
			return 0;
		}
		PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
		PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
		ZapiszPrzedmiot(uid);
		GameTextForPlayer(playerid, "~y~Przedmiot zostal wlozony do twojego ekwipunku.", 3000, 5);
		return 1;
	}
	if(dialogid == DIALOG_BANK_GRUPA)
	{
		if( !response )
			return 1;
		new uid = strval(inputtext);
		SetPVarInt(playerid, "UidGrupyBank", uid);
		dShowPlayerDialog(playerid, DIALOG_BANK_GRUPA_OPCJE, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}ª {88b711}Stan konta\n{DEDEDE}ª {88b711}Wyp≥aÊ pieniπdze\n{DEDEDE}ª {88b711}Wp≥aÊ pieniπdze", "Wybierz", "Zamknij");
		return 1;
	}
	if(dialogid == DIALOG_BANK_GRUPA_OPCJE)
	{
	    if( !response )
	        return 1;
        switch(listitem)
		{
			case 0:
			{
				new uidg = GetPVarInt(playerid, "UidGrupyBank");
			    new stri[256];
   			 	format(stri, sizeof(stri), "{DEDEDE}Stank konta dzia≥anoúci: {88b711}%d{DEDEDE}$",GrupaInfo[uidg][gSaldo]);
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", stri, "Zamknij", "");
				return 1;
			}
			case 1:
			{
				new uidg = GetPVarInt(playerid, "UidGrupyBank");
				if(GrupaInfo[uidg][gOwnerUID] == DaneGracza[playerid][gUID])
				{
					dShowPlayerDialog(playerid, DIALOG_BANK_GRUPA_WYPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wyp≥aciÊ:", "Wyplac", "Zamknij");
					return 1;
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Niestety {88b711}nie masz{DEDEDE} uprawnien do wyp≥acania pieniÍdzy ten dzialalnoúci!", "Zamknij", "");
					return 0;
				}
			}
			case 2:
			{
				dShowPlayerDialog(playerid, DIALOG_BANK_GRUPA_WPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wp≥aciÊ:", "Wplac", "Zamknij");
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_BANK_GRUPA_WPLAC)
	{
		if( !response )
			return 1;
		new cash = strval(inputtext);
		new uidg = GetPVarInt(playerid, "UidGrupyBank");
		if(cash < 0) return 1;
		if(cash > DaneGracza[playerid][gPORTFEL])
		{
		    GameTextForPlayer(playerid, "~r~Kwota ~w~ktora podales jest niepoprawna.", 3000, 5);
			dShowPlayerDialog(playerid, DIALOG_BANK_GRUPA_WPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wp≥aciÊ:", "Wplac", "Zamknij");
			return 1;
		}
		GrupaInfo[uidg][gSaldo] += cash;
		Dodajkase(playerid, -cash);
		new stri[256];
		format(stri, sizeof(stri), "~b~Wplacono: ~w~%d$",cash);
		GameTextForPlayer(playerid, stri, 3000, 5);
		ZapiszSaldo(uidg);
		ZapiszGracza(playerid);
		StatykujTransakcje(uidg, playerid, 501, "Wplacil", cash);
		return 1;
	}
	if(dialogid == DIALOG_BANK_GRUPA_WYPLAC)
	{
		if( !response )
			return 1;
		new cash = strval(inputtext);
		new uidg = GetPVarInt(playerid, "UidGrupyBank");
		if(cash < 0) return 1;
		if(cash > GrupaInfo[uidg][gSaldo])
		{
		    GameTextForPlayer(playerid, "~r~Kwota ~w~ktora podales jest niepoprawna.", 3000, 5);
			dShowPlayerDialog(playerid, DIALOG_BANK_GRUPA_WYPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wyp≥aciÊ:", "Wyplac", "Zamknij");
			return 1;
		}
		GrupaInfo[uidg][gSaldo] -= cash;
		Dodajkase(playerid, cash);
		new stri[256];
		format(stri, sizeof(stri), "~b~Wyplacono: ~w~%d$",cash);
		GameTextForPlayer(playerid, stri, 3000, 5);
		ZapiszSaldo(uidg);
		ZapiszGracza(playerid);
		StatykujTransakcje(uidg, playerid, 501, "Wyplacil", cash);
		return 1;
	}
	if(dialogid == DIALOG_BANKOMAT_WYPLAC)
	{
		if( !response )
			return 1;
		new cash = strval(inputtext);
		if(cash < 0) return 1;
		if(cash > DaneGracza[playerid][gSTAN_KONTA])
		{
		    GameTextForPlayer(playerid, "~r~Kwota ~w~ktora podales jest niepoprawna.", 3000, 5);
			dShowPlayerDialog(playerid, DIALOG_BANKOMAT_WYPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wyp≥aciÊ:", "Okej", "Zamknij");
			return 1;
		}
		DaneGracza[playerid][gSTAN_KONTA] -= cash;
		Dodajkase(playerid, cash);
		new stri[256];
		format(stri, sizeof(stri), "~b~Wyplacono: ~w~%d$",cash);
		GameTextForPlayer(playerid, stri, 3000, 5);
		ZapiszGracza(playerid);
		ZapiszBankKasa(playerid);
		Transakcja(T_BWYPLATA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, cash, -1, -1, -1, "-", gettime()-CZAS_LETNI);
		return 1;
	}
	if(dialogid == DIALOG_BANKOMAT_PRZELEW)
	{
		if( !response )
			return 1;
		new nr = strval(inputtext);
		if(nr < 99999999 || nr > 999999999)
		{
		    GameTextForPlayer(playerid, "~r~Numer konta ~w~ktora podales jest niepoprawny.", 3000, 5);
			return 1;
		}
		new find = -1;
		ForeachEx(i, IloscGraczy)
		{
		    new gnr[256];
			format(gnr, sizeof(gnr), "%d",DaneGracza[KtoJestOnline[i]][gNUMER_KONTA]);
			new wnr[256];
			format(wnr, sizeof(wnr), "%d",nr);
		    if(ComparisonString(gnr, wnr))
		    {
		        find = KtoJestOnline[i];
		        break;
		    }
		}
		if(find == -1)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz {88b711}nie{DEDEDE} jest zalogowany!", "Zamknij", "");
		    return 0;
		}else{
			if(find == playerid) return 1;
			if(zalogowany[playerid] == false)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz {88b711}nie{DEDEDE} jest zalogowany!", "Zamknij", "");
				return 0;
			}
			SetPVarInt(playerid, "idprzelew", find);
			new stri[256];
			format(stri, sizeof(stri), "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} ktÛrπ chcesz przelaÊ:\nGracz: {88b711}%s",ZmianaNicku(find));
			dShowPlayerDialog(playerid, DIALOG_BANKOMAT_PRZELEW_N, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", stri, "Przelej", "Zamknij");
		}
		return 1;
	}
	if(dialogid == DIALOG_BANKOMAT_PRZELEW_N)
	{
		if( !response )
			return 1;
		new nr = strval(inputtext);
		if(nr+10 > DaneGracza[playerid][gSTAN_KONTA] || nr <= 0)
		{
		    GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
		    return 0;
		}
		new vw = GetPlayerVirtualWorld(playerid);
    	new uid = NieruchomoscInfo[vw][nWlascicielD];
    	GrupaInfo[uid][gSaldo] += 10;
    	ZapiszSaldo(uid);
		new id = GetPVarInt(playerid, "idprzelew");
		if(zalogowany[id] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz {88b711}nie{DEDEDE} jest zalogowany!", "Zamknij", "");
			return 0;
		}
		DaneGracza[playerid][gSTAN_KONTA] -= nr+10;
		DaneGracza[id][gSTAN_KONTA] += nr;
		ZapiszBankKasa(id);
		ZapiszBankKasa(playerid);
		Transakcja(T_BPRZELEW, DaneGracza[playerid][gUID], DaneGracza[id][gUID], DaneGracza[playerid][gGUID], DaneGracza[id][gGUID], nr, -1, -1, -1, "-", gettime()-CZAS_LETNI);
		DeletePVar(playerid,"idprzelew");
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Przelew zosta≥ {88b711}wykonany{DEDEDE} pomyúlnie!", "Zamknij", "");
		return 1;
	}
    if(dialogid == DIALOG_BANKOMAT_WPLAC)
	{
		if( !response )
			return 1;
		new cash = strval(inputtext);
		if(cash < 0) return 1;
		if(cash > DaneGracza[playerid][gPORTFEL])
		{
		    GameTextForPlayer(playerid, "~r~Kwota ~w~ktora podales jest niepoprawna.", 3000, 5);
			dShowPlayerDialog(playerid, DIALOG_BANKOMAT_WPLAC, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} jakπ chcesz wp≥aciÊ:", "Wplac", "Zamknij");
			return 1;
		}
		DaneGracza[playerid][gSTAN_KONTA] += cash;
		Dodajkase(playerid, -cash);
		new stri[256];
		format(stri, sizeof(stri), "~b~Wplacono: ~w~%d$",cash);
		GameTextForPlayer(playerid, stri, 3000, 5);
		ZapiszGracza(playerid);
		ZapiszBankKasa(playerid);
		Transakcja(T_BWPLATA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, cash, -1, -1, -1, "-", gettime()-CZAS_LETNI);
		return 1;
	}
	if(dialogid == DIALOG_HURTOWNIA)
	{
		if( !response )
			return 1;
        if(listitem == 0)
		{
			return 0;
		}
		else
		{
			new uid = strval(inputtext);
			SetPVarInt(playerid, "UIDHURT", uid);
			dShowPlayerDialog(playerid, DIALOG_HURTOWNIA_NEXT, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Hurtownia{88b711}:", "{DEDEDE}Wpisz iloúc {88b711}paczek{DEDEDE} ktÛre chcesz zamÛwiÊ:", "Dalej", "Zamknij");
		}
	}
	if(dialogid == DIALOG_BEZPIECZNIK)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(AntySpam[playerid][2] == 1)
		{
			return 0;
		}
		AntySpam[playerid][2] = 1;
		SetTimerEx("SpamKomend3",5000,0,"d",playerid);
		if(response)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Bezpiecznik {88b711}w≥πczony{DEDEDE} poprawnie", "Zamknij", "");
			NieruchomoscInfo[vw][nBezpiecznik] = 1;
			WylaczSwiatlo(vw, playerid);
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Bezpiecznik {88b711}wy≥πczony{DEDEDE} poprawnie", "Zamknij", "");
			NieruchomoscInfo[vw][nBezpiecznik] = 0;
			WylaczSwiatlo(vw, playerid);
		}
		ZapiszElektryke(vw);
		ZapiszNieruchomosc(vw);
		return 1;
	}
	if(dialogid == DIALOG_HURTOWNIA_NEXT)
	{
		if( !response )
			return 1;
		new uid = strval(inputtext);
		if(uid <= 0 || uid > 10)
		{
		    dShowPlayerDialog(playerid, DIALOG_HURTOWNIA_NEXT, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Hurtownia{88b711}:", "{DEDEDE}Wpisz iloúc {88b711}paczek{DEDEDE} ktÛre chcesz zamÛwiÊ:\n{88b711}IloúÊ sztuk nie moøe byÊ mniejsza bπdz rÛwna 0.", "Dalej", "Zamknij");
		    return 0;
		}
		SetPVarInt(playerid, "ILOSCHURT", uid);
		dShowPlayerDialog(playerid, DIALOG_HURTOWNIA_KWOTA, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Hurtownia{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} za jakπ chcesz sprzedawaÊ jeden taki produkt:", "Dalej", "Zamknij");
	}
	if(dialogid == DIALOG_HURTOWNIA_KWOTA)
	{
		if( !response )
			return 1;
		new uid = strval(inputtext);
		if(uid <= HurtowniaInfo[GetPVarInt(playerid, "UIDHURT")][hCena])
		{
		    dShowPlayerDialog(playerid, DIALOG_HURTOWNIA_KWOTA, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Hurtownia{88b711}:", "{DEDEDE}Podaj {88b711}kwotÍ{DEDEDE} za jakπ chcesz sprzedawaÊ jeden taki produkt:\n{88b711}Kwota nie moøe byÊ mniejsza bπdz rÛwna cenie hurtowej.", "Dalej", "Zamknij");
		    return 0;
		}
		SetPVarInt(playerid, "CENACHURT", uid);
		SprzedajPrzedmiotH(playerid);
	}
	if(dialogid == DIALOG_GASTRO_KUP)
	{
	    if( !response )
	    {
	        DeletePVar(playerid, "idgrpodaj");
			return 1;
		}
		new uid = strval(inputtext);
		if(MagazynInfo[uid][mIlosc] == 0)
		{
		    GameTextForPlayer(playerid, "~r~Nie ma takiego przedmiotu.", 3000, 5);
		    return 0;
		}
		//new text[246], text2[30];
		new id = GetPVarInt(playerid, "idgrpodaj");
		//sscanf(MagazynInfo[uid][mNazwa], "p<(>s[246]s[30]", text, text2);
		Transakcja(T_OGASTRO, DaneGracza[playerid][gUID], DaneGracza[id][gUID], DaneGracza[playerid][gGUID], DaneGracza[id][gGUID], MagazynInfo[uid][mCena], MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], "-", gettime()-CZAS_LETNI);
		//Oferuj(playerid, GetPVarInt(playerid, "idgrpodaj"), uid, MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], MagazynInfo[uid][mOwner], MagazynInfo[uid][mCena], text);
		Oferuj(playerid, GetPVarInt(playerid, "idgrpodaj"), uid, MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], OFEROWANIE_PODAJ, MagazynInfo[uid][mCena], MagazynInfo[uid][mNazwa], 0);
		return 1;
	}
	if(dialogid == DIALOG_KARTOTEKA_OPCJE)
	{
	    if( !response )
			return 1;
		SetPVarInt(playerid, "UIDWPISU", strval(inputtext));
		dShowPlayerDialog(playerid, DIALOG_KARTOTEKA_OPCJE_NEXT, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Kartoteka{88b711}:", "{DEDEDE}ª {88b711}Informacja o wpisie\n{DEDEDE}ª {88b711}Dodaj wpis\n{DEDEDE}ª {88b711}UsuÒ wpis", "Wybierz", "Zamknij");
		return 1;
	}
	if(dialogid == DIALOG_POMOC)
	{
	    if( !response )
			return 1;
		switch(listitem)
		{
			case 0:
			{
				PoczatekGry(playerid);
			}
			case 1:
			{
				PodstawoweKomendy(playerid);
			}
			case 2:
			{
				ICOOC(playerid);
			}
			case 3:
			{
				Animacje(playerid);
			}
			case 4:
			{
				PrzedmiotyPomoc(playerid);
			}
			case 5:
			{
				Pojazdy(playerid);
			}
			case 6:
			{
				BW(playerid);
			}
			case 7:
			{
				Oferty(playerid);
			}	
			case 8:
			{
				PracaInfo(playerid);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_KARTOTEKA_OPCJE_NEXT)
	{
	    if( !response )
			return 1;
		switch(listitem)
		{
			case 0:
			{
				new uid_wpisu = GetPVarInt(playerid, "UIDWPISU");
				new strkart[256];
				format(strkart, sizeof(strkart), "{DEDEDE}Typ wpisu: {88b711}%s\n{DEDEDE}Data: {88b711}%s\n{DEDEDE}Godzina: {88b711}%s\n{DEDEDE}Wpisa≥: {88b711}%s (UID: %d, GUID: %d)"
				,typ_wpisu_kartoteka[KartotekaInfo[uid_wpisu][kTyp]]
				,KartotekaInfo[uid_wpisu][kData]
				,KartotekaInfo[uid_wpisu][kGodzina]
				,KartotekaInfo[uid_wpisu][kNickN]
				,KartotekaInfo[uid_wpisu][kUIDN]
				,KartotekaInfo[uid_wpisu][kGUIDN]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Kartoteka{88b711}:", strkart, "Zamknij", "");
			}
			case 1:
			{
				dShowPlayerDialog(playerid, DIALOG_KARTOTEKA_WPIS_NEXT, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Kartoteka{88b711}:", "{DEDEDE}Podaj {88b711}powÛd{DEDEDE} wpisu:", "Wpisz", "Zamknij");
			}
			case 2:
			{
				if(!MaUprawnieie(playerid, 35))
				{
					GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
					return 0;
				}
				new uid_wpisu = GetPVarInt(playerid, "UIDWPISU");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpis zosta≥ {88b711}usuniÍty{DEDEDE}.", "Zamknij", "");
				UsunKartoteka(uid_wpisu);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_KARTOTEKA_WPIS)
	{
	    if( !response )
			return 1;
		dShowPlayerDialog(playerid, DIALOG_KARTOTEKA_WPIS_NEXT, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Kartoteka{88b711}:", "{DEDEDE}Podaj {88b711}powÛd{DEDEDE} wpisu:", "Wpisz", "Zamknij");
		return 1;
	}
	if(dialogid == DIALOG_KARTOTEKA_WPIS_NEXT)
	{
	    if( !response )
			return 1;
		if(strlen(inputtext) < 3)
		{
			dShowPlayerDialog(playerid, DIALOG_KARTOTEKA_WPIS_NEXT, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Kartoteka{88b711}:", "{DEDEDE}Podaj {88b711}powÛd{DEDEDE} wpisu:", "Wpisz", "Zamknij");
			return 0;
		}
		DodajKartoteke(playerid, GetPVarInt(playerid, "IDKART"), 0, inputtext);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpis zosta≥ {88b711}dodany{DEDEDE}.", "Zamknij", "");
		return 1;
	}
	if(dialogid == DIALOG_PRZEBIERZ)
	{
	    if( !response )
			return 1;
		switch(listitem)
		{
			case 0:
			{
				DaneGracza[playerid][gLskin] = 0;
			    SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
				return 1;
			}
			case 1:
			{
				if(DaneGracza[playerid][gPrzynaleznosci][2] == -1)
				{
					GameTextForPlayer(playerid, "~r~Twoje ubranie sluzbowe nie zostalo przydzielone.", 3000, 5);
					return 0;
				}
				DaneGracza[playerid][gLskin] = DaneGracza[playerid][gPrzynaleznosci][2];
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				return 1;
			}
			case 2:
			{
				if(DaneGracza[playerid][gPrzynaleznosci][8] == -1)
				{
					GameTextForPlayer(playerid, "~r~Twoje ubranie sluzbowe nie zostalo przydzielone.", 3000, 5);
					return 0;
				}
				DaneGracza[playerid][gLskin] = DaneGracza[playerid][gPrzynaleznosci][8];
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				return 1;
			}
			case 3:
			{
				if(DaneGracza[playerid][gPrzynaleznosci][14] == -1)
				{
					GameTextForPlayer(playerid, "~r~Twoje ubranie sluzbowe nie zostalo przydzielone.", 3000, 5);
					return 0;
				}
				DaneGracza[playerid][gLskin] = DaneGracza[playerid][gPrzynaleznosci][14];
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				return 1;
			}
			case 4:
			{
				if(DaneGracza[playerid][gPrzynaleznosci][20] == -1)
				{
					GameTextForPlayer(playerid, "~r~Twoje ubranie sluzbowe nie zostalo przydzielone.", 3000, 5);
					return 0;
				}
				DaneGracza[playerid][gLskin] = DaneGracza[playerid][gPrzynaleznosci][20];
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				return 1;
			}
			case 5:
			{
				if(DaneGracza[playerid][gPrzynaleznosci][26] == -1)
				{
					GameTextForPlayer(playerid, "~r~Twoje ubranie sluzbowe nie zostalo przydzielone.", 3000, 5);
					return 0;
				}
				DaneGracza[playerid][gLskin] = DaneGracza[playerid][gPrzynaleznosci][26];
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				return 1;
			}
			case 6:
			{
				if(DaneGracza[playerid][gPrzynaleznosci][32] == -1)
				{
					GameTextForPlayer(playerid, "~r~Twoje ubranie sluzbowe nie zostalo przydzielone.", 3000, 5);
					return 0;
				}
				DaneGracza[playerid][gLskin] = DaneGracza[playerid][gPrzynaleznosci][32];
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_247_KUP)
	{
	    if( !response )
			return 1;
		new uid = strval(inputtext);

		if(MagazynInfo[uid][mCena] > DaneGracza[playerid][gPORTFEL])
		{
		    GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
			return 0;
		}
		if(MagazynInfo[uid][mIlosc] == 0)
		{
		    GameTextForPlayer(playerid, "~r~Nie ma takiego przedmiotu.", 3000, 5);
		    return 0;
		}
		Dodajkase(playerid, -MagazynInfo[uid][mCena]);
		//new text[246], strp[124], text2[30];
		new strp[124];
		//sscanf(MagazynInfo[uid][mNazwa], "p<(>s[246]s[30]", text, text2);
		format(strp, sizeof(strp), "~b~Zakupiono przedmiot:~n~ ~w~%s~n~~y~Koszt: ~w~%d$",MagazynInfo[uid][mNazwa], MagazynInfo[uid][mCena]);
		GameTextForPlayer(playerid, strp, 5000, 5);
		DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], MagazynInfo[uid][mNazwa], DaneGracza[playerid][gUID], 0, -1, 0, 0,0, "");
		new vw = GetPlayerVirtualWorld(playerid);
    	new uidp = NieruchomoscInfo[vw][nWlascicielD];
    	GrupaInfo[uidp][gSaldo] += MagazynInfo[uid][mCena];
    	Transakcja(T_247K, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, MagazynInfo[uid][mCena], MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], uidp, "-", gettime()-CZAS_LETNI);
		ZapiszSaldo(uidp);
		/*new strpa[256];
		format(strpa, sizeof(strpa), "Sprzedal: %s",text);
		StatykujTransakcje(uidp, 502, playerid, strpa, MagazynInfo[uid][mCena]);*/
		//ZapiszStanKonta(playerid);
		if(MagazynInfo[uid][mIlosc] == 1)
		{
		    UsunMagazyn(uid);
		    return 1;
		}
		else
		{
		    MagazynInfo[uid][mIlosc]--;
		    ZapiszMagazyn(uid);
		}
		return 1;
	}
	if(dialogid == DIALOG_BANK_KONTO)
	{
	    if( !response )
			return 1;
		if(20 > DaneGracza[playerid][gPORTFEL])
		{
		    GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
			return 1;
		}
		new vw = GetPlayerVirtualWorld(playerid);
    	new uid = NieruchomoscInfo[vw][nWlascicielD];
    	GrupaInfo[uid][gSaldo] += 20;
		Dodajkase(playerid, -20);

		new nrkarty = 747562131 + DaneGracza[playerid][gUID];
		new test[124];
		strdel(tekst_global, 0, 2048);
		format(test, sizeof(test), "%s", iban(playerid));
		format(tekst_global, sizeof(tekst_global), "%s", test);
		for(new i=4; i < strlen(tekst_global); i+=5)
			strins(tekst_global, " ", i);
        new nrkonta = 100000000 + random(899999999);
        new cos = nrkontasprawdz(nrkonta);
		DodajKontoWBanku(playerid, GrupaInfo[uid][gNazwa], cos, nrkarty, "Los Santos", tekst_global, DaneGracza[playerid][gUID], GrupaInfo[uid][gUID]);
		ZapiszSaldo(uid);
		ZapiszGracza(playerid);
		Transakcja(T_KWB, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 20, uid, -1, -1, "-", gettime()-CZAS_LETNI);
		new stri[254];
		format(stri, sizeof(stri), "{DEDEDE}W≥aúnie uda≥o ci siÍ {88b711}za≥oøyÊ{DEDEDE} konto w banku. \
		\n{DEDEDE}Numer konta: {88b711}%d\n{DEDEDE}Numer karty: {88b711}%d\n{DEDEDE}BIC: {88b711}Los Santos\n{DEDEDE}IBAN: {88b711}%s", cos, nrkarty, tekst_global);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Bank{88b711}:", stri, "Zamknij", "");
		return 1;
	}
	if(dialogid == DIALOG_SALON_POJAZDOW_KUP)
	{
		if( !response )
	        return 1;
		new uid = strval(inputtext);
		SetPVarInt(playerid, "uidsalon", uid);
		new stri[512];
		format(stri, sizeof(stri), "{DEDEDE}Czy aby na pewno chcesz kupiÊ ten pojazd?\n{88b711}ª {FFFFFF}Pojazd: {88b711}%s\n{88b711}ª {FFFFFF}Cena: {88b711}%d{DEDEDE}$\n{88b711}ª {FFFFFF}Typ: {88b711}%s{DEDEDE}\n{DEDEDE}Jeúli jesteú pewien zakupu wpisz w poniøsze pole '{88b711}potwierdzam{DEDEDE}' nastÍpnie zatwierdz swÛj wybÛr.", GetVehicleModelName(HurtowniaInfo[uid][hWar1]), HurtowniaInfo[uid][hCena], TypPojazdow[HurtowniaInfo[uid][hWar2]]);
		dShowPlayerDialog(playerid, DIALOG_SALON_POJAZDOW_KUP_N, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Salon PojazdÛw{88b711}:", stri, "Kup", "OdrzuÊ");
		
	}
	if(dialogid == DIALOG_SALON_POJAZDOW_KUP_N)
	{
		if( !response )
	        return 1;
		strtoupper(inputtext);
		new uid = GetPVarInt(playerid, "uidsalon");
		if(ComparisonString(inputtext, "POTWIERDZAM"))
		{
			if(DaneGracza[playerid][gPORTFEL] < HurtowniaInfo[uid][hCena])
			{
			    new stri[512];
				format(stri, sizeof(stri), "{DEDEDE}Czy aby na pewno chcesz kupiÊ ten pojazd?\n{88b711}ª {FFFFFF}Pojazd: {88b711}%s\n{88b711}ª {FFFFFF}Cena: {88b711}%d{DEDEDE}$\n{88b711}ª {FFFFFF}Typ: {88b711}%s{DEDEDE}\n{DEDEDE}Jeúli jesteú pewien zakupu wpisz w poniøsze pole '{88b711}potwierdzam{DEDEDE}' nastÍpnie zatwierdz swÛj wybÛr.\n{88b711}Nie posiadasz przy sobie takiej gotÛwki.", GetVehicleModelName(HurtowniaInfo[uid][hWar1]), HurtowniaInfo[uid][hCena], TypPojazdow[HurtowniaInfo[uid][hWar2]]);
				dShowPlayerDialog(playerid, DIALOG_SALON_POJAZDOW_KUP_N, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Salon PojazdÛw{88b711}:", stri, "Kup", "OdrzuÊ");
			}
			else
			{
				Dodajkase(playerid, -HurtowniaInfo[uid][hCena]);
				DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, HurtowniaInfo[uid][hTypP], HurtowniaInfo[uid][hWar1], HurtowniaInfo[uid][hWar2], HurtowniaInfo[uid][hNazwa], DaneGracza[playerid][gUID], 0, -1, HurtowniaInfo[uid][hCena], 0,0, "");
				new stri[512];
				format(stri, sizeof(stri),  "{DEDEDE}Gratulacje zakupu {88b711}nowego{DEDEDE} pojazdu, jest on w≥aúnie produkowany w {88b711}Fabryce{DEDEDE} gdzie bÍdziesz mÛg≥ go odebraÊ. \nAby siÍ tam dostaÊ, wezwij {88b711}taksÛwke{DEDEDE} korzystajπc z budki telefonicznej bπdz telefonu komÛrkowego. \nDokument {88b711}potwierdzajπcy{DEDEDE} zakup pojazu zosta≥ dodany do twojego {88b711}ekwipunku{DEDEDE}, ktÛry bÍdzie wymagany przy {88b711}odbiorze{DEDEDE} pojazdu.");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:",  stri, "Zamknij", "");
				DeletePVar(playerid,"uidsalon");
			}
		}
		else
		{
			new stri[512];
			format(stri, sizeof(stri), "{DEDEDE}Czy aby na pewno chcesz kupiÊ ten pojazd?\n{88b711}ª {FFFFFF}Pojazd: {88b711}%s\n{88b711}ª {FFFFFF}Cena: {88b711}%d{DEDEDE}$\n{88b711}ª {FFFFFF}Typ: {88b711}%s{DEDEDE}\n{DEDEDE}Jeúli jesteú pewien zakupu wpisz w poniøsze pole '{88b711}potwierdzam{DEDEDE}' nastÍpnie zatwierdz swÛj wybÛr.\n{88b711}TreúÊ potwierdzajπca nie jest poprawna.", GetVehicleModelName(HurtowniaInfo[uid][hWar1]), HurtowniaInfo[uid][hCena], TypPojazdow[HurtowniaInfo[uid][hWar2]]);
			dShowPlayerDialog(playerid, DIALOG_SALON_POJAZDOW_KUP_N, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Salon PojazdÛw{88b711}:", stri, "Kup", "OdrzuÊ");
		}
	}
	if(dialogid == DIALOG_SALON_POJAZDOW)
	{
		if( !response )
	        return 1;
        switch(listitem)
		{
			case 0:
			{
				Salon(playerid, 4, SALON_TANIE);
			}
			case 1:
			{
				Salon(playerid, 4, SALON_POPULARNE_TANIE);
			}
			case 2:
			{
				Salon(playerid, 4, SALON_POPULARNE);
			}
			case 3:
			{
				Salon(playerid, 4, SALON_POPULARNE_LUKSUSOWE);
			}
			case 4:
			{
				Salon(playerid, 4, SALON_SPORT_EXCLUSIVE);
			}
			case 5:
			{
				Salon(playerid, 4, SALON_LODZIE);
			}
			case 6:
			{
				Salon(playerid, 4, SALON_JEDNOSLADY);
			}
			case 7:
			{
				Salon(playerid, 4, SALON_SAMOLOTY_HELI);
			}
			case 8:
			{
				if(!GraczPremium(playerid))
				{
					dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:" ,"{DEDEDE}Nie posiadasz {88b711}konta premium{DEDEDE}.", "Zamknij", "" );
					return 0;
				}
				Salon(playerid, 4, SALON_SPECJALNE);
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_DZIALALNOSCI_OPCJE)
	{
		if( !response )
	        return 1;
  		new nrs = GetPVarInt(playerid, "NRZLISTY");
        switch(listitem)
		{
			case 0:
			{
			    if(nrs == 1)
			    {
	       			cmd_duty(playerid, "1");
	       			return 1;
       			}
       			else if(nrs == 2)
			    {
	       			cmd_duty(playerid, "2");
	       			return 1;
       			}
       			else if(nrs == 3)
			    {
	       			cmd_duty(playerid, "3");
	       			return 1;
       			}
       			else if(nrs == 4)
			    {
	       			cmd_duty(playerid, "4");
	       			return 1;
       			}
       			else if(nrs == 5)
			    {
	       			cmd_duty(playerid, "5");
	       			return 1;
       			}
       			else if(nrs == 6)
			    {
	       			cmd_duty(playerid, "6");
	       			return 1;
       			}
				return 1;
			}
			case 1:
			{
			    new stri[256], strin[256];
			    if(nrs == 1)
			    {
			        new uid = DaneGracza[playerid][gDzialalnosc1];
                    format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW≥aúciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia≥alnoúci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], nrs, GrupaInfo[uid][gKolorCzatu]);
					format(strin, sizeof(strin), "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			    }
			    else if(nrs == 2)
			    {
                    new uid = DaneGracza[playerid][gDzialalnosc2];
                    format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW≥aúciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia≥alnoúci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], nrs, GrupaInfo[uid][gKolorCzatu]);
					format(strin, sizeof(strin), "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			    }
			    else if(nrs == 3)
			    {
                    new uid = DaneGracza[playerid][gDzialalnosc3];
					format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW≥aúciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia≥alnoúci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], nrs, GrupaInfo[uid][gKolorCzatu]);
					format(strin, sizeof(strin), "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			    }
			    else if(nrs == 4)
			    {
                    new uid = DaneGracza[playerid][gDzialalnosc4];
                    format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW≥aúciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia≥alnoúci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], nrs, GrupaInfo[uid][gKolorCzatu]);
					format(strin, sizeof(strin), "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			    }
			    else if(nrs == 5)
			    {
			        new uid = DaneGracza[playerid][gDzialalnosc5];
                    format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW≥aúciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia≥alnoúci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], nrs, GrupaInfo[uid][gKolorCzatu]);
					format(strin, sizeof(strin), "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			    }
			    else if(nrs == 6)
			    {
			        new uid = DaneGracza[playerid][gDzialalnosc6];
			        format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW≥aúciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia≥alnoúci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], nrs, GrupaInfo[uid][gKolorCzatu]);
					format(strin, sizeof(strin), "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
				}
				return 1;
			}
			case 2:
			{
			    if(nrs == 1)
			    {
			    	Magazyn(playerid, DIALOG_INFO, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc1], "Zamknij", "");
				}
				else if(nrs == 2)
			    {
			    	Magazyn(playerid, DIALOG_INFO, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc2], "Zamknij", "");
				}
				else if(nrs == 3)
			    {
			    	Magazyn(playerid, DIALOG_INFO, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc3], "Zamknij", "");
				}
				else if(nrs == 4)
			    {
			    	Magazyn(playerid, DIALOG_INFO, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc4], "Zamknij", "");
				}
				else if(nrs == 5)
			    {
			    	Magazyn(playerid, DIALOG_INFO, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc5], "Zamknij", "");
				}
				else if(nrs == 6)
			    {
			    	Magazyn(playerid, DIALOG_INFO, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Dzia≥alnoúÊ {88b711}ª {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc6], "Zamknij", "");
				}
				return 1;
			}
			case 3:
			{
			    if(nrs == 1)
			    {
				    new str[512], temp = 0;
					ForeachEx(i, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc1] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc1] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc1] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc1] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc1] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc1])
						{
							temp++;
							format(str, sizeof(str), "%s\n{DEDEDE}[ID: %d]\t%s", str, KtoJestOnline[i], ImieGracza2(KtoJestOnline[i]));
						}
					}
					if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracownikÛw na s≥uøbie.", "Zamknij", "");
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista pracownikÛw online{88b711}:", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 2)
			    {
				    new str[512], temp = 0;
					ForeachEx(i, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc2] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc2] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc2] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc2] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc2] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc2])
						{
							temp++;
							format(str, sizeof(str), "%s\n{DEDEDE}[ID: %d]\t%s", str, KtoJestOnline[i], ImieGracza2(KtoJestOnline[i]));
						}
					}
					if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracownikÛw{DEDEDE} na s≥uøbie.", "Zamknij", "");
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista pracownikÛw online{88b711}:", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 3)
			    {
				    new str[512], temp = 0;
					ForeachEx(i, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc3] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc3] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc3] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc3] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc3] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc3])
						{
							temp++;
							format(str, sizeof(str), "%s\n{DEDEDE}[ID: %d]\t%s", str, KtoJestOnline[i], ImieGracza2(KtoJestOnline[i]));
						}
					}
					if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracownikÛw{DEDEDE} na s≥uøbie.", "Zamknij", "");
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista pracownikÛw online{88b711}:", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 4)
			    {
				    new str[512], temp = 0;
					ForeachEx(i, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc4] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc4] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc4] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc4] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc4] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc4])
						{
							temp++;
							format(str, sizeof(str), "%s\n{DEDEDE}[ID: %d]\t%s", str, KtoJestOnline[i], ImieGracza2(KtoJestOnline[i]));
						}
					}
					if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracownikÛw{DEDEDE} na s≥uøbie.", "Zamknij", "");
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista pracownikÛw online{88b711}:", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 5)
			    {
				    new str[512], temp = 0;
					ForeachEx(i, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc5] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc5] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc5] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc5] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc5] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc5])
						{
							temp++;
							format(str, sizeof(str), "%s\n{DEDEDE}[ID: %d]\t%s", str, KtoJestOnline[i], ImieGracza2(KtoJestOnline[i]));
						}
					}
					if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracownikÛw{DEDEDE} na s≥uøbie.", "Zamknij", "");
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista pracownikÛw online{88b711}:", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 6)
			    {
				    new str[512], temp = 0;
					ForeachEx(i, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc6] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc6] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc6] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc6] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc6] ||
						DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc6])
						{
							temp++;
							format(str, sizeof(str), "%s\n{DEDEDE}[ID: %d]\t%s", str, KtoJestOnline[i], ImieGracza2(KtoJestOnline[i]));
						}
					}
					if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracownikÛw{DEDEDE} na s≥uøbie.", "Zamknij", "");
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Lista pracownikÛw online{88b711}:", str, "Zamknij", "");
					return 1;
				}
				return 1;
			}
			case 4:
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Obecnie {88b711}trwajπ{DEDEDE} prace.", "Zamknij", "");
				return 1;
			}
			case 5:
			{
				new	list_vehicles[512], find = 0;
				if(nrs == 1)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc1])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 2)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc2])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{dedede}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 3)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc3])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{dedede}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 4)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc4])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{dedede}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 5)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc5])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{dedede}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 6)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc6])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{dedede}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				return 1;
			}
			case 6:
			{
				new	list_vehicles[512], find = 0;
				if(nrs == 1)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc1] && PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 2)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc2] && PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 3)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc3] && PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 4)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc4] && PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 5)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc5] && PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 6)
				{
					ForeachEx(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc6] && PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "WiÍcej");
					else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia≥alnoúÊ {88b711}nie{DEDEDE} posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				return 1;
			}
		}
	}
	if(dialogid == DIALOG_POKER_ZETONY)
	{
		if(!response)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Anulowa≥eú zakup øetonÛw bez ktÛrych {88b711}nie moøesz{DEDEDE} rozpoczπÊ gry.", "Zamknij", "");
			new id_pokera = DaneGracza[playerid][gPoker];
			for(new i = 0; i < 6; i++)
			{
				if(ObiektInfo[id_pokera][objPoker][i] == playerid)
				{
					ObiektInfo[id_pokera][objPoker][i] = -1;
					DaneGracza[playerid][gPoker] = 0;
					DaneGracza[playerid][gPokerStanowisko] = 0;
					break;
				}
			}
			Frezuj(playerid,1);
			SetCameraBehindPlayer(playerid);
			WpisalKase[playerid] = 0;
			GraWPokera[playerid] = 0;
			return 0;
		}
		else
		{
			new kasa_na_zetony = strval(inputtext);
			if(kasa_na_zetony < 100)
			{
				dShowPlayerDialog(playerid, DIALOG_POKER_ZETONY, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥asnie do≥πczy≥eú do gry w pokera, w poniøsze pole {88b711}wpisz kwotÍ{DEDEDE} jaka ma byÊ przeznaczona na zakup øetonÛw.\nPrzy kwocie {88b711}100$ {DEDEDE}otrzymasz{88b711} 1000${DEDEDE} w øetonach - pamiÍtaj iø moøesz wykupiÊ maksymalnie {88b711}2000${DEDEDE}.\nZnalezione B≥Ídy: {88b711}Zbyt ma≥a kwota wp≥aty{DEDEDE}.", "Zatwierdz", "Zamknij");
				return 0;
			}
			else if(kasa_na_zetony > 2000)
			{
				dShowPlayerDialog(playerid, DIALOG_POKER_ZETONY, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥asnie do≥πczy≥eú do gry w pokera, w poniøsze pole {88b711}wpisz kwotÍ{DEDEDE} jaka ma byÊ przeznaczona na zakup øetonÛw.\nPrzy kwocie {88b711}100$ {DEDEDE}otrzymasz{88b711} 1000${DEDEDE} w øetonach - pamiÍtaj iø moøesz wykupiÊ maksymalnie {88b711}2000${DEDEDE}.\nZnalezione B≥Ídy: {88b711}Zbyt duøa kwota wp≥aty{DEDEDE}.", "Zatwierdz", "Zamknij");
				return 0;
			}
			else if(DaneGracza[playerid][gPORTFEL] < kasa_na_zetony)
			{
				dShowPlayerDialog(playerid, DIALOG_POKER_ZETONY, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥asnie do≥πczy≥eú do gry w pokera, w poniøsze pole {88b711}wpisz kwotÍ{DEDEDE} jaka ma byÊ przeznaczona na zakup øetonÛw.\nPrzy kwocie {88b711}100$ {DEDEDE}otrzymasz{88b711} 1000${DEDEDE} w øetonach - pamiÍtaj iø moøesz wykupiÊ maksymalnie {88b711}2000${DEDEDE}.\nZnalezione B≥Ídy: {88b711}Nie posiadasz tyle pieniÍdzy{DEDEDE}.", "Zatwierdz", "Zamknij");
				return 0;
			}
			else
			{
				GraWPokera[playerid] = 1;
				WpisalKase[playerid] = 0;
				new id_pokera = DaneGracza[playerid][gPoker];
				DaneGracza[playerid][gPokerZetony] = kasa_na_zetony*10;
				Dodajkase(playerid, -kasa_na_zetony);
				PrzeliczZetony(playerid, id_pokera, 0, 0);
				for(new i = 0; i < 6; i++)
				{
					Streamer_Update(ObiektInfo[id_pokera][objPoker][i]);
				}
				RozpocznijPokera(playerid, id_pokera);
			}
		}
	}
	if(dialogid == DIALOG_POKER_PRZEBIJ)
	{
		if(!response)
		{
			if(WybralMozliwoscPoker[playerid] != 0)
			{
				SelectTextDraw(playerid, 0xFFFFFFFF);
			}
			return 0;
		}
		else
		{
			new kwota = strval(inputtext);
			if(kwota < 10)
			{
				dShowPlayerDialog(playerid, DIALOG_POKER_PRZEBIJ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz {88b711}kwotÍ{DEDEDE} ktÛrπ chcesz przebiÊ zak≥ad.\nZnalezione B≥Ídy: {88b711}Zbyt ma≥a kwota przebicia{DEDEDE}.", "Zatwierdz", "Zamknij");
				return 0;
			}
			else if(kwota > DaneGracza[playerid][gPokerZetony])
			{
				dShowPlayerDialog(playerid, DIALOG_POKER_PRZEBIJ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz {88b711}kwotÍ{DEDEDE} ktÛrπ chcesz przebiÊ zak≥ad.\nZnalezione B≥Ídy: {88b711}Kwota przebicia jest wieksza niz posiadane øetony.{DEDEDE}.", "Zatwierdz", "Zamknij");
				return 0;
			}
			new roznica = ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][13] - DaneGracza[playerid][gPokerPostawione];
			if(roznica >= (kwota+10))
			{
				dShowPlayerDialog(playerid, DIALOG_POKER_PRZEBIJ, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz {88b711}kwotÍ{DEDEDE} ktÛrπ chcesz przebiÊ zak≥ad.\nZnalezione B≥Ídy: {88b711}Kwota przebicia jest mniejsza niø zak≥ad do wyrÛwnania.{DEDEDE}.", "Zatwierdz", "Zamknij");
				return 0;
			}
			else
			{
				WybralMozliwoscPoker[playerid] = 0;
				PlayerTextDrawHide(playerid,Poker2[playerid]);
				PlayerTextDrawHide(playerid,Poker3[playerid]);
				PlayerTextDrawHide(playerid,Poker4[playerid]);
				PlayerTextDrawHide(playerid,Poker5[playerid]);
				PlayerTextDrawHide(playerid,Poker6[playerid]);
				DaneGracza[playerid][gPokerPostawione] += kwota;
				ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][13] = DaneGracza[playerid][gPokerPostawione];
				DaneGracza[playerid][gPokerZetony] -= kwota;
				ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][1] += kwota;
				new ilosc_nie_all = SprawdzNieAllinow(DaneGracza[playerid][gPoker]);
				if(ilosc_nie_all < 2)
				{
					ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][14] = playerid;
				}
				else
				{
					new poprzedni = SprawdzPoprzedniego(DaneGracza[playerid][gPokerStanowisko]);
					new poprzedni2 = DaneGracza[playerid][gPokerStanowisko];
					for(new i = 0; i < 6; i++)
					{
						if(ObiektInfo[DaneGracza[playerid][gPoker]][gAktualniGracze][poprzedni] == -1 || DaneGracza[ObiektInfo[DaneGracza[playerid][gPoker]][gAktualniGracze][poprzedni]][gInformacjePoker][0] == 1)
						{
							switch(poprzedni2)
							{
								case 0:{
									poprzedni2 = 2;
								}
								case 1:{
									poprzedni2 = 3;
								}
								case 2:{
									poprzedni2 = 5;
								}
								case 3:{
									poprzedni2 = 4;
								}
								case 4:{
									poprzedni2 = 0;
								}
								case 5:{
									poprzedni2 = 1;
								}
							}
							poprzedni = SprawdzPoprzedniego(poprzedni2);
						}
					}
					ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][14] = ObiektInfo[DaneGracza[playerid][gPoker]][gAktualniGracze][poprzedni];
				}
				new kasa[128];
				if(DaneGracza[playerid][gPokerZetony] == 0)
				{
					DaneGracza[playerid][gInformacjePoker][0] = 1;
					format(kasa, sizeof(kasa), "All-in ~r~($%d)", kwota);
				}
				else if(roznica > 0)
				{
					format(kasa, sizeof(kasa), "Przebija ~r~$%d", kwota);
				}
				else
				{
					format(kasa, sizeof(kasa), "Stawia ~r~$%d", kwota);
				}
				NadajTextTextdraw(playerid, DaneGracza[playerid][gPoker], kasa);
				for(new i = 0; i < 30; i++)
				{
					if(DaneGracza[playerid][gPokerObj][i] != 0)
					{
						DestroyDynamicObject(DaneGracza[playerid][gPokerObj][i]);
						DaneGracza[playerid][gPokerObj][i] = 0;
					}
				}
				for(new i = 0; i < 30; i++)
				{
					if(DaneGracza[playerid][gNumeryObiektowPostawionych][i] != 0)
					{
						DestroyDynamicObject(DaneGracza[playerid][gNumeryObiektowPostawionych][i]);
						DaneGracza[playerid][gNumeryObiektowPostawionych][i] = 0;
					}
				}
				PrzeliczZetony(playerid, DaneGracza[playerid][gPoker], 0, 0);
				PrzeliczZetony(playerid, DaneGracza[playerid][gPoker], DaneGracza[playerid][gPokerPostawione], 5);
			}
			OdswiezTexdrawyPoker(DaneGracza[playerid][gPoker], 0);
			new ilosc = SprawdzIloscGraczy(DaneGracza[playerid][gPoker]);
			if(ilosc >= 2)
			{
				SprawdzKolejGracza(playerid);
			}
			else
			{
				KoniecRundy(DaneGracza[playerid][gPoker]);
			}
		}
	}
	if(dialogid == DIALOG_POKER_OPUSC)
	{
		if(!response)
		{
			if(WpisalKase[playerid] == 0)
			{
				SelectTextDraw(playerid, 0xFFFFFFFF);
			}
			return 0;
		}
		else
		{
			WybralMozliwoscPoker[playerid] = 0;
			GraWPokera[playerid] = 0;
			WpisalKase[playerid] = 0;
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}W≥asnie {88b711}opuúci≥eú stolik{DEDEDE}, twoje øetony zosta≥y zamienione na prawdziwe pieniπdze.", "Zamknij", "");
			if(DaneGracza[playerid][gPokerZetony] != -1)
			{
				new kasa = DaneGracza[playerid][gPokerZetony] / 10;
				Dodajkase(playerid, kasa);
				DaneGracza[playerid][gPokerZetony] = -1;
			}
			new id_pokera = DaneGracza[playerid][gPoker];
			for(new i = 0; i < 30; i++)
			{
				if(DaneGracza[playerid][gPokerObj][i] != 0)
				{
					DestroyDynamicObject(DaneGracza[playerid][gPokerObj][i]);
					DaneGracza[playerid][gPokerObj][i] = 0;
					DaneGracza[playerid][gNumeryObiektowPostawionych][i] = 0;
				}
			}
			CancelSelectTextDraw(playerid);
			for(new i = 0; i < 6; i++)
			{
				if(ObiektInfo[id_pokera][objPoker][i] != -1)
				{
					UsunBaryGracz(ObiektInfo[id_pokera][objPoker][i]);
				}
			}
			for(new i = 0; i < 6; i++)
			{
				if(ObiektInfo[id_pokera][objPoker][i] == playerid)
				{
					ObiektInfo[id_pokera][gAktualniGracze][i] = -1;
					break;
				}
			}
			new ilosc_oczekujacych_graczy = 0;
			if(DaneGracza[playerid][gRundaPokerCzas] != 0)
			{
				for(new i = 0; i < 6; i++)
				{
					if(ObiektInfo[id_pokera][objPoker][i] != -1 && DaneGracza[ObiektInfo[id_pokera][objPoker][i]][gRundaPokerCzas] != 0)
					{
						ilosc_oczekujacych_graczy++;
					}
				}
				DaneGracza[playerid][gRundaPokerCzas] = 0;
				if(ilosc_oczekujacych_graczy < 2)
				{
					for(new i = 0; i < 6; i++)
					{
						if(ObiektInfo[id_pokera][objPoker][i] != -1)
						{
							DaneGracza[ObiektInfo[id_pokera][objPoker][i]][gRundaPokerCzas] = 0;
							RozpocznijPokera(ObiektInfo[id_pokera][objPoker][i], DaneGracza[ObiektInfo[id_pokera][objPoker][i]][gPoker]);
						}
					}
				}
			}	
			OdswiezTexdrawyPoker(id_pokera, 0);
			new ilosc = SprawdzIloscGraczy(id_pokera);
			if(ilosc >= 2)
			{
				SprawdzKolejGracza(playerid);
			}
			else
			{
				KoniecRundy(id_pokera);
			}
			for(new i = 0; i < 6; i++)
			{
				if(ObiektInfo[id_pokera][objPoker][i] == playerid)
				{
					ObiektInfo[id_pokera][objPoker][i] = -1;
					DaneGracza[playerid][gPoker] = 0;
					DaneGracza[playerid][gPokerStanowisko] = -1;
					DaneGracza[playerid][gPokerPostawione] = 0;
					DaneGracza[playerid][gPokerKarty][0] = 0;
					DaneGracza[playerid][gPokerKarty][1] = 0;
					DaneGracza[playerid][gInformacjePoker][0] = 0;
					DaneGracza[playerid][gInformacjePoker][1] = 0;
					DaneGracza[playerid][gInformacjePoker][2] = 0;
					DaneGracza[playerid][gInformacjePoker][3] = 0;
					DaneGracza[playerid][gInformacjePoker][4] = 0;
					DaneGracza[playerid][gInformacjePoker][5] = 0;
					DaneGracza[playerid][gInformacjePoker][6] = 0;
					break;
				}
			}
			PlayerTextDrawHide(playerid,KartyGracza[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza1[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza11[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza2[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza22[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza3[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza33[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza4[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza44[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza5[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza55[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza6[playerid]);
			PlayerTextDrawHide(playerid,KartyGracza66[playerid]);
			PlayerTextDrawHide(playerid,Poker1[playerid]);
			PlayerTextDrawHide(playerid,Poker2[playerid]);
			PlayerTextDrawHide(playerid,Poker3[playerid]);
			PlayerTextDrawHide(playerid,Poker4[playerid]);
			PlayerTextDrawHide(playerid,Poker5[playerid]);
			PlayerTextDrawHide(playerid,Poker6[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza1[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza2[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza3[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza4[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza5[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza6[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza7[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza8[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza9[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza10[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza11[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza12[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza13[playerid]);
			PlayerTextDrawHide(playerid,KartaGracza14[playerid]);
			PlayerTextDrawHide(playerid,WylosowaneKarty[playerid]);
			PlayerTextDrawHide(playerid,WylosowaneKarty1[playerid]);
			PlayerTextDrawHide(playerid,WylosowaneKarty2[playerid]);
			PlayerTextDrawHide(playerid,WylosowaneKarty3[playerid]);
			PlayerTextDrawHide(playerid,WylosowaneKarty4[playerid]);
			PlayerTextDrawHide(playerid,WylosowaneKarty5[playerid]);
			Frezuj(playerid,1);
			SetCameraBehindPlayer(playerid);
			return 0;
		}
	}
	if(dialogid == DIALOG_BUDKA)
	{
		if(!response)
		{
			ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
		}
		else
		{
			if(listitem > 3)
			{
				ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
				DeletePVar(playerid,"uidbudka");
			}
			switch(listitem)
			{
				case 0:
				{
					ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
					DeletePVar(playerid,"uidbudka");
				}
				case 1:
				{
					new find = 0, budka_lista[512];
					ForeachEx(i, MAX_GROUP)
					{
						if(GrupaInfo[i][gUID] != 0)
						{
							if(GrupaInfo[i][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[i][gTyp] == DZIALALNOSC_SANNEWS || GrupaInfo[i][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[i][gTyp] == DZIALALNOSC_RZADOWA)
							{
								new findduty = 0;
								ForeachEx(playeridg, IloscGraczy)
								{
									if(DaneGracza[KtoJestOnline[playeridg]][gSluzba] == GrupaInfo[i][gUID])
									{
										findduty++;
									}
								}
								if(findduty != 0)
								{
									format(budka_lista, sizeof(budka_lista), "%s\n%d\t{DEDEDE}ª  {88b711}%s {DEDEDE}(Osoby na s≥uøbie: %d)", budka_lista, GrupaInfo[i][gUID], GrupaInfo[i][gNazwa], findduty);
									find++;
								}
							}
						}
					}
					if(find != 0)
					{
						dShowPlayerDialog(playerid, DIALOG_BUDKA_SL, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Budka telefoniczna{88b711}:", budka_lista, "Wybierz", "Zamknij");
					}
					else
					{
						ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Budka telefoniczna{88b711}:", "Aktualnie nie ma s≥uøb porzπdkowych na s≥uøbie.", "Wybierz", "Zamknij");
					}
				}
				case 2:
				{
					new find = 0, budka_lista[1024];
					ForeachEx(i, MAX_GROUP)
					{
						if(GrupaInfo[i][gUID] != 0)
						{
							if(GrupaInfo[i][gTyp] != DZIALALNOSC_SANNEWS && GrupaInfo[i][gTyp] != DZIALALNOSC_POLICYJNA && GrupaInfo[i][gTyp] != DZIALALNOSC_ZMOTORYZOWANA && GrupaInfo[i][gTyp] != DZIALALNOSC_MAFIE && GrupaInfo[i][gTyp] != DZIALALNOSC_RODZINKA && GrupaInfo[i][gTyp] != DZIALALNOSC_MEDYCZNA && GrupaInfo[i][gTyp] != DZIALALNOSC_GANGI && GrupaInfo[i][gTyp] != DZIALALNOSC_RZADOWA)
							{
								new findduty = 0;
								ForeachEx(playeridg, IloscGraczy)
								{
									if(DaneGracza[KtoJestOnline[playeridg]][gSluzba] == GrupaInfo[i][gUID])
									{
										findduty++;
									}
								}
								if(findduty != 0)
								{
									format(budka_lista, sizeof(budka_lista), "%s\n%d\t{DEDEDE}ª  {88b711}%s {DEDEDE}(Osoby na s≥uøbie: %d)", budka_lista, GrupaInfo[i][gUID], GrupaInfo[i][gNazwa], findduty);
									find++;
								}
							}
						}
					}
					if(find != 0)
					{
						dShowPlayerDialog(playerid, DIALOG_BUDKA_SL, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Budka telefoniczna{88b711}:", budka_lista, "Wybierz", "Zamknij");
					}
					else
					{
						ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Budka telefoniczna{88b711}:", "Aktualnie nie ma øadnych dzia≥alnoúci na s≥uøbie.", "Wybierz", "Zamknij");
					}
				}
				case 3:
				{
					ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
					DeletePVar(playerid,"uidbudka");
					//dShowPlayerDialog(playerid, DIALOG_BUDKA_DZWON_KAL, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Budka telefoniczna{88b711}:", "{DEDEDE}Podaj {88b711}numer{DEDEDE}, do ktÛrego chcesz siÍ dodzwoniÊ.", "ZadzwoÒ", "Zamknij");
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_BUDKA_DZWON_KAL)
	{
		if(!response)
		{
			ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
			DeletePVar(playerid,"uidbudka");
		}
		else
		{
			if(strval(inputtext) > 4456781)
			{	
				new a = 0;
				new uid = strval(inputtext);
				ForeachEx(id, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[id]][gTelefon] == uid && zalogowany[KtoJestOnline[id]] == true)
					{
						if(Dzwoni[KtoJestOnline[id]] == 1)
						{
							new strsa[256];
							format(strsa, sizeof(strsa), "{ff6600}** S≥ychaÊ sygna≥ zajÍtoúci.");
							SendClientMessage(playerid, 0xFFb00000, strsa);
							a++;
							ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
							DeletePVar(playerid,"uidbudka");
							break;
						}
						else
						{
							new strs[256];
							format(strs, sizeof(strs), "{ff6600}** Oczekujπce po≥aczenie od numeru {DEDEDE}%d{ff6600} (Budka telefoniczna).", UzywaBudkiUID[playerid]);
							SendClientMessage(KtoJestOnline[id], 0xFFb00000, strs);
							Dzwoni[KtoJestOnline[id]] = -1;
							DzwoniID[KtoJestOnline[id]] = playerid;
							DzwoniID[playerid] = KtoJestOnline[id];
							Dzwoni[playerid] = 1;
							dzwon[playerid] = SetTimerEx("Dzwonie", 10000, 0, "i", playerid);
							new strsa[256];
							format(strsa, sizeof(strsa), "{ff6600}** Dzwonisz pod numer {DEDEDE}%d{ff6600}.", DaneGracza[KtoJestOnline[id]][gTelefon]);
							SendClientMessage(playerid, 0xFFb00000, strsa);
							a++;
							break;
						}
					}
				}
				if(a == 0)
				{
					new strsa[256];
					format(strsa, sizeof(strsa), "{ff6600}** Brak sygna≥u.");
					SendClientMessage(playerid, 0xFFb00000, strsa);
					ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
					DeletePVar(playerid,"uidbudka");
				}
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podany numer jest nieprawid≥owy.", "Zamknij", "");
				ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
				DeletePVar(playerid,"uidbudka");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_BUDKA_SL)
	{
		if(!response)
		{
			ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
		}
		else
		{
			SetPVarInt(playerid, "uidbudka", strval(inputtext));
			if(DaneGracza[playerid][gPORTFEL] < 10)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Budka telefoniczna{88b711}:", "Nie masz wystarczajπcej iloúÊi pieniÍdzy aby wykonaÊ to po≥πczenie.", "Wybierz", "Zamknij");
				return 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_BUDKA_SL_ZG, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} zg≥oszenia nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_BUDKA_SL_ZG)
	{
		if(!response)
		{
			ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
			DeletePVar(playerid,"uidbudka");
		}
		else
		{
			if(strlen(inputtext) < 3)
			{
				dShowPlayerDialog(playerid, DIALOG_BUDKA_SL_ZG, DIALOG_STYLE_INPUT, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podaj {88b711}treúÊ{DEDEDE} zg≥oszenia nastÍpnie {88b711}zatwierdz{DEDEDE} wiadomoúÊ.", "Zatwierdz", "Zamknij");
				return 0;
			}
			ForeachEx(i, IloscGraczy)
			{
				if(DaneGracza[KtoJestOnline[i]][gSluzba]  == GetPVarInt(playerid, "uidbudka"))
				{
					new strs[256];
					format(strs, sizeof(strs), "{ff6600}** Zg≥oszenie od {DEDEDE}%s{ff6600} (ID: {DEDEDE}%d{ff6600}), z budki telefonicznej nr: {DEDEDE}%d{ff6600}.",ZmianaNicku(playerid), playerid, UzywaBudkiUID[playerid]);
					SendClientMessage(KtoJestOnline[i], 0xFFb00000, strs);
					new strss[256];
					format(strss, sizeof(strss), "{ff6600}WiadomoúÊ: {DEDEDE}%s{ff6600}.",inputtext);
					SendClientMessage(KtoJestOnline[i], 0xFFb00000, strss);
				}
			}
			ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
			DeletePVar(playerid,"uidbudka");
			Dodajkase(playerid, -10);
			ZapiszGracza(playerid);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}ª {FFFFFF}"VER" {88b711}ª {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zg≥oszenie {88b711}zosta≥o{DEDEDE} wys≥ane, a op≥ata zosta≥a pobrana.", "Zamknij", "");
		}
		return 1;
	}
	return 1;
}