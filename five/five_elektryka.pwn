AntiDeAMX();

forward ZaladujElektryke();
public ZaladujElektryke()
{
	new result[1024], i = 0;
    format(zapyt, sizeof(zapyt), "SELECT * FROM `five_elektryka`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
    	sscanf(result, "p<|>{d}d", uid);
		sscanf(result,  "p<|>{dd}ds[500]",NieruchomoscInfo[uid][nBezpiecznik], NieruchomoscInfo[uid][nElektryka]);
		i++;
	}
	mysql_free_result();
	//printf("Elektryka       - %d", i);
}
forward ZapiszElektryke(uid);
public ZapiszElektryke(uid)
{
	strdel(zapyt, 0, 1024);
	format(zapyt, sizeof(zapyt), "UPDATE `five_elektryka` SET `INSTALACJA` = '%s', `BEZPIECZNIK` = '%d' WHERE `ID_NIERUCHOMOSCI` = '%d'",
	NieruchomoscInfo[uid][nElektryka],
	NieruchomoscInfo[uid][nBezpiecznik],
	uid);
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();
	return 1;
}
CMD:swiatlo(playerid, params[])
{
	//printf("U¿yta komenda swiatlo");
	if(AntySpam[playerid][0] == 1)
	{
		return 0;
	}
	AntySpam[playerid][0] = 1;
	SetTimerEx("SpamKomend1",10000,0,"d",playerid);
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(NieruchomoscInfo[vw][nElektryka][0] > 0)
		{
			if(!SwiatloBudynku(vw, playerid))
			{
				if(!MontowanieElektryki(playerid))
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz uprawnieñ do {88b711}W³¹czania/Wy³¹czania{DEDEDE} œwiat³a w tym Budynku!", "Zamknij", "");
					return 0;
				}
			}
			if(DaneGracza[playerid][gZarzadzajElektryka] != vw && MontowanieElektryki(playerid) && DaneGracza[playerid][gUID] != NieruchomoscInfo[vw][nWlascicielP] && !SwiatloBudynku(vw, playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zarz¹dzaæ {88b711}elektryk¹{DEDEDE} w tym budynku, oferuj wlaœcicielowi \"{88b711}Zarz¹dzanie instalacja elektryczna{DEDEDE}\"", "Zamknij", "");
				return 0;
			}
			new id_wlacznika = PrzyObiekcie(playerid, 364, 3);
			if(id_wlacznika != 0)
			{
				new ilosc_znakow, od=0, dooo=0, poprawnosc_instalacja[15], znacznik[50], nrzn=0, blad=0;
				ilosc_znakow = strlen(NieruchomoscInfo[vw][nElektryka]);
				for(new i = 0; i< ilosc_znakow; i++)
				{
					if(NieruchomoscInfo[vw][nElektryka][i] == '|')
					{
						dooo = i;
						new obecnie[100], dlugosc_obecnie, poprawnosc1[3], poprawnosc2[3], poprawnosc3[3], poprawnosc4[3], poprawnosc5[3], nr1=0, nr2=0, nr3=0, nr4=0, nr5=0, obecne_i = 600, s=0, s2=0, k=0, x=0;
						strmid(obecnie, NieruchomoscInfo[vw][nElektryka], od, dooo);
						dlugosc_obecnie = strlen(obecnie);
						for(new j = 0; j < dlugosc_obecnie; j++)
						{
							if(obecnie[j] == 'K')
							{
								poprawnosc1[nr1] = 1;
								poprawnosc2[nr2] = 1;
								poprawnosc3[nr3] = 1;
								nr1++;
								nr2++;
								nr3++;
								k++;
							}
							else if(obecnie[j] == 'P')
							{
								poprawnosc1[nr1] = 1;
								nr1++;
							}
							else if(obecnie[j] == 'X')
							{
								poprawnosc1[nr1] = 1;
								poprawnosc2[nr2] = 1;
								poprawnosc4[nr4] = 1;
								nr1++;
								nr2++;
								nr4++;
								x++;
							}
							else if(obecnie[j] == 'N')
							{
								poprawnosc2[nr2] = 1;
								nr2++;
							}
							else if(obecnie[j] == 'L')
							{
								poprawnosc3[nr3] = 1;
								poprawnosc4[nr4] = 1;
								poprawnosc5[nr5] = 1;
								nr3++;
								nr4++;
								nr5++;
							}
							else if(obecnie[j] == 'S')
							{
								new z=0;
								z = j + 1;
								znacznik[nrzn] = obecnie[z];
								if(obecne_i == i)
								{
									new nrznm = nrzn-1;
									if(znacznik[nrzn] == znacznik[nrznm])
									{
										blad = 1;
									}
								}
								if(s == 0)
								{
									poprawnosc3[nr3] = 1;
									nr3++;
									s++;
								}
								if(s2 == 0)
								{
									poprawnosc4[nr4] = 1;
									nr4++;
									s2++;
								}
								obecne_i = i;
								poprawnosc5[nr5] = 1;
								nr5++;
								nrzn++;
							}
						}
						if(poprawnosc1[2] > 0)
						{
							poprawnosc_instalacja[0] = 1;//Poprawne kable uziemienia
						}
						if(poprawnosc2[2] > 0)
						{
							poprawnosc_instalacja[1] = 1;//Poprawne kable Neutralne
						}
						if(poprawnosc3[2] > 0)
						{
							poprawnosc_instalacja[2] = 1;//Poprawne kable do w³¹cznika
						}
						if(poprawnosc4[2] > 0)
						{
							poprawnosc_instalacja[3] = 1;//Poprawne kable do lampy
						}
						if(poprawnosc5[2] > 0)
						{
							poprawnosc_instalacja[4] = 1;//Poprawne kable od w³¹cznika do w³¹cznika
						}
						if(k > 1)
						{
							poprawnosc_instalacja[5] = 1;//Zrobione zwarcie, ma wywalic korki!
						}
						if(x > 1)
						{
							poprawnosc_instalacja[5] = 1;//Zrobione zwarcie, ma wywalic korki!
						}
						od = i+1;
					}
				}
				if(poprawnosc_instalacja[5] == 1 && NieruchomoscInfo[vw][nBezpiecznik] == 1)
				{
					new wywal_bezpiecznik[256];
					format(wywal_bezpiecznik, sizeof(wywal_bezpiecznik), "**Bezpieczniki w tej Nieruchomoœci zosta³y wy³¹czone, powodem tej czynnosci jest zwarcie w po³¹czeniach Elektrycznych**");
					SendPlayerText(15.0, playerid, wywal_bezpiecznik, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
					NieruchomoscInfo[vw][nBezpiecznik] = 0;
					WylaczSwiatlo(vw, playerid);
					ZapiszElektryke(vw);
				}
				else if(poprawnosc_instalacja[0] != 0 && poprawnosc_instalacja[1] != 0 && poprawnosc_instalacja[2] != 0  && poprawnosc_instalacja[3] != 0 && poprawnosc_instalacja[4] != 0)
				{
					new znacznik_numer[500], poprawnosc_znacznika_x3[50], poprawnosc_znacznika_x4[50], nrznacznika=0, nrznacznika2=0;
					new ilosc_znacznikow = strlen(znacznik);
					for(new i=0; i < ilosc_znacznikow; i++)
					{
						new nr_zapisu = znacznik[i]-1;
						znacznik_numer[nr_zapisu]++;
						if(znacznik_numer[nr_zapisu] >= 4)
						{
							poprawnosc_znacznika_x4[nrznacznika2] = 1;
							nrznacznika2++;
						}
						else if(znacznik_numer[nr_zapisu] == 3)
						{	
							poprawnosc_znacznika_x3[nrznacznika] = 1;
							znacznik[nrznacznika] = nr_zapisu+1;
							nrznacznika++;
						}
					}
					if(poprawnosc_znacznika_x3[0] == 1 && poprawnosc_znacznika_x3[1] == 1 && poprawnosc_znacznika_x3[2] == 1 && poprawnosc_znacznika_x4[0] == 1 && blad == 0)
					{
						if(NieruchomoscInfo[vw][nBezpiecznik] != 0)
						{
							new ilosc_wlacznikow = strlen(znacznik);
							new porownanie_tekst_global2[256], blad_znacznika = 1;
							format(porownanie_tekst_global2, sizeof(porownanie_tekst_global2), "S%d", ObiektInfo[id_wlacznika][objWlacznik]);
							for(new i = 0; i < ilosc_wlacznikow; i++)
							{
								format(tekst_global, sizeof(tekst_global), "S%c", znacznik[i]);
								if(ComparisonString(tekst_global, porownanie_tekst_global2))
								{
									blad_znacznika = 0;
									break;
								}
							}
							if(blad_znacznika != 1)
							{
								WlaczSwiatlo(vw, playerid);
							}
						}
					}
					else if(poprawnosc_znacznika_x3[0] == 1 && poprawnosc_znacznika_x3[1] == 1 && blad == 0)
					{
						new porownanie_tekst_global[256], porownanie_tekst_global2[256], porownanie_tekst_global22[256];
						format(porownanie_tekst_global, sizeof(porownanie_tekst_global), "S%c", znacznik[0]);
						format(porownanie_tekst_global22, sizeof(porownanie_tekst_global22), "S%c", znacznik[1]);
						format(porownanie_tekst_global2, sizeof(porownanie_tekst_global2), "S%d", ObiektInfo[id_wlacznika][objWlacznik]);
						if(NieruchomoscInfo[vw][nBezpiecznik] != 0 && ComparisonString(porownanie_tekst_global, porownanie_tekst_global2) || NieruchomoscInfo[vw][nBezpiecznik] != 0 && ComparisonString(porownanie_tekst_global2, porownanie_tekst_global22) )
						{
							WlaczSwiatlo(vw, playerid);
						}
					}
				}
				else if(poprawnosc_instalacja[0] != 0 && poprawnosc_instalacja[1] != 0 && poprawnosc_instalacja[2] != 0 && poprawnosc_instalacja[3] != 0)
				{
					if(znacznik[0] == znacznik[1] && blad == 0)
					{
						new porownanie_tekst_global[256], porownanie_tekst_global2[256];
						format(porownanie_tekst_global, sizeof(porownanie_tekst_global), "S%c", znacznik[0]);
						format(porownanie_tekst_global2, sizeof(porownanie_tekst_global2), "S%d", ObiektInfo[id_wlacznika][objWlacznik]);
						if(NieruchomoscInfo[vw][nBezpiecznik] != 0 && ComparisonString(porownanie_tekst_global, porownanie_tekst_global2))
						{
							WlaczSwiatlo(vw, playerid);
						}
					}
				}
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz sie obok {88b711}w³¹cznika{DEDEDE} pr¹du!", "Zamknij", "");
				return 1;
			}
		}
		else if(DaneGracza[playerid][gZarzadzajElektryka] != vw && MontowanieElektryki(playerid) && DaneGracza[playerid][gUID] != NieruchomoscInfo[vw][nWlascicielP] && !SwiatloBudynku(vw, playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zarz¹dzaæ {88b711}elektryk¹{DEDEDE} w tym budynku, oferuj wlaœcicielowi \"{88b711}Zarz¹dzanie instalacja elektryczna{DEDEDE}\"", "Zamknij", "");
			return 0;
		}
		else if(OwnerDzialalnosci(vw, playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W tym budynku {88b711}nie{DEDEDE} ma ¿adnych instalacji elektrycznych!\nWezwij {88b711}Elektryka{DEDEDE} który pod³¹czy ci {88b711}Licznik/Bezpieczniki{DEDEDE} oraz {88b711}W³¹czniki Œwiat³a{DEDEDE}.", "Zamknij", "");
			return 1;
		}
	}
	return 1;
}

