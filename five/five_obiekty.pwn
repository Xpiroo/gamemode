AntiDeAMX();
CMD:msel( playerid, params[ ] )
{
	//printf("U¿yta komenda msel");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nMapa] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
		return 0;
	}
	if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
	{
		new uids = GetPVarInt(playerid, "inedit");
	    ZapiszObiekt(uids);
		CancelEdit(playerid);
		OnPlayerText(playerid, "-stopani");
        obiektinedit[uids] = false;
        DeletePVar(playerid,"idobiktu");
        DeletePVar(playerid,"inedit");
        TextDrawHideForPlayer(playerid, OBJ[playerid]);
        Edytors[playerid] = 0;
	}
	if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nStworzoneObiekty] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W budynu którym siê {88b711}znajdujesz{DEDEDE} nie ma stworzonych obiektów.", "Zamknij", "");
		return 0;
	}
	new uid;
	new id_budynku = GetPlayerVirtualWorld(playerid);
	if(sscanf(params, "d", uid))
	{
	    new uids = 0, Float:radius = 0.5;
		for(new i = 0; i < 100; i++)
		{
			if(uids == 0)
			{
				ForeachEx(h, NieruchomoscInfo[id_budynku][nStworzoneObiekty])
				{
					if(Dystans(radius, playerid, ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozZ]))
					{
						uids = NieruchomoscInfo[id_budynku][nObiekty][h];
						break;
					}
				}
				radius+=0.5;
			}else{
			if(obiektinedit[uids] == true)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten obiekt {88b711}w³aœnie{DEDEDE} ju¿ ktoœ edytuje.", "Zamknij", "");
				return 0;
			}else{
				SetPVarInt(playerid, "inedit", uids);
				obiektinedit[uids] = true;
				if(DaneGracza[playerid][gEdytor] == 0)
				{
					EditDynamicObject(playerid, ObiektInfo[uids][objSAMP]);
					edycjaobiektow[playerid] = 0;
					Edytors[playerid] = 1;
				}else{
					edycjaobiektow[playerid] = 1;
					CancelEdit(playerid);
					ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
					ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
					Edytors[playerid] = 1;
				}
				SetPVarInt(playerid, "idobiktu", uids);
			}
			break;
			}
		}
		if(uids == 0)
		{
			GameTextForPlayer(playerid, "~r~Brak obiektow w poblizu.", 3000, 5);
		}
		return 1;
	}
	else
	{
		new uids = 0, Float:radius = 0.5;
		for(new i = 0; i < 100; i++)
		{
			if(uids == 0)
			{
				ForeachEx(h, NieruchomoscInfo[id_budynku][nStworzoneObiekty])
				{
					if(Dystans(radius, playerid, ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozZ]) && ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objModel] == uid)
					{
						uids = NieruchomoscInfo[id_budynku][nObiekty][h];
						break;
					}
				}
				radius+=0.5;
			}else{
			if(obiektinedit[uids] == true)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten obiekt {88b711}w³aœnie{DEDEDE} ju¿ ktoœ edytuje.", "Zamknij", "");
				return 0;
			}else{
				SetPVarInt(playerid, "inedit", uids);
				obiektinedit[uids] = true;
				if(DaneGracza[playerid][gEdytor] == 0)
				{
					EditDynamicObject(playerid, ObiektInfo[uids][objSAMP]);
					edycjaobiektow[playerid] = 0;
					Edytors[playerid] = 1;
				}else{
					edycjaobiektow[playerid] = 1;
					CancelEdit(playerid);
					ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
					ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
					Edytors[playerid] = 1;
				}
				SetPVarInt(playerid, "idobiktu", uids);
			}
			break;
			}
		}
		if(uids == 0)
		{
			GameTextForPlayer(playerid, "~r~Brak obiektow w poblizu.", 3000, 5);
		}
	}
	return 1;
}
CMD:md( playerid, params[ ] )
{
	//printf("U¿yta komenda md");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	new id = GetPVarInt(playerid, "idobiktu");
	if(id == 0)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
	    return 0;
	}
	UsunObiekt(id);
	ClearAnimations(playerid);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
	CancelEdit(playerid);
	DeletePVar(playerid,"idobiktu");
    DeletePVar(playerid,"inedit");
    TextDrawHideForPlayer(playerid, OBJ[playerid]);
	return 1;
}
/*CMD:amd( playerid, params[ ] )
{
	//printf("U¿yta komenda amd");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		new myobject = GetPVarInt(playerid, "idobiktu");
		new id = SprawdzObiektUID(myobject);
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		UsunObiekt(id);
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
		ClearAnimations(playerid);
		CancelEdit(playerid);
		DeletePVar(playerid,"idobiktu");
		DeletePVar(playerid,"inedit");
		TextDrawHideForPlayer(playerid, OBJ[playerid]);
	}
	return 1;
}*/
forward UsunObiekt(id);
public UsunObiekt(id)
{
    new sqls[100];
	format( sqls, sizeof( sqls ), "DELETE FROM `five_textury` WHERE `model` = %d", id );
	mysql_query( sqls );

	new sql[100];
	format( sql, sizeof( sql ), "DELETE FROM `five_obiekty` WHERE `ID` = %d", id );
	mysql_query( sql );

	if(ObiektInfo[id][objModel] == 2419)
	{
		ForeachEx(i, MAX_PRZEDMIOT)
		{
			if(PrzedmiotInfo[i][pOwner] == id && PrzedmiotInfo[i][pTypWlas] == TYP_CRAFT && PrzedmiotInfo[i][pUID] != 0)
			{
				UsunPrzedmiot(i);
			}
		}
	}
	DestroyDynamicObject(ObiektInfo[id][objSAMP]);
	for(new i = 0; i < 2048; i++)
	{
		if(NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] == id)
		{
			for(new o = i, d; o < NieruchomoscInfo[ObiektInfo[id][objvWorld]][nStworzoneObiekty]; o++)
			{
				d = o+1;
				NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][o] = NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][d];
			}
			break;
		}
	}
	NieruchomoscInfo[ObiektInfo[id][objvWorld]][nStworzoneObiekty]--;
	if(ObiektInfo[id][objModel] != 364 && ObiektInfo[id][objModel] != 1958)
	{
		NieruchomoscInfo[ObiektInfo[id][objvWorld]][nLiczbaMebli]++;
	}
	ZapiszNieruchomosc(ObiektInfo[id][objvWorld]);
	ObiektInfo[id][objUID] = 0;
	ObiektInfo[id][objSAMP] = 0;
	ObiektInfo[id][objModel] = 0;
	ObiektInfo[id][objvWorld] = 0;
	ObiektInfo[id][objInterior] = 0;
	ObiektInfo[id][objPozX] = 0;
	ObiektInfo[id][objPozY] = 0;
	ObiektInfo[id][objPozZ] = 0;
	ObiektInfo[id][objPosX] = 0;
	ObiektInfo[id][objPosY] = 0;
	ObiektInfo[id][objPosZ] = 0;
	ObiektInfo[id][objBrama] = 0;
	ObiektInfo[id][objSprarowanyUID] = 0;
	ObiektInfo[id][objOwnerBrama] = 0;
	ObiektInfo[id][objTypOwneraBramy] = 0;
	ObiektInfo[id][objRotX] = 0;
	ObiektInfo[id][objRotY] = 0;
	ObiektInfo[id][objRotZ] = 0;
	for(new i = 0; i < 6; i++)
	{
		ObiektInfo[id][objPoker][i] = -1;
		ObiektInfo[id][gAktualniGracze][i] = -1;
	}
	UpdateDynamic3DTextLabelText(ObiektInfo[id][objNapis], 0xC2A2DAFF, " ");
	return 1;
}
/*CMD:arz( playerid, params[ ] )
{
	//printf("U¿yta komenda arz");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(DaneGracza[playerid][gEdytor] == 0)
		{
			return 0;
		}
		new Float:model;
		if( sscanf( params, "f", model) )
			return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}obróciæ{DEDEDE} obiekt w osi {88b711}Z{DEDEDE} wpisz: {88b711}/arz [rotacja]", "Zamknij", "");
		new myobject = GetPVarInt(playerid, "idobiktu");
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		new ids = SprawdzObiektUID(myobject);
		ObiektInfo[ids][objRotZ] += model;
		SetDynamicObjectRot(myobject,ObiektInfo[ids][objRotX],ObiektInfo[ids][objRotY],ObiektInfo[ids][objRotZ]);
	}
	return 1;
}*/
/*CMD:ary( playerid, params[ ] )
{
	//printf("U¿yta komenda ary");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(DaneGracza[playerid][gEdytor] == 0)
		{
			return 0;
		}
		new Float:model;
		if( sscanf( params, "f", model) )
			return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}obróciæ{DEDEDE} obiekt w osi {88b711}Y{DEDEDE} wpisz: {88b711}/ary [rotacja]", "Zamknij", "");
		new myobject = GetPVarInt(playerid, "idobiktu");
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		new ids = SprawdzObiektUID(myobject);
		ObiektInfo[ids][objRotY] += model;
		SetDynamicObjectRot(myobject,ObiektInfo[ids][objRotX],ObiektInfo[ids][objRotY],ObiektInfo[ids][objRotZ]);
	}
	return 1;
}*/
/*CMD:arx( playerid, params[ ] )
{
	//printf("U¿yta komenda arx");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(DaneGracza[playerid][gEdytor] == 0)
		{
			return 0;
		}
		new Float:model;
		if( sscanf( params, "f", model) )
			return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}obróciæ{DEDEDE} obiekt w osi {88b711}X{DEDEDE} wpisz: {88b711}/arx [rotacja]", "Zamknij", "");
		new myobject = GetPVarInt(playerid, "idobiktu");
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		new ids = SprawdzObiektUID(myobject);
		ObiektInfo[ids][objRotX] += model;
		SetDynamicObjectRot(myobject,ObiektInfo[ids][objRotX],ObiektInfo[ids][objRotY],ObiektInfo[ids][objRotZ]);
	}
	return 1;
}*/
CMD:rz( playerid, params[ ] )
{
	//printf("U¿yta komenda rz");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	if(DaneGracza[playerid][gEdytor] == 0)
	{
	    return 0;
	}
	new Float:model;
	if( sscanf( params, "f", model) )
		return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}obróciæ{DEDEDE} obiekt w osi {88b711}Z{DEDEDE} wpisz: {88b711}/rz [rotacja]", "Zamknij", "");
	new myobject = GetPVarInt(playerid, "idobiktu");
	if(myobject == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
		return 0;
	}
	//new ids = SprawdzObiektUID(myobject);
	ObiektInfo[myobject][objRotZ] += model;
	SetDynamicObjectRot(ObiektInfo[myobject][objSAMP],ObiektInfo[myobject][objRotX],ObiektInfo[myobject][objRotY],ObiektInfo[myobject][objRotZ]);
	return 1;
}
CMD:ry( playerid, params[ ] )
{
	//printf("U¿yta komenda ry");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	if(DaneGracza[playerid][gEdytor] == 0)
	{
	    return 0;
	}
	new Float:model;
	if( sscanf( params, "f", model) )
		return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}obróciæ{DEDEDE} obiekt w osi {88b711}Y{DEDEDE} wpisz: {88b711}/ry [rotacja]", "Zamknij", "");
	new myobject = GetPVarInt(playerid, "idobiktu");
	if(myobject == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
		return 0;
	}
	//new ids = SprawdzObiektUID(myobject);
	ObiektInfo[myobject][objRotY] += model;
	SetDynamicObjectRot(ObiektInfo[myobject][objSAMP],ObiektInfo[myobject][objRotX],ObiektInfo[myobject][objRotY],ObiektInfo[myobject][objRotZ]);
	return 1;
}
CMD:rx( playerid, params[ ] )
{
	//printf("U¿yta komenda rx");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	if(DaneGracza[playerid][gEdytor] == 0)
	{
	    return 0;
	}
	new Float:model;
	if( sscanf( params, "f", model) )
		return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}obróciæ{DEDEDE} obiekt w osi {88b711}X{DEDEDE} wpisz: {88b711}/rx [rotacja]", "Zamknij", "");
	new myobject = GetPVarInt(playerid, "idobiktu");
	if(myobject == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
		return 0;
	}
	//new ids = SprawdzObiektUID(myobject);
	ObiektInfo[myobject][objRotX] += model;
	SetDynamicObjectRot(ObiektInfo[myobject][objSAMP],ObiektInfo[myobject][objRotX],ObiektInfo[myobject][objRotY],ObiektInfo[myobject][objRotZ]);
	return 1;
}
CMD:ama( playerid, params[ ] )
{
	//printf("U¿yta komenda ama");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new model, id;
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			return 0;
		}
		if( sscanf( params, "i", model ) )
			return dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Aby stworzyæ {88b711}obiekt{DEDEDE} wpisz: {88b711}/ama [model]", "Zamknij", "" );
		if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
		{
			new uids = GetPVarInt(playerid, "inedit");
			ZapiszObiekt(uids);
			CancelEdit(playerid);
			OnPlayerText(playerid, "-stopani");
			obiektinedit[uids] = false;
			DeletePVar(playerid,"idobiktu");
			DeletePVar(playerid,"inedit");
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			Edytors[playerid] = 0;
		}
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z );
		id = DodajObiekt( model, x, y+1.50, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
		Streamer_Update(playerid);
		if(DaneGracza[playerid][gEdytor] == 0)
		{
			EditDynamicObject(playerid, ObiektInfo[id][objSAMP]);
			edycjaobiektow[playerid] = 0;
		}else{
			edycjaobiektow[playerid] = 1;
			CancelEdit(playerid);
			ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
			ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
		}
		SetPVarInt(playerid, "idobiktu", id);
	}
	return 1;
}
CMD:brama(playerid, params[])
{
	//printf("U¿yta komenda brama");
	if(zalogowany[playerid] == false)//false = nie, true = tak.
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    new find = 0;
	new Float:radius = 0.5;
	new uid_budynku = GetPlayerVirtualWorld(playerid);
	for(new i = 0; i < 100; i++)
	{
		if(find == 0)
		{
			ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
			{
				if(Dystans(radius, playerid, ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozZ]) && GetPlayerVirtualWorld(playerid) == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld] && ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objBrama] != 0)
				{
					find = NieruchomoscInfo[uid_budynku][nObiekty][h];
					break;
				}
			}
			radius+=0.5;
		}
	}
	if(find == 0)
	{
		GameTextForPlayer(playerid, "~r~Brak bram w poblizu.", 3000, 5);
		return 0;
	}
	if(!OtwieranieBramV2(playerid, find))
	{
		GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
		return 0;
	}
	if(obiektinedit[find] == true)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ poniewa¿ {88b711}pobliska{DEDEDE} brama jest edytowana.", "Zamknij", "");
		return 0;
	}
	if(find == 0)
	{
		GameTextForPlayer(playerid, "~r~W pobli¿u nie ma bramy.", 3000, 5);
	    return 0;
	}
	new findt = ObiektInfo[find][objSprarowanyUID];
	if(findt != 0)
	{
		BramaRuch(playerid, find, findt);
	}else{
		BramaRuch(playerid, find, -1);
	}
	return 1;
}
stock BramaRuch(playerid, uid, uid2)
{
	if(ObiektInfo[uid][objBrama] == 1)
	{
		if(ObiektInfo[uid][objOtw] == 0)
		{
			MoveDynamicObject(ObiektInfo[uid][objSAMP],ObiektInfo[uid][objPosX], ObiektInfo[uid][objPosY], ObiektInfo[uid][objPosZ], 2);
			SetDynamicObjectRot(ObiektInfo[uid][objSAMP], ObiektInfo[uid][objRotX], ObiektInfo[uid][objRotY], ObiektInfo [uid][objRotZ]);
			if(uid2 != -1)
			{
				MoveDynamicObject(ObiektInfo[uid2][objSAMP],ObiektInfo[uid2][objPosX], ObiektInfo[uid2][objPosY], ObiektInfo[uid2][objPosZ], 2);
				SetDynamicObjectRot(ObiektInfo[uid2][objSAMP], ObiektInfo[uid2][objRotX], ObiektInfo[uid2][objRotY], ObiektInfo [uid2][objRotZ]);
				ObiektInfo[uid2][objOtw] = 1;
			}
			GameTextForPlayer(playerid, "~g~Brama: ~w~otwarta", 3000, 6);
			ObiektInfo[uid][objOtw] = 1;
		}
		else
		{
			MoveDynamicObject(ObiektInfo[uid][objSAMP],ObiektInfo[uid][objPozX], ObiektInfo[uid][objPozY], ObiektInfo[uid][objPozZ], 2);
			SetDynamicObjectRot(ObiektInfo[uid][objSAMP], ObiektInfo[uid][objRotX], ObiektInfo[uid][objRotY], ObiektInfo [uid][objRotZ]);
			if(uid2 != -1)
			{
				MoveDynamicObject(ObiektInfo[uid2][objSAMP],ObiektInfo[uid2][objPozX], ObiektInfo[uid2][objPozY], ObiektInfo[uid2][objPozZ], 2);
				SetDynamicObjectRot(ObiektInfo[uid2][objSAMP], ObiektInfo[uid2][objRotX], ObiektInfo[uid2][objRotY], ObiektInfo[uid2][objRotZ]);
				ObiektInfo[uid2][objOtw] = 0;
			}
			GameTextForPlayer(playerid, "~r~Brama: ~w~zamknieta", 3000, 6);
			ObiektInfo[uid][objOtw] = 0;
		}
	}
	if(ObiektInfo[uid][objBrama] == 2)
	{
		if(ObiektInfo[uid][objOtw] == 0)
		{
			MoveDynamicObject(ObiektInfo[uid][objSAMP],ObiektInfo[uid][objPozX], ObiektInfo[uid][objPozY], ObiektInfo[uid][objPozZ], 0.5, ObiektInfo[uid][objPosX], ObiektInfo[uid][objPosY], ObiektInfo[uid][objPosZ]);
			/*SetDynamicObjectRot(ObiektInfo[uid][objSAMP], ObiektInfo[uid][objPosX], ObiektInfo[uid][objPosY], ObiektInfo [uid][objPosZ]);
			if(uid2 != -1)
			{
				MoveDynamicObject(ObiektInfo[uid2][objSAMP],ObiektInfo[uid2][objPozX], ObiektInfo[uid2][objPozY], ObiektInfo[uid2][objPozZ], 2);
				SetDynamicObjectRot(ObiektInfo[uid2][objSAMP], ObiektInfo[uid2][objPosX], ObiektInfo[uid2][objPosY], ObiektInfo[uid2][objPosZ]);
				ObiektInfo[uid2][objOtw] = 1;
			}*/
			GameTextForPlayer(playerid, "~g~Brama: ~w~otwarta", 3000, 6);
			ObiektInfo[uid][objOtw] = 1;
		}
		else
		{
			MoveDynamicObject(ObiektInfo[uid][objSAMP],ObiektInfo[uid][objPozX], ObiektInfo[uid][objPozY], ObiektInfo[uid][objPozZ], 2);
			SetDynamicObjectRot(ObiektInfo[uid][objSAMP], ObiektInfo[uid][objRotX], ObiektInfo[uid][objRotY], ObiektInfo [uid][objRotZ]);
			if(uid2 != -1)
			{
				MoveDynamicObject(ObiektInfo[uid2][objSAMP],ObiektInfo[uid2][objPozX], ObiektInfo[uid2][objPozY], ObiektInfo[uid2][objPozZ], 2);
				SetDynamicObjectRot(ObiektInfo[uid2][objSAMP], ObiektInfo[uid2][objRotX], ObiektInfo[uid2][objRotY], ObiektInfo [uid2][objRotZ]);
				ObiektInfo[uid2][objOtw] = 0;
			}
			GameTextForPlayer(playerid, "~r~Brama: ~w~zamknieta", 3000, 6);
			ObiektInfo[uid][objOtw] = 0;
		}
	}
    return true;
}
CMD:amgate( playerid, params[ ] )
{
	//printf("U¿yta komenda amgate");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		new myobject = GetPVarInt(playerid, "idobiktu");
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nMapa] == 1)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
			return 0;
		}
		new typ, Float:x, Float:y, Float:z, model, typ_ownera, owner;
		if( sscanf( params, "dfffddd",typ ,x, y, z, model, typ_ownera, owner ) )
			return dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Aby ustawiæ {88b711}obiekt{DEDEDE} jako ruchom¹ {88b711}brame{DEDEDE} wpisz: {88b711}/amgate [0-1,  0-off, 1-on] [POZX] [POZY] [POZZ] [SPAROWANY OBIEKT] [TYP OWNERA] [OWNER]\n{DEDEDE}- jeœli obiekt ma byæ {88b711}niespraowany{DEDEDE} wpisz w te pole 0", "Zamknij", "" );
		if(typ != 1 && typ !=0 && typ != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podany {88b711}typ{DEDEDE} jest niepoprawny.", "Zamknij", "");
			return 0;
		}
		if(ObiektInfo[model][objvWorld] != GetPlayerVirtualWorld(playerid) && model != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Parametr {88b711}sparowanego{DEDEDE} obiektu jest niepoprawny.", "Zamknij", "");
			return 0;
		}
		ObiektInfo[myobject][objBrama] = typ;
		if(typ == 1)
		{
			ObiektInfo[myobject][objPosX] = ObiektInfo[myobject][objPozX] + x;
			ObiektInfo[myobject][objPosY] = ObiektInfo[myobject][objPozY] + y;
			ObiektInfo[myobject][objPosZ] = ObiektInfo[myobject][objPozZ] + z;
		}
		else if(typ == 2)
		{
			ObiektInfo[myobject][objPosX] = ObiektInfo[myobject][objPozX] + x;
			ObiektInfo[myobject][objPosY] = ObiektInfo[myobject][objPozY] + y;
			ObiektInfo[myobject][objPosZ] = ObiektInfo[myobject][objPozZ] + z;
		}
		ObiektInfo[myobject][objSprarowanyUID] = model;
		new vww = GetPlayerVirtualWorld(playerid);
		if(NieruchomoscInfo[vww][nWlascicielP] == 0 && NieruchomoscInfo[vww][nWlascicielD] != 0)
		{
			ObiektInfo[myobject][objTypOwneraBramy] = typ_ownera;
			ObiektInfo[myobject][objOwnerBrama] = owner;
		}
		else
		{
			ObiektInfo[myobject][objTypOwneraBramy] = typ_ownera;
			ObiektInfo[myobject][objOwnerBrama] = owner;
		}
		if(model != 0)
		{
			ObiektInfo[model][objSprarowanyUID] = myobject;
		}
		ZapiszObiekt(myobject);
		ZapiszObiekt(model);
	}
	return 1;
}
CMD:mgate( playerid, params[ ] )
{
	//printf("U¿yta komenda mgate");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	new myobject = GetPVarInt(playerid, "idobiktu");
	if(myobject == 0)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
	    return 0;
	}
	if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nMapa] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
		return 0;
	}
	new typ, Float:x, Float:y, Float:z, model;
	if( sscanf( params, "dfffd",typ ,x, y, z, model ) )
	    return dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Aby ustawiæ {88b711}obiekt{DEDEDE} jako ruchom¹ {88b711}brame{DEDEDE} wpisz: {88b711}: /mgate [0-1,  0-off, 1-pozycja, 2-rotacja] [POZX] [POZY] [POZZ] [SPAROWANY OBIEKT]\n{DEDEDE}- jeœli obiekt ma byæ {88b711}niespraowany{DEDEDE} wpisz w te pole 0", "Zamknij", "" );
    if(typ != 1 && typ !=0 && typ != 2)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podany {88b711}typ{DEDEDE} jest niepoprawny.", "Zamknij", "");
	    return 0;
	}
	if(ObiektInfo[model][objvWorld] != GetPlayerVirtualWorld(playerid) && model != 0)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Parametr {88b711}sparowanego{DEDEDE} obiektu jest niepoprawny.", "Zamknij", "");
	    return 0;
	}
    ObiektInfo[myobject][objBrama] = typ;
    if(typ == 1)
	{
		ObiektInfo[myobject][objPosX] = ObiektInfo[myobject][objPozX] + x;
		ObiektInfo[myobject][objPosY] = ObiektInfo[myobject][objPozY] + y;
		ObiektInfo[myobject][objPosZ] = ObiektInfo[myobject][objPozZ] + z;
	}
	else if(typ == 2)
	{
		ObiektInfo[myobject][objPosX] = ObiektInfo[myobject][objPozX] + x;
		ObiektInfo[myobject][objPosY] = ObiektInfo[myobject][objPozY] + y;
		ObiektInfo[myobject][objPosZ] = ObiektInfo[myobject][objPozZ] + z;
	}
	ObiektInfo[myobject][objSprarowanyUID] = model;
	new vww = GetPlayerVirtualWorld(playerid);
	if(NieruchomoscInfo[vww][nWlascicielP] == 0 && NieruchomoscInfo[vww][nWlascicielD] != 0)
	{
		if(model != 0)
		{
			ObiektInfo[model][objSprarowanyUID] = myobject;
			ObiektInfo[model][objTypOwneraBramy] = BRAMA_DZIALALNOSC;
			ObiektInfo[model][objOwnerBrama] = NieruchomoscInfo[vww][nWlascicielD];
		}
		ObiektInfo[myobject][objTypOwneraBramy] = BRAMA_DZIALALNOSC;
		ObiektInfo[myobject][objOwnerBrama] = NieruchomoscInfo[vww][nWlascicielD];
	}
	else
	{
		if(model != 0)
		{
			ObiektInfo[model][objSprarowanyUID] = myobject;
			ObiektInfo[model][objTypOwneraBramy] = BRAMA_OWNER;
			ObiektInfo[model][objOwnerBrama] = NieruchomoscInfo[vww][nWlascicielP];
		}
		ObiektInfo[myobject][objTypOwneraBramy] = BRAMA_OWNER;
		ObiektInfo[myobject][objOwnerBrama] = NieruchomoscInfo[vww][nWlascicielP];
	}
	ZapiszObiekt(myobject);
	ZapiszObiekt(model);
	return 1;
}
CMD:ma( playerid, params[ ] )
{
	//printf("U¿yta komenda ma");
	if(AntySpam[playerid][1] == 1)
	{
		return 0;
	}
	AntySpam[playerid][1] = 1;
	SetTimerEx("SpamKomend2",2000,0,"d",playerid);
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new model, id;
	if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nMapa] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		return 0;
	}
	if( sscanf( params, "i", model ) )
	    return dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Aby stworzyæ {88b711}obiekt{DEDEDE} wpisz: {88b711}/ma [model]", "Zamknij", "" );
	if(model == 364 || model == 1958)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Stworzenie tego {88b711}obiektu{DEDEDE} nie jest mo¿liwe!\nObiekt ten mo¿na uzyskaæ w Biznesie typu \"{88b711}Elektryk{DEDEDE}\"", "Zamknij", "");
		return 0;
	}
	if(model < 331)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Obiekt którego ID poda³eœ, nie istnieje!", "Zamknij", "");
		return 0;
	}
	if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
	{
		new uids = GetPVarInt(playerid, "inedit");
	    ZapiszObiekt(uids);
		CancelEdit(playerid);
		OnPlayerText(playerid, "-stopani");
        obiektinedit[uids] = false;
        DeletePVar(playerid,"idobiktu");
        DeletePVar(playerid,"inedit");
        TextDrawHideForPlayer(playerid, OBJ[playerid]);
        Edytors[playerid] = 0;
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z );
	id = DodajObiekt( model, x, y+1.50, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
	Streamer_Update(playerid);
	if(DaneGracza[playerid][gEdytor] == 0)
    {
		EditDynamicObject(playerid, ObiektInfo[id][objSAMP]);
		edycjaobiektow[playerid] = 0;
	}else{
	    edycjaobiektow[playerid] = 1;
	    CancelEdit(playerid);
	    ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
	    ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
	}
	Edytors[playerid] = 1;
	SetPVarInt(playerid, "idobiktu", id);
	return 1;
}
CMD:edytor(playerid, cmdtext[])
{
	//printf("U¿yta komenda edytor");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0 || DaneGracza[playerid][gAdmGroup] == 4)
	{
	    if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
		{
			new uids = GetPVarInt(playerid, "inedit");
			ZapiszObiekt(uids);
			CancelEdit(playerid);
			OnPlayerText(playerid, "-stopani");
			obiektinedit[uids] = false;
			DeletePVar(playerid,"idobiktu");
			DeletePVar(playerid,"inedit");
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			Edytors[playerid] = 0;
		}
 		dShowPlayerDialog( playerid, DIALOG_EDYTOR, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Tutaj mo¿esz wybraæ jakim {88b711}edytorem{DEDEDE} obiektów chcesz siê pos³ugiwaæ.\n{88b711}MTA{DEDEDE} - Stawianie obiektów polega na ich ustawianiu za pomoc¹ myszki\n{88b711}SAMP{DEDEDE} - Stawianie obiektów polega na ich ustawianiu za pomoc¹ klawiszów W,A,S,D", "MTA", "SAMP" );
	}
	return 1;
}
forward SprawdzObiektUID(carid);
public SprawdzObiektUID(carid)
{
	for(new i = 1;i < MAX_OBIEKT; i++)
		if(ObiektInfo[i][objSAMP] == carid)
			return i;
	return 1;
}
forward ZaladujObiekty();
public ZaladujObiekty()
{
	new sql[ 1000 ], id = false,kur;
	mysql_query( "SELECT * FROM `five_obiekty`" );
	mysql_store_result( );
	while( mysql_fetch_row( sql ) )
	{
	    sscanf( sql, "p<|>i", id );
	    sscanf( sql, "p<|>iiii\
	    fffffffffdddddddd",
	    ObiektInfo[ id ][ objUID ],
	    ObiektInfo[ id ][ objModel ],
	    ObiektInfo[ id ][ objvWorld ],
	    ObiektInfo[ id ][ objInterior ],
	    ObiektInfo[ id ][ objPozX ],
	    ObiektInfo[ id ][ objPozY ],
	    ObiektInfo[ id ][ objPozZ ],
	    ObiektInfo[ id ][ objRotX ],
	    ObiektInfo[ id ][ objRotY ],
	    ObiektInfo[ id ][ objRotZ ],
	    ObiektInfo[id][objPosX],
		ObiektInfo[id][objPosY],
		ObiektInfo[id][objPosZ],
		ObiektInfo[id][objBrama],
		ObiektInfo[id][objSprarowanyUID],
		ObiektInfo[id][objWlacznik],
		ObiektInfo[id][objWartosc],
		ObiektInfo[id][objOwnerBrama],
		ObiektInfo[id][objTypOwneraBramy],
		kur,
		ObiektInfo[id][objOwnerDz]
	    );
		for(new i = 0; i < 2048; i++)
		{
			if(NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] == 0)
		    {
				NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] = ObiektInfo[id][objUID];
				break;
			}
		}
		NieruchomoscInfo[ObiektInfo[id][objvWorld]][nStworzoneObiekty] += 1;
		for(new i = 0; i < 6; i++)
		{
			ObiektInfo[id][objPoker][i] = -1;
			ObiektInfo[id][gAktualniGracze][i] = -1;
			ObiektInfo[0][objPoker][i] = -1;
			ObiektInfo[0][gAktualniGracze][i] = -1;
		}
		ObiektInfo[id][gPokerObj] = EOS;
		ObiektInfo[id][objPokerDiler] = 0;
		ObiektInfo[id][gRundaPoker] = 0;
	    ObiektInfo[ id ][ objSAMP ] = CreateDynamicObject( ObiektInfo[ id ][ objModel ], ObiektInfo[ id ][ objPozX ],
	    ObiektInfo[ id ][ objPozY ], ObiektInfo[ id ][ objPozZ ], ObiektInfo[ id ][ objRotX ], ObiektInfo[ id ][ objRotY ],
	    ObiektInfo[ id ][ objRotZ ], ObiektInfo[ id ][ objvWorld ], ObiektInfo[ id ][ objInterior ] );
	    ObiektInfo[id][objOtw] = 0;
	    obiektinedit[id] = false;
		ObiektInfo[id][gPokerKarty][0] = EOS;
		ObiektInfo[id][gZajety] = 0;
		ObiektInfo[id][objNapis] = CreateDynamic3DTextLabel(" ", 0xC2A2DAFF, ObiektInfo[id][objPozX], ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ], 10.0);
	}
	mysql_free_result( );
	//printf("Obiekty   - %d", id);
	return 1;
}
forward ZapiszObiekt(id);
public ZapiszObiekt(id)
{
	strdel(zapyt, 0, 1024);
	format(zapyt, sizeof(zapyt), "UPDATE `five_obiekty` SET `pozX` = '%f', `pozY` = '%f', `pozZ` = '%f', `rotX` = '%f', `rotY` = '%f', `rotZ` = '%f',`posX` = '%f', `posY` = '%f', `posZ` = '%f', `brama` = '%d', `sparowany` = '%d', `WLACZNIK` = '%d', `WARTOSC` = '%d', `objOwnerBrama` = '%d', `objTypOwneraBramy` = '%d', `objOwner` = '%d' WHERE `ID` = %d",
	ObiektInfo[id][objPozX],
	ObiektInfo[id][objPozY],
	ObiektInfo[id][objPozZ],
	ObiektInfo[id][objRotX],
	ObiektInfo[id][objRotY],
	ObiektInfo[id][objRotZ],
	ObiektInfo[id][objPosX],
	ObiektInfo[id][objPosY],
	ObiektInfo[id][objPosZ],
	ObiektInfo[id][objBrama],
	ObiektInfo[id][objSprarowanyUID],
	ObiektInfo[id][objWlacznik],
	ObiektInfo[id][objWartosc],
	ObiektInfo[id][objOwnerBrama],
	ObiektInfo[id][objTypOwneraBramy],
	ObiektInfo[id][objOwnerDz],
	id);
	mysql_query(zapyt);
	return 1;
}
forward DodajObiekt(model, Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz, vw, interior, playid);
public DodajObiekt(model, Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz, vw, interior, playid)
{
	if(NieruchomoscInfo[vw][nLiczbaMebli] == 0 && vw != 0 && model != 1958)
	{
	    dShowPlayerDialog( playid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Ten budynek nie ma {88b711}wystarczaj¹cej{DEDEDE} iloœci obiektów.", "Zamknij", "" );
        ClearAnimations(playid);
		return 0;
	}else{
		new id = GetFreeSQLUID("five_obiekty", "ID");
		format( zapyt, sizeof( zapyt ), "INSERT INTO `five_obiekty` (`ID`,`model`, `vw`, `interior`, `pozX`, `pozY`, `pozZ`, \
		`rotX`, `rotY`, `rotZ`, `CZAS`) VALUES (%d, %d, %d, %d, %f, %f, %f, %f, %f, %f, %d)",
		 id, model, vw, interior, x, y, z, rotx, roty, rotz,gettime()-CZAS_LETNI);
		mysql_query(zapyt);
		//id = mysql_insert_id();
		ObiektInfo[id][objUID] = id;
		ObiektInfo[id][objModel] = model;
		ObiektInfo[id][objvWorld] = vw;
		ObiektInfo[id][objInterior] = interior;
		ObiektInfo[id][objPozX] = x;
		ObiektInfo[id][objPozY] = y;
		ObiektInfo[id][objPozZ] = z;
		ObiektInfo[id][objPosX] = 0;
		ObiektInfo[id][objPosY] = 0;
		ObiektInfo[id][objPosZ] = 0;
		ObiektInfo[id][objBrama] = 0;
		ObiektInfo[id][objSprarowanyUID] = 0;
		ObiektInfo[id][objOwnerBrama] = 0;
		ObiektInfo[id][objTypOwneraBramy] = 0;
		ObiektInfo[id][objWlacznik] = 0;
		ObiektInfo[id][objWartosc] = 0;
		ObiektInfo[id][objRotX] = rotx;
		ObiektInfo[id][objRotY] = roty;
		ObiektInfo[id][objRotZ] = rotz;
		ObiektInfo[id][objSAMP] = CreateDynamicObject(ObiektInfo[id][objModel], ObiektInfo[id][objPozX],
		ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ], ObiektInfo[id][objRotX], ObiektInfo[id][objRotY],
		ObiektInfo[id][objRotZ], ObiektInfo[id][objvWorld], ObiektInfo[id][objInterior]);
		ObiektInfo[id][gPokerKarty][0] = EOS;
		for(new i = 0; i < 2048; i++)
		{
			if(NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] == 0)
		    {
				NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] = id;
				break;
		    }
		}
		for(new i = 0; i < 6; i++)
		{
			ObiektInfo[id][objPoker][i] = -1;
			ObiektInfo[id][gAktualniGracze][i] = -1;
			ObiektInfo[0][objPoker][i] = -1;
			ObiektInfo[0][gAktualniGracze][i] = -1;
		}
		ObiektInfo[id][gPokerObj] = EOS;
		ObiektInfo[id][objPokerDiler] = 0;
		ObiektInfo[id][gRundaPoker] = 0;
		obiektinedit[id] = true;
		NieruchomoscInfo[vw][nStworzoneObiekty]++;
		if(ObiektInfo[id][objModel] != 1958 && ObiektInfo[id][objModel] != 364)
		{
			NieruchomoscInfo[vw][nLiczbaMebli]--;
		}
		ObiektInfo[id][objNapis] = CreateDynamic3DTextLabel(" ", 0xC2A2DAFF, ObiektInfo[id][objPozX], ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ], 10.0);
		ZapiszNieruchomosc(vw);
		SetPVarInt(playid, "inedit", id);
		return id;
	}
}
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    new Float:oldX, Float:oldY, Float:oldZ,
		Float:oldRotX, Float:oldRotY, Float:oldRotZ;
	//new uid = GetPVarInt(playerid, "idobiktu");
	new id = SprawdzObiektUID(objectid);
	if(!IsValidDynamicObject(objectid)) return;
	MoveDynamicObject(objectid, x, y, z, 10.0, rx, ry, rz);
	GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
	GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
    ObiektInfo[id][objPozX] = oldX;
	ObiektInfo[id][objPozY] = oldY;
	ObiektInfo[id][objPozZ] = oldZ;
	ObiektInfo[id][objRotX] = oldRotX;
	ObiektInfo[id][objRotY] = oldRotY;
	ObiektInfo[id][objRotZ] = oldRotZ;
	if(response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
        ZapiszObiekt(id);
        obiektinedit[id] = false;
        DeletePVar(playerid,"idobiktu");
        DeletePVar(playerid,"inedit");
        TextDrawHideForPlayer(playerid, OBJ[playerid]);
        Edytors[playerid] = 0;

	}
}
public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
    new uids = SprawdzObiektUID(objectid);
	if(ObiektInfo[uids][objvWorld] == 0)
	{
		if(DaneGracza[playerid][gAdmGroup] == 4)
		{
			
		}
		else
		{
			CancelEdit(playerid);
			return 0;
		}
	}
	else
	{
		if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid) || GetPlayerVirtualWorld(playerid) == 0)
		{
			CancelEdit(playerid);
			return 0;
		}
	}
	if(obiektinedit[uids] == true)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz zaznczyæ tego {88b711}obiektu{DEDEDE} poniewa¿ ktoœ go w³aœnie edytuje.", "Zamknij", "");
	    return 0;
	}else{
	SetPVarInt(playerid, "inedit", uids);
	obiektinedit[uids] = true;
	if(DaneGracza[playerid][gEdytor] == 0)
    {
		EditDynamicObject(playerid, objectid);
		edycjaobiektow[playerid] = 0;
		Edytors[playerid] = 1;
	}else{
	    edycjaobiektow[playerid] = 1;
	    CancelEdit(playerid);
	    ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
	    ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
	    Edytors[playerid] = 1;
	}
    SetPVarInt(playerid, "idobiktu", uids);
    return 1;
    }
}
stock SkasujIntek(vw)
{
	for(new i = 0; i < 2048; i++)
	{
		if(NieruchomoscInfo[vw][nObiekty][i] != 0)
		{
			UsunObiekt(NieruchomoscInfo[vw][nObiekty][i]);
		}
	}
	if(NieruchomoscInfo[vw][nStworzoneObiekty] > 0)
	{
		SkasujIntek(vw);
	}
	return 1;
}
stock UnloadObject(vw)
{
	ForeachEx(id, 2048)
	{
		if(ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objSAMP] != 0)
		{
			DestroyDynamicObject(ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objSAMP]);
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objUID] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objSAMP] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objModel] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objvWorld] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objInterior] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPozX] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPozY] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPozZ] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPosX] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPosY] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPosZ] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objBrama] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objSprarowanyUID] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objOwnerBrama] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objTypOwneraBramy] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objWlacznik] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objWartosc] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objRotX] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objRotY] = 0;
			ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objRotZ] = 0;
			NieruchomoscInfo[vw][nObiekty][id] = 0;
			for(new i = 0; i < 6; i++)
			{
				ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][objPoker][i] = -1;
				ObiektInfo[NieruchomoscInfo[vw][nObiekty][id]][gAktualniGracze][i] = -1;
				ObiektInfo[0][objPoker][i] = -1;
				ObiektInfo[0][gAktualniGracze][i] = -1;
			}
		}
	}
	NieruchomoscInfo[vw][nStworzoneObiekty] = 0;
	return 1;
}
stock LoadObject(vw)
{
	new sql[ 1000 ], id = false;
	mysql_query( "SELECT * FROM `five_obiekty`" );
	mysql_store_result( );
	while( mysql_fetch_row( sql ) )
	{
	    sscanf( sql, "p<|>i", id );
	    sscanf( sql, "p<|>iiii\
	    fffffffffdddddd",
	    ObiektInfo[ id ][ objUID ],
	    ObiektInfo[ id ][ objModel ],
	    ObiektInfo[ id ][ objvWorld ],
	    ObiektInfo[ id ][ objInterior ],
	    ObiektInfo[ id ][ objPozX ],
	    ObiektInfo[ id ][ objPozY ],
	    ObiektInfo[ id ][ objPozZ ],
	    ObiektInfo[ id ][ objRotX ],
	    ObiektInfo[ id ][ objRotY ],
	    ObiektInfo[ id ][ objRotZ ],
	    ObiektInfo[id][objPosX],
		ObiektInfo[id][objPosY],
		ObiektInfo[id][objPosZ],
		ObiektInfo[id][objBrama],
		ObiektInfo[id][objSprarowanyUID],
		ObiektInfo[id][objWlacznik],
		ObiektInfo[id][objWartosc],
		ObiektInfo[id][objOwnerBrama],
		ObiektInfo[id][objTypOwneraBramy]
	    );
	    if(ObiektInfo[id][objvWorld] == vw)
	    {
		    ObiektInfo[ id ][ objSAMP ] = CreateDynamicObject( ObiektInfo[ id ][ objModel ], ObiektInfo[ id ][ objPozX ],
		    ObiektInfo[ id ][ objPozY ], ObiektInfo[ id ][ objPozZ ], ObiektInfo[ id ][ objRotX ], ObiektInfo[ id ][ objRotY ],
		    ObiektInfo[ id ][ objRotZ ], ObiektInfo[ id ][ objvWorld ], ObiektInfo[ id ][ objInterior ] );
		    ObiektInfo[id][objOtw] = 0;
		    obiektinedit[id] = false;
			for(new i = 0; i < 2048; i++)
		    {
				if(NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] == 0)
				{
					NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] = ObiektInfo[id][objUID];
					break;
				}
		    }
			for(new i = 0; i < 6; i++)
			{
				ObiektInfo[id][objPoker][i] = -1;
				ObiektInfo[id][gAktualniGracze][i] = -1;
				ObiektInfo[0][objPoker][i] = -1;
				ObiektInfo[0][gAktualniGracze][i] = -1;
			}
		    reload++;
		}
	}
	NieruchomoscInfo[vw][nStworzoneObiekty] = reload;
	mysql_free_result( );
	LoadTexturs(vw);
	//printf("Obiekty   - %d", id);
	return 1;
}
/*CMD:amsel( playerid, params[ ] )
{
	//printf("U¿yta komenda amsel");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nMapa] == 1)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
			return 0;
		}
		if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
		{
			new uids = GetPVarInt(playerid, "inedit");
			ZapiszObiekt(uids);
			CancelEdit(playerid);
			OnPlayerText(playerid, "-stopani");
			obiektinedit[uids] = false;
			DeletePVar(playerid,"idobiktu");
			DeletePVar(playerid,"inedit");
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			Edytors[playerid] = 0;
		}
		new uid_budynku = GetPlayerVirtualWorld(playerid);
		new uid;
		if(sscanf(params, "d", uid))
		{
			new uids = 0, Float:radius = 0.5;
			for(new i = 0; i < 200; i++)
			{
				if(uids == 0)
				{
					ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
					{
						if(Dystans(radius, playerid, ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozZ]) && GetPlayerVirtualWorld(playerid) == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld])
						{
							uids = NieruchomoscInfo[uid_budynku][nObiekty][h];
							break;
						}
					}
					radius+=0.5;
				}
				else
				{
					if(obiektinedit[uids] == true)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten obiekt {88b711}w³aœnie{DEDEDE} ju¿ ktoœ edytuje.", "Zamknij", "");
						return 0;
					}
					else
					{
						SetPVarInt(playerid, "inedit", uids);
						obiektinedit[uids] = true;
						if(DaneGracza[playerid][gEdytor] == 0)
						{
							EditDynamicObject(playerid, ObiektInfo[uids][objSAMP]);
							edycjaobiektow[playerid] = 0;
							Edytors[playerid] = 1;
							}else{
							edycjaobiektow[playerid] = 1;
							CancelEdit(playerid);
							ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
							ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
							Edytors[playerid] = 1;
						}
						SetPVarInt(playerid, "idobiktu", ObiektInfo[uids][objSAMP]);
					}
					break;
				}
			}
			if(uids == 0)
			{
				GameTextForPlayer(playerid, "~r~Brak obiektow w poblizu.", 3000, 5);
			}
			return 1;
		}
		else
		{
			new uids = 0, Float:radius = 0.5;
			for(new i = 0; i < 100; i++)
			{
				if(uids == 0)
				{
					ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
					{
						if(Dystans(radius, playerid, ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozZ]) && GetPlayerVirtualWorld(playerid) == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld] && ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objModel] == uid)
						{
							uids = NieruchomoscInfo[uid_budynku][nObiekty][h];
							break;
						}
					}
					radius+=0.5;
					}else{
					if(obiektinedit[uids] == true)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten obiekt {88b711}w³aœnie{DEDEDE} ju¿ ktoœ edytuje.", "Zamknij", "");
						return 0;
						}else{
						SetPVarInt(playerid, "inedit", uids);
						obiektinedit[uids] = true;
						if(DaneGracza[playerid][gEdytor] == 0)
						{
							EditDynamicObject(playerid, ObiektInfo[uids][objSAMP]);
							edycjaobiektow[playerid] = 0;
							Edytors[playerid] = 1;
							}else{
							edycjaobiektow[playerid] = 1;
							CancelEdit(playerid);
							ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
							ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
							Edytors[playerid] = 1;
						}
						SetPVarInt(playerid, "idobiktu", ObiektInfo[uids][objSAMP]);
					}
					break;
				}
			}
			if(uids == 0)
			{
				GameTextForPlayer(playerid, "~r~Brak obiektow w poblizu.", 3000, 5);
			}
		}
	}
	return 1;
}*/
/*CMD:amsave( playerid, params[ ] )
{
	//printf("U¿yta komenda amsave");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
		{
			new uids = GetPVarInt(playerid, "inedit");
			ZapiszObiekt(uids);
			CancelEdit(playerid);
			OnPlayerText(playerid, "-stopani");
			obiektinedit[uids] = false;
			DeletePVar(playerid,"idobiktu");
			DeletePVar(playerid,"inedit");
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			Edytors[playerid] = 0;
		}
	}
	return 1;
}*/
/*CMD:ams( playerid, params[ ] )
{
	//printf("U¿yta komenda ams");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
		{
			new uids = GetPVarInt(playerid, "inedit");
			ZapiszObiekt(uids);
			CancelEdit(playerid);
			OnPlayerText(playerid, "-stopani");
			obiektinedit[uids] = false;
			DeletePVar(playerid,"idobiktu");
			DeletePVar(playerid,"inedit");
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			Edytors[playerid] = 0;
		}
		SelectObject(playerid);
		SendClientMessage(playerid, SZARY, "Kliknij w obiekt, który chcesz edytowaæ.");
	}
	return 1;
}*/
CMD:msave( playerid, params[ ] )
{
	//printf("U¿yta komenda msave");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    /*if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid) || GetPlayerVirtualWorld(playerid) == 0)
	{
	    return 0;
	}*/
    if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
	{
		new uids = GetPVarInt(playerid, "inedit");
	    ZapiszObiekt(uids);
		CancelEdit(playerid);
		OnPlayerText(playerid, "-stopani");
        obiektinedit[uids] = false;
        DeletePVar(playerid,"idobiktu");
        DeletePVar(playerid,"inedit");
        TextDrawHideForPlayer(playerid, OBJ[playerid]);
        Edytors[playerid] = 0;
	}
	return 1;
}
CMD:ms( playerid, params[ ] )
{
	//printf("U¿yta komenda ms");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
    if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
	{
		new uids = GetPVarInt(playerid, "inedit");
	    ZapiszObiekt(uids);
		CancelEdit(playerid);
		OnPlayerText(playerid, "-stopani");
        obiektinedit[uids] = false;
        DeletePVar(playerid,"idobiktu");
        DeletePVar(playerid,"inedit");
        TextDrawHideForPlayer(playerid, OBJ[playerid]);///348
        Edytors[playerid] = 0;
	}
    SelectObject(playerid);
	CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
	TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
	TextDrawSetString(TextNaDrzwi[playerid], "Kliknij w obiekt, który chcesz edytowaæ.");
	TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
	return 1;
}
