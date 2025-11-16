AntiDeAMX();
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
#define T_RC        39
#define T_LOGOUT	40
#define T_BLOKADAK	41
#define T_WYSZEDL	42
#define T_WSZEDL	43
#define T_ANIM		44
#define T_KRZYK		45
#define T_SZEPT		46
#define T_KOLCZATKA	47
#define T_RAPORT	48
#define T_CDRZWI	49
#define T_OMANDAT	50
#define T_OBLOKADE	51
#define T_ELEKTRYKE	52
#define T_DGOOC		53
#define T_DGIC		54
#define T_VSPAWN	55
stock Transakcja(typ, uid, uidt, guid, guidt, Float:ile, uidi, war1, Float:war2, tresc[], data)
{
	UsunPLZnaki(tresc);
	Apostrof(tresc);
	new godzina,
		minuta,
        second;
	gettime(godzina, minuta, second);
	new m[3];
	getdate(m[0], m[1], m[2]);
	if(typ == T_VSPAWN)
	{
		if(war1 == 0)
		{
			printf("[UID_POJAZDU:%d][%02d-%02d-%d][%02d:%02d] Gracz %s odspawnowal auto.[KONIEC_LOGU]", uid, m[0], m[1], m[2], godzina, minuta, ImieGracza(uidt));
		}
		else
		{
			printf("[UID_POJAZDU:%d][%02d-%02d-%d][%02d:%02d] Gracz %s zespawnowal auto.[KONIEC_LOGU]", uidi, m[0], m[1], m[2], godzina, minuta, ImieGracza(uidt));
		}
	}
	if(typ == T_VHEALTH)
	{
		printf("[UID_POJAZDU:%d][%02d-%02d-%d][%02d:%02d] Gracz %s [UID: %d], [GUID: %d] uszkodzil pojazd z %f na %f.[KONIEC_LOGU]", uidt, m[0], m[1], m[2], godzina, minuta, ImieGracza(uid), DaneGracza[uid][gUID], DaneGracza[uid][gGUID],war2,ile);
	}
	else
	{
		format(zapyt, sizeof(zapyt), "INSERT INTO `five_transakcje` SET `Typ` = '%d', `1UID` = '%d', `2UID` = '%d', `1GUID` = '%d', `2GUID` = '%d', `Ile` = '%f', `UIDI` = '%d', `War1` = '%d', `War2` = '%f', `tekst_global` = '%s', `Data` = '%d'", typ, uid, uidt, guid, guidt, ile, uidi, war1, war2, tresc, data);
		print(zapyt);
		mysql_query(zapyt);
	}
}
