AntiDeAMX();

enum oOferta
{
	oKlient,
	oCena,
	oTyp,
	oWar1,
	oWar2,
	oWar3,
	oWar4,
	oWar5,
	oSprzedajacy,
	oPowod[256]
}
new OfertaInfo[MAX_PLAYERS][oOferta];

stock Oferuj(playerid, playerid2, uid, dzialnoscuid, war1, skin, typ, cena, reason[], news)
{
	if(OferujeA[playerid] != -1)//war2, war1, war3
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wys³a³eœ ju¿ ofertê, {88b711}poczekaj{DEDEDE} na odpowiedz klienta.", "Zamknij", "");
		return 0;
	}
	else
	{
	    if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz coœ oferowaæ {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(Predkosc(playerid2) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewasz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		if(typ != OFEROWANIE_AKC_NAP)
		{
			if(!PlayerObokPlayera(playerid, playerid2, 5))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz coœ oferowaæ {88b711}nie{DEDEDE} znajduje siê obok Ciebie.", "Zamknij", "");
				return 0;
			}
		}
		if(typ != OFEROWANIE_INVITE && typ != OFEROWANIE_YO && typ != OFEROWANIE_WYNAJMU && typ != OFEROWANIE_WYSCIG && typ != OFEROWANIE_WYWIAD && typ != OFEROWANIE_KONTAKT && typ != OFEROWANIE_HOLOWANIA && typ != OFEROWANIE_PRZEDMIOTU)
		{
			if(cena <= 0)
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podana przez ciebie {88b711}kwota{DEDEDE} musi byæ wiêksza od zera.", "Zamknij", "");
				return 0;
			}
		}
		new offername[256];
		OfertaInfo[playerid][oTyp] = typ;
		strmid(OfertaInfo[playerid][oPowod],reason, 0, 60, 60);
		//format(OfertaInfo[playerid][oPowod], 60, "%s", reason);
	    OfertaInfo[playerid][oKlient] = playerid2;
	    OfertaInfo[playerid][oCena] = cena;
	    OfertaInfo[playerid][oWar1] = war1;//w2, w3,w1
	    OfertaInfo[playerid][oWar2] = uid;
	    OfertaInfo[playerid][oWar3] = dzialnoscuid;
	    OfertaInfo[playerid][oWar4] = skin;
		OfertaInfo[playerid][oWar5] = news;
	    OfertaInfo[playerid2][oSprzedajacy] = playerid;
	    new but = -1;
	    if(typ == OFEROWANIE_INVITE)
		{
		    but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Dolaczenie do dzialalnosci gospodarczej~n~~n~~n~~w~Dzialalnosc: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~n~~n~~n~", GrupaInfo[dzialnoscuid][gNazwa], ZmianaNicku(playerid));
		}
		if(typ == OFEROWANIE_KONTAKT)
		{
		    but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Kontakt~n~~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~n~~n~~n~", ZmianaNicku(playerid));
		}
		if(typ == OFEROWANIE_POJAZDU)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Kupno pojazdu~n~~n~~w~Pojazd: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", GetVehicleModelName(PojazdInfo[war1][pModel]), ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_WYPOZYCZENIE)
		{
			but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Wypozyczenie pojazdu~n~~n~~w~Pojazd: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Czas: ~y~%d~g~~h~min~n~~n~~n~~n~", GetVehicleModelName(PojazdInfo[war1][pModel]), ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_KARNET)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Karnet~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_SZTUKEWALKI)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Sztuke walki~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_DOKUMENTU)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~%s~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", TypDokumentu[uid], ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_DZIALA)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~%s~n~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", NazwyDzialalnosci[uid], reason, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_HOLOWANIA)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Holowanie (%s, %d)~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", GetVehicleModelName(PojazdInfo[dzialnoscuid][pModel]), dzialnoscuid, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_TABLIC)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Tablice (%s, %d)~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", GetVehicleModelName(PojazdInfo[uid][pModel]), uid, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_OPLATY)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Budynek (%d)~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", uid, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_WYREJ)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Wyrejestrowanie (%s, %d)~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~~n~", GetVehicleModelName(PojazdInfo[uid][pModel]), uid, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_ELEKTRYKI)
		{
			but = 0;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Zarzadzanie instalacja elektryczna~n~~n~~w~Czas: ~y~%d min~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", war1, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_BUDYNKU)
		{
		    but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Kupno budynku~n~~n~~w~Budynek: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", NieruchomoscInfo[war1][nAdres], ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_PRZEDMIOTU)
		{
		    but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Kupno przedmiotu~n~~n~~w~Przedmiot: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", PrzedmiotInfo[uid][pNazwa], ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_PODAJ)
		{
		    but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Kupno przedmiotu~n~~n~~w~Przedmiot: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", OfertaInfo[playerid][oPowod], ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_MANDATU)
		{
		    but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Mandat (Pkt: %d)~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~",cena, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_BLOKADY)
		{
		    but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Blokada~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_TANKOWANIA)
		{
		    but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Tankowanie~n~Litry: %d(Lacznie: %d)~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~",dzialnoscuid,war1, ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_WYSCIG)
		{
			but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Wyscig~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~n~~n~~n~~n~", ZmianaNicku(playerid));
		}
		if(typ == OFEROWANIE_WYWIAD)
		{
			but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Wywiad~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~n~~n~~n~~n~", ZmianaNicku(playerid));
		}
		if(typ == OFEROWANIE_WYNAJMU)
		{
		    but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Wynajem pokoju~n~~n~~n~~w~Budynek: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~n~~n~~n~", NieruchomoscInfo[war1][nAdres], ZmianaNicku(playerid));
		}
		if(typ == OFEROWANIE_LAKIEROWANIA)
		{
			but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Lakierowanie~n~~n~~w~Kolor: ~y~%d:%d~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", OfertaInfo[playerid][oWar1], OfertaInfo[playerid][oWar4], ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_PJ)
		{
			but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Paint-Job~n~~n~~w~Numer: ~y~%d~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", OfertaInfo[playerid][oWar1], ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_TAXI)
		{
			but = 0;
		    format(offername, 256, "~n~Typ oferty:~n~~g~~h~Przejazd taxi~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$/km~n~~n~~n~~n~", ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_NAP_VEH)
		{
		    but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Montaz~n~~n~~n~~w~Czesc: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", PrzedmiotInfo[uid][pNazwa], ZmianaNicku(playerid), NaprawianieCena[playerid]);
		}
		if(typ == OFEROWANIE_NAP_ENG)
		{
		    but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Naprawa silnika~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", ZmianaNicku(playerid), cena);
		}
		if(typ == OFEROWANIE_YO)
		{
		    but = 1;
			format(offername, 256, "~n~Typ oferty:~n~~g~~h~Przywitanie~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~g~~h~$~n~~n~~n~~n~", ZmianaNicku(playerid));
		}
		if(typ == OFEROWANIE_AKC_NAP)
		{
			but = 0;
			if(NaprawiaIUID[playerid] == -1) format(offername, 256, "~n~Typ oferty:~n~~g~~h~Naprawa silnika~n~~n~~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", ZmianaNicku(playerid), cena);
			//else if(NaprawiaIUID[playerid] == -2) format(offername, 256, "~n~Typ oferty:~n~~g~~h~Tuning~n~~n~~w~Czesc: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", PrzedmiotInfo[OfertaInfo[playerid][oWar3]][pNazwa], ZmianaNicku(playerid), cena);
			else format(offername, 256, "~n~Typ oferty:~n~~g~~h~Montaz~n~~n~~n~~w~Czesc: ~y~%s~n~~w~Oferuje: ~r~%s~n~~n~~w~Koszt: ~y~%d~g~~h~$~n~~n~~n~~n~", PrzedmiotInfo[uid][pNazwa], ZmianaNicku(playerid), NaprawianieCena[playerid]);
		}
		strdel(tekst_global, 0, 2048);
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		format(tekst_global, sizeof(tekst_global), "%s", offername);
		SelectTextDraw(playerid2, 0xFF4040AA);
	    PlayerTextDrawHide(playerid2, TextOferty0[playerid2]);
	    PlayerTextDrawShow(playerid2, TextOferty0[playerid2]);
		PlayerTextDrawHide(playerid2, TextOferty1[playerid2]);
		PlayerTextDrawSetString(playerid2, TextOferty1[playerid2], tekst_global);
		PlayerTextDrawShow(playerid2, TextOferty1[playerid2]);
		PlayerTextDrawHide(playerid2, TextOferty2[playerid2]);
		PlayerTextDrawSetSelectable(playerid2, TextOferty2[playerid2], 1);
	    PlayerTextDrawShow(playerid2, TextOferty2[playerid2]);
	    if(but == 0)
	    {
	    	PlayerTextDrawHide(playerid2, TextOferty3[playerid2]);
	    	PlayerTextDrawSetSelectable(playerid2, TextOferty3[playerid2], 1);
	    	PlayerTextDrawShow(playerid2, TextOferty3[playerid2]);
	    	PlayerTextDrawHide(playerid2, TextOferty4[playerid2]);
	    	PlayerTextDrawSetSelectable(playerid2, TextOferty4[playerid2], 1);
	    	PlayerTextDrawShow(playerid2, TextOferty4[playerid2]);
	    	PlayerTextDrawHide(playerid2, TextOferty5[playerid2]);
	    	PlayerTextDrawSetSelectable(playerid2, TextOferty5[playerid2], 1);
	    	PlayerTextDrawShow(playerid2, TextOferty5[playerid2]);
	    }
	    else if(but == 1)
	    {
	        PlayerTextDrawHide(playerid2, TextOferty6[playerid2]);
	    	PlayerTextDrawSetSelectable(playerid2, TextOferty6[playerid2], 1);
	    	PlayerTextDrawShow(playerid2, TextOferty6[playerid2]);
	    	PlayerTextDrawHide(playerid2, TextOferty7[playerid2]);
	    	PlayerTextDrawSetSelectable(playerid2, TextOferty7[playerid2], 1);
	    	PlayerTextDrawShow(playerid2, TextOferty7[playerid2]);
	    }
		OferujeA[playerid] = playerid2;
	}
    return 1;
}
stock Akceptacja(playerid, accept, typp)
{
	new sellerid = OfertaInfo[playerid][oSprzedajacy];
	OferujeA[sellerid] = -1;
	new type = OfertaInfo[sellerid][oTyp];
	new cena = OfertaInfo[sellerid][oCena];
	new wart1 = OfertaInfo[sellerid][oWar1];
	new wart2 = OfertaInfo[sellerid][oWar2];
	new wart3 = OfertaInfo[sellerid][oWar3];//w2, w3,w1
	new wart4 = OfertaInfo[sellerid][oWar4];
	new wart5 = OfertaInfo[sellerid][oWar5];
	if(accept == 0)
	{
	    GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala odrzucona.",5000,3);
		if(type == OFEROWANIE_NAP_VEH || type == OFEROWANIE_AKC_NAP || type == OFEROWANIE_NAP_ENG || type == OFEROWANIE_TUNE_VEH) 
		{
			NaprawiaID[sellerid] = 0;
			NaprawianieVW[sellerid] = 0;
			NaprawiaVeh[sellerid] = 0;
			NaprawiaIUID[sellerid] = 0;
			NaprawiaCzas[sellerid] = 0;
			LakierujeCzas[sellerid] = 0;
			DeletePVar(sellerid,"TypM");
		}
	    return 1;
	}
	if(typp == 0)
	{
		if(DaneGracza[playerid][gPORTFEL] < cena)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}wystarczaj¹cej{DEDEDE} iloœæi pieniêdzy.", "Zamknij", "");
			if(type == OFEROWANIE_NAP_VEH || type == OFEROWANIE_AKC_NAP || type == OFEROWANIE_TUNE_VEH)
			{
				NaprawiaID[sellerid] = 0;
				NaprawianieVW[sellerid] = 0;
				NaprawiaVeh[sellerid] = 0;
				NaprawiaIUID[sellerid] = 0;
				NaprawiaCzas[sellerid] = 0;
				LakierujeCzas[sellerid] = 0;
				DeletePVar(sellerid,"TypM");
			}
		    return 1;
		}
	}
	else if(typp == 1)
	{
	    if(DaneGracza[playerid][gSTAN_KONTA] < cena)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}wystarczaj¹cej{DEDEDE} iloœæi pieniêdzy.", "Zamknij", "");
			if(type == OFEROWANIE_NAP_VEH || type == OFEROWANIE_AKC_NAP || type == OFEROWANIE_TUNE_VEH)
			{
				NaprawiaID[sellerid] = 0;
				NaprawianieVW[sellerid] = 0;
				NaprawiaVeh[sellerid] = 0;
				NaprawiaIUID[sellerid] = 0;
				NaprawiaCzas[sellerid] = 0;
				LakierujeCzas[sellerid] = 0;
				DeletePVar(sellerid,"TypM");
			}
		    return 1;
		}
	}
	if(type == OFEROWANIE_INVITE)
	{
	    if(!Osiagniecia(playerid, OSIAGNIECIE_ZATRUDNIENIE))
		{
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Pierwsza praca ~g~+75GS");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
			DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_ZATRUDNIENIE] = 1;
			DaneGracza[playerid][gGAMESCORE] += 75;
			SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
			ZapiszGraczaGlobal(playerid, 1);
		}
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
		if(DaneGracza[playerid][gDzialalnosc1] == 0)
		{
		    DaneGracza[playerid][gDzialalnosc1] = wart3;
		    DodajPracownika(DaneGracza[playerid][gUID], wart3, wart1, wart4, OfertaInfo[sellerid][oPowod]);
			kolorchatu(playerid, wart3, 1);
			StatykujTransakcje(wart3, sellerid, playerid, "Zaprosil gracza", -1);
			Zaproszenie(playerid, sellerid, wart3, GrupaInfo[wart3][gNazwa], GrupaInfo[wart3][gTyp]);
			Transakcja(T_OKINV, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], -1, wart3, -1, -1, "-", gettime()-CZAS_LETNI);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc2] == 0)
		{
		    DaneGracza[playerid][gDzialalnosc2] = wart3;
			DodajPracownika(DaneGracza[playerid][gUID], wart3, wart1, wart4, OfertaInfo[sellerid][oPowod]);
			kolorchatu(playerid, wart3, 2);
			StatykujTransakcje(wart3, sellerid, playerid, "Zaprosil gracza", -1);
			Zaproszenie(playerid, sellerid, wart3, GrupaInfo[wart3][gNazwa], GrupaInfo[wart3][gTyp]);
			Transakcja(T_OKINV, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], -1, wart3, -1, -1, "-", gettime()-CZAS_LETNI);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc3] == 0)
		{
            DaneGracza[playerid][gDzialalnosc3] = wart3;
			DodajPracownika(DaneGracza[playerid][gUID], wart3, wart1, wart4, OfertaInfo[sellerid][oPowod]);
			kolorchatu(playerid, wart3, 3);
			StatykujTransakcje(wart3, sellerid, playerid, "Zaprosil gracza", -1);
			Zaproszenie(playerid, sellerid, wart3, GrupaInfo[wart3][gNazwa], GrupaInfo[wart3][gTyp]);
			Transakcja(T_OKINV, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], -1, wart3, -1, -1, "-", gettime()-CZAS_LETNI);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc4] == 0)
		{
            DaneGracza[playerid][gDzialalnosc4] = wart3;
			DodajPracownika(DaneGracza[playerid][gUID], wart3, wart1, wart4, OfertaInfo[sellerid][oPowod]);
			kolorchatu(playerid, wart3, 4);
			StatykujTransakcje(wart3, sellerid, playerid, "Zaprosil gracza", -1);
			Zaproszenie(playerid, sellerid, wart3, GrupaInfo[wart3][gNazwa], GrupaInfo[wart3][gTyp]);
			Transakcja(T_OKINV, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], -1, wart3, -1, -1, "-", gettime()-CZAS_LETNI);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc5] == 0)
		{
            DaneGracza[playerid][gDzialalnosc5] = wart3;
			DodajPracownika(DaneGracza[playerid][gUID], wart3, wart1, wart4, OfertaInfo[sellerid][oPowod]);
			kolorchatu(playerid, wart3, 5);
			StatykujTransakcje(wart3, sellerid, playerid, "Zaprosil gracza", -1);
			Zaproszenie(playerid, sellerid, wart3, GrupaInfo[wart3][gNazwa], GrupaInfo[wart3][gTyp]);
			Transakcja(T_OKINV, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], -1, wart3, -1, -1, "-", gettime()-CZAS_LETNI);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc6] == 0)
		{
            DaneGracza[playerid][gDzialalnosc6] = wart3;
			DodajPracownika(DaneGracza[playerid][gUID], wart3, wart1, wart4, OfertaInfo[sellerid][oPowod]);
			kolorchatu(playerid, wart3, 6);
			StatykujTransakcje(wart3, sellerid, playerid, "Zaprosil gracza", -1);
			Zaproszenie(playerid, sellerid, wart3, GrupaInfo[wart3][gNazwa], GrupaInfo[wart3][gTyp]);
			Transakcja(T_OKINV, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], -1, wart3, -1, -1, "-", gettime()-CZAS_LETNI);
			return 1;
		}
	}
	if(type == OFEROWANIE_YO)
	{
		SetPlayerToFacePlayer(playerid, sellerid);
		ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0);
		ApplyAnimation(sellerid,"GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0);
     	GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_TABLIC)
	{
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszGracza(playerid);
			ZapiszSaldo(wart3);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart3);
		}
		new id = DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, P_TABLICA, wart2, 0, "Tablice", DaneGracza[playerid][gUID], 0, -1, 0, 0, 0, "");
		PojazdInfo[wart2][pTablicaON] = id;
		ZapiszPojazd(wart2, 1);
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart3, sellerid, playerid, "Tablice", cena);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_OPLATY)
	{
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszGracza(playerid);
			ZapiszSaldo(wart3);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart3);
		}
		NieruchomoscInfo[wart2][nOplata] = gettime()+(7*24*60*60);
		ZapiszNieruchomosc(wart2);
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart3, sellerid, playerid, "Oplata budynku", cena);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_KONTAKT)
	{
		DodajKontakty(playerid, sellerid);
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_WYREJ)
	{
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszGracza(playerid);
			ZapiszSaldo(wart3);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart3);
		}
		UsunPrzedmiot(PojazdInfo[wart2][pTablicaON]);
		PojazdInfo[wart2][pTablicaON] = 0;
		format(PojazdInfo[wart2][pTablice], 10, " ");
		GetVehiclePos(PojazdInfo[wart2][pID],PojazdInfo[wart2][pOX],PojazdInfo[wart2][pOY],PojazdInfo[wart2][pOZ]);
		PojazdInfo[wart2][pOVW] = GetVehicleVirtualWorld(PojazdInfo[wart2][pID]);
		GetVehicleZAngle(PojazdInfo[wart2][pID], PojazdInfo[wart2][pOA]);
		SetVehicleNumberPlate(PojazdInfo[wart2][pID], PojazdInfo[wart2][pTablice]);
		SetTimerEx("Naprawa",3000,false,"dd",PojazdInfo[wart2][pID],GetVehicleVirtualWorld(PojazdInfo[wart2][pID]));
		SetVehicleVirtualWorld(PojazdInfo[wart2][pID],9999);
		ZapiszPojazd(wart2, 1);
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart3, sellerid, playerid, "Wyrejestrowa³ pojazd", cena);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_DOKUMENTU)
	{
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszGracza(playerid);
			ZapiszSaldo(wart3);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart3);
		}
		if(wart2 == D_PRAWKO_A)
		{
			DaneGracza[playerid][gDokumenty][D_PRAWKO_A] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (prawo jazdy A)", cena);
		}
		if(wart2 == D_PRAWKO_B)
		{
			DaneGracza[playerid][gDokumenty][D_PRAWKO_B] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (prawo jazdy B)", cena);
		}
		if(wart2 == D_BRON)
		{
			DaneGracza[playerid][gDokumenty][D_BRON] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (licencja na broñ)", cena);
		}
		if(wart2 == D_NIEKARALNOSC)
		{
			DaneGracza[playerid][gDokumenty][D_NIEKARALNOSC] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (niekaralnoœci)", cena);
		}
		if(wart2 == D_DOWOD)
		{
			DaneGracza[playerid][gDokumenty][D_DOWOD] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (dowód)", cena);
		}
		if(wart2 == D_NIEPOCZYTALNOSC)
		{
			DaneGracza[playerid][gDokumenty][D_NIEPOCZYTALNOSC] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (niepoczytalnoœci)", cena);
		}
		if(wart2 == D_WEDKARSKA)
		{
			DaneGracza[playerid][gDokumenty][D_WEDKARSKA] = 1;
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (karta wêdkarska)", cena);
		}
		ZapiszGracza(playerid);
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_DZIALA)
	{
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszGracza(playerid);
			ZapiszSaldo(wart3);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart3][gSaldo] += cena;
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart3);
		}
		if(wart2 == DZIALALNOSC_WARSZTAT)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (warsztat)", cena);
		}
		if(wart2 == DZIALALNOSC_247)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (27/7)", cena);
		}
		if(wart2 == DZIALALNOSC_ELEKTRTYKA)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (elektryka)", cena);
		}
		if(wart2 == DZIALALNOSC_GASTRONOMIA)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (gastronomia)", cena);
		}
		if(wart2 == DZIALALNOSC_HOTEL)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (hotel)", cena);
		}
		if(wart2 == DZIALALNOSC_TAXI)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (taxi)", cena);
		}
		if(wart2 == DZIALALNOSC_SILOWNIA)
		{
			StatykujTransakcje(wart3, sellerid, playerid, "Dokumenty (silownia)", cena);
		}
		new nowa[25];
		strdel(nowa, 0, 25);
		format(nowa, sizeof(nowa), "typ:%d", wart2);
		new uid_grupy = DodajGrupe(playerid, OfertaInfo[sellerid][oPowod], wart2, nowa, nowa);
		Zaproszenie(playerid, sellerid, uid_grupy, GrupaInfo[uid_grupy][gNazwa], GrupaInfo[uid_grupy][gTyp]);
		GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
		if(DaneGracza[playerid][gDzialalnosc1] == 0)
		{
		    DaneGracza[playerid][gDzialalnosc1] = uid_grupy;
		    DodajPracownika(DaneGracza[playerid][gUID], uid_grupy, 0, -1, "0");
			kolorchatu(playerid, uid_grupy, 1);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc2] == 0)
		{
		    DaneGracza[playerid][gDzialalnosc2] = uid_grupy;
			DodajPracownika(DaneGracza[playerid][gUID], uid_grupy, 0, -1, "0");
			kolorchatu(playerid, uid_grupy, 2);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc3] == 0)
		{
            DaneGracza[playerid][gDzialalnosc3] = uid_grupy;
			DodajPracownika(DaneGracza[playerid][gUID], uid_grupy, 0, -1, "0");
			kolorchatu(playerid, uid_grupy, 3);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc4] == 0)
		{
            DaneGracza[playerid][gDzialalnosc4] = uid_grupy;
			DodajPracownika(DaneGracza[playerid][gUID], uid_grupy, 0, -1, "0");
			kolorchatu(playerid, uid_grupy, 4);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc5] == 0)
		{
            DaneGracza[playerid][gDzialalnosc5] = uid_grupy;
			DodajPracownika(DaneGracza[playerid][gUID], uid_grupy, 0, -1, "0");
			kolorchatu(playerid, uid_grupy, 5);
			return 1;
		}
		else if(DaneGracza[playerid][gDzialalnosc6] == 0)
		{
            DaneGracza[playerid][gDzialalnosc6] = uid_grupy;
			DodajPracownika(DaneGracza[playerid][gUID], uid_grupy, 0, -1, "0");
			kolorchatu(playerid, uid_grupy, 6);
			return 1;
		}
	}
	if(type == OFEROWANIE_KARNET)
	{
		new procent = cena/10;
		if(procent > 20)
		{
			procent = 20;
		}
		DaneGracza[sellerid][gPremia] += procent;
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart2][gSaldo] += (cena-procent);
			ZapiszGracza(playerid);
			ZapiszSaldo(wart2);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart2][gSaldo] += (cena-procent);
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart2);
		}
		DaneGracza[playerid][gOstatniTrening] = (gettime() + CZAS_LETNI) + (60*60*12);
		karnet[playerid] = 1;
		ZapiszGracza(playerid);
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "Wlasnie zakupiles karnet~n~mozesz rozpoczac swoj trening");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart2, sellerid, playerid, "Karnet si³owy", cena);
		GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_SZTUKEWALKI)
	{
		new procent = cena/10;
		if(procent > 20)
		{
			procent = 20;
		}
		DaneGracza[sellerid][gPremia] += procent;
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart2][gSaldo] += (cena-procent);
			ZapiszGracza(playerid);
			ZapiszSaldo(wart2);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart2][gSaldo] += (cena-procent);
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart2);
		}
		if(DaneGracza[playerid][gTrenowanyStyl] != wart3)
		{
			DaneGracza[playerid][gTrenowanyStyl] = wart3;
			DaneGracza[playerid][gNrTreningu] = 1;
		}
		else
		{
			DaneGracza[playerid][gNrTreningu]++;
		}
		if(DaneGracza[playerid][gNrTreningu] == 7)
		{
			DaneGracza[playerid][gStylWalki] = wart3;
			DaneGracza[playerid][gNrTreningu] = 0;
			SetPlayerFightingStyle(playerid, DaneGracza[playerid][gStylWalki]);
		}
		DaneGracza[playerid][gOstatniTrening] = (gettime() + CZAS_LETNI) + (60*60*12);
		karnet[playerid] = 1;
		ZapiszGracza(playerid);
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "Wlasnie zakupiles lekcje walki~n~mozesz rozpoczac swoj trening");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart2, sellerid, playerid, "Karnet si³owy + sztuka walki", cena);
		GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_WYSCIG)
	{
		if(Pracuje[playerid] != 0)
		{
			GameTextForPlayer(playerid, "~r~Aktualnie sprzatasz ulice. Anuluj zlecenie, aby dolaczyc do wyscigu.", 3000, 5);
			return 0;
		}
		new str[256];
		DaneGracza[playerid][gWyscig] = wart2;
		new texts[124];
		format(texts, sizeof(texts), "{DEDEDE}** Gracz: %s do³¹czy³ do wyœcigu.", ZmianaNicku(playerid));
		KomuninikatWyscig(playerid,texts);
		format(str, sizeof(str), "~g~Dolaczyles do wyscigu: ~w~%s", WyscigInfo[wart2][wNazwa]);
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], str);
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		StatykujTransakcje(DaneGracza[sellerid][gSluzba], sellerid, playerid, "Do³¹czenie do wyœcigu", -1);
		GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_WYWIAD)
	{
		DaneGracza[sellerid][gWywiad] = playerid;
		DaneGracza[playerid][gWywiad] = sellerid;
		GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "Akceptowales wywiad, aby mowic na antenie wpisz ~g~/wywiad [tresc]");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		StatykujTransakcje(DaneGracza[sellerid][gSluzba], sellerid, playerid, "Wywiad", cena);
	}
	if(type == OFEROWANIE_HOLOWANIA)
	{
	    if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    Dodajkase( sellerid, cena );
		    ZapiszGracza(playerid);
		    ZapiszGracza(sellerid);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    Dodajkase( sellerid, cena );
		    ZapiszBankKasa(playerid);
		    ZapiszGracza(sellerid);
	    }
		if(!IsPlayerInAnyVehicle(playerid))
		{
			dShowPlayerDialog(sellerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} znajduje siê w pojezdzie.", "Zamknij", "");
			return 0;
		}
		if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
		{
			dShowPlayerDialog(sellerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie mo¿e{DEDEDE} znajdywaæ siê za kierownic¹.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(sellerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} znajduje siê w pojezdzie.", "Zamknij", "");
			return 0;
		}
		if(GetPlayerState(sellerid) != PLAYER_STATE_DRIVER)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Gracz {88b711}nie{DEDEDE} znajduje siê za kierownic¹.", "Zamknij", "");
			return 0;
		}
		AttachTrailerToVehicle(GetPlayerVehicleID(playerid),GetPlayerVehicleID(sellerid));
		new us = SprawdzCarUID(GetPlayerVehicleID(sellerid));
		PrzedmiotInfo[wart1][pUzywany] = us;
		ZapiszPrzedmiot(wart1);
	    GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
 	if(type == OFEROWANIE_POJAZDU)
	{
	    PojazdInfo[wart1][pOwnerPostac] = DaneGracza[playerid][gUID];
	    if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    Dodajkase( sellerid, cena );
		    ZapiszGracza(playerid);
		    ZapiszGracza(sellerid);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    Dodajkase( sellerid, cena );
		    ZapiszBankKasa(playerid);
		    ZapiszGracza(sellerid);
	    }
	    ZapiszPojazd(wart1, 2);
	    Transakcja(T_OKVEH, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], cena, wart1, -1, -1, "-", gettime()-CZAS_LETNI);
	    RemovePlayerFromVehicle(sellerid);
	    RemovePlayerFromVehicle(sellerid);
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd zosta³ {88b711}zakupiony{DEDEDE} pomyœlnie.", "Zamknij", "");
	    dShowPlayerDialog(sellerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd zosta³ {88b711}sprzedany{DEDEDE} pomyœlnie.", "Zamknij", "");
	}
	if(type == OFEROWANIE_WYPOZYCZENIE)
	{
		DaneGracza[playerid][gWypozyczonyPojazdUID] = wart1;
		DaneGracza[playerid][gWypozyczonyPojazdCZAS] = gettime()+(60*cena);
	    GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_ELEKTRYKI)
	{
		new procent = cena/10;
		if(procent > 20)
		{
			procent = 20;
		}
		DaneGracza[sellerid][gPremia] += procent;
		if(typp == 0)
		{
			Dodajkase( playerid, -cena );
			GrupaInfo[wart2][gSaldo] += (cena-procent);
			ZapiszGracza(playerid);
			ZapiszSaldo(wart2);
		}
		else if(typp == 1)
		{
			DaneGracza[playerid][gSTAN_KONTA] -= cena;
			GrupaInfo[wart2][gSaldo] += (cena-procent);
			ZapiszBankKasa(playerid);
			ZapiszSaldo(wart2);
		}
		new czas = wart1*60000;
		DaneGracza[sellerid][gZarzadzajElektryka] = wart4;
		SetTimerEx("ZarzadzajElektryka",czas,0,"d",sellerid);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Elektryk mo¿e teraz {88b711}zarz¹dzaæ{DEDEDE} instalacjami {88b711}elektrycznymi{DEDEDE} w tym budynku.", "Zamknij", "");
		dShowPlayerDialog(sellerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Mo¿esz {88b711}zarz¹dzaæ{DEDEDE} teraz instalacjami {88b711}elektrycznymi{DEDEDE} w tym budynku.", "Zamknij", "");
		StatykujTransakcje(wart2, sellerid, playerid, "Elektryke", cena);
	}
	if(type == OFEROWANIE_PRZEDMIOTU)
	{
		if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    Dodajkase( sellerid, cena );
		    ZapiszGracza(playerid);
		    ZapiszGracza(sellerid);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    Dodajkase( sellerid, cena );
		    ZapiszBankKasa(playerid);
		    ZapiszGracza(sellerid);
	    }
		PrzedmiotInfo[wart2][pOwner] = DaneGracza[playerid][gUID];
		ZapiszPrzedmiot(wart2);
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Przedmiot zosta³ {88b711}zakupiony{DEDEDE} pomyœlnie.", "Zamknij", "");
	    dShowPlayerDialog(sellerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Przedmiot zosta³ {88b711}sprzedany{DEDEDE} pomyœlnie.", "Zamknij", "");
	    
	}
	if(type == OFEROWANIE_BUDYNKU)
	{
	    NieruchomoscInfo[wart1][nWlascicielP] = DaneGracza[playerid][gUID];
        if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    Dodajkase( sellerid, cena );
		    ZapiszGracza(playerid);
		    ZapiszGracza(sellerid);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    Dodajkase( sellerid, cena );
		    ZapiszBankKasa(playerid);
		    ZapiszGracza(sellerid);
	    }
	    ZapiszNieruchomosc(wart1);
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Budynek zosta³ {88b711}zakupiony{DEDEDE} pomyœlnie.", "Zamknij", "");
	    dShowPlayerDialog(sellerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Budynek zosta³ {88b711}sprzedany{DEDEDE} pomyœlnie.", "Zamknij", "");
	    Transakcja(T_OKHOUSE, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], cena, wart1, -1, -1, "-", gettime()-CZAS_LETNI);
	}
	if(type == OFEROWANIE_PODAJ)
	{
		new procent = cena/10;
		if(procent > 20)
		{
			procent = 20;
		}
		new grupa = MagazynInfo[wart2][mOwner];
		if(MagazynInfo[wart2][mIlosc] == 0)
		{
		    GameTextForPlayer(playerid, "~r~Nie ma takiego przedmiotu.", 3000, 5);
		    return 0;
		}
		DaneGracza[sellerid][gPremia] += procent;
	    if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    GrupaInfo[grupa][gSaldo] += (cena-procent);
		    ZapiszGracza(playerid);
		    ZapiszSaldo(grupa);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    GrupaInfo[grupa][gSaldo] += (cena-procent);
		    ZapiszBankKasa(playerid);
		    ZapiszSaldo(grupa);
	    }
		Transakcja(T_OKITEM, DaneGracza[playerid][gUID], DaneGracza[sellerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[sellerid][gGUID], cena, wart2, wart3, wart1, "-", gettime()-CZAS_LETNI);
		DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, wart3, wart1, wart4, OfertaInfo[sellerid][oPowod], DaneGracza[playerid][gUID], 0, -1, 0, 0,0, "");
		if(MagazynInfo[wart2][mIlosc] == 1)
		{
		    UsunMagazyn(wart2);
		    return 1;
		}
		else
		{
		    MagazynInfo[wart2][mIlosc]--;
		    ZapiszMagazyn(wart2);
		}
        GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~~2~Kupiles przedmiot.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(grupa, sellerid, playerid, OfertaInfo[sellerid][oPowod], cena);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_TANKOWANIA)
	{
	    if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    ZapiszGracza(playerid);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    ZapiszBankKasa(playerid);
	    }
		ApplyAnimation(sellerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
		cmd_fasdasfdfive(sellerid, "wk³ada pistolet do baku.");
		new Float:ilosc = wart3;
		PojazdInfo[wart2][pPaliwo] = ilosc;
		ZapiszPojazd(wart2, 1);
		new dla_nuba = cena / 10;
		Dodajkase( sellerid, dla_nuba );
		ZapiszGracza(sellerid);
        GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_BLOKADY)
	{
	    if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    GrupaInfo[wart2][gSaldo] += cena;
		    ZapiszGracza(playerid);
		    ZapiszSaldo(wart2);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    GrupaInfo[wart2][gSaldo] += cena;
		    ZapiszBankKasa(playerid);
		    ZapiszSaldo(wart2);
	    }
		PojazdInfo[wart3][pBlokada] = 0;
		ZapiszPojazd(wart3, 1);
		new dla_nuba = cena / 10;
		Dodajkase( sellerid, dla_nuba );
		ZapiszGracza(sellerid);
        GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart2, sellerid, playerid, "Zdjêcie blokady", cena);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_MANDATU)
	{
	    if(typp == 0)
	    {
		    Dodajkase( playerid, -cena );
		    GrupaInfo[wart2][gSaldo] += cena;
		    ZapiszGracza(playerid);
		    ZapiszSaldo(wart2);
	    }
     	else if(typp == 1)
	    {
		    DaneGracza[playerid][gSTAN_KONTA] -= cena;
		    GrupaInfo[wart2][gSaldo] += cena;
		    ZapiszBankKasa(playerid);
		    ZapiszSaldo(wart2);
	    }
		new dla_nuba = cena / 10;
		Dodajkase( sellerid, dla_nuba );
		ZapiszGracza(sellerid);
		DodajKartoteke(sellerid, playerid, 1, OfertaInfo[sellerid][oPowod]);
		DaneGracza[playerid][gPktKarne] += wart3;
		ZapiszGracza(playerid);
        GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
		if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
		else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
		else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
		else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
		else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
		else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
		StatykujTransakcje(wart2, sellerid, playerid, "Mandat", cena);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_WYNAJMU)
	{
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
	    DaneGracza[playerid][gWynajem] = NieruchomoscInfo[wart1][nUID];
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `WYNAJEM`='%d' WHERE `ID`='%d'", DaneGracza[playerid][gWynajem], DaneGracza[playerid][gUID]);
	    mysql_query(zapyt);
	    GameTextForPlayer(playerid,"~y~~h~Oferta:~n~~w~Akceptowales oferte.",5000,3);
     	GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~Twoja oferta zostala akceptowana.",5000,3);
	}
	if(type == OFEROWANIE_TAXI)
	{
	    new Float:przejechane;
	    GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
     	GameTextForPlayer(playerid,"~y~~h~Oferowanie:~n~~w~~2~Oferta zostala akceptowana.",5000,3);
     	SetPVarInt(playerid, "przejazt", sellerid);
		SetPVarInt(playerid, "przejazvid", wart2);
		SetPVarInt(playerid, "przejazuid", wart1);
		SetPVarInt(playerid, "przejazguid", wart3);
		SetPVarInt(playerid, "przejazcena", cena);
		przejechane = (PojazdInfo[wart1][pPrzebieg]/1000.0);
		SetPVarFloat(playerid, "przejechanes", przejechane);
     	taxijedz[playerid] = 1;
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "Wlasnie ~b~akceptowales~w~ usluge taksowkarza, aby zaznaczyc ~r~cel~w~ podrozy wcisnij ~n~klawisz ~y~ESC~w~ nastepnie uzyj ~g~~h~mapy~w~ by zaznaczyc punkt.");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
	}
	if(type == OFEROWANIE_NAP_VEH)
	{
		NaprawiaCzas[sellerid] = 30;
	}
	if(type == OFEROWANIE_TUNE_VEH)
	{
		NaprawiaCzas[sellerid] = 30;
	}
	if(type == OFEROWANIE_NAP_ENG)
	{
		NaprawiaIUID[sellerid] = -1;
		NaprawianieVW[sellerid] = wart2;
		NaprawianieDUID[sellerid] = wart1;
		NaprawiaCzas[sellerid] = 60;
	}
	if(type == OFEROWANIE_LAKIEROWANIA)
	{
		new bron_uid = GetPVarInt(sellerid, "UzywanaBronUID");
		PoziomLakieru[sellerid] = PrzedmiotInfo[bron_uid][pWar2];
		Tag[sellerid] = -1;
		LakierujeCzas[sellerid] = 1;
		new uidpo = SprawdzCarUID(wart3);
		NaprawianieVW[sellerid] = GetVehicleVirtualWorld(GetPlayerVehicleID(playerid));
		MalowanieKolor[sellerid][0] = wart1;
		MalowanieKolor[sellerid][1] = wart4;
		MalowanieKolor[sellerid][2] = wart3;
		MalowanieKolor[sellerid][3] = wart5;
		NaprawiaID[sellerid] = playerid;
		NaprawiaVeh[sellerid] = wart3;
		UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[uidpo][pID]], 0xAAAAFFFF, "Rozpoczynanie lakierowania");
		GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
		PJ[sellerid] = 0;
	}
	if(type == OFEROWANIE_PJ)
	{
		new bron_uid = GetPVarInt(sellerid, "UzywanaBronUID");
		PoziomLakieru[sellerid] = PrzedmiotInfo[bron_uid][pWar2];
		Tag[sellerid] = -1;
		LakierujeCzas[sellerid] = 1;
		new uidpo = SprawdzCarUID(wart3);
		NaprawianieVW[sellerid] = GetVehicleVirtualWorld(GetPlayerVehicleID(playerid));
		MalowanieKolor[sellerid][0] = wart1;
		MalowanieKolor[sellerid][1] = wart4;
		MalowanieKolor[sellerid][2] = wart3;
		MalowanieKolor[sellerid][3] = wart5;
		NaprawiaID[sellerid] = playerid;
		NaprawiaVeh[sellerid] = wart3;
		UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[uidpo][pID]], 0xAAAAFFFF, "Rozpoczynanie lakierowania");
		GameTextForPlayer(sellerid,"~y~~h~Oferowanie:~n~~w~~2~Twoja oferta zostala akceptowana.",5000,3);
		PJ[sellerid] = 1;
	}
	if(type == OFEROWANIE_AKC_NAP)
	{
		new up = SprawdzCarUID(NaprawiaVeh[sellerid]);
		if(NaprawiaIUID[sellerid] == -1)
		{
			new grupa;
			if(NaprawianieVW[sellerid] == 0)
			{
				grupa = NaprawianieDUID[sellerid];
			}
			else
			{
				grupa = NieruchomoscInfo[NaprawianieVW[sellerid]][nWlascicielD];
			}
			if(typp == 0)
			{
				Dodajkase( playerid, -cena );
				GrupaInfo[grupa][gSaldo] += NaprawianieCena[sellerid];
				ZapiszGracza(playerid);
				ZapiszSaldo(grupa);
			}
			else if(typp == 1)
			{
				DaneGracza[playerid][gSTAN_KONTA] -= cena;
				GrupaInfo[grupa][gSaldo] += NaprawianieCena[sellerid];
				ZapiszBankKasa(playerid);
				ZapiszSaldo(grupa);
			}
			new dla_nuba = NaprawianieCena[sellerid] / 10;
			Dodajkase( sellerid, dla_nuba );
			ACOFF[up] = 1;
			PojazdInfo[up][pNaprawy] += (1000 - PojazdInfo[up][pStan]);
			PojazdInfo[up][pStan] = 1000;
			SetVehicleHealth(NaprawiaVeh[sellerid], PojazdInfo[up][pStan]);
			PojazdInfo[up][pStan] = 1000;
			if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
			else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
			else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
			else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
			else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
			else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
			StatykujTransakcje(grupa, sellerid, playerid, "Naprawe pojazdu", cena);
			/*if(PojazdInfo[up][pNaprawy] >= 10000)
			{
				UsunPojazd(up);
				GameTextForPlayer(playerid, "~r~Pojazd osiagnal maxymalny poziom zniszczen.", 3000, 5);
				return 0;
			}*/
		}
		else
		{
			new uzy = GetPVarInt(sellerid, "UzytyItem");
			if(PrzedmiotInfo[uzy][pOwner] != DaneGracza[sellerid][gUID])
			{
				NaprawiaODL[sellerid] = 0;
				NaprawiaID[sellerid] = 0;
				NaprawianieVW[sellerid] = 0;
				NaprawiaVeh[sellerid] = 0;
				NaprawiaIUID[sellerid] = 0;
				NaprawiaCzas[sellerid] = 0;
				DeletePVar(sellerid,"TypM");
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Komponent który zosta³ {88b711}montowany{DEDEDE} nie znajduje siê w {88b711}ekwipunku{DEDEDE} oferuj¹cego.", "Zamknij", "");
				return 0;
			}
			new grupa = NieruchomoscInfo[NaprawianieVW[sellerid]][nWlascicielD];
			if(typp == 0)
			{
				Dodajkase( playerid, -cena );
				GrupaInfo[grupa][gSaldo] += cena;
				ZapiszGracza(playerid);
				ZapiszSaldo(grupa);
			}
			else if(typp == 1)
			{
				DaneGracza[playerid][gSTAN_KONTA] -= cena;
				GrupaInfo[grupa][gSaldo] += cena;
				ZapiszBankKasa(playerid);
				ZapiszSaldo(grupa);
			}
			new przedtyp = GetPVarInt(sellerid, "TypM");
			GetVehiclePos(PojazdInfo[up][pID],PojazdInfo[up][pOX],PojazdInfo[up][pOY],PojazdInfo[up][pOZ]);
			PojazdInfo[up][pOVW] = GetVehicleVirtualWorld(PojazdInfo[up][pID]);
			if(przedtyp == P_KOMPONENTY)
			{
				new uidt = SprawdzCarUID(NaprawiaVeh[sellerid]);
				new uid = NaprawiaIUID[sellerid];
				if(PrzedmiotInfo[uid][pWar1] == 1)
				{
					PojazdInfo[uidt][pTempomat] = 1;
					StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (tempomat)", cena);
				}
				if(PrzedmiotInfo[uid][pWar1] == 2)
				{
					PojazdInfo[uidt][pAudio] = 1;
					StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (system audio)", cena);
				}
				if(PrzedmiotInfo[uid][pWar1] == 3)
				{
					PojazdInfo[uidt][pAlarm] = 1;
					StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (system alarmowy)", cena);
				}
				if(PrzedmiotInfo[uid][pWar1] == 4)
				{
					PojazdInfo[uidt][pImmo] = 1;
					StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (immobilajzer)", cena);
				}
				if(PrzedmiotInfo[uid][pWar1] == 5)
				{
					PojazdInfo[uidt][pCB] = 1;
					StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (CB-Radio)", cena);
				}
				if(PrzedmiotInfo[uid][pWar1] == 6)
				{
					PojazdInfo[uidt][pGaz] = 1;
					StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (gaz)", cena);
				}
			}
			if(przedtyp == P_TUNING)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidt = SprawdzCarUID(NaprawiaVeh[sellerid]);
				new uid = NaprawiaIUID[sellerid];
				PrzedmiotInfo[uid][pX] = 0;
				PrzedmiotInfo[uid][pY] = 0;
				PrzedmiotInfo[uid][pZ] = 0;
				PrzedmiotInfo[uid][pVW] = 0;
				PrzedmiotInfo[uid][pTypWlas] = TYP_AUTO;
				PrzedmiotInfo[uid][pWar2] = 1;
				PrzedmiotInfo[uid][pOwner] = uidt;
				DeletePVar(playerid, "UzytyItem");
				ZapiszPrzedmiot(uid);
				Tuning(NaprawiaVeh[sellerid]);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (tuning)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_MASKA)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidveh = SprawdzCarUID(NaprawiaVeh[sellerid]);
				GetVehiclePos(PojazdInfo[uidveh][pID],PojazdInfo[uidveh][pOX],PojazdInfo[uidveh][pOY],PojazdInfo[uidveh][pOZ]);
				PojazdInfo[uidveh][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uidveh][pID]);
				GetVehicleZAngle(PojazdInfo[uidveh][pID], PojazdInfo[uidveh][pOA]);
				setDoor(NaprawiaVeh[sellerid],HOOD,FULL);
				SetTimerEx("Naprawa",3000,false,"dd",NaprawiaVeh[sellerid],GetVehicleVirtualWorld(NaprawiaVeh[sellerid]));
				SetVehicleVirtualWorld(NaprawiaVeh[sellerid],9999);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (maska)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_BAGAZNIK)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidveh = SprawdzCarUID(NaprawiaVeh[sellerid]);
				GetVehiclePos(PojazdInfo[uidveh][pID],PojazdInfo[uidveh][pOX],PojazdInfo[uidveh][pOY],PojazdInfo[uidveh][pOZ]);
				PojazdInfo[uidveh][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uidveh][pID]);
				GetVehicleZAngle(PojazdInfo[uidveh][pID], PojazdInfo[uidveh][pOA]);
				setDoor(NaprawiaVeh[sellerid],TRUNK,FULL);
				SetTimerEx("Naprawa",3000,false,"dd",NaprawiaVeh[sellerid],GetVehicleVirtualWorld(NaprawiaVeh[sellerid]));
				SetVehicleVirtualWorld(NaprawiaVeh[sellerid],9999);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (baga¿nik)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_ZDERZAKP)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidveh = SprawdzCarUID(NaprawiaVeh[sellerid]);
				GetVehiclePos(PojazdInfo[uidveh][pID],PojazdInfo[uidveh][pOX],PojazdInfo[uidveh][pOY],PojazdInfo[uidveh][pOZ]);
				PojazdInfo[uidveh][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uidveh][pID]);
				GetVehicleZAngle(PojazdInfo[uidveh][pID], PojazdInfo[uidveh][pOA]);
				setPanel(NaprawiaVeh[sellerid],FRONT_PANEL,FULL);
				SetTimerEx("Naprawa",3000,false,"dd",NaprawiaVeh[sellerid],GetVehicleVirtualWorld(NaprawiaVeh[sellerid]));
				SetVehicleVirtualWorld(NaprawiaVeh[sellerid],9999);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (zderzak przedni)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_ZDERZAKT)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidveh = SprawdzCarUID(NaprawiaVeh[sellerid]);
				GetVehiclePos(PojazdInfo[uidveh][pID],PojazdInfo[uidveh][pOX],PojazdInfo[uidveh][pOY],PojazdInfo[uidveh][pOZ]);
				PojazdInfo[uidveh][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uidveh][pID]);
				GetVehicleZAngle(PojazdInfo[uidveh][pID], PojazdInfo[uidveh][pOA]);
				setPanel(NaprawiaVeh[sellerid],BACK_PANEL,FULL);
				SetTimerEx("Naprawa",3000,false,"dd",NaprawiaVeh[sellerid],GetVehicleVirtualWorld(NaprawiaVeh[sellerid]));
				SetVehicleVirtualWorld(NaprawiaVeh[sellerid],9999);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (zderzak tylni)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_DRZWIP)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidveh = SprawdzCarUID(NaprawiaVeh[sellerid]);
				GetVehiclePos(PojazdInfo[uidveh][pID],PojazdInfo[uidveh][pOX],PojazdInfo[uidveh][pOY],PojazdInfo[uidveh][pOZ]);
				PojazdInfo[uidveh][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uidveh][pID]);
				GetVehicleZAngle(PojazdInfo[uidveh][pID], PojazdInfo[uidveh][pOA]);
				setDoor(NaprawiaVeh[sellerid],RIGHT_DOOR,FULL);
				SetTimerEx("Naprawa",3000,false,"dd",NaprawiaVeh[sellerid],GetVehicleVirtualWorld(NaprawiaVeh[sellerid]));
				SetVehicleVirtualWorld(NaprawiaVeh[sellerid],9999);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (drzwi pasa¿era)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_DRZWIK)
			{
				AntyCheatWizualizacja[playerid] = 1;
				new uidveh = SprawdzCarUID(NaprawiaVeh[sellerid]);
				GetVehiclePos(PojazdInfo[uidveh][pID],PojazdInfo[uidveh][pOX],PojazdInfo[uidveh][pOY],PojazdInfo[uidveh][pOZ]);
				PojazdInfo[uidveh][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uidveh][pID]);
				GetVehicleZAngle(PojazdInfo[uidveh][pID], PojazdInfo[uidveh][pOA]);
				setDoor(NaprawiaVeh[sellerid],LEFT_DOOR,FULL);
				SetTimerEx("Naprawa",3000,false,"dd",NaprawiaVeh[sellerid],GetVehicleVirtualWorld(NaprawiaVeh[sellerid]));
				SetVehicleVirtualWorld(NaprawiaVeh[sellerid],9999);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (drzwi kierowcy)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_SWIATLOLP)
			{
				AntyCheatWizualizacja[playerid] = 1;
				setLight(NaprawiaVeh[sellerid],LEFT_LIGHT,FULL);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (lewe œwiat³o)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_SWIATLOPP)
			{
				AntyCheatWizualizacja[playerid] = 1;
				setLight(NaprawiaVeh[sellerid],RIGHT_LIGHT,FULL);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (prawe œwiat³o)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_OPONALP)
			{
				AntyCheatWizualizacja[playerid] = 1;
				setTire(NaprawiaVeh[sellerid],LEFT_F_TIRE,FULL);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (Opona LP)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_OPONAPP)
			{
				AntyCheatWizualizacja[playerid] = 1;
				setTire(NaprawiaVeh[sellerid],RIGHT_F_TIRE,FULL);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (Opona PP)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_OPONAPT)
			{
				AntyCheatWizualizacja[playerid] = 1;
				setTire(NaprawiaVeh[sellerid],RIGHT_B_TIRE,FULL);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (Opona PT)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(przedtyp == P_OPONALT)
			{
				AntyCheatWizualizacja[playerid] = 1;
				setTire(NaprawiaVeh[sellerid],LEFT_B_TIRE,FULL);
				StatykujTransakcje(grupa, sellerid, playerid, "Monta¿ (Opona LT)", cena);
				KillTimer(AntyCheatWizualizacjaTimer[playerid]);
				AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
			}
			if(DutyNR[sellerid] == 1) DaneGracza[sellerid][gPrzynaleznosci][3]++;
			else if(DutyNR[sellerid] == 2) DaneGracza[sellerid][gPrzynaleznosci][9]++;
			else if(DutyNR[sellerid] == 3) DaneGracza[sellerid][gPrzynaleznosci][15]++;
			else if(DutyNR[sellerid] == 4) DaneGracza[sellerid][gPrzynaleznosci][21]++;
			else if(DutyNR[sellerid] == 5) DaneGracza[sellerid][gPrzynaleznosci][27]++;
			else if(DutyNR[sellerid] == 6) DaneGracza[sellerid][gPrzynaleznosci][33]++;
			new dla_nuba = cena / 10;
			Dodajkase( sellerid, dla_nuba );
			if(przedtyp != P_TUNING)
			{
				UsunPrzedmiot(NaprawiaIUID[sellerid]);
			}
		}
		ZapiszPojazd(up, 1);
		SetTimerEx("Unfreeze_AC", 2000, 0, "i", up);
		ForeachEx(x, IloscGraczy)
		{
			if(PlayerObokPojazdu(KtoJestOnline[x],	NaprawiaVeh[sellerid]) < 10.0)
		    {
           		PlayerPlaySound(KtoJestOnline[x], 1133, 0.0, 0.0, 0.00);
          	}
        }
		NaprawiaODL[sellerid] = 0;
        NaprawiaID[sellerid] = 0;
		NaprawianieVW[sellerid] = 0;
		NaprawiaVeh[sellerid] = 0;
		NaprawiaIUID[sellerid] = 0;
		NaprawiaCzas[sellerid] = 0;
		DeletePVar(sellerid,"TypM");
	}
	OfertaInfo[sellerid][oTyp] = 0;
	strmid(OfertaInfo[sellerid][oPowod],"", 0, 60, 60);
    OfertaInfo[sellerid][oKlient] = -1;
    OfertaInfo[sellerid][oCena] = 0;
    OfertaInfo[sellerid][oWar1] = 0;
    OfertaInfo[sellerid][oWar2] = 0;
    OfertaInfo[sellerid][oWar3] = 0;
    OfertaInfo[sellerid][oWar4] = 0;
	OfertaInfo[sellerid][oWar5] = 0;
    OfertaInfo[playerid][oSprzedajacy] = -1;
    return 1;
}
