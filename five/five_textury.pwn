AntiDeAMX();
enum pText
{
	objUID,
	objModel,
	objTyp,
	objIndex,
	objNazwa[124],
	objRozmiar,
	objCzcionka[124],
	objSize,
	objBolt,
	objKol1[124],
	objKol2[124],
	objWysrotkowanie
}
new TextruaInfo[MAX_TEXTUR][pText];
forward ZaladujTextury();
public ZaladujTextury()
{
	new sql[ 500 ], id = false;
	mysql_query( "SELECT * FROM `five_textury`" );
	mysql_store_result( );
	while( mysql_fetch_row( sql ) )
	{
	    sscanf( sql, "p<|>i", id );
	    sscanf( sql, "p<|>dddds[124]ds[124]dds[124]s[124]d",
	    TextruaInfo[ id ][ objUID ],
	    TextruaInfo[ id ][ objModel ],
	    TextruaInfo[id][objTyp],
		TextruaInfo[id][objIndex],
		TextruaInfo[id][objNazwa],
		TextruaInfo[id][objRozmiar],
		TextruaInfo[id][objCzcionka],
		TextruaInfo[id][objSize],
		TextruaInfo[id][objBolt],
		TextruaInfo[id][objKol1],
		TextruaInfo[id][objKol2],
		TextruaInfo[id][objWysrotkowanie]
	    );
	    new uid = TextruaInfo[ id ][ objModel ];
	    if(TextruaInfo[id][objTyp] == 1)
	    {
	        new text[246];
	        format(text, sizeof(text), "%s", TextruaInfo[id][objNazwa]);
	        A_MT(text);
			A_KOLS(text);
			A_KOL(text);
	        SetDynamicObjectMaterialText(ObiektInfo[uid][ objSAMP ],TextruaInfo[id][objIndex],text,TextruaInfo[id][objRozmiar],TextruaInfo[id][objCzcionka], TextruaInfo[id][objSize],TextruaInfo[id][objBolt],HexToInt(TextruaInfo[id][objKol1]),HexToInt(TextruaInfo[id][objKol2]),TextruaInfo[id][objWysrotkowanie]);
	    }
	    else if(TextruaInfo[id][objTyp] == 2)
	    {
	        SetDynamicObjectMaterial(ObiektInfo[uid][ objSAMP ], TextruaInfo[id][objIndex], TextruaInfo[id][objRozmiar], TextruaInfo[id][objCzcionka], TextruaInfo[id][objKol1], HexToInt(TextruaInfo[id][objNazwa]));
	    }
	}
	mysql_free_result( );
	//printf("Textury   - %d", id);
	return 1;
}
stock LoadTexturs(vw)
{
	new sql[ 500 ], id = false;
	mysql_query( "SELECT * FROM `five_textury`" );
	mysql_store_result( );
	while( mysql_fetch_row( sql ) )
	{
	    sscanf( sql, "p<|>i", id );
	    sscanf( sql, "p<|>dddds[124]ds[124]dds[124]s[124]d",
	    TextruaInfo[ id ][ objUID ],
	    TextruaInfo[ id ][ objModel ],
	    TextruaInfo[id][objTyp],
		TextruaInfo[id][objIndex],
		TextruaInfo[id][objNazwa],
		TextruaInfo[id][objRozmiar],
		TextruaInfo[id][objCzcionka],
		TextruaInfo[id][objSize],
		TextruaInfo[id][objBolt],
		TextruaInfo[id][objKol1],
		TextruaInfo[id][objKol2],
		TextruaInfo[id][objWysrotkowanie]
	    );
	    new uid = TextruaInfo[ id ][ objModel ];
	    if(ObiektInfo[uid][objvWorld] == vw)
		{
		    if(TextruaInfo[id][objTyp] == 1)
		    {
		        new text[246];
		        format(text, sizeof(text), "%s", TextruaInfo[id][objNazwa]);
		        A_MT(text);
				A_KOLS(text);
				A_KOL(text);
		        SetDynamicObjectMaterialText(ObiektInfo[uid][ objSAMP ],TextruaInfo[id][objIndex],text,TextruaInfo[id][objRozmiar],TextruaInfo[id][objCzcionka], TextruaInfo[id][objSize],TextruaInfo[id][objBolt],HexToInt(TextruaInfo[id][objKol1]),HexToInt(TextruaInfo[id][objKol2]),TextruaInfo[id][objWysrotkowanie]);
		    }
			else if(TextruaInfo[id][objTyp] == 2)
			{
				SetDynamicObjectMaterial(ObiektInfo[uid][ objSAMP ], TextruaInfo[id][objIndex], TextruaInfo[id][objRozmiar], TextruaInfo[id][objCzcionka], TextruaInfo[id][objKol1], HexToInt(TextruaInfo[id][objNazwa]));
			}
	    }
	}
	mysql_free_result( );
	//printf("Textury   - %d", id);
	return 1;
}
forward DodajTexture(model, typ, index, rozmiar, czcionka[], size, bolt, kol1[], kol2[], wysrodkowanie, nazwa[]);
public DodajTexture(model, typ, index, rozmiar, czcionka[], size, bolt, kol1[], kol2[], wysrodkowanie, nazwa[])
{
    if(typ == 1)
	{
		new zs=0, strss[256];
		format(strss, sizeof(strss), "SELECT * FROM `five_textury` WHERE `model`=%d AND `typ` = %d", model, 2);
		mysql_query(strss);
		mysql_store_result();
		while(mysql_fetch_row_format(strss, "|"))
		{
			zs++;
		}
		if(zs != 0)
		{
		    new sql[100];
			format( sql, sizeof( sql ), "DELETE FROM `five_textury` WHERE `model` = %d", model );
			mysql_query( sql );
		}
		new text[246];
	    format(text, sizeof(text), "%s", nazwa);
	    A_MT(text);
		A_KOLS(text);
		A_KOL(text);
	    SetDynamicObjectMaterialText(ObiektInfo[model][objSAMP],index,text,rozmiar,czcionka, size,bolt,HexToInt(kol1),HexToInt(kol2),wysrodkowanie);
	}
	if(typ == 2)
	{
		new za=0, stra[256];
		format(stra, sizeof(stra), "SELECT * FROM `five_textury` WHERE `model`=%d AND `typ` = %d", model, 1);
		mysql_query(stra);
		mysql_store_result();
		while(mysql_fetch_row_format(stra, "|"))
		{
			za++;
		}
		if(za != 0)
		{
		    new sql[100];
			format( sql, sizeof( sql ), "DELETE FROM `five_textury` WHERE `model` = %d", model );
			mysql_query( sql );
		}
		SetDynamicObjectMaterial(ObiektInfo[model][objSAMP], index, rozmiar, czcionka, kol1, HexToInt(nazwa));
	}
	new z=0, str[256];
	format(str, sizeof(str), "SELECT * FROM `five_textury` WHERE `model`=%d AND `index` = %d LIMIT 1", model, index);
	mysql_query(str);
	mysql_store_result();
	while(mysql_fetch_row_format(str, "|"))
	{
		z++;
	}
	if(z == 0)
	{
		new id = GetFreeSQLUID("five_textury", "ID");
		format(zapyt, sizeof(zapyt), "INSERT INTO `five_textury` (`ID` ,`model` ,`typ` ,`index` ,`rozmiar`,`czcionka`,`size`,`bolt`,`kol1`,`kol2`,`wysrodkowanie`,`nazwa`) VALUES ('%d', '%d', '%d', '%d', '%d', '%s', '%d', '%d', '%s', '%s', '%d', '%s')",
		id, model, typ, index, rozmiar, czcionka, size, bolt, kol1, kol2, wysrodkowanie, nazwa);
		mysql_check();
		mysql_query(zapyt);
	}
	else
	{
	    /*format(strs, sizeof(strs), "UPDATE `five_textury` SET `model` = '%d',`typ` = '%d' ,`index` = '%d' ,`rozmiar` = '%d',`czcionka` = '%s',`size` = '%d',`bolt` = '%d',`kol1` = '%s',`kol2` = '%s',`wysrodkowanie` = '%d',`nazwa` = '%s' WHERE `model` = '%d' AND `index` = '%d'",
		model, typ, index, rozmiar, czcionka, size, bolt, kol1, kol2, wysrodkowanie, nazwa, typ, index);
	    mysql_query(strs);*/
		strdel(zapyt, 0, 1024);
	    format(zapyt, sizeof(zapyt), "UPDATE `five_textury` SET `model` = '%d', `typ` = '%d', `index` = '%d', `rozmiar` = '%d', `czcionka` = '%s', `size` = '%d', `bolt` = '%d', `kol1` = '%s', `kol2` = '%s', `nazwa` = '%s', `wysrodkowanie` = '%d' WHERE `model` = '%d' AND `index` = '%d'",
		model,
		typ,
		index,
		rozmiar,
		czcionka,
		size, bolt,
		kol1,
		kol2,
		nazwa,
		wysrodkowanie,
		model,
		index);
		mysql_check();
		mysql_query2(zapyt);
		mysql_free_result();
	}
 	return 1;
}
CMD:amt( playerid, params[ ] )
{
	//printf("U¿yta komenda amt");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(!GraczPremium(playerid))
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:" ,"{DEDEDE}Nie posiadasz {88b711}konta premium{DEDEDE}.", "Zamknij", "" );
			return 0;
		}
		if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			return 0;
		}
		new nazwa[124], index, rozmiar, czcionka[124], size, bolt, col[124], colt[124], wys;
		if( sscanf( params, "dds[124]dds[124]s[124]ds[124]",index, rozmiar, czcionka, size, bolt, col, colt, wys, nazwa) )
		{
			SendClientMessage( playerid, SZARY, "Aby na³o¿yæ text wpisz: /amt [index] [material size] [czcionka] [size] [bolt 1-0] ..." );
			SendClientMessage( playerid, SZARY, "... [kolor textu - 0xFF[...] kolor HTML] [kolor t³a - 0xFF[...] kolor HTML] [text aling] [text]." );
			return 1;
		}
		new myobject = GetPVarInt(playerid, "idobiktu");
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		if(index < 0 || index > 10)
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie indexu ({88b711}0-10{DEDEDE}).", "Zamknij", "" );
			return 0;
		}
		if(size < 0 || size > 100)
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie rozmiaru tekstu ({88b711}0-100{DEDEDE}).", "Zamknij", "" );
			return 0;
		}
		if(bolt < 0 || bolt > 1)
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie pogrubienia ({88b711}0-1{DEDEDE}).", "Zamknij", "" );
			return 0;
		}
		if(wys < 0 || wys > 2)
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie marginesu ({88b711}0-2{DEDEDE}).", "Zamknij", "" );
			return 0;
		}
		if(rozmiar == 10 || rozmiar == 20 || rozmiar == 30 || rozmiar == 40 || rozmiar == 50 || rozmiar == 60 || rozmiar == 70 || rozmiar == 80 || rozmiar == 90 || rozmiar == 100)
		{
			DodajTexture(myobject, 1, index, rozmiar, czcionka, size, bolt, col, colt, wys, nazwa);
		}
		else
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie material size ({88b711}10-100{DEDEDE}, tylko liczby dziesiêtne).", "Zamknij", "" );
		}
	}
	return 1;
}
CMD:mt( playerid, params[ ] )
{
	//printf("U¿yta komenda mt");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	/*if(!GraczPremium(playerid))
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:" ,"{DEDEDE}Nie posiadasz {88b711}konta premium{DEDEDE}.", "Zamknij", "" );
		return 0;
	}*/
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		return 0;
	}
	new nazwa[124], index, rozmiar, czcionka[124], size, bolt, col[124], colt[124], wys;
	if( sscanf( params, "dds[124]dds[124]s[124]ds[124]",index, rozmiar, czcionka, size, bolt, col, colt, wys, nazwa) )
	{
		SendClientMessage( playerid, SZARY, "{DEDEDE}Aby na³o¿yæ {88b711}text{DEDEDE} wpisz: {88b711}/mt [index] [material size] [czcionka] [size] [bolt 1-0]{DEDEDE} ..." );
		SendClientMessage( playerid, SZARY, "... {88b711}[kolor textu - 0xFF[...] kolor HTML] [kolor t³a - 0xFF[...] kolor HTML] [text aling] [text]." );
	    return 1;
	}
	new myobject = GetPVarInt(playerid, "idobiktu");
	if(myobject == 0)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
	    return 0;
	}
	if(index < 0 || index > 10)
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie indexu ({88b711}0-10{DEDEDE}).", "Zamknij", "" );
		return 0;
	}
	if(size < 0 || size > 200)
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie rozmiaru tekstu ({88b711}0-200{DEDEDE}).", "Zamknij", "" );
		return 0;
	}
	if(bolt < 0 || bolt > 1)
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie pogrubienia ({88b711}0-1{DEDEDE}).", "Zamknij", "" );
		return 0;
	}
	if(wys < 0 || wys > 2)
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie marginesu ({88b711}0-2{DEDEDE}).", "Zamknij", "" );
		return 0;
	}
	if(rozmiar == 10 || rozmiar == 20 || rozmiar == 30 || rozmiar == 40 || rozmiar == 50 || rozmiar == 60 || rozmiar == 70 || rozmiar == 80 || rozmiar == 90 || rozmiar == 100 ||
	rozmiar == 110 || rozmiar == 120 || rozmiar == 130 || rozmiar == 140 || rozmiar == 150 || rozmiar == 160 || rozmiar == 170 || rozmiar == 180 || rozmiar == 190 || rozmiar == 120)
	{
		DodajTexture(myobject, 1, index, rozmiar, czcionka, size, bolt, col, colt, wys, nazwa);
	}
	else
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie material size ({88b711}10-200{DEDEDE}, tylko liczby dziesiêtne).", "Zamknij", "" );
	}
	return 1;
}
CMD:mo( playerid, params[ ] )
{
	//printf("U¿yta komenda mo");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!ZarzadzanieBudynkiem(GetPlayerVirtualWorld(playerid), playerid))
	{
	    return 0;
	}
	/*if(!GraczPremium(playerid))
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:" ,"{DEDEDE}Nie posiadasz {88b711}konta premium{DEDEDE}.", "Zamknij", "" );
		return 0;
	}*/
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		return 0;
	}
	new model, id, st[124], st2[124], st3[124];
	if( sscanf( params, "iis[124]s[124]s[124]", model, id,st, st2, st3 ) )
	    return SendClientMessage( playerid, SZARY, "{DEDEDE}Aby na³o¿yæ {88b711}texture{DEDEDE} wpisz: {88b711}/mo [index] [id obiektu] [txdname] [texturename] [materialcolor]." );
	new myobject = GetPVarInt(playerid, "idobiktu");
	if(myobject == 0)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
	    return 0;
	}
	if(model < 0 || model > 10)
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie indexu ({88b711}0-10{DEDEDE}).", "Zamknij", "" );
		return 0;
	}
	if(model < 0 || model > 99999)
	{
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie {88b711}id{DEDEDE} obiektu.", "Zamknij", "" );
		return 0;
	}
	DodajTexture(myobject, 2, model, id, st, 0, 0, st2, " ", 0, st3);
	return 1;
}
CMD:amo( playerid, params[ ] )
{
	//printf("U¿yta komenda amo");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(!GraczPremium(playerid))
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:" ,"{DEDEDE}Nie posiadasz {88b711}konta premium{DEDEDE}.", "Zamknij", "" );
			return 0;
		}
		if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			return 0;
		}
		new model, id, st[124], st2[124], st3[124];
		if( sscanf( params, "iis[124]s[124]s[124]", model, id,st, st2, st3 ) )
			return SendClientMessage( playerid, SZARY, "U¿yj: /amo [index] [id obiektu] [txdname] [texturename] [materialcolor]." );
		new myobject = GetPVarInt(playerid, "idobiktu");
		if(myobject == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie nie {88b711}edytujesz{DEDEDE} ¿adnego obiektu.", "Zamknij", "");
			return 0;
		}
		if(model < 0 || model > 10)
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie indexu ({88b711}0-10{DEDEDE}).", "Zamknij", "" );
			return 0;
		}
		if(model < 0 || model > 99999)
		{
			dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Z³e u¿ycie {88b711}id{DEDEDE} obiektu.", "Zamknij", "" );
			return 0;
		}
		DodajTexture(myobject, 2, model, id, st, 0, 0, st2, " ", 0, st3);	
	}
	return 1;
}