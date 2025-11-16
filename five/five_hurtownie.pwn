AntiDeAMX();
enum hinfo
{
	hUID,
	hTyp,
	hNazwa[50],
	hCena,
	hTypP,
	hWar1,
	hWar2
};
new HurtowniaInfo[MAX_HURT][hinfo];
enum xinfo
{
	xUID,
	xHURT,
	xMIEJSCED,
	xWARTOSC,
	xILOSC,
	xTYP,
	xWAR1,
	xWAR2,
	xZAMOWIL,
	xCENA,
	xZAJETY,
	xUIDG,
	xNAZWA[124],
	xNICK[52]
};
new PaczkaInfo[200][xinfo];
forward UsunHurtownie(uid);
public UsunHurtownie(uid)
{
	HurtowniaInfo[uid][hUID] = 0;
	HurtowniaInfo[uid][hTyp] = 0;
	HurtowniaInfo[uid][hCena] = 0;
	HurtowniaInfo[uid][hTypP] = 0;
	HurtowniaInfo[uid][hWar1] = 0;
	HurtowniaInfo[uid][hWar2] = 0;
	format(zapyt, sizeof(zapyt), "DELETE FROM `five_hurtownie` WHERE `ID` = '%d'", uid);
	mysql_check();
	mysql_query2(zapyt);
	return 1;
}
forward ZaladujPaczki();
public ZaladujPaczki()
{
	new result[524], i = 0;
    format(zapyt, sizeof(zapyt), "SELECT * FROM `five_paczki`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
    	sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>dddddddddds[52]ds[124]", PaczkaInfo[uid][xUID],
		    PaczkaInfo[uid][xHURT],
		    PaczkaInfo[uid][xMIEJSCED],
		    PaczkaInfo[uid][xWARTOSC],
			PaczkaInfo[uid][xILOSC],
			PaczkaInfo[uid][xTYP],
			PaczkaInfo[uid][xWAR1],
			PaczkaInfo[uid][xWAR2],
			PaczkaInfo[uid][xZAMOWIL],
			PaczkaInfo[uid][xCENA],
			PaczkaInfo[uid][xNICK],
			PaczkaInfo[uid][xUIDG],
			PaczkaInfo[uid][xNAZWA]);
		i++;
	}
	//printf("Paczki:       - %d", i);
	mysql_free_result();
}
forward ZaladujHurtownie();
public ZaladujHurtownie()
{
	new result[524], i = 0;
    format(zapyt, sizeof(zapyt), "SELECT * FROM `five_hurtownie`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
    	sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>dds[50]dddd", HurtowniaInfo[uid][hUID],
		    HurtowniaInfo[uid][hTyp],
		    HurtowniaInfo[uid][hNazwa],
		    HurtowniaInfo[uid][hCena],
			HurtowniaInfo[uid][hTypP],
			HurtowniaInfo[uid][hWar1],
			HurtowniaInfo[uid][hWar2]);
		i++;
	}
	//printf("Hurtownie:       - %d", i);
	mysql_free_result();
}
forward Salon(playerid, typ, dzialalnosc);
public Salon(playerid, typ, dzialalnosc)
{
	new item_list[64], items_list[1024], find;
	format(items_list, sizeof(items_list), "%s\n{88b711}UID\t\tCena\t\tNazwa{DEDEDE}",items_list);
	ForeachEx(i, MAX_HURT)
	{
		if(HurtowniaInfo[i][hTyp] == typ && HurtowniaInfo[i][hWar2] == dzialalnosc)
		{
			format(item_list, sizeof(item_list), "%d\t\t%d$\t\t%s", HurtowniaInfo[i][hUID], HurtowniaInfo[i][hCena], HurtowniaInfo[i][hNazwa]);
			format(items_list, sizeof(items_list), "%s\n%s", items_list, item_list);
			find++;
  		}
	}
	if(find != 0)
	{
		dShowPlayerDialog(playerid, DIALOG_SALON_POJAZDOW_KUP, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Salon pojazdów{88b711}:", items_list, "Zakup", "Zamknij");
	}
	else
	{
		cmd_salon(playerid, "");
	}	
	return 1;
}
forward Hurtownia(playerid, typ, dzialalnosc, uid, vw);
public Hurtownia(playerid, typ, dzialalnosc, uid, vw)
{
    if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}skorzystaæ{DEDEDE} z hurtowni musisz wejœæ na {88b711}s³u¿bê{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	//if(typ == 21)
	//{
	//	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] != DZIALALNOSC_ZMOTORYZOWANA && GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] != DZIALALNOSC_WARSZTAT)
	//	{
	//		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak mo¿liwoœc {88b711}zamawiania{DEDEDE} przedmiotów w tym {88b711}miejscu{DEDEDE} dla twojej dzia³alnoœci.", "Zamknij", "");
	//		return 0;
	//	}
	//}
	//else
	//{
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] != dzialalnosc)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak mo¿liwoœc {88b711}zamawiania{DEDEDE} przedmiotów w tym {88b711}miejscu{DEDEDE} dla twojej dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	//}
	if(NieruchomoscInfo[vw][nWlascicielD] != DaneGracza[playerid][gSluzba] || NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nWlascicielD] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak mo¿liwoœc {88b711}zamawiania{DEDEDE} przedmiotów w tym {88b711}budynku{DEDEDE} dla twojej dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_ZAMAWIANIE_P))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}uprawnieñ{DEDEDE} do zamawiania przedmiotów.", "Zamknij", "");
	    return 0;
	}
	new item_list[64], items_list[1024], find;
	format(items_list, sizeof(items_list), "%s\n{88b711}UID\t\tCena\t\tNazwa{DEDEDE}",items_list);
	ForeachEx(i, MAX_HURT)
	{
		if(HurtowniaInfo[i][hTyp] == typ)
		{
			format(item_list, sizeof(item_list), "%d\t\t%d$\t\t%s", HurtowniaInfo[i][hUID], HurtowniaInfo[i][hCena], HurtowniaInfo[i][hNazwa]);
			format(items_list, sizeof(items_list), "%s\n%s", items_list, item_list);
			find++;
  		}
	}
	SetPVarInt(playerid, "TYP_Hurt", vw);
	SetPVarInt(playerid, "UIDN_Hurt", uid);
	if(find == 0) dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W tej hurtowni nie mo¿na nic zakupiæ.", "Zamknij", "");
	else dShowPlayerDialog(playerid, DIALOG_HURTOWNIA, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Hurtownia{88b711}:", items_list, "Zakup", "Zamknij");
	return 1;
}
forward SprzedajPrzedmiotH(playerid);
public SprzedajPrzedmiotH(playerid)
{
    new uid = GetPVarInt(playerid, "UIDHURT");
    new ilosc = GetPVarInt(playerid, "ILOSCHURT");
    new cena = GetPVarInt(playerid, "CENACHURT");
    new uids = DaneGracza[playerid][gSluzba];
    if(GrupaInfo[uids][gSaldo] < (HurtowniaInfo[uid][hCena]*ilosc))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Dzia³alnoœæ dla której kupujesz {88b711}produkty{DEDEDE} nie ma wystarczaj¹cej iloœci {88b711}pieniêdzy{DEDEDE} na koncie dzia³alnoœci.", "Zamknij", "");
	    return 0;
	}
	new strp[256];
    format(strp, sizeof(strp), "~b~Zakupiono przedmiot:~n~ ~w~%s~n~~y~Koszt: ~w~%d$~n~~w~Ilosc: %dx",HurtowniaInfo[uid][hNazwa], (HurtowniaInfo[uid][hCena]*ilosc), ilosc);
	GameTextForPlayer(playerid, strp, 5000, 5);
    GrupaInfo[uids][gSaldo] -= (HurtowniaInfo[uid][hCena]*ilosc);
    ZapiszSaldo(uids);
	
	DodajPaczke(GetPVarInt(playerid, "UIDN_Hurt"), GetPVarInt(playerid, "TYP_Hurt"), HurtowniaInfo[uid][hCena]*ilosc, ilosc, HurtowniaInfo[uid][hTypP], HurtowniaInfo[uid][hWar1], HurtowniaInfo[uid][hWar2], playerid, cena,HurtowniaInfo[uid][hNazwa]);
