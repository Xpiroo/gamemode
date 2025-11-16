AntiDeAMX();
enum ginfo
{
	gUID,
	gNazwa[50],
	gTyp,
	gOwner,
	gKolorCzatu[50],
	gKolorNicku[50],
	gKolorTerenu[50],
	gSaldo,
	gOwnerUID
};
new GrupaInfo[MAX_GROUP][ginfo];
CMD:d(playerid, cmdtext[])
{
	//printf("U¿yta komenda d");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_DEPRTAMENTIWY))
	{
		GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie dzialalnosci.", 3000, 5);
		return 0;
	}
	strdel(tekst_globals, 0, 2048);
	if(sscanf(cmdtext, "s[256]", tekst_globals))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie departamentowym{DEDEDE} wpisz: {88b711}/d [treœæ]", "Zamknij", "");
		return 1;
	}
	tekst_globals[0] = toupper(tekst_globals[0]);
	new trws[256];
	new id = DaneGracza[playerid][gSluzba];
	format(trws, sizeof(trws), "%s %s (radio): %s", GrupaInfo[id][gNazwa], ZmianaNicku(playerid), tekst_globals);
	ForeachEx(i, IloscGraczy)
	{
		if(GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc1]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc1]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc1]][gTyp] == DZIALALNOSC_RZADOWA ||
		GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc2]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc2]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc2]][gTyp] == DZIALALNOSC_RZADOWA ||
		GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc3]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc3]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc3]][gTyp] == DZIALALNOSC_RZADOWA ||
		GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc4]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc4]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc4]][gTyp] == DZIALALNOSC_RZADOWA ||
		GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc5]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc5]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc5]][gTyp] == DZIALALNOSC_RZADOWA ||
		GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc6]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc6]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[KtoJestOnline[i]][gDzialalnosc6]][gTyp] == DZIALALNOSC_RZADOWA)
		{
			DGCZAT(KtoJestOnline[i], "B4FF00", 0xB4FF00FF, trws);
		}
	}	
	new str[256];
	format(str, sizeof(str), "%s (s³uchawka): %s", ZmianaNicku(playerid), tekst_globals);
	Sluchawka(playerid, str, 10);
	return 1;
}
CMD:r(playerid, cmdtext[])
{
	//printf("U¿yta komenda r");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    new typ, tekst_globalsa[256], dz, upr, kl[20];
	strdel(tekst_globalsa, 0, 256);
	if(sscanf(cmdtext, "ds[256]", typ, tekst_globalsa))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie IC grupy{DEDEDE} wpisz: {88b711}/r [slot] [treœæ]", "Zamknij", "");
		return 1;
	}
	if(typ <= 0 || typ >=7) return 1;
	switch(typ)
    {
		case 1: 
		{
			dz = DaneGracza[playerid][gDzialalnosc1];
			upr = DaneGracza[playerid][gUprawnienia1][8];
			format(kl, sizeof(kl), "%s", DaneGracza[playerid][gKolorChatu1]);
		}
		case 2: 
		{
			upr = DaneGracza[playerid][gUprawnienia2][8];
			dz = DaneGracza[playerid][gDzialalnosc2];
			format(kl, sizeof(kl), "%s", DaneGracza[playerid][gKolorChatu2]);
		}
		case 3: 
		{
			upr = DaneGracza[playerid][gUprawnienia3][8];
			dz = DaneGracza[playerid][gDzialalnosc3];
			format(kl, sizeof(kl), "%s", DaneGracza[playerid][gKolorChatu3]);
		}
		case 4: 
		{
			upr = DaneGracza[playerid][gUprawnienia4][8];
			dz = DaneGracza[playerid][gDzialalnosc4];
			format(kl, sizeof(kl), "%s", DaneGracza[playerid][gKolorChatu4]);
		}
		case 5: 
		{
			upr = DaneGracza[playerid][gUprawnienia5][8];
			dz = DaneGracza[playerid][gDzialalnosc5];
			format(kl, sizeof(kl), "%s", DaneGracza[playerid][gKolorChatu5]);
		}
		case 6: 
		{
			upr = DaneGracza[playerid][gUprawnienia6][8];
			dz = DaneGracza[playerid][gDzialalnosc6];
			format(kl, sizeof(kl), "%s", DaneGracza[playerid][gKolorChatu6]);
		}
	}
	if(upr == 1)
	{
		tekst_globalsa[0] = toupper(tekst_globalsa[0]);
		new trws[256];
		format(trws, sizeof(trws), "%s (radio): %s", ZmianaNicku(playerid), tekst_globalsa);
		//Transakcja(T_DGIC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, dz, -1, -1, tekst_globalsa, gettime()-CZAS_LETNI);
		ForeachEx(i, IloscGraczy)
		{
			if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == dz ||
			DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == dz ||
			DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == dz ||
			DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == dz ||
			DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == dz ||
			DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == dz)
			{
				DGCZAT(KtoJestOnline[i], kl, 0xB4FF00FF, trws);
			}
		}
		new str[256];
		format(str, sizeof(str), "%s (s³uchawka): %s", ZmianaNicku(playerid), tekst_globalsa);
		Sluchawka(playerid, str, 10);
	}else{
	GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
	}
	return 1;
}
CMD:dg(playerid, cmdtext[])
{
	//printf("U¿yta komenda dg");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    //ZaladujDzialalnoscis();
    new	comm1[32], comm2[128];
	if(sscanf(cmdtext, "s[32]S()[128]", comm1, comm2))
	{
	    new	dzg_lista[350], find;
		if(DaneGracza[playerid][gDzialalnosc1] != 0)
		{
		    new uid = DaneGracza[playerid][gDzialalnosc1];
			find = 1;
			format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
		}
		if(DaneGracza[playerid][gDzialalnosc2] != 0)
		{
			new uid = DaneGracza[playerid][gDzialalnosc2];
			find = 2;
			format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
		}
		if(DaneGracza[playerid][gDzialalnosc3] != 0)
		{
			new uid = DaneGracza[playerid][gDzialalnosc3];
			find = 3;
			format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
		}
		if(DaneGracza[playerid][gDzialalnosc4] != 0)
		{
			new uid = DaneGracza[playerid][gDzialalnosc4];
			find = 4;
			if(GraczPremium(playerid)) format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
			else format(dzg_lista, sizeof(dzg_lista), "%s\n{000000}%d\t%s (UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
		}
		if(DaneGracza[playerid][gDzialalnosc5] != 0)
		{
			new uid = DaneGracza[playerid][gDzialalnosc5];
			find = 5;
			if(GraczPremium(playerid)) format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
			else format(dzg_lista, sizeof(dzg_lista), "%s\n{000000}%d\t%s (UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
		}
		if(DaneGracza[playerid][gDzialalnosc6] != 0)
		{
			new uid = DaneGracza[playerid][gDzialalnosc6];
			find = 6;
			if(GraczPremium(playerid)) format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
			else format(dzg_lista, sizeof(dzg_lista), "%s\n{000000}%d\t%s (UID: %d)", dzg_lista, find, GrupaInfo[uid][gNazwa], GrupaInfo[uid][gUID]);
		}
		if(find > 0) dShowPlayerDialog(playerid, DIALOG_DZIALALNOSCI, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœci gospodarcze{88b711}:", dzg_lista, "Wiêcej", "Wyjdz");
		else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœci gospodarcze{88b711}:", "{DEDEDE}Nie posiadasz {88b711}dzia³alnoœci{DEDEDE} gospodarczych.", "Wybierz", "Zamknij");
	}
	else if(!strcmp(comm1,"1",true))
	{
		if(DaneGracza[playerid][gDzialalnosc1] != 0)
		{
			if(BlokadaOOC(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				return 0;
			}
			new typ[124], text[256];
			if(sscanf(comm2, "s[124]", typ))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie grupowym{DEDEDE} wpisz: {88b711}/dg 1 [treœæ]", "Zamknij", "");
				return 1;
			}
			if(!strcmp(typ,"v",true))
			{
				new	list_vehicles[512], find = 0;
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
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Wiêcej");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia³alnoœæ {88b711}nie{DEDEDE} posiada ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}
			else if(!strcmp(typ,"info",true))
			{
				new stri[256], strin[256];
				new uid = DaneGracza[playerid][gDzialalnosc1];
				format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW³aœciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia³alnoœci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], 1, GrupaInfo[uid][gKolorCzatu]);
				format(strin, sizeof(strin), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			}
			else if(!strcmp(typ,"m",true))
			{
				Magazyn(playerid, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœæ {88b711}» {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc1], "Zamknij", "");
			}
			else if(!strcmp(typ,"p",true))
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
				if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracowników na s³u¿bie.", "Zamknij", "");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Lista pracowników online{88b711}:", str, "Zamknij", "");
				return 1;
			}
			else if(DaneGracza[playerid][gUprawnienia1][7] == 1)
			{
				typ[0] = toupper(typ[0]);
				format(text, sizeof(text), "[1]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc1]][gNazwa], playerid,ZmianaNicku(playerid),typ);
				//Transakcja(T_DGOOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, DaneGracza[playerid][gDzialalnosc1], -1, -1, typ, gettime()-CZAS_LETNI);
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc1] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc1] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc1] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc1] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc1] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc1])
					{
						DGCZAT(KtoJestOnline[i], DaneGracza[playerid][gKolorChatu1], 0xB4FF00FF, text);
					}
				}
			}else{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"2",true))
	{
		if(DaneGracza[playerid][gDzialalnosc2] != 0)
		{
			if(BlokadaOOC(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				return 0;
			}
			new typ[124], text[256];
			if(sscanf(comm2, "s[124]", typ))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie grupowym{DEDEDE} wpisz: {88b711}/dg 2 [treœæ]", "Zamknij", "");
				return 1;
			}
			if(!strcmp(typ,"v",true))
			{
				new	list_vehicles[512], find = 0;
				ForeachEx(i, MAX_VEH)
				{
					if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc2])
					{
						if(PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						}
						else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Wiêcej");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia³alnoœæ {88b711}nie{DEDEDE} posiada ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}
			else if(!strcmp(typ,"info",true))
			{
				new stri[256], strin[256];
				new uid = DaneGracza[playerid][gDzialalnosc2];
				format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW³aœciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia³alnoœci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], 2, GrupaInfo[uid][gKolorCzatu]);
				format(strin, sizeof(strin), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			}
			else if(!strcmp(typ,"m",true))
			{
				Magazyn(playerid, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœæ {88b711}» {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc2], "Zamknij", "");
			}
			else if(!strcmp(typ,"p",true))
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
				if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracowników na s³u¿bie.", "Zamknij", "");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Lista pracowników online{88b711}:", str, "Zamknij", "");
				return 1;
			}
			else if(DaneGracza[playerid][gUprawnienia2][7] == 1)
			{
				typ[0] = toupper(typ[0]);
				format(text, sizeof(text), "[2]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc2]][gNazwa], playerid,ZmianaNicku(playerid),typ);
				//Transakcja(T_DGOOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, DaneGracza[playerid][gDzialalnosc2], -1, -1, typ, gettime()-CZAS_LETNI);
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc2] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc2] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc2] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc2] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc2] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc2])
					{
						DGCZAT(KtoJestOnline[i], DaneGracza[playerid][gKolorChatu2], 0xB4FF00FF, text);
					}
				}
			}else{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"3",true))
	{
		if(DaneGracza[playerid][gDzialalnosc3] != 0)
		{
			if(BlokadaOOC(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				return 0;
			}
			new typ[124], text[256];
			if(sscanf(comm2, "s[124]", typ))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie grupowym{DEDEDE} wpisz: {88b711}/dg 3 [treœæ]", "Zamknij", "");
				return 1;
			}
			if(!strcmp(typ,"v",true))
			{
				new	list_vehicles[512], find = 0;
				ForeachEx(i, MAX_VEH)
				{
					if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc3])
					{
						if(PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						}
						else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Wiêcej");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia³alnoœæ {88b711}nie{DEDEDE} posiada ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}
			else if(!strcmp(typ,"info",true))
			{
				new stri[256], strin[256];
				new uid = DaneGracza[playerid][gDzialalnosc3];
				format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW³aœciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia³alnoœci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], 3, GrupaInfo[uid][gKolorCzatu]);
				format(strin, sizeof(strin), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			}
			else if(!strcmp(typ,"m",true))
			{
				Magazyn(playerid, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœæ {88b711}» {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc3], "Zamknij", "");
			}
			else if(!strcmp(typ,"p",true))
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
				if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracowników na s³u¿bie.", "Zamknij", "");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Lista pracowników online{88b711}:", str, "Zamknij", "");
				return 1;
			}
			else if(DaneGracza[playerid][gUprawnienia3][7] == 1)
			{
				typ[0] = toupper(typ[0]);
				format(text, sizeof(text), "[3]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gNazwa], playerid,ZmianaNicku(playerid),typ);
				//Transakcja(T_DGOOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, DaneGracza[playerid][gDzialalnosc3], -1, -1, typ, gettime()-CZAS_LETNI);
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc3] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc3] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc3] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc3] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc3] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc3])
					{
						//format(text, sizeof(text), "[3]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						DGCZAT(KtoJestOnline[i], DaneGracza[playerid][gKolorChatu3], 0xB4FF00FF, text);
					}
				}
			}else{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"4",true))
	{
		if(DaneGracza[playerid][gDzialalnosc4] != 0 && GraczPremium(playerid))
		{
			if(BlokadaOOC(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				return 0;
			}
			new typ[124], text[256];
			if(sscanf(comm2, "s[124]", typ))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie grupowym{DEDEDE} wpisz: {88b711}/dg 4 [treœæ]", "Zamknij", "");
				return 1;
			}
			if(!strcmp(typ,"v",true))
			{
				new	list_vehicles[512], find = 0;
				ForeachEx(i, MAX_VEH)
				{
					if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc4])
					{
						if(PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						}
						else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Wiêcej");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia³alnoœæ {88b711}nie{DEDEDE} posiada ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}
			else if(!strcmp(typ,"info",true))
			{
				new stri[256], strin[256];
				new uid = DaneGracza[playerid][gDzialalnosc4];
				format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW³aœciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia³alnoœci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], 4, GrupaInfo[uid][gKolorCzatu]);
				format(strin, sizeof(strin), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			}
			else if(!strcmp(typ,"m",true))
			{
				Magazyn(playerid, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœæ {88b711}» {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc4], "Zamknij", "");
			}
			else if(!strcmp(typ,"p",true))
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
				if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracowników na s³u¿bie.", "Zamknij", "");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Lista pracowników online{88b711}:", str, "Zamknij", "");
				return 1;
			}
			else if(DaneGracza[playerid][gUprawnienia4][7] == 1)
			{
				typ[0] = toupper(typ[0]);
				format(text, sizeof(text), "[4]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						
				//Transakcja(T_DGOOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, DaneGracza[playerid][gDzialalnosc4], -1, -1, typ, gettime()-CZAS_LETNI);
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc4] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc4] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc4] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc4] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc4] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc4])
					{
						//format(text, sizeof(text), "[4]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						DGCZAT(KtoJestOnline[i], DaneGracza[playerid][gKolorChatu4], 0xB4FF00FF, text);
					}
				}
			}else{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"5",true))
	{
		if(DaneGracza[playerid][gDzialalnosc5] != 0 && GraczPremium(playerid))
		{
			if(BlokadaOOC(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				return 0;
			}
			new typ[124], text[256];
			if(sscanf(comm2, "s[124]", typ))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie grupowym{DEDEDE} wpisz: {88b711}/dg 5 [treœæ]", "Zamknij", "");
				return 1;
			}
			if(!strcmp(typ,"v",true))
			{
				new	list_vehicles[512], find = 0;
				ForeachEx(i, MAX_VEH)
				{
					if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc5])
					{
						if(PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						}
						else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Wiêcej");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia³alnoœæ {88b711}nie{DEDEDE} posiada ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}
			else if(!strcmp(typ,"info",true))
			{
				new stri[256], strin[256];
				new uid = DaneGracza[playerid][gDzialalnosc5];
				format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW³aœciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia³alnoœci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], 5, GrupaInfo[uid][gKolorCzatu]);
				format(strin, sizeof(strin), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			}
			else if(!strcmp(typ,"m",true))
			{
				Magazyn(playerid, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœæ {88b711}» {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc5], "Zamknij", "");
			}
			else if(!strcmp(typ,"p",true))
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
				if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracowników na s³u¿bie.", "Zamknij", "");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Lista pracowników online{88b711}:", str, "Zamknij", "");
				return 1;
			}
			else if(DaneGracza[playerid][gUprawnienia5][7] == 1)
			{
				typ[0] = toupper(typ[0]);
				format(text, sizeof(text), "[5]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						
				//Transakcja(T_DGOOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, DaneGracza[playerid][gDzialalnosc5], -1, -1, typ, gettime()-CZAS_LETNI);
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc5] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc5] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc5] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc5] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc5] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc5])
					{
						//format(text, sizeof(text), "[5]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						DGCZAT(KtoJestOnline[i], DaneGracza[playerid][gKolorChatu5], 0xB4FF00FF, text);
					}
				}
			}else{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"6",true))
	{
		if(DaneGracza[playerid][gDzialalnosc6] != 0 && GraczPremium(playerid))
		{
			if(BlokadaOOC(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				return 0;
			}
			new typ[124], text[256];
			if(sscanf(comm2, "s[124]", typ))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na {88b711}czacie grupowym{DEDEDE} wpisz: {88b711}/dg 6 [treœæ]", "Zamknij", "");
				return 1;
			}
			if(!strcmp(typ,"v",true))
			{
				new	list_vehicles[512], find = 0;
				ForeachEx(i, MAX_VEH)
				{
					if(PojazdInfo[i][pOwnerPostac] == 0  && PojazdInfo[i][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc6])
					{
						if(PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{88b711}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						}
						else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t{DEDEDE}%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
						find++;
					}
				}
				if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Wiêcej");
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta dzia³alnoœæ {88b711}nie{DEDEDE} posiada ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}
			else if(!strcmp(typ,"info",true))
			{
				new stri[256], strin[256];
				new uid = DaneGracza[playerid][gDzialalnosc6];
				format(stri, sizeof(stri), "{DEDEDE}UID:\t\t\t\t%d\nW³aœciciel:\t\t\t%s\nStan konta:\t\t\t%d$\nTyp dzia³alnoœci:\t\t%s\nSlot:\t\t\t\t%d\n{DEDEDE}\n1\t{%s}Kolor czatu OOC",GrupaInfo[uid][gUID], NickGraczaGlobalSQL(GrupaInfo[uid][gOwner]), GrupaInfo[uid][gSaldo], NazwyDzialalnosci[GrupaInfo[uid][gTyp]], 6, GrupaInfo[uid][gKolorCzatu]);
				format(strin, sizeof(strin), "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}%s{88b711}:",GrupaInfo[uid][gNazwa]);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, strin, stri, "Zamknij", "");
			}
			else if(!strcmp(typ,"m",true))
			{
				Magazyn(playerid, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœæ {88b711}» {FFFFFF}Magazyn{88b711}:", TYP_MAGAZYN, DaneGracza[playerid][gDzialalnosc6], "Zamknij", "");
			}
			else if(!strcmp(typ,"p",true))
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
				if(temp == 0) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}pracowników na s³u¿bie.", "Zamknij", "");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Lista pracowników online{88b711}:", str, "Zamknij", "");
				return 1;
			}
			else if(DaneGracza[playerid][gUprawnienia6][7] == 1)
			{
				typ[0] = toupper(typ[0]);
				format(text, sizeof(text), "[6]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						
				//Transakcja(T_DGOOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, DaneGracza[playerid][gDzialalnosc6], -1, -1, typ, gettime()-CZAS_LETNI);
				ForeachEx(i, IloscGraczy)
				{
					if(DaneGracza[KtoJestOnline[i]][gDzialalnosc1] == DaneGracza[playerid][gDzialalnosc6] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc2] == DaneGracza[playerid][gDzialalnosc6] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc3] == DaneGracza[playerid][gDzialalnosc6] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc4] == DaneGracza[playerid][gDzialalnosc6] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc5] == DaneGracza[playerid][gDzialalnosc6] ||
					DaneGracza[KtoJestOnline[i]][gDzialalnosc6] == DaneGracza[playerid][gDzialalnosc6])
					{
					   // format(text, sizeof(text), "[6]%s (( [%d] %s: %s ))", GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gNazwa], playerid,ZmianaNicku(playerid),typ);
						DGCZAT(KtoJestOnline[i], DaneGracza[playerid][gKolorChatu6], 0xB4FF00FF, text);
					}
				}
			}else{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do korzystania z tego kanalu.", 3000, 5);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"wypros",true))
	{
	    new typ, war1;
		if(sscanf(comm2, "dd", typ, war1))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}wyprosiæ{DEDEDE} gracza z {88b711}dzia³alnoœci{DEDEDE} wpisz: {88b711}/dg wypros [Dzia³alnoœci 1-6] [Id Gracza]", "Zamknij", "");
			return 1;
		}
		if(typ == 1 && DaneGracza[playerid][gUprawnienia1][6] == 1 || typ == 1 && DaneGracza[playerid][gUprawnienia1][19] == 1)
		{
	       	WywalzDZ(playerid, war1, DaneGracza[playerid][gDzialalnosc1]);
		}
		else if(typ == 2 && DaneGracza[playerid][gUprawnienia2][6] == 1 || typ == 2 && DaneGracza[playerid][gUprawnienia2][19] == 1)
		{
	        WywalzDZ(playerid, war1, DaneGracza[playerid][gDzialalnosc2]);
		}
		else if(typ == 3 && DaneGracza[playerid][gUprawnienia3][6] == 1 || typ == 3 && DaneGracza[playerid][gUprawnienia3][19] == 1)
		{
	        WywalzDZ(playerid, war1, DaneGracza[playerid][gDzialalnosc3]);
		}
		else if(typ == 4 && DaneGracza[playerid][gUprawnienia4][6] == 1 || typ == 4 && DaneGracza[playerid][gUprawnienia4][19] == 1)
		{
	        WywalzDZ(playerid, war1, DaneGracza[playerid][gDzialalnosc4]);
		}
		else if(typ == 5 && DaneGracza[playerid][gUprawnienia5][6] == 1 || typ == 5 && DaneGracza[playerid][gUprawnienia5][19] == 1)
		{
	        WywalzDZ(playerid, war1, DaneGracza[playerid][gDzialalnosc5]);
		}
		else if(typ == 6 && DaneGracza[playerid][gUprawnienia6][6] == 1 || typ == 6 && DaneGracza[playerid][gUprawnienia6][19] == 1)
		{
	   	    WywalzDZ(playerid, war1, DaneGracza[playerid][gDzialalnosc6]);
		}
		return 1;
	}
	else if(!strcmp(comm1,"zapros",true))
	{
	    new typ, war1;
		if(sscanf(comm2, "dd", typ, war1))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}zaprosiæ{DEDEDE} gracza do {88b711}dzia³alnoœci{DEDEDE} wpisz: {88b711}/dg zapros [Dzia³alnoœci 1-6] [Id Gracza]", "Zamknij", "");
			return 1;
		}
		if(!PlayerObokPlayera(playerid, war1, 5))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz zaprosiæ {88b711}nie{DEDEDE} znajduje siê obok ciebie.", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[war1][gKONTO_W_BANKU] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz zaprosiæ {88b711}nie{DEDEDE} posiada konta w banku.", "Zamknij", "");
			return 1;
		}
		if(playerid != war1 && IsPlayerConnected(war1))
		{
			if(typ == 1 && DaneGracza[playerid][gUprawnienia1][6] == 1 || typ == 1 && DaneGracza[playerid][gUprawnienia1][19] == 1)
			{
	          	SprawdzDostepnoscDzialalnosci(playerid, war1, DaneGracza[playerid][gDzialalnosc1]);
			}
			else if(typ == 2 && DaneGracza[playerid][gUprawnienia2][6] == 1 || typ == 2 && DaneGracza[playerid][gUprawnienia2][19] == 1)
			{
	            SprawdzDostepnoscDzialalnosci(playerid, war1, DaneGracza[playerid][gDzialalnosc2]);
			}
			else if(typ == 3 && DaneGracza[playerid][gUprawnienia3][6] == 1 || typ == 3 && DaneGracza[playerid][gUprawnienia3][19] == 1)
			{
	            SprawdzDostepnoscDzialalnosci(playerid, war1, DaneGracza[playerid][gDzialalnosc3]);
			}
			else if(typ == 4 && DaneGracza[playerid][gUprawnienia4][6] == 1 && GraczPremium(playerid) || typ == 4 && DaneGracza[playerid][gUprawnienia4][19] == 1 && GraczPremium(playerid))
			{
	            SprawdzDostepnoscDzialalnosci(playerid, war1, DaneGracza[playerid][gDzialalnosc4]);
			}
			else if(typ == 5 && DaneGracza[playerid][gUprawnienia5][6] == 1 && GraczPremium(playerid) || typ == 5 && DaneGracza[playerid][gUprawnienia5][19] == 1 && GraczPremium(playerid))
			{
	            SprawdzDostepnoscDzialalnosci(playerid, war1, DaneGracza[playerid][gDzialalnosc5]);
			}
			else if(typ == 6 && DaneGracza[playerid][gUprawnienia6][6] == 1 && GraczPremium(playerid) || typ == 6 && DaneGracza[playerid][gUprawnienia6][19] == 1 && GraczPremium(playerid))
			{
	    	    SprawdzDostepnoscDzialalnosci(playerid, war1, DaneGracza[playerid][gDzialalnosc6]);
			}
		}
		return 1;
	}
	return 1;
}
forward ZaladujDzialalnoscisPracownika(id, playerid);
public ZaladujDzialalnoscisPracownika(id, playerid)
{
	new result[450], iz = 0;
	format(zapyt, sizeof(zapyt), "SELECT `ID`, `NAZWA`, `TYP`, `GUID_OWNERA`, `KOLOR_CZATU`, `UID_OWNERA`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID` = %d", id);
	mysql_check();
	mysql_query2(zapyt);
	mysql_store_result();

	while(mysql_fetch_row_format(result, "|") == 1)
	{
		new uid;
		sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>ds[50]dds[20]ds[50]", GrupaInfo[uid][gUID],
		GrupaInfo[uid][gNazwa],
		GrupaInfo[uid][gTyp],
		GrupaInfo[uid][gOwner],
		GrupaInfo[uid][gKolorCzatu],
		GrupaInfo[uid][gOwnerUID],
		GrupaInfo[uid][gKolorNicku]);
		format(GrupaInfo[uid][gKolorTerenu], 50, "0x%sAA", GrupaInfo[uid][gKolorCzatu]);
		if(GrupaInfo[uid][gTyp] == DZIALALNOSC_GANGI)
		{
			ForeachEx(i, MAX_ZON)
			{
				if(Lokacja[i][gOwner] != 0)
				{
					GangZoneShowForPlayer(playerid, Lokacja[i][gID], HexToInt(GrupaInfo[Lokacja[i][gOwner]][gKolorTerenu]));
				}
				else
				{
					GangZoneShowForPlayer(playerid, Lokacja[i][gID], 0x88b711AA);
				}
			}
		}
		iz++;
	}
	mysql_free_result();
	//printf("Dzialalnosci     - %d", iz);
}
forward ZaladujDzialalnoscis();
public ZaladujDzialalnoscis()
{
	new result[450], iz = 0;
	format(zapyt, sizeof(zapyt), "SELECT `ID`, `NAZWA`, `TYP`, `GUID_OWNERA`, `KOLOR_CZATU`, `SALDO`, `UID_OWNERA`, `KOLOR_NICKU` FROM `five_dzialalnosci`");
	mysql_check();
	mysql_query2(zapyt);
	mysql_store_result();

	while(mysql_fetch_row_format(result, "|") == 1)
	{
		new uid;
		sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>ds[50]dds[20]dds[50]", GrupaInfo[uid][gUID],
		GrupaInfo[uid][gNazwa],
		GrupaInfo[uid][gTyp],
		GrupaInfo[uid][gOwner],
		GrupaInfo[uid][gKolorCzatu],
		GrupaInfo[uid][gSaldo],
		GrupaInfo[uid][gOwnerUID],
		GrupaInfo[uid][gKolorNicku]);
		format(GrupaInfo[uid][gKolorTerenu], 50, "0x%sAA", GrupaInfo[uid][gKolorCzatu]);
		iz++;
	}
	mysql_free_result();
	//printf("Dzialalnosci     - %d", iz);
}
stock POD_DZIALALNOSC(playerid, dialog)
{
	new dz[512];
	if(DaneGracza[playerid][gDzialalnosc1] != 0 && GrupaInfo[DaneGracza[playerid][gDzialalnosc1]][gOwnerUID] == DaneGracza[playerid][gUID]) format(dz, sizeof(dz), "%s\n1.\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc1]][gNazwa],DaneGracza[playerid][gDzialalnosc1]);
	if(DaneGracza[playerid][gDzialalnosc2] != 0 && GrupaInfo[DaneGracza[playerid][gDzialalnosc2]][gOwnerUID] == DaneGracza[playerid][gUID]) format(dz, sizeof(dz), "%s\n2.\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc2]][gNazwa],DaneGracza[playerid][gDzialalnosc2]);
	if(DaneGracza[playerid][gDzialalnosc3] != 0 && GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gOwnerUID] == DaneGracza[playerid][gUID]) format(dz, sizeof(dz), "%s\n3.\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gNazwa],DaneGracza[playerid][gDzialalnosc3]);
	if(DaneGracza[playerid][gDzialalnosc4] != 0 && GraczPremium(playerid) && GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gOwnerUID] == DaneGracza[playerid][gUID]) format(dz, sizeof(dz), "%s\n4.\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gNazwa],DaneGracza[playerid][gDzialalnosc4]);
	if(DaneGracza[playerid][gDzialalnosc5] != 0 && GraczPremium(playerid) && GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gOwnerUID] == DaneGracza[playerid][gUID]) format(dz, sizeof(dz), "%s\n5.\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gNazwa],DaneGracza[playerid][gDzialalnosc5]);
	if(DaneGracza[playerid][gDzialalnosc6] != 0 && GraczPremium(playerid) && GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gOwnerUID] == DaneGracza[playerid][gUID]) format(dz, sizeof(dz), "%s\n6.\t{DEDEDE}»  {88b711}%s {DEDEDE}(UID: %d)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gNazwa],DaneGracza[playerid][gDzialalnosc6]);
	if(DaneGracza[playerid][gDzialalnosc1] == 0 &&
	DaneGracza[playerid][gDzialalnosc2] == 0 &&
	DaneGracza[playerid][gDzialalnosc3] == 0 &&
	DaneGracza[playerid][gDzialalnosc4] == 0 &&
	DaneGracza[playerid][gDzialalnosc5] == 0 &&
	DaneGracza[playerid][gDzialalnosc6] == 0) format(dz, sizeof(dz), "%s\nNie nale¿ysz do ¿adnych dzia³alnoœci gospodarczych.", dz, DaneGracza[playerid][gDzialalnosc6],GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gNazwa]);
	dShowPlayerDialog(playerid, dialog, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœci gospodarcze{88b711}:", dz, "Wybierz", "Zamknij");
	return 1;
}
forward ZapiszSaldo(uid);
public ZapiszSaldo(uid)
{
	strdel(zapyt, 0, 1024);
    format(zapyt, sizeof(zapyt),"UPDATE `five_dzialalnosci` SET `SALDO`=%d WHERE `ID`='%d'", GrupaInfo[uid][gSaldo],
	GrupaInfo[uid][gUID]);
    mysql_query(zapyt);
	return 1;
}
forward DodajGrupe(playerid, nazwa[], typ, przywileje[], skiny[]);
public DodajGrupe(playerid, nazwa[], typ, przywileje[], skiny[])
{
	new id = GetFreeSQLUID("five_dzialalnosci", "ID");
	strdel(zapyt, 0, 1024);
	format( zapyt, sizeof( zapyt ), "INSERT INTO `five_dzialalnosci` (`ID`,`NAZWA`, `TYP`, `PRZYWILEJE`, `GUID_OWNERA`, `UID_OWNERA`, `SKINY`) VALUES ('%d', '%s', '%d', '%s', '%d', '%d', '%s')",
		 id, nazwa, typ, przywileje, DaneGracza[playerid][gGUID], DaneGracza[playerid][gUID], skiny);
	mysql_query(zapyt);
	GrupaInfo[id][gUID] = id;
	format(GrupaInfo[id][gNazwa], 25, "%s", nazwa);
	GrupaInfo[id][gTyp] = typ;
	GrupaInfo[id][gOwner] = DaneGracza[playerid][gGUID];
	format(GrupaInfo[id][gKolorCzatu], 50, "%s", "FFFFFF");
	format(GrupaInfo[id][gKolorNicku], 50, "%s", "DEDEDE");
	format(GrupaInfo[id][gKolorTerenu], 50, "%s", "DEDEDE");
	GrupaInfo[id][gSaldo] = 0;
	GrupaInfo[id][gOwnerUID] = DaneGracza[playerid][gUID];
	//
	strdel(zapyt, 0, 1024);
	new ids = GetFreeSQLUID("five_rangi", "ID");
	format( zapyt, sizeof( zapyt ), "INSERT INTO `five_rangi` (`ID`,`UID_DZIALALNOSCI`) VALUES ('%d', '%d')", ids, id);
	mysql_query(zapyt);
	//
	return id;
}