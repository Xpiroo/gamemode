#define ForeachExpp(%2,%1) for(new %2 = 0; %2 < %1; %2++)
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    A_CHAR(inputtext); //Zamienia % na # w tekscie GUI
////////////////////////////////////////////////////////////////////////////////
    if(dialogid == DIALOG_MAIN)
    {
        switch(listitem)
        {
			case 0: ShowPlayerDialog(playerid,DIALOG_RANGE,DIALOG_STYLE_INPUT,"Wstawienie zakresu","ProszÍ o wstawienie szeregu. (Zalecane: 20-30)","Akceptuj","Anuluj");
			case 1:
			{
				new cam = GetClosestCamera(playerid);
				if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"Øaden fotoradar w pobiløu nie zosta≥ odnaleziony.!");
				SendClientMessageEx(playerid,COLOR_GREEN,"sis","Najbliøsze ID Fotoradaru jest ID: ",cam,".");
			}
			case 2:
			{
				new cam = GetClosestCamera(playerid);
				if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"Nie znaleziono w pobliøu fotoradaru!");
				SetPVarInt(playerid,"selected",cam);
				ShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,""VER" ª Fotoradary","Zmiany kπta\nZmiany zakresu\nZmiena limitu szybkoúci","Akceptuj","Anuluj");
			}
			case 3:
			{
				new cam = GetClosestCamera(playerid);
				if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"Nie znaleziono w pobliøu fotoradaru!");
				UsunFotoradar(cam);
			 	SendClientMessage(playerid,COLOR_GREEN,"Fotoradar zosta≥ usuniÍty.");
			 	DeletePVar(playerid,"selected");
			}
			case 4:
			{
				for(new i = 0;i<loaded_cameras +1;i++)
				{
		        	UsunFotoradar(i);
				}
				SendClientMessage(playerid,COLOR_GREEN,"Wszystkie fotoradary zosta≥y usuniÍte.");
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
	if(dialogid == DIALOG_RANGE)
	{
		if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_RANGE,DIALOG_STYLE_INPUT,"Wstaw szereg","ProszÍ podaÊ zakres (Zalecane: 20-30)","Akceptuj","Anuluj");
	    SetPVarInt(playerid,"range",strval(inputtext));
	    ShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"Wstaw fotoradar","ProszÍ wstawiÊ fotoradar","Akceptuj","Anuluj");
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
			edycjaobiektowtyp[playerid] = 1;
			ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Edytor obiektÛw","W≥πczy≥eú edytor typu SAMP.", "Zamknij", "" );
			return 1;
		}else{
			edycjaobiektowtyp[playerid] = 0;
			ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Edytor obiektÛw","W≥πczy≥eú edytor typu MTA.", "Zamknij", "" );
		}
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
		if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"Wstaw fotoradar","ProszÍ wstawiÊ fotoradar","Akceptuj","Anuluj");
	    SetPVarInt(playerid,"limit",strval(inputtext));
	    SetPVarInt(playerid,"fine",strval(inputtext));
		new Float:x,Float:y,Float:z,Float:angle;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,angle);
		angle = angle + 180;if(angle > 360){angle = angle - 360;}
		new id = CreateSpeedCam(x,y,z -3,angle,GetPVarInt(playerid,"range"),GetPVarInt(playerid,"limit"),GetPVarInt(playerid,"fine"),0);
		SetPlayerPos(playerid,x,y+2,z);
		DeletePVar(playerid,"range");
		DeletePVar(playerid,"limit");
		DeletePVar(playerid,"fine");
		SetPVarInt(playerid,"selected",id);
		ShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,""VER" ª Fotoradary","Zmiana kπta\nZmiena zakresu\nZmiana limitu prÍdkoúci\nUsuÒ fotoradar","Akceptuj","Anuluj");
	}
	if(dialogid == DIALOG_EDIT)
	{
	    switch(listitem)
	    {
	        case 0: ShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","ProszÍ wpisaÊ nowy kπt","Akceptuj","Anuluj");
	        case 1: ShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy zakres","Akceptuj","Anuluj");
	        case 2: ShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy limit prÍdkoúci","Akceptuj","Anuluj");
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
	    if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","ProszÍ wpisaÊ nowy kπt","Akceptuj","Anuluj");
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
	    if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy zakres","Akceptuj","Anuluj");
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
	    if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,""VER" ª Fotoradary","Wpisz nowy limit prÍdkoúci","Akceptuj","Anuluj");
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
			ForeachExp(i, MAX_ANIM)
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
	if(dialogid == DIALOG_MANIPULATION_VEH)
	{
	    if(response)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new veh = SprawdzCarUID(vehicleid);
			if(listitem == 0)
			{
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
			if(listitem == 1)
			{
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
			if(listitem == 2)
			{
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
			if(listitem == 3)
			{
				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ta opcja jest chwilowo niedostÍpna dla graczy.", "Zamknij", "");
			}
			if(listitem == 4)
			{
				if(!GraczPremium(playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ta funkcja wymaga {FFFF00}Konta Premium.", "Zamknij", "");
					return 1;
				}
				if(PojazdInfo[veh][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[veh][pOwnerDzialalnosc] == 0 || WlascicielGrupyOwner(vehicleid, playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_REJESTR_UNIK, DIALOG_STYLE_INPUT, "Unikalna rejestracja pojazdÛw:","Wpisz nazwÍ unikalnej tablicy rejestracyjnej.", "Dalej", "Zamknij" );
				}else{
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ten pojazd nie naleøy do ciebie - bπdz nie jesteú ownerem grupy do ktÛrej naleøy pojazd.", "Zamknij", "");
				}
			}
			if(listitem == 5)
			{
			POD_DZIALALNOSC(playerid);
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
	    ShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, ""VER" ª Zmiana nicku", "W poniøsze pole wprowadz nowy nick, po \nczym zatwierdz przyciskiem 'ZmieÒ'.", "ZmieÒ", "WrÛÊ");
	    return 1;
	}
	if(dialogid == DIALOG_NICK)
	{
		if(response)
	    {
    	    if(strfind(inputtext, "_", true) <= 0)
		    {
			    GameTextForPlayer(playerid, "~n~~n~~n~~n~~r~Niepoprawny nick.~n~~w~Nick postaci nie zostal zmieniony", 2000, 5);
				ShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, ""VER" ª Zmiana nicku", "W poniøsze pole wprowadz nowy nick, po \nczym zatwierdz przyciskiem 'ZmieÒ'.", "ZmieÒ", "WrÛÊ");
				return 1;
			}
			if(strlen(inputtext) == 0)
			{
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~r~Niepoprawny nick.~n~~w~Nick postaci nie zostal zmieniony", 2000, 5);
				ShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, ""VER" ª Zmiana nicku", "W poniøsze pole wprowadz nowy nick, po \nczym zatwierdz przyciskiem 'ZmieÒ'.", "ZmieÒ", "WrÛÊ");
			}
			else
			{
				SetPlayerName(playerid, inputtext);
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
		if( !strlen( inputtext ) || strlen( inputtext ) > 25 )
		    return ShowPlayerDialog(playerid, DIALOG_REJESTR_UNIK, DIALOG_STYLE_INPUT, "Unikalna rejestracja pojazdÛw:","Wpisz nazwÍ unikalnej tablicy rejestracyjnej.\n{ff0000}Maxymalnie 1-25 znakÛw.", "Dalej", "Zamknij" );
        A_KOL(inputtext);
        A_KOLS(inputtext);
		SetVehicleNumberPlate(vehicleid, inputtext);
		strmid(PojazdInfo[indexveh][pTablice], inputtext, 0, 64, 64);
		ZapiszPojazd(indexveh);
		ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Unikalna rejestracja pojazdÛw:", "Aby wprowadziÊ zmiany w pojezdzie zaleca siÍ unspawn i spawn pojazdu.", "Zatwierdz", "Anuluj" );
	}
	if(dialogid == DIALOG_LOGIN)
	{
		if(response)
		{
           	if(strlen(inputtext) > 32)
			{
				new str2[256];
    			format(str2, sizeof(str2), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerÛw Role Play!\n\n{DEDEDE}PrÛbujesz zalogowac sie na PostaÊ:{88B711} %s\n{DEDEDE}Wpisz swoje has≥o(Globalne) i kliknij ''Zaloguj'' aby sie zalogowaÊ!",ImieGracza2(playerid));
				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""VER" ª Panel Logowania", str2, "Zaloguj", "Wyjdz");
			}
			else
			{
                new sql3[200];
				format(sql3, sizeof(sql3), "SELECT `password`, `salt`, `premium`, `ooc`, `run`, `ban`, `veh`, `gun`, `username`, `GAMESCORE`, `usergroup`, `POZIOM_ADMINISTRACJI` FROM `five_users` WHERE `uid` = '%d'", DaneGracza[playerid][gGUID]);
				mysql_query(sql3);
				mysql_store_result();
				mysql_fetch_row(sql3);
				sscanf(sql3, "p<|>s[124]s[124]dddddds[124]ddd", DaneGracza[playerid][gHASLO]
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
				);
                new hassh[150];
          		format(hassh, sizeof(hassh), "%s%s", MD5_Hash(DaneGracza[playerid][gSALT]), MD5_Hash(inputtext));
		  		Logowanie(playerid, hassh);
			}
			return 1;
		}
		else
		{
           	ShowPlayerDialog(playerid, DIALOG_NICK, DIALOG_STYLE_INPUT, ""VER" ª Zmiana nicku", "W poniøsze pole wprowadz nowy nick, po \nczym zatwierdz przyciskiem 'ZmieÒ'.", "ZmieÒ", "WrÛÊ");
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
				ShowPlayerDialog(playerid, DIALOG_PODPISZ_VEH_ACC, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy napewno chcesz podpisaÊ pojazd pod dzia≥alnoúÊ?\nPamiÍtaj jeúli zatwierdzisz nie bÍdzie odwrotu - auta juø nie bÍdziesz mÛg≥ odpisaÊ.", "Tak", "Nie");
			}else{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie posiadasz uprawnieÒ do podpisania tego auta pod dzia≥alnoúÊ gospodarczπ.", "Zamknij", "");
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
			ZapiszPojazd(veh);
			DeletePVar(playerid,"PodpisanieAuta");
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Akceptowa≥eú transakcje, auto zosta≥o podpisane pod dzia≥alnoúÊ.", "Zamknij", "");
		}
		else
		{
        	ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Anulowa≥eú transakcje pomyúlnie.", "Zamknij", "");
		}
		return 1;
	}
	if(dialogid == DIALOG_VEH_SPAWN)
	{
	    if(response)
		{
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
		    StworzPojazd(uid, playerid);
		}
		else
		{
		    SetPVarInt(playerid, "OPCJAPOJAZDY", uid);
		    ShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_DZ, DIALOG_STYLE_LIST, ""VER" - Pojazdy:", "1.\tNamierz\n2.\tZresetuj na spawnpoint\n3.\tSkasuj ca≥kowicie\n4.\tOdpisz", "Wybierz", "Anuluj");
		}
	}
	if(dialogid == DIALOG_VEH_NAMIERZ)
	{
	    if(response)
		{
		    new uid = strval(inputtext);
		    new Float:X, Float:Y, Float:Z;
		    GetVehiclePos(PojazdInfo[uid][pID], X, Y, Z);
		    SetPlayerCheckpoint(playerid, X, Y, Z, 5.0);
		    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazd", "Pojazd zosta≥ namierzony. Wpisz komendÍ ponownie, aby wy≥πczyÊ radar!", "Zamknij", "");
		}
		return 1;
	}
	if( dialogid == DIALOG_BUS )
	{
	    if( !response )
	        return 1;
		new string[256];
		new
		    uid = strval( inputtext ), czas, koszt;
		koszt 	= 100/6;
		czas    = 90;
		//koszt 	= 100;
		//czas    = 8;

		if( koszt < MIN_KOSZT_BILETU )
		    koszt = MIN_KOSZT_BILETU;
		if( koszt > MAX_KOSZT_BILETU )
		    koszt = MAX_KOSZT_BILETU;

		SetPVarInt( playerid, "BusKoszt", koszt );
		SetPVarInt( playerid, "BusCzas", czas );
		SetPVarInt( playerid, "BusDo", uid );
		SetPVarInt( playerid, "BusPrzystanek", GetPlayerBusStop( playerid ) );

		format( string, sizeof( string ), "Trasa %s - %s\n\
		Czas: %d min. %d s\n\
		Koszt: %d$", Przystanek[ GetPlayerBusStop( playerid ) ][ busText ],
		Przystanek[ uid ][ busText ], czas / 60, czas % 60, koszt );
		ShowPlayerDialog( playerid, DIALOG_BUS_BILET, DIALOG_STYLE_MSGBOX, "Przystanek > Kup bilet",
		string, "Kup", "Anuluj" );

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
	        return ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Przystanek > Kup bilet","Nie staÊ CiÍ na kupno biletu.", "Zamknij", "" );
		}

		SetTimerEx( "BusStart", 33000, 0, "i", playerid );
		GameTextForPlayer( playerid, "~y~~h~autobus pojawi sie~n~~y~~h~za okolo ~b~~h~pol minuty.",3000, 5);

	}
	if( dialogid == DIALOG_NOWYBUS_CZ1 )
	{
		if( !response )
		    return 1;

		if( !strlen( inputtext ) || strlen( inputtext ) > 32 )
		    return ShowPlayerDialog( playerid, DIALOG_NOWYBUS_CZ1, DIALOG_STYLE_INPUT, "Przystanek > Nowy",
		            "Zbyt krÛtka lub zbyt d≥uga nazwa przystanku.\n\
		            Wpisz poprawnπ nazwÍ.", "Dalej", "Anuluj" );
		new string[256];
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos( playerid, x, y, z );
		GetPlayerFacingAngle( playerid, a );
		new id = StworzPrzystanek( inputtext, x, y, z, a );
		format( string, sizeof( string ), "Utworzono przystanek %d. %s",
		id, Przystanek[ id ][ busText ] );
		ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Przystanek",string, "Zamknij", "" );
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
			    return 	ShowPlayerDialog( playerid, DIALOG_BUS_EDITZAPISZ, DIALOG_STYLE_INPUT, "Przystanek > Nazwa",
			            "Wpisz nowπ nazwÍ przystanku.", "Dalej", "Anuluj" );

			case 7:
				return ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Przystanek","Ustaw siÍ w nowej pozycji przystanku i wpisz /abus.", "Zamknij", "" );

			case 8:
			{
			    UsunPrzystanek( GetPVarInt( playerid, "BusPoz" ) );
			    ShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Przystanek","UsuniÍto przystanek.", "Zamknij", "" );
			    DeletePVar( playerid, "BusPoz" );
			}
		}
	}
	if( dialogid == DIALOG_BUS_EDITZAPISZ )
	{
	    if( !response )
	        return DeletePVar( playerid, "BusPoz" );

		if( !strlen( inputtext ) || strlen( inputtext ) > 32 )
		    return 	ShowPlayerDialog( playerid, DIALOG_BUS_EDITZAPISZ, DIALOG_STYLE_INPUT, "Przystanek > Nazwa",
			        "Wpisana przez Ciebie nazwa jest niepoprawna.\n\
					SprÛbuj ponownie, nie przekraczajπc limitu 32 znakÛw.", "Dalej", "Anuluj" );

		new
		    id = GetPVarInt( playerid, "BusPoz" )
		;
		new string[256];
		format( Przystanek[ id ][ busText ], 32, "%s", inputtext );
		ZapiszPrzystanek( id );

		format( string, 100, "Przystanek %d. %s\n\
		{88b711}Aby kupiÊ bilet, wpisz /bus",
		id, Przystanek[ id ][ busText ] );

		Update3DTextLabelText( Przystanek[ id ][ busTag ], SZARY, string );

		DeletePVar( playerid, "BusPoz" );
	}
	if(dialogid == DIALOG_PRZEDZMIOTY)
	{
	    if(response)
		{
		    SetPVarInt( playerid, "UzytyItem", strval(inputtext));
 	        ShowPlayerDialog(playerid, DIALOG_PRZEDZMIOT_OPCJE, DIALOG_STYLE_LIST, ""VER" - Opcje przedmiotu:", "Uøyj\nOd≥Ûø\nW≥Ûø do szafy\nW≥Ûø do torby\nW≥Ûü do plecaka\nW≥Ûü do magazynu\nZniszcz", "Wybierz", "Anuluj");
		}
		else
		{
			DeletePVar(playerid, "UzytyItem");
		}
		return 1;
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
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do magazynu swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze dwa dni\nTen przedmiot zostanie skasowany.", "Zamknij", "");
					return 0;
				}
			    UzywanieItemu(playerid, GetPVarInt(playerid, "UzytyItem"));
		        return 1;
			}
			case 1:
			{
			    if(PrzedmiotInfo[uid][pTyp] == P_PACZKA)
			    {
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten przedmiot moøna tylko i wy≥πcznie w≥oøyÊ do magazynu swojego biznesu.\nPamiÍtaj jeúli nie w≥oøysz go do swojego biznesu przez najbliøsze dwa dni\nTen przedmiot zostanie skasowany.", "Zamknij", "");
					return 0;
				}
			    OdkladanieItemu(playerid, GetPVarInt(playerid, "UzytyItem"));
		        return 1;
			}
			case 5:
			{
			    new vw = GetPlayerVirtualWorld(playerid);
			    if(PrzedmiotInfo[uid][pTyp] != P_PACZKA)
			    {
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ta opcja jest dostÍpna tylko dla paczek.", "Zamknij", "");
					return 0;
				}
				if(vw == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie znajdujesz siÍ w budynku.", "Zamknij", "");
					return 0;
				}
				if(NieruchomoscInfo[vw][nWlascicielD] != PrzedmiotInfo[uid][pWar2])
				{
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten budynek nie jest w≥asnoúciπ dzia≥alnoúci do ktÛrej naleøy paczka.", "Zamknij", "");
					return 0;
				}
                DodajDoMagazynu(PrzedmiotInfo[uid][pWar2], PrzedmiotInfo[uid][pWar1], PrzedmiotInfo[uid][pStworzylUID], PrzedmiotInfo[uid][pWar4], PrzedmiotInfo[uid][pNazwa], PrzedmiotInfo[uid][pCenas], PrzedmiotInfo[uid][pObject]);
				UsunPrzedmiot(uid);
				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Paczka zosta≥a od≥oøona pomyúlnie.", "Zamknij", "");
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
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Aby namierzyÊ pojazd musi on byÊ zespawnowany.", "Zamknij", "");
				    return 0;
				}
			    new Float:X, Float:Y, Float:Z;
			    GetVehiclePos(PojazdInfo[uid][pID], X, Y, Z);
			    SetPlayerCheckpoint(playerid, X, Y, Z, 5.0);
		        return 1;
			}
			case 1:
			{
				if(!WlascicielGrupyOwner(PojazdInfo[uid][pID], playerid))
				{
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Brak uprawnieÒ do tej opcji", "Zamknij", "");
				    return 0;
				}
			    ShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_RESET, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy aby napewno chesz zresetowaÊ spawnpoint swojego pojazdu?\nPamiÍtaj zresetowanie pozycji pojazdu wiπøe siÍ z na≥oøeniem blokady na ko≥o o wartoúci {FF0000}100$", "Tak", "Nie");
		        return 1;
			}
			case 2:
			{
			    if(!WlascicielGrupyOwner(PojazdInfo[uid][pID], playerid))
				{
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Brak uprawnieÒ do tej opcji", "Zamknij", "");
				    return 0;
				}
			    ShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_DEL, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy aby napewno chesz usunπÊ swÛj pojazd z dzia≥alnoúci?\nPamiÍtaj ta opcja nie jest odwracalna.", "Tak", "Nie");
		        return 1;
			}
			case 3:
			{
			    if(!WlascicielGrupyOwner(PojazdInfo[uid][pID], playerid))
				{
				    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Brak uprawnieÒ do tej opcji", "Zamknij", "");
				    return 0;
				}
			    //ShowPlayerDialog(playerid, DIALOG_POJAZD_OPCJE_ODPISZ, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ta opcja jest niedostÍpna dla graczy.", "Zamknij", "");
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
		    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Aby zresetowaÊ pojazd musi on byÊ odspawnowany.", "Zamknij", "");
		    return 0;
		}
		PojazdInfo[uid][pBlokada] = 100;
		PojazdInfo[uid][pX] = 929.5447;
		PojazdInfo[uid][pY] = -1221.7166;
		PojazdInfo[uid][pZ] = 16.8016;
		Transakcja(T_VRESET, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 100, uid, -1, -1, "-", gettime()-3600);
		ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Pojazd zosta≥ zresetowany na spawnpoint.", "Zamknij", "");
	    return 1;
	}
	if(dialogid == DIALOG_ITEM_CD)
    {
        new uid2 = GetPVarInt(playerid, "UIDWeaponAmmo");
        if(response)
        {
            format(PrzedmiotInfo[uid2][pWar3], 124, "%s", inputtext);
		    ZapiszPrzedmiot(uid2);
		    ShowPlayerDialog(playerid, DIALOG_ITEM_CD2, DIALOG_STYLE_INPUT, ""VER" ª Pusta plytka", "Podaj nazwe p≥ytki:", "Zapisz", "Anuluj");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_ITEM_CD2, DIALOG_STYLE_INPUT, ""VER" ª Pusta plytka", "Podaj nazwe p≥ytki:", "Zapisz", "Anuluj");
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
            ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "P≥ytka zosta≥a nagrana pomyúlnie.", "Zamknij", "");
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
		ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Pojazd zosta≥ usuniÍty.", "Zamknij", "");
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
		    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Aby zresetowaÊ pojazd musi on byÊ zespawnowany.", "Zamknij", "");
		    return 0;
		}
		PojazdInfo[uid][pOwnerPostac] = DaneGracza[playerid][gUID];
		Transakcja(T_VODP, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uid, PojazdInfo[uid][pOwnerDzialalnosc], -1, "-", gettime()-3600);
		PojazdInfo[uid][pOwnerDzialalnosc] = 0;
		ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Pojazd zosta≥ odpisany.", "Zamknij", "");
	    return 1;
	}
	if(dialogid == DIALOG_PRZEDZMIOTY_PODNIES)
	{
	    if(response)
		{
		    new uid = strval(inputtext);
		    if(!IsPlayerInRangeOfPoint(playerid, 3, PrzedmiotInfo[uid][pX], PrzedmiotInfo[uid][pY], PrzedmiotInfo[uid][pZ]) && PrzedmiotInfo[uid][pTypWlas] != TYP_ULICA)
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten przedmiot nie znajduje siÍ obok Ciebie!", "Zamknij", "");
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
		    Transakcja(T_IPODNIES, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uid, PrzedmiotInfo[uid][pTyp], PrzedmiotInfo[uid][pWar1], "-", gettime()-3600);
		    new mestring[124];
		    format(mestring, sizeof(mestring), "* %s podnosi przedmiot %s.", ZmianaNicku(playerid), PrzedmiotInfo[uid][pNazwa]);
			SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, mestring, 10);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		}
		else return 1;
	}
	if(dialogid == DIALOG_PRZEDZMIOTY_PODNIES_VEH)
	{
	    if(response)
		{
		    new uid = strval(inputtext);
			PrzedmiotInfo[uid][pX] = 0;
			PrzedmiotInfo[uid][pY] = 0;
			PrzedmiotInfo[uid][pZ] = 0;
			PrzedmiotInfo[uid][pVW] = 0;
			PrzedmiotInfo[uid][pTypWlas] = TYP_WLASCICIEL;
			PrzedmiotInfo[uid][pOwner] = DaneGracza[playerid][gUID];
		    ZapiszPrzedmiot(uid);
		    Transakcja(T_IPODNIES, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uid, PrzedmiotInfo[uid][pTyp], PrzedmiotInfo[uid][pWar1], "-", gettime()-3600);
		    new mestring[124];
		    format(mestring, sizeof(mestring), "* %s podnosi przedmiot %s.", ZmianaNicku(playerid), PrzedmiotInfo[uid][pNazwa]);
			SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, mestring, 10);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
		}
		else return 1;
	}
	if(dialogid == DIALOG_DZIALALNOSCI)
	{
	    if(response)
		{
		    SetPVarInt(playerid, "NRZLISTY", strval(inputtext));
		    ShowPlayerDialog(playerid, DIALOG_DZIALALNOSCI_OPCJE, DIALOG_STYLE_LIST, ""VER" - Opcje przedmiotu:", "Wejdz na s≥uøbe\nInformacje\nMagazyn\nOsoby na s≥uøbie\nZadania dzia≥alnoúci\nPojazdy dzia≥alnoúci", "Wybierz", "Zamknij");
		}
		else return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE)
	{
	    if(response)
		{
			switch(listitem)
			{
				case 0:
				{
        			new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
					new string_big[256];
				    format(string_big, sizeof(string_big), "~y~%s~n~~n~~p~Owner:~w~ %d:%d  UID: %d  Obiekty: %d~n~~r~Wejscie:~w~ %0.02f,  %0.02f,  %0.02f~n~~r~Wyjscie:~w~ %0.02f,  %0.02f,  %0.02f~n~~n~~b~Vw: ~w~%d~b~  Int:~w~ %d~n~~b~Zew. Vw: ~w~%d~b~  Zew.Int: ~w~%d~n~~b~Stw. obiekty: ~w~%d",
					NieruchomoscInfo[uids][nAdres],NieruchomoscInfo[uids][nWlascicielP],NieruchomoscInfo[uids][nWlascicielD],NieruchomoscInfo[uids][nUID],NieruchomoscInfo[uids][nLiczbaMebli],NieruchomoscInfo[uids][nX],NieruchomoscInfo[uids][nY],NieruchomoscInfo[uids][nZ],NieruchomoscInfo[uids][nXW],NieruchomoscInfo[uids][nYW],NieruchomoscInfo[uids][nZW],NieruchomoscInfo[uids][nVW],NieruchomoscInfo[uids][nINT],NieruchomoscInfo[uids][nVWW],NieruchomoscInfo[uids][nINTW],NieruchomoscInfo[uids][nStworzoneObiekty]);
					TextDrawSetString(OBJ[playerid], string_big);
					TextDrawShowForPlayer(playerid, OBJ[playerid]);
					SetTimerEx("NapisUsunsV",15000,0,"d",playerid);
					return 1;
				}
				case 1:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_OB, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy naprwno chcesz dokupiÊ obiekt do tego budynku?", "Tak", "Nie");
					return 1;
				}
				case 2:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_NP, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy naprwno chcesz dokupiÊ napis do tego budynku?", "Tak", "Nie");
					return 1;
				}
				case 3:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WP, DIALOG_STYLE_INPUT, ""VER" ª Informacja", "Czy naprwno chcesz zmieniÊ standardowy spawn budynku?\nJeúli tak przepisz s≥owo: ''potwierdzam'' w poniøsze pole.", "Tak", "Nie");
					return 1;
				}
				case 4:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_PP, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy chcesz w≥πczyÊ przejazd pojazdami?", "W≥πcz", "Wy≥πcz");
					return 1;
				}
				case 5:
				{
					new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    if(NieruchomoscInfo[uids][nWlascicielD] != 0)
				    {
					    if(NieruchomoscInfo[uids][nOdpis] == 1)
						{
						    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten budynek nie moøe zostaÊ odpisany.", "Zamknij", "");
			 				return 0;
						}
					    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_BP, DIALOG_STYLE_LIST, ""VER" ª Informacja", "0.\tPrzepisz budynek na tπ postaÊ.", "Wybierz", "Zamknij");
				    }else{
				    POD_DZIALALNOSC_BUDYNEK(playerid);
				    }
					return 1;
				}
				case 6:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
					ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WN, DIALOG_STYLE_INPUT, ""VER" ª Informacja", "Wpisz nowπ nazwe w pole niøej max 3-32 zanki.", "Zatwierdz", "Zamknij");
					return 1;
				}
				case 7:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    if(NieruchomoscInfo[uids][nWlascicielP] == DaneGracza[playerid][gUID] && NieruchomoscInfo[uids][nWlascicielD] == 0)
				    {
						ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SP, DIALOG_STYLE_INPUT, ""VER" ª Informacja", "Wpisz kwote za jakπ chcesz sprzedaÊ budynek:", "Zatwierdz", "Zamknij");
					}else{
						ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten budynek nie naleøy do ciebie.", "Zamknij", "");
					}
					return 1;
				}
				case 8:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    if(NieruchomoscInfo[uids][nAudio] == -1)
				    {
				    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_HIFI, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy chcesz zakupiÊ High fidelity (HIFI) za kwote 5000$?", "Tak", "Nie");
				    }
				    if(NieruchomoscInfo[uids][nAudio] == 0)
				    {
				        new found = 0;
						new string[256];
						ForeachExp(i, MAX_PRZEDMIOT)
						{
							if(PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL&& PrzedmiotInfo[i][pTyp] == P_CD && !ComparisonString(PrzedmiotInfo[i][pWar3], ""))
							{
								format(string, sizeof(string), "%s\n%d\t%s", string, PrzedmiotInfo[i][pUID], PrzedmiotInfo[i][pNazwa]);
								found++;
							}
						}
						if(found != 0) ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_CD, DIALOG_STYLE_LIST, ""VER" ª Audio", string, "Okej", "Anuluj");
						else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Audio", "Nie posiadasz przy sobie p≥ytek CD.", "Okej", "Anuluj");
				    }
				    if(NieruchomoscInfo[uids][nAudio] == 1)
				    {
				        foreach(Player, i)
						{
				            if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
				            {
				                StopAudioStreamForPlayer(i);
				                NieruchomoscInfo[uids][nAudio] = 0;
				                ZapiszNieruchomosc(uids);
		    				}
						}
						return 1;
					}
				}
				case 9:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SZAFA, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Czy chcesz zakupiÊ szafe za kwote 5000$?", "Tak", "Nie");
					return 1;
				}
				case 10:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    if(NieruchomoscInfo[uids][nSwiatlo] == 1)
					{
						GameTextForPlayer(playerid, "~b~Zapaliles swiatlo!", 3000, 3);
						NieruchomoscInfo[uids][nSwiatlo] = 0;
						foreach(Player, i)
						{
						    if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
								TextDrawHideForPlayer(i, Light);
						}
					}
					else
					{
					    GameTextForPlayer(playerid, "~b~Zgasiles swiatlo!", 3000, 3);
					    NieruchomoscInfo[uids][nSwiatlo] = 1;
						foreach(Player, i)
						{
						    if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
								TextDrawShowForPlayer(i, Light);
						}
					}
     				ZapiszNieruchomosc(uids);
				    return 1;
				}
				case 11:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
				    if(!GraczPremium(playerid))
					{
						ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ta funkcja wymaga {FFFF00}Konta Premium.", "Zamknij", "");
						return 0;
					}
					if(NieruchomoscInfo[uids][nMapa] == 0)
					{
					    if(GraczWbudynku(uids) != -1)
					    {
					        ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie moøesz tego zrobiÊ poniewaø ktoú uøywa edytora w budynku.", "Zamknij", "");

							return 0;
					    }
					    NieruchomoscInfo[uids][nMapa] = 1;
					    ZapiszNieruchomosc(uids);
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Teraz moøesz siÍ udaÊ do panelu dzia≥alnoúci gospodarczych na forum, aby wgraÊ mapÍ obiektÛw.", "Zamknij", "");
					}else{
					    UaktualnijObiektyWBudynku(uids);
					    UnloadObject(uids);
	    				LoadObject(uids);
	    				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Mapa obiektÛw zosta≥a wgrana pomyúlnie.", "Zamknij", "");
	    				NieruchomoscInfo[uids][nMapa] = 0;
					    ZapiszNieruchomosc(uids);
					}
				    return 1;
				}
				case 12:
				{
				    new uids = GetPVarInt(playerid, "uiddrzwi");
        			if(NieruchomoscInfo[uids][nMapa] == 1)
					{
					    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥aúciciel budynku w≥aúnie wgrywa mape obiektÛw do budynku.\nTa opcja jest niedostÍpna do czasu zakoÒczenia tej operacji.", "Zamknij", "");
		 				return 0;
					}
				    new string[256], found = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
					    if(DaneGracza[i][gUID] && PlayerObokPlayera(playerid, i, 15))
					    {
							format(string, sizeof(string), "%s\n%d\t%s", string, i, ZmianaNicku(i));
							found++;
						}
					}
					if(found != 0) ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WNAJEM, DIALOG_STYLE_LIST, ""VER" ª Wynajem", string, "Wynajmij", "Anuluj");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Oferta przedmiotu", "Nikt obok Ciebie nie stoi.", "Okej", "Anuluj");
				    return 1;
				}
			}
   		}
		else
		{
			return 0;
		}
	}//strval(inputtext)
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
	                StopAudioStreamForPlayer(i);
		    		PlayAudioStreamForPlayer(i, NieruchomoscInfo[uids][nRadio], 0, 0, 0, 14.0, 0);
				}
			}
			NieruchomoscInfo[uids][nAudio] = 1;
   			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "P≥yta zosta≥a w≥oøona do systmu audio.", "Zamknij", "");
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
			if(!ComparisonString(inputtext, "potwierdzam"))
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "èle przepisana treúÊ.", "Zamknij", "");
			    return 0;
			}
			new Float:pXs, Float:pYs, Float:pZs;
			GetPlayerPos(playerid, pXs, pYs, pZs);
			NieruchomoscInfo[uids][nXW] = pXs;
			NieruchomoscInfo[uids][nYW] = pYs;
			NieruchomoscInfo[uids][nZW] = pZs;
			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Standardowy spawn budynku zosta≥ zmienieony.", "Zamknij", "");
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
			Oferuj(playerid, strval(inputtext), 0, 0, uids, 0, OFEROWANIE_WYNAJMU, 0, "");
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
				ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SP, DIALOG_STYLE_INPUT, ""VER" ª Informacja", "Wpisz kwote za jakπ chcesz sprzedaÊ budynek:\nKwota musi byÊ wiÍksza od 0.", "Zatwierdz", "Zamknij");
				return 1;
			}
            SetPVarInt(playerid, "CenaBudynku",strval(inputtext));
            new string[256], found = 0;
			ForeachExp(i, MAX_PLAYERS)
			{
			    if(DaneGracza[i][gUID] && PlayerObokPlayera(playerid, i, 15) && i != playerid)
			    {
					format(string, sizeof(string), "%s\n%d\t%s", string, i, ZmianaNicku(i));
					found++;
				}
			}
			if(found != 0) ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_SP_G, DIALOG_STYLE_LIST, ""VER" ª Oferta budynku", string, "Oferuj", "Anuluj");
			else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Oferta przedmiotu", "Nikt obok Ciebie nie stoi.", "Okej", "Anuluj");
	    }
	    return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_SP_G)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
		    Transakcja(T_HOFFER, DaneGracza[playerid][gUID], DaneGracza[strval(inputtext)][gUID], DaneGracza[playerid][gGUID], DaneGracza[strval(inputtext)][gGUID], GetPVarInt(playerid, "CenaBudynku"), uids, -1, -1, "-", gettime()-3600);
			Oferuj(playerid, strval(inputtext), 0, 0, uids, 0, OFEROWANIE_BUDYNKU, GetPVarInt(playerid, "CenaBudynku"), "");
	    }
	    return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_WN)
	{
	    if(response)
		{
			if(strlen(inputtext) > 32 || strlen(inputtext) < 3)
			{
				ShowPlayerDialog(playerid, DIALOG_DRZWI_OPCJE_WN, DIALOG_STYLE_INPUT, ""VER" ª Informacja", "Wpisz nowπ nazwe w pole niøej max 3-32 zanki.", "Zatwierdz", "Zamknij");
				return 1;
			}
			if(DaneGracza[playerid][gPORTFEL] < 100)
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie staÊ ciÍ na zmiane nazwy tego budynku.", "Zamknij", "");
			    return 1;
			}
			Dodajkase(playerid, -100);
			new uids = GetPVarInt(playerid, "uiddrzwi");
			format(NieruchomoscInfo[uids][nAdres], 50, "%s", inputtext);
   			ZapiszNieruchomosc(uids);
   			Transakcja(T_HZMNAZWY, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 100, uids, -1, -1, "-", gettime()-3600);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nazwa budynku zosta≥a zmieniona. Kwota ktÛra zosta≥a pobrana to 100$.", "Zamknij", "");
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
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc1], -1, "-", gettime()-3600);
			}
			else if(uid == 2)
			{
			NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc2];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc2], -1, "-", gettime()-3600);
			}
			else if(uid == 3)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc3];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc3], -1, "-", gettime()-3600);
			}
			else if(uid == 4)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc4];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc4], -1, "-", gettime()-3600);
			}
			else if(uid == 5)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc5];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc5], -1, "-", gettime()-3600);
			}
			else if(uid == 6)
			{
            NieruchomoscInfo[uids][nWlascicielP] = 0;
			NieruchomoscInfo[uids][nWlascicielD] = DaneGracza[playerid][gDzialalnosc6];
			Transakcja(T_HPODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, DaneGracza[playerid][gDzialalnosc6], -1, "-", gettime()-3600);
			}
			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Budynek zosta≥ podpisany pod dzia≥alnoúÊ.", "Zamknij", "");
		}
		else
		{
        	ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Anulowa≥eú transakcje pomyúlnie.", "Zamknij", "");
		}
		return 1;
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_BP)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
			NieruchomoscInfo[uids][nWlascicielP] = DaneGracza[playerid][gUID];
			NieruchomoscInfo[uids][nWlascicielD] = 0;
			ZapiszNieruchomosc(uids);
			Transakcja(T_HODPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, uids, -1, -1, "-", gettime()-3600);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Budynek zosta≥ przepisany na tπ postaÊ.", "Zamknij", "");
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
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "W≥πczy≥eú przejazd pojazdami w tym budynku.", "Zamknij", "");
   		}
		else
		{
			new uids = GetPVarInt(playerid, "uiddrzwi");
			NieruchomoscInfo[uids][nPrzejazd] = 0;
			ZapiszNieruchomosc(uids);
		    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Wy≥πczy≥eú przejazd pojazdami w tym budynku.", "Zamknij", "");
			return 0;
		}
	}
	if(dialogid == DIALOG_DRZWI_OPCJE_OB)
	{
	    if(response)
		{
		    new uids = GetPVarInt(playerid, "uiddrzwi");
		    new obiekty = NieruchomoscInfo[uids][nLiczbaMebli] + NieruchomoscInfo[uids][nStworzoneObiekty];
		    if(obiekty >= 150 )
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten budynek osiπgnπ≥ maxymalnπ iloúÊ obiektÛw na budynek (150).", "Zamknij", "");
			    return 0;
			}
			if(DaneGracza[playerid][gPORTFEL] < 1000)
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie staÊ ciÍ na zakup obiektu do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -1000);
			Transakcja(T_HOBIEKT, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 1000, uids, -1, -1, "-", gettime()-3600);
			NieruchomoscInfo[uids][nLiczbaMebli]++;
			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Zakupi≥eú jeden obiekt do budynku za kwote 1000$", "Zamknij", "");
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
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie staÊ ciÍ na zakup systemu audio do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -5000);
			Transakcja(T_HAUDIO, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 5000, uids, -1, -1, "-", gettime()-3600);
			NieruchomoscInfo[uids][nAudio] = 0;
			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Zakupi≥eú system audio do swojego budynku za kwote 5000$", "Zamknij", "");
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
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie staÊ ciÍ na zakup szafy do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -4000);
			Transakcja(T_HSZAFA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 4000, uids, -1, -1, "-", gettime()-3600);
			NieruchomoscInfo[uids][nSzafa] = 0;
			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Zakupi≥eú szafe do swojego budynku za kwote 4000$", "Zamknij", "");
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
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie staÊ ciÍ na zakup napisu do tego budynku.", "Zamknij", "");
			    return 0;
			}
			Dodajkase(playerid, -500);
			Transakcja(T_HNAPIS, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 500, uids, -1, -1, "-", gettime()-3600);
			NieruchomoscInfo[uids][nLiczbaNapisow]++;
			ZapiszNieruchomosc(uids);
			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Zakupi≥eú jeden napis do budynku za kwote 500$", "Zamknij", "");
   		}
		else
		{
			return 0;
		}
	}
	if(dialogid == DIALOG_BANKOMAT)
	{
	    if( !response )
	        return 1;
        switch(listitem)
		{
			case 0:
			{
			    new stri[256];
   			 	format(stri, sizeof(stri), "TwÛj stan konta to: %d$",DaneGracza[playerid][gSTAN_KONTA]);
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Bank", stri, "Zamknij", "");
				return 1;
			}
			case 1:
			{
				ShowPlayerDialog(playerid, DIALOG_BANKOMAT_WYPLAC, DIALOG_STYLE_INPUT, ""VER" ª Bank", "Podaj kwotÍ do wyp≥aty:", "Okej", "Anuluj");
				return 1;
			}
			case 2:
			{
				ShowPlayerDialog(playerid, DIALOG_BANKOMAT_WPLAC, DIALOG_STYLE_INPUT, ""VER" ª Bank", "Podaj kwotÍ do wp≥aty:", "Okej", "Anuluj");
				return 1;
			}
			case 3:
			{
				ShowPlayerDialog(playerid, DIALOG_BANKOMAT_PRZELEW, DIALOG_STYLE_INPUT, ""VER" ª Bank", "Podaj numer konta na ktÛry chcesz przelaÊ swoje pieniπdze:\nnp: 789456123  - koszt jednego przelewu wynosi: 10$", "Dalej", "Anuluj");
				return 1;
			}
		}
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
			ShowPlayerDialog(playerid, DIALOG_BANKOMAT_WYPLAC, DIALOG_STYLE_INPUT, ""VER" ª Bank", "Podaj kwotÍ do wyp≥aty:", "Okej", "Anuluj");
			return 1;
		}
		DaneGracza[playerid][gSTAN_KONTA] -= cash;
		Transakcja(T_BWYPLATA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, cash, -1, -1, -1, "-", gettime()-3600);
		Dodajkase(playerid, cash);
		new stri[256];
		format(stri, sizeof(stri), "~b~Wyplacono: ~w~%d$",cash);
		GameTextForPlayer(playerid, stri, 3000, 5);
		//ZapiszStanKonta(playerid);
		ZapiszBankKasa(playerid);
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
		ForeachExp(i, MAX_PLAYERS)
		{
		    new gnr[256];
			format(gnr, sizeof(gnr), "%d",DaneGracza[i][gNUMER_KONTA]);
			new wnr[256];
			format(wnr, sizeof(wnr), "%d",nr);
		    if(ComparisonString(gnr, wnr))
		    {
		        find = i;
		        break;
		    }
		}
		if(find == -1)
		{
		    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten gracz jest niepod≥πczony!", "Zamknij", "");
		    return 0;
		}else{
			if(find == playerid)
			{
                ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Nie moøesz zaoferowaÊ czegoú samemu sobie.", "Zamknij", "");
			    return 0;
			}
			if(!IsPlayerConnected(playerid))
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten gracz jest niepod≥πczony!", "Zamknij", "");
				return 1;
			}
			SetPVarInt(playerid, "idprzelew", find);
			new stri[256];
			format(stri, sizeof(stri), "Podaj kwotÍ ktÛrπ chcesz przelaÊ:\n{ffffff}Gracz: %s",ZmianaNicku(find));
			ShowPlayerDialog(playerid, DIALOG_BANKOMAT_PRZELEW_N, DIALOG_STYLE_INPUT, ""VER" ª Bank", stri, "Przelej", "Anuluj");
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
		if(!IsPlayerConnected(id))
		{
		    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ten gracz jest niepod≥πczony!", "Zamknij", "");
			return 1;
		}
		DaneGracza[playerid][gSTAN_KONTA] -= nr+10;
		DaneGracza[id][gSTAN_KONTA] += nr;
		ZapiszBankKasa(id);
		ZapiszBankKasa(playerid);
		Transakcja(T_BPRZELEW, DaneGracza[playerid][gUID], DaneGracza[id][gUID], DaneGracza[playerid][gGUID], DaneGracza[id][gGUID], nr, -1, -1, -1, "-", gettime()-3600);
		DeletePVar(playerid,"idprzelew");
		ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Przelew zosta≥ wykonany pomyúlnie!", "Zamknij", "");
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
			ShowPlayerDialog(playerid, DIALOG_BANKOMAT_WPLAC, DIALOG_STYLE_INPUT, ""VER" ª Bank", "Podaj kwotÍ do wp≥aty:", "Okej", "Anuluj");
			return 1;
		}
		DaneGracza[playerid][gSTAN_KONTA] += cash;
		Dodajkase(playerid, -cash);
		Transakcja(T_BWPLATA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, cash, -1, -1, -1, "-", gettime()-3600);
		new stri[256];
		format(stri, sizeof(stri), "~b~Wplacono: ~w~%d$",cash);
		GameTextForPlayer(playerid, stri, 3000, 5);
		//ZapiszStanKonta(playerid);
		ZapiszBankKasa(playerid);
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
			ShowPlayerDialog(playerid, DIALOG_HURTOWNIA_NEXT, DIALOG_STYLE_INPUT, ""VER" ª Hurtownia", "Wpisz iloúc sztuk:", "Dalej", "Anuluj");
		}
	}
	if(dialogid == DIALOG_HURTOWNIA_NEXT)
	{
		if( !response )
			return 1;
		new uid = strval(inputtext);
		if(uid <= 0)
		{
		    ShowPlayerDialog(playerid, DIALOG_HURTOWNIA_NEXT, DIALOG_STYLE_INPUT, ""VER" ª Hurtownia", "Wpisz iloúc sztuk:\n{ffff80}IloúÊ sztuk nie moøe byÊ mniejsza bπdz rÛwna 0.", "Dalej", "Anuluj");
		    return 0;
		}
		if(uid > 10)
		{
		    ShowPlayerDialog(playerid, DIALOG_HURTOWNIA_NEXT, DIALOG_STYLE_INPUT, ""VER" ª Hurtownia", "Wpisz iloúc sztuk:\n{ffff80}IloúÊ sztuk nie moøe byÊ wiÍksza od 10.", "Dalej", "Anuluj");
		    return 0;
		}
		SetPVarInt(playerid, "ILOSCHURT", uid);
		ShowPlayerDialog(playerid, DIALOG_HURTOWNIA_KWOTA, DIALOG_STYLE_INPUT, ""VER" ª Hurtownia", "Podaj kwotÍ za jakπ chcesz sprzedawaÊ jeden taki produkt:", "Dalej", "Anuluj");
	}
	if(dialogid == DIALOG_HURTOWNIA_KWOTA)
	{
		if( !response )
			return 1;
		new uid = strval(inputtext);
		if(uid <= HurtowniaInfo[GetPVarInt(playerid, "UIDHURT")][hCena])
		{
		    ShowPlayerDialog(playerid, DIALOG_HURTOWNIA_KWOTA, DIALOG_STYLE_INPUT, ""VER" ª Hurtownia", "Podaj kwotÍ za jakπ chcesz sprzedawaÊ jeden taki produkt:\n{ffff80}Kwota nie moøe byÊ mniejsza bπdz rÛwna cenie hurtowej.", "Dalej", "Anuluj");
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
		new text[246];
		new id = GetPVarInt(playerid, "idgrpodaj");
	    format(text, sizeof(text), "%s", MagazynInfo[uid][mNazwa]);
		A_HURT(text);
		A_HURT1(text);
		A_HURT2(text);
		Transakcja(T_OGASTRO, DaneGracza[playerid][gUID], DaneGracza[id][gUID], DaneGracza[playerid][gGUID], DaneGracza[id][gGUID], MagazynInfo[uid][mCena], MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], "-", gettime()-3600);
		Oferuj(playerid, GetPVarInt(playerid, "idgrpodaj"), uid, MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], MagazynInfo[uid][mOwner], MagazynInfo[uid][mCena], text);
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
		new text[246], strp[124];
	    format(text, sizeof(text), "%s", MagazynInfo[uid][mNazwa]);
		A_HURT(text);
		A_HURT1(text);
		A_HURT2(text);
		format(strp, sizeof(strp), "~b~Zakupiono przedmiot:~n~ ~w~%s~n~~y~Koszt: ~w~%d$",text, MagazynInfo[uid][mCena]);
		GameTextForPlayer(playerid, strp, 5000, 5);
		DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], MagazynInfo[uid][mWar2], text, DaneGracza[playerid][gUID], 0, -1, 0, 0,0);
		new vw = GetPlayerVirtualWorld(playerid);
    	new uidp = NieruchomoscInfo[vw][nWlascicielD];
    	GrupaInfo[uidp][gSaldo] += MagazynInfo[uid][mCena];
    	Transakcja(T_247K, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, MagazynInfo[uid][mCena], MagazynInfo[uid][mTyp], MagazynInfo[uid][mWar1], uidp, "-", gettime()-3600);
    	ZapiszSaldo(uidp);
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
		if(100 > DaneGracza[playerid][gPORTFEL])
		{
		    GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
			return 1;
		}
		new vw = GetPlayerVirtualWorld(playerid);
    	new uid = NieruchomoscInfo[vw][nWlascicielD];
    	GrupaInfo[uid][gSaldo] += 100;
		Dodajkase(playerid, -100);
		
		new nrkarty = 747562131 + DaneGracza[playerid][gUID];
		new String[124];
		new test[124];
		format(test, sizeof(test), "%s", iban(playerid));
		format(String, sizeof(String), "%s", test);
		for(new i=4; i < strlen(String); i+=5)
			strins(String, " ", i);
        new nrkonta = 100000000 + random(899999999);
        new cos = nrkontasprawdz(nrkonta);
		DodajKontoWBanku(playerid, GrupaInfo[uid][gNazwa], cos, nrkarty, "Los Santos", String, DaneGracza[playerid][gUID], GrupaInfo[uid][gUID]);
		ZapiszSaldo(uid);
		Transakcja(T_KWB, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, 100, uid, -1, -1, "-", gettime()-3600);
		new stri[254];
		format(stri, sizeof(stri), "W≥aúnie uda≥o ci siÍ za≥oøyÊ konto w banku. \
		\nNumer konta: %d\nNumer karty: %d\nBIC: Los Santos\nIBAN: %s", cos, nrkarty, String);
		ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Los Santos Bank", stri, "Zamknij", "");
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
			    new stri[124];
			    if(nrs == 1)
			    {
			        new uid = DaneGracza[playerid][gDzialalnosc1];
                    format(stri, sizeof(stri), "{88b711}%s{ffffff}\nW≥aúciciel: %s\nStan konta: %d$\nTyp dzia≥alnoúci: %s",GrupaInfo[uid][gNazwa], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]]);
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacje", stri, "Zamknij", "");
			    }
			    else if(nrs == 2)
			    {
                    new uid = DaneGracza[playerid][gDzialalnosc2];
                    format(stri, sizeof(stri), "{88b711}%s{ffffff}\nW≥aúciciel: %s\nStan konta: %d$\nTyp dzia≥alnoúci: %s",GrupaInfo[uid][gNazwa], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]]);
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacje", stri, "Zamknij", "");
			    }
			    else if(nrs == 3)
			    {
                    new uid = DaneGracza[playerid][gDzialalnosc3];
                    format(stri, sizeof(stri), "{88b711}%s{ffffff}\nW≥aúciciel: %s\nStan konta: %d$\nTyp dzia≥alnoúci: %s",GrupaInfo[uid][gNazwa], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]]);
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacje", stri, "Zamknij", "");
			    }
			    else if(nrs == 4)
			    {
                    new uid = DaneGracza[playerid][gDzialalnosc4];
                    format(stri, sizeof(stri), "{88b711}%s{ffffff}\nW≥aúciciel: %s\nStan konta: %d$\nTyp dzia≥alnoúci: %s",GrupaInfo[uid][gNazwa], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]]);
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacje", stri, "Zamknij", "");
			    }
			    else if(nrs == 5)
			    {
			        new uid = DaneGracza[playerid][gDzialalnosc5];
                    format(stri, sizeof(stri), "{88b711}%s{ffffff}\nW≥aúciciel: %s\nStan konta: %d$\nTyp dzia≥alnoúci: %s",GrupaInfo[uid][gNazwa], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]]);
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacje", stri, "Zamknij", "");
			    }
			    else if(nrs == 6)
			    {
			        new uid = DaneGracza[playerid][gDzialalnosc6];
			        format(stri, sizeof(stri), "{88b711}%s{ffffff}\nW≥aúciciel: %s\nStan konta: %s$\nTyp dzia≥alnoúci: %s",GrupaInfo[uid][gNazwa], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]]);
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacje", stri, "Zamknij", "");
				}
				return 1;
			}
			case 2:
			{
			    if(nrs == 1)
			    {
			    	Magazyn(playerid, DIALOG_INFO, ""VER" ª Magazyn", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc1], "Zamknij", "");
				}
				else if(nrs == 2)
			    {
			    	Magazyn(playerid, DIALOG_INFO, ""VER" ª Magazyn", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc2], "Zamknij", "");
				}
				else if(nrs == 3)
			    {
			    	Magazyn(playerid, DIALOG_INFO, ""VER" ª Magazyn", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc3], "Zamknij", "");
				}
				else if(nrs == 4)
			    {
			    	Magazyn(playerid, DIALOG_INFO, ""VER" ª Magazyn", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc4], "Zamknij", "");
				}
				else if(nrs == 5)
			    {
			    	Magazyn(playerid, DIALOG_INFO, ""VER" ª Magazyn", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc5], "Zamknij", "");
				}
				else if(nrs == 6)
			    {
			    	Magazyn(playerid, DIALOG_INFO, ""VER" ª Magazyn", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc6], "Zamknij", "");
				}
				return 1;
			}
			case 3:
			{
			    if(nrs == 1)
			    {
				    new str[124], temp = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
						if(DaneGracza[i][gUID] != 0 && DaneGracza[i][gSluzba] == DaneGracza[playerid][gDzialalnosc1])
						{
							temp++;
							format(str, sizeof(str), "%s\n[ID: %d]\t%s", str, i, ImieGracza2(i));
						}
					}
					if(temp == 0) return ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Online", "Brak pracownikÛw na s≥uøbie.", "Zamknij", "");
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, ""VER" ª Online", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 2)
			    {
				    new str[124], temp = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
						if(DaneGracza[i][gUID] != 0 && DaneGracza[i][gSluzba] == DaneGracza[playerid][gDzialalnosc2])
						{
							temp++;
							format(str, sizeof(str), "%s\n[ID: %d]\t%s", str, i, ImieGracza2(i));
						}
					}
					if(temp == 0) return ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Online", "Brak pracownikÛw na s≥uøbie.", "Zamknij", "");
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, ""VER" ª Online", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 3)
			    {
				    new str[124], temp = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
						if(DaneGracza[i][gUID] != 0 && DaneGracza[i][gSluzba] == DaneGracza[playerid][gDzialalnosc2])
						{
							temp++;
							format(str, sizeof(str), "%s\n[ID: %d]\t%s", str, i, ImieGracza2(i));
						}
					}
					if(temp == 0) return ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Online", "Brak pracownikÛw na s≥uøbie.", "Zamknij", "");
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, ""VER" ª Online", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 4)
			    {
				    new str[124], temp = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
						if(DaneGracza[i][gUID] != 0 && DaneGracza[i][gSluzba] == DaneGracza[playerid][gDzialalnosc2])
						{
							temp++;
							format(str, sizeof(str), "%s\n[ID: %d]\t%s", str, i, ImieGracza2(i));
						}
					}
					if(temp == 0) return ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Online", "Brak pracownikÛw na s≥uøbie.", "Zamknij", "");
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, ""VER" ª Online", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 5)
			    {
				    new str[124], temp = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
						if(DaneGracza[i][gUID] != 0 && DaneGracza[i][gSluzba] == DaneGracza[playerid][gDzialalnosc2])
						{
							temp++;
							format(str, sizeof(str), "%s\n[ID: %d]\t%s", str, i, ImieGracza2(i));
						}
					}
					if(temp == 0) return ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Online", "Brak pracownikÛw na s≥uøbie.", "Zamknij", "");
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, ""VER" ª Online", str, "Zamknij", "");
					return 1;
				}
				else if(nrs == 6)
			    {
				    new str[124], temp = 0;
					ForeachExp(i, MAX_PLAYERS)
					{
						if(DaneGracza[i][gUID] != 0 && DaneGracza[i][gSluzba] == DaneGracza[playerid][gDzialalnosc2])
						{
							temp++;
							format(str, sizeof(str), "%s\n[ID: %d]\t%s", str, i, ImieGracza2(i));
						}
					}
					if(temp == 0) return ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Online", "Brak pracownikÛw na s≥uøbie.", "Zamknij", "");
					ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, ""VER" ª Online", str, "Zamknij", "");
					return 1;
				}
				return 1;
			}
			case 4:
			{
			    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Informacja", "Ta opcja bÍdzie dostÍpna juø niebawem.", "Zamknij", "");
				return 1;
			}
			case 5:
			{
				new	list_vehicles[256], find = 0;
				if(nrs == 1)
				{
					ForeachExp(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc1])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) ShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, ""VER" ª Pojazdy dzia≥alnoúci", list_vehicles, "Wybierz", "WiÍcej");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ta dzia≥alnoúÊ nie posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 2)
				{
					ForeachExp(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc2])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) ShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, ""VER" ª Pojazdy dzia≥alnoúci", list_vehicles, "Wybierz", "WiÍcej");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ta dzia≥alnoúÊ nie posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 3)
				{
					ForeachExp(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc3])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) ShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, ""VER" ª Pojazdy dzia≥alnoúci", list_vehicles, "Wybierz", "WiÍcej");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ta dzia≥alnoúÊ nie posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 4)
				{
					ForeachExp(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc4])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) ShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, ""VER" ª Pojazdy dzia≥alnoúci", list_vehicles, "Wybierz", "WiÍcej");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ta dzia≥alnoúÊ nie posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 5)
				{
					ForeachExp(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc5])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) ShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, ""VER" ª Pojazdy dzia≥alnoúci", list_vehicles, "Wybierz", "WiÍcej");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ta dzia≥alnoúÊ nie posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				else if(nrs == 6)
				{
					ForeachExp(i, MAX_VEH)
					{
						if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc6])
						{
							if(PojazdInfo[i][pSpawn] != 0)
							{
								format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							}
							else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							find++;
						}
					}
					if(find > 0) ShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, ""VER" ª Pojazdy dzia≥alnoúci", list_vehicles, "Wybierz", "WiÍcej");
					else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" ª Pojazdy", "Ta dzia≥alnoúÊ nie posiada øadnych pojazdÛw.", "Zamknij", "");
				}
				return 1;
			}
			case 6:
			{
			    new stre[256];
				strcat(stre, "\t\t\t\t\t\t\tOg≥oszenie\n");
				strcat(stre, "\n");
				strcat(stre, "Tutaj moøna wypisaÊ regulaminy, og≥oszenia spotkac itp... tablica jest do waszej dyspozycji...\n");
				strcat(stre, "-------------------------------------\n");
				strcat(stre, "\n");
				strcat(stre, "\n");
				strcat(stre, "1.\tPierszy punkt regulaminu\n");
				strcat(stre, "2.\tDrugi punkt\n");
				strcat(stre, "3.\tTrzeci Punkt\n");
				strcat(stre, "4.\tCzwarty Punkt\n");
				strcat(stre, "\n");
				strcat(stre, "\n");
				strcat(stre, "-------------------------------------\n");
				strcat(stre, "\n");
				strcat(stre, "Tekst jest ca≥y czas moøliwy do edycji jednak jedynie dla lidera a w krÛtce dla posiadajπcych uprawnienia\n");
				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Test", stre, "OK", "Anuluj");
				return 1;
			}
		}
	}
	return 1;
}