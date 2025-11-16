AntiDeAMX();
forward ZapiszGraczaGlobal(playerid, nr);
public ZapiszGraczaGlobal(playerid, nr)
{
	if(IsPlayerConnected(playerid) && DaneGracza[playerid][gUID] != 0 && zalogowany[playerid] == true)
	{
		if(nr == 1)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `GAMESCORE`=%d WHERE `uid`='%d'",
			DaneGracza[playerid][gGAMESCORE],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 2)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `ooc`=%d WHERE `uid`='%d'",
			DaneGracza[playerid][gOOC],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 3)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `run`=%d WHERE `uid`='%d'",
			DaneGracza[playerid][gRUN],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 4)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `ban`=%d WHERE `uid`='%d'",
			DaneGracza[playerid][gBAN],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 5)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `veh`=%d WHERE `uid`='%d'",
			DaneGracza[playerid][gVEH],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 6)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `gun` = %d WHERE `uid`='%d'",
			DaneGracza[playerid][gGUN],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 7)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `klatwa` = %d WHERE `uid`='%d'",
			DaneGracza[playerid][gKLATWA],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
		if(nr == 8)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),
			"UPDATE `five_users` SET `SLUZBA` = %d WHERE `uid`='%d'",
			DaneGracza[playerid][gSLUZBAA],
			DaneGracza[playerid][gGUID]);
			mysql_query(zapyt);
		}
	}
	return 1;
}
forward ZapiszGracza(playerid);
public ZapiszGracza(playerid)
{
	if(IsPlayerConnected(playerid) && DaneGracza[playerid][gUID] != 0 && zalogowany[playerid] == true)
	{
	    DaneGracza[playerid][gOSTATNIO_NA_SERWERZE] = gettime()-CZAS_LETNI;
		DaneGracza[playerid][gPromile] = GetPlayerDrunkLevel(playerid);
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_postacie` SET `CZAS_ONLINE`='%d', `ZDROWIE`='%f', `SKIN`='%d', `LSKIN`='%d', `OSTATNIO_NA_SERWERZE`='%d', `PORTFEL`='%d', `WAGA`='%d', `BW`='%d', `X`='%f', `Y`='%f', `Z`='%f', `VW`='%d', `INT`='%d', `BRON`='%d', `UIDBRON`='%d', `DO_PELNEJ_GODZINY`='%d', `AJ` = '%d', `QS` = '%d', `PROMILE` = '%d', `PKT` = '%d', `PRZETRZYMANIE` = '%d', `PUID` = '%d', `PX` = '%f', `PY` = '%f', `PZ` = '%f', `GLOD` = '%d', `EDYTOR` = '%d', `KONTO_W_BANKU` = '%d', `AKTYWNE` = '%d' WHERE `ID`='%d'",
		DaneGracza[playerid][gCZAS_ONLINE],
		DaneGracza[playerid][gZDROWIE],
		DaneGracza[playerid][gSKIN],
		DaneGracza[playerid][gLskin],
		DaneGracza[playerid][gOSTATNIO_NA_SERWERZE],
		DaneGracza[playerid][gPORTFEL],
		DaneGracza[playerid][gWAGA],
		DaneGracza[playerid][gBW],
		DaneGracza[playerid][gX],
		DaneGracza[playerid][gY],
		DaneGracza[playerid][gZ],
		DaneGracza[playerid][gVW],
		DaneGracza[playerid][gINT],
		DaneGracza[playerid][gBronAmmo],
		DaneGracza[playerid][gBronUID],
		DaneGracza[playerid][gDoPelnejGodziny],
		DaneGracza[playerid][gAJ],
		DaneGracza[playerid][gQS],
		DaneGracza[playerid][gPromile],
		DaneGracza[playerid][gPktKarne],
		DaneGracza[playerid][gPrzetrzmanie],
		DaneGracza[playerid][gPUID],
		DaneGracza[playerid][gPX],
		DaneGracza[playerid][gPY],
		DaneGracza[playerid][gPZ],
		DaneGracza[playerid][gGlod],
		DaneGracza[playerid][gEdytor],
		DaneGracza[playerid][gKONTO_W_BANKU],
		DaneGracza[playerid][gAKTYWNE],
		DaneGracza[playerid][gUID]);
	    mysql_query(zapyt);
		mysql_free_result();
		
		new dol[124],dols[124];
		format(dol, sizeof(dol), "%s%d", dol, DaneGracza[playerid][gDokumenty][0]);
		format(dols, sizeof(dols), "%s%d", dols, DaneGracza[playerid][gOsiagniecia][0]);
		for(new u = 1; u < D_PENTLA_SAVE; u++)
		{
			format(dol, sizeof(dol), "%s*%d", dol, DaneGracza[playerid][gDokumenty][u]);
		}
		for(new u = 1; u < 30; u++)
		{
			format(dols, sizeof(dols), "%s*%d", dols, DaneGracza[playerid][gOsiagniecia][u]);
		}
		strdel(zapyt, 0, 1024);
		format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `OSTATNI_TRENING` = '%d', `SZTUKA_WALKI` = '%d', `NR_TRENINGU` = '%d', `TRENOWANA_SZTUKA` = '%d', `CZAS_TRWANIA` = '%d', `UZALEZNIENIE` = '%f', `PRACA_TYP` = '%d', `SILA` = '%d', `DOKUMENTY` = '%s',`TELEFON` = '%d', `OSIAGNIECIA` = '%s', `DODATEK1` = '%d', `DODATEK2` = '%d', `ZASILEK` = '%d', `ZAMELDOWANIE` = '%d', `TYP_CHODZENIA` = '%d' WHERE `ID`='%d'",
		DaneGracza[playerid][gOstatniTrening],
		DaneGracza[playerid][gStylWalki],
		DaneGracza[playerid][gNrTreningu],
		DaneGracza[playerid][gTrenowanyStyl],
		DaneGracza[playerid][gCzasTrwaniaUzaleznienia],
		DaneGracza[playerid][gUzaleznienie],
		DaneGracza[playerid][gPracaTyp],
		DaneGracza[playerid][gSILA],
		dol,
		DaneGracza[playerid][gTelefon],
		dols,
		DaneGracza[playerid][gPrzyczepiony1],
		DaneGracza[playerid][gPrzyczepiony2],
		DaneGracza[playerid][gZasilek],
		DaneGracza[playerid][gZamHot],
		DaneGracza[playerid][gTYPCHODZENIA],
		DaneGracza[playerid][gUID]);
	    mysql_query(zapyt);
		mysql_free_result();
	}
	return 1;
}
forward ZapiszDuty(uid, playerid, nr);
public ZapiszDuty(uid, playerid, nr)
{
	if(nr == 1)
	{
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_pracownicy` SET CZAS_NA_SLUZBIE = CZAS_NA_SLUZBIE + %d, KLIENTOW = KLIENTOW + %d, PREMIA = PREMIA + %d WHERE `UID_POSTACI`='%d' AND `UID_DZIALALNOSCI`='%d'",
		DaneGracza[playerid][gPrzynaleznosci][1],
		DaneGracza[playerid][gPrzynaleznosci][3],
		DaneGracza[playerid][gPremia],
		DaneGracza[playerid][gUID],
		uid);
		mysql_query(zapyt);
		DaneGracza[playerid][gPrzynaleznosci][1] = 0;
		DaneGracza[playerid][gPrzynaleznosci][3] = 0;
		DaneGracza[playerid][gPremia] = 0;
		return 1;
	}
    else if(nr == 2)
	{
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_pracownicy` SET CZAS_NA_SLUZBIE = CZAS_NA_SLUZBIE + %d, KLIENTOW = KLIENTOW + %d, PREMIA = PREMIA + %d WHERE `UID_POSTACI`='%d' AND `UID_DZIALALNOSCI`='%d'",
		DaneGracza[playerid][gPrzynaleznosci][7],
		DaneGracza[playerid][gPrzynaleznosci][9],
		DaneGracza[playerid][gPremia],
		DaneGracza[playerid][gUID],
		uid);
		mysql_query(zapyt);
		DaneGracza[playerid][gPrzynaleznosci][7] = 0;
		DaneGracza[playerid][gPrzynaleznosci][9] = 0;
		DaneGracza[playerid][gPremia] = 0;
		return 1;
	}
	else if(nr == 3)
	{
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_pracownicy` SET CZAS_NA_SLUZBIE = CZAS_NA_SLUZBIE + %d, KLIENTOW = KLIENTOW + %d, PREMIA = PREMIA + %d WHERE `UID_POSTACI`='%d' AND `UID_DZIALALNOSCI`='%d'",
		DaneGracza[playerid][gPrzynaleznosci][13],
		DaneGracza[playerid][gPrzynaleznosci][15],
		DaneGracza[playerid][gPremia],
		DaneGracza[playerid][gUID],
		uid);
		mysql_query(zapyt);
		DaneGracza[playerid][gPrzynaleznosci][13] = 0;
		DaneGracza[playerid][gPrzynaleznosci][15] = 0;
		DaneGracza[playerid][gPremia] = 0;
		return 1;
	}
	else if(nr == 4)
	{
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_pracownicy` SET CZAS_NA_SLUZBIE = CZAS_NA_SLUZBIE + %d, KLIENTOW = KLIENTOW + %d, PREMIA = PREMIA + %d WHERE `UID_POSTACI`='%d' AND `UID_DZIALALNOSCI`='%d'",
		DaneGracza[playerid][gPrzynaleznosci][19],
		DaneGracza[playerid][gPrzynaleznosci][21],
		DaneGracza[playerid][gPremia],
		DaneGracza[playerid][gUID],
		uid);
		mysql_query(zapyt);
		DaneGracza[playerid][gPrzynaleznosci][19] = 0;
		DaneGracza[playerid][gPrzynaleznosci][21] = 0;
		DaneGracza[playerid][gPremia] = 0;
		return 1;
	}
	else if(nr == 5)
	{
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_pracownicy` SET CZAS_NA_SLUZBIE = CZAS_NA_SLUZBIE + %d, KLIENTOW = KLIENTOW + %d, PREMIA = PREMIA + %d WHERE `UID_POSTACI`='%d' AND `UID_DZIALALNOSCI`='%d'",
		DaneGracza[playerid][gPrzynaleznosci][25],
		DaneGracza[playerid][gPrzynaleznosci][27],
		DaneGracza[playerid][gPremia],
		DaneGracza[playerid][gUID],
		uid);
		mysql_query(zapyt);
		DaneGracza[playerid][gPrzynaleznosci][25] = 0;
		DaneGracza[playerid][gPrzynaleznosci][27] = 0;
		DaneGracza[playerid][gPremia] = 0;
		return 1;
	}
	else if(nr == 6)
	{
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),
		"UPDATE `five_pracownicy` SET CZAS_NA_SLUZBIE = CZAS_NA_SLUZBIE + %d, KLIENTOW = KLIENTOW + %d, PREMIA = PREMIA + %d WHERE `UID_POSTACI`='%d' AND `UID_DZIALALNOSCI`='%d'",
		DaneGracza[playerid][gPrzynaleznosci][31],
		DaneGracza[playerid][gPrzynaleznosci][33],
		DaneGracza[playerid][gPremia],
		DaneGracza[playerid][gUID],
		uid);
		mysql_query(zapyt);
		DaneGracza[playerid][gPrzynaleznosci][31] = 0;
		DaneGracza[playerid][gPrzynaleznosci][33] = 0;
		DaneGracza[playerid][gPremia] = 0;
		return 1;
	}
	return 1;
}