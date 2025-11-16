AntiDeAMX();
CMD:news(playerid,cmdtext[])
{
	//printf("U¿yta komenda news");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_SANNEWS, 31))
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	new uidg = DaneGracza[playerid][gSluzba];
	strdel(tekst_global, 0, 2048);
	if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_SANNEWS)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	if(sscanf(cmdtext, "s[256]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby napisaæ {88b711}newsa{DEDEDE} wpisz:{88b711} /news [treœæ]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisana wiadomoœæ jest {88b711}nie{DEDEDE} poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(blad != 1)
	{
		format(tekst_global, sizeof(tekst_global), " ~p~LS News (%s): ~w~ %s", ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SNINFO = 60*5;
	}
	return 1;
	
}
CMD:wywiad(playerid,cmdtext[])
{
	//printf("U¿yta komenda wywiad");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gWywiad] == 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "s[256]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby napisaæ na {88b711}antenie{DEDEDE} wpisz:{88b711} /wywiad [treœæ]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	if(ComparisonString(tekst_global, "zakoncz"))
	{
		if(!UprawnienieNaSluzbie(playerid, U_WYWIAD))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		dShowPlayerDialog(DaneGracza[playerid][gWywiad], DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Reporter {88b711}zakoñczy³{DEDEDE} z tob¹ wywiad!", "Zamknij", "");
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zakoñczy³eœ wywiad.", "Zamknij", "");
		DaneGracza[DaneGracza[playerid][gWywiad]][gWywiad] = 0;
		DaneGracza[playerid][gWywiad] = 0;
		return 0;
	}
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisana wiadomoœæ jest {88b711}nie{DEDEDE} poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(blad != 1)
	{
		format(tekst_global, sizeof(tekst_global), " ~p~Wywiad (%s): ~w~ %s", ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SNINFO = 60*2;
	}
	return 1;
	
}
CMD:reklama(playerid,cmdtext[])
{
	//printf("U¿yta komenda reklama");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_SANNEWS, 32))
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	new uidg = DaneGracza[playerid][gSluzba];
	if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_SANNEWS)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	new czas;
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "ds[256]", czas, tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby napisaæ {88b711}newsa{DEDEDE} wpisz:{88b711} /reklama [iloœæ minut] [treœæ]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisana wiadomoœæ jest {88b711}nie{DEDEDE} poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(blad != 1)
	{
		format(tekst_global, sizeof(tekst_global), " ~y~~h~LS Reklama (%s): ~w~ %s", ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SNINFO = czas*60;
	}
	return 1;
}
CMD:live(playerid,cmdtext[])
{
	//printf("U¿yta komenda live");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!NalezyDoDziZUp(playerid, DZIALALNOSC_SANNEWS, 33))
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	new uidg = DaneGracza[playerid][gSluzba];
	if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_SANNEWS)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	new metekst_global[256];
	if(sscanf(cmdtext, "s[256]", metekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby napisaæ {88b711}newsa{DEDEDE} wpisz:{88b711} /live [treœæ]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(metekst_global);
	new ilosc_znakow = strlen(metekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(metekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(metekst_global[nowy] == '~' || metekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisana wiadomoœæ jest {88b711}nie{DEDEDE} poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(blad != 1)
	{
		format(metekst_global, sizeof(metekst_global), " ~r~~h~LS Live (%s): ~w~ %s", ZmianaNicku(playerid), metekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, metekst_global);
		SNINFO = 2*60;
	}
	return 1;
}