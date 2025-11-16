AntiDeAMX();
stock encode_tires(tire1, tire2, tire3, tire4) {

    return tire1 | (tire2 << 1) | (tire3 << 2) | (tire4 << 3);

}
new NazwyAut[212][32] = {
"Landstalker","Bravura","Buffalo","Linerunner","Perenniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana",
"Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat",
"Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks",
"Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral",
"Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy",
"Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic",
"Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina",
"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher",
"Virgo","Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
"RC Goblin","Hotring Racer","Hotring Racer","Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike",
"Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic","Buccaneer","Shamal","Hydra",
"FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck","Willard","Forklift","Tractor",
"Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover","Sadler",
"Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor",
"Monster","Monster","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna",
"Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley",
"Stafford","BF-400","Newsvan","Tug","Trailer","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer","Trailer",
"Andromeda","Dodo","RC Cam","Launch","Police Car","Police Car","Police Car","Police Ranger","Picador","S.W.A.T. Van",
"Alpha","Phoenix","Glendale","Sadler","Luggage Trailer","Luggage Trailer","Stair Trailer","Boxville","Farm Plow","Utility Trailer"};
public OnVehicleSpawn(vehicleid)
{
	KierunkiAwaryjneIn[vehicleid] = false;
	KierunekPrawyOn[vehicleid] = false;
	KierunekLewyOn[vehicleid] = false;
	DestroyObject(KierunekObiekt[vehicleid][0]);
	DestroyObject(KierunekObiekt[vehicleid][1]);
	DestroyObject(KierunekObiekt[vehicleid][2]);
	DestroyObject(KierunekObiekt[vehicleid][3]);
	DestroyObject(KierunekObiekt[vehicleid][4]);
	
	Tuning(vehicleid);
	new uid = SprawdzCarUID(vehicleid);
	if(PojazdInfo[uid][pStan] < 300)
	{
		PojazdInfo[uid][pStan] = 300;
	}
	if(PojazdInfo[uid][pPJ] != -1)
	{
		ChangeVehiclePaintjob(vehicleid, PojazdInfo[uid][pPJ]);
	}
	SetVehicleHealth(vehicleid, PojazdInfo[uid][pStan]);
	//Transakcja(T_SPAWNVEH, -1, -1, -1, -1, -1, uid, vehicleid, PojazdInfo[uid][pStan], "-", gettime()-CZAS_LETNI);
	UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && GetPVarInt(playerid, "Tempomat_Wlaczony") == 1)
	{
		DisableCruiseControl(playerid);
	}
    new vehicleid=GetPlayerVehicleID(playerid);
    new uid = SprawdzCarUID(vehicleid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    TextDrawHideForPlayer(playerid, Licznik[playerid]);
		if(GetPlayerVirtualWorld(playerid) != 0 && NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nAudio] == 1)
		{
			if(GetPVarInt(playerid,"spawn"))
			{
				DeletePVar(playerid,"spawn");
			}
			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nRadio], 0, 0, 0, 14.0, 0);
		}
		else
		{
			StopAudioStreamForPlayer(playerid);
		}
	    RefreshNick(playerid);
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    if(PojazdInfo[uid][pLock] == 1)
	    {
			RemovePlayerFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
			Frezuj(playerid, 0);
			Frezuj(playerid, 1);
	    }
		if(PojazdInfo[uid][pModel] == 574)
		{
			dShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wsiad³eœ do pojazdu, który nale¿y do {88b711}Sprz¹taczy Ulic.\nAby rozpocz¹æ prace musisz zaakceptowaæ zlecenie.", "Akceptuj", "Odrzuæ");
		}
		if((PojazdInfo[uid][pTypPaliwa] == 0 && PojazdInfo[uid][pModel] != 574 && PojazdInfo[uid][pModel] != 509 && PojazdInfo[uid][pModel] != 481 && PojazdInfo[uid][pModel] != 510) && newstate == PLAYER_STATE_DRIVER)
		{
			if(Jednoslady(vehicleid))
			{
				PojazdInfo[uid][pTypPaliwa] = 2;
				ZapiszPojazd(uid, 1);
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_PALIWKO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Wybierz typ paliwa{88b711}:", "{DEDEDE}» {88b711}Diesel\n{DEDEDE}» {88b711}Benzyna", "Wybierz", "Zamknij");
			}
		}
		if(Discman[playerid] == 0)
		{
			if(PojazdInfo[uid][pAudioStream] != 0) 
			{
				if(GetPVarInt(playerid,"spawn"))
				{
					DeletePVar(playerid,"spawn");
				}
				new uids = PojazdInfo[uid][pAudioStream];
				new audio[128];
				format(audio, sizeof(audio), "%s",PrzedmiotInfo[uids][pWar3]);
				PlayAudioStreamForPlayer(playerid, audio, 0, 0, 0, 14.0, 0);
			}
		}
	    if(newstate != PLAYER_STATE_PASSENGER)
		{
		    if(BlokadaVEH(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade prowadzenia pojazdów{DEDEDE} \
				\nJeœli uwa¿asz, ¿e kara zosta³a nadana nies³usznie mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
				RemovePlayerFromVehicle(playerid);
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
			if(PojazdInfo[uid][pModel] != 481 && PojazdInfo[uid][pModel] != 510 && PojazdInfo[uid][pModel] != 509)
			{
			    if(PojazdInfo[uid][pSilnik] == 1)
			    {
			    new str[256];
				strdel(tekst_globals, 0, 2048);
				strdel(str, 0, 256);
				if(PojazdInfo[uid][pTypPaliwa] == 1)
				{
					format(tekst_globals, sizeof(tekst_globals), "Diesel: ~y~%0.01f/%d~w~l",PojazdInfo[uid][pPaliwo],PaliwoIlosc(PojazdInfo[uid][pModel]));
				}
				else
				{
					if(PojazdInfo[uid][pGaz] != 0)
					{
						format(tekst_globals, sizeof(tekst_globals), "Benzyna: ~y~%0.01f/%d~w~l~n~~w~Gaz: ~y~%0.01f/%d~w~dm3",PojazdInfo[uid][pPaliwo],PaliwoIlosc(PojazdInfo[uid][pModel]),PojazdInfo[uid][pPaliwoGaz]);
					}
					else
					{
						format(tekst_globals, sizeof(tekst_globals), "Benzyna: ~y~%0.01f/%d~w~l",PojazdInfo[uid][pPaliwo],PaliwoIlosc(PojazdInfo[uid][pModel]));
					}
				}
			    format(str, sizeof(str), "~n~~p~%s (SQLID %d)~n~~n~~w~%s~n~~w~Stan: ~y~%0.01f ~n~~w~Predkosc: ~y~%d~w~ km/h~n~~w~Przebieg: ~y~%0.01f ~w~ km~n~",
				GetVehicleModelName(PojazdInfo[uid][pModel]),
				PojazdInfo[uid][pUID],
				tekst_globals,
				PojazdInfo[uid][pStan],
				Predkosc(playerid),
				PojazdInfo[uid][pPrzebieg]/1000);
    			TextDrawSetString(Licznik[playerid], str);
				TextDrawShowForPlayer(playerid, Licznik[playerid]);
				}
			}
			if(!Wlascicielpojazdu(vehicleid, playerid))
			{
		    	GameTextForPlayer(playerid,"~r~Nie posiadasz kluczy do tego pojazdu!",5000,3);
				RemovePlayerFromVehicle(playerid);
				RemovePlayerFromVehicle(playerid);
				Frezuj(playerid, 0);
				Frezuj(playerid, 1);
				return 1;
			}
			if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510)
		    {
		        new lights,doors,bonnet,boot,objective,engine,alarm;
		        GetVehiclePos(vehicleid,dOstatniX[playerid],dOstatniY[playerid],dOstatniZ[playerid]);
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, 1, lights, 0, doors, bonnet, boot, objective);
			}
		}
	}
	//return SetPVarInt(playerid, "Teleportacja", 1);
	return 1;
}
stock Predkosc(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
        GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
        else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 180.3;
    return floatround(ST[3]);
}
public OnPlayerExitVehicle(playerid, vehicleid)
{	
	KillTimer(ABTimer[playerid]);
	AB[playerid] = 0;
	new uid = SprawdzCarUID(vehicleid);
	if(PojazdInfo[uid][pModel] == 574)
	{
		SetVehicleToRespawn(vehicleid);
		PojazdInfo[uid][pStan] = 1000.0;
		PojazdInfo[uid][pPaliwo] = 100;
		KillTimer(PojazdInfo[uid][pTimer]);
		SetVehicleHealth(vehicleid, PojazdInfo[uid][pStan] );
		RepairVehicle(vehicleid);
		if(Pracuje[playerid] != 0)
		{
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "Wysiadles z pojazdu, zlecenie zostalo anulowane.");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
			DaneGracza[playerid][gCheckopintID] = 0;
			DaneGracza[playerid][gWyscig] = 0;
			DaneGracza[playerid][gCheckopintID] = 0;
			DisablePlayerRaceCheckpoint(playerid);
			DaneGracza[playerid][gKoniecWyscigu] = 0;
			DaneGracza[playerid][gRaceTimeStart] = 0;
		}
		Pracuje[playerid] = 0;
	}
	RefreshNick(playerid);
	GetVehiclePos(PojazdInfo[uid][pID],PojazdInfo[uid][pOX],PojazdInfo[uid][pOY],PojazdInfo[uid][pOZ]);
	PojazdInfo[uid][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uid][pID]);
	GetVehicleZAngle(PojazdInfo[uid][pID], PojazdInfo[uid][pOA]);
	ZapiszPojazd(uid, 1);
	//SetPVarInt(playerid, "Teleportacja", 1);
	GPS[playerid] = 0;
	PASY[playerid] = 0;
	if(GPS[playerid] == 1)
	{
		GPS[playerid] = 0;
		ForeachEx(ilosc, 99)
		{
			RemovePlayerMapIcon( playerid, ilosc );
		}
	}
	RefreshNick(playerid);
	SetTimerEx("WychodziZPojazdu",2000,0,"d",playerid);
	ABTimer[playerid] = SetTimerEx("ABTimerer",5000, 0, "d", playerid);
	return 1;
}
stock WlascicielpojazduUID(uid, playerid)
{
	if(PojazdInfo[uid][pOwnerDzialalnosc] == 0 && PojazdInfo[uid][pOwnerPostac] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc1] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia1][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc2] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia2][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc3] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia3][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc4] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia4][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc5] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia5][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc6] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia6][9] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock WlascicielpojazduBezWYP(vehid, playerid)
{
	new uid = SprawdzCarUID(vehid);
	if(PojazdInfo[uid][pOwnerDzialalnosc] == 0 && PojazdInfo[uid][pOwnerPostac] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc1] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia1][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc2] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia2][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc3] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia3][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc4] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia4][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc5] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia5][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc6] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia6][9] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock Wlascicielpojazdu(vehid, playerid)
{
	new uid = SprawdzCarUID(vehid);
	if(PojazdInfo[uid][pOwnerDzialalnosc] == 0 && PojazdInfo[uid][pOwnerPostac] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc1] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia1][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc2] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia2][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc3] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia3][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc4] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia4][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc5] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia5][9] == 1)
    {
		return true;
 	}
    else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gDzialalnosc6] == PojazdInfo[uid][pOwnerDzialalnosc] && DaneGracza[playerid][gUprawnienia6][9] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pModel] == 574 && DaneGracza[playerid][gPracaTyp] == PRACA_ZAMIATACZ)
    {
		return true;
 	}
	else if(DaneGracza[playerid][gWypozyczonyPojazdUID] == uid && DaneGracza[playerid][gWypozyczonyPojazdCZAS] > gettime())
	{
		return true;
	}
	else if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		return true;
	}
	else
	{
		return false;
 	}
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	KillTimer(TimerSprawdzaniaPojazdu[playerid]);
	TimerSprawdzaniaPojazdu[playerid] = SetTimerEx("SprawdzPojazd",7000,0,"d",playerid);
	SprawdzaniePojazdu[playerid] = 1;
	if(Rolki[playerid] != 0)
	{
		GameTextForPlayer(playerid, "~r~Nie mozesz z rolkami wchodzic do pojazdow.", 3000, 5);
		RemovePlayerFromVehicle(playerid);
		Frezuj(playerid, 0);
		Frezuj(playerid, 1);
		return 1;
	}
	new veh = SprawdzCarUID(vehicleid);
    SetVehicleHealth(vehicleid, PojazdInfo[veh][pStan]);
	if(PojazdInfo[veh][pModel] == 574 && DaneGracza[playerid][gWyscig] != 0)
	{
		GameTextForPlayer(playerid, "~r~Aby wejsc do Sweepera musisz opuscic wyscig.~n~/opusc", 3000, 5);
		RemovePlayerFromVehicle(playerid);
		Frezuj(playerid, 0);
		Frezuj(playerid, 1);
		return 1;
	}
	if(Jednoslady(vehicleid) && !Dokument(playerid, D_PRAWKO_A) && !ispassenger)
	{
		if(GetVehicleModel(vehicleid) != 509 && GetVehicleModel(vehicleid) != 481 && GetVehicleModel(vehicleid) != 510)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz prawa jazdy {88b711}Kat. A{DEDEDE}.\nUdaj siê do urzêdu aby wyrobiæ ten dokument.", "Zamknij", "");
		}
	}
	if(!Jednoslady(vehicleid) && !Dokument(playerid, D_PRAWKO_B) && !ispassenger)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz prawa jazdy {88b711}Kat. B{DEDEDE}.\nUdaj siê do urzêdu aby wyrobiæ ten dokument.", "Zamknij", "");
	}
	/*if(DaneGracza[playerid][gCZAS_ONLINE] < 3 * 60 * 60 && !ispassenger)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ twoja postaæ nie ma przegranych {88b711}3{DEDEDE} godzin.", "Zamknij", "");
		RemovePlayerFromVehicle(playerid);
		Frezuj(playerid, 0);
		Frezuj(playerid, 1);
		return 1;
	}*/
    if(BlokadaVEH(playerid) && !ispassenger)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade prowadzenia pojazdów{DEDEDE} \
		\nJeœli uwa¿asz, ¿e kara zosta³a nadana nies³usznie mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
		RemovePlayerFromVehicle(playerid);
		Frezuj(playerid, 0);
		Frezuj(playerid, 1);
		return 1;
	}
	if(!Wlascicielpojazdu(vehicleid, playerid) && ispassenger == 0)
	{
    	GameTextForPlayer(playerid,"~r~Nie posiadasz kluczy do tego pojazdu!",5000,3);
		RemovePlayerFromVehicle(playerid);
		RemovePlayerFromVehicle(playerid);
		Frezuj(playerid, 0);
		Frezuj(playerid, 1);
		return 1;
	}
	if(DaneGracza[playerid][gWynajem] == 0 && ispassenger == 0)
	{
    	GameTextForPlayer(playerid,"~r~Nie posiadasz zameldowania!",5000,3);
		RemovePlayerFromVehicle(playerid);
		RemovePlayerFromVehicle(playerid);
		Frezuj(playerid, 0);
		Frezuj(playerid, 1);
		return 1;
	}
    return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    new uid = SprawdzCarUID(vehicleid);
	new uszkodzenia[4];
	GetVehicleDamageStatus(vehicleid, uszkodzenia[0], uszkodzenia[1], uszkodzenia[2], uszkodzenia[3]);
	GetVehicleDamageStatus(vehicleid, uszkodzenia[0], uszkodzenia[1], uszkodzenia[2], uszkodzenia[3]);
	if(uszkodzenia[0] == 0 && PojazdInfo[uid][pUszkodzenie1] != 0 || uszkodzenia[1] == 0 && PojazdInfo[uid][pUszkodzenie2] != 0 || uszkodzenia[3] == 0 && PojazdInfo[uid][pUszkodzenie4] != 0)
	{
		if(uszkodzenia[1] == 0 && PojazdInfo[uid][pUszkodzenie2] != 0)
		{
			new tablica[32], tablica2[32], uszkodzeniasprawdz = PojazdInfo[uid][pUszkodzenie2];
			for(new i = 0; i < 32; i++)
			{
				tablica[i] = uszkodzenia[1] % 2;
				tablica2[i] = uszkodzeniasprawdz % 2;
				if(i == 16 && tablica2[i] == 1 && tablica[i] == 0)
				{
					return 0;
				}
				if(i == 24 && tablica2[i] == 1 && tablica[i] == 0)
				{
					return 0;
				}
				uszkodzenia[1] /= 2;
				uszkodzeniasprawdz /= 2;
			}
		}
		if(AntyCheatWizualizacja[playerid] == 0)
		{
			new world = GetVehicleVirtualWorld(vehicleid);
			UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
			SetVehicleVirtualWorld(vehicleid,9999);
			SetVehicleVirtualWorld(vehicleid,world);
			GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
			NadajKare(playerid,-1, 1, "Anty Cheat System (Naprawa wizualizacji pojazdu)", 30);
			return 1;
		}
	}
	else
	{
		new Float:Rozmiar[3], Float:Srodek[3];
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, Rozmiar[0], Rozmiar[1], Rozmiar[2]);
		GetVehiclePos(vehicleid, Srodek[0], Srodek[1], Srodek[2]);
		new tablica[32], tablica2[32], tablica3[32], tablica4[32], uszkodzeniasprawdz = PojazdInfo[uid][pUszkodzenie2], uszkodzeniasprawdz2 = PojazdInfo[uid][pUszkodzenie1];
		for(new i = 0; i < 32; i++)
		{
			tablica[i] = uszkodzenia[1] % 2;
			tablica2[i] = uszkodzeniasprawdz % 2;
			tablica3[i] = uszkodzenia[0] % 2;
			tablica4[i] = uszkodzeniasprawdz2 % 2;
			if(i == 1 && tablica[i] == 1 && tablica2[i] == 0)
			{
				new Float:Pozycje[3];
				Pozycje[0] = Srodek[0];
				Pozycje[1] = Srodek[1];
				Pozycje[2] = Srodek[2];
				for(new h = 0; h < IloscGraczy; h++)
				{
					if(IsPlayerInRangeOfPoint(KtoJestOnline[h], 5.0, Pozycje[0], Pozycje[1], Pozycje[2]) && !IsPlayerInAnyVehicle(KtoJestOnline[h]))
					{
						if(UzylLPM[KtoJestOnline[h]] == 1)
						{
							new world = GetVehicleVirtualWorld(vehicleid);
							UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							SetVehicleVirtualWorld(vehicleid,9999);
							SetVehicleVirtualWorld(vehicleid,world);
							GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							Frezuj(KtoJestOnline[h], 0);
							SetTimerEx("Frez", 3000, 0, "d", KtoJestOnline[h]);
							NadajKare(KtoJestOnline[h],-1, 1, "Anty Cheat System (Rozwalenie karoseri pojazdu MK)", 0);
						}
					}
				}
			}
			if(i == 9 && tablica[i] == 1 && tablica2[i] == 0)
			{
				new Float:Pozycje[3];
				Pozycje[0] = Srodek[0];
				Pozycje[1] = Srodek[1];
				Pozycje[2] = Srodek[2];
				for(new h = 0; h < IloscGraczy; h++)
				{
					if(IsPlayerInRangeOfPoint(KtoJestOnline[h], 5.0, Pozycje[0], Pozycje[1], Pozycje[2]) && !IsPlayerInAnyVehicle(KtoJestOnline[h]))
					{
						if(UzylLPM[KtoJestOnline[h]] == 1)
						{
							new world = GetVehicleVirtualWorld(vehicleid);
							UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							SetVehicleVirtualWorld(vehicleid,9999);
							SetVehicleVirtualWorld(vehicleid,world);
							GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							Frezuj(KtoJestOnline[h], 0);
							SetTimerEx("Frez", 3000, 0, "d", KtoJestOnline[h]);
							NadajKare(KtoJestOnline[h],-1, 1, "Anty Cheat System (Rozwalenie karoseri pojazdu BG)", 0);
						}
					}
				}
			}
			if(i == 17 && tablica[i] == 1 && tablica2[i] == 0)
			{
				new Float:Pozycje[3];
				Pozycje[0] = Srodek[0];
				Pozycje[1] = Srodek[1];
				Pozycje[2] = Srodek[2];
				for(new h = 0; h < IloscGraczy; h++)
				{
					if(IsPlayerInRangeOfPoint(KtoJestOnline[h], 3.0, Pozycje[0], Pozycje[1], Pozycje[2]) && !IsPlayerInAnyVehicle(KtoJestOnline[h]))
					{
						if(UzylLPM[KtoJestOnline[h]] == 1)
						{
							new world = GetVehicleVirtualWorld(vehicleid);
							UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							SetVehicleVirtualWorld(vehicleid,9999);
							SetVehicleVirtualWorld(vehicleid,world);
							GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							Frezuj(KtoJestOnline[h], 0);
							SetTimerEx("Frez", 3000, 0, "d", KtoJestOnline[h]);
							NadajKare(KtoJestOnline[h],-1, 1, "Anty Cheat System (Rozwalenie karoseri pojazdu DK)", 0);
						}
					}
				}
			}
			if(i == 25 && tablica[i] == 1 && tablica2[i] == 0)
			{
				new Float:Pozycje[3];
				Pozycje[0] = Srodek[0];
				Pozycje[1] = Srodek[1];
				Pozycje[2] = Srodek[2];
				for(new h = 0; h < IloscGraczy; h++)
				{
					if(IsPlayerInRangeOfPoint(KtoJestOnline[h], 3.0, Pozycje[0], Pozycje[1], Pozycje[2]) && !IsPlayerInAnyVehicle(KtoJestOnline[h]))
					{
						if(UzylLPM[KtoJestOnline[h]] == 1)
						{
							new world = GetVehicleVirtualWorld(vehicleid);
							UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							SetVehicleVirtualWorld(vehicleid,9999);
							SetVehicleVirtualWorld(vehicleid,world);
							GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							Frezuj(KtoJestOnline[h], 0);
							SetTimerEx("Frez", 3000, 0, "d", KtoJestOnline[h]);
							NadajKare(KtoJestOnline[h],-1, 1, "Anty Cheat System (Rozwalenie karoseri pojazdu DP)", 0);
						}
					}
				}
			}
			if(i == 20 && tablica3[i] == 1 && tablica4[i] == 0)
			{
				new Float:Pozycje[3];
				Pozycje[0] = Srodek[0];
				Pozycje[1] = Srodek[1];
				Pozycje[2] = Srodek[2];
				for(new h = 0; h < IloscGraczy; h++)
				{
					if(IsPlayerInRangeOfPoint(KtoJestOnline[h], 5.0, Pozycje[0], Pozycje[1], Pozycje[2]) && !IsPlayerInAnyVehicle(KtoJestOnline[h]))
					{
						if(UzylLPM[KtoJestOnline[h]] == 1)
						{
							new world = GetVehicleVirtualWorld(vehicleid);
							UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							SetVehicleVirtualWorld(vehicleid,9999);
							SetVehicleVirtualWorld(vehicleid,world);
							GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							Frezuj(KtoJestOnline[h], 0);
							SetTimerEx("Frez", 3000, 0, "d", KtoJestOnline[h]);
							NadajKare(KtoJestOnline[h],-1, 1, "Anty Cheat System (Rozwalenie karoseri pojazdu ZP)", 0);
						}
					}
				}
			}
			if(i == 24 && tablica3[i] == 1 && tablica4[i] == 0)
			{
				new Float:Pozycje[3];
				Pozycje[0] = Srodek[0];
				Pozycje[1] = Srodek[1];
				Pozycje[2] = Srodek[2];
				for(new h = 0; h < IloscGraczy; h++)
				{
					if(IsPlayerInRangeOfPoint(KtoJestOnline[h], 5.0, Pozycje[0], Pozycje[1], Pozycje[2]) && !IsPlayerInAnyVehicle(KtoJestOnline[h]))
					{
						if(UzylLPM[KtoJestOnline[h]] == 1)
						{
							new world = GetVehicleVirtualWorld(vehicleid);
							UpdateVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							SetVehicleVirtualWorld(vehicleid,9999);
							SetVehicleVirtualWorld(vehicleid,world);
							GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
							Frezuj(KtoJestOnline[h], 0);
							SetTimerEx("Frez", 3000, 0, "d", KtoJestOnline[h]);
							NadajKare(KtoJestOnline[h],-1, 1, "Anty Cheat System (Rozwalenie karoseri pojazdu ZT)", 0);
						}
					}
				}
			}
			uszkodzenia[1] /= 2;
			uszkodzeniasprawdz /= 2;
			uszkodzenia[0] /= 2;
			uszkodzeniasprawdz2 /= 2;
		}
		GetVehicleDamageStatus(vehicleid, PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
	}
    return 1;
}
public OnVehicleDeath(vehicleid, killerid)
{
	new	Float:nVHP;
	GetVehicleHealth(vehicleid, nVHP );
	new uid = SprawdzCarUID(vehicleid);
	DestroyDynamicObject(PojazdInfo[uid][pKogut]);
	if(PojazdInfo[uid][pModel] == 574)
	{
		SetVehicleToRespawn(vehicleid);
		PojazdInfo[uid][pStan] = 1000.0;
		PojazdInfo[uid][pPaliwo] = 100;
		SetVehicleHealth(vehicleid, PojazdInfo[uid][pStan] );
		RepairVehicle(vehicleid);
	}
	else
	{
		DestroyVehicle(vehicleid);
		PojazdInfo[uid][pSpawn] = 0;
		PojazdInfo[uid][pStan] = 300.0;
		SetVehicleHealth(vehicleid, PojazdInfo[uid][pStan] );
	}
	PojazdInfo[uid][pHolowany] = 0;
	new rok, miesiac, dzien, godzina, minuta, sekunda;
	sekundytodata(gettime()-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
	printf("[UID_POJAZDU:%d][%02d-%02d-%d, %02d:%02d][Wybuch Pojazdu] Gracz: %s (UID: %d, GUID: %d) doprowadzil pojazd (UID: %d) do wybuchu.[KONIEC_LOGU]",uid, dzien, miesiac, rok, godzina, minuta, ZmianaNicku(killerid), DaneGracza[killerid][gUID], DaneGracza[killerid][gGUID], uid);
	//Transakcja(T_VEHDEST, DaneGracza[killerid][gUID], -1, DaneGracza[killerid][gGUID], -1, nVHP, uid, vehicleid, PojazdInfo[uid][pStan], "-", gettime()-CZAS_LETNI);
	PojazdInfo[uid][pID] = 0;
	ZapiszPojazd(uid, 1);
	KillTimer(PojazdInfo[uid][pTimer]);
	UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[uid][pID]], 0xAAAAFFFF, " ");
	KierunkiAwaryjneIn[vehicleid] = false;
	KierunekPrawyOn[vehicleid] = false;
	KierunekLewyOn[vehicleid] = false;
	DestroyObject(KierunekObiekt[vehicleid][0]);
	DestroyObject(KierunekObiekt[vehicleid][1]);
	DestroyObject(KierunekObiekt[vehicleid][2]);
	DestroyObject(KierunekObiekt[vehicleid][3]);
	DestroyObject(KierunekObiekt[vehicleid][4]);
	if(Indicators[vehicleid][2]) DestroyDynamicObject(Indicators[vehicleid][2]), DestroyDynamicObject(Indicators[vehicleid][3]),Indicators[vehicleid][2]=0;
	if(Indicators[vehicleid][0]) DestroyDynamicObject(Indicators[vehicleid][0]), DestroyDynamicObject(Indicators[vehicleid][1]),Indicators[vehicleid][0]=0;
    return 1;
}
/*forward WyladujPojazdyGracza(playerid);
public WyladujPojazdyGracza(playerid)
{
	ForeachEx(i, MAX_VEH)
	{
		if(PojazdInfo[i][pOwnerDzialalnosc] == 0 && PojazdInfo[i][pOwnerPostac] == DaneGracza[playerid][gUID])
	    {
			
			if(PojazdInfo[i][pSpawn] == 1)
			{
				StworzPojazd(i, -1);
			}
			PojazdInfo[i][pUID] = 0;
			PojazdInfo[i][pOwnerPostac] = 0;
			PojazdInfo[i][pOwnerDzialalnosc] = 0;
			PojazdInfo[i][pModel] = 0;
			PojazdInfo[i][pKolor] = 0;
			PojazdInfo[i][pKolor2] = 0;
			PojazdInfo[i][pStan] = 0;
			PojazdInfo[i][pPrzebieg] = 0;
			PojazdInfo[i][pGaz] = 0;
			PojazdInfo[i][pTypPojazdu] = 0;
			PojazdInfo[i][pTypPaliwa] = 0;
			PojazdInfo[i][pMoc] = 0;
			PojazdInfo[i][pRok] = 0;
			PojazdInfo[i][pX] = 0;
			PojazdInfo[i][pY] = 0;
			PojazdInfo[i][pZ] = 0;
			PojazdInfo[i][pVw] = 0;
			PojazdInfo[i][pInt] = 0;
			PojazdInfo[i][pAngle] = 0;
			PojazdInfo[i][pSpawn] = 0;
			PojazdInfo[i][pLpg] = 0;
			PojazdInfo[i][pPaliwo] = 0;
			PojazdInfo[i][pID] = 0;
			PojazdInfo[i][pLock] = 0;
			PojazdInfo[i][pSilnik] = 0;
			PojazdInfo[i][pUszkodzenie1] = 0;
			PojazdInfo[i][pUszkodzenie2] = 0;
			PojazdInfo[i][pUszkodzenie3] = 0;
			PojazdInfo[i][pUszkodzenie4] = 0;
			PojazdInfo[i][pBlokada] = 0;
			KillTimer(PojazdInfo[i][pTimer]);
			PojazdInfo[i][pAudioStream] = 0;
			PojazdInfo[i][pNaprawy] = 0;
		}
	}
}*/
forward ZaladujPojazdy();
public ZaladujPojazdy()
{
	new result[512], iz = 0;
	format(zapyt, sizeof(zapyt), "SELECT * FROM `five_pojazdy`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
		sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>ddddddffs[20]dddds[20]dfffddfddfdddddddfdffffdddddddddddf", 	PojazdInfo[uid][pUID],
															PojazdInfo[uid][pOwnerPostac],
															PojazdInfo[uid][pOwnerDzialalnosc],
															PojazdInfo[uid][pModel],
															PojazdInfo[uid][pKolor],
															PojazdInfo[uid][pKolor2],
															PojazdInfo[uid][pStan],
															PojazdInfo[uid][pPrzebieg],
															PojazdInfo[uid][pDodatki],
															PojazdInfo[uid][pGaz],
															PojazdInfo[uid][pTypPojazdu],
															PojazdInfo[uid][pTypPaliwa],
															PojazdInfo[uid][pMoc],
															PojazdInfo[uid][pTablice],
															PojazdInfo[uid][pRok],
															PojazdInfo[uid][pX],
															PojazdInfo[uid][pY],
															PojazdInfo[uid][pZ],
															PojazdInfo[uid][pVw],
															PojazdInfo[uid][pInt],
															PojazdInfo[uid][pAngle],
															PojazdInfo[uid][pSpawn],
															PojazdInfo[uid][pLpg],
															PojazdInfo[uid][pPaliwo],
															PojazdInfo[uid][pLock],
															PojazdInfo[uid][pSilnik],
															PojazdInfo[uid][pUszkodzenie1],
															PojazdInfo[uid][pUszkodzenie2],
															PojazdInfo[uid][pUszkodzenie3],
															PojazdInfo[uid][pUszkodzenie4],
															PojazdInfo[uid][pBlokada],
															PojazdInfo[uid][pNaprawy],
															PojazdInfo[uid][pPJ],
															PojazdInfo[uid][pOX],
															PojazdInfo[uid][pOY],
															PojazdInfo[uid][pOZ],
															PojazdInfo[uid][pOA],
															PojazdInfo[uid][pPrzepchany],
															PojazdInfo[uid][pTempomat],
															PojazdInfo[uid][pAudio],
															PojazdInfo[uid][pAlarm],
															PojazdInfo[uid][pImmo],
															PojazdInfo[uid][pCB],
															PojazdInfo[uid][pKanal],
															PojazdInfo[uid][pSzyba],
															PojazdInfo[uid][pAukcja],
															PojazdInfo[uid][pTablicaON],
															PojazdInfo[uid][pOVW],
															PojazdInfo[uid][pPaliwoGaz]);
		if(PojazdInfo[uid][pModel] >= 400 && PojazdInfo[uid][pModel] <= 611)
		{
			if(PojazdInfo[uid][pAukcja] > 0)
			{
				PojazdInfo[uid][pOwnerPostac] = PojazdInfo[uid][pAukcja];
				PojazdInfo[uid][pAukcja] = 0;
				new str[124];
				strdel(str, 0, 124);
				format(str, sizeof(str), "UPDATE `five_pojazdy` SET `AUKCJA` = '%d' WHERE `ID` = '%d'", PojazdInfo[uid][pAukcja], uid);
				mysql_query(str);
			}
			if(PojazdInfo[uid][pPaliwo] > PaliwoIlosc(PojazdInfo[uid][pModel]))
			{
				PojazdInfo[uid][pPaliwo] = PaliwoIlosc(PojazdInfo[uid][pModel]);
			}
			if(PojazdInfo[uid][pModel] == 574)
			{
				PojazdInfo[uid][pSpawn] = 1;
			}
		    if(PojazdInfo[uid][pSpawn] != 0)
			{
				StworzPojazdUID(uid);
			}
			iz++;
		}
	}
	mysql_free_result();
	//printf("1Pojazdy     - %d", iz);
}
forward ZaladujPojazdyGracza(playerid);
public ZaladujPojazdyGracza(playerid)
{
	new result[512], iz = 0;
	format(zapyt, sizeof(zapyt), "SELECT * FROM `five_pojazdy` WHERE `UID_POSTACI` = %d AND `UID_DZIALALNOSCI` = 0", DaneGracza[playerid][gUID]);
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
		sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>ddddddffs[20]dddds[20]dfffddfddfdddddddfdffffdddddddddddf", 	PojazdInfo[uid][pUID],
															PojazdInfo[uid][pOwnerPostac],
															PojazdInfo[uid][pOwnerDzialalnosc],
															PojazdInfo[uid][pModel],
															PojazdInfo[uid][pKolor],
															PojazdInfo[uid][pKolor2],
															PojazdInfo[uid][pStan],
															PojazdInfo[uid][pPrzebieg],
															PojazdInfo[uid][pDodatki],
															PojazdInfo[uid][pGaz],
															PojazdInfo[uid][pTypPojazdu],
															PojazdInfo[uid][pTypPaliwa],
															PojazdInfo[uid][pMoc],
															PojazdInfo[uid][pTablice],
															PojazdInfo[uid][pRok],
															PojazdInfo[uid][pX],
															PojazdInfo[uid][pY],
															PojazdInfo[uid][pZ],
															PojazdInfo[uid][pVw],
															PojazdInfo[uid][pInt],
															PojazdInfo[uid][pAngle],
															PojazdInfo[uid][pSpawn],
															PojazdInfo[uid][pLpg],
															PojazdInfo[uid][pPaliwo],
															PojazdInfo[uid][pLock],
															PojazdInfo[uid][pSilnik],
															PojazdInfo[uid][pUszkodzenie1],
															PojazdInfo[uid][pUszkodzenie2],
															PojazdInfo[uid][pUszkodzenie3],
															PojazdInfo[uid][pUszkodzenie4],
															PojazdInfo[uid][pBlokada],
															PojazdInfo[uid][pNaprawy],
															PojazdInfo[uid][pPJ],
															PojazdInfo[uid][pOX],
															PojazdInfo[uid][pOY],
															PojazdInfo[uid][pOZ],
															PojazdInfo[uid][pOA],
															PojazdInfo[uid][pPrzepchany],
															PojazdInfo[uid][pTempomat],
															PojazdInfo[uid][pAudio],
															PojazdInfo[uid][pAlarm],
															PojazdInfo[uid][pImmo],
															PojazdInfo[uid][pCB],
															PojazdInfo[uid][pKanal],
															PojazdInfo[uid][pSzyba],
															PojazdInfo[uid][pAukcja],
															PojazdInfo[uid][pTablicaON],
															PojazdInfo[uid][pOVW],
															PojazdInfo[uid][pPaliwoGaz]);
		if((PojazdInfo[uid][pModel] >= 400 && PojazdInfo[uid][pModel] <= 611))
		{
			if(PojazdInfo[uid][pAukcja] > 0)
			{
				PojazdInfo[uid][pOwnerPostac] = PojazdInfo[uid][pAukcja];
				PojazdInfo[uid][pAukcja] = 0;
				new str[124];
				strdel(zapyt, 0, 124);
				format(str, sizeof(str), "UPDATE `five_pojazdy` SET `AUKCJA` = '%d' WHERE `ID` = '%d'", PojazdInfo[uid][pAukcja], uid);
				mysql_query(str);
			}
			if(PojazdInfo[uid][pPaliwo] > PaliwoIlosc(PojazdInfo[uid][pModel]))
			{
				PojazdInfo[uid][pPaliwo] = PaliwoIlosc(PojazdInfo[uid][pModel]);
			}
		    //PojazdInfo[uid][pSpawn] = 0;
			iz++;
		}
	}
	mysql_free_result();
	//printf("2Pojazdy     - %d", iz);
}
forward UsunPojazd(uid);
public UsunPojazd(uid)
{
	format(zapyt, sizeof(zapyt), "DELETE FROM `five_pojazdy` WHERE `ID` = '%d'", uid);
	mysql_check();
	mysql_query2(zapyt);
	DestroyDynamicObject(PojazdInfo[uid][pKogut]);
	DestroyVehicle(PojazdInfo[uid][pID]);
	PojazdInfo[uid][pID] = 0;
	PojazdInfo[uid][pUID] = 0;
	PojazdInfo[uid][pOwnerPostac] = 0;
	PojazdInfo[uid][pOwnerDzialalnosc] = 0;
	PojazdInfo[uid][pModel] = 0;
	PojazdInfo[uid][pKolor] = 0;
	PojazdInfo[uid][pKolor2] = 0;
	PojazdInfo[uid][pStan] = 0;
	PojazdInfo[uid][pPrzebieg] = 0;
	PojazdInfo[uid][pDodatki] = 0;
	PojazdInfo[uid][pGaz] = 0;
	PojazdInfo[uid][pTypPojazdu] = 0;
	PojazdInfo[uid][pTypPaliwa] = 0;
	PojazdInfo[uid][pMoc] = 0;
	PojazdInfo[uid][pRok] = 0;
	PojazdInfo[uid][pX] = 0;
	PojazdInfo[uid][pY] = 0;
	PojazdInfo[uid][pZ] = 0;
	PojazdInfo[uid][pVw] = 0;
	PojazdInfo[uid][pInt] = 0;
	PojazdInfo[uid][pAngle] = 0;
	PojazdInfo[uid][pSpawn] = 0;
	PojazdInfo[uid][pLpg] = 0;
	PojazdInfo[uid][pPaliwo] = 0;
	PojazdInfo[uid][pLock] = 0;
	PojazdInfo[uid][pSilnik] = 0;
	PojazdInfo[uid][pUszkodzenie1] = 0;
	PojazdInfo[uid][pUszkodzenie2] = 0;
	PojazdInfo[uid][pUszkodzenie3] = 0;
	PojazdInfo[uid][pUszkodzenie4] = 0;
	PojazdInfo[uid][pBlokada] = 0;
	PojazdInfo[uid][pNaprawy] = 0;
	mysql_free_result();
	return 1;
}
forward StworzPojazdUID(uid);
public StworzPojazdUID(uid)
{
	new pointer;
	if(PojazdInfo[uid][pPrzepchany] == 1)
	{
		if(PojazdInfo[uid][pModel] == 538)
		{
			pointer = AddStaticVehicle(PojazdInfo[uid][pModel], PojazdInfo[uid][pX], PojazdInfo[uid][pY], PojazdInfo[uid][pZ], PojazdInfo[uid][pAngle], PojazdInfo[uid][pKolor], PojazdInfo[uid][pKolor2]);
		}else{
			pointer = CreateVehicle(PojazdInfo[uid][pModel], PojazdInfo[uid][pOX], PojazdInfo[uid][pOY], PojazdInfo[uid][pOZ], PojazdInfo[uid][pOA], PojazdInfo[uid][pKolor], PojazdInfo[uid][pKolor2], -1);
		}
	}
	else
	{
		if(PojazdInfo[uid][pModel] == 538)
		{
			pointer = AddStaticVehicle(PojazdInfo[uid][pModel], PojazdInfo[uid][pX], PojazdInfo[uid][pY], PojazdInfo[uid][pZ], PojazdInfo[uid][pAngle], PojazdInfo[uid][pKolor], PojazdInfo[uid][pKolor2]);
		}else{
			pointer = CreateVehicle(PojazdInfo[uid][pModel], PojazdInfo[uid][pX], PojazdInfo[uid][pY], PojazdInfo[uid][pZ], PojazdInfo[uid][pAngle], PojazdInfo[uid][pKolor], PojazdInfo[uid][pKolor2], -1);
		}
	}
	/*if(PojazdInfo[uid][pModel] == 538)
	{
		pointer = AddStaticVehicle(PojazdInfo[uid][pModel], PojazdInfo[uid][pX], PojazdInfo[uid][pY], PojazdInfo[uid][pZ], PojazdInfo[uid][pAngle], PojazdInfo[uid][pKolor], PojazdInfo[uid][pKolor2]);
	}else{
		pointer = CreateVehicle(PojazdInfo[uid][pModel], PojazdInfo[uid][pX], PojazdInfo[uid][pY], PojazdInfo[uid][pZ], PojazdInfo[uid][pAngle], PojazdInfo[uid][pKolor], PojazdInfo[uid][pKolor2], -1);
	}*/
	PojazdInfo[uid][pID] = pointer;
	if(ComparisonString(PojazdInfo[uid][pTablice], "Brak"))
	{
		format(PojazdInfo[uid][pTablice], 10, " ");
	}
	if(ComparisonString(PojazdInfo[uid][pTablice], ""))
	{
		format(PojazdInfo[uid][pTablice], 10, " ");
	}
	SetVehicleNumberPlate(pointer, PojazdInfo[uid][pTablice]);
	LinkVehicleToInterior(pointer, PojazdInfo[uid][pInt]);
	PojazdInfo[uid][pAudioStream] = 0;
	PojazdInfo[uid][pSilnik] = 0;
	KillTimer(PojazdInfo[uid][pTimer]);
	if(PojazdInfo[uid][pModel] == 574)
	{
		PojazdInfo[uid][pLock] = 0;
	}
	else
	{
		PojazdInfo[uid][pLock] = 1;
	}
	SetVehicleParamsEx(pointer, false, false, false, PojazdInfo[uid][pLock], false, false, false);
	OnVehicleSpawn(pointer);
	PojazdInfo[uid][pOVW] = GetVehicleVirtualWorld(PojazdInfo[uid][pID]);
	GetVehicleZAngle(pointer, PojazdInfo[uid][pOA]);
	if(PojazdInfo[uid][pPrzepchany] == 1)
	{
		SetVehiclePos(pointer,PojazdInfo[uid][pOX],PojazdInfo[uid][pOY],PojazdInfo[uid][pOZ]);
		SetVehicleVirtualWorld(pointer, PojazdInfo[uid][pOVW]);
		PojazdInfo[uid][pPrzepchany] = 0;
	}
	else
	{
		SetVehiclePos(pointer,PojazdInfo[uid][pX],PojazdInfo[uid][pY],PojazdInfo[uid][pZ]);
		SetVehicleVirtualWorld(pointer, PojazdInfo[uid][pVw]);
	}
	SetVehicleZAngle(pointer, PojazdInfo[uid][pAngle]);
	Vopis[pointer]= CreateDynamic3DTextLabel(" ",0xAAAAFFDD,0.0,0.0,0.0,15.0,INVALID_PLAYER_ID,pointer,0,-1,-1,-1,100.0);
	GetVehiclePos(pointer,PojazdInfo[uid][pOX],PojazdInfo[uid][pOY],PojazdInfo[uid][pOZ]);
	for(new i = 0; i < MAX_VEH; i++)
	{
		if(PojazdySerwera[i] == 0)
		{
			PojazdySerwera[i] = uid;
			break;
		}
	}
	IloscPojazdow++;
}
forward StworzPojazd(uid, playerid);
public StworzPojazd(uid, playerid)
{
	if(uid != 0)
	{
	    if(PojazdInfo[uid][pSpawn] == 0)
		{
			/*if(PojazdInfo[uid][pNaprawy] >= 10000)
			{
				UsunPojazd(uid);
				GameTextForPlayer(playerid, "~r~Pojazd osiagnal maxymalny poziom zniszczen.", 3000, 5);
				return 0;
			}*/
			PojazdInfo[uid][pHolowany] = 0;
			PojazdInfo[uid][pSpawn] = 1;
			StworzPojazdUID(uid);
			ZapiszPojazd(uid, 1);
			GameTextForPlayer(playerid, "~r~Pojazd zostal ~w~zespawnowany.", 3000, 5);
			Transakcja(T_VSPAWN, uid, playerid, 0, 0, 0, 0, 1, 0, "", 0);
		}
		else
		{
			PojazdInfo[uid][pPrzepchany] = 0;
			PojazdInfo[uid][pHolowany] = 0;
			PojazdInfo[uid][pSpawn] = 0;
			KillTimer(PojazdInfo[uid][pTimer]);
			UsunPojazdUID(uid);
			GameTextForPlayer(playerid, "~r~Pojazd zostal ~w~unspawnowany.", 3000, 5);
			Transakcja(T_VSPAWN, uid, playerid, 0, 0, 0, 0, 0, 0, "", 0);
		}
	}
	return 1;
}
forward UsunPojazdUID(uid);
public UsunPojazdUID(uid)
{
	
	new id = GetVehicleTrailer(GetPlayerVehicleID(PojazdInfo[uid][pID]));
	if(id != 0)
	{
		new id_p = SprawdzCarUID(id);
		PojazdInfo[id_p][pHolowany] = 0;
		//GetVehiclePos(PojazdInfo[id_p][pID], PojazdInfo[id_p][pOX], PojazdInfo[id_p][pOY], PojazdInfo[id_p][pOZ]);
		DetachTrailerFromVehicle(PojazdInfo[uid][pID]);
	}
	DestroyDynamic3DTextLabel(Text3D:Vopis[PojazdInfo[uid][pID]]);
	KierunkiAwaryjneIn[PojazdInfo[uid][pID]] = false;
	KierunekPrawyOn[PojazdInfo[uid][pID]] = false;
	KierunekLewyOn[PojazdInfo[uid][pID]] = false;
	DestroyObject(KierunekObiekt[PojazdInfo[uid][pID]][0]);
	DestroyObject(KierunekObiekt[PojazdInfo[uid][pID]][1]);
	DestroyObject(KierunekObiekt[PojazdInfo[uid][pID]][2]);
	DestroyObject(KierunekObiekt[PojazdInfo[uid][pID]][3]);
	DestroyObject(KierunekObiekt[PojazdInfo[uid][pID]][4]);
	UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[uid][pID]], 0xAAAAFFFF, " ");
    GetVehicleDamageStatus(PojazdInfo[uid][pID], PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
	DestroyDynamicObject(PojazdInfo[uid][pKogut]);
	DestroyVehicle(PojazdInfo[uid][pID]);
	KillTimer(PojazdInfo[uid][pTimer]);
	for(new i = 0; i < MAX_VEH; i++)
	{
		if(PojazdySerwera[i] == uid)
		{
			for(new o = i, d; o < IloscPojazdow; o++)
			{
				d = o+1;
				PojazdySerwera[o] = PojazdySerwera[d];
			}
			break;
		}
	}
	PojazdInfo[uid][pID] = 0;
	IloscPojazdow--;
	ZapiszPojazd(uid, 1);
}
forward ZapiszPojazd(uid, nr);
public ZapiszPojazd(uid, nr)
{
	if(nr == 2)
	{
		new lzapyt[256];
		strdel(lzapyt, 0, 256);
		format(lzapyt, sizeof(lzapyt), "UPDATE `five_pojazdy` SET `UID_POSTACI` = '%d', `UID_DZIALALNOSCI` = '%d' WHERE `ID` = '%d'",
		PojazdInfo[uid][pOwnerPostac],
		PojazdInfo[uid][pOwnerDzialalnosc],
		uid);
		mysql_check();
		mysql_query2(lzapyt);
		mysql_free_result();
	}
	if(nr == 1)
	{
		GetVehicleHealth(PojazdInfo[uid][pID], PojazdInfo[uid][pStan]);
		GetVehicleDamageStatus(PojazdInfo[uid][pID], PojazdInfo[uid][pUszkodzenie1], PojazdInfo[uid][pUszkodzenie2], PojazdInfo[uid][pUszkodzenie3], PojazdInfo[uid][pUszkodzenie4]);
		new lzapyt[600];
		strdel(lzapyt, 0, 600);
		format(lzapyt, sizeof(lzapyt), "UPDATE `five_pojazdy` SET `MODEL` = '%d', `KOLOR` = '%d', `KOLOR_2` = '%d', `STAN` = '%f', `PRZEBIEG` = '%f', `DODATKI` = '%s', `LICZBA_DRZWI` = '%d', `TYP_POJAZDU` = '%d', `TYP_PALIWA` = '%d', `MOC` = '%d', `NUMER_REJESTRACJI` = '%s', `ROK_PRODUKCJI` = '%d', `X` = '%f', `Y` = '%f', `Z` = '%f', `VW` = '%d', `INT` = '%d', `ANGLE` = '%f', `SPAWN` = '%d', `LPG` = '%d', `PALIWO` = '%f', `LOCK` = '%d' WHERE `ID` = '%d'",
		PojazdInfo[uid][pModel],
		PojazdInfo[uid][pKolor],
		PojazdInfo[uid][pKolor2],
		PojazdInfo[uid][pStan],
		PojazdInfo[uid][pPrzebieg],
		PojazdInfo[uid][pDodatki],
		PojazdInfo[uid][pGaz],
		PojazdInfo[uid][pTypPojazdu],
		PojazdInfo[uid][pTypPaliwa],
		PojazdInfo[uid][pMoc],
		PojazdInfo[uid][pTablice],
		PojazdInfo[uid][pRok],
		PojazdInfo[uid][pX],
		PojazdInfo[uid][pY],
		PojazdInfo[uid][pZ],
		PojazdInfo[uid][pVw],
		PojazdInfo[uid][pInt],
		PojazdInfo[uid][pAngle],
		PojazdInfo[uid][pSpawn],
		PojazdInfo[uid][pLpg],
		PojazdInfo[uid][pPaliwo],
		PojazdInfo[uid][pLock],
		uid);
		mysql_check();
		mysql_query2(lzapyt);
		mysql_free_result();

		strdel(zapyt, 0, 1024);
		format(zapyt, sizeof(zapyt), "UPDATE `five_pojazdy` SET `SILNIK` = '%d', `USZKODZENIE1` = '%d', `USZKODZENIE2` = '%d', `USZKODZENIE3` = '%d', `USZKODZENIE4` = '%d', `BLOKADA` = '%d', `NAPRAWY` = '%f', `PJ` = '%d', `OX` = '%f', `OY` = '%f', `OZ` = '%f', `OA` = '%f', `PRZEPCHANY` = '%d', `TEMPOMAT` = '%d', `AUDIO` = '%d', `ALARM` = '%d', `IMMO` = '%d', `CB` = '%d', `KANAL` = '%d', `SZYBA` = '%d', `SPAWN` = '%d', `TablicaON` = '%d', `OVW` = '%d', `PALIWOG` = '%f' WHERE `ID` = '%d'",
		PojazdInfo[uid][pSilnik],
		PojazdInfo[uid][pUszkodzenie1],
		PojazdInfo[uid][pUszkodzenie2],
		PojazdInfo[uid][pUszkodzenie3],
		PojazdInfo[uid][pUszkodzenie4],
		PojazdInfo[uid][pBlokada],
		PojazdInfo[uid][pNaprawy],
		PojazdInfo[uid][pPJ],
		PojazdInfo[uid][pOX],
		PojazdInfo[uid][pOY],
		PojazdInfo[uid][pOZ],
		PojazdInfo[uid][pOA],
		PojazdInfo[uid][pPrzepchany],
		PojazdInfo[uid][pTempomat],
		PojazdInfo[uid][pAudio],
		PojazdInfo[uid][pAlarm],
		PojazdInfo[uid][pImmo],
		PojazdInfo[uid][pCB],
		PojazdInfo[uid][pKanal],
		PojazdInfo[uid][pSzyba],
		PojazdInfo[uid][pSpawn],
		PojazdInfo[uid][pTablicaON],
		PojazdInfo[uid][pOVW],
		PojazdInfo[uid][pPaliwoGaz],
		uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_free_result();
	}
	return 1;
}
forward SprawdzCarUID(carid);
public SprawdzCarUID(carid)
{
	for(new i = 1;i < MAX_VEH; i++)
		if(PojazdInfo[i][pID] == carid)
			return i;
	return 1;
}
forward GetVehicleID(uid);
public GetVehicleID(uid)
{
	if(uid == INVALID_VEHICLE_ID) return false;
	ForeachEx(vehicleid, MAX_VEH)
	{
		if(PojazdInfo[vehicleid][pID] == uid)
	    {
			return vehicleid;
		}
	}
	return 0;
}
stock GetVehicleModelName(modelid)
{
	new tmp = modelid - 400;
	return NazwyAut[tmp];
}
stock PaliwoIlosc(modelid)
{
	new tmp = modelid - 400;
	return RozmiarBaku[tmp][0];
}
stock GetClosestVehicle(playerid, Float:Distance2 = 1000.0)
{
    Distance2 = floatabs(Distance2);
    if(Distance2 == 0.0) Distance2 = 1000.0;
    new Float:X[2], Float:Y[2], Float:Z[2];
    new Float:NearestPos = Distance2;
    new NearestVehicle = INVALID_VEHICLE_ID;
    GetPlayerPos(playerid, X[0], Y[0], Z[0]);
    for(new i; i<MAX_VEHICLES; i++)
	{
        if(!IsVehicleStreamedIn(i, playerid) || i == GetPlayerVehicleID(playerid)) continue;
        GetVehiclePos(i, X[1], Y[1], Z[1]);
        if(NearestPos > GetDistanceBetweenPoints(X[0], Y[0], Z[0], X[1], Y[1], Z[1])) NearestPos = GetDistanceBetweenPoints(X[0], Y[0], Z[0], X[1], Y[1], Z[1]), NearestVehicle = i;
    }
    if(NearestPos < Distance2) return NearestVehicle;
    return INVALID_VEHICLE_ID;
}
forward DodajPojazd(uids, model, kolor, kolor2, Float:x, Float:y, Float:z, paliwo, Float:a, typ);
public DodajPojazd(uids, model, kolor, kolor2, Float:x, Float:y, Float:z, paliwo, Float:a, typ)
{
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_pojazdy` (`UID_POSTACI`, `MODEL`, `KOLOR`, `KOLOR_2`, `X`, `Y`, `Z`, `PALIWO`, `ANGLE`) VALUES ('%d', '%d', '%d', '%d', '%f', '%f', '%f', '%d', '%f')",
	uids, model, kolor, kolor2, Float:x, Float:y, Float:z, paliwo, a);
	mysql_check();
	mysql_query2(zapyt);
	new uid = mysql_insert_id();
	PojazdInfo[uid][pUID] = uid;
	PojazdInfo[uid][pOwnerPostac] = uids;
	PojazdInfo[uid][pOwnerDzialalnosc] = 0;
	PojazdInfo[uid][pModel] = model;
	PojazdInfo[uid][pKolor] = kolor;
	PojazdInfo[uid][pKolor2] = kolor2;
	PojazdInfo[uid][pStan] = 1000;
	PojazdInfo[uid][pPrzebieg] = 0;
	format(PojazdInfo[uid][pDodatki], 32, "BRAK");
	PojazdInfo[uid][pGaz] = 0;
	PojazdInfo[uid][pTypPojazdu] = typ;
	PojazdInfo[uid][pTypPaliwa] = 0;
	PojazdInfo[uid][pMoc] = 0;
	format(PojazdInfo[uid][pTablice], 32, "Brak");
	PojazdInfo[uid][pX] = x;
	PojazdInfo[uid][pY] = y;
	PojazdInfo[uid][pZ] = z;
	PojazdInfo[uid][pVw] = 0;
	PojazdInfo[uid][pInt] = 0;
	PojazdInfo[uid][pAngle] = a;
	PojazdInfo[uid][pSpawn] = 0;
	PojazdInfo[uid][pLpg] = 0;
	PojazdInfo[uid][pPJ] = -1;
	PojazdInfo[uid][pPaliwo] = paliwo;
	PojazdInfo[uid][pLock] = 0;
	PojazdInfo[uid][pSilnik] = 0;
	PojazdInfo[uid][pUszkodzenie1] = 0;
	PojazdInfo[uid][pUszkodzenie2] = 0;
	PojazdInfo[uid][pUszkodzenie3] = 0;
	PojazdInfo[uid][pUszkodzenie4] = 0;
	PojazdInfo[uid][pBlokada] = 0;
	PojazdInfo[uid][pNaprawy] = 0;
	mysql_free_result();
	return uid;
}
stock PlayerObokPojazdu(playerid,carid)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:Dis;
	if (!IsPlayerConnected(playerid))return -1;
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(carid,x2,y2,z2);
	Dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(Dis);
}
Float:GetHeadingAngle(Float:targetX, Float:targetY, Float:entityX, Float:entityY)
{
	new
		Float:vectorX = targetX - entityX,
		Float:vectorY = targetY - entityY,
		Float:HeadingAngle;

	HeadingAngle = atan(-(vectorX/vectorY));

	if(vectorY < 0)
		HeadingAngle = (HeadingAngle >= 180) ? HeadingAngle - 180.0 : HeadingAngle + 180.0;

	return HeadingAngle;
}
forward Tempomacik();
public Tempomacik()
{
	new vehicleid,Float:rotZ,Float:velX,Float:velY,Float:velZ,Float:speed;
	ForeachEx(playerid, IloscGraczy)
	{
		vehicleid = GetPlayerVehicleID(KtoJestOnline[playerid]);

		if(vehicleid != 0 && GetPVarInt(KtoJestOnline[playerid], "Tempomat_Wlaczony") == 1)
		{
			speed = GetPVarFloat(KtoJestOnline[playerid], "Tempomat_Speed");
			GetVehicleVelocity(vehicleid, velX, velY, velZ);

			if(velX == 0.0 && velY == 0.0 && velZ == 0.0)
				GetVehicleZAngle(vehicleid, rotZ);
			else
				rotZ = Float:GetHeadingAngle(velX, velY, 0.0, 0.0);

			SetVehicleVelocity(vehicleid, speed * floatsin(-rotZ, degrees), speed * floatcos(-rotZ, degrees), velZ);
		}
	}
	return 1;
}
EnableCruiseControl(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		return 0;
	}
	else if(GetPVarInt(playerid, "Tempomat_Wlaczony") != 0)
	{
		return 0;
	}
	else
	{
		new vehicleid = GetPlayerVehicleID(playerid),
			Float:velX,
			Float:velY,
			Float:velZ;

		GetVehicleVelocity(vehicleid, velX, velY, velZ);

		new Float:speed = floatsqroot(velX * velX + velY * velY + velZ * velZ);

		if(Predkosc(playerid) > 20.0)
		{
			SetPVarFloat(playerid, "Tempomat_Speed", speed);

			SetPVarInt(playerid, "Tempomat_Wlaczony", 1);
			SendClientMessage(playerid, SZARY, "{DEDEDE}W³¹czy³eœ {88b711}tempomat{DEDEDE}, aby go wy³¹czyæ wciœnij ponownie {88b711}klawisz{DEDEDE} submisji b¹dz zmieñ prêdkoœæ pojazdu.");
		}
		else
		{
			SendClientMessage(playerid, SZARY, "{DEDEDE}Aby w³¹czyæ {88b711}tempomat minimalna prêdkoœæ pojazdu musi wynosiæ {88b711}20{DEDEDE}km.");
		}
	}
	return 1;
}
DisableCruiseControl(playerid)
{
	DeletePVar(playerid, "Tempomat_Wlaczony");
	DeletePVar(playerid, "Tempomat_Speed");
	SendClientMessage(playerid, BIALY, "Tempomat zosta³ wy³¹czony.");
	return 1;
}