#define T_IC		1
#define T_OOC		2
#define T_VRESET	3
#define T_VODP		4
#define T_IPODNIES	5
#define T_HOFFER	6
#define T_HZMNAZWY	7
#define T_HPODPIS	8
#define T_HODPIS	9
#define T_HOBIEKT	10
#define T_HAUDIO	11
#define T_HSZAFA	12
#define T_HNAPIS	13
#define T_BWYPLATA	14
#define	T_BPRZELEW	15
#define T_BWPLATA	16
#define T_OGASTRO	17
#define T_247K		18
#define T_KWB		19
#define T_SPAWNVEH	20
#define T_VHEALTH	21
#define T_VEHDEST	22
#define T_TM		23
#define T_GMX		24
#define T_OVEH		25
#define T_ALOGIN	26
#define T_AMMOL		27
#define T_IODLOZV	28
#define T_IODLOZ	29
#define T_HRTSELL	30
#define T_OKINV		31
#define T_OKVEH		32
#define T_OKHOUSE	33
#define T_OKITEM	34
#define T_BW		35
#define T_OINV		36
#define T_WHIPS		37
#define T_PLAC		38

stock UsunPLZnaki(string[])
{
	ForeachEx(i, strlen(string))
	{
	    if(string[i] == 'ê') string[i] = 'e';
	    if(string[i] == 'ó') string[i] = 'o';
	    if(string[i] == '¹') string[i] = 'a';
	    if(string[i] == 'œ') string[i] = 's';
	    if(string[i] == '³') string[i] = 'l';
	    if(string[i] == '¿') string[i] = 'z';
	    if(string[i] == 'Ÿ') string[i] = 'z';
	    if(string[i] == 'æ') string[i] = 'c';
	    if(string[i] == 'ñ') string[i] = 'n';
	}
}
stock Transakcja(typ, uid, uidt, guid, guidt, ile, uidi, war1, Float:war2, tresc[], data)
{
	UsunPLZnaki(tresc);
	new query[512];
	format(query, sizeof(query), "INSERT INTO `five_transakcje` SET `Typ` = '%d', `1UID` = '%d', `2UID` = '%d', `1GUID` = '%d', `2GUID` = '%d', `Ile` = '%d', `UIDI` = '%d', `War1` = '%d', `War2` = '%f', `String` = '%s', `Data` = '%d'", typ, uid, uidt, guid, guidt, ile, uidi, war1, war2, tresc, data);
	mysql_query(query);
}