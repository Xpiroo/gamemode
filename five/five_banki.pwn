AntiDeAMX();
CMD:bank(playerid, params[])
{
	//printf("U¿yta komenda bank");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0)
	{
	    return 0;
	}
	if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0)
	{
	    return 0;
	}
	new uid = NieruchomoscInfo[vw][nWlascicielD];
	if(GrupaInfo[uid][gTyp] != DZIALALNOSC_BANK)
	{
	    return 0;
	}
	if(DaneGracza[playerid][gKONTO_W_BANKU] == 0)
	{
	    dShowPlayerDialog(playerid, DIALOG_BANK_KONTO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Los Santos Bank{88b711}:", "{DEDEDE}Niestety {88b711}nie{DEDEDE} posiadasz konta w banku. \
		\nJeœli chcesz {88b711}za³o¿yæ{DEDEDE} konto w banku wciœnik przycisk ''{88b711}Tak{DEDEDE}'', pamiêtaj za³o¿enie konta w banku kosztuje jednorazowo 20$.\
		\nPoprzez posiadanie konta w banku masz mo¿liwoœæ wziêcia hipotetycznego kredytu.", "Tak", "Nie");
	    return 1;
	}
	else
	{
	    dShowPlayerDialog(playerid, DIALOG_BANKOMAT, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Los Santos Bank{88b711}:", "{DEDEDE}»  {88b711}Stan konta\n{DEDEDE}»  {88b711}Wyp³aæ pieni¹dze\n{DEDEDE}»  {88b711}Wp³aæ pieni¹dze\n{DEDEDE}»  {88b711}Dokonaj przelewu\n{DEDEDE}»  {88b711}Konta Firmowe\n{DEDEDE}»  {88b711}Odbierz zasi³ek", "Wybierz", "Zamknij");
	}
	return 1;
}
CMD:bankomat(playerid, params[])
{
	//printf("U¿yta komenda bankomat");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    new find = 0;
	new uid_budynku = GetPlayerVirtualWorld(playerid);
    ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
	{
	    if(Dystans(1.0, playerid, ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objPozZ]) && GetPlayerVirtualWorld(playerid) == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld])
	    {
		    find = NieruchomoscInfo[uid_budynku][nObiekty][h];
		    break;
		}
	}
	if(ObiektInfo[find][objModel] == 2942)
	{
	    if(DaneGracza[playerid][gKONTO_W_BANKU] != 0)
 		{
		dShowPlayerDialog(playerid, DIALOG_BANKOMAT, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Bankomat{88b711}:", "{DEDEDE}»  {88b711}Stan konta\n{DEDEDE}»  {88b711}Wyp³aæ pieni¹dze", "Wybierz", "Zamknij");
		}else{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}konta{DEDEDE} w banku.", "Zamknij", "");
		}
	}else{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteœ zbyt daleko od modelu bankomatu {88b711}(obiekt id: 2942){DEDEDE}.", "Zamknij", "");
	}
	return 1;
}
forward nrkontasprawdz(nr);
public nrkontasprawdz(nr)
{
	format(zapyt, sizeof(zapyt), "SELECT `NUMER_KONTA` FROM `five_bank` WHERE `NUMER_KONTA` = '%d'", nr);
	mysql_query(zapyt);
	mysql_store_result();
	if(mysql_num_rows() != 0)
	{
   		nr = 100000000 + random(899999999);
   		return nrkontasprawdz(nr);
	}
	else
	{
		return nr;
	}
}
forward DodajKontoWBanku(playerid, nazwa[], nrkonta, nrkarty, bic[], iban[], uidp, uidg);
public DodajKontoWBanku(playerid, nazwa[], nrkonta, nrkarty, bic[], iban[], uidp, uidg)
{
	new index = GetFreeSQLUID("five_bank", "ID");
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_bank` (`ID`, `NAZWA_BANKU`, `NUMER_KONTA`, `NUMER_KARTY`, `BIC`, `IBAN`, `UID_POSTACI`, `UID_DZIALALNOSCI`) VALUES ('%d','%s', '%d', '%d', '%s', '%s', '%d', '%d')",
	index, nazwa, nrkonta, nrkarty, bic, iban, uidp, uidg);
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();
	DaneGracza[playerid][gKONTO_W_BANKU] = index;
	DaneGracza[playerid][gNUMER_KONTA] = nrkonta;
	DaneGracza[playerid][gNUMER_KARTY] = nrkarty;
	DaneGracza[playerid][gUID_BANKU] = uidg;
	DaneGracza[playerid][gSTAN_KONTA] = 0;
	format(DaneGracza[playerid][gBIC], 124, "%s", bic);
    format(DaneGracza[playerid][gIBAN], 124, "%s", iban);
    format(DaneGracza[playerid][gNAZWA_BANKU], 124, "%s", nazwa);
	DaneGracza[playerid][gKREDYT] = 0;
	return index;
}
forward ZapiszBankKasa(uid);
public ZapiszBankKasa(uid)
{
	if(zalogowany[uid] == true)
    {
		strdel(zapyt, 0, 1024);
		format(zapyt, sizeof(zapyt), "UPDATE `five_bank` SET `STAN_KONTA`=%d WHERE `UID_POSTACI`='%d'",
		DaneGracza[uid][gSTAN_KONTA],
		DaneGracza[uid][gUID]);
		mysql_query(zapyt);
	}
	return 1;
}
