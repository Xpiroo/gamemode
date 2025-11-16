AntiDeAMX();
enum minfo
{
	mUID,
	mOwner,
	mTyp,
	mWar1,
	mWar2,
	mTermin,
	mNazwa[50],
	mCena,
	mIlosc
};
new MagazynInfo[MAX_MAGAZYN][minfo];
forward UsunMagazyn(uid);
public UsunMagazyn(uid)
{
	new sql[100];
	format( sql, sizeof( sql ), "DELETE FROM `five_magazyny` WHERE `ID` = %d", uid );
	mysql_query( sql );
    MagazynInfo[uid][mUID] = 0;
	MagazynInfo[uid][mOwner] = 0;
	MagazynInfo[uid][mTyp] = 0;
	MagazynInfo[uid][mWar1] = 0;
	MagazynInfo[uid][mWar2] = 0;
	MagazynInfo[uid][mTermin] = -1;
	MagazynInfo[uid][mCena] = 0;
	MagazynInfo[uid][mIlosc] = 0;
	return 1;
}
forward ZaladujMagazyny();
public ZaladujMagazyny()
{
	new result[524], i = 0;
    format(zapyt, sizeof(zapyt), "SELECT * FROM `five_magazyny`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
    	sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>dddddds[50]dd", MagazynInfo[uid][mUID],
		    MagazynInfo[uid][mOwner],
		    MagazynInfo[uid][mTyp],
		    MagazynInfo[uid][mWar1],
		    MagazynInfo[uid][mWar2],
			MagazynInfo[uid][mTermin],
			MagazynInfo[uid][mNazwa],
			MagazynInfo[uid][mCena],
		    MagazynInfo[uid][mIlosc]);
		i++;
	}
	//printf("Magazyny:       - %d", i);
	mysql_free_result();
}
forward Magazyn(playerid, dialogid, naglowek[], typ, dzialalnosc, buttone[], buttons[]);
public Magazyn(playerid, dialogid, naglowek[], typ, dzialalnosc, buttone[], buttons[])
{
	new item_list[64], items_list[1024], find;
	if(typ == TYP_MAGAZYN)
	{
	format(items_list, sizeof(items_list), "%s\n{88b711}UID\t\tIloœæ\t\tCena\t\tNazwa{DEDEDE}",items_list);
	}
	ForeachEx(i, MAX_MAGAZYN)
	{
		if(MagazynInfo[i][mOwner] == dzialalnosc && MagazynInfo[i][mUID] != 0)
		{
		    //new text[246], text2[30];
			//sscanf(MagazynInfo[i][mNazwa], "p<(>s[246]s[30]", text, text2);
			format(item_list, sizeof(item_list), "%d\t\t%dx\t\t%d$\t\t%s", MagazynInfo[i][mUID], MagazynInfo[i][mIlosc], MagazynInfo[i][mCena], MagazynInfo[i][mNazwa]);
			format(items_list, sizeof(items_list), "%s\n%s", items_list, item_list);
			find++;
  		}
	}
	if(find == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Magazyn nale¿¹cy do tej {88b711}dzia³alnoœci{DEDEDE} jest pusty.", "Zamknij", "");
	}
	else
	{
		dShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, naglowek, items_list, buttone, buttons);
	}
	return 1;
}
forward JestWMagazynie(owner, typ);
public JestWMagazynie(owner, typ)
{
	new test = 0;
	ForeachEx(i, MAX_MAGAZYN)
	{
	    if(MagazynInfo[i][mOwner] == owner && MagazynInfo[i][mTyp] == typ)
		{
		    test = i;
		    break;
		}
	}
	return test;
}
forward JestWMagazynieTyp(owner, typ, war);
public JestWMagazynieTyp(owner, typ, war)
{
	new test = 0;
	ForeachEx(i, MAX_MAGAZYN)
	{
	    if(MagazynInfo[i][mOwner] == owner && MagazynInfo[i][mTyp] == typ && MagazynInfo[i][mWar1] == war)
		{
		    test = i;
		    break;
		}
	}
	return test;
}
forward DodajDoMagazynu(owner, typ, war1, war2, nazwa[], cena, ilosc);
public DodajDoMagazynu(owner, typ, war1, war2, nazwa[], cena, ilosc)
{
	new uid = JestWMagazynie(owner, typ);
	new war = JestWMagazynieTyp(owner, typ, war1);
	if(uid != 0)
	{
	    if(typ == 1 || typ == 19 || typ == 22 || typ == 20 || typ == 21|| typ == 29|| typ == 30|| typ == 31 || typ == 32 || typ == 33 || typ == 38 || typ == P_WODA || typ == P_ZARCIE || typ == P_PIWO || typ == 47 ||
		typ == P_SKLADNIK_MARYCHA || typ == P_SKLADNIK_AMFA || typ == P_SKLADNIK_KOKA|| typ == P_SKLADNIK_EXTASA|| typ == P_SKLADNIK_LSD|| typ == P_SKLADNIK_GRZYBY|| typ == P_SKLADNIK_HERA|| typ == P_SKLADNIK_MEFEDRON ||
		typ == P_LEK)
		{
		    if(war != 0)
		    {
                MagazynInfo[war][mCena] = cena;
			    MagazynInfo[war][mIlosc] += ilosc;
				ZapiszMagazyn(war);
		    }else{
				new itemid = GetFreeSQLUID("five_magazyny", "ID");
				format(zapyt, sizeof(zapyt), "INSERT INTO `five_magazyny` (`ID`, `mOwner`, `mTyp`, `mWar1`, `mWar2`, `mNazwa`, `mCena`, `mIlosc`) VALUES ('%d', '%d', '%d', '%d', '%d', '%s', '%d', '%d')",
				itemid, owner, typ, war1, war2, nazwa, cena, ilosc);
				mysql_check();
				mysql_query2(zapyt);
				MagazynInfo[itemid][mUID] = itemid;
				MagazynInfo[itemid][mOwner] = owner;
				MagazynInfo[itemid][mTyp] = typ;
				MagazynInfo[itemid][mWar1] = war1;
				MagazynInfo[itemid][mWar2] = war2;
				format(MagazynInfo[itemid][mNazwa], 50, "%s", nazwa);
				MagazynInfo[itemid][mCena] = cena;
				MagazynInfo[itemid][mIlosc] = ilosc;
				ZapiszMagazyn(itemid);
				mysql_free_result();
			}
		}
		else
		{
		MagazynInfo[uid][mCena] = cena;
	    MagazynInfo[uid][mIlosc] += ilosc;
		ZapiszMagazyn(uid);
		}
	}
	else
	{
		new itemid = GetFreeSQLUID("five_magazyny", "ID");
		format(zapyt, sizeof(zapyt), "INSERT INTO `five_magazyny` (`ID`, `mOwner`, `mTyp`, `mWar1`, `mWar2`, `mNazwa`, `mCena`, `mIlosc`) VALUES ('%d', '%d', '%d', '%d', '%d', '%s', '%d', '%d')",
		itemid, owner, typ, war1, war2, nazwa, cena, ilosc);
		mysql_check();
		mysql_query2(zapyt);
		MagazynInfo[itemid][mUID] = itemid;
		MagazynInfo[itemid][mOwner] = owner;
		MagazynInfo[itemid][mTyp] = typ;
		MagazynInfo[itemid][mWar1] = war1;
		MagazynInfo[itemid][mWar2] = war2;
		format(MagazynInfo[itemid][mNazwa], 50, "%s", nazwa);
		MagazynInfo[itemid][mCena] = cena;
		MagazynInfo[itemid][mIlosc] = ilosc;
		ZapiszMagazyn(itemid);
		mysql_free_result();
	}
	return 1;
}
forward ZapiszMagazyn(uid);
public ZapiszMagazyn(uid)
{
	strdel(zapyt, 0, 1024);
    format(zapyt, sizeof(zapyt),
	"UPDATE `five_magazyny` SET `mCena`=%d, `mIlosc`=%d WHERE `ID`='%d'",
	MagazynInfo[uid][mCena],
	MagazynInfo[uid][mIlosc],
	uid);
    mysql_query(zapyt);
	return 1;
}
