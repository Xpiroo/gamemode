#define COLOR_ORANGE 0xFF8040FF
#define COLOR_RED 0xFF0000FF
#define COLOR_LIGHTGREEN 0x80FF00FF
#define COLOR_YELLOW 0xFFFF00FF
#define POL_ZOLTY 0xFFFF00FF
#define COLOR_LIGHTRED 0xFF0000AA
#define CINFO 0x0088FFFF
#define COLOR_WHITE 0xFFFFFFFF
#define CWARN 0xFF4444FF
#define COLOR_GREEN 0x008000FF
#define POL_ZIELONY 0x73C315FF
#define COLOR_LIGHTBLUE 0x00BFFFAA
#define KOLOR_CZERWONY 0xE60000FF
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000FFFF
#define KOLOR_JASNONIEBIESKI 0x0080FFFF

#define MAX_WEAPONS 7
#define MAX_GANGS 32
#define MAX_GANG_MEMBERS 6
#define MAX_GANG_NAME 16
#define MAX_CASINO 3
#define MAX_SAVE 64

#define CP_BANK     0
#define CP_PIRATE   1
#define CP_AMMU     2
#define CP_SALON    3
#define CP_SEXSHOP  4
#define CP_BAR      5
#define CP_CALIGULA 6
#define CP_ZIP      7
#define CP_BINCO    8
#define CP_TATOO    9
#define CP_BOTIQUE  10
#define CP_STARFISH 11
#define CP_BAZA     12
#define CP_HATA     13

#define P_SALON     0
#define P_SEXSHOP   1
#define P_BAR       2
#define P_CALIGULA  3
#define P_ZIP       4
#define P_BINCO     5
#define P_TATOO     6
#define P_BOTIQUE   7
#define P_STARFISH  8

#define MAX_POINTS 14

//new iJailSpawnSet[MAX_PLAYERS];
//new Naprawa1;
new Float:Pos[MAX_PLAYERS][3];
new wpisaltune[200];
new wpisal100hp[200];
new wpisalkam[200];
new wpisalodlicz[200];
new hackingbans;
new weaponhackingbans;
new CashScoreOld;
new Dom,Dom2,Brama;
new Bank[MAX_PLAYERS];
new rampid[MAX_PLAYERS] = {-1, ...};
new ramptypes[] = {
1503, // curvy normal one
1660, // concrete one with pipes
1245, // plank of wood against a box
1631, // water ramp with rocks
1632, // normal water ramp
1655, // wide water ramp
};
new Float:LocX = 0.0;
new Float:LocY = 0.0;
new Float:LocZ = 0.0;
new Float:Ang;
new playerramptypes[MAX_PLAYERS];
new gPlayerName[MAX_PLAYERS][MAX_PLAYER_NAME];
new WpisalPraca[MAX_PLAYERS];
new Vip[MAX_PLAYERS];
new awertsat;
new Godz[MAX_PLAYERS];
new Min[MAX_PLAYERS];
new Sek[MAX_PLAYERS];
new playerWeapons[MAX_PLAYERS][MAX_WEAPONS];
new savedWeapons[MAX_SAVE][MAX_WEAPONS];
new gangMembers[MAX_GANGS][MAX_GANG_MEMBERS];
new gangNames[MAX_GANGS][MAX_GANG_NAME];
new gangInfo[MAX_GANGS][3]; 
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
new gangInvite[MAX_PLAYERS];
new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];
new Wpisalall[200];
new kasa[MAX_PLAYERS];
new respekt[MAX_PLAYERS];
new interior[MAX_PLAYERS];
new Nick[MAX_PLAYERS]; 
new StrM[256];
new playermuted[200];
new MayBeKicked1[MAX_PLAYERS];
new WpisalLos[MAX_PLAYERS];
new WpisalBron[MAX_PLAYERS];
new LoginAutorG[MAX_PLAYERS];
new SAMtimervar;
new SAM_M[MAX_PLAYERS];
new kupilcar[200];
new wpisalsiema[200];
new glob391CC[200][1];
new Arena[256];
new tele[MAX_PLAYERS];
new Wojsko[256];
new Granat[256];
new RPG[256];
new killsinarow[MAX_PLAYERS];
new Float:aa2,Float: b2,Float: c2;
new iSpawnSet[MAX_PLAYERS];
new bounty[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];