/*	new strpa[256];
	format(strpa, sizeof(strpa), "Kupil: %s",HurtowniaInfo[uid][hNazwa]);
	StatykujTransakcje(uids, playerid, 502, strpa, HurtowniaInfo[uid][hCena]*ilosc);*/
    //Transakcja(T_HRTSELL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, (HurtowniaInfo[uid][hCena]*ilosc), uids, HurtowniaInfo[uid][hTypP], HurtowniaInfo[uid][hWar1], "-", gettime()-CZAS_LETNI);
   // DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, P_PACZKA, HurtowniaInfo[uid][hTypP], DaneGracza[playerid][gSluzba], HurtowniaInfo[uid][hNazwa], HurtowniaInfo[uid][hWar1], 0, gettime()+172800, HurtowniaInfo[uid][hWar2], ilosc, cena, "");
	return 1;
}
forward DodajPaczke(hurtuid, mejscedost, wartoscp, ile, typp, war1p, war2p, zamowil, cenap, nazwa[]);
public DodajPaczke(hurtuid, mejscedost, wartoscp, ile, typp, war1p, war2p, zamowil, cenap, nazwa[])
{
	new uid = GetFreeSQLUID("five_paczki", "ID");
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_paczki` (`ID`, `HURT`, `MIEJSCED`, `WARTOSC`, `ILOSC`, `TYP`, `WAR1`, `WAR2`, `ZAMOWIL`, `CENA`, `IMIE`, `UIDG`, `NAZWA`) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%s', '%d', '%s')",
	uid, hurtuid, mejscedost, wartoscp, ile, typp, war1p, war2p, DaneGracza[zamowil][gUID], cenap, ZmianaNicku(zamowil), DaneGracza[zamowil][gSluzba],nazwa);
	mysql_check();
	mysql_query2(zapyt);
	PaczkaInfo[uid][xUID] = uid;
	PaczkaInfo[uid][xHURT] = hurtuid;
	PaczkaInfo[uid][xMIEJSCED] = mejscedost;
	PaczkaInfo[uid][xWARTOSC] = wartoscp;
	PaczkaInfo[uid][xILOSC] = ile;
	PaczkaInfo[uid][xTYP] = typp;
	PaczkaInfo[uid][xWAR1] = war1p;
	PaczkaInfo[uid][xWAR2] = war2p;
	PaczkaInfo[uid][xZAMOWIL] = DaneGracza[zamowil][gUID];
	PaczkaInfo[uid][xCENA] = cenap;
	PaczkaInfo[uid][xUIDG] = DaneGracza[zamowil][gSluzba];
	PaczkaInfo[uid][xZAJETY] = 0;
	format(PaczkaInfo[uid][xNICK], 52, "%s", ZmianaNicku(zamowil));
	format(PaczkaInfo[uid][xNAZWA], 124, "%s", nazwa);
	mysql_free_result();
	return 1;
}
forward UsunPaczke(uid);
public UsunPaczke(uid)
{
	PaczkaInfo[uid][xUID] = 0;
	PaczkaInfo[uid][xHURT] = 0;
	PaczkaInfo[uid][xMIEJSCED] = 0;
	PaczkaInfo[uid][xWARTOSC] = 0;
	PaczkaInfo[uid][xILOSC] = 0;
	PaczkaInfo[uid][xTYP] = 0;
	PaczkaInfo[uid][xWAR1] = 0;
	PaczkaInfo[uid][xWAR2] = 0;
	PaczkaInfo[uid][xZAMOWIL] = 0;
	PaczkaInfo[uid][xZAJETY] = 0;
	PaczkaInfo[uid][xCENA] = 0;
	PaczkaInfo[uid][xUIDG] = 0;
	format(PaczkaInfo[uid][xNICK], 52, " ");
	format(PaczkaInfo[uid][xNAZWA], 124, " ");
	format(zapyt, sizeof(zapyt), "DELETE FROM `five_paczki` WHERE `ID` = '%d'", uid);
	mysql_check();
	mysql_query2(zapyt);
	return 1;
}
forward DodajDoHurtowni(typ, nazwa[], cena, typp, war1, war2);
public DodajDoHurtowni(typ, nazwa[], cena, typp, war1, war2)
{
	new uid = GetFreeSQLUID("five_hurtownie", "ID");
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_hurtownie` (`ID`, `hTyp`, `hNazwa`, `hCena`, `hTypItemu`, `hWartosc1`, `hWartosc2`) VALUES ('%d', '%d', '%s', '%d', '%d', '%d', '%d')",
	uid, typ, nazwa, cena, typp, war1, war2);
	mysql_check();
	mysql_query2(zapyt);
	HurtowniaInfo[uid][hUID] = uid;
	HurtowniaInfo[uid][hTyp] = typ;
	format(HurtowniaInfo[uid][hNazwa], 124, "%s", nazwa);
	HurtowniaInfo[uid][hCena] = cena;
	HurtowniaInfo[uid][hTypP] = typp;
	HurtowniaInfo[uid][hWar1] = war1;
	HurtowniaInfo[uid][hWar2] = war2;
	mysql_free_result();
	ZapiszHurtownie(uid);
	return 1;
}
forward ZapiszHurtownie(uid);
public ZapiszHurtownie(uid)
{
	strdel(zapyt, 0, 1024);
    format(zapyt, sizeof(zapyt),
	"UPDATE `five_hurtownie` SET `hCena`=%d, `hTyp`=%d, `hNazwa`=%s, `hTypItemu`=%d, `hWartosc1`=%d, `hWartosc2`=%d WHERE `ID`='%d'",
	HurtowniaInfo[uid][hCena],
	HurtowniaInfo[uid][hTyp],
	HurtowniaInfo[uid][hNazwa],
	HurtowniaInfo[uid][hTypP],
	HurtowniaInfo[uid][hWar1],
	HurtowniaInfo[uid][hWar2],
	uid);
    mysql_query(zapyt);
	return 1;
}