CMD:polacz(playerid, params[])
{
	//printf("U¿yta komenda polacz");
	strtoupper(params);
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(!NalezyDoDzialalnosci(playerid, DZIALALNOSC_ELEKTRTYKA))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz ³¹czyæ przewodów elektrycznych poniewa¿ nie nalezysz do Biznesu \"Elektryka\"!", "Zamknij", "");
			return 0;
		}
		if(!MontowanieElektryki(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz uprawnieñ do ³¹czenia przewodów elektrycznych!", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gZarzadzajElektryka] != vw)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zarz¹dzaæ elektryk¹ w tym budynku, oferuj wlaœcicielowi \"Zarz¹dzanie instalacja elektryczna\"", "Zamknij", "");
			return 0;
		}
		new	kom1[10], kom2[10], kom3[10];
		if(sscanf(params, "s[10]s[10]s[10]", kom1, kom2, kom3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{88b711}[PodpowiedŸ]:{DEDEDE} u¿yj /polacz [S1, X, K] [L, N, PE] [K, X, S1]", "Zamknij", "");
			return 1;
		}
		else
		{
			new cala_komenda[250], kom1s[10], kom2s[10];
			format(cala_komenda, 250, "%s %s %s", kom1, kom2, kom3);
			format(kom1s, 10, "%s", kom1);
			format(kom2s, 10, "%s", kom3);
			if(ObiektwBudynku(playerid, 1958, vw) !=0)
			{
				new id_obiektu = ObiektwBudynku(playerid, 364, vw);
				if(id_obiektu !=0)
				{
					if(strfind(kom2, "N", true) == -1 && strfind(kom2, "L", true) == -1 && strfind(kom2, "PE", true) == -1 )
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jeden z wybranych kabli nie jest poprawny!", "Zamknij", "");
						return 1;
					}
					else
					{
					//	if(ComparisonString(kom1, kom3) && NieruchomoscInfo[vw][nBezpiecznik] == 1 &&  ComparisonString(kom2, "L")|| ComparisonString(kom1, "K") && ComparisonString(kom3, "X") && NieruchomoscInfo[vw][nBezpiecznik] == 1  &&  ComparisonString(kom2, "L")|| ComparisonString(kom1, "X") && ComparisonString(kom3, "K") && NieruchomoscInfo[vw][nBezpiecznik] == 1 && ComparisonString(kom2, "L"))
						if(NieruchomoscInfo[vw][nBezpiecznik] == 1)
						{
							GameTextForPlayer(playerid, "~r~Zostales porazony pradem!", 7000, 5);
							//BW(playerid, 1);
							//DaneGracza[playerid][gBW] = 1;
							//ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4, 1, 0, 0, 1, 1, 1);
							//SetPVarInt(playerid, "PlayAnim", 1);
							new wywal_bezpiecznik[256];
							format(wywal_bezpiecznik, sizeof(wywal_bezpiecznik), "**Bezpieczniki w tej Nieruchomoœci zosta³y wy³¹czone, powodem tej czynnosci jest zwarcie w po³¹czeniach Elektrycznych**");
							SendPlayerText(15.0, playerid, wywal_bezpiecznik, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
							NieruchomoscInfo[vw][nBezpiecznik] = 0;
							WylaczSwiatlo(vw, playerid);
							ZapiszElektryke(vw);
							return 0;
						}
						else
						{
							if(strfind(kom1, "S", true) != -1 || strfind(kom3, "S", true) != -1)
							{
								new znaki = strlen(kom1), znaki2 = strlen(kom3), poprawnosc_wlacznika[2];
								if(strfind(kom1, "S", true) != -1 && strfind(kom3, "S", true) != -1)
								{
									if(znaki >= 2 && znaki2 >= 2)
									{
										poprawnosc_wlacznika[0] = 1;
										poprawnosc_wlacznika[1] = 1;
									}
									else
									{
										dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Numer w³¹cznika jest niepoprawny! Poprawna wartoœæ to np. {88b711}S1{DEDEDE}, {88b711}S2", "Zamknij", "");
										return 1;
									}
								}
								else
								{
									if(strfind(kom1, "S", true) != -1 && znaki >= 2)
									{
										 poprawnosc_wlacznika[0] = 1;
									}
									else if(strfind(kom3, "S", true) != -1 && znaki2 >= 2)
									{
										 poprawnosc_wlacznika[1] = 1;
									}
									else
									{
										dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Numer w³¹cznika jest niepoprawny! Poprawna wartoœæ to np: {88b711}S1{DEDEDE}, {88b711}S2", "Zamknij", "");
										return 1;
									}
								}
								new sprawdz_poprawnosc_wszystkich[2];
								sprawdz_poprawnosc_wszystkich[0] = 1;
								sprawdz_poprawnosc_wszystkich[1] = 1;
								if(poprawnosc_wlacznika[0] == 1)
								{
									strdel(kom1, 0, 1);
									new znacznik = strval(kom1);
									if(SprawdzWlacznik(playerid, vw, znacznik) != 0)
									{
										sprawdz_poprawnosc_wszystkich[0] = 1;
									}
									else
									{
										sprawdz_poprawnosc_wszystkich[0] = 0;
									}
								}
								if(poprawnosc_wlacznika[1] == 1)
								{
									strdel(kom3, 0, 1);
									new znacznik3 = strval(kom3);
									if(SprawdzWlacznik(playerid, vw, znacznik3) != 0)
									{
										sprawdz_poprawnosc_wszystkich[1] = 1;
									}
									else
									{
										sprawdz_poprawnosc_wszystkich[1] = 0;
									}
								}
								if(sprawdz_poprawnosc_wszystkich[0] == 1 && sprawdz_poprawnosc_wszystkich[1] == 1)
								{
									new ilosc_znakow = strlen(NieruchomoscInfo[vw][nElektryka]), ilosc_k = 0, ilosc_x = 0, ilosc_s1= 0, ilosc_s2, mozliwe1 = 1, mozliwe2 = 1;
									for(new i = 0; i < ilosc_znakow; i++)
									{
										if(NieruchomoscInfo[vw][nElektryka][i] == 'K' && kom1s[0] == 'K' || NieruchomoscInfo[vw][nElektryka][i] == 'K' && kom2s[0] == 'K')
										{
											ilosc_k++;
										}
										else if(NieruchomoscInfo[vw][nElektryka][i] == 'X' && kom1s[0] == 'X' || NieruchomoscInfo[vw][nElektryka][i] == 'X' && kom2s[0] == 'X')
										{
											ilosc_x++;
										}
										else if(NieruchomoscInfo[vw][nElektryka][i] == 'S')
										{
											new nowy_nr = i + 1;
											new baza_instalacje[200];
											format(baza_instalacje, sizeof(baza_instalacje), "%c", NieruchomoscInfo[vw][nElektryka][nowy_nr]);
											new znacznik_w_bazie = strval(baza_instalacje);
											new znacznik_int1 = strval(kom1);
											new znacznik_int2 = strval(kom3);
											if(znacznik_w_bazie == znacznik_int1)
											{
												new zna = strval(kom1);
												new id_obiektu_s = SprawdzWartoscWlacznika(playerid, 364, vw, zna);
												if(id_obiektu_s != 0)
												{
													new wartosc_wlacznika = ObiektInfo[id_obiektu_s][objWartosc];
													switch(wartosc_wlacznika)
													{
														case 1:{
															mozliwe1 = 2;
														}
														case 2:{
															mozliwe1 = 3;
														}
														case 3:{
															mozliwe1 = 3;
														}
														case 4:{
															mozliwe1 = 4;
														}
													}
												}
												ilosc_s1++;
											}
											else if(znacznik_w_bazie == znacznik_int2)
											{
												new zna = strval(kom3);
												new id_obiektu_s = SprawdzWartoscWlacznika(playerid, 364, vw, zna);
												if(id_obiektu_s != 0)
												{
													new wartosc_wlacznika = ObiektInfo[id_obiektu_s][objWartosc];
													switch(wartosc_wlacznika)
													{
														case 1:{
															mozliwe2 = 2;
														}
														case 2:{
															mozliwe2 = 3;
														}
														case 3:{
															mozliwe2 = 3;
														}
														case 4:{
															mozliwe2 = 4;
														}
													}
												}
												ilosc_s2++;
											}
										}
									}
									if(ilosc_k > 6)
									{
										dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Do tego {88b711}Licznika/Bezpiecznika{DEDEDE} nie mo¿na podpi¹æ wiêcej po³¹czeñ!", "Zamknij", "");
										return 1;
									}
									else if(ilosc_x > 6)
									{
										dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Do tej {88b711}lampy{DEDEDE} nie mo¿na {88b711}podpi¹æ{DEDEDE} wiêcej po³¹czeñ!", "Zamknij", "");
										return 1;
									}
									else if(ilosc_s1 >= mozliwe1 || ilosc_s2 >= mozliwe2)
									{
										dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Do tego {88b711}w³¹cznika{DEDEDE} nie mo¿na {88b711}podpi¹æ{DEDEDE} wiêcej po³¹czeñ!", "Zamknij", "");
										return 1;
									}
									else
									{
										format(NieruchomoscInfo[vw][nElektryka], 500, "%s%s|", NieruchomoscInfo[vw][nElektryka], cala_komenda);
										ZapiszElektryke(vw);
										new potwierdzenie[256];
										format(potwierdzenie, sizeof(potwierdzenie), "{DEDEDE}Poprawnie {88b711}po³¹czono{DEDEDE} po³¹czenie \"{88b711}%s{DEDEDE}\"", cala_komenda);
										dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", potwierdzenie, "Zamknij", "");
										return 1;
									}
								}
								else
								{
									dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jeden z {88b711}w³¹czników{DEDEDE} do których chcesz {88b711}po³¹czyæ{DEDEDE} kable, nie istnieje!", "Zamknij", "");
									return 1;
								}
							}
							else if(strfind(kom1, "K", true) != -1 || strfind(kom3, "X", true) != -1 || strfind(kom1, "X", true) != -1 || strfind(kom3, "K", true) != -1)
							{
								new ilosc_znakow = strlen(NieruchomoscInfo[vw][nElektryka]), ilosc_k = 0, ilosc_x = 0;
								for(new i = 0; i < ilosc_znakow; i++)
								{
									if(NieruchomoscInfo[vw][nElektryka][i] == 'K')
									{
										ilosc_k++;
									}
									else if(NieruchomoscInfo[vw][nElektryka][i] == 'X')
									{
										ilosc_x++;
									}
								}
								if(ilosc_k > 6)
								{
									dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Do tego {88b711}Licznika/Bezpiecznika{DEDEDE} nie mo¿na {88b711}podpi¹æ{DEDEDE} wiêcej po³¹czeñ!", "Zamknij", "");
									return 1;
								}
								else if(ilosc_x > 6)
								{
									dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Do tej {88b711}lapmy{DEDEDE} nie mo¿na {88b711}podpi¹æ{DEDEDE} wiêcej po³¹czeñ!", "Zamknij", "");
									return 1;
								}
								else
								{
									format(NieruchomoscInfo[vw][nElektryka], 500, "%s%s %s %s|", NieruchomoscInfo[vw][nElektryka], kom1, kom2, kom3);
									ZapiszElektryke(vw);
									new potwierdzenie[256];
									format(potwierdzenie, sizeof(potwierdzenie), "{DEDEDE}Poprawnie {88b711}po³¹czono{DEDEDE} po³¹czenie \"{88b711}%s{DEDEDE}\"", cala_komenda);
									dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", potwierdzenie, "Zamknij", "");
									return 1;
								}
							}
							else
							{
								dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jeden z {88b711}znaczników{DEDEDE} do których chcesz {88b711}po³¹czyæ{DEDEDE} kable, nie istnieje!", "Zamknij", "");
								return 1;
							}
						}
					}
				}
				else
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W tym {88b711}budynku{DEDEDE} nie ma zamontowanego {88b711}W³¹cznika Pr¹du{DEDEDE}!", "Zamknij", "");
					return 1;
				}
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W tym {88b711}budynku{DEDEDE} nie ma zamontowanego {88b711}Licznika/Bezpieczników Pr¹du{DEDEDE}!", "Zamknij", "");
				return 1;
			}
		}
	}
	return 1;
}
CMD:odlacz(playerid, params[])
{
	//printf("U¿yta komenda odlacz");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(!NalezyDoDzialalnosci(playerid, DZIALALNOSC_ELEKTRTYKA))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz {88b711}od³¹czaæ{DEDEDE} przewodów elektrycznych poniewa¿ nie nalezysz do Biznesu \"{88b711}Elektryka{DEDEDE}\"!", "Zamknij", "");
			return 0;
		}
		if(!MontowanieElektryki(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz {88b711}uprawnieñ{DEDEDE} do od³¹czania {88b711}przewodów{DEDEDE} elektrycznych!", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gZarzadzajElektryka] != vw)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zarz¹dzaæ {88b711}elektryk¹{DEDEDE} w tym budynku, oferuj wlaœcicielowi \"{88b711}Zarz¹dzanie instalacja elektryczna{DEDEDE}\"", "Zamknij", "");
			return 0;
		}
		new	kom1[10], kom2[10], kom3[10];
		if(sscanf(params, "s[10]s[10]s[10]", kom1, kom2, kom3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}od³¹czyæ{DEDEDE} przewody wpisz: {88b711}/odlacz [S1, X, K] [L, N, PE] [K, X, S1]", "Zamknij", "");
			return 1;
		}
		else
		{
			new calosc[250], calosc2[250];
			if(NieruchomoscInfo[vw][nBezpiecznik] == 1)
			{
				GameTextForPlayer(playerid, "~r~Zostales porazony pradem!", 7000, 5);
				//BW(playerid, 1);
				//DaneGracza[playerid][gBW] = 1;
				//ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4, 1, 0, 0, 1, 1, 1);
				//SetPVarInt(playerid, "PlayAnim", 1);
				new wywal_bezpiecznik[256];
				format(wywal_bezpiecznik, sizeof(wywal_bezpiecznik), "**Bezpieczniki w tej Nieruchomoœci zosta³y wy³¹czone, powodem tej czynnosci jest zwarcie w po³¹czeniach Elektrycznych**");
				SendPlayerText(15.0, playerid, wywal_bezpiecznik, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
				NieruchomoscInfo[vw][nBezpiecznik] = 0;
				WylaczSwiatlo(vw, playerid);
				ZapiszElektryke(vw);
				return 0;
			}
			format(calosc, 250, "%s %s %s", kom1, kom2, kom3);
			format(calosc2, 250, "%s %s %s", kom3, kom2, kom1);
			new ilosc_znakow = strfind(NieruchomoscInfo[vw][nElektryka], calosc, true);
			new ilosc_znakow2 = strfind(NieruchomoscInfo[vw][nElektryka], calosc2, true);
			if(ilosc_znakow != -1 || ilosc_znakow2 != -1)
			{
				new wiadomosc[256], ilosc_do_usuniecia = ilosc_znakow, ilosc_znakow_polaczenia;
				ilosc_znakow_polaczenia = strlen(calosc);
				ilosc_znakow_polaczenia += ilosc_do_usuniecia;
				ilosc_znakow_polaczenia += 1;
				strdel(NieruchomoscInfo[vw][nElektryka], ilosc_do_usuniecia, ilosc_znakow_polaczenia);
				format(wiadomosc, sizeof(wiadomosc), "{DEDEDE}Poprawnie {88b711}od³¹czono{DEDEDE} po³¹czenie \"{88b711}%s{DEDEDE}\"", calosc);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", wiadomosc, "Zamknij", "");
				ZapiszElektryke(vw);
				return 1;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Po³¹czenie o podanych {88b711}parametrach{DEDEDE} nie istanieje!", "Zamknij", "");
				return 1;
			}
		}
	}
	return 1;
}
CMD:bezpiecznik(playerid, params[])
{
	//printf("U¿yta komenda bezpiecznik");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(!SwiatloBudynku(vw, playerid))
		{
			if(!MontowanieElektryki(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz uprawnieñ do {88b711}W³¹czania/Wy³¹czania{DEDEDE} Bezpieczników w tym Budynku!", "Zamknij", "");
				return 0;
			}
		}
		if(DaneGracza[playerid][gZarzadzajElektryka] != vw && MontowanieElektryki(playerid) && DaneGracza[playerid][gUID] != NieruchomoscInfo[vw][nWlascicielP] && !SwiatloBudynku(vw, playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zarz¹dzaæ {88b711}elektryk¹{DEDEDE} w tym budynku, oferuj wlaœcicielowi \"{88b711}Zarz¹dzanie instalacja elektryczna{DEDEDE}\"", "Zamknij", "");
			return 0;
		}
		if(PrzyObiekcie(playerid, 1958, 3) != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_BEZPIECZNIK, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wybierz jedn¹ z poni¿szych opcji aby {88b711}w³¹czyæ/wy³¹czyæ{DEDEDE} Bezpiecznik", "W³¹cz", "Wy³¹cz");
			return 1;
		}
	}
	return 1;
}
CMD:polaczenia(playerid, params[])
{
	//printf("U¿yta komenda olaczenia");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(!NalezyDoDzialalnosci(playerid, DZIALALNOSC_ELEKTRTYKA))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz zobaczyæ {88b711}przewodów{DEDEDE} elektrycznych poniewa¿ nie nalezysz do Biznesu \"{88b711}Elektryka{DEDEDE}\"!", "Zamknij", "");
			return 0;
		}
		if(!MontowanieElektryki(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz {88b711}uprawnieñ{DEDEDE} do przegl¹dania przewodów elektrycznych!", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gZarzadzajElektryka] != vw)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zarz¹dzaæ {88b711}elektryk¹{DEDEDE} w tym budynku, oferuj wlaœcicielowi \"{88b711}Zarz¹dzanie instalacja elektryczna{DEDEDE}\"", "Zamknij", "");
			return 0;
		}
		new id_wlacznika = PrzyObiekcie(playerid, 364, 3);
		new id_licznika = PrzyObiekcie(playerid, 1958, 3);
		if(id_wlacznika != 0)
		{
			new ilosc_znakow, od=0, dooo=0, polaczenia_l[400];
			ilosc_znakow = strlen(NieruchomoscInfo[vw][nElektryka]);
			for(new i = 0; i< ilosc_znakow; i++)
			{
				if(NieruchomoscInfo[vw][nElektryka][i] == '|')
				{
					dooo = i;
					new obecnie[100], dlugosc_obecnie, kabel[20], pol_z[20];
					strmid(obecnie, NieruchomoscInfo[vw][nElektryka], od, dooo);
					dlugosc_obecnie = strlen(obecnie);
					for(new j = 0; j < dlugosc_obecnie; j++)
					{
						if(obecnie[j] == 'S')
						{
							new nr = j+1, nr2 = j+2, nr3 = j+3;
							new wlacznik_jest[250], wlacznik_nie[250], wlacznik_ew[120];
							strmid(wlacznik_ew, obecnie, nr2, nr3);
							format(wlacznik_jest, sizeof(wlacznik_jest), "S%d", ObiektInfo[id_wlacznika][objWlacznik]);
							if(ComparisonString(wlacznik_ew, " "))
							{
								format(wlacznik_nie, sizeof(wlacznik_nie), "S%c", obecnie[nr]);
							}
							else
							{
								format(wlacznik_nie, sizeof(wlacznik_nie), "S%c%s", obecnie[nr], wlacznik_ew);
							}
							if(ComparisonString(wlacznik_jest, wlacznik_nie))
							{
								if(strfind(obecnie, "L", true) != -1)
								{
									kabel = "L";
								}
								else if(strfind(obecnie, "N", true) != -1)
								{
									kabel = "N";
								}
								else if(strfind(obecnie, "PE", true) != -1)
								{
									kabel = "PE";
								}
								new obecnie_s[120], nr_s = j+1;
								strmid(obecnie_s, obecnie, nr_s, dlugosc_obecnie);
								new ilosc = strfind(obecnie_s, "S", true);
								new obecnie_s1[120], nr_s1 = j-1;
								strmid(obecnie_s1, obecnie, 0, nr_s1);
								new iloscs = strfind(obecnie_s1, "S", true);
								if(strfind(obecnie, "X", true) != -1)
								{
									pol_z = "X";
								}
								else if(strfind(obecnie, "K", true) != -1)
								{
									pol_z = "K";
								}
								else if(ilosc != -1)
								{
									new numer[120], numer2[120], ilosc2 = ilosc+1, ilosc3 = ilosc+2, ilosc4 = ilosc+3;
									if(iloscs != -1)
									{
										
									}
									strmid(numer2, obecnie_s, ilosc3, ilosc4);
									strmid(numer, obecnie_s, ilosc2, ilosc3);
									if(ComparisonString(numer2, " "))
									{
										format(pol_z, sizeof(pol_z), "S%s", numer);
									}
									else
									{
										format(pol_z, sizeof(pol_z), "S%s%s", numer, numer2);
									}
								}
								else if(iloscs != -1)
								{
									new numer[120], numer2[120], ilosc2s = iloscs+1, ilosc3s = iloscs+2, ilosc4s = iloscs+3;
									strmid(numer2, obecnie_s1, ilosc3s, ilosc4s);
									strmid(numer, obecnie_s1, ilosc2s, ilosc3s);
									if(ComparisonString(numer2, " "))
									{
										format(pol_z, sizeof(pol_z), "S%s", numer);
									}
									else
									{
										format(pol_z, sizeof(pol_z), "S%s%s", numer, numer2);
									}
								}
								format(polaczenia_l, sizeof(polaczenia_l), "%s~r~Polaczenie z ~w~%s ~r~kablem ~w~%s~n~",polaczenia_l, pol_z, kabel);
							}
						}
					}
					od = i+1;
				}
			}
			new typ_wlacznika[250];
			switch(ObiektInfo[id_wlacznika][objWartosc])
			{
				case 1:{
					typ_wlacznika = "Jednobiegunowy";
				}
				case 2:{
					typ_wlacznika = "Dwubiegunowy";
				}
				case 3:{
					typ_wlacznika = "Schodowy";
				}
				case 4:{
					typ_wlacznika = "Krzyzowy";
				}
			}
			if(!polaczenia_l[0])
			{
				format(polaczenia_l, sizeof(polaczenia_l), "%s~r~Brak polaczen z tym wlacznikiem~n~");
			}
			strdel(tekst_global, 0, 2048);
			format(tekst_global, sizeof(tekst_global), "~y~Wlacznik %s S%d~n~~n~%s",typ_wlacznika,
			ObiektInfo[id_wlacznika][objWlacznik],polaczenia_l);
			TextDrawSetString(OBJ[playerid], tekst_global);
			TextDrawShowForPlayer(playerid, OBJ[playerid]);
			SetTimerEx("NapisUsunsV",15000,0,"d",playerid);
		}
		else if(id_licznika != 0)
		{
			new ilosc_znakow, od=0, dooo=0, polaczenia_l[400];
			ilosc_znakow = strlen(NieruchomoscInfo[vw][nElektryka]);
			for(new i = 0; i< ilosc_znakow; i++)
			{
				if(NieruchomoscInfo[vw][nElektryka][i] == '|')
				{
					dooo = i;
					new obecnie[100], dlugosc_obecnie, kabel[20], pol_z[20];
					strmid(obecnie, NieruchomoscInfo[vw][nElektryka], od, dooo);
					dlugosc_obecnie = strlen(obecnie);
					for(new j = 0; j < dlugosc_obecnie; j++)
					{
						if(obecnie[j] == 'K')
						{
							new obecnie_k2[250], nr2=j+1;
							strmid(obecnie_k2, obecnie, nr2, dlugosc_obecnie);
							new ilosck = strfind(obecnie_k2, "K", true);
							if(strfind(obecnie, "L", true) != -1)
							{
								kabel = "L";
							}
							else if(strfind(obecnie, "N", true) != -1)
							{
								kabel = "N";
							}
							else if(strfind(obecnie, "PE", true) != -1)
							{
								kabel = "PE";
							}
							new ilosc = strfind(obecnie, "S", true);
							if(strfind(obecnie, "X", true) != -1)
							{
								pol_z = "X";
							}
							else if(ilosc != -1)
							{
								new numer[120], numer2[120], ilosc2 = ilosc+1, ilosc3 = ilosc+2, ilosc4 = ilosc+3;
								strmid(numer2, obecnie, ilosc3, ilosc4);
								strmid(numer, obecnie, ilosc2, ilosc3);
								if(ComparisonString(numer2, " "))
								{
									format(pol_z, sizeof(pol_z), "S%s", numer);
								}
								else
								{
									format(pol_z, sizeof(pol_z), "S%s%s", numer, numer2);
								}
							}
							else if(ilosck >= 0)
							{
								pol_z = "K";
								j += ilosck;
								j +=1;
							}
							format(polaczenia_l, sizeof(polaczenia_l), "%s~r~Polaczenie z ~w~%s ~r~kablem ~w~%s~n~",polaczenia_l, pol_z, kabel);
						}
					}
					od = i+1;
				}
			}
			if(!polaczenia_l[0])
			{
				format(polaczenia_l, sizeof(polaczenia_l), "%s~r~Brak polaczen z tym Licznikiem/Bezpiecznikiem~n~");
			}
			format(tekst_global, sizeof(tekst_global), "~y~Licznik/Bezpiecznik K~n~~n~%s",polaczenia_l);
			TextDrawSetString(OBJ[playerid], tekst_global);
			TextDrawShowForPlayer(playerid, OBJ[playerid]);
			SetTimerEx("NapisUsunsV",30000,0,"d",playerid);
		}
		else
		{
			new ilosc_znakow, od=0, dooo=0, polaczenia_l[400];
			ilosc_znakow = strlen(NieruchomoscInfo[vw][nElektryka]);
			for(new i = 0; i< ilosc_znakow; i++)
			{
				if(NieruchomoscInfo[vw][nElektryka][i] == '|')
				{
					dooo = i;
					new obecnie[100], dlugosc_obecnie, kabel[20], pol_z[20];
					strmid(obecnie, NieruchomoscInfo[vw][nElektryka], od, dooo);
					dlugosc_obecnie = strlen(obecnie);
					for(new j = 0; j < dlugosc_obecnie; j++)
					{
						if(obecnie[j] == 'X')
						{
							new obecnie_k2[250], nr2=j+1;
							strmid(obecnie_k2, obecnie, nr2, dlugosc_obecnie);
							new ilosck = strfind(obecnie_k2, "X", true);
							if(strfind(obecnie, "L", true) != -1)
							{
								kabel = "L";
							}
							else if(strfind(obecnie, "N", true) != -1)
							{
								kabel = "N";
							}
							else if(strfind(obecnie, "PE", true) != -1)
							{
								kabel = "PE";
							}
							new ilosc = strfind(obecnie, "S", true);
							if(strfind(obecnie, "K", true) != -1)
							{
								pol_z = "K";
							}
							else if(ilosc != -1)
							{
								new numer[120], numer2[120], ilosc2 = ilosc+1, ilosc3 = ilosc+2, ilosc4 = ilosc+3;
								strmid(numer2, obecnie, ilosc3, ilosc4);
								strmid(numer, obecnie, ilosc2, ilosc3);
								if(ComparisonString(numer2, " "))
								{
									format(pol_z, sizeof(pol_z), "S%s", numer);
								}
								else
								{
									format(pol_z, sizeof(pol_z), "S%s%s", numer, numer2);
								}
							}
							else if(ilosck >= 0)
							{
								pol_z = "X";
								j += ilosck;
								j +=1;
							}
							format(polaczenia_l, sizeof(polaczenia_l), "%s~r~Polaczenie z ~w~%s ~r~kablem ~w~%s~n~",polaczenia_l, pol_z, kabel);
						}
					}
					od = i+1;
				}
			}
			if(!polaczenia_l[0])
			{
				format(polaczenia_l, sizeof(polaczenia_l), "%s~r~Brak polaczen z Lampa~n~");
			}
			strdel(tekst_global, 0, 2048);
			format(tekst_global, sizeof(tekst_global), "~y~Lampa X~n~~n~%s",polaczenia_l);
			TextDrawSetString(OBJ[playerid], tekst_global);
			TextDrawShowForPlayer(playerid, OBJ[playerid]);
			SetTimerEx("NapisUsunsV",30000,0,"d",playerid);
		}
	}
	return 1;
}