new playerColors[100] = {
0x9AD6DAFF,0xFF734AFF,0xDC143CFF,0x98F5FFFF,0x7FFFD4FF,0x912CEEFF,0xC00040FF,0x66cc99FF,0x00ccccFF,0x33ccffFF,
0x33FFFFFF,0x009933FF,0xFF3333FF,0x3333CCFF,0x003366FF,0x008080FF,0xB22222FF,0xFF1493FF,0x8A2BE2FF,0x32CD32FF,
0xE0FFFFFF,0x00BFFFFF,0xFF6030FF,0xFFB100FF,0x406090FF,0x0000FFFF,0x8000FFFF,0x40E010FF,0xFF8040FF,0xFF00F0FF,
0xC0FF50FF,0x80FFC0FF,0x8020FFFF,0x40A0E0FF,0xFFFF40FF,0x008040FF,0xC02050FF,0xFFA070FF,0xFF8010FF,0xFF2030FF,
0x80A0C0FF,0x80C040FF,0x24C005FF,0x00FFFFFF,0x00A0D0FF,0x004070FF,0x80E0FFFF,0x8020B0FF,0xA79C20FF,0x0080B0FF,
0x80C0FFFF,0x004080FF,0xE0D560FF,0xFF00D5FF,0xF4A460FF,0x4169E1FF,0x006400FF,0x00FFFFFF,0xDAA520FF,0x9370DBFF,
0x000080FF,0xDC143CFF,0xFF4500FF,0x708090FF,0xFF6347FF,0x800080FF,0x00FF7FFF,0x20B2AAFF,0xFF1493FF,0x6633ffFF,
0x00ff99FF,0xcccc00FF,0xffcc00FF,0xff9900FF,0xcc66ffFF,0x5F9F9FFF,0x7093DBFF,0x238E23FF,0x4D4DFFFF,0x3333ffFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
0x3FE65CFF,0xFFD720FF,0xBD34DAFF,0x54137DFF,0xAF2FF3FF,0x4B8987FF,0xE3AC12FF,0xC1F7ECFF,0xA04E0AFF,0xD8C762FF
};
new vehName[][] = { "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier",
"Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy",
"Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick",
"News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster",
"Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
"Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune",
"Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix",
"Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville", "Tiller", "Utility Trailer" };
new Float:PozycjeSpawnuLabirynt [13][4] = {
{1101.1650,1360.4152,10.8240,268.3634},
{1155.7495,1352.6552,10.8490,122.9753},
{1101.2443,1346.8594,10.8240,261.1332},
{1143.0187,1341.5460,10.8490,123.5786},
{1171.5188,1334.0542,10.8490,131.4120},
{1166.9915,1311.9561,10.8490,84.7249},
{1099.7155,1306.1665,10.8240,162.3598},
{1170.7175,1301.4602,10.8490,103.5250},
{1171.6846,1227.1056,10.8490,25.1909},
{1103.7914,1229.2970,10.8240,330.6704},
{1101.6595,1274.1641,10.8240,241.3696},
{1134.9075,1255.1561,10.8240,241.6830},
{1138.6971,1242.6146,10.8490,331.6830}
};
new Float:PozycjeSpawnuAreny[15][4] = {
{2618.1382,2712.5740,36.5386,359.7468},
{2619.8621,2735.2429,23.8222,358.4935},
{2648.9651,2709.1841,19.3222,1.2903},
{2649.6755,2734.4734,10.8203,357.8437},
{2599.0779,2800.9829,10.8203,270.1096},
{2609.9302,2809.4607,10.8203,43.5909},
{2575.4382,2848.7029,19.9922,178.3254},
{2584.8076,2800.2007,10.8203,177.0721},
{2587.6609,2772.6104,13.4851,86.2045},
{2551.2422,2726.5503,10.8203,73.9844},
{2544.7126,2711.3955,10.8130,25.7306},
{2516.1624,2757.4250,10.8203,17.8972},
{2515.7842,2841.4802,10.8203,214.6490},
{2599.9783,2778.0479,23.8222,173.6020},
{2601.2085,2793.4153,32.4760,87.1446}
};
new Float:PozycjeSpawnuwojska[6][4] = {
{285.3885,2037.1829,17.6406,166.1406},
{264.8102,2012.4924,17.6406,268.6199},
{285.5188,1975.9672,17.6406,78.2184},
{380.7642,1949.6378,17.6406,85.9056},
{294.2708,1865.4301,17.6406,268.1395},
{224.9764,2014.9268,17.6406,268.2866}
};
new Float:PozycjeSpawnugranat[4][4] = {
{-2.4651,1565.3538,12.7500},
{53.1568,1540.4901,12.7500},
{14.9365,1461.6990,14.9136},
{-38.1285,1482.8934,12.7500}
};
new Float:PozycjeSpawnurpg[13][4] = {
{4441.2920,7045.1689,9.3828},
{4503.1333,7071.4565,2.2028},
{4281.6152,7116.6099,3.0124},
{4466.6274,7100.5073,12.7086},
{4550.6196,7044.3970,12.1640},
{4494.7153,7051.1787,2.7649},
{4521.4722,7095.8955,15.6932},
{4364.1021,7115.8047,3.0124},
{4470.8501,7058.0493,2.8616},
{4281.6152,7116.6099,3.0124},
{4493.7930,7051.0439,12.9334},
{4422.9526,7088.7554,3.0124},
{4494.7153,7051.1787,2.7649}
};
new Float:gRandomPlayerSpawns[49][3] = {
{2028.1071,1008.3978,10.8203},
{2164.6570,960.4089,15.6720},
{2090.8835,1297.4596,10.8203},
{1956.2605,1343.0405,15.3746},
{2312.5542,1390.3867,42.8203},
{2474.4604,1358.0571,10.8203},
{2782.3220,1296.3235,10.7500},
{2001.3075,1521.1016,17.0682},
{1664.4908,1557.4963,10.8119},
{2213.6536,1838.9110,11.8359},
{2032.2949,1915.8035,12.3359},
{2187.2817,1983.1500,10.8203},
{2087.0928,2083.2539,11.0579},
{2293.1670,2451.3333,10.8203},
{2112.5537,2740.5444,10.8203},
{363.4508,2536.6797,16.6741},
{1322.2528,1264.5836,10.8203},
{1023.1157,1838.7200,11.2218},
{2528.2898,-1668.0345,15.1691},
{-1954.2181,289.1571,35.4688},
{-793.1560,-1868.0883,11.6048},
{-525.3211,-502.2457,25.5234},
{-1091.5300,-1638.4167,76.3672},
{1886.2944,-1366.3239,19.1406},
{2267.7332,550.6624,7.7802},
{-352.7289,1635.2131,198.4125},
{2441.0500,1053.5159,57.5016},
{-1686.9789,-162.8569,17.0703},
{1643.1482,2525.0791,698.3438},
{1862.5520,-2099.1023,454.8469},
{-1822.9243,551.5527,234.8874},
{320.7538,-1870.4171,2.7953},
{-1260.7089,2490.4297,1485.9249},
{318.5862,1421.8171,873.8586},
{-662.9370,398.4651,1977.3617},
{1888.8813,2339.3291,10.8203},
{1692.1621,-1945.8219,13.5469},
{1555.9583,-1263.1283,277.8734},
{2768.0183,-1876.4691,9.7446},
{1126.2168,-2037.0676,69.8836},
{-2742.0972,-331.0944,7.1839},
{-2417.0098,-595.2660,132.7109},
{-2124.9939,-824.7352,32.0234},
{-1953.9169,-858.5871,32.0312},
{-1462.2815,-1552.6068,101.7578},
{-1059.8657,-1018.8507,129.2119},
{-1031.1194,-653.1036,32.0078},
{-83.0185,-353.9785,1.4297},
{878.3464,-29.6882,63.1953}

};
new Float:gCopPlayerSpawns[1][3] = {
{2289.8579,2451.8171,10.8203}
};
new Float:checkCoords[MAX_POINTS][4] = {
{-36.5483,-57.9948, -17.2655,-49.2967},     //BANK
{1894.6128,1445.3431, 2084.9739,1637.8186}, //PIRATE
{284.0546,-86.4384, 302.9315,-56.6674},     //AMMUNATION
{-2016.7003,200.5211, -1899.6112,329.9724}, //SALON
{-115.9544,-24.2706, -99.1631,-7.1391},     //SEXSHOP
{487.6558,-88.5900, 512.0635, -67.7503},    //BAR
{2216.7971,1638.0493, 2255.2097,1714.0806}, //CALIGULA
{144.9131,-96.0927, 177.4128,-70.7923},    	//ZIP
{201.4462,-112.4556, 218.5237,-95.1238},    //BINCO
{-204.7623,-44.0326, -200.2330,-39.8128},   //TATOO
{416.7485,-84.4242, 422.6890,-74.0611},     //BOTIQUE
{2100.6367,1841.2338, 2352.1677,2014.0052},  //STARFISH
{1928.9760,2397.9697, 1954.1478,2426.1018},   //BAZA LVPD
{1916.5337,2427.3633, 1924.9414,2437.2817} //HATA
};
new Float:checkpoints[MAX_POINTS][3] = {
{-22.2549,-55.6575,1003.5469},
{2000.3132,1538.6012,13.5859},
{291.0004,-84.5168,1001.5156},
{-1968.8003,299.3703,35.1719}, //SALON
{-103.5525,-22.4661,1000.7188},
{501.4927,-75.4323,998.7578},
{2235.5408,1679.0402,1008.3594},
{161.1875,-79.9915,1001.8047},
{207.5640,-97.8188,1005.2578},
{-203.4864,-41.2045,1002.2734},
{418.5547,-80.1667,1001.8047},
{2163.3354,1904.5193,10.8125},
{1939.3109,2410.9191,11.0192},
{1924.7462,2434.3640,12.4012}
};
new checkpointType[MAX_POINTS] = {
	CP_BANK,
	CP_PIRATE,
	CP_AMMU,
	CP_SALON,
	CP_SEXSHOP,
	CP_BAR,
	CP_CALIGULA,
	CP_ZIP,
	CP_BINCO,
	CP_TATOO,
	CP_BOTIQUE,
	CP_STARFISH,
	CP_BAZA,
	CP_HATA
      };

#define MAX_PROPERTIES	9
new propertyNames[MAX_PROPERTIES][32] = {
	"Salon Samochodowy",
	"Sex Shop",
	"Bar Shithole",
	"Kasyno Caligula's",
	"Sklep Zip",
	"Sklep Binco",
	"Salon Tatua¿u",
	"Botique",
	"Kasyno Star Fish"
};
new propertyValues[MAX_PROPERTIES] = {
	80000,
	25000,
	30000,
	100000,
	20000,
	15000,
	30000,
	23000,
	200000
};
new propertyEarnings[MAX_PROPERTIES] = {
	8000,
	2500,
	3000,
	10000,
	2000,
	1500,
	3000,
	2300,
	20000,
};
