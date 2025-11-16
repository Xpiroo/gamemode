#include <a_samp>
#include <a_mysqlfive>
#include <sscanf2five>
#include <streamerfive>
//#include <a_mysql10>
//#include <sscanf23>
#include <zcmd>
#include <md5>
#include <face>
//#include <streamer23>
#include <foreach>
#include <YSI/y_ini>
#include <pDoor>
#include <pPanel>
#include <pTire>
#include <pLight>
#include <pDefinitions>
#include <a_npc>
#include <j_fader>
new dDialogid[200];
stock dShowPlayerDialog(playerid,id,styl,napis[],text[],res[],res2[])
{
	dDialogid[playerid]=id;
	ShowPlayerDialog(playerid,id,styl,napis,text,res,res2);
	return 1;
}
#include "five/five_definicje.pwn"
#include "five/five_newy.pwn"
#include "five/five_enum.pwn"
#include <antyfrp>
//#include <cleocheats>
#pragma dynamic 50000
////////////////////////////////////////////////////////////////////////////////
#define SQL_HOST "localhost"
#define SQL_USER "root"
#define SQL_PASS "qwerty123"
#define SQL_DB 	 "testowa"

new tekst_global[2048];
new tekst_globals[2048];
new zapyt[1024];
new zapyt2[1024];
new Indicators[MAX_VEHICLES][4];
//new czaswykonania;
////////////////////////////////////////////////////////////////////////////////
new Bar:PasekGlodu[MAX_PLAYERS];
new Bar:BarEdytor[MAX_PLAYERS];
/*
~r~ - Czerwony
~n~ - niebieski
~g~ - zielony
~y~ - pomarañcz/¿ó³ty, zale¿y od monitora
~h~ - rozjaœniacz
~p~ - pedalski (czyt. ró¿owy).
~l~ - czarny
~n~ - nowa linia
~w~ - bia³y
*/
///mt 0 100 Mistral 54 0 0xFF88b711 0 1 (00ff00)Five*(000000)Boxton*Crips
////////////////////////////////////////////////////////////////////////////////
#define LIMIT_UBRAN_SKLEP_M 55
#define LIMIT_UBRAN_SKLEP_W 10
enum SkinInfo
{
	nazwa4[128],id4,cena4
}
enum AttachmentEnum
{
    attachmodel,
    attachname[24]
}
stock SetVehicleIndicator(vehicleid, leftindicator=0, rightindicator=0)
{
	if(!leftindicator & !rightindicator) return false;
	new Float:_vX[2], Float:_vY[2], Float:_vZ[2];
	if(rightindicator)
	{
	    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, _vX[0], _vY[0], _vZ[0]);
 		Indicators[vehicleid][0] = CreateDynamicObject(19294, 0, 0, 0,0,0,0);
		AttachDynamicObjectToVehicle(Indicators[vehicleid][0], vehicleid,  _vX[0]/2.23, _vY[0]/2.23, 0.1 ,0,0,0);
 		Indicators[vehicleid][1] = CreateDynamicObject(19294, 0, 0, 0,0,0,0);
		AttachDynamicObjectToVehicle(Indicators[vehicleid][1], vehicleid,  _vX[0]/2.23, -_vY[0]/2.23, 0.1 ,0,0,0);
	}
	if(leftindicator)
	{
	    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, _vX[0], _vY[0], _vZ[0]);
 		Indicators[vehicleid][2] = CreateDynamicObject(19294, 0, 0, 0,0,0,0);
		AttachDynamicObjectToVehicle(Indicators[vehicleid][2], vehicleid,  -_vX[0]/2.23, _vY[0]/2.23, 0.1 ,0,0,0);
 		Indicators[vehicleid][3] = CreateDynamicObject(19294, 0, 0, 0,0,0,0);
		AttachDynamicObjectToVehicle(Indicators[vehicleid][3], vehicleid,  -_vX[0]/2.23, -_vY[0]/2.23, 0.1 ,0,0,0);
	}
	return 1;
}
stock GetVehicleRelativePos(vehicleid, &Float:x, &Float:y, &Float:z, Float:xoff=0.0, Float:yoff=0.0, Float:zoff=0.0)
{
	new Float:rot;
	GetVehicleZAngle(vehicleid, rot);
	rot = 360 - rot;
	GetVehiclePos(vehicleid, x, y, z);
	x = floatsin(rot,degrees) * yoff + floatcos(rot,degrees) * xoff + x;
	y = floatcos(rot,degrees) * yoff - floatsin(rot,degrees) * xoff + y;
	z = zoff + z;
}


	    
stock Samolot(carid2)
{
	new carid = GetVehicleModel(carid2);
	if(carid == 592 || carid == 577 || carid == 511 || carid == 512 || carid == 593 || carid == 520 || carid == 553 || carid == 476 || carid == 519 || carid == 460 || carid == 513) return 1;
	return 0;
}
stock Rower(carid2)
{
	new carid = GetVehicleModel(carid2);
	if(carid == 509 || carid == 481 || carid == 510) return 1;
	return 0;
}

stock Lodka(carid)
{
	new modelid = GetVehicleModel(carid);
	if(modelid == 430 || modelid == 446 || modelid == 452 || modelid == 453 || modelid == 454 || modelid == 472 || modelid == 473 || modelid == 484 || modelid == 493 || modelid == 595)
	{
		return 1;
	}
	return 0;
}
	   
stock SetPlayerToFacePlayer(playerid, targetid)
{
	//czaswykonania = gettime();
	new Float:pXl,Float:pYl,Float:pZl,Float:X,Float:Y,Float:Z,Float:ang;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid))
	{
		return 0;
	}	
	GetPlayerPos(targetid, X, Y, Z);
	GetPlayerPos(playerid, pXl, pYl, pZl);
	if( Y > pYl )
	{
		ang = (-acos((X - pXl) / floatsqroot((X - pXl)*(X - pXl) + (Y - pYl)*(Y - pYl))) - 90.0);
	}
	else if( Y < pYl && X < pXl )
	{
		ang = (acos((X - pXl) / floatsqroot((X - pXl)*(X - pXl) + (Y - pYl)*(Y - pYl))) - 450.0);
	}
	else if( Y < pYl )
	{
		ang = (acos((X - pXl) / floatsqroot((X - pXl)*(X - pXl) + (Y - pYl)*(Y - pYl))) - 90.0);
	}
	if(X > pXl)
	{
		ang = (floatabs(floatabs(ang) + 180.0));
	}
	else
	{
		ang = (floatabs(ang) - 180.0);
		SetPlayerFacingAngle(playerid, ang);
	}
	////printf("SetPlayerToFacePlayer: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
	return 0;
}
new AttachmentObjects[][AttachmentEnum] = {
	{18633, "Klucz"},
	{18634, "£om"},
	{18635, "M³otek"},
	{18638, "Kask ochronny"},
	{18639, "Kapelusz"},
	{18640, "W³osy 1"},
	{18975, "W³osy 2"},
	{19136, "W³osy 4"},
	{19274, "W³osy 5"},
	{18644, "Œrubokrêt"},
	{18645, "Kask"},
	{18865, "Telefon 1"},
	{18866, "Telefon 2"},
	{18867, "Telefon 3"},
	{18875, "Pager"},
	{18890, "Grabie"},
	{18891, "Bandana 1"},
	{18892, "Bandana 2"},
	{18893, "Bandana 3"},
	{18894, "Bandana 4"},
	{18895, "Bandana 5"},
	{18896, "Bandana 6"},
	{18897, "Bandana 7"},
	{18898, "Bandana 8"},
	{18899, "Bandana 9"},
	{18900, "Bandana 10"},
	{18901, "Bandana 11"},
	{18902, "Bandana 12"},
	{18903, "Bandana 13"},
	{18904, "Bandana 14"},
	{18905, "Bandana 15"},
	{18906, "Bandana 16"},
	{18907, "Bandana 17"},
	{18908, "Bandana 18"},
	{18909, "Bandana 19"},
	{18910, "Bandana 20"},
	{18921, "Beret 1"},
	{18922, "Beret 2"},
	{18923, "Beret 3"},
	{18924, "Beret 4"},
	{18925, "Beret 5"},
	{18926, "Czapka 1"},
	{18927, "Czapka 2"},
	{18928, "Czapka 3"},
	{18929, "Czapka 4"},
	{18930, "Czapka 5"},
	{19006, "Okulary 1"},
	{19007, "Okulary 2"},
	{19008, "Okulary 3"},
	{19009, "Okulary 4"},
	{19039, "Zegarek 1"},
	{19040, "Zegarek 2"},
	{19041, "Zegarek 3"},
	{19095, "Kapelusz 1"},
	{19096, "Kapelusz 2"},
	{19097, "Kapelusz 3"},
	{1210, "Teczka"}
};
new Ikonki[22][1] =
{
	{56},
	{30},
	{53},
	{27}, //gotowe
	{44}, //gotowe
	{55}, //gotowe
	{42}, //wstrzymana
	{52}, //gotowe
	{23}, //gotowe
	{10}, //gotowe
	{48},
	{38}, //gotowe
	{32},
	{58}, //gotowe 1/2
	{22},//gotowe
	{11},
	{61},
	{54},
	{12},
	{34},
	{51},
	{18}
};
new AttachmentBones[][24] = {
	{"Krêgos³up"},
	{"G³owa"},
	{"Lewe ramiê"},
	{"Prawe ramiê"},
	{"Lewa rêka"},
	{"Prawa rêka"},
	{"Lewe udo"},
	{"Prawe udo"},
	{"Lewa stopa"},
	{"Prawa stopa"},
	{"Prawa ³ydka"},
	{"Lewa ³ydka"},
	{"Lewe przedramiê"},
	{"Prawe przedramiê"},
	{"Lewy obojczyk"},
	{"Prawy obojczyk"},
	{"Szyja"},
	{"Szczêka"}
};
new SkinPlayerM[LIMIT_UBRAN_SKLEP_M][SkinInfo] =
{
	{"Ubranie (2)",2,60},
	{"Ubranie (6)",6,110},
	{"Ubranie (7)",7,115},
	{"Ubranie (14)",14,90},
	{"Ubranie (15)",15,95},
	{"Ubranie (17)",17,150},
	{"Ubranie (18)",18,60},
	{"Ubranie (19)",19,110},
	{"Ubranie (20)",20,130},
	{"Ubranie (21)",21,100},
	{"Ubranie (22)",22,160},
	{"Ubranie (23)",23,140},
	{"Ubranie (26)",26,70},
	{"Ubranie (27)",27,75},
	{"Ubranie (29)",29,110},
	{"Ubranie (30)",30,95},
	{"Ubranie (32)",32,75},
	{"Ubranie (33)",33,95},
	{"Ubranie (34)",34,90},
	{"Ubranie (35)",35,160},
	{"Ubranie (43)",43,200},
	{"Ubranie (44)",44,150},
	{"Ubranie (45)",45,45},
	{"Ubranie (46)",46,250},
	{"Ubranie (57)",57,240},
	{"Ubranie (58)",58,100},
	{"Ubranie (59)",59,190},
	{"Ubranie (60)",60,175},
	{"Ubranie (62)",62,40},
	{"Ubranie (67)",67,99},
	{"Ubranie (72)",72,125},
	{"Ubranie (73)",73,125},
	{"Ubranie (78)",78,15},
	{"Ubranie (79)",79,15},
	{"Ubranie (94)",94,75},
	{"Ubranie (98)",98,150},
	{"Ubranie (101)",101,95},
	{"Ubranie (128)",128,165},
	{"Ubranie (132)",132,50},
	{"Ubranie (133)",133,65},
	{"Ubranie (135)",135,45},
	{"Ubranie (143)",143,170},
	{"Ubranie (147)",147,290},
	{"Ubranie (158)",158,50},
	{"Ubranie (159)",159,40},
	{"Ubranie (160)",160,30},
	{"Ubranie (161)",161,80},
	{"Ubranie (170)",170,150},
	{"Ubranie (180)",180,120},
	{"Ubranie (181)",181,75},
	{"Ubranie (184)",184,145},
	{"Ubranie (185)",185,145},
	{"Ubranie (186)",186,315},
	{"Ubranie (187)",187,270},
	{"Ubranie (202)",202,65}
};

new SkinPlayerW[LIMIT_UBRAN_SKLEP_W][SkinInfo] =
{
	{"Ubranie (9)",9,45},
	{"Ubranie (10)",10,20},
	{"Ubranie (12)",12,80},
	{"Ubranie (31)",31,25},
	{"Ubranie (40)",40,50},
	{"Ubranie (41)",41,50},
	{"Ubranie (10)",10,20},
	{"Ubranie (55)",55,60},
	{"Ubranie (56)",56,40},
	{"Ubranie (76)",76,120}
};
new NazwaBroni[0][46] =
{
	{" ",},
	{"Kastet",},{"Kij golfowy",},{"Palka policyjna",},{"Noz",},{"Kij bassebalowy",},{"Lopata",},{"Kij bilardowy",},{"Katana",},{"Pila Lancuchowa",},
	{"Rozowy Dildo",},{"Maly Vibrator",},{"Duzy Vibrator",},{"Srebrny Vibrator",},{"Kwiaty",},{"Laska",},{"Granaty",},{"Gaz lzawiacy",},{"Koktajl molotova",},
	{" ",},{" ",},{" ",},{"9mm",},{"Cichy 9mm",},{"Desert Eagle",},{"Shotgun",},{"Sawn-off Shotgun",},{"Combat Shotgun",},{"Micro SMG",},
	{"MP5",},{"AK-47",},{"M4",},{"Tec9",},{"Wiejska strzelba",},{"Snajperka",},{"Wyrzutnia Rakiet",},{"Wyrzutnia Rakiet",},{"Miotacz Ognia",},
	{"Minigun",},{"Ladunki wybuchowe",},{"Detonator",},{"Spray",},{"Gasnica",},{"Camera",},{"Noktowizor",},{"Termowizor",},{"Spadochron",}
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum zoneinfo {
	gNazwa[124],
	gID,
	gUID,
	gOwner,
    Float:gX,
    Float:gY,
    Float:gXX,
    Float:gYY
};
new Lokacja[MAX_ZON][zoneinfo];
new RozmiarBaku[210][2] =
{
	{50},//400 gotowe
	{30},//401 gotowe
	{55},//402 gotowe
	{120},//403 gotowe
	{35},//404 gotowe
	{50},//405 gotowe
	{200},//406 gotowe
	{200},//407 brak kogutu
	{150},//408 gotowe
	{60},//409 gotowe
	{25},//410 gotowe
	{45},//411 gotowe
	{40},//412 gotowe
	{70},//413 gotowe
	{75},//414 gotowe
	{50},//415 gotowe
	{65},//416 brak kogutu
	{95},//417 brak kogutu
	{45},//418  gotowe
	{40},//419 gotowe
	{60},//420 brak kogutu
	{60},//421 gotowe
	{50},//422 gotowe
	{40},//423 brak kogutu
	{30},//424 brak kogutu
	{0},//425 brak kogutu
	{55},//426 gotowe
	{75},//427 brak kogutu
	{70},//428 gotowe
	{40},//429 brak kogutu
	{80},//430 brak kogutu
	{110},//431 gotowe
	{0},//432 brak kogutu
	{90},//433 gotowe
	{50},//434 brak kogutu
	{0},//435 brak kogutu
	{30},//436 gotowe
	{140},//437 gotowe
	{50},//438 brak kogutu
	{35},//439 gotowe
	{80},//440 gotowe
	{0},//441 brak kogutu
	{45},//442 gotowe
	{150},//443 gotowe
	{25},//444 brak kogutu
	{45},//445 gotowe
	{80},//446 brak kogutu
	{0},//447 brak kogutu
	{5},//448 brak kogutu
	{0},//449 brak kogutu
	{0},//450 brak kogutu
	{40},//451 gotowe
	{75},//452 brak kogutu
	{65},//453 brak kogutu
	{65},//454 brak kogutu
	{80},//455 gotowe
	{65},//456 gotowe
	{10},//457 brak kogutu
	{35},//458 gotowe
	{55},//459 gotowe
	{60},//460 brak kogutu
	{15},//461 brak kogutu
	{5},//462 brak kogutu
	{15},//463 brak kogutu
	{0},//464 brak kogutu
	{0},//465 brak kogutu
	{25},//466 gotowe
	{25},//467 gotowe
	{15},//468 brak kogutu
	{45},//469 brak kogutu
	{50},//470 gotowe
	{5},//471 brak kogutu
	{35},//472 brak kogutu
	{20},//473 brak kogutu
	{35},//474 gotowe
	{40},//475 gotowe
	{0},//476 brak kogutu
	{45},//477 gotowe
	{20},//478 gotowe
	{25},//479 gotowe
	{40},//480 gotowe
	{50},//481 brak kogutu
	{65},//482 gotowe
	{60},//483 gotowe
	{60},//484 brak kogutu
	{15},//485 brak kogutu
	{80},//486 brak kogutu
	{65},//487 brak kogutu
	{60},//488 brak kogutu
	{70},//489 gotowe
	{75},//490 brak kogutu
	{35},//491 gotowe
	{30},//492 gotowe
	{55},//493 brak kogutu
	{60},//494 brak kogutu
	{60},//495 brak kogutu
	{35},//496 gotowe
	{50},//497 brak kogutu
	{45},//498 gotowe
	{35},//499 gotowe
	{30},//500 gotowe
	{0},//501 brak kogutu
	{60},//502 brak kogutu
	{60},//503 brak kogutu
	{35},//504 brak kogutu
	{40},//505 gotowe
	{65},//506 gotowe
	{45},//507 gotowe
	{70},//508 brak kogutu
	{50},//509 brak kogutu
	{50},//510 brak kogutu
	{55},//511 brak kogutu
	{30},//512 brak kogutu
	{30},//513 brak kogutu
	{120},//514 gotowe
	{150},//515 gotowe
	{35},//516 gotowe
	{25},//517 gotowe
	{30},//518 gotowe
	{100},//519 brak kogutu
	{0},//520 brak kogutu
	{15},//521 brak kogutu
	{15},//522 brak kogutu
	{15},//523 brak kogutu
	{90},//524 gotowe
	{35},//525 gotowe
	{20},//526 gotowe
	{20},//527 gotowe
	{35},//528 brak kogutu
	{25},//529 gotowe
	{15},//530 brak kogutu
	{0},//531 brak kogutu
	{35},//532 brak kogutu
	{30},//533 gotowe
	{50},//534 gotowe
	{45},//535 gotowe
	{50},//536 gotowe
	{50},//537 brak kogutu
	{50},//538 brak kogutu
	{10},//539 brak kogutu
	{35},//540 gotowe
	{45},//541 gotowe
	{25},//542 gotowe
	{20},//543 gotowe
	{100},//544 brak kogutu
	{20},//545 gotowe
	{25},//546 gotowe
	{30},//547 gotowe
	{150},//548 brak kogutu
	{25},//549 gotowe
	{40},//550 gotowe
	{35},//551 gotowe
	{40},//552 gotowe
	{80},//553 brak kogutu
	{35},//554 gotowe
	{25},//555 brak kogutu
	{25},//556 brak kogutu
	{30},//557 brak kogutu
	{60},//558 gotowe
	{55},//559 gotowe
	{50},//560 gotowe
	{40},//561 gotowe
	{35},//562 gotowe
	{110},//563 brak kogutu
	{0},//564 brak kogutu
	{35},//565 gotowe
	{30},//566 gotowe
	{40},//567 brak kogutu
	{10},//568 brak kogutu
	{0},//569 brak kogutu
	{0},//570 brak kogutu
	{5},//571 brak kogutu
	{5},//572 brak kogutu
	{45},//573 brak kogutu
	{15},//574 brak kogutu
	{30},//575 brak kogutu
	{35},//576 gotowe
	{300},//577 brak kogutu
	{45},//578 gotowe
	{75},//579 gotowe
	{40},//580 gotowe
	{15},//581 brak kogutu
	{55},//582 brak kogutu
	{5},//583 brak kogutu
	{0},//584 brak kogutu
	{25},//585 gotowe
	{80},//586 brak kogutu
	{35},//587 gotowe
	{0},//588 brak kogutu
	{35},//589 gotowe
	{500},//590 brak kogutu
	{35},//591 brak kogutu
	{0},//592 brak kogutu
	{60},//593 brak kogutu
	{60},//594 brak kogutu
	{60},//595 brak kogutu
	{60},//596 brak kogutu
	{60},//597 brak kogutu
	{60},//598 brak kogutu
	{95},//599 brak kogutu
	{40},//600 gotowe
	{20},//601 brak kogutu
	{45},//602 gotowe
	{35},//603 gotowe
	{20},//604 gotowe
	{20},//605 gotowe
	{0},//606 brak kogutu
	{0},//607 brak kogutu
	{0},//608 brak kogutu
	{30}//609 gotowe
};
new Float:kogutpos[210][3] =
{
	{0.5, 0.8, 0.3},//400 gotowe
	{-0.55, 0.05, 0.8},//401 gotowe
	{-0.5, -0.35, 0.78},//402 gotowe
	{-0.5, 1.9, 1.52},//403 gotowe
	{0.5, 0.5, 0.5},//404 gotowe
	{0.5, 0.65, 0.3},//405 gotowe
	{-1.7, 4.7, 0.4},//406 gotowe
	{0.0, 100.0, 0.0},//407 brak kogutu
	{-0.5, 2.7, 1.0},//408 gotowe
	{0.5, 1.75, 0.35},//409 gotowe
	{0.5, 0.5, 0.4},//410 gotowe
	{-0.5, 0.2, 0.7},//411 gotowe
	{0.5, 0.7, 0.25},//412 gotowe
	{0.5, 1.5, 0.5},//413 gotowe
	{0.5, 1.7, 0.6},//414 gotowe
	{-0.35, -0.1, 0.60},//415 gotowe
	{0.0, 100.0, 0.5},//416 brak kogutu
	{0.0, 100.0, 0.5},//417 brak kogutu
	{0.5, 1.5, 0.35},//418  gotowe
	{-0.5, -0.1, 0.7},//419 gotowe
	{0.0, 100.0, 0.5},//420 brak kogutu
	{-0.5, 0.15, 0.7},//421 gotowe
	{0.5, 0.7, 0.35},//422 gotowe
	{0.0, 100.0, 0.5},//423 brak kogutu
	{0.0, 100.0, 0.5},//424 brak kogutu
	{0.0, 100.0, 0.5},//425 brak kogutu
	{-0.5, 0.1, 0.85},//426 gotowe
	{0.0, 100.0, 0.5},//427 brak kogutu
	{-0.85, 0.8, 1.35},//428 gotowe
	{0.0, 100.0, 0.5},//429 brak kogutu
	{0.0, 100.0, 0.5},//430 brak kogutu
	{-0.65, 5.0, 2.2},//431 gotowe
	{0.0, 100.0, 0.5},//432 brak kogutu
	{-0.5, 1.3, 1.73},//433 gotowe
	{0.0, 100.0, 0.5},//434 brak kogutu
	{0.0, 100.0, 0.5},//435 brak kogutu
	{0.5, 0.5, 0.35},//436 gotowe
	{-0.65, 5.0, 2.1},//437 gotowe
	{0.0, 100.0, 0.5},//438 brak kogutu
	{0.5, 0.4, 0.3},//439 gotowe
	{0.5, 1.5, 0.4},//440 gotowe
	{0.0, 100.0, 0.5},//441 brak kogutu
	{0.5, 1.05, 0.3},//442 gotowe
	{-0.5, 3.4, 1.53},//443 gotowe
	{0.0, 100.0, 0.5},//444 brak kogutu
	{-0.5, 0.0, 0.86},//445 gotowe
	{0.0, 100.0, 0.5},//446 brak kogutu
	{0.0, 100.0, 0.5},//447 brak kogutu
	{0.0, 100.0, 0.5},//448 brak kogutu
	{0.0, 100.0, 0.5},//449 brak kogutu
	{0.5, 100.0, 0.2},//450 brak kogutu
	{0.5, 0.5, 0.2},//451 gotowe
	{0.5, 100.0, 0.3},//452 brak kogutu
	{0.5, 100.0, 0.3},//453 brak kogutu
	{0.5, 100.0, 0.3},//454 brak kogutu
	{-0.6, 1.4, 1.72},//455 gotowe
	{-0.5, 1.6, 1.28},//456 gotowe
	{0.5, 100.0, 0.3},//457 brak kogutu
	{0.5, 0.9, 0.2},//458 gotowe
	{0.5, 1.5, 0.52},//459 gotowe
	{0.5, 100.0, 0.3},//460 brak kogutu
	{0.5, 100.0, 0.3},//461 brak kogutu
	{0.5, 100.0, 0.3},//462 brak kogutu
	{0.5, 100.0, 0.3},//463 brak kogutu
	{0.5, 100.0, 0.3},//464 brak kogutu
	{0.5, 100.0, 0.3},//465 brak kogutu
	{0.5, 0.75, 0.38},//466 gotowe
	{0.5, 0.75, 0.38},//467 gotowe
	{0.5, 100.0, 0.3},//468 brak kogutu
	{0.5, 100.0, 0.3},//469 brak kogutu
	{-0.8, 0.2, 1.12},//470 gotowe
	{0.5, 100.0, 0.3},//471 brak kogutu
	{0.5, 100.0, 0.3},//472 brak kogutu
	{0.5, 100.0, 0.3},//473 brak kogutu
	{-0.51, 0.0, 0.85},//474 gotowe
	{0.5, 0.52, 0.32},//475 gotowe
	{0.5, 100.0, 0.3},//476 brak kogutu
	{-0.5, -0.25, 0.72},//477 gotowe
	{-0.5, 0.5, 0.9},//478 gotowe
	{0.5, 0.65, 0.45},//479 gotowe
	{0.5, 0.4, 0.3},//480 gotowe
	{0.5, 100.0, 0.3},//481 brak kogutu
	{0.5, 1.4, 0.45},//482 gotowe
	{-0.5, 1.9, 1.06},//483 gotowe
	{0.5, 100.0, 0.3},//484 brak kogutu
	{0.5, 100.0, 0.3},//485 brak kogutu
	{0.5, 100.0, 0.3},//486 brak kogutu
	{0.5, 100.0, 0.3},//487 brak kogutu
	{0.5, 100.0, 0.3},//488 brak kogutu
	{-0.6, 0.0, 1.13},//489 gotowe
	{0.5, 100.0, 0.3},//490 brak kogutu
	{0.5, 0.4, 0.3},//491 gotowe
	{0.5, 0.78, 0.4},//492 gotowe
	{0.5, 100.0, 0.3},//493 brak kogutu
	{0.5, 100.0, 0.3},//494 brak kogutu
	{0.5, 100.0, 0.3},//495 brak kogutu
	{0.5, 0.52, 0.37},//496 gotowe
	{0.5, 100.0, 0.3},//497 brak kogutu
	{-0.9, 2.0, 2.07},//498 gotowe
	{0.5, 0.9, 0.45},//499 gotowe
	{0.5, 0.45, 0.32},//500 gotowe
	{0.5, 100.0, 0.45},//501 brak kogutu
	{0.5, 100.0, 0.45},//502 brak kogutu
	{0.5, 100.0, 0.45},//503 brak kogutu
	{0.5, 100.0, 0.45},//504 brak kogutu
	{-0.7, 0.1, 1.12},//505 gotowe
	{0.5, 0.32, 0.25},//506 gotowe
	{0.5, 0.8, 0.3},//507 gotowe
	{0.5, 100.0, 0.45},//508 brak kogutu
	{0.5, 100.0, 0.45},//509 brak kogutu
	{0.5, 100.0, 0.45},//510 brak kogutu
	{0.5, 100.0, 0.45},//511 brak kogutu
	{0.5, 100.0, 0.45},//512 brak kogutu
	{0.5, 100.0, 0.45},//513 brak kogutu
	{-0.65, 1.8, 1.38},//514 gotowe
	{-0.65, 1.8, 1.32},//515 gotowe
	{0.5, 0.8, 0.32},//516 gotowe
	{0.5, 0.76, 0.32},//517 gotowe
	{-0.5, 0.15, 0.73},//518 gotowe
	{0.5, 100.0, 0.45},//519 brak kogutu
	{0.5, 100.0, 0.45},//520 brak kogutu
	{0.5, 100.0, 0.45},//521 brak kogutu
	{0.5, 100.0, 0.45},//522 brak kogutu
	{0.5, 100.0, 0.45},//523 brak kogutu
	{-0.6, 1.7, 0.93},//524 gotowe
	{0.0, -0.47, 1.43},//525 gotowe
	{-0.5, 0.0, 0.67},//526 gotowe
	{-0.5, 0.1, 0.89},//527 gotowe
	{0.5, 100.0, 0.45},//528 brak kogutu
	{-0.5, 0.0, 0.93},//529 gotowe
	{0.5, 100.0, 0.45},//530 brak kogutu
	{0.5, 100.0, 0.45},//531 brak kogutu
	{0.5, 100.0, 0.45},//532 brak kogutu
	{0.5, 0.65, 0.33},//533 gotowe
	{0.5, 0.77, 0.26},//534 gotowe
	{-0.6, 0.4, 0.83},//535 gotowe
	{0.5, 0.68, 0.23},//536 gotowe
	{0.5, 100.0, 0.45},//537 brak kogutu
	{0.5, 100.0, 0.45},//538 brak kogutu
	{0.5, 100.0, 0.45},//539 brak kogutu
	{0.5, 0.68, 0.23},//540 gotowe
	{-0.4, 0.05, 0.66},//541 gotowe
	{0.5, 0.55, 0.4},//542 gotowe
	{-0.7, 0.4, 0.91},//543 gotowe
	{0.5, 100.0, 0.45},//544 brak kogutu
	{-0.5, -0.3, 0.78},//545 gotowe
	{0.5, 0.60, 0.4},//546 gotowe
	{0.5, 0.7, 0.4},//547 gotowe
	{0.5, 100.0, 0.45},//548 brak kogutu
	{-0.55, 0.4, 0.75},//549 gotowe
	{-0.6, 0.1, 0.72},//550 gotowe
	{0.5, 0.8, 0.35},//551 gotowe
	{0.5, 1.33, 0.8},//552 gotowe
	{-0.55, 100.0, 0.75},//553 brak kogutu
	{-0.7, 0.2, 1.06},//554 gotowe
	{-0.55, 100.0, 0.75},//555 brak kogutu
	{-0.55, 100.0, 0.75},//556 brak kogutu
	{-0.55, 100.0, 0.75},//557 brak kogutu
	{-0.5, -0.2, 0.89},//558 gotowe
	{-0.5, 0.0, 0.75},//559 gotowe
	{0.5, 0.8, 0.4},//560 gotowe
	{-0.5, 0.2, 0.81},//561 gotowe
	{-0.5, -0.1, 0.79},//562 gotowe
	{-0.55, 100.0, 0.75},//563 brak kogutu
	{-0.55, 100.0, 0.75},//564 brak kogutu
	{-0.5, 0.0, 0.71},//565 gotowe
	{-0.7, 0.2, 0.87},//566 gotowe
	{-0.55, 100.0, 0.75},//567 brak kogutu
	{-0.55, 100.0, 0.75},//568 brak kogutu
	{-0.55, 100.0, 0.75},//569 brak kogutu
	{-0.55, 100.0, 0.75},//570 brak kogutu
	{-0.55, 100.0, 0.75},//571 brak kogutu
	{-0.55, 100.0, 0.75},//572 brak kogutu
	{-0.55, 100.0, 0.75},//573 brak kogutu
	{-0.55, 100.0, 0.75},//574 brak kogutu
	{-0.55, 100.0, 0.75},//575 brak kogutu
	{0.5, 0.6, 0.48},//576 gotowe
	{-0.55, 100.0, 0.75},//577 brak kogutu
	{-0.7, 3.9, 1.41},//578 gotowe
	{-0.7, 0.1, 1.25},//579 gotowe
	{-0.7, 0.3, 1.06},//580 gotowe
	{-0.55, 100.0, 0.75},//581 brak kogutu
	{-0.55, 100.0, 0.75},//582 brak kogutu
	{-0.55, 100.0, 0.75},//583 brak kogutu
	{-0.55, 100.0, 0.75},//584 brak kogutu
	{-0.6, 0.1, 1.02},//585 gotowe
	{-0.55, 100.0, 0.75},//586 brak kogutu
	{0.5, 0.5, 0.25},//587 gotowe
	{-0.55, 100.0, 0.75},//588 brak kogutu
	{-0.5, 0.0, 1.09},//589 gotowe
	{-0.55, 100.0, 0.75},//590 brak kogutu
	{-0.55, 100.0, 0.75},//591 brak kogutu
	{-0.55, 100.0, 0.75},//592 brak kogutu
	{-0.55, 100.0, 0.75},//593 brak kogutu
	{-0.55, 100.0, 0.75},//594 brak kogutu
	{-0.55, 100.0, 0.75},//595 brak kogutu
	{-0.55, 100.0, 0.75},//596 brak kogutu
	{-0.55, 100.0, 0.75},//597 brak kogutu
	{-0.55, 100.0, 0.75},//598 brak kogutu
	{-0.55, 100.0, 0.75},//599 brak kogutu
	{-0.5, 0.1, 0.8},//600 gotowe
	{-0.55, 100.0, 0.75},//601 brak kogutu
	{-0.5, -0.2, 0.72},//602 gotowe
	{-0.5, -0.2, 0.68},//603 gotowe
	{0.5, 0.7, 0.35},//604 gotowe
	{-0.5, 0.3, 0.91},//605 gotowe
	{-0.55, 100.0, 0.75},//606 brak kogutu
	{-0.55, 100.0, 0.75},//607 brak kogutu
	{-0.55, 100.0, 0.75},//608 brak kogutu
	{-0.9, 2.0, 2.07}//609 gotowe
};
enum kInfo
{
	VID,          //ID Modelu Pojazdu
	Float:PXLP,  //Lewy Przod X
	Float:PYLP, //Lewy Przod Y
	Float:PZLP,//Lewy Przod Z

	Float:PXLT,  //Lewy Ty³ X
	Float:PYLT, //Lewy Ty³ Y
	Float:PZLT,//Lewy Ty³ Z

	Float:PXPP,  //Prawy Przod X
	Float:PYPP, //Prawy Przod Y
	Float:PZPP,//Prawy Przod Z

	Float:PXPT,  //Prawy Ty³ X
	Float:PYPT, //Prawy Ty³ Y
	Float:PZPT //Prawy Ty³ Z
};
new KierunekObiekt[MAX_VEHICLES][6];    //Obiekty kierunkowskazów
new	bool:KierunekPrawyOn[MAX_VEHICLES];	     //Kierunkowskaz prawy w³¹czony false/true
new	bool:KierunekLewyOn[MAX_VEHICLES];	    //Kierunkowskaz lewy w³¹czony false/true
new	bool:KierunkiAwaryjneIn[MAX_VEHICLES];	   //Awaryjne œwiat³a w³¹czone false/true
/*new KierunekInfo[MAX_KIEUNKI][kInfo] =
{
	{422, -0.8, 2.2, -0.3, -0.9, -2.499999, -0.2, 0.8, 2.2, -0.3, 0.9, -2.499999, -0.2}, // 1
	{482,-0.9,2.399999,-0.3,-0.799999,-2.599999,0.0,0.9,2.399999,-0.3,0.799999,-2.599999,0.0}, // 2
	{514, -1.3, 4.199998, 0.0, -0.4, -5.099997, -0.6, 1.3, 4.199998, 0.0, 0.4, -5.099997, -0.6}, // 3
	{515, -1.4, 4.399998, -0.5,	-1.4, -5.099997, -1.1,1.4, 4.399998, -0.5,1.4, -5.099997, -1.1}, // 4
	{591, 0.0, 0.0, 0.0, -1.0, -3.899998, -1.1, 0.0, 0.0, 0.0, 1.0, -3.899998, -1.1}, // 5
	{596, -1.0, 2.299999, 0.0, -1.0, -2.699999, 0.0, 1.0, 2.299999, 0.0, 1.0, -2.699999, 0.0}, // 6
	{597, -1.0, 2.299999, 0.0, -1.0, -2.699999, 0.0, 1.0, 2.299999, 0.0, 1.0, -2.699999, 0.0}, // 7
	{598, -1.0, 2.299999, 0.0, -1.0, -2.699999, 0.0, 1.0, 2.299999, 0.0, 1.0, -2.699999, 0.0} // 8
	
};*/
stock TOKKEN(playerid, zmienna=0)
{
	//czaswykonania = gettime();
	if(zmienna == 0) zmienna = playerid;
	new text[32];
	format(text, sizeof(text), "%d", zmienna);
	new char1[5], char2[5], char3[5], char4[4], charcode2[5];
	strmid(charcode2, MD5_Hash(text), 0, strlen(MD5_Hash(text)), 255);
	strmid(char1, charcode2[0], 0, 1, 255);
	strmid(char2, charcode2[1], 0, 1, 255);
	strmid(char3, charcode2[2], 0, 1, 255);
	strmid(char4, charcode2[3], 0, 1, 255);
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "%s%s%s%s", char1, char2, char3, char4);
	strtoupper(tekst_global);
	////printf("TOKKEN: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
	return tekst_global;
}
stock iban(playerid, zmienna=0)
{
	//czaswykonania = gettime();
	if(zmienna == 0) zmienna = DaneGracza[playerid][gUID];
	new text[32];
	format(text, sizeof(text), "%d", zmienna);
	new char1[5], char2[5], char3[5], char4[4], charcode2[21], char5[5], char6[5], char7[5], char8[5], char9[5], char10[5]
	, char11[5], char12[5], char13[5], char14[5], char15[5], char16[5], char17[5], char18[5], char19[5], char20[5];
	strmid(charcode2, MD5_Hash(text), 0, strlen(MD5_Hash(text)), 255);
	strmid(char1, charcode2[0], 0, 1, 255);
	strmid(char2, charcode2[1], 0, 1, 255);
	strmid(char3, charcode2[2], 0, 1, 255);
	strmid(char4, charcode2[3], 0, 1, 255);
	strmid(char5, charcode2[4], 0, 1, 255);
	strmid(char6, charcode2[5], 0, 1, 255);
	strmid(char7, charcode2[6], 0, 1, 255);
	strmid(char8, charcode2[7], 0, 1, 255);
	strmid(char9, charcode2[8], 0, 1, 255);
	strmid(char10, charcode2[9], 0, 1, 255);
	strmid(char11, charcode2[10], 0, 1, 255);
	strmid(char12, charcode2[11], 0, 1, 255);
	strmid(char13, charcode2[12], 0, 1, 255);
	strmid(char14, charcode2[13], 0, 1, 255);
	strmid(char15, charcode2[14], 0, 1, 255);
	strmid(char16, charcode2[15], 0, 1, 255);
	strmid(char17, charcode2[16], 0, 1, 255);
	strmid(char18, charcode2[17], 0, 1, 255);
	strmid(char19, charcode2[18], 0, 1, 255);
	strmid(char20, charcode2[19], 0, 1, 255);
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s", char1, char2, char3, char4, char5, char6, char7, char8, char9
	, char10, char11, char12, char13, char14, char15, char16, char17, char18, char19, char20);
	strtoupper(tekst_global);
	////printf("iban: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
	return tekst_global;
}
stock md5(str[])
{
	return MD5_Hash(str);
}
new NazwyDzialalnosci[23][124] =
{
	{"None"},
	{"Policyjny"}, //gotowe
	{"Zmotoryzowany"},
	{"Warsztat"}, //gotowe
	{"27/7"}, //gotowe
	{"Samochodowy"}, //gotowe
	{"Koœcielna"}, //wstrzymana
	{"Bankowa"}, //gotowe
	{"Elektryczna"}, //gotowe
	{"Gastronomia"}, //gotowe
	{"San News"},
	{"Mafia/Szajka"}, //gotowe
	{"Hotel"},
	{"Rodzinka"}, //gotowe 1/2
	{"Medyczny"},//gotowe
	{"Taxi"},
	{"Gangowy"},
	{"Silownia"},
	{"Sklep z ubraniami"},
	{"Rzadowy"},
	{"Wypo¿yczalnia pojazdów"},
	{"Syndykat"},
	{"Nauka Jazdy"}
};
new TypDokumentu[7][124] =
{
	{"Prawo jazdy kat. A"},
	{"Prawo jazdy kat. B"},
	{"Licencja na bron"},
	{"Zaswiadzczenie o niekaralnosc"},
	{"Dowod osobisty"},
	{"Zaswiadzczenie o niepoczytalnosci"},
	{"Karta wedkarska"}
};
new TypPojazdow[10][124] =
{
	{"None"},
	{"Tanie"}, 
	{"Popularne Tanie"},
	{"Popularne"}, 
	{"Prawie luksusowe"}, 
	{"Sport & Exclusive"},
	{"£odze"},
	{"Jednoœlady"}, 
	{"Samoloty & Helikoptery"}, 
	{"Pojazdy Premium"}
};
stock strtoupper(text[])
{
	//czaswykonania = gettime();
	for(new l = 0; l < strlen(text); l++)
	{
		text[l] = toupper(text[l]);
	}
	////printf("strtoupper: %d sec", gettime()-czaswykonania);
}
stock strtolower(text[])
{
	//czaswykonania = gettime();
	for(new l = 0; l < strlen(text); l++)
	{
		text[l] = tolower(text[l]);
	}
	////printf("strtolower: %d sec", gettime()-czaswykonania);
}
stock UsunPLZnaki(text[])
{
	//czaswykonania = gettime();
	ForeachEx(i, strlen(text))
	{
		if(text[i] == 'ê') text[i] = 'e';
	    if(text[i] == 'ó') text[i] = 'o';
	    if(text[i] == '¹') text[i] = 'a';
	    if(text[i] == 'œ') text[i] = 's';
	    if(text[i] == '³') text[i] = 'l';
	    if(text[i] == '¿') text[i] = 'z';
	    if(text[i] == 'Ÿ') text[i] = 'z';
	    if(text[i] == 'æ') text[i] = 'c';
	    if(text[i] == 'ñ') text[i] = 'n';
	}
	////printf("UsunPlZnaki: %d sec", gettime()-czaswykonania);
}
stock GM(playerid, zmienna=0)
{
	//czaswykonania = gettime();
	if(zmienna == 0) zmienna = DaneGracza[playerid][gGUID];
	new text[32];
	format(text, sizeof(text), "%d", zmienna);
	new char1[5], char2[5], char3[5], char4[4], charcode2[5];
	strmid(charcode2, MD5_Hash(text), 0, strlen(MD5_Hash(text)), 255);
	strmid(char1, charcode2[0], 0, 1, 255);
	strmid(char2, charcode2[1], 0, 1, 255);
	strmid(char3, charcode2[2], 0, 1, 255);
	strmid(char4, charcode2[3], 0, 1, 255);
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "%s%s%s%s", char1, char2, char3, char4);
	strtoupper(tekst_global);
	////printf("GM: %d sec", gettime()-czaswykonania);
	return tekst_global;
}
stock mysql_check()
{
	//czaswykonania = gettime();
	if(mysql_ping() == (-1))
	{
		mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
		for(new i = 0; i < 100; i++)
		{
			if(!mysql_reload())
			{
				SendRconCommand("hostname [Five-RP.net] - Prace techniczne.");
				SendRconCommand("password QSSS");
				SetGameModeText(""VER"*");
				mysql_reload();
			}
			else
			{
				SendRconCommand("hostname [Five-RP.net] - Serwer Beta.");
				SendRconCommand("password ");
				SetGameModeText(""VER"");
			}
		}
	}
	////printf("mysql_check: %d sec", gettime()-czaswykonania);
	return 1;
}

stock ImieGracza(playerid)
{
	//czaswykonania = gettime();
	new imie[MAX_PLAYER_NAME];
	GetPlayerName(playerid, imie, sizeof(imie));
	////printf("ImieGracza: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
	return imie;
}
stock ImieGracza2(playerid)
{
	//czaswykonania = gettime();
	new imie[MAX_PLAYER_NAME], tekst_global1[50];
	GetPlayerName(playerid, imie, sizeof(imie));
	strtolower(imie);
	new imien[50], nazwisko[50];
    sscanf(imie, "p<_>s[50]s[50]",imien,nazwisko);
	imien[0] = toupper(imien[0]);
	nazwisko[0] = toupper(nazwisko[0]);
	format(tekst_global1, sizeof(tekst_global1), "%s %s", imien,nazwisko);
	////printf("ImieGracza2: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
	return tekst_global1;
}
main()
{
	new Rok, Miesiac, Dzien;
	mysql_check();
	getdate(Rok, Miesiac, Dzien);
	print ("\n===========["VER"]===========");

}
////////////////////////////////////////////////////////////////////////////////
#include "five/five_zapis.pwn"
#include "five/five_logi.pwn"
#include "five/five_kary.pwn"
#include "five/five_ryby.pwn"
#include "five/five_grupy.pwn"
#include "five/five_forumpw.pwn"
#include "five/five_nieruchomosci.pwn"
#include "five/five_obiekty.pwn"
#include "five/five_elektryka.pwn"
#include "five/five_przedmioty.pwn"
#include "five/five_pojazdy.pwn"
#include "five/five_sannews.pwn"
#include "five/five_fotoradary.pwn"
#include "five/five_textury.pwn"
#include "five/five_tuning.pwn"
#include "five/five_banki.pwn"
#include "five/five_busy.pwn"
#include "five/five_magazyny.pwn"
#include "five/five_oferty.pwn"
#include "five/five_hurtownie.pwn"
#include "five/five_animacje.pwn"
#include "five/five_wyscigi.pwn"
#include "five/five_police.pwn"
#include "five/five_dialogid.pwn"
#include "five/five_poker.pwn"
#include "five/five_mafie.pwn"
////////////////////////////////////////////////////////////////////////////////
forward ZaladujTereny();
public ZaladujTereny()
{
	//czaswykonania = gettime();
	new id = false;
	mysql_query( "SELECT * FROM `five_tereny`" );
	mysql_store_result( );
	while(mysql_fetch_row(zapyt))
	{
	    sscanf(zapyt, "p<|>i", id );
	    sscanf(zapyt, "p<|>ds[124]ffffd",
	    Lokacja[id][gUID],
	    Lokacja[id][gNazwa],
	    Lokacja[id][gX],
	    Lokacja[id][gY],
	    Lokacja[id][gXX],
	    Lokacja[id][gYY],
		Lokacja[id][gOwner]);
		Lokacja[id][gID] = GangZoneCreate(Lokacja[id][gX], Lokacja[id][gY], Lokacja[id][gXX], Lokacja[id][gYY]);
	}
	mysql_free_result( );
	////printf("Tereny   - %d", id);
	////printf("ZaladujTereny: %d sec", gettime()-czaswykonania);
	return 1;
}
forward ZaladujKontakty();
public ZaladujKontakty()
{
	//czaswykonania = gettime();
	new id = false;
	mysql_query( "SELECT * FROM `five_kontakty`" );
	mysql_store_result( );
	while(mysql_fetch_row(zapyt))
	{
	    sscanf(zapyt, "p<|>i", id );
	    sscanf(zapyt, "p<|>ddds[254]",
	    Kontakt[id][kUID],
	    Kontakt[id][kPrzedmiot],
	    Kontakt[id][kNumer],
	    Kontakt[id][kNazwa]);
	}
	mysql_free_result( );
	////printf("Kontakty   - %d", id);
	////printf("ZaladujKontakty: %d sec", gettime()-czaswykonania);
	return 1;
}
forward DodajKontakty(playerid, sell);
public DodajKontakty(playerid, sell)
{
	//czaswykonania = gettime();
	new index = GetFreeSQLUID("five_kontakty", "UID");
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_kontakty` (`UID`, `UID_PRZEDMIOTU`, `NUMER`, `NAZWA`) VALUES ('%d','%d','%d','%s')",
	index, DaneGracza[playerid][gTelefon]-4456781, DaneGracza[sell][gTelefon], ZmianaNicku(sell));
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();
	Kontakt[index][kUID] = index;
	Kontakt[index][kPrzedmiot] = DaneGracza[playerid][gTelefon]-4456781;
	Kontakt[index][kNumer] = DaneGracza[sell][gTelefon];
	format(Kontakt[index][kNazwa], 124, "%s", ZmianaNicku(sell));
	////printf("DodajKontakty: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
    return index;
}
forward UsunKontakt(uid);
public UsunKontakt(uid)
{
	//czaswykonania = gettime();
	Kontakt[uid][kUID] = 0;
	Kontakt[uid][kPrzedmiot] = 0;
	Kontakt[uid][kNumer] = 0;
	format(zapyt, sizeof(zapyt), "DELETE FROM `five_kontakty` WHERE `UID` = '%d'", uid);
	mysql_check();
	mysql_query2(zapyt);
	////printf("UsunKontakt: %d sec", gettime()-czaswykonania);
	return 1;
}
forward Dzwonie(playerid);
public Dzwonie(playerid)
{
	//czaswykonania = gettime();
	new id = DzwoniID[playerid];
	SendClientMessage(playerid, 0xDEDEDE00, "Rozmówca nie odebra³ telefonu.");
	SendClientMessage(id, 0xDEDEDE00, "Nie odebra³eœ po³¹czenia.");
	Dzwoni[id] = 0;
	DzwoniID[id] = 0;
	/*if(UzywaBudkiUID[id] != 0)
	{
		ObiektInfo[UzywaBudkiUID[id]][objPoker][0] = 0;
		DeletePVar(id,"uidbudka");
	}
	if(UzywaBudkiUID[playerid] != 0)
	{
		ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
		DeletePVar(playerid,"uidbudka");
	}*/
	DzwoniID[playerid] = 0;
	Dzwoni[playerid] = 0;
	////printf("Dzwonie: %d sec (%s, UID:%d, GUID:%d)", gettime()-czaswykonania,ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
	return 1;
}
CMD:nazwa(playerid,cmdtext[])
{
	//printf("U¿yta komenda model");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] != 4)
    {
		return 0;
	}
	new model[50], xs[50];
	if(sscanf(cmdtext, "s[50]", model))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zmieniæ nazwe serwera wpisz: {88b711}/nazwa [tresc]", "Zamknij", "");
		return 1;
	}
	format(xs, sizeof(xs), "hostname %s", model);
	SendRconCommand(xs);
	return 1;
}
CMD:odbierz(playerid, cmdtext[])
{
	//printf("U¿yta komenda zakoncz");
	if(Dzwoni[playerid] == -1)
	{
		KillTimer(dzwon[DzwoniID[playerid]]);
		SendClientMessage(playerid, 0xDEDEDE00, "Odebra³eœ po³¹czenie.");
		SendClientMessage(DzwoniID[playerid], 0xDEDEDE00, "Rozmówca odebra³ po³¹czenie.");
		Odebral[playerid] = 1;
	}
	return 1;
}
CMD:zakoncz(playerid, cmdtext[])
{
	//printf("U¿yta komenda odbierz");
	/*if(Dzwoni[playerid] == 1)
	{
		KillTimer(dzwon[playerid]);
		SendClientMessage(playerid, 0xDEDEDE00, "Zakoñczy³eœ po³¹czenie.");
		SendClientMessage(DzwoniID[playerid], 0xDEDEDE00, "Rozmówca zakoñczy³ po³¹czenie.");
		new id = DzwoniID[playerid];
		Dzwoni[id] = 0;
		DzwoniID[id] = 0;
		DzwoniID[playerid] = 0;
		Dzwoni[playerid] = 0;
	}*/
	if(Dzwoni[playerid] == -1 || Odebral[playerid] == 1 || Dzwoni[playerid] == 1)
	{
		KillTimer(dzwon[DzwoniID[playerid]]);
		KillTimer(dzwon[playerid]);
		SendClientMessage(playerid, 0xDEDEDE00, "Zakoñczy³eœ po³¹czenie.");
		SendClientMessage(DzwoniID[playerid], 0xDEDEDE00, "Rozmówca zakoñczy³ po³¹czenie.");
		new id = DzwoniID[playerid];
		Dzwoni[id] = 0;
		DzwoniID[id] = 0;
		Odebral[id] = 0;
		/*if(UzywaBudkiUID[id] != 0)
		{
			ObiektInfo[UzywaBudkiUID[id]][objPoker][0] = 0;
			DeletePVar(id,"uidbudka");
		}
		if(UzywaBudkiUID[playerid] != 0)
		{
			ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
			DeletePVar(playerid,"uidbudka");
		}*/
		DzwoniID[playerid] = 0;
		Dzwoni[playerid] = 0;
		Odebral[playerid] = 0;
	}
	/*if(Odebral[playerid] == 1)
	{
		KillTimer(dzwon[DzwoniID[playerid]]);
		SendClientMessage(playerid, 0xDEDEDE00, "Zakoñczy³eœ po³¹czenie.");
		SendClientMessage(DzwoniID[playerid], 0xDEDEDE00, "Rozmówca zakoñczy³ po³¹czenie.");
		new id = DzwoniID[playerid];
		Dzwoni[id] = 0;
		DzwoniID[id] = 0;
		DzwoniID[playerid] = 0;
		Dzwoni[playerid] = 0;
		Odebral[playerid] = 0;
	}*/
	return 1;
}
public OnGameModeInit()
{
	print("Poczatek");
	new godzina, minuta;
	AntiDeAMX();
	FadeInit();
	SetGameModeText(""VER"");
	SendRconCommand("mapname Los Santos");
	ShowNameTags(0);
    ShowPlayerMarkers(0);//Markery
   	AllowInteriorWeapons(1);//Bronie w interiorze
	EnableStuntBonusForAll(0);//Brak kasy za stunty
	DisableInteriorEnterExits();//Brak intów GTA
	EnableVehicleFriendlyFire();
	gettime(godzina, minuta);
	SetWorldTime(godzina);
	ManualVehicleEngineAndLights();
	mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
	new str[124];
	strdel(str, 0, 124);
    format(str, sizeof(str), "UPDATE `five_postacie` SET `ONLINE` = '0' WHERE `ONLINE` = '%d'", 1);
    mysql_query(str);
////////////////////////////////////////////////////////////////////////////////
	ZaladujTereny();
	ZaladujKontakty();
	ZaladujObiekty();
	ZaladujAnimacje();
	ZaladujPrzedmioty();
	ZaladujPojazdy();
	ZaladujDzialalnoscis();
	ZaladujPrzystanki();
	ZaladujNieruchomosci();
	ZaladujElektryke();
	ZaladujTextury();
	ZaladujHurtownie();
	ZaladujMagazyny();
	ZaladujKartoteki();
	ZaladujWyscigAll();
	ZaladujFotoradary();
	ZaladujPaczki();
////////////////////////////////////////////////////////////////////////////////
	SetTimer("Minuta", 60000, 1);
	SetTimer("AntyCheatSystem",1000,true);
	SetTimer("CoSekunde",1000,true);
	SetTimer("Przebieg",500,true);
	SetTimer("MinusAuto",2000,true);
	AFKTimer = SetTimer("AFKT", 60000, 1);
	SetTimer("Tempomacik", 200, 1);
	//SetTimer("UpdateCameras",750,true);
	
	SetTimer("Brakprawka",3000,1);
	//SetTimer("CoPietnacieSekund",15000,1);
	ConnectNPC("Frank_Mattson","urzednik");
////////////////////////////////////////////////////////////////////////////////
	flash = TextDrawCreate(-20.000000,2.000000,"|");
	TextDrawUseBox(flash,1);
	TextDrawBoxColor(flash,0xffffff66);
	TextDrawTextSize(flash,660.000000,22.000000);
	TextDrawAlignment(flash,0);
	TextDrawBackgroundColor(flash,0x000000ff);
	TextDrawFont(flash,3);
	TextDrawLetterSize(flash,1.000000,52.200000);
	TextDrawColor(flash,0xffffffff);
	TextDrawSetOutline(flash,1);
	TextDrawSetProportional(flash,1);
	TextDrawSetShadow(flash,1);
////////////////////////////////////////////////////////////////////////////////
    Light = TextDrawCreate(0.0, 0.0, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawUseBox(Light, 1);
	TextDrawBoxColor(Light, 0x00000077);
	TextDrawTextSize(Light, 640.0, 400.0);
////////////////////////////////////////////////////////////////////////////////
	LosSantosFM = TextDrawCreate(-1.000000,439.000000,"");
	TextDrawUseBox(LosSantosFM,1);
	TextDrawBoxColor(LosSantosFM,0x00000033);
	TextDrawTextSize(LosSantosFM,643.000000,0.000000);
	TextDrawAlignment(LosSantosFM,0);
	TextDrawBackgroundColor(LosSantosFM,0x000000ff);
	TextDrawFont(LosSantosFM,1);
	TextDrawLetterSize(LosSantosFM,0.199999,0.899999);
	TextDrawColor(LosSantosFM,0xffffffff);
	TextDrawSetOutline(LosSantosFM,1);
	TextDrawSetProportional(LosSantosFM,1);
	TextDrawShowForAll(LosSantosFM);
////////////////////////////////////////////////////////////////////////////////
    brudny = TextDrawCreate(-20.000000,2.000000,"|");
	TextDrawUseBox(brudny,1);
	TextDrawBoxColor(brudny,0x523305AA);
	TextDrawTextSize(brudny,660.000000,22.000000);
	TextDrawAlignment(brudny,0);
	TextDrawBackgroundColor(brudny,0x000000ff);
	TextDrawFont(brudny,3);
	TextDrawLetterSize(brudny,1.000000,52.200000);
	TextDrawColor(brudny,0x7D3636AA);
	TextDrawSetOutline(brudny,1);
	TextDrawSetProportional(brudny,1);
	TextDrawSetShadow(brudny,1);
////////////////////////////////////////////////////////////////////////////////
	Textdrawodkar = TextDrawCreate(14.000000, 286.000000, " ");
	TextDrawBackgroundColor(Textdrawodkar, 255);
	TextDrawFont(Textdrawodkar, 1);
	TextDrawLetterSize(Textdrawodkar, 0.300000, 1.200000);
	TextDrawColor(Textdrawodkar, -1);
	TextDrawSetOutline(Textdrawodkar, 1);
	TextDrawSetProportional(Textdrawodkar, 1);
	TextDrawShowForAll(Textdrawodkar);
////////////////////////////////////////////////////////////////////////////////
	Worek = TextDrawCreate(1.000000,1.000000," ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~");
	TextDrawUseBox(Worek,1);
	TextDrawBoxColor(Worek,0x000000ff);
	TextDrawTextSize(Worek,640.000000,0.000000);
	TextDrawAlignment(Worek,0);
	TextDrawBackgroundColor(Worek,0x000000ff);
	TextDrawFont(Worek,3);
	TextDrawLetterSize(Worek,1.000000,1.000000);
	TextDrawColor(Worek,0xffffffff);
	TextDrawSetOutline(Worek,1);
	TextDrawSetProportional(Worek,1);
	TextDrawSetShadow(Worek,1);
	Telefon[0] = TextDrawCreate(493.000000, 156.000000, "hud:radardisc");
	TextDrawBackgroundColor(Telefon[0], 255);//test matii
	TextDrawFont(Telefon[0], 4);
	TextDrawLetterSize(Telefon[0], 0.500000, 1.000000);
	TextDrawColor(Telefon[0], -1);
	TextDrawSetOutline(Telefon[0], 0);
	TextDrawSetProportional(Telefon[0], 1);
	TextDrawSetShadow(Telefon[0], 1);
	TextDrawUseBox(Telefon[0], 1);
	TextDrawBoxColor(Telefon[0], 255);
	TextDrawTextSize(Telefon[0], 27.000000, 33.000000);

	Telefon[1] = TextDrawCreate(493.000000, 423.000000, "hud:radardisc");
	TextDrawBackgroundColor(Telefon[1], 255);
	TextDrawFont(Telefon[1], 4);
	TextDrawLetterSize(Telefon[1], 0.500000, 1.000000);
	TextDrawColor(Telefon[1], -1);
	TextDrawSetOutline(Telefon[1], 0);
	TextDrawSetProportional(Telefon[1], 1);
	TextDrawSetShadow(Telefon[1], 1);
	TextDrawUseBox(Telefon[1], 1);
	TextDrawBoxColor(Telefon[1], 255);
	TextDrawTextSize(Telefon[1], 27.000000, -33.000000);

	Telefon[2] = TextDrawCreate(615.000000, 423.000000, "hud:radardisc");
	TextDrawBackgroundColor(Telefon[2], 255);
	TextDrawFont(Telefon[2], 4);
	TextDrawLetterSize(Telefon[2], 0.500000, 1.000000);
	TextDrawColor(Telefon[2], -1);
	TextDrawSetOutline(Telefon[2], 0);
	TextDrawSetProportional(Telefon[2], 1);
	TextDrawSetShadow(Telefon[2], 1);
	TextDrawUseBox(Telefon[2], 1);
	TextDrawBoxColor(Telefon[2], 255);
	TextDrawTextSize(Telefon[2], -27.000000, -33.000000);

	Telefon[3] = TextDrawCreate(615.000000, 156.000000, "hud:radardisc");
	TextDrawBackgroundColor(Telefon[3], 255);
	TextDrawFont(Telefon[3], 4);
	TextDrawLetterSize(Telefon[3], 0.500000, 1.000000);
	TextDrawColor(Telefon[3], -1);
	TextDrawSetOutline(Telefon[3], 0);
	TextDrawSetProportional(Telefon[3], 1);
	TextDrawSetShadow(Telefon[3], 1);
	TextDrawUseBox(Telefon[3], 1);
	TextDrawBoxColor(Telefon[3], 255);
	TextDrawTextSize(Telefon[3], -27.000000, 33.000000);

	Telefon[4] = TextDrawCreate(494.000000, 138.000000, "0");
	TextDrawBackgroundColor(Telefon[4], 255);
	TextDrawFont(Telefon[4], 1);
	TextDrawLetterSize(Telefon[4], 2.259998, 10.800010);
	TextDrawColor(Telefon[4], 255);
	TextDrawSetOutline(Telefon[4], 0);
	TextDrawSetProportional(Telefon[4], 1);
	TextDrawSetShadow(Telefon[4], 0);

	Telefon[5] = TextDrawCreate(565.500000, 138.000000, "0");
	TextDrawBackgroundColor(Telefon[5], 255);
	TextDrawFont(Telefon[5], 1);
	TextDrawLetterSize(Telefon[5], 2.259998, 10.800010);
	TextDrawColor(Telefon[5], 255);
	TextDrawSetOutline(Telefon[5], 0);
	TextDrawSetProportional(Telefon[5], 1);
	TextDrawSetShadow(Telefon[5], 0);

	Telefon[14] = TextDrawCreate(494.000000, 336.000000, "0");
	TextDrawBackgroundColor(Telefon[14], 255);
	TextDrawFont(Telefon[14], 1);
	TextDrawLetterSize(Telefon[14], 2.259998, 10.800010);
	TextDrawColor(Telefon[14], 255);
	TextDrawSetOutline(Telefon[14], 0);
	TextDrawSetProportional(Telefon[14], 1);
	TextDrawSetShadow(Telefon[14], 0);

	Telefon[15] = TextDrawCreate(565.500000, 335.000000, "0");
	TextDrawBackgroundColor(Telefon[15], 255);
	TextDrawFont(Telefon[15], 1);
	TextDrawLetterSize(Telefon[15], 2.259998, 10.800010);
	TextDrawColor(Telefon[15], 255);
	TextDrawSetOutline(Telefon[15], 0);
	TextDrawSetProportional(Telefon[15], 1);
	TextDrawSetShadow(Telefon[15], 0);

	Telefon[6] = TextDrawCreate(617.000000, 191.000000, "_");
	TextDrawBackgroundColor(Telefon[6], 255);
	TextDrawFont(Telefon[6], 1);
	TextDrawLetterSize(Telefon[6], 0.500000, 22.200000);
	TextDrawColor(Telefon[6], -1);
	TextDrawSetOutline(Telefon[6], 0);
	TextDrawSetProportional(Telefon[6], 1);
	TextDrawSetShadow(Telefon[6], 1);
	TextDrawUseBox(Telefon[6], 1);
	TextDrawBoxColor(Telefon[6], 255);
	TextDrawTextSize(Telefon[6], 491.000000, 0.000000);

	Telefon[7] = TextDrawCreate(590.000000, 158.000000, "_");
	TextDrawBackgroundColor(Telefon[7], 255);
	TextDrawFont(Telefon[7], 1);
	TextDrawLetterSize(Telefon[7], 0.500000, 29.200004);
	TextDrawColor(Telefon[7], -1);
	TextDrawSetOutline(Telefon[7], 0);
	TextDrawSetProportional(Telefon[7], 1);
	TextDrawSetShadow(Telefon[7], 1);
	TextDrawUseBox(Telefon[7], 1);
	TextDrawBoxColor(Telefon[7], 255);
	TextDrawTextSize(Telefon[7], 518.000000, 0.000000);

	Telefon[8] = TextDrawCreate(606.000000, 174.000000, "_");
	TextDrawBackgroundColor(Telefon[8], 255);
	TextDrawFont(Telefon[8], 1);
	TextDrawLetterSize(Telefon[8], 0.500000, 26.199996);
	TextDrawColor(Telefon[8], -1);
	TextDrawSetOutline(Telefon[8], 0);
	TextDrawSetProportional(Telefon[8], 1);
	TextDrawSetShadow(Telefon[8], 1);
	TextDrawUseBox(Telefon[8], 1);
	TextDrawBoxColor(Telefon[8], 255);
	TextDrawTextSize(Telefon[8], 498.000000, 0.000000);

	Telefon[9] = TextDrawCreate(554.000000, 397.000000, "u");
	TextDrawBackgroundColor(Telefon[9], 255);
	TextDrawAlignment(Telefon[9], 2);
	TextDrawFont(Telefon[9], 2);
	TextDrawLetterSize(Telefon[9], 2.070000, 1.400000);
	TextDrawColor(Telefon[9], -1);
	TextDrawSetOutline(Telefon[9], 0);
	TextDrawSetProportional(Telefon[9], 1);
	TextDrawSetShadow(Telefon[9], 1);
	TextDrawTextSize(Telefon[9], 13.000000, 50.000000);

	Telefon[10] = TextDrawCreate(502.000000, 190.000000, "_");
	TextDrawBackgroundColor(Telefon[10], 255);
	TextDrawFont(Telefon[10], 1);
	TextDrawLetterSize(Telefon[10], 0.500000, 22.000003);
	TextDrawColor(Telefon[10], -1);
	TextDrawSetOutline(Telefon[10], 0);
	TextDrawSetProportional(Telefon[10], 1);
	TextDrawSetShadow(Telefon[10], 1);
	TextDrawUseBox(Telefon[10], 1);
	TextDrawBoxColor(Telefon[10], 842150655);
	TextDrawTextSize(Telefon[10], 606.000000, 0.000000);

	Telefon[11] = TextDrawCreate(535.000000, 157.000000, "-");
	TextDrawBackgroundColor(Telefon[11], 255);
	TextDrawFont(Telefon[11], 1);
	TextDrawLetterSize(Telefon[11], 2.569999, 1.800000);
	TextDrawColor(Telefon[11], 842150655);
	TextDrawSetOutline(Telefon[11], 0);
	TextDrawSetProportional(Telefon[11], 1);
	TextDrawSetShadow(Telefon[11], 0);

	Telefon[12] = TextDrawCreate(568.000000, 163.000000, ".. o");
	TextDrawBackgroundColor(Telefon[12], 255);
	TextDrawFont(Telefon[12], 1);
	TextDrawLetterSize(Telefon[12], 0.400000, 1.400000);
	TextDrawColor(Telefon[12], 842150655);
	TextDrawSetOutline(Telefon[12], 0);
	TextDrawSetProportional(Telefon[12], 1);
	TextDrawSetShadow(Telefon[12], 0);

	Telefon[13] = TextDrawCreate(533.000000, 175.000000, "Five-RP");
	TextDrawBackgroundColor(Telefon[13], 255);
	TextDrawFont(Telefon[13], 1);
	TextDrawLetterSize(Telefon[13], 0.250000, 0.899999);
	TextDrawColor(Telefon[13], -1);
	TextDrawSetOutline(Telefon[13], 0);
	TextDrawSetProportional(Telefon[13], 1);
	TextDrawSetShadow(Telefon[13], 0);
////////////////////////////////////////////////////////////////////////////////
    ForeachEx(i, MAX_PLAYERS)
	{
////////////////////////////////////////////////////////////////////////////////
		KtoJestOnline[i] = -1;
		Wyscig[i] = TextDrawCreate(17.000000,177.000000," ");
		TextDrawAlignment(Wyscig[i],0);
		TextDrawBackgroundColor(Wyscig[i],0x000000ff);
		TextDrawFont(Wyscig[i],1);
		TextDrawLetterSize(Wyscig[i],0.200000,1.000000);
		TextDrawColor(Wyscig[i],0xffffffff);
		TextDrawSetProportional(Wyscig[i],1);
		TextDrawSetShadow(Wyscig[i],1);
////////////////////////////////////////////////////////////////////////////////
	    TextNaDrzwi[i] = TextDrawCreate(510.000000, 300.000000, "");
		TextDrawAlignment(TextNaDrzwi[i], 2);
		TextDrawBackgroundColor(TextNaDrzwi[i], 255);
		TextDrawFont(TextNaDrzwi[i], 1);
		TextDrawLetterSize(TextNaDrzwi[i], 0.469998, 1.399999);
		TextDrawColor(TextNaDrzwi[i], -1);
		TextDrawSetOutline(TextNaDrzwi[i], 1);
		TextDrawSetProportional(TextNaDrzwi[i], 1);
		TextDrawUseBox(TextNaDrzwi[i], 1);
		TextDrawBoxColor(TextNaDrzwi[i], 55);
		TextDrawTextSize(TextNaDrzwi[i], 93.000000, 191.000000);
////////////////////////////////////////////////////////////////////////////////
	    Licznik[i] = TextDrawCreate(552.000000,146.000000," ");
		TextDrawUseBox(Licznik[i],1);
		TextDrawBoxColor(Licznik[i],0x00000043);
		TextDrawTextSize(Licznik[i],690.000000,124.000000);
		TextDrawAlignment(Licznik[i],2);
		TextDrawBackgroundColor(Licznik[i],0xFFFFFFFF);
		TextDrawFont(Licznik[i],1);
		TextDrawLetterSize(Licznik[i],0.190000,0.659998);
		TextDrawColor(Licznik[i],0x5BC73DFF);
		TextDrawSetProportional(Licznik[i],1);
		TextDrawSetShadow(Licznik[i],0);
////////////////////////////////////////////////////////////////////////////////
		OBJ[i] = TextDrawCreate(250.0,300.0," ");
		TextDrawAlignment(OBJ[i],2);
		TextDrawBackgroundColor(OBJ[i],0x000000ff);
		TextDrawLetterSize(OBJ[i],0.344444,1.100000);
		TextDrawColor(OBJ[i],0xffffffff);
		TextDrawSetProportional(OBJ[i],1);
		TextDrawSetShadow(OBJ[i],1);
////////////////////////////////////////////////////////////////////////////////
		strdel(tekst_global, 0, 2048);
	    format(tekst_global, sizeof(tekst_global), "%s (%d)", ImieGracza2(i), i);
	    DaneGracza[i][gNICK] = CreateDynamic3DTextLabel(tekst_global,0xFFFFFFEE,0.0,0.0,0.13,20.0,i,INVALID_VEHICLE_ID, 1);
		DaneGracza[i][gOpisPostaci] = CreateDynamic3DTextLabel(" ",0xFFFFFFDD,0.0,0.0,-0.6,10.0,i);
////////////////////////////////////////////////////////////////////////////////
		TabelaRyb[i] = CreateProgressBar(500.0, 120.0, 106.0, _, 0x0000FFFF, 100.0);
		PasekGlodu[i] = CreateProgressBar(500.0,105.0,106.0,_, 0x88b711FF, 104.0);
		PasekGloduWLACZONY[i] = 1;
		KartyGracza111[i] = CreateProgressBar(256.0,115.0,60.0,7, 0x88b711FF, 104.0);
		KartyGracza222[i] = CreateProgressBar(361.0,248.0,60.0,7, 0x88b711FF, 104.0);
		KartyGracza333[i] = CreateProgressBar(131.0,148.0,60.0,7, 0x88b711FF, 104.0);
		KartyGracza444[i] = CreateProgressBar(474.0,183.0,60.0,7, 0x88b711FF, 104.0);
		KartyGracza555[i] = CreateProgressBar(424.0,113.0,60.0,7, 0x88b711FF, 104.0);
		KartyGracza666[i] = CreateProgressBar(31.0,248.0,60.0,7, 0x88b711FF, 104.0);
	}
}

public OnGameModeExit()
{
	new str[124];
	strdel(str, 0, 124);
    format(str, sizeof(str), "UPDATE `five_postacie` SET `ONLINE` = '0' WHERE `ONLINE` = '%d'", 1);
    mysql_query(str);
	FadeExit();
	KillTimer(AFKTimer);
	mysql_close();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	ResetPlayerWeapons(playerid);
	if(IsPlayerNPC(playerid))
	{
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername, sizeof(playername));
		if(!strcmp(playername, "Frank_Mattson", false))
		{
			SetSpawnInfo(playerid,69,255,1462.0745,2630.8787,10.8203,0.0,0,0,0,0,0,0);
		}
		return 1;
	}
   	return 1;
}
public OnPlayerConnect(playerid)
{
	dDialogid[playerid]=0;
	SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
	print("0a");
	UpdateDynamic3DTextLabelText(DaneGracza[playerid][gOpisPostaci], 0xAAAAFFFF, " ");
	OstrzezeniaAir[playerid] = 0;
	DaneGracza[playerid][gPokerZetony] = -1;
	GangZonePL[playerid] = false;
	WybralMozliwoscPoker[playerid] = 0;
	FadePlayerConnect(playerid);
    SetPlayerColor(playerid, CZARNY);
    ResetPlayerWeapons(playerid);
	SetPlayerWeather(playerid, 2);
	DaneGracza[playerid][gKajdanki] = -1;
	///
	new sql[200];
	format(sql, sizeof(sql), "SELECT * FROM `five_postacie` WHERE `IMIE_NAZWISKO` = '%s' LIMIT 1", ImieGracza(playerid));
	mysql_query(sql);
	mysql_store_result();
	print("1");
	if(mysql_num_rows() != 0)
	{
		print("2");
	   	new sql1[200];
		format(sql1, sizeof(sql1), "SELECT `ID`, `GUID`, `AKTYWNE` FROM `five_postacie` WHERE `IMIE_NAZWISKO` = '%s' LIMIT 1", ImieGracza(playerid));
		mysql_query(sql1);
		mysql_store_result();
	    mysql_fetch_row(sql1);
	    sscanf(sql1, "p<|>ddd", DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid][gAKTYWNE]);
	    if(DaneGracza[playerid][gAKTYWNE] == 1 && (DaneGracza[playerid][gAKTYWNE] < gettime() && DaneGracza[playerid][gAKTYWNE] != -1))
	    {
			new str5[256];
			format(str5, sizeof(str5), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerów Role Play!\n\n{DEDEDE}Próbujesz zalogowaæ siê na postaæ:{88B711} %s\n{DEDEDE}Wpisz swoje has³o(Globalne) i kliknij ''Zaloguj'' aby sie zalogowaæ!",ImieGracza2(playerid));
			dShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Panel Logowania{88b711}:", str5, "Zaloguj", "Zmieñ nick");
		}
		else
		{
            new str4[256];
	    	format(str4, sizeof(str4), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerów Role Play!\n\n{DEDEDE}Próbujesz zalogowaæ siê na postaæ:{88B711} %s\n{DEDEDE}Taka postaæ jest Zablokowana, aby to wyjaœniæ wejdz na www.five-rp.com",ImieGracza2(playerid));
			dShowPlayerDialog(playerid, DIALOG_INFO_BP, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Panel Logowania{88b711}:", str4, "Zmieñ nick", "Wyjdz");
		}
		print("3");
	}
	else
	{
		print("4");
        new str3[256];
	  	format(str3, sizeof(str3), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerów Role Play!\n\n{DEDEDE}Próbujesz zalogowaæ siê na postaæ:{88B711} %s\n{DEDEDE}Taka postaæ nie istnieje, aby j¹ utworzyæ wejdz na www.five-rp.com",ImieGracza2(playerid));
		dShowPlayerDialog(playerid, DIALOG_INFO_BP, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Panel Logowania{88b711}:", str3, "Zmieñ nick", "Wyjdz");
	}
	print("5");
	SetPlayerVirtualWorld(playerid, 1024);
	PoziomLakieru[playerid] = -1;
	MalowanieKolor[playerid][0] = -1;
	MalowanieKolor[playerid][1] = -1;
	DaneGracza[playerid][gSznur] = -1;
	MalowanieKolor[playerid][1] = -1;
	ResetPlayerWeapons(playerid);
	OfertaInfo[playerid][oSprzedajacy] = -1;
	OfertaInfo[playerid][oKlient] = -1;
	DestroyDynamic3DTextLabel(Text3D:Opisek[playerid]);
	zalogowany[playerid] = false;
    OferujeA[playerid] = -1;
	SetPlayerColor(playerid, CZARNY);
	DaneGracza[playerid][gKOLOR] = CZARNY;
	if(Relog[playerid] != 1)
	{
		connectplayer(playerid);
	}
	else
	{
		Relog[playerid] = 0;
	}
	if(IsPlayerNPC(playerid)) return 1;
	return 1;
}
stock connectplayer(playerid)
{
	////////////////////////////////////////////////////////////////////////////////
	TextOferty0[playerid] = CreatePlayerTextDraw(playerid, 408.499969, 130.000000, "Oferta, wybierz jedna z opcji:");
	PlayerTextDrawBackgroundColor(playerid, TextOferty0[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty0[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty0[playerid], 0.230000, 0.899999);
	PlayerTextDrawColor(playerid, TextOferty0[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TextOferty0[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TextOferty0[playerid], 1);
	PlayerTextDrawUseBox(playerid, TextOferty0[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TextOferty0[playerid], 50269196);
	PlayerTextDrawTextSize(playerid, TextOferty0[playerid], 629.299194, 1.399999);
	
	Lokalizacja[playerid] = CreatePlayerTextDraw(playerid,3.000000, 422.500000, " ");
	PlayerTextDrawBackgroundColor(playerid,Lokalizacja[playerid], 8448863); 
	PlayerTextDrawFont(playerid,Lokalizacja[playerid], 3);
	PlayerTextDrawLetterSize(playerid,Lokalizacja[playerid], 0.240000, 1.200000); 
	PlayerTextDrawColor(playerid,Lokalizacja[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Lokalizacja[playerid], 1);
	PlayerTextDrawSetProportional(playerid,Lokalizacja[playerid], 1);

	TextOferty1[playerid] = CreatePlayerTextDraw(playerid, 519.000000, 141.700012, " ");
	PlayerTextDrawAlignment(playerid, TextOferty1[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, TextOferty1[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty1[playerid], 0.319999, 0.899999);
	PlayerTextDrawColor(playerid, TextOferty1[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TextOferty1[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty1[playerid], 1);
	PlayerTextDrawUseBox(playerid, TextOferty1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TextOferty1[playerid], 926365495);
	PlayerTextDrawTextSize(playerid, TextOferty1[playerid], 608.000000, 221.000000);

	TextOferty2[playerid] = CreatePlayerTextDraw(playerid, 617.000000, 128.499969, "x");
	PlayerTextDrawBackgroundColor(playerid, TextOferty2[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty2[playerid], 0.389999, 1.000000);
	PlayerTextDrawColor(playerid, TextOferty2[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TextOferty2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty2[playerid], 1);
	PlayerTextDrawTextSize(playerid, TextOferty2[playerid], 626.000000, 10.000000);

	TextOferty3[playerid] = CreatePlayerTextDraw(playerid, 425.000000, 224.000000, "Gotowka");
	PlayerTextDrawBackgroundColor(playerid, TextOferty3[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty3[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty3[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, TextOferty3[playerid], -1967713793);
	PlayerTextDrawSetOutline(playerid, TextOferty3[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty3[playerid], 1);
	PlayerTextDrawTextSize(playerid, TextOferty3[playerid], 460.000000, 10.000000);

	TextOferty4[playerid] = CreatePlayerTextDraw(playerid, 493.000000, 224.000000, "Konto Bankowe");
	PlayerTextDrawBackgroundColor(playerid, TextOferty4[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty4[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty4[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, TextOferty4[playerid], -1967713793);
	PlayerTextDrawSetOutline(playerid, TextOferty4[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty4[playerid], 1);
	PlayerTextDrawTextSize(playerid, TextOferty4[playerid], 552.000000, 10.000000);

	TextOferty5[playerid] = CreatePlayerTextDraw(playerid, 583.000000, 224.000000, "Odrzuc");
	PlayerTextDrawBackgroundColor(playerid, TextOferty5[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty5[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty5[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, TextOferty5[playerid], -872414977);
	PlayerTextDrawSetOutline(playerid, TextOferty5[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty5[playerid], 1);
	PlayerTextDrawTextSize(playerid, TextOferty5[playerid], 611.000000, 10.000000);
	
	TextOferty6[playerid] = CreatePlayerTextDraw(playerid, 475.000000, 224.000000, "Akceptuj");
	PlayerTextDrawBackgroundColor(playerid, TextOferty6[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty6[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty6[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, TextOferty6[playerid], -1967713793);
	PlayerTextDrawSetOutline(playerid, TextOferty6[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty6[playerid], 1);
	PlayerTextDrawTextSize(playerid, TextOferty6[playerid], 508.000000, 10.000000);

	TextOferty7[playerid] = CreatePlayerTextDraw(playerid, 539.000000, 224.000000, "Odrzuc");
	PlayerTextDrawBackgroundColor(playerid, TextOferty7[playerid], 255);
	PlayerTextDrawFont(playerid, TextOferty7[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TextOferty7[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, TextOferty7[playerid], -872414977);
	PlayerTextDrawSetOutline(playerid, TextOferty7[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TextOferty7[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TextOferty7[playerid], 1);
	PlayerTextDrawTextSize(playerid, TextOferty7[playerid], 566.000000, 10.000000);
	
	////////////////////////////////Poker////////////////////////////////////////////////////////
	Poker1[playerid] = CreatePlayerTextDraw(playerid, 310.000000, 310.000000, "Pula zakladow ~r~$0");
	PlayerTextDrawAlignment(playerid, Poker1[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Poker1[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, Poker1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Poker1[playerid], 0.40000, 1.800000);
	PlayerTextDrawColor(playerid, Poker1[playerid], 0x88b711FF);
	PlayerTextDrawSetOutline(playerid, Poker1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Poker1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Poker1[playerid], 0);
	PlayerTextDrawUseBox(playerid, Poker1[playerid], 0);
	PlayerTextDrawBoxColor(playerid, Poker1[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, Poker1[playerid], 600.000000, 317.000000);
	
	Poker2[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 220.000000, "Twoje Mozliwosci");
	PlayerTextDrawAlignment(playerid, Poker2[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Poker2[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, Poker2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Poker2[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Poker2[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, Poker2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Poker2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Poker2[playerid], 0);
	PlayerTextDrawUseBox(playerid, Poker2[playerid], 1);
	PlayerTextDrawBoxColor(playerid, Poker2[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, Poker2[playerid], 600.000000, 120.000000);
	
	Poker3[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 233.000000, "Sprawdzam");
	PlayerTextDrawAlignment(playerid, Poker3[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Poker3[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, Poker3[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Poker3[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Poker3[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, Poker3[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Poker3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Poker3[playerid], 0);
	PlayerTextDrawUseBox(playerid, Poker3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Poker3[playerid], 1);
	PlayerTextDrawBoxColor(playerid, Poker3[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, Poker3[playerid], 10.000000, 120.000000);

	Poker4[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 246.000000, "Przebijam");
	PlayerTextDrawAlignment(playerid, Poker4[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Poker4[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, Poker4[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Poker4[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Poker4[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, Poker4[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Poker4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Poker4[playerid], 0);
	PlayerTextDrawUseBox(playerid, Poker4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Poker4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, Poker4[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, Poker4[playerid], 10.000000, 120.000000);

	Poker5[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 259.000000, "Pasuje");
	PlayerTextDrawAlignment(playerid, Poker5[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Poker5[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, Poker5[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Poker5[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Poker5[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, Poker5[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Poker5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Poker5[playerid], 0);
	PlayerTextDrawUseBox(playerid, Poker5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Poker5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, Poker5[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, Poker5[playerid], 10.000000, 120.000000);

	Poker6[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 272.000000, "Opuszczam Stol");
	PlayerTextDrawAlignment(playerid, Poker6[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Poker6[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, Poker6[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Poker6[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Poker6[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, Poker6[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Poker6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Poker6[playerid], 0);
	PlayerTextDrawUseBox(playerid, Poker6[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Poker6[playerid], 1);
	PlayerTextDrawBoxColor(playerid, Poker6[playerid], 0x860000FF);
	PlayerTextDrawTextSize(playerid, Poker6[playerid], 10.000000, 120.000000);
	
	KartyGracza[playerid] = CreatePlayerTextDraw(playerid, 547.500000, 335.000000, "Twoje karty");
	PlayerTextDrawAlignment(playerid, KartyGracza[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, KartyGracza[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza[playerid], 600.000000, 122.000000);
	
	KartaGracza1[playerid] = CreatePlayerTextDraw(playerid, 550.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza1[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza1[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza1[playerid], 60.000000, 80.000000);
	
	KartaGracza2[playerid] = CreatePlayerTextDraw(playerid, 485.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza2[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza2[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza2[playerid], 60.000000, 80.000000);
	
	WylosowaneKarty[playerid] = CreatePlayerTextDraw(playerid, 310.000000, 335.000000, "Karty na stole");
	PlayerTextDrawAlignment(playerid, WylosowaneKarty[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, WylosowaneKarty[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, WylosowaneKarty[playerid], 1);
	PlayerTextDrawLetterSize(playerid, WylosowaneKarty[playerid], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, WylosowaneKarty[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, WylosowaneKarty[playerid], 0);
	PlayerTextDrawSetProportional(playerid, WylosowaneKarty[playerid], 1);
	PlayerTextDrawSetShadow(playerid, WylosowaneKarty[playerid], 0);
	PlayerTextDrawUseBox(playerid, WylosowaneKarty[playerid], 1);
	PlayerTextDrawBoxColor(playerid, WylosowaneKarty[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, WylosowaneKarty[playerid], 600.000000, 317.000000);
	
	WylosowaneKarty1[playerid] = CreatePlayerTextDraw(playerid, 150.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, WylosowaneKarty1[playerid], 4);
	PlayerTextDrawColor(playerid, WylosowaneKarty1[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, WylosowaneKarty1[playerid], 60.000000, 80.000000);
	
	WylosowaneKarty2[playerid] = CreatePlayerTextDraw(playerid, 215.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, WylosowaneKarty2[playerid], 4);
	PlayerTextDrawColor(playerid, WylosowaneKarty2[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, WylosowaneKarty2[playerid], 60.000000, 80.000000);
	
	WylosowaneKarty3[playerid] = CreatePlayerTextDraw(playerid, 280.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, WylosowaneKarty3[playerid], 4);
	PlayerTextDrawColor(playerid, WylosowaneKarty3[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, WylosowaneKarty3[playerid], 60.000000, 80.000000);
	
	WylosowaneKarty4[playerid] = CreatePlayerTextDraw(playerid, 345.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, WylosowaneKarty4[playerid], 4);
	PlayerTextDrawColor(playerid, WylosowaneKarty4[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, WylosowaneKarty4[playerid], 60.000000, 80.000000);
	
	WylosowaneKarty5[playerid] = CreatePlayerTextDraw(playerid, 410.000000, 350.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, WylosowaneKarty5[playerid], 4);
	PlayerTextDrawColor(playerid, WylosowaneKarty5[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, WylosowaneKarty5[playerid], 60.000000, 80.000000);
	
	//////////////////////Gracz przy stoliku, stanowisko 1//////////////////////////////////////////////
	
	KartaGracza3[playerid] = CreatePlayerTextDraw(playerid, 255.000000, 67.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza3[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza3[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza3[playerid], 30.000000, 45.000000);
	
	KartaGracza4[playerid] = CreatePlayerTextDraw(playerid, 287.000000, 67.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza4[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza4[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza4[playerid], 30.000000, 45.000000);
	
	KartyGracza1[playerid] = CreatePlayerTextDraw(playerid, 286.000000, 115.000000, "Oczekiwanie...");
	PlayerTextDrawAlignment(playerid, KartyGracza1[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza1[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza1[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza1[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza1[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza1[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza1[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, KartyGracza1[playerid], 600.000000, 59.500000);
	
	KartyGracza11[playerid] = CreatePlayerTextDraw(playerid, 286.000000, 127.000000, "$0");
	PlayerTextDrawAlignment(playerid, KartyGracza11[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza11[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza11[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza11[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza11[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza11[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza11[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza11[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza11[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza11[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza11[playerid], 600.000000, 59.500000);
	
	//////////////////////Gracz przy stoliku, stanowisko 2//////////////////////////////////////////////
	
	KartaGracza5[playerid] = CreatePlayerTextDraw(playerid, 360.000000, 200.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza5[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza5[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza5[playerid], 30.000000, 45.000000);
	
	KartaGracza6[playerid] = CreatePlayerTextDraw(playerid, 392.000000, 200.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza6[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza6[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza6[playerid], 30.000000, 45.000000);
	
	KartyGracza2[playerid] = CreatePlayerTextDraw(playerid, 391.000000, 248.000000, "Oczekiwanie...");
	PlayerTextDrawAlignment(playerid, KartyGracza2[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza2[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza2[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza2[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza2[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza2[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza2[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, KartyGracza2[playerid], 600.000000, 59.500000);
	
	KartyGracza22[playerid] = CreatePlayerTextDraw(playerid, 391.000000, 260.000000, "$0");
	PlayerTextDrawAlignment(playerid, KartyGracza22[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza22[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza22[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza22[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza22[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza22[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza22[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza22[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza22[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza22[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza22[playerid], 600.000000, 59.500000);
	
	/////////////////////Gracz przy stoliku, stanowisko 3//////////////////////////////////////////////
	
	KartaGracza7[playerid] = CreatePlayerTextDraw(playerid, 130.000000, 100.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza7[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza7[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza7[playerid], 30.000000, 45.000000);
	
	KartaGracza8[playerid] = CreatePlayerTextDraw(playerid, 162.000000, 100.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza8[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza8[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza8[playerid], 30.000000, 45.000000);
	
	KartyGracza3[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 148.000000, "Oczekiwanie...");
	PlayerTextDrawAlignment(playerid, KartyGracza3[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza3[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza3[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza3[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza3[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza3[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza3[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza3[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza3[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, KartyGracza3[playerid], 600.000000, 59.500000);
	
	KartyGracza33[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 160.000000, "$0");
	PlayerTextDrawAlignment(playerid, KartyGracza33[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza33[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza33[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza33[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza33[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza33[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza33[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza33[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza33[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza33[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza33[playerid], 600.000000, 59.500000);
	
	/////////////////////Gracz przy stoliku, stanowisko 4//////////////////////////////////////////////
	
	KartaGracza9[playerid] = CreatePlayerTextDraw(playerid, 473.000000, 135.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza9[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza9[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza9[playerid], 30.000000, 45.000000);
	
	KartaGracza10[playerid] = CreatePlayerTextDraw(playerid, 505.000000, 135.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza10[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza10[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza10[playerid], 30.000000, 45.000000);
	
	KartyGracza4[playerid] = CreatePlayerTextDraw(playerid, 504.000000, 183.000000, "Oczekiwanie...");
	PlayerTextDrawAlignment(playerid, KartyGracza4[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza4[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza4[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza4[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza4[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza4[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza4[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza4[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza4[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, KartyGracza4[playerid], 600.000000, 59.500000);
	
	KartyGracza44[playerid] = CreatePlayerTextDraw(playerid, 504.000000, 195.000000, "$0");
	PlayerTextDrawAlignment(playerid, KartyGracza44[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza44[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza44[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza44[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza44[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza44[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza44[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza44[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza44[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza44[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza44[playerid], 600.000000, 59.500000);
	
	/////////////////////Gracz przy stoliku, stanowisko 5//////////////////////////////////////////////
	
	KartaGracza11[playerid] = CreatePlayerTextDraw(playerid, 423.000000, 65.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza11[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza11[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza11[playerid], 30.000000, 45.000000);
	
	KartaGracza12[playerid] = CreatePlayerTextDraw(playerid, 455.000000, 65.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza12[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza12[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza12[playerid], 30.000000, 45.000000);
	
	KartyGracza5[playerid] = CreatePlayerTextDraw(playerid, 454.000000, 113.000000, "Oczekiwanie...");
	PlayerTextDrawAlignment(playerid, KartyGracza5[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza5[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza5[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza5[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza5[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza5[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza5[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza5[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza5[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, KartyGracza5[playerid], 600.000000, 59.500000);
	
	KartyGracza55[playerid] = CreatePlayerTextDraw(playerid, 454.000000, 125.000000, "$0");
	PlayerTextDrawAlignment(playerid, KartyGracza55[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza55[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza55[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza55[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza55[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza55[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza55[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza55[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza55[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza55[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza55[playerid], 600.000000, 59.500000);
	
	/////////////////////Gracz przy stoliku, stanowisko 6//////////////////////////////////////////////
	
	KartaGracza13[playerid] = CreatePlayerTextDraw(playerid, 30.000000, 200.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza13[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza13[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza13[playerid], 30.000000, 45.000000);
	
	KartaGracza14[playerid] = CreatePlayerTextDraw(playerid, 62.000000, 200.000000, "LD_CARD:cdback");
	PlayerTextDrawFont(playerid, KartaGracza14[playerid], 4);
	PlayerTextDrawColor(playerid, KartaGracza14[playerid], 0xFFFFFFFF);
	PlayerTextDrawTextSize(playerid, KartaGracza14[playerid], 30.000000, 45.000000);
	
	KartyGracza6[playerid] = CreatePlayerTextDraw(playerid, 61.000000, 248.000000, "Oczekiwanie...");
	PlayerTextDrawAlignment(playerid, KartyGracza6[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza6[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza6[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza6[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza6[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza6[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza6[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza6[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza6[playerid], 0x88B711FF);
	PlayerTextDrawTextSize(playerid, KartyGracza6[playerid], 600.000000, 59.500000);
	
	KartyGracza66[playerid] = CreatePlayerTextDraw(playerid, 61.000000, 260.000000, "$0");
	PlayerTextDrawAlignment(playerid, KartyGracza66[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, KartyGracza66[playerid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, KartyGracza66[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KartyGracza66[playerid], 0.180000, 0.800000);
	PlayerTextDrawColor(playerid, KartyGracza66[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, KartyGracza66[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KartyGracza66[playerid], 1);
	PlayerTextDrawSetShadow(playerid, KartyGracza66[playerid], 0);
	PlayerTextDrawUseBox(playerid, KartyGracza66[playerid], 1);
	PlayerTextDrawBoxColor(playerid, KartyGracza66[playerid], 0xDEDEDEFF);
	PlayerTextDrawTextSize(playerid, KartyGracza66[playerid], 600.000000, 59.500000);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	DaneGracza[playerid][gSpam] = 0;
	ALK[playerid] = 0;
	DaneGracza[playerid][gTYPCHODZENIA] = 0;
	if(DaneGracza[playerid][gPaczkaUID] != 0)
	{
		PaczkaInfo[DaneGracza[playerid][gPaczkaUID]][xZAJETY] = 0;
		DaneGracza[playerid][gPaczkaUID] = 0;
		DaneGracza[playerid][gPaczkaM] = 0;
		DaneGracza[playerid][gPaczkaT] = 0;
	}
	UpdateDynamic3DTextLabelText(DaneGracza[playerid][gOpisPostaci], 0xAAAAFFFF, " ");
	DzwoniID[playerid] = 0; 
	Dzwoni[playerid] = 0;
	DaneGracza[playerid][gAdmGroup] = 0;
	Discman[playerid] = 0;
	Odebral[playerid] = 0;
	ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
	DeletePVar(playerid,"uidbudka");
	PlayerTextDrawHide(playerid, Lokalizacja[playerid]);
	GangZonePL[playerid] = false;
	if(Pracuje[playerid] != 0)
	{
		new uid = SprawdzCarUID(Pracuje[playerid]);
		SetVehicleToRespawn(Pracuje[playerid]);
		PojazdInfo[uid][pStan] = 1000.0;
		PojazdInfo[uid][pPaliwo] = 100;
		SetVehicleHealth(Pracuje[playerid], PojazdInfo[uid][pStan] );
		RepairVehicle(Pracuje[playerid]);
		Pracuje[playerid] = 0;
		DaneGracza[playerid][gSwp] = 0;
	}
	if(DaneGracza[playerid][gWywiad] != 0)
	{
		DaneGracza[DaneGracza[playerid][gWywiad]][gWywiad] = 0;
		DaneGracza[playerid][gWywiad] = 0;
	}
	karnet[playerid] = 0;
	silka[playerid] = 0;
	if(taxijedz[playerid] != 0)
	{
		new vuid = GetPVarInt(playerid, "przejazuid");
		new guid = GetPVarInt(playerid, "przejazguid");
		new cena = GetPVarInt(playerid, "przejazcena");
		new Float:przejechal, Float:cenak;
		przejechal = (PojazdInfo[vuid][pPrzebieg]/1000)-GetPVarFloat(playerid, "przejechanes");
		cenak = przejechal*cena;
		new procent = floatround(cenak/10);
		if(procent > 20)
		{
			procent = 20;
		}
		DaneGracza[GetPVarInt(playerid, "przejazt")][gPremia] += procent;
		GrupaInfo[guid][gSaldo] += (floatround(cenak)-procent);
		Dodajkase( playerid, -floatround( cenak ) );
		new taxisstr[124];
		format(taxisstr, sizeof(taxisstr), "~b~~h~~h~Przychod: %d$",floatround( cenak ));
		GameTextForPlayer(GetPVarInt(playerid, "przejazt"),taxisstr,5000,4);
		DisablePlayerCheckpoint(GetPVarInt(playerid, "przejazt"));
		taxijedz[playerid] = 0;
	}
	if(DaneGracza[playerid][gTworzyWyscig] != 0)
	{
		GrupaInfo[TrasaDuty[playerid]][gSaldo] += 1000;
		ZapiszSaldo(TrasaDuty[playerid]);
		UsunWyscig(TrasaDuty[playerid], DaneGracza[playerid][gTworzyWyscigNazwa], TrasaDutyNr[playerid]);
		TrasaDuty[playerid] = 0;
		TrasaDutyNr[playerid] = 0;
	}
	if(Tag[playerid] != -1)
	{
		UpdateDynamic3DTextLabelText(ObiektInfo[Tag[playerid]][objNapis], 0xC2A2DAFF, " ");
		RoznicaLakieru[playerid] = 0;
		ObiektInfo[Tag[playerid]][gZajety] = 0;
		Tag[playerid] = -1;
		LakierujeCzas[playerid] = 0;
	}
	if(LakierujeCzas[playerid] != 0)
	{
		GameTextForPlayer(playerid,"~n~~g~Malowanie przerwane!", 3000,4);
		RoznicaLakieru[playerid] = 0;
		UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[MalowanieKolor[playerid][3]][pID]], 0xAAAAFFFF, " ");
		LakierujeCzas[playerid] = 0;
		GameTextForPlayer(NaprawiaID[playerid], "~n~~g~Gracz ktory lakierowal ci pojazd wyszedl z serwera!", 5000, 3);
        NaprawianieVW[playerid] = 0;
	}
	if(UzywaBudkiUID[playerid] != 0)
	{
		ObiektInfo[UzywaBudkiUID[playerid]][objPoker][0] = 0;
	}
	///////////////////////////////////////////////////////////////////////
	WybralMozliwoscPoker[playerid] = 0;
	GraWPokera[playerid] = 0;
	WpisalKase[playerid] = 0;
	if(DaneGracza[playerid][gPokerZetony] != -1)
	{
		new kasa = DaneGracza[playerid][gPokerZetony] / 10;
		Dodajkase(playerid, kasa);
		DaneGracza[playerid][gPokerZetony] = -1;
	}
	new id_pokera = DaneGracza[playerid][gPoker];
	for(new i = 0; i < 30; i++)
	{
		if(DaneGracza[playerid][gPokerObj][i] != 0)
		{
			DestroyDynamicObject(DaneGracza[playerid][gPokerObj][i]);
			DaneGracza[playerid][gPokerObj][i] = 0;
			DaneGracza[playerid][gNumeryObiektowPostawionych][i] = 0;
		}
	}
	CancelSelectTextDraw(playerid);
	for(new i = 0; i < 6; i++)
	{
		if(ObiektInfo[id_pokera][objPoker][i] != -1)
		{
			UsunBaryGracz(ObiektInfo[id_pokera][objPoker][i]);
		}
	}
	for(new i = 0; i < 6; i++)
	{
		if(ObiektInfo[id_pokera][objPoker][i] == playerid)
		{
			ObiektInfo[id_pokera][gAktualniGracze][i] = -1;
			break;
		}
	}
	new ilosc_oczekujacych_graczy = 0;
	if(DaneGracza[playerid][gRundaPokerCzas] != 0)
	{
		for(new i = 0; i < 6; i++)
		{
			if(ObiektInfo[id_pokera][objPoker][i] != -1 && DaneGracza[ObiektInfo[id_pokera][objPoker][i]][gRundaPokerCzas] != 0)
			{
				ilosc_oczekujacych_graczy++;
			}
		}
		DaneGracza[playerid][gRundaPokerCzas] = 0;
		if(ilosc_oczekujacych_graczy < 2)
		{
			for(new i = 0; i < 6; i++)
			{
				if(ObiektInfo[id_pokera][objPoker][i] != -1)
				{
					DaneGracza[ObiektInfo[id_pokera][objPoker][i]][gRundaPokerCzas] = 0;
					RozpocznijPokera(ObiektInfo[id_pokera][objPoker][i], DaneGracza[ObiektInfo[id_pokera][objPoker][i]][gPoker]);
				}
			}
		}
	}
	OdswiezTexdrawyPoker(id_pokera, 0);
	new ilosc = SprawdzIloscGraczy(id_pokera);
	if(ilosc >= 2)
	{
		SprawdzKolejGracza(playerid);
	}
	else
	{
		KoniecRundy(id_pokera);
	}
	for(new i = 0; i < 6; i++)
	{
		if(ObiektInfo[id_pokera][objPoker][i] == playerid)
		{
			ObiektInfo[id_pokera][objPoker][i] = -1;
			DaneGracza[playerid][gPoker] = 0;
			DaneGracza[playerid][gPokerStanowisko] = -1;
			DaneGracza[playerid][gPokerPostawione] = 0;
			DaneGracza[playerid][gPokerKarty][0] = 0;
			DaneGracza[playerid][gPokerKarty][1] = 0;
			DaneGracza[playerid][gInformacjePoker][0] = 0;
			DaneGracza[playerid][gInformacjePoker][1] = 0;
			DaneGracza[playerid][gInformacjePoker][2] = 0;
			DaneGracza[playerid][gInformacjePoker][3] = 0;
			DaneGracza[playerid][gInformacjePoker][4] = 0;
			DaneGracza[playerid][gInformacjePoker][5] = 0;
			DaneGracza[playerid][gInformacjePoker][6] = 0;
			break;
		}
	}
	PlayerTextDrawHide(playerid,KartyGracza[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza1[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza11[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza2[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza22[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza3[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza33[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza4[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza44[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza5[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza55[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza6[playerid]);
	PlayerTextDrawHide(playerid,KartyGracza66[playerid]);
	PlayerTextDrawHide(playerid,Poker1[playerid]);
	PlayerTextDrawHide(playerid,Poker2[playerid]);
	PlayerTextDrawHide(playerid,Poker3[playerid]);
	PlayerTextDrawHide(playerid,Poker4[playerid]);
	PlayerTextDrawHide(playerid,Poker5[playerid]);
	PlayerTextDrawHide(playerid,Poker6[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza1[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza2[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza3[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza4[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza5[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza6[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza7[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza8[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza9[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza10[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza11[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza12[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza13[playerid]);
	PlayerTextDrawHide(playerid,KartaGracza14[playerid]);
	PlayerTextDrawHide(playerid,WylosowaneKarty[playerid]);
	PlayerTextDrawHide(playerid,WylosowaneKarty1[playerid]);
	PlayerTextDrawHide(playerid,WylosowaneKarty2[playerid]);
	PlayerTextDrawHide(playerid,WylosowaneKarty3[playerid]);
	PlayerTextDrawHide(playerid,WylosowaneKarty4[playerid]);
	PlayerTextDrawHide(playerid,WylosowaneKarty5[playerid]);
	Frezuj(playerid,1);
	SetCameraBehindPlayer(playerid);
	//////////////////////////////////////////////////////////
	KillTimer(DaneGracza[playerid][gTimerGlodu]);
	KillTimer(DaneGracza[playerid][gTimerParliator]);
	TextDrawHideForPlayer(playerid, Worek);
	if(DaneGracza[playerid][gBronUID] != 0)
	{
		UsunBronieGracza(playerid, PrzedmiotInfo[DaneGracza[playerid][gBronUID]][pWar1]);
		PrzedmiotInfo[DaneGracza[playerid][gBronUID]][pUzywany] = 0;
		ZapiszPrzedmiot(DaneGracza[playerid][gBronUID]);
		DaneGracza[playerid][gBronUID] = 0;
		DaneGracza[playerid][gBronAmmo] = 0;
		DeletePVar(playerid, "UzywanaBron");
		ZapiszGracza(playerid);
	}
	//ZaladujPojazdyGracza(playerid);
	//WyladujPojazdyGracza(playerid);
    if(DaneGracza[playerid][gSluzba] != 0)
	{
		ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
	}
    DutyAdmina[playerid] = 0;
	Wedkuje[playerid] = 0;
    Wylogowany[playerid] = 0;
    new uids = GetPVarInt(playerid, "inedit");
	obiektinedit[uids] = false;
    Rekawiczki[playerid] = 0;
    DutyDZ[playerid] = 0;
	Rolki[playerid] = 0;
	Dostal[playerid] = 0;
	GPS[playerid] = 0;
	PASY[playerid] = 0;
	Amfeta[playerid] = 0;
	Kokaina[playerid] = 0;
	Extasa[playerid] = 0;
	LSD[playerid] = 0;
	Grzyby[playerid] = 0;
	Hera[playerid] = 0;
	Mefedron[playerid] = 0;
	Tag[playerid] = -1;
	OpisekJaki[playerid] = 0;
	taxijedz[playerid] = 0;
	TrasaDuty[playerid] = 0;
	RoznicaLakieru[playerid] = 0;
	spanuje[playerid] = 0;
    DutyNR[playerid] = 0;
	////////////////////////////////////////////////////////////////////////////
	WybralMozliwoscPoker[playerid] = 0;
	////////////////////////////////////////////////////////////////////////////
    FrezzPlayer[playerid] = 0;
	PoziomLakieru[playerid] = -1;
    Nieznajomy[playerid] = 0;
    FadePlayerDisconnect(playerid);
    DestroyDynamic3DTextLabel(Text3D:NapisWyszedl[playerid]);
    DestroyDynamic3DTextLabel(Text3D:Opisek[playerid]);
    OstatnieDrzwi[playerid] = 0;
    new Float:Pose[3];
	GetPlayerPos(playerid,Pose[0],Pose[1],Pose[2]);
	new sstr[256];
	if(reason==0)
	{
		DaneGracza[playerid][gQS] = gettime()+600;
		GetPlayerPos(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
		DaneGracza[playerid][gVW] = GetPlayerVirtualWorld(playerid);
		DaneGracza[playerid][gINT] = GetPlayerInterior(playerid);
		Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "time out", gettime()-CZAS_LETNI);
    	format(sstr,sizeof(sstr),"%s\n(time-out)",ZmianaNicku(playerid));
		NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
	}
	else if(reason==1)
	{
		Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "/q", gettime()-CZAS_LETNI);
	    new IP[16];
		GetPlayerIp(playerid, IP, sizeof(IP));
		sukces(playerid, 1, DaneGracza[playerid][gGUID], DaneGracza[playerid][gUID], DaneGracza[playerid][gIP],PRZEBYTE[playerid]);
    	format(sstr,sizeof(sstr),"%s\n(/q)",ZmianaNicku(playerid));
		NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
	}
	else if(reason==2)
	{
		if(DaneGracza[playerid][gQS] == 0)
		{
			format(sstr,sizeof(sstr),"%s\n(kick/ban)",ZmianaNicku(playerid));
			Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "kick/ban", gettime()-CZAS_LETNI);
			NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
		}
		else
		{
			format(sstr,sizeof(sstr),"%s\n(qs)",ZmianaNicku(playerid));
			Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "qs", gettime()-CZAS_LETNI);
			NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
		}
	}
	else if(reason==1000)
	{
		Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "relog/admin", gettime()-CZAS_LETNI);
    	format(sstr,sizeof(sstr),"%s\n(relog/admin)",ZmianaNicku(playerid));
		NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
	}
	else if(reason==1002)
	{
		Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "/wyloguj", gettime()-CZAS_LETNI);
    	format(sstr,sizeof(sstr),"%s\n(/wyloguj)",ZmianaNicku(playerid));
		NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
	}
	SetTimerEx("NapisUsuns",15000,0,"d",playerid);
	strdel(tekst_global, 0, 2048);
	//format(tekst_global, sizeof(tekst_global), "(Opuœci³ Serwer)", playerid);
	format(tekst_global, sizeof(tekst_global), " ", playerid);
	UpdateDynamic3DTextLabelText(DaneGracza[playerid][gNICK], 0xf5deb355, tekst_global);
	new str[124];
	strdel(str, 0, 124);
    format(str, sizeof(str), "UPDATE `five_postacie` SET `ONLINE` = '0' WHERE `ID` = '%d'", DaneGracza[playerid][gUID]);
    mysql_query(str);
	DaneGracza[playerid][gOSTATNIO_NA_SERWERZE] = gettime()-CZAS_LETNI;
	ZapiszGracza(playerid);
	ZapiszBankKasa(playerid);
	ZapiszGraczaGlobal(playerid, 1);
////////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gONLINE] = 0;
	DaneGracza[playerid][gGUID] = 0;
	Edytors[playerid] = 0;
	LOCKW[playerid] = 0;
	NaprawiaID[playerid] = 0;
	NaprawianieVW[playerid] = 0;
	NaprawiaODL[playerid] = 0;
	UzywaBudkiUID[playerid] = 0;
    NaprawiaVeh[playerid] = 0;
    NaprawiaIUID[playerid] = 0;
    animacja[playerid] = 0;
	LakierujeCzas[playerid] = 0;
    NaprawiaCzas[playerid] = 0;
    NaprawianieCena[playerid] = 0;
	DaneGracza[playerid][gUID] = 0;	
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gPokx] = 0;
	DaneGracza[playerid][gPoky] = 0;
	DaneGracza[playerid][gPokz] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gTworzyWyscig] = 0;
	DaneGracza[playerid][gTworzyWyscigCP] = 0;
	DaneGracza[playerid][gTworzyWyscigNazwa] = 0;
	DaneGracza[playerid][gWyscig] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gPokr] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gRaport] = 0;
	DaneGracza[playerid][gPytanie] = 0;
	DaneGracza[playerid][gCZAS_ONLINE] = 0;
	DaneGracza[playerid][gZarzadzajElektryka] = 0;
	DaneGracza[playerid][gPORTFEL] = 0;
	DaneGracza[playerid][gKajdanki] = -1;
	DaneGracza[playerid][gSznur] = -1;
	DaneGracza[playerid][gKoniecWyscigu] = 0;
	DaneGracza[playerid][gRaceTimeStart] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gPokerPostawione] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gNumeryObiektowPostawionych][0] = EOS;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gInformacjePoker][0] = EOS;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gSKIN] = 0;
	DaneGracza[playerid][gLskin] = 0;
	DaneGracza[playerid][gWynajem] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gPoker] = 0;
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gZDROWIE] = 0.0;
	DaneGracza[playerid][gPromile] = 0;
	DaneGracza[playerid][gZamHot] = 0;
	DaneGracza[playerid][gCheckopintID] = 0;
	DaneGracza[playerid][gWIEK] = 0;
	DaneGracza[playerid][gWAGA] = 0;
	DaneGracza[playerid][gBW] = 0;
	DaneGracza[playerid][gBetaTester] = 0;
	DaneGracza[playerid][gX] = 0.0;
	DaneGracza[playerid][gY] = 0.0;
	DaneGracza[playerid][gZ] = 0.0;
	DaneGracza[playerid][gKOLOR] = 0;
	DaneGracza[playerid][gVW] = 99999;
	DaneGracza[playerid][gSluzba] = 0;
	DaneGracza[playerid][gINT] = 0;
	DaneGracza[playerid][gOCZEKIWANA_WYPLATA] = 0;
	DaneGracza[playerid][gAKTYWNE] = 1;
    DaneGracza[playerid][gPREMIUM] = 0;
    DaneGracza[playerid][gGAMESCORE] = 0;
    DaneGracza[playerid][gOOC] = 0;
    DaneGracza[playerid][gKLATWA] = 0;
    DaneGracza[playerid][gRUN] = 0;
    DaneGracza[playerid][gBAN] = 0;
    DaneGracza[playerid][gVEH] = 0;
   	DaneGracza[playerid][gGUN] = 0;
   	DaneGracza[playerid][gKONTO_W_BANKU] = 0;
	DaneGracza[playerid][gOstatniTrening] = 0;
	DaneGracza[playerid][gSTAN_KONTA] = 0;
	DaneGracza[playerid][gKREDYT] = 0;
 	DaneGracza[playerid][gDzialalnosc1] = 0;
	DaneGracza[playerid][gDzialalnosc2] = 0;
	DaneGracza[playerid][gDzialalnosc3] = 0;
	DaneGracza[playerid][gDzialalnosc4] = 0;
	DaneGracza[playerid][gDzialalnosc5] = 0;
	DaneGracza[playerid][gDzialalnosc6] = 0;
	DaneGracza[playerid][gBronUID] = 0;
	DaneGracza[playerid][gPktKarne] = 0;
	DaneGracza[playerid][gGlod] = 0;
	DaneGracza[playerid][gWorek] = 0;
	DaneGracza[playerid][gPrzetrzmanie] = 0;
	DaneGracza[playerid][gPX] = 0;
	DaneGracza[playerid][gPY] = 0;
	DaneGracza[playerid][gPZ] = 0;
	DaneGracza[playerid][gPUID] = 0;
	DaneGracza[playerid][gBronAmmo] = 0;
	DaneGracza[playerid][gZarzadzajElektryka] = 0;
	MozeBanowac[playerid] = 0;
	ForeachEx(ilosca, 124)
	{
		DaneGracza[playerid][gUprawnienia1][ilosca] = 0;
		DaneGracza[playerid][gUprawnienia2][ilosca] = 0;
		DaneGracza[playerid][gUprawnienia3][ilosca] = 0;
		DaneGracza[playerid][gUprawnienia4][ilosca] = 0;
		DaneGracza[playerid][gUprawnienia5][ilosca] = 0;
		DaneGracza[playerid][gUprawnienia6][ilosca] = 0;
	}
	////////////////////////////////////////////////////////////////////////////
	DaneGracza[playerid][gPokerObj][0] = EOS;
	DaneGracza[playerid][gRundaPokerCzas] = 0;
	DaneGracza[playerid][gPokerKarty][0] = 0;
	DaneGracza[playerid][gPokerKarty][1] = 0;
	DaneGracza[playerid][gPokerZetony] = -1;
	////////////////////////////////////////////////////////////////////////////
	ResetPlayerWeapons(playerid);
	DeletePVar(playerid, "UzywanaBron");
	for(new i = 0; i < IloscGraczy; i++)
	{
		if(KtoJestOnline[i] == playerid)
		{
			zalogowany[playerid] = false;
			for(new o = i, d; o < IloscGraczy; o++)
			{
				d = o+1;
				KtoJestOnline[o] = KtoJestOnline[d];
			}
			IloscGraczy--;
			break;
		}
	}
////////////////////////////////////////////////////////////////////////////////
	return 1;
}
public OnPlayerSpawn(playerid)
{
	SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
	AntyCheatBroni[playerid] = 1;
	KillTimer(TimerAntyCheat[playerid]);
	TimerAntyCheat[playerid] = SetTimerEx("WlaczAntyCheata",5000,0,"d",playerid);
	TextDrawHideForPlayer(playerid, Worek);
	SetPlayerWeather(playerid, 2);
	if(zalogowany[playerid] == false && !IsPlayerNPC(playerid))
	{
	    NadajKare(playerid,-1, 0, "Spawn bez zalogowania", 0);
	    return 1;
	}
	if(DaneGracza[playerid][gZDROWIE] <= 0)
	{
		DaneGracza[playerid][gZDROWIE] = 9;
	}
 	UstawHP(playerid,DaneGracza[playerid][gZDROWIE]);
	SetPlayerDrunkLevel (playerid, DaneGracza[playerid][gPromile]);
 	SetTimerEx("Unfreeze_SetHP", 2000, 0, "i", playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	if(GraczPremium(playerid))
	{
		SetPlayerColor(playerid, 0x88B711FF);
	}
	else
	{
		SetPlayerColor(playerid, 0xDEDEDEFF);
	}
	if(DaneGracza[playerid][gPrzyczepiony1] != 0)
	{
		new sql4[200];
		format(sql4, sizeof(sql4), "SELECT * FROM `five_dodadtki` WHERE `UID` = '%d' AND `index` = '%d' LIMIT 1", DaneGracza[playerid][gUID], DaneGracza[playerid][gPrzyczepiony1]);
		mysql_query(sql4);
		mysql_store_result();
		if(mysql_num_rows() != 0)
		{
			mysql_fetch_row(sql4);
			new Float:zm[9], zmnsa[5];
			sscanf(sql4, "p<|>{dd}dddfffffffff", zmnsa[0]
				, zmnsa[1]
				, zmnsa[2]
				, zm[0]
				, zm[1]
				, zm[2]
				, zm[3]
				, zm[4]
				, zm[5]
				, zm[6]
				, zm[7]
				, zm[8]
				);
			SetPlayerAttachedObject(playerid,zmnsa[0],zmnsa[1],zmnsa[2],zm[0],zm[1],zm[2],zm[3],zm[4],zm[5],zm[6],zm[7],zm[8]);
		}
	}
	if(DaneGracza[playerid][gPrzyczepiony2] != 0)
	{
		new sql4[200];
		format(sql4, sizeof(sql4), "SELECT * FROM `five_dodadtki` WHERE `UID` = '%d' AND `index` = '%d' LIMIT 1", DaneGracza[playerid][gUID], DaneGracza[playerid][gPrzyczepiony2]);
		mysql_query(sql4);
		mysql_store_result();
		if(mysql_num_rows() != 0)
		{
			mysql_fetch_row(sql4);
			new Float:zm[9], zmnsa[5];
			sscanf(sql4, "p<|>{dd}dddfffffffff", zmnsa[0]
				, zmnsa[1]
				, zmnsa[2]
				, zm[0]
				, zm[1]
				, zm[2]
				, zm[3]
				, zm[4]
				, zm[5]
				, zm[6]
				, zm[7]
				, zm[8]
				);
			SetPlayerAttachedObject(playerid,zmnsa[0],zmnsa[1],zmnsa[2],zm[0],zm[1],zm[2],zm[3],zm[4],zm[5],zm[6],zm[7],zm[8]);
		}
	}
	if(!Osiagniecia(playerid, OSIAGNIECIE_ZALOGOWANIE))
	{
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Pierwsze zalogowanie ~g~+10GS");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_ZALOGOWANIE] = 1;
		DaneGracza[playerid][gGAMESCORE] += 10;
	    SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
		ZapiszGraczaGlobal(playerid, 1);
	}
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, DaneGracza[playerid][gPORTFEL]);
	ResetPlayerWeapons( playerid );
	SetPlayerFightingStyle(playerid, DaneGracza[playerid][gStylWalki]);
	SetProgressBarValue(Bar:PasekGlodu[playerid], DaneGracza[playerid][gGlod]);
	if(PasekGloduWLACZONY[playerid] != 0)
	{
		ShowProgressBarForPlayer(playerid, PasekGlodu[playerid]);
	}
	OnPlayerText(playerid, "-stopani");
 	if(DaneGracza[playerid][gAJ] != 0)
	{
		Teleportuj(playerid, 1174.3706,-1180.3267,87.0350);
		SetPlayerVirtualWorld(playerid, playerid + 500);
		SetPlayerInterior(playerid, 0);
		if(DaneGracza[playerid][gLskin] == 0)
		{
			SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
		}else{
		    SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
		}
		return 1;
	}
	else if(DaneGracza[playerid][gBW] != 0)
	{
		UstawHP(playerid,100);
	    Teleportuj(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
		SetPlayerCameraPos(playerid, DaneGracza[playerid][gX]-3, DaneGracza[playerid][gY],DaneGracza[playerid][gZ]+7);
	  	SetPlayerCameraLookAt(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
	    SetPlayerVirtualWorld(playerid, DaneGracza[playerid][gVW]);
	    SetPlayerInterior(playerid, DaneGracza[playerid][gINT]);
	    if(DaneGracza[playerid][gLskin] == 0)
		{
			SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
		}else{
		    SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
		}
		if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nSwiatlo] == 1)
		{
            TextDrawShowForPlayer(playerid, Light);
		}
		Frezuj(playerid, 0);
		ApplyAnimation(playerid, "PED", "FLOOR_hit", 4.1, 0, 1, 1, 1, 1);
		return 1;
	}
	else if(DaneGracza[playerid][gPrzetrzmanie] != 0)
	{
		Frezuj(playerid, 0);
		SetTimerEx("Frez", 5000, 0, "d", playerid);
		new ui = DaneGracza[playerid][gPUID];
		Teleportuj(playerid, DaneGracza[playerid][gPX], DaneGracza[playerid][gPY], DaneGracza[playerid][gPZ]);
		SetPlayerVirtualWorld(playerid, NieruchomoscInfo[ui][nVWW]);
		if(NieruchomoscInfo[ui][nSwiatlo] == 1)
		{
			TextDrawShowForPlayer(playerid, Light);
		}
		if(DaneGracza[playerid][gLskin] == 0)
		{
			SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
		}else{
			SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
		}
		return 1;
	}
	if(DaneGracza[playerid][gQS] >= gettime() && DaneGracza[playerid][gVW] == INT_BUS_VW)
	{
		DaneGracza[playerid][gQS] = 0;
	}
	else if(DaneGracza[playerid][gQS] >= gettime())
	{
		Frezuj(playerid, 0);
		SetTimerEx("Frez", 2000, 0, "d", playerid);
	    Teleportuj(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
	    SetPlayerVirtualWorld(playerid, DaneGracza[playerid][gVW]);
	    SetPlayerInterior(playerid, DaneGracza[playerid][gINT]);
	    if(DaneGracza[playerid][gLskin] == 0)
		{
			SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
		}else{
		    SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
		}
		if(NieruchomoscInfo[GetPlayerVirtualWorld(playerid)][nSwiatlo] == 1)
		{
            TextDrawShowForPlayer(playerid, Light);
		}
		SetTimerEx("QS", 3000, 0, "d", playerid);
		return 1;
	}
	else if(DaneGracza[playerid][gWynajem] != 0)
	{
		new ui = DaneGracza[playerid][gWynajem];
		if(NieruchomoscInfo[ui][nTyp] == 1 || NieruchomoscInfo[ui][nTyp] == 20)
		{
			new uid = NieruchomoscInfo[ui][nWlascicielD];
			if(GrupaInfo[uid][gTyp] == DZIALALNOSC_HOTEL || NieruchomoscInfo[ui][nTyp] == 20)
			{
				if(NieruchomoscInfo[ui][nStworzoneObiekty] >= 10 || NieruchomoscInfo[ui][nTyp] == 20)
				{
					Frezuj(playerid, 0);
					SetTimerEx("Frez", 2000, 0, "d", playerid);
					if(NieruchomoscInfo[ui][nTyp] != 20)
					{
						Teleportuj(playerid, NieruchomoscInfo[ui][nXW],NieruchomoscInfo[ui][nYW],NieruchomoscInfo[ui][nZW]);
						SetPlayerFacingAngle(playerid, NieruchomoscInfo[ui][naw]);
						SetPlayerVirtualWorld(playerid, NieruchomoscInfo[ui][nVWW]);
						if(NieruchomoscInfo[ui][nSwiatlo] == 1)
						{
							TextDrawShowForPlayer(playerid, Light);
						}
						if(DaneGracza[playerid][gLskin] == 0)
						{
							SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
						}else{
							SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
						}
						if(DaneGracza[playerid][gZamHot] < gettime())
						{
							strdel(tekst_globals, 0, 2048);
							SetPVarInt(playerid, "CENAPRZ", ui);
							format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Okres twojego zameldowania dobieg³ koñca, aby go przed³u¿yæ musisz zap³aciæ {88b711}%d{DEDEDE}$ za kolejne trzy dni.",NieruchomoscInfo[ui][nHotel]);
							dShowPlayerDialog( playerid, DIALOG_HOTEL_PRZED, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:",tekst_globals, "Op³aæ", "Wymelduj" );
						
						}
					}
					else
					{
						Teleportuj(playerid, NieruchomoscInfo[ui][nX],NieruchomoscInfo[ui][nY],NieruchomoscInfo[ui][nZ]);
						SetPlayerFacingAngle(playerid, NieruchomoscInfo[ui][na]);
						SetPlayerVirtualWorld(playerid, NieruchomoscInfo[ui][nVW]);
						if(DaneGracza[playerid][gLskin] == 0)
						{
							SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
						}else{
							SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
						}
						if(DaneGracza[playerid][gZamHot] < gettime())
						{
							strdel(tekst_globals, 0, 2048);
							SetPVarInt(playerid, "CENAPRZ", ui);
							format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Okres twojego zameldowania dobieg³ koñca, aby go przed³u¿yæ musisz zap³aciæ {88b711}%d{DEDEDE}$ za kolejny dzieñ.",NieruchomoscInfo[ui][nHotel]);
							dShowPlayerDialog( playerid, DIALOG_HOTEL_PRZED, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:",tekst_globals, "Op³aæ", "Wymelduj" );
						
						}
					}
				}
				else
				{
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Zostales wymeldowany z hotelu, poniewaz budynek ma mniej niz 10 stworzonych obiektow");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
					DaneGracza[playerid][gWynajem] = 0;
					strdel(zapyt, 0, 1024);
					format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `WYNAJEM`='%d' WHERE `ID`='%d'", DaneGracza[playerid][gWynajem], DaneGracza[playerid][gUID]);
					mysql_query(zapyt);
					dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Hotel w którym wynamjmowa³eœ pokój {88b711}zbankrutowa³{DEDEDE}, udaj siê do innego Hotelu.", "Zamknij", "" );
					OnPlayerSpawn(playerid);
				}
			}
			else
			{
				DaneGracza[playerid][gWynajem] = 0;
				strdel(zapyt, 0, 1024);
				format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `WYNAJEM`='%d' WHERE `ID`='%d'", DaneGracza[playerid][gWynajem], DaneGracza[playerid][gUID]);
				mysql_query(zapyt);
				dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Hotel w którym wynamjmowa³eœ pokój {88b711}zbankrutowa³{DEDEDE}, udaj siê do innego Hotelu.", "Zamknij", "" );
				OnPlayerSpawn(playerid);
			}
		}
		else
		{
			Frezuj(playerid, 0);
			SetTimerEx("Frez", 5000, 0, "d", playerid);
			Teleportuj(playerid, NieruchomoscInfo[ui][nXW],NieruchomoscInfo[ui][nYW],NieruchomoscInfo[ui][nZW]);
			SetPlayerFacingAngle(playerid, NieruchomoscInfo[ui][naw]);
			SetPlayerVirtualWorld(playerid, NieruchomoscInfo[ui][nVWW]);
			if(NieruchomoscInfo[ui][nSwiatlo] == 1)
			{
				TextDrawShowForPlayer(playerid, Light);
			}
			if(DaneGracza[playerid][gLskin] == 0)
			{
				SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
			}else{
				SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
			}
		}
		return 1;
	}
	else
	{
		Frezuj(playerid, 0);
		SetTimerEx("Frez", 3000, 0, "d", playerid);
		new spawn = random(5);
		SpawnPlayerRandom[playerid] = spawn;
		if(spawn == 0)
		{
			Teleportuj(playerid, 1234.4191,-1335.0488,13.7924);
		}
		if(spawn == 1)
		{
			Teleportuj(playerid, 1231.0106,-1345.4373,13.7824);
		}
		if(spawn == 2)
		{
			Teleportuj(playerid, 1225.9561,-1352.3527,13.7724);
		}
		if(spawn == 3)
		{
			Teleportuj(playerid, 1231.2156,-1324.1813,13.8024);
		}
		if(spawn == 4)
		{ 
			Teleportuj(playerid, 1225.9934,-1316.4702,13.8083);
		}
		SetPlayerVirtualWorld(playerid, 0);
		if(DaneGracza[playerid][gLskin] == 0)
		{
			SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
		}else{
		    SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
		}
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	AntyCheatBroni[playerid] = 1;
	KillTimer(TimerAntyCheat[playerid]);
	TimerAntyCheat[playerid] = SetTimerEx("WlaczAntyCheata",5000,0,"d",playerid);
	CheatPlayerInfo[playerid][aAntiWeaponHack] = 0;
	new findgun = DaneGracza[playerid][gBronUID];
	if(findgun != 0)
	{
		UzywanieItemu(playerid, findgun);
	}
	if(Pracuje[playerid] != 0)
	{
		new uid = SprawdzCarUID(Pracuje[playerid]);
		SetVehicleToRespawn(Pracuje[playerid]);
		PojazdInfo[uid][pStan] = 1000.0;
		PojazdInfo[uid][pPaliwo] = 100;
		SetVehicleHealth(Pracuje[playerid], PojazdInfo[uid][pStan] );
		RepairVehicle(Pracuje[playerid]);
		Pracuje[playerid] = 0;
		DaneGracza[playerid][gSwp] = 0;
	}
	GetPlayerPos(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
	DaneGracza[playerid][gVW] = GetPlayerVirtualWorld(playerid);
	DaneGracza[playerid][gINT] = GetPlayerInterior(playerid);
	DaneGracza[playerid][gWyscig] = 0;
	DaneGracza[playerid][gCheckopintID] = 0;
	DisablePlayerRaceCheckpoint(playerid);
	DaneGracza[playerid][gKoniecWyscigu] = 0;
	DaneGracza[playerid][gRaceTimeStart] = 0;
	ResetPlayerWeapons(playerid);
	DaneGracza[playerid][gBronUID] = 0;
	DaneGracza[playerid][gBronAmmo] = 0;
	if(IsPlayerInAnyVehicle(playerid))
	{
	    Smierc(playerid, 15);
	    return 1;
	}
	if(reason == 0 || reason == 1 || reason == 3)
	{
		Smierc(playerid, 10);
	}
	else if(reason == 53 || reason == 49)
	{
		Smierc(playerid, 1);
	}
	else if(reason == 54)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(PASY[playerid] != 0)
			{
				Smierc(playerid, 3);
			}
			else
			{
				Smierc(playerid, 15);
			}
		}
		else
		{
			Smierc(playerid, 1);
		}
	}
  	else
	{
		Smierc(playerid, 30);
	}
	/*if(reason != 54 && reason != 38)
	{
		DaneGracza[playerid][gWyscig] = 0;
		DaneGracza[playerid][gCheckopintID] = 0;
		DisablePlayerRaceCheckpoint(playerid);
		DaneGracza[playerid][gKoniecWyscigu] = 0;
		DaneGracza[playerid][gRaceTimeStart] = 0;
		GetPlayerPos(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
		ResetPlayerWeapons(playerid);
		DaneGracza[playerid][gBronUID] = 0;
		DaneGracza[playerid][gBronAmmo] = 0;
		DaneGracza[playerid][gBW] = 10;
		DaneGracza[playerid][gVW] = GetPlayerVirtualWorld(playerid);
		DaneGracza[playerid][gINT] = GetPlayerInterior(playerid);
		Transakcja(T_BW, DaneGracza[playerid][gUID], DaneGracza[killerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[killerid][gGUID], -1, reason, DaneGracza[playerid][gBW], -1, "", gettime()-CZAS_LETNI);
		new str[64];
		format(str, sizeof(str), "~w~Pozostalo: ~r~10 min.");
		GameTextForPlayer(playerid, str, 60000, 1);
	}
	else
	{
		DaneGracza[playerid][gWyscig] = 0;
		DaneGracza[playerid][gCheckopintID] = 0;
		DisablePlayerRaceCheckpoint(playerid);
		DaneGracza[playerid][gKoniecWyscigu] = 0;
		DaneGracza[playerid][gRaceTimeStart] = 0;
		GetPlayerPos(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
		ResetPlayerWeapons(playerid);
		DaneGracza[playerid][gBronUID] = 0;
		DaneGracza[playerid][gBronAmmo] = 0;
		DaneGracza[playerid][gBW] = 3;
		DaneGracza[playerid][gVW] = GetPlayerVirtualWorld(playerid);
		DaneGracza[playerid][gINT] = GetPlayerInterior(playerid);
		Transakcja(T_BW, DaneGracza[playerid][gUID], DaneGracza[killerid][gUID], DaneGracza[playerid][gGUID], DaneGracza[killerid][gGUID], -1, reason, DaneGracza[playerid][gBW], -1, "", gettime()-CZAS_LETNI);
		new str[64];
		format(str, sizeof(str), "~w~Pozostalo: ~r~3 min.");
		GameTextForPlayer(playerid, str, 60000, 1);
	}*/
	SetTimerEx("ACONWEP", 10000, 0, "d", playerid);
	return 1;
}
forward	ACONWEP(playerid);
public ACONWEP(playerid)
{
	CheatPlayerInfo[playerid][aAntiWeaponHack] = 1;
}
forward	Smierc(playerid, czas);
public Smierc(playerid, czas)
{
	new str[126];
	format(str,sizeof(str),"{DEDEDE}Zginê³eœ. Odczekaj %d Minut lub wpisz '{88b711}/akceptujsmierc{DEDEDE}' (doprowadzi to do blokady postaci)",czas);
	SendClientMessage(playerid, SZARY,str);
	DaneGracza[playerid][gBW] =  (czas*60);
	TogglePlayerControllable(playerid, 0);
}
stock SetPlayerInAdminJail(playerid, playerid2, time, reason[])
{
	DaneGracza[playerid][gAJ] = (time*60);
	DaneGracza[playerid][gBW] = 0;
	SetPlayerInterior(playerid, 0);
	Teleportuj(playerid, 1178.5234,-1180.7908,86.9796);
	SetPlayerVirtualWorld(playerid, playerid+500);
	NadajKare(playerid,playerid2, 3, reason, time);
	ResetPlayerWeapons(playerid);
	return 1;
}
public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(DaneGracza[playerid][gSpam] != 0)
	{
		SendClientMessage(playerid, 0xFFb00000, "{CC0000}Odebrano Ci mo¿liwoœc pisania na 30 sekund, powodem blokady jest spam komendami.");
		return 0;
	}
    if(AFK[playerid] == 1)
		GraczWrocilZAFK(playerid);
	return 1;
}
public OnPlayerText(playerid, text[])
{
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] > 0)
	{
		return 0;
	}
    if(AFK[playerid] == 1)
		GraczWrocilZAFK(playerid);
    if((text[0] == '-'))
	{
	    if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
		if(silka[playerid] != 0)
		{
			return 0;
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			return 0;
		}
		/*if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
		{
		    dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE} Nie mo¿esz u¿ywaæ {88b711}animacji{DEDEDE}, gdy edytujesz obiekt!", "Zamknij", "" );
		    return 0;
		}*/
		if(!strcmp(text[1], " ", true)) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}animacji{DEDEDE} wpisz:\".idz1\"", "Zamknij", ""), 0;
  	    new found = 0;
		ForeachEx(i, MAX_ANIM)
	    {
			if(!isnull(AnimInfo[i][CMD]))
			{
				if(!strcmp(text[1], AnimInfo[i][CMD], true))
	        	{
					if(AnimInfo[i][Toggle] == 2) SetPlayerSpecialAction(playerid, AnimInfo[i][Loop]);
					else
					{
						ApplyAnimation(playerid, AnimInfo[i][Lib], AnimInfo[i][Name], AnimInfo[i][Speed], AnimInfo[i][Loop], AnimInfo[i][Lock][0], AnimInfo[i][Lock][1], AnimInfo[i][Freeze], AnimInfo[i][aTime], 1);
						SetPVarInt(playerid, "PlayAnim", 0);
						animacja[playerid] = 1;
						if(AnimInfo[i][Toggle] == 1) SetPVarInt(playerid, "PlayAnim", 1);
						//Transakcja(T_ANIM, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, AnimInfo[i][CMD], gettime()-CZAS_LETNI);
					}
					found++;
	        	}
	        }
	    }
		if(found == 0) return 0;
	}
	else if(strfind(text, "!1", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "1 %s", text);
		cmd_r(playerid,cmd_tekst);
	}
	else if(strfind(text, "!2", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "2 %s", text);
		cmd_r(playerid,cmd_tekst);
	}
	else if(strfind(text, "!3", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "3 %s", text);
		cmd_r(playerid,cmd_tekst);
	}
	else if(strfind(text, "!4", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "4 %s", text);
		cmd_r(playerid,cmd_tekst);
	}
	else if(strfind(text, "!5", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "5 %s", text);
		cmd_r(playerid,cmd_tekst);
	}
	else if(strfind(text, "!6", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "6 %s", text);
		cmd_r(playerid,cmd_tekst);
	}
	else if(strfind(text, ".", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 1);
		format(cmd_tekst, sizeof(cmd_tekst), "%s", text);
		cmd_b(playerid,cmd_tekst);
	}
	else if(strfind(text, "@1", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "1 %s", text);
		cmd_dg(playerid,cmd_tekst);
	}
	else if(strfind(text, "@2", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "2 %s", text);
		cmd_dg(playerid,cmd_tekst);
	}
	else if(strfind(text, "@3", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "3 %s", text);
		cmd_dg(playerid,cmd_tekst);
	}
	else if(strfind(text, "@4", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "4 %s", text);
		cmd_dg(playerid,cmd_tekst);
	}
	else if(strfind(text, "@5", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "5 %s", text);
		cmd_dg(playerid,cmd_tekst);
	}
	else if(strfind(text, "@6", true) == 0)
	{
		new cmd_tekst[256];
		strdel(text, 0, 2);
		format(cmd_tekst, sizeof(cmd_tekst), "6 %s", text);
		cmd_dg(playerid,cmd_tekst);
	}
	else if(!strcmp(text, ":)", true) || !strcmp(text, " :)", true) || !strcmp(text, ":) ", true) || !strcmp(text, ";)", true))
	{
	    cmd_fasdasfdfive(playerid, "uœmiecha siê.");
	}
	else if(!strcmp(text, ":(", true) || !strcmp(text, " :(", true) || !strcmp(text, ":( ", true) || !strcmp(text, ";(", true) || !strcmp(text, ";0", true))
	{
	    cmd_fasdasfdfive(playerid, "robi smutn¹ minê.");
	}
	else if(!strcmp(text, ":D", true) || !strcmp(text, " :D", true) || !strcmp(text, ":D ", true) || !strcmp(text, ";D", true))
	{
		ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.1, 0, 0, 0, 0, 0, 1);
		cmd_fasdasfdfive(playerid, "œmieje siê.");
	}
	else if(!strcmp(text, ":P", true) || !strcmp(text, " :P", true) || !strcmp(text, ":P ", true) || !strcmp(text, ";P", true))
	{
		cmd_fasdasfdfive(playerid, "wystawia jêzyk.");
	}
	else if(!strcmp(text, ":/", true) || !strcmp(text, " :/", true) || !strcmp(text, ":/ ", true) || !strcmp(text, ";/", true))
	{
		cmd_fasdasfdfive(playerid, "krzywi siê.");
	}
	else
	{
		if(text[strlen(text)-1] == '!' && text[strlen(text)-2] == '!')
		{
			cmd_k(playerid, text);
		}
		else
		{
			new str[256];
			text[0] = toupper(text[0]);
			if(Dzwoni[playerid] == 1 || Odebral[playerid] == 1)
			{
				if(Dzwoni[playerid] == 1 && Odebral[DzwoniID[playerid]] == 1)
				{
					format(str, sizeof(str), "{DEDEDE}%d {ff6600}telefon:{DEDEDE} %s", DaneGracza[playerid][gTelefon], text);
					SendClientMessage(DzwoniID[playerid], 0xE6E6E6E6, str);
				}
				if(Dzwoni[playerid] == -1 && Odebral[playerid] == 1)
				{
					format(str, sizeof(str), "{DEDEDE}%d {ff6600}telefon:{DEDEDE} %s", DaneGracza[playerid][gTelefon], text);
					SendClientMessage(DzwoniID[playerid], 0xE6E6E6E6, str);
				}
				format(str, sizeof(str), "%s (telefon): %s", ZmianaNicku(playerid), text);
			}
			else
			{
				format(str, sizeof(str), "%s mówi: %s", ZmianaNicku(playerid), text);
			}
			if(IsPlayerInAnyVehicle(playerid))
			{
				new uid = SprawdzCarUID(GetPlayerVehicleID(playerid));
				if(PojazdInfo[uid][pSzyba] == 1)
				{
					for(new is=0; is< IloscGraczy; is++)
					{
						if(GetPlayerVehicleID(KtoJestOnline[is]) == PojazdInfo[uid][pID])
						{
							SendClientMessage(KtoJestOnline[is], 0xE6E6E6E6, str);
						}
					}
				}
				else
				{
					CzatGlobalny(playerid, str, 10);
				}
			}
			else
			{
				CzatGlobalny(playerid, str, 10);
			}
			//Transakcja(T_IC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, text, gettime()-CZAS_LETNI);
			SetPVarInt(playerid, "IC", GetPVarInt(playerid, "IC")+1);
			SetTimerEx("SpamIC", 3000, 0, "d", playerid);
			/*if(DaneGracza[playerid][gAJ] == 0)
			{
				if(BlokadaOOC(playerid))
				{
					if(anty(text))
					{
						//NadajKare(playerid,-1, 3, "Proba ominiecia blokady OOC v1", 30);
						SetPlayerInAdminJail(playerid, -1, 30, "Proba ominiecia blokady OOC v1");
					}
				}
			}*/
		}
	}
	return 0;
}
CMD:iloscgraczy(playerid, cmdtext[])
{
	for(new i = 0, tekst[128]; i < IloscGraczy; i++)
	{
		format(tekst, sizeof(tekst), "Online jest id: %d", KtoJestOnline[i]);
		SendClientMessage(playerid, SZARY, tekst);
	}
}
CMD:ukryjglod(playerid, cmdtext[])
{
	//printf("U¿yta komenda ukryjglod");
	HideProgressBarForPlayer(playerid, PasekGlodu[playerid]);
	PasekGloduWLACZONY[playerid] = 0;
	return 1;
}
CMD:pokazglod(playerid, cmdtext[])
{
	//printf("U¿yta komenda pokazglod");
	ShowProgressBarForPlayer(playerid, PasekGlodu[playerid]);
	PasekGloduWLACZONY[playerid] = 1;
	return 1;
}
CMD:wyrzuc(playerid,cmdtext[])
{
	//printf("U¿yta komenda wyrzuc");
    new playerid2;
	if(sscanf(cmdtext, "i", playerid2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}wyrzuciæ{DEDEDE} gracza z pojazdu wpisz: {88b711}/wyrzuc [id gracza]", "Zamknij", "");
	    return 1;
	}
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerInAnyVehicle(playerid))
	{
	   return 1;
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return 1;
	}
	if(GetPlayerVehicleID(playerid2) != vehicleid)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten {88b711}gracz{DEDEDE} nie znajduje siê w twoim pojezdzie,", "Zamknij", "");
	    return 1;
	}
	RemovePlayerFromVehicle(playerid2);
	RemovePlayerFromVehicle(playerid2);
	GameTextForPlayer(playerid2, "~y~Zostales wyrzucony z pojazdu.", 3000, 5);
	GameTextForPlayer(playerid, "~y~Wyrzuciles gracza z pojazdu.", 3000, 5);
	return 1;
}
CMD:k(playerid,cmdtext[])
{
	//printf("U¿yta komenda k");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new text[128];
	if(sscanf(cmdtext, "s[128]", text))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ komendy krzyku wpisz: {88b711}/k [treœæ] {DEDEDE}lub u¿yj {88b711}dwóch wykrzyników {DEDEDE}na koñcu zdania.", "Zamknij", "");
	    return 1;
	}
	if(DaneGracza[playerid][gBW] > 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz u¿ywaæ komendy {88b711}krzyku{DEDEDE}, gdy jesteœ {88b711}nieprzytomny{DEDEDE}.", "Zamknij", "");
		return 0;
	}
	new str[256];
	text[0] = toupper(text[0]);
	format(str, sizeof(str), "%s krzyczy: %s!!", ZmianaNicku(playerid), text);
	if(IsPlayerInAnyVehicle(playerid))
	{
		new uid = SprawdzCarUID(GetPlayerVehicleID(playerid));
		if(PojazdInfo[uid][pSzyba] == 1)
		{
			CzatGlobalny(playerid, str, 10);
		}
		else
		{
			CzatGlobalny(playerid, str, 30);
		}
		
	}
	else
	{
		CzatGlobalny(playerid, str, 30);
	}
	//Transakcja(T_KRZYK, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, text, gettime()-CZAS_LETNI);
	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
	SetPVarInt(playerid, "IC", GetPVarInt(playerid, "IC")+1);
	SetTimerEx("SpamIC", 3000, 0, "d", playerid);
	/*if(DaneGracza[playerid][gAJ] == 0)
	{
		if(BlokadaOOC(playerid))
		{
			if(anty(text))
			{
	            //NadajKare(playerid,-1, 3, "Proba ominiecia blokady OOC v3", 30);
				SetPlayerInAdminJail(playerid, -1, 30, "Proba ominiecia blokady OOC v3");
			}
		}
	}*/
    return 1;
}
CMD:model(playerid,cmdtext[])
{
	//printf("U¿yta komenda model");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] != 4)
    {
		return 0;
	}
	new Float:a,Float:b,Float:c, model;
	if(sscanf(cmdtext, "dfff", model, a,b,c))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ komendy do tworzenia przyczepionych obiektów wpisz: {88b711}/model [model] [x] [y] [z] {DEDEDE}nastêpnie wpisz parametry.", "Zamknij", "");
		return 1;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		return 0;
	}
	new vehid = GetPlayerVehicleID(playerid);
	new uidk = SprawdzCarUID(vehid);
	DestroyDynamicObject(PojazdInfo[uidk][pKogut]);
	PojazdInfo[uidk][pKogut] = 0;
	//PojazdInfo[uidk][pKogut] = CreateObject(19419,0,0,0,0,0,0); taki jak na lspd
	PojazdInfo[uidk][pKogut] = CreateDynamicObject(model,0,0,0,0,0,0,0);
	AttachDynamicObjectToVehicle(PojazdInfo[uidk][pKogut], vehid, a, b, c, 0.0, 0.0, 0.0);
	Streamer_Update(playerid);
	return 1;
}
CMD:barek(playerid,cmdtext[])
{
	//printf("U¿yta komenda barek");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] != 4)
    {
		return 0;
	}
	new Float:a,Float:b,Float:w,strs[64];
	if(sscanf(cmdtext, "fffs[64]", a,b,w,strs))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ komendy tworzenia barów wpisz: {88b711}/barek [x] [y] [width] [kolor html] {DEDEDE}nastêpnie wpisz parametry.", "Zamknij", "");
		return 1;
	}
	DestroyProgressBar(BarEdytor[playerid]);
	BarEdytor[playerid] = CreateProgressBar(a,b,w,_, HexToInt(strs), 100.0);
	SetProgressBarValue(Bar:BarEdytor[playerid], 50);
	ShowProgressBarForPlayer(playerid, BarEdytor[playerid]);
    return 1;
}
CMD:terengangu(playerid,cmdtext[])
{
	//printf("U¿yta komenda teren");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] != 4)
    {
		return 0;
	}
	dShowPlayerDialog(playerid, DIALOG_GZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}»  {88b711}Stwórz teren gangowy\n{DEDEDE}»  {88b711}Edytuj teren gangowy", "Wybierz", "Zamknij");
    return 1;
}
CMD:c(playerid,cmdtext[])
{
	//printf("U¿yta komenda c");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new text[128];
	if(sscanf(cmdtext, "s[128]", text))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ komendy szeptu wpisz: {88b711}/c [treœæ] {DEDEDE}- gdy u¿ywasz szeptu twoje rozmowy s¹ s³yszane na krótk¹ odleg³oœæ.", "Zamknij", "");
		return 1;
	}
	if(DaneGracza[playerid][gBW] > 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz u¿ywaæ komendy {88b711}szeptu{DEDEDE}, gdy jesteœ {88b711}nieprzytomny{DEDEDE}.", "Zamknij", "");
		return 0;
	}
	new str[256];
	text[0] = toupper(text[0]);
	//Transakcja(T_SZEPT, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, text, gettime()-CZAS_LETNI);
	format(str, sizeof(str), "%s szepcze: %s", ZmianaNicku(playerid), text);
	CzatGlobalny(playerid, str, 2);
	SetPVarInt(playerid, "IC", GetPVarInt(playerid, "IC")+1);
	SetTimerEx("SpamIC", 3000, 0, "d", playerid);
	/*if(DaneGracza[playerid][gAJ] == 0)
	{
		if(BlokadaOOC(playerid))
		{
			if(anty(text))
			{
	            //NadajKare(playerid,-1, 3, "Proba ominiecia blokady OOC v2", 30);
				SetPlayerInAdminJail(playerid, -1, 30, "Proba ominiecia blokady OOC v2");
			}
		}
	}*/
    return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(AFK[playerid] == 1)
		GraczWrocilZAFK(playerid);
	return 0;
}
forward WychodziZPojazdu(playerid);
public WychodziZPojazdu(playerid)
{
	MozeBycWPojezdzie[playerid] = 0;
	return 1;
}
forward SprawdzPojazd(playerid);
public SprawdzPojazd(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		MozeBycWPojezdzie[playerid] = 1;
	}
	else
	{
		MozeBycWPojezdzie[playerid] = 0;
	}
	SprawdzaniePojazdu[playerid] = 0;
	return 1;
}
forward WlaczWeaponCheata(playerid);
public WlaczWeaponCheata(playerid)
{
	MozeBanowac[playerid] = 0;
	return 1;
}
forward NapisUsuns(playerid);
public NapisUsuns(playerid)
{
    DestroyDynamic3DTextLabel(Text3D:NapisWyszedl[playerid]);
	return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
    {
        PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
        return 1;
    }
    SetPVarInt(playerid, "command", GetPVarInt(playerid, "command")+1);
	SetTimerEx("SpamCmd", 3000, 0, "d", playerid);
	/*if(DaneGracza[playerid][gSpam] == 0)
	{
		SetPVarInt(playerid, "commands", GetPVarInt(playerid, "commands")+1);
		SetTimerEx("SpamCmds", 3000, 0, "d", playerid);
	}*/
	return 1;
}
forward SpamIC(playerid);
public SpamIC(playerid)
{
	if(GetPVarInt(playerid, "IC") > 7 && DaneGracza[playerid][gAdmGroup] != 4)
	{
	    new str[256];
    	format(str, sizeof(str), "Spam na kanale IC, %d wypowiedzi w ciagu 3 sec.",GetPVarInt(playerid, "IC"));
	    NadajKare(playerid,-1, 0, str, 0);
	}
    SetPVarInt(playerid, "IC", 0);
	return 1;
}
forward Odnow(playerid);
public Odnow(playerid)
{
	DaneGracza[playerid][gSpam] = 1;
	return 1;
}
forward SpamCmds(playerid);
public SpamCmds(playerid)
{
	if(GetPVarInt(playerid, "command") > 3 && DaneGracza[playerid][gAdmGroup] != 4)
	{
	    DaneGracza[playerid][gSpam] = 1;
		SetTimerEx("Odnow", 30000, 0, "d", playerid);
		
	}
    SetPVarInt(playerid, "commands", 0);
	return 1;
}
forward SpamCmd(playerid);
public SpamCmd(playerid)
{
	if(GetPVarInt(playerid, "command") > 5 && DaneGracza[playerid][gAdmGroup] != 4)
	{
	    new str[256];
    	format(str, sizeof(str), "Spam komend, %d w ciagu 3 sec.",GetPVarInt(playerid, "command"));
	    NadajKare(playerid,-1, 0, str, 0);
	}
    SetPVarInt(playerid, "command", 0);
	return 1;
}
forward NapisUsunsV(playerid);
public NapisUsunsV(playerid)
{
	TextDrawHideForPlayer(playerid, OBJ[playerid]);
	return 1;
}
forward SpamKomend1(playerid);
public SpamKomend1(playerid)
{
	AntySpam[playerid][0] = 0;
	return 1;
}
forward SpamKomend2(playerid);
public SpamKomend2(playerid)
{
	AntySpam[playerid][1] = 0;
	return 1;
}
forward ZarzadzajElektryka(playerid);
public ZarzadzajElektryka(playerid)
{
	DaneGracza[playerid][gZarzadzajElektryka] = 0;
	return 1;
}
stock GraczWbudynku(uid)
{
	new value = -1;
	for(new i=0; i< IloscGraczy; i++)
	{
  		if(GetPlayerVirtualWorld(KtoJestOnline[i]) == uid)
  		{
      		//if(Edytors[KtoJestOnline[i]] == 1)
			if(GetPVarInt(KtoJestOnline[i], "idobiktu") != 0 || GetPVarInt(KtoJestOnline[i], "inedit") != 0)
      		{
    			value = KtoJestOnline[i];
    			break;
   			}
  		}
 	}
	return value;
}
stock GetVehiclePlayerKierownica(vehicle)
{
	new value = 0;
	for(new i=0; i< IloscGraczy; i++)
	{
		if(GetPlayerVehicleID(KtoJestOnline[i]) == vehicle)
		{
			if(GetPlayerState(KtoJestOnline[i]) == PLAYER_STATE_DRIVER)
			{
				value++;
				break;
			}
		}
	}
	return value;
}
stock GetVehiclePlayer(vehicle)
{
	new value = -1;
	for(new i=0; i< IloscGraczy; i++)
	{
		if(GetPlayerVehicleID(KtoJestOnline[i]) != vehicle)
		{
			value = -1;
		}
		else
		{
			value = KtoJestOnline[i];
			break;
		}
	}
	return value;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(!Samolot(GetPlayerVehicleID(playerid)) && !Lodka(GetPlayerVehicleID(playerid)) && !Rower(GetPlayerVehicleID(playerid)))
	    {
	        new vid = GetPlayerVehicleID(playerid);
	    	if(newkeys & ( KEY_LOOK_LEFT ) && newkeys & ( KEY_LOOK_RIGHT ))
			{
		    	if(Indicators[vid][2]) DestroyDynamicObject(Indicators[vid][2]), DestroyDynamicObject(Indicators[vid][3]),Indicators[vid][2]=0;
            	if(Indicators[vid][0]) DestroyDynamicObject(Indicators[vid][0]), DestroyDynamicObject(Indicators[vid][1]),Indicators[vid][0]=0;
				else
				SetVehicleIndicator(vid,1,1);
				return 1;
			}
			else if(newkeys & KEY_LOOK_RIGHT)
			{
	  		  	if(Indicators[vid][0]) DestroyDynamicObject(Indicators[vid][0]), DestroyDynamicObject(Indicators[vid][1]),Indicators[vid][0]=0;
      	      	else if(Indicators[vid][2]) DestroyDynamicObject(Indicators[vid][2]), DestroyDynamicObject(Indicators[vid][3]),Indicators[vid][2]=0;
				else
				SetVehicleIndicator(vid,0,1);
			}
			else if(newkeys & KEY_LOOK_LEFT)
			{
			    if(Indicators[vid][2]) DestroyDynamicObject(Indicators[vid][2]), DestroyDynamicObject(Indicators[vid][3]),Indicators[vid][2]=0;
      	      	else if(Indicators[vid][0]) DestroyDynamicObject(Indicators[vid][0]), DestroyDynamicObject(Indicators[vid][1]),Indicators[vid][0]=0;
				else
				SetVehicleIndicator(vid,1,0);
			}
		}
	}
	if(GetPVarInt(playerid, "WybieraUbranie") == 1)
	{
		if(newkeys == 4)
		{
			SetPVarInt(playerid, "WybieraUbranie", 0);
			SetPlayerSkin(playerid, GetPVarInt(playerid, "UbranieNa"));
			Frezuj(playerid,1);
			SetCameraBehindPlayer(playerid);
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			GameTextForPlayer(playerid, "~w~Anulowales kupno nowego ubrania.", 3000, 5);
			return 1;
		}
		if(newkeys == 16)
		{
			if(DaneGracza[playerid][gPLEC]==1)
			{
				if(DaneGracza[playerid][gPORTFEL] < SkinPlayerW[SkinIDW[playerid]][cena4])
				{
					GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
				}
				else
				{
					GameTextForPlayer(playerid, "~w~Kupiles ~y~nowe ubranie.", 3000, 5);
					Dodajkase( playerid, -SkinPlayerW[SkinIDW[playerid]][cena4]);
					DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, P_UBRANIE, 1, SkinPlayerW[SkinIDW[playerid]][id4], SkinPlayerW[SkinIDW[playerid]][nazwa4], DaneGracza[playerid][gUID], 0, -1, 0, 0, 0, "");
				}
			}
			else
			{
				if(DaneGracza[playerid][gPORTFEL] < SkinPlayerM[SkinIDM[playerid]][cena4])
				{
					GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
				}
				else
				{
					GameTextForPlayer(playerid, "~w~Kupiles ~y~nowe ubranie.", 3000, 5);
					Dodajkase( playerid, -SkinPlayerM[SkinIDM[playerid]][cena4]);
					DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, P_UBRANIE, 0, SkinPlayerM[SkinIDM[playerid]][id4], SkinPlayerM[SkinIDM[playerid]][nazwa4], DaneGracza[playerid][gUID], 0, -1, 0, 0, 0, "");
				}
			}
			SetCameraBehindPlayer(playerid);
			Frezuj(playerid,1);
			SetPlayerSkin(playerid, GetPVarInt(playerid, "UbranieNa"));
			SetPVarInt(playerid, "WybieraUbranie", 0);
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			return 1;
		}
	}
	if(silka[playerid] != 0)
 	{
		if(newkeys == KEY_SPRINT)
		{
			podnoszenie[playerid] =1;
			testzabez[playerid] = SetTimerEx("cwiczenie", 800, 0, "i", playerid);
			ApplyAnimation(playerid,"benchpress","gym_bp_up_A",4.1,0,0,0,1,0);
		}
		else if(oldkeys == KEY_SPRINT)
		{
			KillTimer(testzabez[playerid]);
			podnoszenie[playerid] = 0;
			ApplyAnimation(playerid,"benchpress","gym_bp_down",4.1,0,0,0,1,0);
		}
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		if((newkeys & KEY_CROUCH || newkeys & KEY_CTRL_BACK) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
			//PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), GetPlayerVehicleSeat(playerid));
			NadajKare(playerid,-1, 0, "Prawdopodobny DB", -1);
		}
		if(GetPVarInt(playerid, "Tempomat_Wlaczony") == 1)
		{
			if(newkeys & KEY_SUBMISSION || newkeys & 8 || newkeys & 32 || newkeys & 128)
			{
				DisableCruiseControl(playerid);
			}
		}
		else
		{
			if(newkeys & KEY_SUBMISSION)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new uid = SprawdzCarUID(vehicleid);
				if(PojazdInfo[uid][pTempomat] == 1)
				{
					EnableCruiseControl(playerid);
				}
			}
		}
		if(newkeys == KEY_YES && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!Wlascicielpojazdu(vehicleid, playerid))
			{
				return 0;
			}
			new lights,doors,bonnet,boot,objective,engine,alarm;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(!bonnet)
			{
				SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,true,boot,objective);
			}
			else
			{
				SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,false,boot,objective);
				return 1;
			}
		}
		if(newkeys == KEY_NO && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!Wlascicielpojazdu(vehicleid, playerid))
			{
				return 0;
			}
			new lights,doors,bonnet,boot,objective,engine,alarm;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(!boot)
			{
					SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,true,objective);
			}
			else
			{
				SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,false,objective);
				return 1;
			}
		}
	}
	if(newkeys & KEY_HANDBRAKE && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(DaneGracza[playerid][gTworzyWyscig] != 0)
		{
			if(TrasaDuty[playerid] != DaneGracza[playerid][gSluzba])
			{
				GrupaInfo[TrasaDuty[playerid]][gSaldo] += 1000;
				ZapiszSaldo(TrasaDuty[playerid]);
				UsunWyscig(TrasaDuty[playerid], DaneGracza[playerid][gTworzyWyscigNazwa], TrasaDutyNr[playerid]);
				TrasaDuty[playerid] = 0;
				TrasaDutyNr[playerid] = 0;
				DaneGracza[playerid][gTworzyWyscig] = 0;
				DaneGracza[playerid][gTworzyWyscigCP] = 0;
				CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
				TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
				TextDrawSetString(TextNaDrzwi[playerid], "Wyscig zostal przerwany poniewaz nie znajdujesz sie na sluzbie dzialalnosci.");
				TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				TrasaDuty[playerid] = 0;
				return 0;
			}
			DaneGracza[playerid][gTworzyWyscigCP]++;
			new Float: x, Float: y, Float: z, str[124];
			GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
			DaneGracza[playerid][gTworzyWyscig] = DodajWyscig(x, y, z, DaneGracza[playerid][gTworzyWyscigCP], TrasaDuty[playerid], DaneGracza[playerid][gTworzyWyscigNazwa]);
			format(str, sizeof(str), "~r~CheckPoint: ~w~%d/20~n~~n~~b~~h~Nazwa: ~w~%s", DaneGracza[playerid][gTworzyWyscigCP], DaneGracza[playerid][gTworzyWyscigNazwa]);
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 60;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], str);
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
			if(DaneGracza[playerid][gTworzyWyscigCP] == 20)
			{
				DaneGracza[playerid][gTworzyWyscig] = 0;
				DaneGracza[playerid][gTworzyWyscigCP] = 0;
				CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
				TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
				TextDrawSetString(TextNaDrzwi[playerid], "Wyscig zostal stworzony.");
				TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				TrasaDuty[playerid] = 0;
				TrasaDutyNr[playerid] = 0;
			}
		}
	}
	if(newkeys == KEY_SPRINT)
	{
		if(GangZonePL[playerid] == true)
		{
			ZapiszTeren(DaneGracza[playerid][gTeren]);
			DaneGracza[playerid][gTeren] = 0;
			GangZonePL[playerid] = false;
			Frezuj(playerid, 1);
		}
	}
    if(newkeys == (KEY_SPRINT + KEY_WALK))
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			for(new i = 0; i < sizeof(NieruchomoscInfo); i++)
			{
			    if(NieruchomoscInfo[i][nTyp] == 0 || NieruchomoscInfo[i][nTyp] == 1)
				{
					if(Dystans(1.5, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
					{
						if(DaneGracza[playerid][gBW] != 0)
						{
							return 0;
						}
						if(NieruchomoscInfo[i][nZamek] == 1)
						{
          					if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
							{
							    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz opuœciæ budynku podczas {88b711}edycji {DEDEDE}obiektów.", "Zamknij", "");
								return 0;
							}
						    if(IsPlayerInAnyVehicle(playerid)) return 1;
							WejscieDoBudynku(playerid, i, 0, NieruchomoscInfo[i][nVWW]);
						}
						else
						{
							GameTextForPlayer(playerid,"~r~~h~Drzwi sa zamkniete.",5000,3);
							return 1;
						}
					}
					if(Dystans(1.5, playerid, NieruchomoscInfo[i][nXW], NieruchomoscInfo[i][nYW], NieruchomoscInfo[i][nZW]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVWW])
					{
						if(DaneGracza[playerid][gBW] != 0)
						{
							return 0;
						}
						if(NieruchomoscInfo[i][nZamek] == 1)
						{
						    if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
							{
							    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz opuœciæ budynku podczas {88b711}edycji {DEDEDE}obiektów.", "Zamknij", "");
								return 0;
							}
							if(IsPlayerInAnyVehicle(playerid)) return 1;
							WyjscieZBudynku(playerid, i, 0, NieruchomoscInfo[i][nVW]);
						}
						else
						{
							GameTextForPlayer(playerid,"~r~~h~Drzwi sa zamkniete.",5000,3);
							return 1;
						}
					}
				}
			}
		}
	}
	if( newkeys == KEY_HANDBRAKE)
	{
		if(DaneGracza[playerid][gBronUID] != 0)
	    {
	        if(HOLDING( KEY_SPRINT ))
			{
				ALK[playerid] = GetPlayerDrunkLevel(playerid);
				SetPlayerDrunkLevel(playerid, 10000);
			}
			else if(oldkeys & KEY_SPRINT)
			{
				SetPlayerDrunkLevel(playerid, ALK[playerid]);
				ALK[playerid] = 0;
			}
		}
	    if(!IsPlayerInAnyVehicle(playerid))
		{
			if(animacja[playerid] != 0 && silka[playerid] == 0)
			{
				OnPlayerText(playerid, "-stopani");
				animacja[playerid] = 0;
			}
		}
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////
	/*if ((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK)&& IsPlayerInAnyVehicle(playerid) == 0)
	{
		if(MaPilke[playerid])
		{
			ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1);
		}
		else
		{
			ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
		}
	}
	if (!(newkeys & KEY_SECONDARY_ATTACK) && (oldkeys & KEY_SECONDARY_ATTACK) && IsPlayerInAnyVehicle(playerid) == 0)
	{
		ClearAnimations(playerid);
	}*/
	/*if(newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid))
	{
		if(MaPilke[playerid] == 0)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(DaneGracza[playerid][gPilka], x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 1.5, x, y, z))
			{
				MaPilke[playerid] = 1;
				ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
				if(PosiadaPilke[DaneGracza[playerid][gPilka]] != -1)
				{
					MaPilke[PosiadaPilke[DaneGracza[playerid][gPilka]]] = 0;
					ClearAnimations(PosiadaPilke[DaneGracza[playerid][gPilka]]);
					ApplyAnimation(PosiadaPilke[DaneGracza[playerid][gPilka]], "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
					ApplyAnimation(playerid,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
				}
				PosiadaPilke[DaneGracza[playerid][gPilka]] = playerid;
				StatusPilki[DaneGracza[playerid][gPilka]] = 1;
				new Float:x2, Float:y2;
				PobierzPozycjeGracza(playerid, x2, y2, 0.8);
				GetPlayerPos(playerid, x, y, z);
				MoveDynamicObject(DaneGracza[playerid][gPilka], x2, y2, z, 2.5);
				//BallBounce = 0;
			}
		}
	}*/
	//////////////////////////////////////////////////////////////////////////////////////////////////
	/*if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new trailerid = GetVehicleTrailer(GetPlayerVehicleID(playerid));
		
				//----------------------Kierunkowskaz Lewy
		if(newkeys == KEY_LOOK_LEFT)
		{

			if(IsTrailerAttachedToVehicle(vehicleid))
			{
			    if(KierunekLewyOn[trailerid] == true) return 0;
				for(new t = 0; t < MAX_KIEUNKI; t++)
				{
				    if(KierunekInfo[t][VID] == GetVehicleModel(GetVehicleTrailer(vehicleid)))
				    {
				        if(KierunekLewyOn[trailerid] == false)
				        {
							KierunekLewyOn[trailerid] = true;
							KierunekObiekt[trailerid][4] = CreateObject( 19294,0,0,0,0,0,0,80 );
						    AttachObjectToVehicle(KierunekObiekt[trailerid][4], trailerid, KierunekInfo[t][PXLT], KierunekInfo[t][PYLT], KierunekInfo[t][PZLT], 0, 0, 0);
						}else
						{
						    KierunekLewyOn[trailerid] = false;
						    DestroyObject(KierunekObiekt[trailerid][4]);
						}
						break;
					}
				}
			}
			
			for(new i = 0; i < MAX_KIEUNKI; i++)
			{
				if(KierunekInfo[i][VID] == GetVehicleModel(vehicleid))//Porównanie Modelu pojazdu z modelem w tablicy
				{
				    if(KierunkiAwaryjneIn[vehicleid] == true || KierunekPrawyOn[vehicleid] == true) return 0;
				    if(KierunekLewyOn[vehicleid] == false)
				    {

          		        KierunekLewyOn[vehicleid] = true;
					    //Kierunkowskaz Lewy Przedni
						KierunekObiekt[vehicleid][0] = CreateObject( 19294,0,0,0,0,0,0,80 );
					    AttachObjectToVehicle(KierunekObiekt[vehicleid][0], vehicleid, KierunekInfo[i][PXLP], KierunekInfo[i][PYLP], KierunekInfo[i][PZLP], 0, 0, 0);
						//Kierunkowskaz Lewy Tylny
						KierunekObiekt[vehicleid][1] = CreateObject( 19294,0,0,0,0,0,0,80 );
					    AttachObjectToVehicle(KierunekObiekt[vehicleid][1], vehicleid, KierunekInfo[i][PXLT], KierunekInfo[i][PYLT], KierunekInfo[i][PZLT], 0, 0, 0);

					}else
					{
					    KierunekLewyOn[vehicleid] = false;
					    DestroyObject(KierunekObiekt[vehicleid][0]);
					    DestroyObject(KierunekObiekt[vehicleid][1]);
					
     				}
					break;
				}
			}
		}
				//----------------------Kierunkowskaz Prawy
		if(newkeys == KEY_LOOK_RIGHT)
		{
		
			if(IsTrailerAttachedToVehicle(vehicleid))
			{
			    if(KierunekLewyOn[trailerid] == true) return 0;
				for(new t = 0; t < MAX_KIEUNKI; t++)
				{
				    if(KierunekInfo[t][VID] == GetVehicleModel(GetVehicleTrailer(vehicleid)))
				    {
				        if(KierunekPrawyOn[trailerid] == false)
				        {
							KierunekPrawyOn[trailerid] = true;
							KierunekObiekt[trailerid][4] = CreateObject( 19294,0,0,0,0,0,0,80 );
						    AttachObjectToVehicle(KierunekObiekt[trailerid][4], trailerid, KierunekInfo[t][PXPT], KierunekInfo[t][PYPT], KierunekInfo[t][PZPT], 0, 0, 0);
						}else
						{
						    KierunekPrawyOn[trailerid] = false;
						    DestroyObject(KierunekObiekt[trailerid][4]);
						}
						break;
					}
				}
			}
		
			for(new i = 0; i < MAX_KIEUNKI; i++)
			{
				if(KierunekInfo[i][VID] == GetVehicleModel(vehicleid))//Porównanie Modelu pojazdu z modelem w tablicy
				{
				    if(KierunkiAwaryjneIn[vehicleid] == true || KierunekLewyOn[vehicleid] == true) return 0;
				    if(KierunekPrawyOn[vehicleid] == false)
				    {
				        KierunekPrawyOn[vehicleid] = true;
					    //Kierunkowskaz Prawy Przedni
						KierunekObiekt[vehicleid][0] = CreateObject( 19294,0,0,0,0,0,0,80 );
					    AttachObjectToVehicle(KierunekObiekt[vehicleid][0], vehicleid, KierunekInfo[i][PXPP], KierunekInfo[i][PYPP], KierunekInfo[i][PZPP], 0, 0, 0);
						//Kierunkowskaz Prawy Tylny
						KierunekObiekt[vehicleid][1] = CreateObject( 19294,0,0,0,0,0,0,80 );
					    AttachObjectToVehicle(KierunekObiekt[vehicleid][1], vehicleid, KierunekInfo[i][PXPT], KierunekInfo[i][PYPT], KierunekInfo[i][PZPT], 0, 0, 0);
					}else
					{
					    KierunekPrawyOn[vehicleid] = false;
					    DestroyObject(KierunekObiekt[vehicleid][0]);
					    DestroyObject(KierunekObiekt[vehicleid][1]);
					}
				}
			}
		}
	}*/
	if(newkeys == KEY_FIRE)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			if(DaneGracza[playerid][gBW] != 0)
			{
				return 0;
			}
	        if( GetPVarInt( playerid, "inedit" ) != 0 )
			{
			    if(edycjaobiektow[playerid] == 0)
			    {
			    edycjaobiektow[playerid] = 1;
			    ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
			    }else{
			    edycjaobiektow[playerid] = 0;
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
	      		ClearAnimations(playerid);
			    }
			}
		}
	}
	if(newkeys & KEY_FIRE || newkeys & KEY_SECONDARY_ATTACK)
	{
		if(GetPlayerWeapon(playerid) == 0)
		{
			UzylLPM[playerid] = 1;
			KillTimer(UzylLPMTimer[playerid]);
			UzylLPMTimer[playerid] = SetTimerEx("UsunLPM",1000,0,"d",playerid);
		}
	}
	if(newkeys==KEY_ACTION && GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
			if(DaneGracza[playerid][gBW] != 0)
			{
				return 0;
			}
			cmd_v(playerid, "odpal");
		}
		return 1;
 	}
    if(newkeys==KEY_FIRE&& GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
		if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!Wlascicielpojazdu(vehicleid, playerid))
		{
			return 0;
		}
		new lights,doors,bonnet,boot,objective,engine,alarm;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if(!lights)
		{
			SetVehicleParamsEx(vehicleid,engine,true,alarm,doors,bonnet,boot,objective);
		}
		else
		{
			SetVehicleParamsEx(vehicleid,engine,false,alarm,doors,bonnet,boot,objective);
			return 1;
		}
		return 1;
	}
	if(Wedkuje[playerid] != 0)
	{
		if((newkeys & KEY_SECONDARY_ATTACK)&&!(oldkeys & KEY_SECONDARY_ATTACK) && (graczlowiFish[playerid] == 0))
		{
			if(DaneGracza[playerid][gBW] != 0)
			{
				return 0;
			}
			for( new o; o != sizeof fishR_pos; o ++ )
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.0, fishR_pos[ o ][ 0 ], fishR_pos[ o ][ 1 ], fishR_pos[ o ][ 2 ]))
				{
					if(PrzedmiotInfo[Wedkuje[playerid]][pWar4] == 0)
					{
						dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Brak {88b711}przynêty{DEDEDE}, udaj siê do sklepu aby j¹ kupiæ.", "Zamknij", "");
						return 0;
					}
					SetPlayerFacingAngle(playerid, 182.8412);
					SetCameraBehindPlayer(playerid);
					PrzedmiotInfo[Wedkuje[playerid]][pWar4] --;
					ZapiszPrzedmiot(Wedkuje[playerid]);
					Frezuj(playerid, 0);
					graczlowiFish[playerid] = true;
					SetProgressBarValue(Bar:TabelaRyb[playerid], 5);
					ShowProgressBarForPlayer(playerid, TabelaRyb[playerid]);
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Rozpoczoles proces wedkowania naciskaj klawisz ''~y~~k~~PED_SPRINT~~w~'', az niebieski pasek osiagnie 100 procent. Uzyj ponownie ''~y~~k~~VEHICLE_ENTER_EXIT~~w~'' aby zakonczyc wedkowanie.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
					break;
				}
			}
		}
		else if((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK) && (graczlowiFish[playerid] == 1))
		{
			if(DaneGracza[playerid][gBW] != 0)
			{
				return 0;
			}
			graczlowiFish[playerid] = false;
			SetPlayerFacingAngle(playerid, 182.8412);
			ClearAnimations(playerid);
			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
			Frezuj(playerid, 1);
			HideProgressBarForPlayer(playerid, TabelaRyb[playerid]);
		}
		else if((newkeys & KEY_SPRINT ) && !( oldkeys & KEY_SPRINT ) && ( graczlowiFish[playerid] == 1))
		{
			if(DaneGracza[playerid][gBW] != 0)
			{
				return 0;
			}
			ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,0,1,1);
			SetPlayerFacingAngle(playerid, 182.8412);
			GetProgressBarValue(Bar:TabelaRyb[playerid]);
			SetProgressBarValue(Bar:TabelaRyb[playerid], GetProgressBarValue(Bar:TabelaRyb[playerid])+1.0);
			ShowProgressBarForPlayer(playerid, TabelaRyb[playerid]);
			
			if(GetProgressBarValue(Bar:TabelaRyb[playerid]) >= 100)
			{
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
				ClearAnimations(playerid);
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
				graczlowiFish[playerid] = false;
				Frezuj(playerid, 1);
				HideProgressBarForPlayer(playerid, TabelaRyb[playerid]);
				new losek = random(10);
				if(losek >= 0 && losek <= 7)
				{
					new loseke;
					if(ComparisonString(PrzedmiotInfo[Wedkuje[playerid]][pWar3], "C"))
					{
						loseke = random(10)+10;
					}
					if(ComparisonString(PrzedmiotInfo[Wedkuje[playerid]][pWar3], "B"))
					{
						loseke = random(7)+5;
					}
					if(ComparisonString(PrzedmiotInfo[Wedkuje[playerid]][pWar3], "A"))
					{
						loseke = random(5)+1;
					}
					if(DaneGracza[playerid][gPracaTyp] == PRACA_WEDKARZ)
					{
						new strryba[256];
						format(strryba, sizeof(strryba), "~g~Gratulacje~n~~w~Udalo ci sie zlowic rybe.~n~~r~~h~Ryba: %s~n~~r~~h~Waga: %dkg~n~~g~Zarobiles: %d$", TypRyby[losek], loseke, loseke);
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], strryba);
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
						Dodajkase(playerid, loseke);
					}else{
						new strryba[256];
						format(strryba, sizeof(strryba), "~g~Gratulacje~n~~w~Udalo ci sie zlowic rybe.~n~~r~~h~Ryba: %s~n~~r~~h~Waga: %dkg", TypRyby[losek], loseke);
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 20;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], strryba);
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
					}
				}
				if(losek == 8)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zerwa³eœ {88b711}haczyk{DEDEDE}, udaj siê do sklepu po nowy {88b711}haczyk{DEDEDE} oraz {88b711}przynête{DEDEDE}.", "Zamknij", "");
					PrzedmiotInfo[Wedkuje[playerid]][pWar1] = 0;
					PrzedmiotInfo[Wedkuje[playerid]][pWar4] = 0;
					ZapiszPrzedmiot(Wedkuje[playerid]);
					UzywanieItemu(playerid, Wedkuje[playerid]);
				}
				if(losek == 9)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Zerwa³eœ {88b711}¿y³kê{DEDEDE}, straci³eœ {88b711}haczyk{DEDEDE} oraz {88b711}przynête{DEDEDE} - udaj siê do sklepu po nowy zestaw.", "Zamknij", "");
					PrzedmiotInfo[Wedkuje[playerid]][pWar2] = 0;
					PrzedmiotInfo[Wedkuje[playerid]][pWar4] = 0;
					PrzedmiotInfo[Wedkuje[playerid]][pWar1] = 0;
					ZapiszPrzedmiot(Wedkuje[playerid]);
					UzywanieItemu(playerid, Wedkuje[playerid]);
				}
			}
		}
	}
	return 1;
}
forward Frez(playerid);
public Frez(playerid)
{
    Frezuj(playerid, true);
	return 1;
}
forward QS(playerid);
public QS(playerid)
{
    DaneGracza[playerid][gQS] = 0;
	return 1;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{

    return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(BlokadaOOC(playerid))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
		\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
	    return 0;
	}
	if(zalogowany[clickedplayerid] == false)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
	    return 0;
	}
	if(playerid == clickedplayerid) return 1;
	if(DaneGracza[playerid][gBW] != 0)
	{
	    if(!PlayerObokPlayera(playerid, clickedplayerid, 5))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podczas {88b711}BW{DEDEDE} mo¿esz pisaæ wiadomoœci na {88b711}krótk¹{DEDEDE} odleg³oœæ.", "Zamknij", "");
		    return 0;
		}
	}
	if(LOCKW[clickedplayerid] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz ma {88b711}wy³¹czone{DEDEDE} prywatne wiadomoœci.", "Zamknij", "");
	    return 0;
	}
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "{DEDEDE}Wiadomoœæ do {88b711}gracza{DEDEDE} %s:", ZmianaNicku(clickedplayerid), clickedplayerid);
	dShowPlayerDialog(playerid,DIALOG_PW,DIALOG_STYLE_INPUT,"{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:",tekst_global,"Wyœlij","Zamknij");
	SetPVarInt(playerid, "PM", clickedplayerid);
	return 0;
}
stock Rowery(vehicleid)
{
    if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock Jednoslady(vehicleid)
{
    if(GetVehicleModel(vehicleid) == 461 || GetVehicleModel(vehicleid) == 462 || GetVehicleModel(vehicleid) == 463 ||
	GetVehicleModel(vehicleid) == 471 || GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 ||
	GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 521 || GetVehicleModel(vehicleid) == 522 ||
	GetVehicleModel(vehicleid) == 523 || GetVehicleModel(vehicleid) == 581 || GetVehicleModel(vehicleid) == 586)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock WlascicielGrupyOwner(uid, playerid)
{
	new owner_pojazdu = PojazdInfo[uid][pOwnerDzialalnosc];
    if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gGUID] == GrupaInfo[owner_pojazdu][gOwner])
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock Dokument(playerid, dokument)
{
	if(DaneGracza[playerid][gDokumenty][dokument] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock Osiagniecia(playerid, dokument)
{
	if(DaneGracza[playerid][gOsiagniecia][dokument] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock WlascicielGrupyOwnerUID(uid, playerid)
{
    if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gUID] == GrupaInfo[PojazdInfo[uid][pOwnerDzialalnosc]][gOwnerUID])
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
PobierzPozycjeGracza(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
stock ZarzadzaniePojazdamiDlaDz(uid, playerid, typ_dzialnosci)
{
	if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gGUID] == GrupaInfo[PojazdInfo[uid][pOwnerDzialalnosc]][gOwner] && GrupaInfo[PojazdInfo[uid][pOwnerDzialalnosc]][gTyp] == typ_dzialnosci)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock ZarzadzaniePojazdami(uid, playerid)
{
    if(PojazdInfo[uid][pOwnerPostac] == 0 && PojazdInfo[uid][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc1] && DaneGracza[playerid][gUprawnienia1][2] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pOwnerPostac] == 0 && PojazdInfo[uid][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc2] && DaneGracza[playerid][gUprawnienia2][2] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pOwnerPostac] == 0 && PojazdInfo[uid][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc3] && DaneGracza[playerid][gUprawnienia3][2] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pOwnerPostac] == 0 && PojazdInfo[uid][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc4] && DaneGracza[playerid][gUprawnienia4][2] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pOwnerPostac] == 0 && PojazdInfo[uid][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc5] && DaneGracza[playerid][gUprawnienia5][2] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pOwnerPostac] == 0 && PojazdInfo[uid][pOwnerDzialalnosc] == DaneGracza[playerid][gDzialalnosc6] && DaneGracza[playerid][gUprawnienia6][2] == 1)
    {
		return true;
 	}
	else if(PojazdInfo[uid][pOwnerPostac] == 0 && DaneGracza[playerid][gUID] == GrupaInfo[PojazdInfo[uid][pOwnerDzialalnosc]][gOwnerUID])
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock UzywanieMikrofonu(playerid, uid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][18] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][18] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][18] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][18] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][18] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][18] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock ZarzadzanieBlokadami(playerid)
{
    if(DaneGracza[playerid][gUprawnienia1][25] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gUprawnienia2][25] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia3][25] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia4][25] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia5][25] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia6][25] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock UprDutyOn(playerid, uid, uprawnienie)
{
	if(DaneGracza[playerid][gDzialalnosc1] == uid && DaneGracza[playerid][gUprawnienia1][uprawnienie] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gDzialalnosc2] == uid && DaneGracza[playerid][gUprawnienia2][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc3] == uid && DaneGracza[playerid][gUprawnienia3][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc4] == uid && DaneGracza[playerid][gUprawnienia4][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc5] == uid && DaneGracza[playerid][gUprawnienia5][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc6] == uid && DaneGracza[playerid][gUprawnienia6][uprawnienie] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock NaprawianieVwZero(playerid, uid)
{
	if(DaneGracza[playerid][gDzialalnosc1] == uid && DaneGracza[playerid][gUprawnienia1][23] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gDzialalnosc2] == uid && DaneGracza[playerid][gUprawnienia2][23] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc3] == uid && DaneGracza[playerid][gUprawnienia3][23] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc4] == uid && DaneGracza[playerid][gUprawnienia4][23] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc5] == uid && DaneGracza[playerid][gUprawnienia5][23] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc6] == uid && DaneGracza[playerid][gUprawnienia6][23] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock MontazItemow(playerid, uid)
{
	if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][23] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][23] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][23] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][23] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][23] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][23] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock Podaj(playerid, uid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][14] == 1 && DaneGracza[playerid][gDzialalnosc1] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][14] == 1 && DaneGracza[playerid][gDzialalnosc2] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][14] == 1 && DaneGracza[playerid][gDzialalnosc3] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][14] == 1 && DaneGracza[playerid][gDzialalnosc4] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][14] == 1 && DaneGracza[playerid][gDzialalnosc5] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][14] == 1 && DaneGracza[playerid][gDzialalnosc6] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock OtwieranieBramV2(playerid, find)
{
	if(ObiektInfo[find][objTypOwneraBramy] == BRAMA_DZIALALNOSC)
	{
		if(DaneGracza[playerid][gDzialalnosc1] == ObiektInfo[find][objOwnerBrama] && DaneGracza[playerid][gUprawnienia1][12] == 1)
		{
			return true;
		}
		else if(DaneGracza[playerid][gDzialalnosc2] == ObiektInfo[find][objOwnerBrama] && DaneGracza[playerid][gUprawnienia2][12] == 1)
		{
			return true;
		}
		else if(DaneGracza[playerid][gDzialalnosc3] == ObiektInfo[find][objOwnerBrama] && DaneGracza[playerid][gUprawnienia3][12] == 1)
		{
			return true;
		}
		else if(DaneGracza[playerid][gDzialalnosc4] == ObiektInfo[find][objOwnerBrama] && GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia4][12] == 1)
		{
			return true;
		}
		else if(DaneGracza[playerid][gDzialalnosc5] == ObiektInfo[find][objOwnerBrama] && GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia5][12] == 1)
		{
			return true;
		}
		else if(DaneGracza[playerid][gDzialalnosc6] == ObiektInfo[find][objOwnerBrama] && GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia6][12] == 1)
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
	else if(ObiektInfo[find][objTypOwneraBramy] == BRAMA_OWNER)
	{
		if(DaneGracza[playerid][gUID] == ObiektInfo[find][objOwnerBrama])
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else if(ObiektInfo[find][objTypOwneraBramy] == BRAMA_ALL)
	{
		return true;
	}
	else
	{
		return false;
	}
}
stock MaUprawnieie(playerid, uprawnienie)
{
	if(DaneGracza[playerid][gUprawnienia1][uprawnienie] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gUprawnienia2][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia3][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia4][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia5][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia6][uprawnienie] == 1)
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock NalezyDoDziZUp(playerid, dzialnosc, uprawnienie)
{
	if(GrupaInfo[DaneGracza[playerid][gDzialalnosc1]][gTyp] == dzialnosc && DaneGracza[playerid][gUprawnienia1][uprawnienie] == 1)
    {
		return true;
 	}
    else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc2]][gTyp] == dzialnosc && DaneGracza[playerid][gUprawnienia2][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gTyp] == dzialnosc && DaneGracza[playerid][gUprawnienia3][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gTyp] == dzialnosc && GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia4][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gTyp] == dzialnosc && GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia5][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gTyp] == dzialnosc && GraczPremium(playerid) && DaneGracza[playerid][gUprawnienia6][uprawnienie] == 1)
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock NalezyDoDzialalnosci(playerid, dzialnosc)
{
	if(GrupaInfo[DaneGracza[playerid][gDzialalnosc1]][gTyp] == dzialnosc)
    {
		return true;
 	}
    else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc2]][gTyp] == dzialnosc)
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gTyp] == dzialnosc)
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gTyp] == dzialnosc && GraczPremium(playerid))
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gTyp] == dzialnosc && GraczPremium(playerid))
    {
		return true;
 	}
 	else if(GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gTyp] == dzialnosc && GraczPremium(playerid))
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock MontowanieElektryki(playerid)
{
	if(DaneGracza[playerid][gUprawnienia1][21] == 1 && GetPlayerVirtualWorld(playerid) != 0 && DaneGracza[playerid][gDzialalnosc1] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
    else if(DaneGracza[playerid][gUprawnienia2][21] == 1 && GetPlayerVirtualWorld(playerid) != 0 && DaneGracza[playerid][gDzialalnosc2] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if( DaneGracza[playerid][gUprawnienia3][21] == 1 && GetPlayerVirtualWorld(playerid) != 0 && DaneGracza[playerid][gDzialalnosc3] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia4][21] == 1 && GetPlayerVirtualWorld(playerid) != 0 && DaneGracza[playerid][gDzialalnosc4] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia5][21] == 1 && GetPlayerVirtualWorld(playerid) != 0 && DaneGracza[playerid][gDzialalnosc5] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gUprawnienia6][21] == 1 && GetPlayerVirtualWorld(playerid) != 0 && DaneGracza[playerid][gDzialalnosc6] == DaneGracza[playerid][gSluzba])
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock MikrofonWVW(playerid)
{
	if(DaneGracza[playerid][gDzialalnosc1] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia1][18] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gDzialalnosc2] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia2][18] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc3] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia3][18] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc4] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia4][18] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc5] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia5][18] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc6] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia6][18] == 1)
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock UprawnienieNaSluzbie(playerid, uprawnienie)
{
	if(DaneGracza[playerid][gDzialalnosc1] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia1][uprawnienie] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gDzialalnosc2] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia2][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc3] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia3][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc4] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia4][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc5] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia5][uprawnienie] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc6] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia6][uprawnienie] == 1)
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock ZamawianiePrzedmiotow(playerid)
{
	if(DaneGracza[playerid][gDzialalnosc1] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia1][13] == 1)
    {
		return true;
 	}
    else if(DaneGracza[playerid][gDzialalnosc2] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia2][13] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc3] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia3][13] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc4] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia4][13] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc5] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia5][13] == 1)
    {
		return true;
 	}
 	else if(DaneGracza[playerid][gDzialalnosc6] == DaneGracza[playerid][gSluzba] && DaneGracza[playerid][gUprawnienia6][13] == 1)
    {
		return true;
 	}
	else
	{
		return false;
	}
}
stock ZarzadzanieBramami(uid, playerid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
	else if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nUID] == DaneGracza[playerid][gWynajem])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][12] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][12] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][12] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][12] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][12] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][12] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock OwnerDzialalnosci(uid, playerid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && GrupaInfo[NieruchomoscInfo[uid][nWlascicielD]][gOwnerUID] == DaneGracza[playerid][gUID])
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock ZarzadzanieSzafa(uid, playerid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][16] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][16] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][16] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][16] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][16] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][16] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock ZarzadzanieBudynkiem(uid, playerid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][4] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][4] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][4] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][4] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][4] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][4] == 1)
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
stock SwiatloBudynku(uid, playerid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][24] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][24] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][24] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][24] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][24] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][24] == 1)
    {
		return true;
 	}
	else
	{
		return false;
 	}
}
stock OtwieranieBudynku(uid, playerid)
{
	if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nWlascicielP] == DaneGracza[playerid][gUID])
	{
		return true;
 	}
	else if(NieruchomoscInfo[uid][nWlascicielD] == 0 && NieruchomoscInfo[uid][nUID] == DaneGracza[playerid][gWynajem])
	{
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc1] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia1][11] == 1)
    {
		return true;
 	}
    else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc2] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia2][11] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc3] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia3][11] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc4] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia4][11] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc5] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia5][11] == 1)
    {
		return true;
 	}
 	else if(NieruchomoscInfo[uid][nWlascicielP] == 0 && DaneGracza[playerid][gDzialalnosc6] == NieruchomoscInfo[uid][nWlascicielD] && DaneGracza[playerid][gUprawnienia6][11] == 1)
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
forward Speedrower(g);
public Speedrower(g)
{
	new Float:Xz, Float:Yz, Float:Zz, vehid;
	vehid = GetPlayerVehicleID(g);
	if(IsPlayerInAnyVehicle(g) && GetVehicleModel(vehid) == 510 || IsPlayerInAnyVehicle(g) && GetVehicleModel(vehid) == 509 || IsPlayerInAnyVehicle(g) && GetVehicleModel(vehid) == 481)
	{
		GetVehicleVelocity(vehid, Xz, Yz, Zz);
		if(Predkosc(g) > 50)
		{
			SetVehicleVelocity(vehid,LastSpeed[g][0], LastSpeed[g][1], 0);
		} 
		else 
		{
			LastSpeed[g][0] = Xz;
			LastSpeed[g][1] = Yz;
			LastSpeed[g][2] = Zz;
		}
	}
}
public OnQueryError(errorid, error[], resultid, extraid, callback[], query[], connectionHandle)
{
	printf("[MySQL Error] %s (%d), Zapytanie: %s", error, errorid, query);
	return 1;
}
forward Unfreeze_SetHP(playerid);
public Unfreeze_SetHP(playerid)
{
	SetPVarInt(playerid, "USetHPHP", 1);
	return 1;
}
forward Unfreeze_AC(uid);
public Unfreeze_AC(uid)
{
	ACOFF[uid] = 0;
	return 1;
}
stock GraczNaTerenie(playerid)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    ForeachEx(i, MAX_ZON)
	{
		if(X <= Lokacja[i][gX] && X >= Lokacja[i][gXX] && Y <= Lokacja[i][gY] && Y >= Lokacja[i][gYY] || X <= Lokacja[i][gXX] && X >= Lokacja[i][gX] && Y <= Lokacja[i][gYY] && Y >= Lokacja[i][gY])
		{
			return i;
		}
    }
    return 0;
}
public OnPlayerUpdate(playerid)
{
	if(zalogowany[playerid] == true)
	{
		new	Float:nHP, Float:nVHP;
		GetPlayerHealth(playerid, nHP);
		//if(nHP != DaneGracza[playerid][gZDROWIE] && GetPVarInt(playerid, "USetHP") == 1 && DaneGracza[playerid][gBW] == 0)
		if(nHP != DaneGracza[playerid][gZDROWIE] && DaneGracza[playerid][gBW] == 0)
		{
			if(nHP < DaneGracza[playerid][gZDROWIE])
			{
				if(DaneGracza[playerid][gBW] == 0)
				{
					Uderzony(playerid, 0xFF0000FF);
				}
				DaneGracza[playerid][gZDROWIE] = nHP;
			}
			else
			{
				SetPlayerHealth(playerid,DaneGracza[playerid][gZDROWIE]);
			}
		}
		if(GetPlayerPing(playerid) >= 700)
		{
			new armour[256];
			format(armour, sizeof(armour), "Wysoki ping (%d)", GetPlayerPing(playerid));
			NadajKare(playerid,-1, 0, armour, -1);
		}
		if(DaneGracza[playerid][gWypozyczonyPojazdCZAS] > gettime())
		{
			new uidpojazd = DaneGracza[playerid][gWypozyczonyPojazdUID];
			if(PojazdInfo[uidpojazd][pSpawn] == 0)
			{
				DaneGracza[playerid][gWypozyczonyPojazdUID] = 0;
				DaneGracza[playerid][gWypozyczonyPojazdCZAS] = 0;
			}
		}
		if(impreza == 1)
		{
			new na_terenie = GraczNaTerenie(playerid);
			if(na_terenie == 67 && Discman[playerid] == 0)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new vehicleid=GetPlayerVehicleID(playerid);
					new uid = SprawdzCarUID(vehicleid);
					if(PojazdInfo[uid][pAudioStream] == 0) 
					{
						if(!GetPVarInt(playerid,"spawn"))
						{
							SetPVarInt(playerid,"spawn",1);
							StopAudioStreamForPlayer(playerid);
							PlayAudioStreamForPlayer(playerid, "http://tnij.org/dxd-max",253.68, -1834.98, 3.61, 70.0, 1);	
						}
					}
				}
				else
				{
					if(!GetPVarInt(playerid,"spawn"))
					{
						SetPVarInt(playerid,"spawn",1);
						StopAudioStreamForPlayer(playerid);
						PlayAudioStreamForPlayer(playerid, "http://tnij.org/dxd-max",253.68, -1834.98, 3.61, 70.0, 1);	
					}
				}
			}
			else
			{
				if(GetPVarInt(playerid,"spawn"))
				{
					DeletePVar(playerid,"spawn");
					StopAudioStreamForPlayer(playerid);
				}
			}
		}
		if(GetPVarInt(playerid, "WybieraUbranie") == 1)
		{
			new Keys,ud,lr;
			GetPlayerKeys(playerid,Keys,ud,lr);
			if(lr > 0)
			{
				if(DaneGracza[playerid][gPLEC] == 0 && SkinIDM[playerid] != LIMIT_UBRAN_SKLEP_M-1)
				{
					SkinIDM[playerid]++;
					SetPlayerSkin(playerid, SkinPlayerM[SkinIDM[playerid]][id4]);
				}
				if(DaneGracza[playerid][gPLEC] == 1 && SkinIDW[playerid] != LIMIT_UBRAN_SKLEP_W-1)
				{
					SkinIDW[playerid]++;
					SetPlayerSkin(playerid, SkinPlayerW[SkinIDW[playerid]][id4]);
				}
			}
			else if(lr < 0)
			{
				if(DaneGracza[playerid][gPLEC] == 0 && SkinIDM[playerid] > 0)
				{
					SkinIDM[playerid]--;
					SetPlayerSkin(playerid, SkinPlayerM[SkinIDM[playerid]][id4]);
				}
				if(DaneGracza[playerid][gPLEC] == 1 && SkinIDW[playerid] > 0)
				{
					SkinIDW[playerid]--;
					SetPlayerSkin(playerid, SkinPlayerW[SkinIDW[playerid]][id4]);
				}
			}
			if(DaneGracza[playerid][gPLEC]==0)
			{
				strdel(tekst_global, 0, 2048);
				format(tekst_global, sizeof(tekst_global), "~r~~h~Zakup ubrania~n~~g~~h~Cena:~w~ $%d  ~g~~h~Ubranie:~w~ %d~n~W celu zakupu nacisnij ~y~~k~~VEHICLE_ENTER_EXIT~~w~.~n~W celu anulowania zakupu nacisnij ~y~~k~~PED_FIREWEAPON~~w~.",SkinPlayerM[SkinIDM[playerid]][cena4],SkinPlayerM[SkinIDM[playerid]][id4]);
				TextDrawSetString(OBJ[playerid], tekst_global);
				TextDrawShowForPlayer(playerid, OBJ[playerid]);
			}
			if(DaneGracza[playerid][gPLEC]==1)
			{
				strdel(tekst_global, 0, 2048);
				format(tekst_global, sizeof(tekst_global), "~r~~h~Zakup ubrania~n~~g~~h~Cena:~w~ $%d  ~g~~h~Ubranie:~w~ %d~n~W celu zakupu nacisnij ~y~~k~~VEHICLE_ENTER_EXIT~~w~.~n~W celu anulowania zakupu nacisnij ~y~~k~~PED_FIREWEAPON~~w~.",SkinPlayerW[SkinIDW[playerid]][cena4],SkinPlayerW[SkinIDW[playerid]][id4]);
				TextDrawSetString(OBJ[playerid], tekst_global);
				TextDrawShowForPlayer(playerid, OBJ[playerid]);
			}
		}
		/*if(DaneGracza[playerid][gAdmGroup] == 4)
		{
			strdel(tekst_global, 0, 2048);
			new na_terenie = GraczNaTerenie(playerid);
			if(na_terenie != 0)
			{
				format(tekst_global,sizeof(tekst_global),"%s",Lokacja[na_terenie][gNazwa]);
			}
			else
			{
				format(tekst_global,sizeof(tekst_global),"Poza zasiegiem radaru");
			}
			PlayerTextDrawHide(playerid, Lokalizacja[playerid]);
			PlayerTextDrawSetString(playerid, Lokalizacja[playerid], tekst_global);
			PlayerTextDrawShow(playerid, Lokalizacja[playerid]);
		}*/
		/*if(Predkosc(playerid) != 0 && Frezowany[playerid] == 1 && zalogowany[playerid] == true)
		{
			NadajKare(playerid,-1, 0, "Ruch podczas zamrozenia", -1);
		}*/
		if(IsPlayerInAnyVehicle(playerid))
		{
			new Keyss,uds,lrs;
			GetPlayerKeys(playerid,Keyss,uds,lrs);
			if(Keyss == 2048 || Keyss == 264192)
			{
				new id = GetVehicleTrailer(GetPlayerVehicleID(playerid));
				if(id != 0)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						new id_p = SprawdzCarUID(id);
						DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
						GetVehiclePos(id, PojazdInfo[id_p][pOX], PojazdInfo[id_p][pOY], PojazdInfo[id_p][pOZ]);
						SetVehiclePos(id, PojazdInfo[id_p][pOX], PojazdInfo[id_p][pOY], PojazdInfo[id_p][pOZ]);
						SetTimerEx("HolowanyTimer", 2000, 0, "d", id_p);	
					}
				}
			}
			new vehicle = GetPlayerVehicleID( playerid );
			Speedrower(playerid);
			if(GetVehicleModel(vehicle) != 509 && GetVehicleModel(vehicle) != 481 && GetVehicleModel(vehicle) != 510)
			{
				GetVehicleHealth( vehicle, nVHP );
				/*if(!Wlascicielpojazdu(vehicle, playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					GameTextForPlayer(playerid,"~r~Nie posiadasz kluczy do tego pojazdu!",5000,3);
					RemovePlayerFromVehicle(playerid);
					RemovePlayerFromVehicle(playerid);
					Frezuj(playerid, 0);
					Frezuj(playerid, 1);
				}*/
				new uids = SprawdzCarUID(vehicle);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{
					if(Predkosc(playerid) > 10 && PojazdInfo[uids][pSilnik] == 0 && zalogowany[playerid] == true && !Rowery(vehicle))
					{
						SetVehicleVelocity(vehicle, 0.0, 0.0, 0.0);
						GameTextForPlayer(playerid, "~n~~r~Jazda z zgaszonym silnikiem!", 5000, 3);
						/*new Float: x, Float: y, Float: z;
						GetPlayerPos(playerid, x, y, z);
						Teleportuj(playerid, x, y, z + 5);
						PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);*/
					}
					new speed[124];
					if(Predkosc(playerid) > 250)
					{
						format(speed, sizeof(speed), "SpeedHack (%s, %dKM)", GetVehicleModelName(PojazdInfo[uids][pModel]), Predkosc(playerid));
						NadajKare(playerid,-1, 0, speed, -1);
					}
				}
				if( nVHP != PojazdInfo[uids][pStan] && ACOFF[uids] == 0)
				{
					if( nVHP < PojazdInfo[uids][pStan]+50 && ACOFF[uids] == 0)
					{
						for(new is=0; is< IloscGraczy; is++)
						{
							if(GetPlayerVehicleID(KtoJestOnline[is]) == PojazdInfo[uids][pID])
							{
								if(DaneGracza[KtoJestOnline[is]][gZDROWIE] <= ((PojazdInfo[uids][pStan] - nVHP) / 5))
								{
									UstawHP(KtoJestOnline[is],9);
									GetPlayerPos(KtoJestOnline[is], DaneGracza[KtoJestOnline[is]][gX],DaneGracza[KtoJestOnline[is]][gY],DaneGracza[KtoJestOnline[is]][gZ]);
									DaneGracza[KtoJestOnline[is]][gVW] = GetPlayerVirtualWorld(KtoJestOnline[is]);
									DaneGracza[KtoJestOnline[is]][gINT] = GetPlayerInterior(KtoJestOnline[is]);
									DaneGracza[KtoJestOnline[is]][gWyscig] = 0;
									DaneGracza[KtoJestOnline[is]][gCheckopintID] = 0;
									DisablePlayerRaceCheckpoint(KtoJestOnline[is]);
									DaneGracza[KtoJestOnline[is]][gKoniecWyscigu] = 0;
									DaneGracza[KtoJestOnline[is]][gRaceTimeStart] = 0;
									ResetPlayerWeapons(KtoJestOnline[is]);
									DaneGracza[KtoJestOnline[is]][gBronUID] = 0;
									DaneGracza[KtoJestOnline[is]][gBronAmmo] = 0;
									Smierc(KtoJestOnline[is], 15);
								}
								else
								{
									DaneGracza[KtoJestOnline[is]][gZDROWIE] -= ((PojazdInfo[uids][pStan] - nVHP) / 5);
								}
								//SetPlayerHealth(KtoJestOnline[is], DaneGracza[KtoJestOnline[is]][gZDROWIE] - ((PojazdInfo[uids][pStan] - nVHP) / 5));
							}
						}
						if(GetPVarInt(playerid, "Tempomat_Wlaczony") == 1)
						{
							DisableCruiseControl(playerid);
						}
						new rok, miesiac, dzien, godzina, minuta, sekunda;
						sekundytodata(gettime()-(3600*4), rok, miesiac, dzien, godzina, minuta, sekunda);
						//printf("[UID_POJAZDU:%d][%02d-%02d-%d, %02d:%02d][Uszkodzenie Pojazdu] Gracz: %s (UID: %d, GUID: %d) uszkodzil pojazd (UID: %d) z %f na %f.[KONIEC_LOGU]",uids, dzien, miesiac, rok, godzina, minuta, ZmianaNicku(playerid), DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID], uids, PojazdInfo[uids][pStan], nVHP);
						Transakcja(T_VHEALTH, playerid, uids, DaneGracza[playerid][gGUID], -1, nVHP, uids, vehicle, PojazdInfo[uids][pStan], "-", gettime()-CZAS_LETNI);
						PojazdInfo[uids][pStan] = nVHP;
						if(PojazdInfo[uids][pStan] < 300)
						{
							PojazdInfo[uids][pStan] = 300;
						}
						if(PojazdInfo[uids][pStan] < 300 && PojazdInfo[uids][pSilnik] == 1)
						{
							SetVehicleVelocity(vehicle, 0.0, 0.0, 0.0);
							PojazdInfo[uids][pSilnik] = 0;
							new eng, lights, alarm, drs, bonnet, boot, obj,bzstr[124];
							GetVehicleParamsEx(vehicle, eng, lights, alarm, drs, bonnet, boot, obj);
							SetVehicleParamsEx(vehicle, PojazdInfo[uids][pSilnik], lights, 0, drs, bonnet, boot, obj);
							format(bzstr, sizeof(bzstr), "**W pojezdzie %s zgas³ silnik, poniewa¿ jego uszkodzenia s¹ zbyt wielkie**", GetVehicleModelName(PojazdInfo[uids][pModel]));
							SendVehText(15.0, vehicle, bzstr, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
							KillTimer(PojazdInfo[uids][pTimer]);
						}
					}
					else
					{
						if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
						{
							//setDoor(vehicle,HOOD,REMOVED);
							//setDoor(vehicle,TRUNK,REMOVED);
							//setDoor(vehicle,LEFT_DOOR,REMOVED);
							//setDoor(vehicle,RIGHT_DOOR,REMOVED);
							//setPanel(vehicle,FRONT_PANEL,REMOVED);
							//setPanel(vehicle,BACK_PANEL,REMOVED);
							//setLight(vehicle,LEFT_LIGHT,DAMAGED);
							//setLight(vehicle,RIGHT_LIGHT,DAMAGED);
							//setTire(vehicle,LEFT_F_TIRE,DAMAGED);
							//setTire(vehicle,LEFT_B_TIRE,DAMAGED);
							//setTire(vehicle,RIGHT_F_TIRE,DAMAGED);
							//setTire(vehicle,RIGHT_B_TIRE,DAMAGED);
							if(AntyCheatWizualizacja[playerid] == 0)
							{
								SetVehicleHealth(vehicle, PojazdInfo[uids][pStan]);
								NadajKare(playerid,-1, 2, "Anty Cheat System (Naprawa silnika pojazdu)", 30);
							}
						}
					}
				}
			}
		}
		else
		{
			PASY[playerid] = 0;
		}
		if(GetPlayerWeapon(playerid))
		{
			new uid = GetPVarInt(playerid, "UzywanaBron");
			if( uid )
			{

			}
			else
			{
				if(MozeBanowac[playerid] == 0)
				{
					/*ACBron=GetPlayerWeapon(playerid);
					format(ACtekst_global, sizeof(ACtekst_global),"Weapon Cheat v3 (%s)",NazwaBroni[ACBron]);
					NadajKare(playerid,-1, 2, ACtekst_global, 30);
					ResetPlayerWeapons(playerid);
					DeletePVar(playerid, "UzywanaBron");*/
				}
			}
		}
		new PlayerWeapon = GetPlayerWeapon(playerid);
		new findgun = DaneGracza[playerid][gBronUID];
		new ammo = GetPlayerWeaponAmmo(playerid, PlayerWeapon);
		if(PrzedmiotInfo[findgun][pUzywany] != 0 && DaneGracza[playerid][gBronAmmo] == PlayerWeapon && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			if(ammo > PrzedmiotInfo[findgun][pWar2]+5 || 0 > PrzedmiotInfo[findgun][pWar2])
			{
				SetPlayerAmmo(playerid, DaneGracza[playerid][gBronAmmo], PrzedmiotInfo[findgun][pWar2]);
				NadajKare(playerid,-1, 2, "Infinity Ammo :>", 30);
			}
			if(ammo > PrzedmiotInfo[findgun][pWar2])
			{
				SetWeaponAmmo(playerid, PlayerWeapon, PrzedmiotInfo[findgun][pWar2]);
			}
			else
			{
				if(ammo <= 0)
				{
					/*UsunBronieGracza(playerid, PrzedmiotInfo[findgun][pWar1]);
					ResetPlayerWeapons(playerid);
					PrzedmiotInfo[findgun][pUzywany] = 0;
					DaneGracza[playerid][gBronUID] = 0;
					DaneGracza[playerid][gBronAmmo] = 0;
					DeletePVar(playerid, "UzywanaBron");
					DeletePVar(playerid, "UzywanaBronUID");
					DeletePVar(playerid, "UzywanaBron");
					ZapiszGracza(playerid);
					strdel(tekst_global, 0, 2048);
					format(tekst_global, sizeof(tekst_global), "schowa³ broñ %s.", PrzedmiotInfo[findgun][pNazwa]);
					cmd_fasdasfdfive(playerid, tekst_global);
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W {88b711}broni{DEDEDE}, której u¿ywa³eœ w³aœnie skoñczy³a siê {88b711}amunicja{DEDEDE}.", "Zamknij", "");
					//ResetPlayerWeapons(playerid);
					//PrzedmiotInfo[findgun][pUzywany] = 0;*/
					MozeBanowac[playerid] = 1;
					UzywanieItemu(playerid, findgun);
					SetTimerEx("WlaczWeaponCheata",2000,0,"d",playerid);
					Transakcja(T_AMMOL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, findgun, PrzedmiotInfo[findgun][pWar1], -1, "-", gettime()-CZAS_LETNI);
					//DaneGracza[playerid][gBronUID] = 0;
					//DaneGracza[playerid][gBronAmmo] = 0;
					//DeletePVar(playerid, "UzywanaBron");
				}
				PrzedmiotInfo[findgun][pWar2] = ammo;
				ZapiszPrzedmiot(findgun);
			}
		}
		if(GetPVarInt(playerid, "idobiktu") != 0)
		{
			new id = GetPVarInt(playerid, "idobiktu");
			new Float:xp[7],tekst_global_big[500];
			GetDynamicObjectPos( ObiektInfo[id][objSAMP], xp[0], xp[1], xp[2]);
			GetDynamicObjectRot( ObiektInfo[id][objSAMP], xp[4], xp[5], xp[6]);
			format(tekst_global_big, sizeof(tekst_global_big), "~w~Obiekt: ~r~%d:%d  ~w~Model: ~y~%d  ~w~Owner: ~p~%d~n~~n~~r~Pozycja: ~w~%0.2f,%0.2f,%0.2f~n~~r~Rotacja:~w~ %0.2f,%0.2f,%0.2f~n~Brama: ~y~%d  ~w~Sparowany:~y~ %d",
			ObiektInfo[id][objvWorld], id,ObiektInfo[id][objModel],ObiektInfo[id][objOwnerDz], xp[0], xp[1], xp[2], xp[4], xp[5], xp[6], ObiektInfo[id][objBrama], ObiektInfo[id][objSprarowanyUID]);
			TextDrawSetString(OBJ[playerid], tekst_global_big);
			TextDrawShowForPlayer(playerid, OBJ[playerid]);
		}
		/*if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new uid = SprawdzCarUID(vehicleid);
			if(PojazdInfo[uid][pModel] != 481 && PojazdInfo[uid][pModel] != 510 && PojazdInfo[uid][pModel] != 509)
			{
				if(PojazdInfo[uid][pSilnik] == 1)
				{
					strdel(tekst_global, 0, 2048);
					strdel(tekst_globals, 0, 2048);
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
					format(tekst_global, sizeof(tekst_global), "~n~~p~%s (SQLID %d)~n~~n~~w~%s~n~~w~Stan: ~y~%0.01f ~n~~w~Predkosc: ~y~%d~w~ km/h~n~~w~Przebieg: ~y~%0.01f~w~ km~n~",
					GetVehicleModelName(PojazdInfo[uid][pModel]),
					PojazdInfo[uid][pUID],
					tekst_globals,
					PojazdInfo[uid][pStan],
					Predkosc(playerid),
					PojazdInfo[uid][pPrzebieg]/1000);
					TextDrawSetString(Licznik[playerid], tekst_global);
					TextDrawShowForPlayer(playerid, Licznik[playerid]);
				}
			}
		}*/
		if(GangZonePL[playerid] == true)
		{
			new keys, ud, lr, Float:PRECISE, typ = 0;
			GetPlayerKeys( playerid, keys, ud, lr );
			if( !ud && !lr ) return 1;
			new uid = DaneGracza[playerid][gTeren];
			PRECISE = 8.0;
			if( keys & KEY_WALK )   PRECISE = 1.0;
			if( keys & 32 )	typ = 1;
			Frezuj(playerid, 0);
			if(typ == 0)
			{	
				if(ud < 0)//W
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gX] -= PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);
				}
				if(ud > 0)//S
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gX] += PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);}
				if(lr < 0)//A
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gY] -= PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);
				}
				if(lr > 0)//D
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gY] += PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);
				}
			}
			else
			{
				if(ud < 0)//W
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gXX] -= PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);
				}
				if(ud > 0)//S
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gXX] += PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);}
				if(lr < 0)//A
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gYY] -= PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);
				}
				if(lr > 0)//D
				{
					GangZoneDestroy(Lokacja[uid][gID]);
					Lokacja[uid][gYY] += PRECISE;
					Lokacja[uid][gID] = GangZoneCreate(Lokacja[uid][gX], Lokacja[uid][gY], Lokacja[uid][gXX], Lokacja[uid][gYY]);
				}
			}
			if( keys & KEY_SPRINT )
			{
				ZapiszTeren(uid);
				DaneGracza[playerid][gTeren] = 0;
				GangZonePL[playerid] = false;
				Frezuj(playerid, 1);
			}
			GangZoneShowForAll(Lokacja[uid][gID], 0xFFFFFFAA);
		}
		if( GetPVarInt( playerid, "inedit" ) != 0 )
		{
			if(DaneGracza[playerid][gEdytor] == 1)
			{
				if(edycjaobiektow[playerid] == 1)
				{
					new keys, ud, lr,
						Float:PRECISE,
						typ = 0,
						id = GetPVarInt(playerid, "idobiktu");
					GetPlayerKeys( playerid, keys, ud, lr );

					if( !ud && !lr ) return 1;
					if( keys & 32 )	typ = 1;
					if(typ == 1)
					{
						PRECISE = 1.00;
						if( keys & KEY_WALK )   PRECISE = 0.01;
					}
					else
					{
						PRECISE = 0.10;
						if( keys & KEY_WALK )   PRECISE = 0.01;
						if( keys & KEY_SPRINT ) PRECISE = 2.00;
					}
					if(typ == 0)
					{
						if(ud < 0)//W
						{
							SetDynamicObjectPos(ObiektInfo[id][objSAMP], ObiektInfo[id][objPozX],ObiektInfo[id][objPozY] + PRECISE, ObiektInfo[id][objPozZ]);
						}
						if(ud > 0)//S
						{
							SetDynamicObjectPos(ObiektInfo[id][objSAMP], ObiektInfo[id][objPozX],ObiektInfo[id][objPozY] - PRECISE, ObiektInfo[id][objPozZ]);
						}
						if(lr < 0)//A
						{
							SetDynamicObjectPos(ObiektInfo[id][objSAMP], ObiektInfo[id][objPozX] - PRECISE,ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ]);
						}
						if(lr > 0)//D
						{
							SetDynamicObjectPos(ObiektInfo[id][objSAMP], ObiektInfo[id][objPozX] + PRECISE,ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ]);
						}
					}
					if(typ == 1)
					{
						if(ud < 0)
						{
							PRECISE = 0.10;
							if( keys & KEY_WALK )   PRECISE = 0.01;
							if( keys & KEY_SPRINT ) PRECISE = 1.00;
							SetDynamicObjectPos(ObiektInfo[id][objSAMP], ObiektInfo[id][objPozX],ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ] + PRECISE);
						}
						if(ud > 0)
						{
							PRECISE = 0.10;
							if( keys & KEY_WALK )   PRECISE = 0.01;
							if( keys & KEY_SPRINT ) PRECISE = 1.00;
							SetDynamicObjectPos(ObiektInfo[id][objSAMP], ObiektInfo[id][objPozX],ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ] - PRECISE);
						}
						if(lr < 0)
						{
							if( keys & KEY_SPRINT ) PRECISE = 30.00;
							SetDynamicObjectRot(ObiektInfo[id][objSAMP], ObiektInfo[id][objRotX],ObiektInfo[id][objRotY], ObiektInfo[id][objRotZ] - PRECISE);
						}
						if(lr > 0)
						{
							if( keys & KEY_SPRINT ) PRECISE = 30.00;
							SetDynamicObjectRot(ObiektInfo[id][objSAMP], ObiektInfo[id][objRotX],ObiektInfo[id][objRotY], ObiektInfo[id][objRotZ] + PRECISE);
						}
					}/*
					if( GetPVarInt( playerid, "EdycjaTyp" ) == MOVE_ROT )
					{
						if(ud < 0)
						{
							SetDynamicObjectRot(Object[id][objSAMP], Object[id][objRotX],Object[id][objRotY] - PRECISE, Object[id][objRotZ]);
						}
						if(ud > 0)
						{
							SetDynamicObjectRot(Object[id][objSAMP], Object[id][objRotX],Object[id][objRotY] + PRECISE, Object[id][objRotZ]);
						}
						if(lr < 0)
						{
							SetDynamicObjectRot(Object[id][objSAMP], Object[id][objRotX] - PRECISE,Object[id][objRotY], Object[id][objRotZ]);
						}
						if(lr > 0)
						{
							SetDynamicObjectRot(Object[id][objSAMP], Object[id][objRotX] + PRECISE,Object[id][objRotY], Object[id][objRotZ]);
						}
					}*/
					GetDynamicObjectPos( ObiektInfo[ id ][ objSAMP ], ObiektInfo[ id ][ objPozX ],ObiektInfo[ id ][ objPozY], ObiektInfo[ id ][ objPozZ ] );
					GetDynamicObjectRot( ObiektInfo[ id ][ objSAMP ], ObiektInfo[ id ][ objRotX ],ObiektInfo[ id ][ objRotY], ObiektInfo[ id ][ objRotZ ] );
				}
			}
		}
		if(GetPlayerWeapon(playerid) != 0)
		{
			RemovePlayerAttachedObject(playerid, 2); 
		}
		new weaponid, ammos, testuje = 0; 
		GetPlayerWeaponData(playerid, 1, weaponid, ammos);
		{
			if (weaponid == 5 && GetPlayerWeapon(playerid) != 5)
			{ 
				SetPlayerAttachedObject(playerid, 2, 336, 1,0.3, -0.15,-0.15,0,-85,0); // baseball g,d,p
				testuje++;
			}
			else if (weaponid == 3 && GetPlayerWeapon(playerid) != 3)
			{ 
				SetPlayerAttachedObject(playerid, 2, 334, 8, 0, -0.1, 0.05, 90, 80, 0); // palka pd g,d,p
				testuje++;
			}
			else if (weaponid == 7 && GetPlayerWeapon(playerid) != 7)
			{ 
				SetPlayerAttachedObject(playerid, 2, 338, 1, 0.3, -0.12,-0.15,0,-85,0);	// kij bilardowyee g,d,p
				testuje++;
			}
		}
		if(testuje == 0)
		{
			RemovePlayerAttachedObject(playerid, 1);
		}
		GetPlayerWeaponData(playerid, 2, weaponid, ammos); 
		{
			if (weaponid == 22 && GetPlayerWeapon(playerid) != 22)
			{ 
				SetPlayerAttachedObject(playerid, 2, 346, 8, -0.05, -0.18,-0.1,-20,0,0);// glock g,t,p
				testuje++;
			}
			if (weaponid == 23 && GetPlayerWeapon(playerid) != 23)
			{ 
				SetPlayerAttachedObject(playerid, 2, 347, 8, -0.05, -0.18,-0.1,-20,0,0);// paralizator g,t,p
				testuje++;
			}
			if (weaponid == 24 && GetPlayerWeapon(playerid) != 24)
			{ 
				SetPlayerAttachedObject(playerid, 2, 348, 8, -0.05, -0.18,-0.1,-20,0,0);// deagle g,t,p
				testuje++;
			}
		}
		if(testuje == 0)
		{
			RemovePlayerAttachedObject(playerid, 2);
		}
		GetPlayerWeaponData(playerid, 3, weaponid, ammos); 
		{
			if (weaponid == 25 && GetPlayerWeapon(playerid) != 25)
			{ 
				SetPlayerAttachedObject(playerid, 2, 349, 1, 0.3, -0.13, -0.07, 0, 210, 0);// shotgun g,d,p
				testuje++;
			}
		}
		if(testuje == 0)
		{
			RemovePlayerAttachedObject(playerid, 3);
		}
		GetPlayerWeaponData(playerid, 4, weaponid, ammos); 
		{
			if (weaponid == 28 && GetPlayerWeapon(playerid) != 28)
			{ 
				SetPlayerAttachedObject(playerid, 2, 352, 7, 0.15, 0.1, -0.13  , 90, -80, 0);// uzi g,d,p
				testuje++;
			}
			if (weaponid == 29 && GetPlayerWeapon(playerid) != 29)
			{ 
				SetPlayerAttachedObject(playerid, 2, 353, 1, -0.1, -0.15,0,0,35,0);// mp5 
				testuje++;
			}
			if (weaponid == 32 && GetPlayerWeapon(playerid) != 32)
			{ 
				SetPlayerAttachedObject(playerid, 2, 372, 7, 0.15, 0.1, -0.13  , 90, -70, 0);// tec g,d,p
				testuje++;
			}
		}
		if(testuje == 0)
		{
			RemovePlayerAttachedObject(playerid, 4);
		}
		GetPlayerWeaponData(playerid, 5, weaponid, ammos); 
		{
			if (weaponid == 30 && GetPlayerWeapon(playerid) != 30)
			{ 
				SetPlayerAttachedObject(playerid, 2, 355, 1, -0.1, -0.15,0,0,35,0);// ak47 
				testuje++;
			}
			if (weaponid == 31 && GetPlayerWeapon(playerid) != 31)
			{ 
				SetPlayerAttachedObject(playerid, 2, 356, 1, -0.1, -0.15,0,0,35,0);// m4a1 
				testuje++;
			}
		}
		if(testuje == 0)
		{
			RemovePlayerAttachedObject(playerid, 5);
		}
		GetPlayerWeaponData(playerid, 6, weaponid, ammos); 
		{
			if (weaponid == 34 && GetPlayerWeapon(playerid) != 34)
			{ 
				SetPlayerAttachedObject(playerid, 2, 358, 1, 0.3, -0.13, -0.07, 0, 210, 0);// sniperka g,d,p
				testuje++;
			}
		}
		if(testuje == 0)
		{
			RemovePlayerAttachedObject(playerid, 6);
		}
		if(Rolki[playerid] != 0)
		{
			new keysa, uda, lra;
			GetPlayerKeys(playerid, keysa, uda, lra);
			if(uda & KEY_UP || uda & KEY_DOWN || lra & KEY_LEFT || lra & KEY_RIGHT)
			{
				if(keysa == KEY_SPRINT && !IsPlayerInAnyVehicle(playerid))
				{
					ApplyAnimation(playerid, "SKATE", "skate_run", 1.0, 2, 1, 1, 1, 1);
				}
			}
		}
		else
		{
			if(Bieg[playerid] == 1)
			{
				Frezuj(playerid, 1);
				Bieg[playerid] = 0;
			}
			if(GetPlayerDrunkLevel(playerid) < 14000 && DaneGracza[playerid][gGlod] == 4 && !BlokadaRUN(playerid))
			{
				new keysa, uda, lra;
				GetPlayerKeys(playerid, keysa, uda, lra);
				if(uda & KEY_UP || uda & KEY_DOWN || lra & KEY_LEFT || lra & KEY_RIGHT)
				{
					if(keysa != KEY_WALK && !IsPlayerInAnyVehicle(playerid))
					{
						new myobject = GetPVarInt(playerid, "idobiktu");
						if(myobject == 0)
						{
							OnPlayerText(playerid, "-idz7");
						}
					}
				}
			}
			if(GetPlayerDrunkLevel(playerid) >= 14000)
			{
				new keysa, uda, lra;
				GetPlayerKeys(playerid, keysa, uda, lra);
				if(uda & KEY_UP || uda & KEY_DOWN || lra & KEY_LEFT || lra & KEY_RIGHT)
				{
					if(keysa != KEY_WALK && !IsPlayerInAnyVehicle(playerid))
					{
						new myobject = GetPVarInt(playerid, "idobiktu");
						if(myobject == 0)
						{
							OnPlayerText(playerid, "-pijak");
						}
					}
				}
			}
			if(BlokadaRUN(playerid) && GetPlayerDrunkLevel(playerid) < 14000 && DaneGracza[playerid][gGlod] != 4)
			{
				new keysa, uda, lra;
				GetPlayerKeys(playerid, keysa, uda, lra);
				if(uda & KEY_UP || uda & KEY_DOWN || lra & KEY_LEFT || lra & KEY_RIGHT)
				{
					if(keysa != KEY_WALK && !IsPlayerInAnyVehicle(playerid))
					{
						new myobject = GetPVarInt(playerid, "idobiktu");
						if(myobject == 0)
						{
							Frezuj(playerid, 0);
							OnPlayerText(playerid, "-idz6");
							Bieg[playerid] = 1;
						}
					}
				}
			}
			if(DaneGracza[playerid][gTYPCHODZENIA] != 0)
			{
				new keysa, uda, lra;
				GetPlayerKeys(playerid, keysa, uda, lra);
				if(uda & KEY_UP || uda & KEY_DOWN || lra & KEY_LEFT || lra & KEY_RIGHT)
				{
					if(keysa == KEY_WALK && !IsPlayerInAnyVehicle(playerid))
					{
						new myobject = GetPVarInt(playerid, "idobiktu");
						if(myobject == 0)
						{
							new stra[10];
							strdel(stra, 0, 10);
							format(stra, sizeof(stra), "-idz%d", DaneGracza[playerid][gTYPCHODZENIA]);
							OnPlayerText(playerid, stra);
						}
					}
				}
			}
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			ForeachEx(k, MAX_KOLCZATEK)
			{
				if(KolczatkaInfo[k][kUzyta] == 1)
				{
					new a,b,c,d;
					GetVehicleDamageStatus(GetPlayerVehicleID(playerid), a, b, c, d);
					if(d != 15)
					{
						new Float: x, Float: y;
						x = KolczatkaInfo[k][kPozX];
						y = KolczatkaInfo[k][kPozY];
						for(new Float: xi; xi < 5.2; xi+=0.1)
						{
							GetXYInFrontOfPoint(x, y, KolczatkaInfo[k][kRotZ], xi);
							if(IsPlayerInRangeOfPoint(playerid, 1, x, y, KolczatkaInfo[k][kPozZ]))
							{
								new panels, doors, lights, tires;
								tires = encode_tires(1, 1, 1, 1);
								UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
								//Transakcja(T_KOLCZATKA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, SprawdzCarUID(GetPlayerVehicleID(playerid)), -1, -1, "", gettime()-CZAS_LETNI);
								break;
							}
							x = KolczatkaInfo[k][kPozX];
							y = KolczatkaInfo[k][kPozY];
							GetXYInFrontOfPoint(x, y, KolczatkaInfo[k][kRotZ] - 180, xi);
							if(IsPlayerInRangeOfPoint(playerid, 1, x, y, KolczatkaInfo[k][kPozZ]))
							{
								new panels, doors, lights, tires;
								tires = encode_tires(1, 1, 1, 1);
								UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
								//Transakcja(T_KOLCZATKA, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, SprawdzCarUID(GetPlayerVehicleID(playerid)), -1, -1, "", gettime()-CZAS_LETNI);
								break;
							}
							x = KolczatkaInfo[k][kPozX];
							y = KolczatkaInfo[k][kPozY];
						}
					}
				}
			}
		}
		
	}
	return 1;
}
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}
public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	if(enterexit == 1)
    {
		NadajKare(playerid,-1, 2, "Wymuszony tuning pojazdu", -1);
    }
    return 1;
}
public OnVehicleMod(playerid,vehicleid,componentid)
{
	if(GetPlayerInterior(playerid) == 0)
    {
        NadajKare(playerid,-1, 2, "Wymuszony tuning pojazdu", -1);
    }
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    return 1;
}

stock AntiDeAMX()
{
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}
stock ComparisonString(text1[], text2[])
{
    new cmpTest1 = strlen(text1);
    new cmpTest2 = strlen(text2);
    if(cmpTest1 == cmpTest2)
    {
        new BAD = 0;
        for(new c = 0; c < cmpTest1; c++)
        {
            if(text1[c] == text2[c]) continue;
            else
            {
                BAD = 1;
                break;
            }
        }
        if(BAD == 1) return false;
        else return true;
    }
    return false;
}
forward UsuwanieTwardejSpacji(imie[]);
public UsuwanieTwardejSpacji(imie[])
{
	for(new i = 0; i < strlen(imie); i++)
	{
		if(imie[i] == '_') imie[i] = ' ';
	}
}
//////////////////////////////////////////////////////////////////////////
stock mysql_query2(sql[])
{
	qr++;
    mysql_query(sql);
}
////////////////////////////////////////////////////////////////////////////////
/*CMD:h(playerid,cmdtext[])
{
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	new tekst[256];
	format(tekst, sizeof(tekst), "{88b711}[Pytanie]{99CCFF} %s (ID: %d): %s", ZmianaNicku(playerid), playerid, cmdtext);
	KomunikatOpiekun(tekst);
	SendClientMessage(playerid, SZARY, "Zada³eœ pytanie opiekunowi, {88b711}prosimy o cieprliwoœæ{DEDEDE} - zaraz ktoœ sie do ciebie odezwie.");
	SendClientMessage(playerid, SZARY, tekst);
	return 1;
}*/
CMD:raport(playerid,cmdtext[])
{
	//printf("U¿yta komenda raport");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	new playerid2, tekst[128];
	if(sscanf(cmdtext, "is[128]", playerid2, tekst))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby napisaæ {88b711}raport {DEDEDE}na gracza który {88b711}przeszkadza{DEDEDE} tobie lub innym w grze oraz nie przestrzega {88b711}regulaminu\n{DEDEDE}u¿yj komendy {88b711}/raport [id gracza] [powód]{DEDEDE} np. /raport 0 Sprinter.", "Zamknij", "");
		return 1;
	}
	if(DaneGracza[playerid][gRaport] > gettime())
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wys³a³eœ ostatnio {88b711}raport{DEDEDE}. Odczekaj {88b711}minutê{DEDEDE}, by napisaæ nastêpny.", "Zamknij", "");
		return 0;
	}
	if(zalogowany[playerid2] == false)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz na którego piszesz {88b711}raport{DEDEDE} nie jest zalogowany.", "Zamknij", "");
		return 0;
	}
	if(strfind(tekst, "kurwa", true) >= 0  || strfind(tekst, "chuj", true) >= 0  || strfind(tekst, "wypier", true) >= 0  || strfind(tekst, "spierd", true) >= 0  || strfind(tekst, "dupa", true) >= 0  || strfind(tekst, "cipa", true) >= 0 )
    {
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wysy³aj¹c {88b711}raport{DEDEDE} musisz zachowaæ {88b711}kulturê osobist¹{DEDEDE}. Popraw go.", "Zamknij", "");
	}
	else
	{
		new ip = 0;
		ForeachEx(i, IloscGraczy)
		{
			if((DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 11) && DutyAdmina[KtoJestOnline[i]] == 1)
			{
				new str[256], strs[256];
				format(str, sizeof(str), "{ff6600}[Raport] {dedede}%s (ID:%d) {ff6600}raportuje gracza {dedede}%s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2);
				SendClientMessage(KtoJestOnline[i], 0xFFb00000, str);
				format(strs, sizeof(strs), "{ff6600}Powód: {dedede}%s", tekst);
				SendClientMessage(KtoJestOnline[i], 0xFFb00000, strs);
				ip++;
			}
		}
		if(ip == 0)
		{
			//Transakcja(T_RAPORT, DaneGracza[playerid][gUID], DaneGracza[playerid2][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid2][gGUID], -1, -1, -1, -1, tekst, gettime()-CZAS_LETNI);
		}
		DaneGracza[playerid][gRaport] = gettime()+60;
		new strss[256];
		format(strss, sizeof(strss), "{CC0000}Wys³a³eœ raport na gracza: {CC0000}%s (ID:%d){CC0000}, powód: {CC0000}%s",ZmianaNicku(playerid2), playerid2, tekst);
		SendClientMessage(playerid, 0xFFb00000, strss);
		SendClientMessage(playerid, 0xFFb00000, "{CC0000}Raport z³o¿ony poprawnie, Administracja zosta³a o nim poinformowana!");
		SendClientMessage(playerid2, 0xFFb00000, "{CC0000}Ktoœ wys³a³ na ciebie raport - pamiêtaj raporty s¹ weryfikowane przez administracje, byæ mo¿e coœ przeskroba³eœ.");
	}
	return 1;
}
CMD:pytanie(playerid,cmdtext[])
{
	//printf("U¿yta komenda pytanie");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	new tekst[128];
	if(sscanf(cmdtext, "s[128]", tekst))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby napisaæ {88b711}pytanie {DEDEDE}wpisz: {88b711}/pytanie [treœæ]{DEDEDE}.", "Zamknij", "");
		return 1;
	}
	if(DaneGracza[playerid][gPytanie] > gettime())
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wys³a³eœ ostatnio {88b711}pytanie{DEDEDE}. Odczekaj {88b711}minutê{DEDEDE}, by napisaæ kolejne.", "Zamknij", "");
		return 0;
	}
	if(strfind(tekst, "kurwa", true) >= 0  || strfind(tekst, "chuj", true) >= 0  || strfind(tekst, "wypier", true) >= 0  || strfind(tekst, "spierd", true) >= 0  || strfind(tekst, "dupa", true) >= 0  || strfind(tekst, "cipa", true) >= 0 )
    {
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wysy³aj¹c {88b711}pytanie{DEDEDE} musisz zachowaæ {88b711}kulturê osobist¹{DEDEDE}. Popraw to.", "Zamknij", "");
		return 1;
	}
	else
	{
		new ip = 0;
		ForeachEx(i, IloscGraczy)
		{
			if((DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 11 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 10) && DutyAdmina[KtoJestOnline[i]] == 1)
			{
				new str[256];
				format(str, sizeof(str), "{ff6600}[%s(ID: %d) zada³ pytanie] {dedede} %s",ZmianaNicku(playerid), playerid, tekst);
				SendClientMessage(KtoJestOnline[i], 0xFFb00000, str);
				ip++;
			}
		}
		DaneGracza[playerid][gPytanie] = gettime()+60;
		new strss[256];
		if(ip != 0)
		{
			format(strss, sizeof(strss), "{88b711}[Pytanie do Administracji]:{DEDEDE} %s", tekst);
			SendClientMessage(playerid, 0xFFb00000, strss);
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Obecnie nie ma {88b711}¿adnego{DEDEDE} Administratora oraz Game Mastera na s³uzbiê - spóbuj ponownie póŸniej.", "Zamknij", "");
			return 1;
		}
	}
	return 1;
}
CMD:worek(playerid,cmdtext[])
{
	//printf("U¿yta komenda worek");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!GraczaMaTypPrzedmiotu(playerid, P_WOREK))
	{
		return 0;
	}
	new playerid2;
	if(sscanf(cmdtext, "i", playerid2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ {88b711}worka{DEDEDE} wpisz: {88b711}/worek [id gracza]{DEDEDE}.", "Zamknij", "");
		return 1;
	}
	if(playerid == playerid2) return 0;
	if(!PlayerObokPlayera(playerid, playerid2, 5))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz siê obok {88b711}gracza{DEDEDE} któremu chcesz za³o¿yæ worek na g³owê.", "Zamknij", "");
	    return 0;
	}
	if(zalogowany[playerid2] == false)
	{
		return 0;
	}
	if(DaneGracza[playerid2][gWorek] == 0)
	{
	    TextDrawShowForPlayer(playerid2, Worek);
	    DaneGracza[playerid2][gWorek] = 1;
		new str[256];
		format(str, sizeof(str), "zak³ada worek na g³owe %s.", ZmianaNicku(playerid2));
	    cmd_fasdasfdfive(playerid, str);
	}
	else
	{
	    TextDrawHideForPlayer(playerid2, Worek);
	    DaneGracza[playerid2][gWorek] = 0;
		new str[256];
		format(str, sizeof(str), "zdejmuje worek z g³owy %s.", ZmianaNicku(playerid2));
	    cmd_fasdasfdfive(playerid, str);
	}
	return 1;
}

CMD:przebierz(playerid,params[])
{
	//printf("U¿yta komenda przebierz");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) == 0)
	{
		return 0;
	}
	if(!OtwieranieBudynku(GetPlayerVirtualWorld(playerid), playerid))
	{
	    GameTextForPlayer(playerid, "~r~Mozesz przebierac sie tylko w budynku do ktorego posiadasz klucze.", 3000, 5);
	    return 0;
	}//2,8,14,20,26,32,DaneGracza[playerid][gPrzynaleznosci][6]
	new	dzg_lista[350], find = 1;
	format(dzg_lista, sizeof(dzg_lista), "%s\n{DEDEDE}»  Domyœlny", dzg_lista);
	if(DaneGracza[playerid][gDzialalnosc1] != 0)
	{
	    new uid = DaneGracza[playerid][gDzialalnosc1];
		format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{88b711}%s", dzg_lista, find, GrupaInfo[uid][gNazwa]);
	    find++;
	}
	if(DaneGracza[playerid][gDzialalnosc2] != 0)
	{
		new uid = DaneGracza[playerid][gDzialalnosc2];
		format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{88b711}%s", dzg_lista, find, GrupaInfo[uid][gNazwa]);
	    find++;
	}
	if(DaneGracza[playerid][gDzialalnosc3] != 0)
	{
		new uid = DaneGracza[playerid][gDzialalnosc3];
		format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{88b711}%s", dzg_lista, find, GrupaInfo[uid][gNazwa]);
	    find++;
	}
	if(DaneGracza[playerid][gDzialalnosc4] != 0 && GraczPremium(playerid))
	{
		new uid = DaneGracza[playerid][gDzialalnosc4];
		format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{88b711}%s", dzg_lista, find, GrupaInfo[uid][gNazwa]);
	    find++;
	}
	if(DaneGracza[playerid][gDzialalnosc5] != 0 && GraczPremium(playerid))
	{
		new uid = DaneGracza[playerid][gDzialalnosc5];
		format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{88b711}%s", dzg_lista, find, GrupaInfo[uid][gNazwa]);
	    find++;
	}
	if(DaneGracza[playerid][gDzialalnosc6] != 0 && GraczPremium(playerid))
	{
		new uid = DaneGracza[playerid][gDzialalnosc6];
		format(dzg_lista, sizeof(dzg_lista), "%s\n%d\t{88b711}%s", dzg_lista, find, GrupaInfo[uid][gNazwa]);
	    find++;
	}
	dShowPlayerDialog(playerid, DIALOG_PRZEBIERZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Przebierz{88b711}:", dzg_lista, "Przebierz", "Wyjdz");
	return 1;
}
CMD:zamknij(playerid,params[])
{
	//printf("U¿yta komenda zamknij");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new id = -1;
	for(new h = 0; h < sizeof(NieruchomoscInfo); h++)
	{
		if(NieruchomoscInfo[h][nUID] != 0)
		{
			if(Dystans(3.0, playerid, NieruchomoscInfo[h][nX], NieruchomoscInfo[h][nY], NieruchomoscInfo[h][nZ]) && NieruchomoscInfo[h][nVW] == GetPlayerVirtualWorld(playerid) || Dystans(3.0, playerid, NieruchomoscInfo[h][nXW], NieruchomoscInfo[h][nYW], NieruchomoscInfo[h][nZW]) && NieruchomoscInfo[h][nVWW] == GetPlayerVirtualWorld(playerid))
			{
				id = h;
			}
		}
	}
	if(id == -1)
	{
		return 1;
	}
	if(NieruchomoscInfo[id][nMapa] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
		return 0;
	}
	if(!OtwieranieBudynku(id, playerid))
	{
	    GameTextForPlayer(playerid, "~r~~h~Nie posiadasz uprawnien do~n~~w~/zamknij.", 3000, 5);
	    return 0;
	}
	if(NieruchomoscInfo[id][nZamek] == 1)
	{
		NieruchomoscInfo[id][nZamek] = 0;
		//Transakcja(T_CDRZWI, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, id, -1, -1, "Zamkniecie", gettime()-CZAS_LETNI);
		ForeachEx(x, IloscGraczy)
		{
		    if(PlayerObokPlayera(playerid, KtoJestOnline[x], 10))
		    {
           		PlayerPlaySound(KtoJestOnline[x], 1145, 0.0, 0.0, 0.00);
          	}
        }
        if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
	}
	else
	{
		NieruchomoscInfo[id][nZamek] = 1;
		Transakcja(T_CDRZWI, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, id, -1, -1, "Otwarcie", gettime()-CZAS_LETNI);
		ForeachEx(x, IloscGraczy)
		{
		    if(PlayerObokPlayera(playerid, KtoJestOnline[x], 10))
		    {
           		PlayerPlaySound(KtoJestOnline[x], 1145, 0.0, 0.0, 0.00);
          	}
        }
        if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
	}
	ZapiszNieruchomosc(id);
	return 1;
}
/*
CMD:specoff(playerid, cmdtext[])
{
	//printf("U¿yta komenda specoff");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1)
    {
		if(SpecUruchomiony[playerid]==1)
		{
			TogglePlayerSpectating ( playerid, 0 ) ;
			SpawnPlayer(playerid);
			SpecCel[playerid]=-1;
			SpecUruchomiony[playerid]=0;
			GameTextForPlayer(playerid, "~g~spec wylaczony", 5500, 3);
		}
	}
    return 1;
}*/
CMD:yo(playerid, params[])
{
	//printf("U¿yta komenda yo");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new id;
	if(sscanf(params, "d", id))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}graczu{DEDEDE} przywitanie wpisz: {88b711}/yo [id gracza]{DEDEDE}.", "Zamknij", "");
		return 1;
	}
	if(id == INVALID_PLAYER_ID) return 0;
	if(!PlayerObokPlayera(playerid, id, 5))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ{DEDEDE} przywitanie nie znajduje siê obok ciebie.", "Zamknij", "");
		return 1;
	}
	if(!IsPlayerFacingPlayer(playerid, id, 20)) 
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ{DEDEDE} przywitanie nie patrzy w twoj¹ strone.", "Zamknij", "");
		return 1;
	}
	else
	{
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Oferuj(playerid, id, 0, 0, 0, 0, OFEROWANIE_YO, 0, "", 0);
	}
	return 1;
}
/*
CMD:spec(playerid, cmdtext[])
{
	//printf("U¿yta komenda spec");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1)
    {
		new playa;
		if(sscanf(cmdtext, "d", playa))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby podgl¹daæ {88b711}gracza{DEDEDE} wpisz: {88b711}/spec [id gracza]{DEDEDE}.", "Zamknij", "");
			return 1;
		}
		if(playa==playerid) return 1;
		if(zalogowany[playa] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}podgl¹daæ{DEDEDE} nie jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playa][gAdmGroup] == 4 && DaneGracza[playerid][gAdmGroup] != 4)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}uprawnieñ{DEDEDE} do {88b711}podgl¹dania{DEDEDE} tego gracza.", "Zamknij", "");
			return 0;
		}
		if(IsPlayerConnected(playa)&&zalogowany[playa]==true)
		{
			SpecUruchomiony[playerid]=1;
			SpecCel[playerid]=playa;
			SetTimerEx("SpecSystem",5500, 0, "d", playerid);
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}podgl¹daæ{DEDEDE} nie jest zalogowany.", "Zamknij", "");
			return 0;
		}
	}
    return 1;
}*/
forward Spawns(playerid);
public Spawns(playerid)
{
	SpawnPlayer(playerid);
	SetTimerEx("SprawdzSpawn",1000, 0, "d", playerid);
	return 1;
}
forward SprawdzSpawn(playerid);
public SprawdzSpawn(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(DaneGracza[playerid][gAJ] != 0)
	{
		if(x+20.0 < 1174.3706 || x-20.0 > 1174.3706)
		{
			SetTimerEx("Spawns",500, 0, "d", playerid);
		}
		return 1;
	}
	else if(DaneGracza[playerid][gBW] != 0)
	{
	    if(x+20.0 < DaneGracza[playerid][gX] || x-20.0 > DaneGracza[playerid][gX])
		{
			SetTimerEx("Spawns",500, 0, "d", playerid);
		}
		return 1;
	}
	else if(DaneGracza[playerid][gPrzetrzmanie] != 0)
	{
		if(x+20.0 < DaneGracza[playerid][gPX] || x-20.0 > DaneGracza[playerid][gPX])
		{
			SetTimerEx("Spawns",500, 0, "d", playerid);
		}
		return 1;
	}
	else if(DaneGracza[playerid][gQS] >= gettime())
	{
		if(x+20.0 < DaneGracza[playerid][gX] || x-20.0 > DaneGracza[playerid][gX])
		{
			SetTimerEx("Spawns",500, 0, "d", playerid);
		}
		return 1;
	}
	else if(DaneGracza[playerid][gWynajem] != 0)
	{
		new ui = DaneGracza[playerid][gWynajem];
		if(x+20.0 < NieruchomoscInfo[ui][nXW] || x-20.0 > NieruchomoscInfo[ui][nXW])
		{
			SetTimerEx("Spawns",500, 0, "d", playerid);
		}
		return 1;
	}
	else
	{
		if(SpawnPlayerRandom[playerid] == 0)
		{
			if(x+20.0 < 1234.4191 || x-20.0 > 1234.4191)
			{
				SetTimerEx("Spawns",500, 0, "d", playerid);
			}
			return 1;
		}
		if(SpawnPlayerRandom[playerid] == 1)
		{
			if(x+20.0 < 1231.0106 || x-20.0 > 1231.0106)
			{
				SetTimerEx("Spawns",500, 0, "d", playerid);
			}
			return 1;
		}
		if(SpawnPlayerRandom[playerid] == 2)
		{
			if(x+20.0 < 1225.9561 || x-20.0 > 1225.9561)
			{
				SetTimerEx("Spawns",500, 0, "d", playerid);
			}
			return 1;
		}
		if(SpawnPlayerRandom[playerid] == 3)
		{
			if(x+20.0 < 1231.2156 || x-20.0 > 1231.2156)
			{
				SetTimerEx("Spawns",500, 0, "d", playerid);
			}
			return 1;
		}
		if(SpawnPlayerRandom[playerid] == 4)
		{
			if(x+20.0 < 1225.9934 || x-20.0 > 1225.9934)
			{
				SetTimerEx("Spawns",500, 0, "d", playerid);
			}
			return 1;
		}
	}
	return 1;
}
forward SpecSystem(playerid);
public SpecSystem(playerid)
{
	if(SpecUruchomiony[playerid] && SpecCel[playerid] != -1 )
	{
	    new specowany = SpecCel[playerid];
	    if(IsPlayerConnected(specowany) && DutyAdmina[playerid] == 1)
	    {
			strdel(tekst_global, 0, 2048);
			new interior = GetPlayerInterior(specowany), vw = GetPlayerVirtualWorld(specowany);
		  	SetPlayerInterior(playerid, interior );
		   	SetPlayerVirtualWorld(playerid, vw);
			format( tekst_global, sizeof( tekst_global ), "~y~%s ~r~(ID: %d, UID: %d, GUID: %d)~n~Kasa: %d$ Bank: %d$", ZmianaNicku(specowany), specowany, DaneGracza[specowany][gUID], DaneGracza[playerid][gGUID], DaneGracza[specowany][gPORTFEL], DaneGracza[specowany][gSTAN_KONTA]);
			GameTextForPlayer(playerid, tekst_global, 5500, 1);
			if(!IsPlayerInAnyVehicle(specowany))
			{
				TogglePlayerSpectating ( playerid, 1 ) ;
				PlayerSpectatePlayer(playerid, specowany);
			}
			else
			{
				TogglePlayerSpectating ( playerid, 1 ) ;
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specowany));
			}
			SetTimerEx("SpecSystem", 1000, 0, "d", playerid);
		}
		else
		{
			//SpawnPlayer(playerid);
			SetCameraBehindPlayer(playerid);
			TogglePlayerSpectating ( playerid, 0 ) ;
			SpecCel[playerid] 			= -1;
			SpecUruchomiony[playerid]	= 0;
			GameTextForPlayer(playerid, "~r~Gracz rozlaczyl sie!", 5500, 3);
		}
	}
	return 1;
}

CMD:rc(playerid,cmdtext[])
{
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1 || DaneGracza[playerid][gGUID] == 1356)
    {
		new playerid2;
		if(sscanf(cmdtext, "i", playerid2))
		{
		    if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		    {
		        SetPlayerInterior(playerid, 0);
		    	SetPlayerVirtualWorld(playerid, 0);
		        TogglePlayerSpectating(playerid, 0);
				SetCameraBehindPlayer(playerid);
			}
			return 1;
		}
		if(zalogowany[playerid2] == false || !IsPlayerConnected(playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}podgl¹daæ{DEDEDE} nie jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid2][gAdmGroup] == 4 && DaneGracza[playerid][gAdmGroup] != 4)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}uprawnieñ{DEDEDE} do {88b711}podgl¹dania{DEDEDE} tego gracza.", "Zamknij", "");
			return 0;
		}
		SetPlayerInterior(playerid, GetPlayerInterior(playerid2));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid2));
		SetPVarInt(playerid, "Teleportacja", 1);
		if(GetPlayerVehicleID(playerid2) != 0)
		{
		    TogglePlayerSpectating(playerid, 1);
		    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerid2));
		}
		else
		{
		    TogglePlayerSpectating(playerid, 1);
		    PlayerSpectatePlayer(playerid, playerid2);
		}
        SetPVarInt(playerid, "Teleportacja", 0);
		strdel(tekst_global, 0, 2048);
		format( tekst_global, sizeof( tekst_global ), "~y~%s ~r~(ID: %d, UID: %d, GUID: %d)~n~Kasa: %d$ Bank: %d$", ZmianaNicku(playerid2), playerid2, DaneGracza[playerid2][gUID], DaneGracza[playerid2][gGUID], DaneGracza[playerid2][gPORTFEL], DaneGracza[playerid2][gSTAN_KONTA]);
		GameTextForPlayer(playerid, tekst_global, 5500, 1);
		new przelew[124];
		format(przelew, sizeof(przelew), "[RC] Gracz: %s (ID:%d) podgl¹da gracza: %s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2);
		KomunikatAdmin(1, przelew);
		//Transakcja(T_RC, DaneGracza[playerid][gUID], DaneGracza[playerid2][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid2][gGUID], -1, -1, -1, -1, "-", gettime()-CZAS_LETNI);
	}
	return 1;
}
CMD:klatwa(playerid,cmdtext[])
{
	//printf("U¿yta komenda klatwa");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 4)) && DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[124];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}kl¹twe{DEDEDE} wpisz: {88b711}/klatwa [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ kl¹twe {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(Klatwa(playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ {88b711}kl¹twe{DEDEDE} posiada tak¹ kare.", "Zamknij", "");
			return 0;
		}
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		NadajKare(playerid2,playerid, 10, tresc, cash);
		if(cash == -1)
		{
		DaneGracza[playerid2][gKLATWA] = -1;
		}
		else
		{
		DaneGracza[playerid2][gKLATWA] = (gettime()-CZAS_LETNI)+(86400*cash);
		}
		ZapiszGraczaGlobal(playerid2, 7);
	}
	return 1;
}
CMD:ban(playerid,cmdtext[])
{
	//printf("U¿yta komenda ban");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 ||(DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 5)) && DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[124];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby kogoœ {88b711}zbanowaæ{DEDEDE} wpisz: {88b711}/ban [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ bana {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		NadajKare(playerid2,playerid, 2, tresc, cash);
		if(cash == -1)
		{
		DaneGracza[playerid2][gBAN] = -1;
		}
		else
		{
		DaneGracza[playerid2][gBAN] = (gettime()-CZAS_LETNI)+(86400*cash);
		}
		ZapiszGraczaGlobal(playerid2, 4);
		Kick(playerid2);
	}
	return 1;
}
CMD:oo(playerid,cmdtext[])
{
	//printf("U¿yta komenda oo");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
	{
		strdel(tekst_global, 0, 2048);
		if(sscanf(cmdtext, "s[256]", tekst_global))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}globaln¹{DEDEDE} wiadomoœæ wpisz: /oo [treœæ]", "Zamknij", "");
			return 1;
		}
		format(tekst_global, sizeof(tekst_global), "[[ %s: %s ]]", DaneGracza[playerid][nickOOC], tekst_global);
		SendWrappedMessageToAll(0xff99ccFF, tekst_global);
	}
	return 1;
}
CMD:gs(playerid,cmdtext[])
{
	//printf("U¿yta komenda booc");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 2))&& DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[256];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}gamescore{DEDEDE} wpisz: {88b711}/gs [id gracza] [iloœæ] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    return 1;
		}
		if(cash!= 0)
		{
			if(cash > 0)
			{
				NadajKare(playerid2,playerid, 9, tresc, cash);
				DaneGracza[playerid2][gGAMESCORE] = DaneGracza[playerid2][gGAMESCORE]+cash;
				SetPlayerScore(playerid2,DaneGracza[playerid2][gGAMESCORE]);
				ZapiszGraczaGlobal(playerid2, 1);
			}
			else
			{
				
			}
		}
		
	}
	return 1;
}
CMD:booc(playerid,cmdtext[])
{
	//printf("U¿yta komenda booc");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 2))&& DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[256];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}blokade czatu OOC{DEDEDE} wpisz: {88b711}/booc [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ blokade czatu OOC {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		if(BlokadaOOC(playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ {88b711}blokade czatu OOC{DEDEDE} posiada tak¹ kare.", "Zamknij", "");
			return 0;
		}
		NadajKare(playerid2,playerid, 7, tresc, cash);
		if(!Klatwa(playerid2))
		{
			if(cash == -1)
			{
				DaneGracza[playerid2][gOOC] = -1;
			}
			else
			{
				DaneGracza[playerid2][gOOC] = (gettime()-CZAS_LETNI)+(86400*cash);
			}
			ZapiszGraczaGlobal(playerid2, 2);
		}
	}
	return 1;
}
CMD:aj(playerid,cmdtext[])
{
	//printf("U¿yta komenda aj");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11)&& DutyAdmina[playerid] == 1)
	{
		new playerid2, tresc[256],minut;
		if(sscanf(cmdtext, "ids[124]", playerid2, minut, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}admin jaila{DEDEDE} wpisz: {88b711}/aj [id gracza] [minuty] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ admin jaila {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(minut <= 0) return 1;
		//NadajKare(playerid2,playerid, 3, tresc, minut);
		SetPlayerInAdminJail(playerid2, playerid, minut, tresc);
	}
	return 1;
}
CMD:warn(playerid,cmdtext[])
{
	//printf("U¿yta komenda warn");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11)&& DutyAdmina[playerid] == 1)
    {
		new playerid2, tresc[256];
		if(sscanf(cmdtext, "is[124]", playerid2, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}warna{DEDEDE} wpisz: {88b711}/warn [id gracza] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ warna {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		NadajKare(playerid2,playerid, 1, tresc, 0);
	}
	return 1;
}
CMD:unbw(playerid,cmdtext[])
{
	//printf("U¿yta komenda unbw");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11)&& DutyAdmina[playerid] == 1)
    {
		new playerid2;
		if(sscanf(cmdtext, "i", playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby usun¹æ {88b711}bw{DEDEDE} wpisz: {88b711}/unbw [id gracza]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz usun¹æ bw {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[playerid2][gBW] == 0)
		{
			return 1;
		}
		strdel(tekst_global, 0, 2048);
		format(tekst_global, sizeof(tekst_global), "{DEDEDE}Twoje bw zosta³o usuniête przez gracza: {88b711}%s{DEDEDE}.", ZmianaNicku(playerid));
		SendClientMessage(playerid2, KOLOR, tekst_global);
		SetCameraBehindPlayer(playerid2);
		UstawHP(playerid2,100);
		DaneGracza[playerid2][gBW] = 0;
		ZapiszGracza(playerid2);
		RefreshNick(playerid2);
		Frezuj(playerid2, 1);
		new przelew[124];
		format(przelew, sizeof(przelew), "[UNBW] Gracz: %s (ID:%d) da³ unbw graczu: %s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2);
		KomunikatAdmin(1, przelew);
	}
	return 1;
}
CMD:kick(playerid,cmdtext[])
{
	//printf("U¿yta komenda kick");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11)&& DutyAdmina[playerid] == 1)
    {
		new playerid2, tresc[256];
		if(sscanf(cmdtext, "is[124]", playerid2, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}kicka{DEDEDE} wpisz: {88b711}/kick [id gracza] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ kicka {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		NadajKare(playerid2,playerid, 0, tresc, 0);
	}
	return 1;
}
CMD:brun(playerid,cmdtext[])
{
	//printf("U¿yta komenda brun");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 2))&& DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[256];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}blokade biegania{DEDEDE} wpisz: {88b711}/brun [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ blokade biegania {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		if(BlokadaRUN(playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ {88b711}blokade biegania{DEDEDE} posiada tak¹ kare.", "Zamknij", "");
			return 0;
		}
		NadajKare(playerid2,playerid, 5, tresc, cash);
		if(!Klatwa(playerid2))
		{
			if(cash == -1)
			{
			DaneGracza[playerid2][gRUN] = -1;
			}
			else
			{
			DaneGracza[playerid2][gRUN] = (gettime()-CZAS_LETNI)+(86400*cash);
			}
			ZapiszGraczaGlobal(playerid2, 3);
		}
	}
	return 1;
}
CMD:bgun(playerid,cmdtext[])
{
	//printf("U¿yta komenda bgun");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 3))&& DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[256];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}blokade broni{DEDEDE} wpisz: {88b711}/bgun [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ blokade broni {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		if(BlokadaGUN(playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ {88b711}blokade broni{DEDEDE} posiada tak¹ kare.", "Zamknij", "");
			return 0;
		}
		ResetPlayerWeapons(playerid2);
		if(!Klatwa(playerid2))
		{
			if(cash == -1)
			{
			DaneGracza[playerid2][gGUN] = -1;
			}
			else
			{
			DaneGracza[playerid2][gGUN] = (gettime()-CZAS_LETNI)+(86400*cash);
			}
			ZapiszGraczaGlobal(playerid2, 6);
		}
	}
	return 1;
}
CMD:bveh(playerid,cmdtext[])
{
	//printf("U¿yta komenda bveh");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 3))&& DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[256];
		if(sscanf(cmdtext, "ids[124]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}blokade pojazdów{DEDEDE} wpisz: {88b711}/bveh [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ blokade pojazdów {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		if(BlokadaVEH(playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ {88b711}blokade pojazdów{DEDEDE} posiada tak¹ kare.", "Zamknij", "");
			return 0;
		}
		NadajKare(playerid2,playerid, 6, tresc, cash);
		if(!Klatwa(playerid2))
		{
			if(cash == -1)
			{
			DaneGracza[playerid2][gVEH] = -1;
			}
			else
			{
			DaneGracza[playerid2][gVEH] = (gettime()-CZAS_LETNI)+(86400*cash);
			}
			RemovePlayerFromVehicle(playerid2);
			RemovePlayerFromVehicle(playerid2);
			ZapiszGraczaGlobal(playerid2, 5);
		}
	}
	return 1;
}
CMD:bkonta(playerid,cmdtext[])
{
	//printf("U¿yta komenda bkonta");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 3))&& DutyAdmina[playerid] == 1)
    {
		new playerid2, cash, tresc[256];
		strdel(tresc, 0, 256);
		if(sscanf(cmdtext, "ids[256]", playerid2, cash, tresc))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}blokade konta{DEDEDE} wpisz: {88b711}/bkonta [id gracza] [iloœæ dni] [treœæ]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz nadaæ blokade konta {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(cash < -1 || cash > 361)
		{
		    return 0;
		}
		NadajKare(playerid2,playerid, 4, tresc, cash);
		if(cash == -1)
		{
			DaneGracza[playerid2][gAKTYWNE] = -1;
		}
		else
		{
			DaneGracza[playerid2][gAKTYWNE] = (gettime()-CZAS_LETNI)+(86400*cash);
		}
		ZapiszGracza(playerid2);
		Kick(playerid2);
	}
	return 1;
}
CMD:plac(playerid,cmdtext[])
{
	//printf("U¿yta komenda plac");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new playerid2, cash, str[64];
	if(sscanf(cmdtext, "id", playerid2, cash))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby daæ graczu {88b711}pieni¹dze{DEDEDE} wpisz: {88b711}/plac [id gracza] [iloœæ pieniêdzy]", "Zamknij", "");
		return 1;
	}
	if(playerid == playerid2) return 1;
	if(!PlayerObokPlayera(playerid, playerid2, 5))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz daæ {88b711}pieni¹dze{DEDEDE} nie znajduje siê obok ciebie.", "Zamknij", "");
	    return 1;
	}
	if(zalogowany[playerid2] == false)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz daæ pieni¹dze {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
		return 1;
	}
	if(cash > DaneGracza[playerid][gPORTFEL])
	{
	    GameTextForPlayer(playerid, "~r~Nie posiadasz takiej kwoty.", 3000, 5);
		return 1;
	}
	if(cash <= 0)
	{
	    return 1;
	}
	if(DaneGracza[playerid][gCZAS_ONLINE] < 10 * 60 * 60)
	{
		new przelew[124];
		format(przelew, sizeof(przelew), "[OSTRZE¯ENIE] Gracz: %s (ID:%d) da³ graczu: %s (ID:%d) (%d$)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2,cash);
		KomunikatAdmin(1, przelew);
	}
	else if(DaneGracza[playerid2][gCZAS_ONLINE] < 10 * 60 * 60)
	{
		new przelew[124];
		format(przelew, sizeof(przelew), "[OSTRZE¯ENIE] Gracz: %s (ID:%d) da³ graczu: %s (ID:%d) (%d$)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2,cash);
		KomunikatAdmin(1, przelew);
	}
	Dodajkase(playerid, -cash);
	Dodajkase(playerid2, cash);
	format(str, sizeof(str), "podajê trochê pieniêdzy %s.", ZmianaNicku(playerid2));
	cmd_fasdasfdfive(playerid,str);
	new text[124];
	format(text, sizeof(text), "{DEDEDE}%s da³ Tobie %d$", ZmianaNicku(playerid), cash);
	new texts[124];
	format(texts, sizeof(texts), "{DEDEDE}Da³eœ %s %d$.", ZmianaNicku(playerid2), cash);
	SendClientMessage(playerid2, SZARY, text);
	SendClientMessage(playerid, SZARY, texts);
	Transakcja(T_PLAC, DaneGracza[playerid][gUID], DaneGracza[playerid2][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid2][gGUID], cash, -1, -1, -1, "-", gettime()-CZAS_LETNI);
	return 1;
}
stock KomunikatAdmin(sluzba, powod[])
{
	if(sluzba == 1)
	{
		ForeachEx(i, IloscGraczy)
		{
			if((DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 11) && DutyAdmina[KtoJestOnline[i]] == 1)
			{
				SendClientMessage(KtoJestOnline[i], 0x00FFFF00, powod);
			}
		}
	}
	else
	{
		ForeachEx(i, IloscGraczy)
		{
			if(DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 11)
			{
				SendClientMessage(KtoJestOnline[i], 0x00FFFF00, powod);
			}
		}
	}
	
	return 1;
}
stock KomunikatOpiekun(pytanie[])
{
	ForeachEx(i, IloscGraczy)
	{
		if((DaneGracza[KtoJestOnline[i]][gAdmGroup] == 10) && DutyAdmina[KtoJestOnline[i]] == 1)
		{
			SendClientMessage(KtoJestOnline[i], 0x99CCFF00, pytanie);
		}
	}
	return 1;
}
CMD:namiot( playerid, params[ ] )
{
	//printf("U¿yta komenda praca");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	for(new i = 0; i < sizeof(NieruchomoscInfo); i++)
	{
		if(Dystans(1.0, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
		{
			if(NieruchomoscInfo[i][nTyp] == 20)
		   	{
				if(DaneGracza[playerid][gPORTFEL] < NieruchomoscInfo[i][nHotel])
				{
					dShowPlayerDialog(playerid, DIALOG_HOTEL, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz wystarczaj¹cej {88b711}gotówki{DEDEDE} aby wynaj¹æ Namiot.", "Zamknij", "");
					return 0;
				}
				Dodajkase(playerid, -NieruchomoscInfo[i][nHotel]);
				DaneGracza[playerid][gWynajem] = NieruchomoscInfo[i][nUID];
				DaneGracza[playerid][gZamHot] = gettime() + 86400;
				ZapiszGracza(playerid);
				strdel(zapyt, 0, 1024);
				format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `WYNAJEM`='%d' WHERE `ID`='%d'", DaneGracza[playerid][gWynajem], DaneGracza[playerid][gUID]);
				mysql_query(zapyt);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gratulacje {88b711}zameldowa³eœ{DEDEDE} siê w Namiocie na okres jednego dnia.", "Zamknij", "");
	    		break;
		   	}
		}
	}
	return 1;
}
CMD:pokoj(playerid, params[])
{
	//printf("U¿yta komenda pokoj");
    if(zalogowany[playerid] == false) return 0;
	if(DaneGracza[playerid][gBW] != 0) return 0;
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0) return 0;
	if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0) return 0;
	new uid = NieruchomoscInfo[vw][nWlascicielD];
	if(GrupaInfo[uid][gTyp] != DZIALALNOSC_HOTEL) return 0;
	new hotelstr[512];
	format(hotelstr, sizeof(hotelstr), "{DEDEDE}Aby wynaj¹æ pokój w tym hotelu wybie¿ przycisk ''{88b711}Wynajmij{DEDEDE}''\nKoszt wynajêcia pokoju na 3 wynosi: {88b711}%d{DEDEDE}$, pierwsze zameldowanie wynosi: {88b711}%d{DEDEDE}$", NieruchomoscInfo[vw][nHotel], (NieruchomoscInfo[vw][nHotel]+50));
	dShowPlayerDialog(playerid, DIALOG_HOTEL, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Hotel{88b711}:", hotelstr, "Wynajmij", "Zamknij");
	return 1;
}
CMD:wymelduj(playerid, params[])
{
	if(DaneGracza[playerid][gWynajem] != 0)
	{
		DaneGracza[playerid][gWynajem] = 0;
		strdel(zapyt, 0, 1024);
		format(zapyt, sizeof(zapyt),"UPDATE `five_postacie` SET `WYNAJEM`='%d' WHERE `ID`='%d'", DaneGracza[playerid][gWynajem], DaneGracza[playerid][gUID]);
		mysql_query(zapyt);
		dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE}Zrezygnowa³es z {88b711}wynajmu{DEDEDE} w tej nieruchomoœci.", "Zamknij", "" );
	}
	return 1;
}
CMD:salon(playerid, params[])
{
	//printf("U¿yta komenda salon");
	new vw = GetPlayerVirtualWorld(playerid);
    if(zalogowany[playerid] == false) return 0;
	if(DaneGracza[playerid][gBW] != 0) return 0;
	if(vw == 0) return 0;
	if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0) return 0;
	new uid = NieruchomoscInfo[vw][nWlascicielD];
	if(GrupaInfo[uid][gTyp] != DZIALALNOSC_SALON) return 0;
	dShowPlayerDialog(playerid, DIALOG_SALON_POJAZDOW, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Salon Pojazdów{88b711}:", "{DEDEDE}»  {88b711}Tanie\n{DEDEDE}»  {88b711}Popularne Tanie\n{DEDEDE}»  {88b711}Popularne\n{DEDEDE}»  {88b711}Prawie luksusowe\n{DEDEDE}»  {88b711}Sport & Exclusive\n{DEDEDE}»  {88b711}£odzie\n{DEDEDE}»  {88b711}Jednoœlady\n{DEDEDE}»  {88b711}Samoloty & Helikoptery\n{DEDEDE}»  {88b711}Pojazdy premium", "Wybierz", "Zamknij");
	return 1;
}
CMD:dodatki(playerid, params[])
{
	//printf("U¿yta komenda dodatki");
    if(zalogowany[playerid] == false) return 0;
	if(DaneGracza[playerid][gBW] != 0) return 0;
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0) return 0;
	if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0) return 0;
	new uid = NieruchomoscInfo[vw][nWlascicielD];
	if(GrupaInfo[uid][gTyp] != DZIALALNOSC_BINCO)
	{
	    return 0;
	}
	dShowPlayerDialog(playerid, DIALOG_ATTACH_INDEX_SELECTION, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}»  {88b711}Slot 1\n{DEDEDE}»  {88b711}Slot 2", "Wybierz", "Zamknij");
	return 1;
}
CMD:ubranie(playerid, params[])
{
	//printf("U¿yta komenda ubranie");
    if(zalogowany[playerid] == false) return 0;
	if(DaneGracza[playerid][gBW] != 0) return 0;
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0) return 0;
	if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0) return 0;
	new uid = NieruchomoscInfo[vw][nWlascicielD];
	if(GrupaInfo[uid][gTyp] != DZIALALNOSC_BINCO)
	{
	    return 0;
	}
	if(GetPVarInt(playerid, "WybieraUbranie") == 1)
	{
		return 0;
	}
	new Float:Pos[3];
	GetPlayerPos(playerid, Pos[0],Pos[1],Pos[2]);
	SkinIDM[playerid] = 0;
	SkinIDW[playerid] = 0;
	SetPVarInt(playerid, "UbranieNa", GetPlayerSkin(playerid));
	if(DaneGracza[playerid][gPLEC] == 0)
	{
		strdel(tekst_global, 0, 2048);
		SetPVarInt(playerid, "WybieraUbranie", 1);
		format(tekst_global, sizeof(tekst_global), "~r~~h~Zakup ubrania~n~~g~~h~Cena:~w~ $%d  ~g~~h~Ubranie:~w~ %d~n~W celu zakupu nacisnij ~y~~k~~VEHICLE_ENTER_EXIT~~w~.~n~W celu anulowania zakupu nacisnij ~y~~k~~PED_FIREWEAPON~~w~.",SkinPlayerM[SkinIDM[playerid]][cena4],SkinPlayerM[SkinIDM[playerid]][id4]);
		TextDrawSetString(OBJ[playerid], tekst_global);
		TextDrawShowForPlayer(playerid, OBJ[playerid]);
		SetPlayerSkin(playerid, SkinPlayerM[SkinIDM[playerid]][id4]);
		Frezuj(playerid,0);
   		SetPlayerCameraPos(playerid, Pos[0]-3,Pos[1],Pos[2]);
	  	SetPlayerCameraLookAt(playerid, Pos[0],Pos[1],Pos[2]);
		return 1;
	}
 	if(DaneGracza[playerid][gPLEC] == 1)
	{
		strdel(tekst_global, 0, 2048);
		SetPVarInt(playerid, "WybieraUbranie", 1);
		format(tekst_global, sizeof(tekst_global), "~r~~h~Zakup ubrania~n~~g~~h~Cena:~w~ $%d  ~g~~h~Ubranie:~w~ %d~n~W celu zakupu nacisnij ~y~~k~~VEHICLE_ENTER_EXIT~~w~.~n~W celu anulowania zakupu nacisnij ~y~~k~~PED_FIREWEAPON~~w~.",SkinPlayerM[SkinIDW[playerid]][cena4],SkinPlayerM[SkinIDW[playerid]][id4]);
		TextDrawSetString(OBJ[playerid], tekst_global);
		TextDrawShowForPlayer(playerid, OBJ[playerid]);
		SetPlayerSkin(playerid, SkinPlayerW[SkinIDW[playerid]][id4]);
		Frezuj(playerid,0);
		SetPlayerCameraPos(playerid, Pos[0]-3,Pos[1],Pos[2]);
	  	SetPlayerCameraLookAt(playerid, Pos[0],Pos[1],Pos[2]);
		return 1;
	}
	SetPlayerFacingAngle( playerid, 90 );
	return 1;
}
CMD:kup(playerid, params[])
{
	//printf("U¿yta komenda kup");
    if(zalogowany[playerid] == false) return 0;
	if(DaneGracza[playerid][gBW] != 0) return 0;
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0)
	{
		return 0;
	}
	if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0) return 0;
	new uid = NieruchomoscInfo[vw][nWlascicielD];
	if(GrupaInfo[uid][gTyp] != DZIALALNOSC_247)
	{
		return 0;
	}
	Magazyn(playerid, DIALOG_247_KUP, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}24/7{88b711}:", TYP_MAGAZYN, NieruchomoscInfo[vw][nWlascicielD], "Kup", "Zamknij");
	return 1;
}
CMD:ab(playerid, params[])
{
	//printf("U¿yta komenda ab");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(DaneGracza[playerid][gAdmGroup] == 4)
    {
	    new Float:x, Float:y, Float:z;
		if((flying[playerid] = !flying[playerid]))
		{
			SetPVarInt(playerid, "USetHP", 1);
		    GetPlayerPos(playerid, x, y, z);
		    Teleportuj(playerid, x, y, z+5);
		    UstawHP(playerid,1000000000);
		    SetTimerEx("AdminFly", 100, 0, "d", playerid);
		}
		else
		{
			SetPVarInt(playerid, "USetHP", 0);
		    GetPlayerPos(playerid, x, y, z);
		    Teleportuj(playerid, x, y, z+0.5);
		    ClearAnimations(playerid);
			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
		    UstawHP(playerid,100);
			return 1;
		}
	}
	return 1;
}
CMD:amaska(playerid,params[])
{
	//printf("U¿yta komenda amaska");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1)
    {
	    new chusta[10], find = -1, str[256];
		if(sscanf(params, "s[10]", chusta))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby sprawdziæ {88b711}maske nieznajomego{DEDEDE} wpisz: {88b711}/amaska [kod]", "Zamknij", "");
			return 1;
		}
		ForeachEx(i, IloscGraczy)
		{
			strtoupper(chusta);
		    if(ComparisonString(GM(KtoJestOnline[i]), chusta))
		    {
		        find = KtoJestOnline[i];
		        break;
		    }
		}
		if(find == -1)
		{
        	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Przepisany {88b711}kod{DEDEDE} jest nieprawid³owy.", "Zamknij", "");
			return 1;
		}
		format(str, sizeof(str), "Gracz: %s (ID: %d) KOD: %s", ImieGracza2(find), find, chusta);
		SendClientMessage(playerid, 0xFFFFFFFF, str);
	}
	return 1;
}
CMD:reload(playerid,params[])
{
	//printf("U¿yta komenda reload");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
	    new chusta;
		if(sscanf(params, "d", chusta))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}prze³adowaæ obiekty{DEDEDE} w budynku wpisz: {88b711}/reload [uid budynku]", "Zamknij", "");
			return 1;
		}
	    new str[256];
	    UnloadObject(chusta);
	    LoadObject(chusta);
		format(str, sizeof(str), "Przeladowa³eœ %d obiektów", reload);
		SendClientMessage(playerid, 0xFFFFFFFF, str);
		reload = 0;
	}
	return 1;
}
CMD:afotoradar(playerid,params[])
{
	//printf("U¿yta komenda afotoradar");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		dShowPlayerDialog(playerid,DIALOG_MAIN,DIALOG_STYLE_LIST,"{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Fotoradary{88b711}:","{DEDEDE}» {88b711}Stwórz fotoradar\n{DEDEDE}» {88b711}Edycja fotoradaru.\n{DEDEDE}» {88b711}Usuniêcie fotoradaru.","Akceptuj","Zamknij");
	}
	return 1;
}
CMD:asay(playerid, params[])
{
	//printf("U¿yta komenda asay");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new id;
	new tresc[80];
	if(DaneGracza[playerid][gAdmGroup] == 4)
	{
		if(sscanf(params, "ds[80]", id, tresc)) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}naœladowaæ gracza{DEDEDE} wpisz: {88b711}/asay [id gracza] [treœæ]", "Zamknij", "");
		if(zalogowany[id] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz naœladowaæ {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		OnPlayerText(id, tresc);
	}
	return 1;
}
CMD:ac(playerid, params[])
{
	//printf("U¿yta komenda ac");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] != 4 && DaneGracza[playerid][gAdmGroup] != 8 && DaneGracza[playerid][gAdmGroup] != 11 && DaneGracza[playerid][gAdmGroup] != 10)
	{
		return 1;
	}
	new info[126];
	if(sscanf(params, "s[126]", info)) dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na czacie {88b711}ekipy serwisu{DEDEDE} wpisz: {88b711}/ac [treœæ].", "Zamknij", "");
	else
	{
	    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
		{
		    format(info, sizeof(info), "[Administrator][ID: %d] %s: %s", playerid, ZmianaNicku(playerid), info);
		}
		else if(DaneGracza[playerid][gAdmGroup] == 11)
		{
			format(info, sizeof(info), "[GameMaster][ID: %d] %s: %s", playerid, ZmianaNicku(playerid), info);
		}
		else if(DaneGracza[playerid][gAdmGroup] == 10)
		{
			format(info, sizeof(info), "[Opiekun][ID: %d] %s: %s", playerid, ZmianaNicku(playerid), info);
		}
		ForeachEx(i, IloscGraczy)
		{
			if(DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 ||
			 DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8 ||
			 DaneGracza[KtoJestOnline[i]][gAdmGroup] == 11 ||
			 DaneGracza[KtoJestOnline[i]][gAdmGroup] == 10)
			{
                SendClientMessage(KtoJestOnline[i], 0xB4FF00FF, info);
			}
		}
	}
	return 1;
}
CMD:aac(playerid, params[])
{
	//printf("U¿yta komenda aac");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] != 4 && DaneGracza[playerid][gAdmGroup] != 8)
	{
		PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		return 1;
	}
	new infoe[126];
	if(sscanf(params, "s[126]", infoe)) dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pisaæ na czacie {88b711}zarz¹du serwisu{DEDEDE} wpisz: {88b711}/aac [treœæ].", "Zamknij", "");
	else
	{
		format(infoe, sizeof(infoe), "[AA CZAT][ID: %d] %s: %s", playerid, ZmianaNicku(playerid), infoe);
		ForeachEx(i, IloscGraczy)
		{
			if(DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 ||
			 DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8)
			{
				SendClientMessage(KtoJestOnline[i], 0xB4FF00FF, infoe);
			}
		}
	}
	return 1;
}
CMD:top(playerid, params[])
{
	//printf("U¿yta komenda top");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 6)) && DutyAdmina[playerid] == 1)
    {
	    new playerid2;
		if(sscanf(params, "i", playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}teleportowaæ{DEDEDE} siê do {88b711}pojazdu{DEDEDE} wpisz: {88b711}/top [uid pojazdu]", "Zamknij", "");
			return 1;
		}
		if(PojazdInfo[playerid2][pSpawn] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd do którego chcesz siê {88b711}teleportowaæ{DEDEDE} nie jest {88b711}zespawnowany{DEDEDE}.", "Zamknij", "");
			return 0;
		}
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(PojazdInfo[playerid2][pID], X, Y, Z);
		Teleportuj(playerid, X, Y, Z);
		SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(PojazdInfo[playerid2][pID]));
	}
	return 1;
}
CMD:too(playerid, params[])
{
	//printf("U¿yta komenda too");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8) && DutyAdmina[playerid] == 1)
    {
	    new playerid2;
		if(sscanf(params, "i", playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}teleportowaæ{DEDEDE} siê do {88b711}obiektu{DEDEDE} wpisz: {88b711}/too [uid obiektu]", "Zamknij", "");
			return 1;
		}
		Teleportuj(playerid, ObiektInfo[playerid2][objPozX]+2, ObiektInfo[playerid2][objPozY], ObiektInfo[playerid2][objPozZ]);
		SetPlayerVirtualWorld(playerid, ObiektInfo[playerid2][objvWorld]);
		SetPlayerInterior(playerid, ObiektInfo[playerid2][objInterior]);
	}
	return 1;
}
CMD:tod(playerid, params[])
{
	//printf("U¿yta komenda tod");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4  || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 7)) && DutyAdmina[playerid] == 1)
    {
	    new playerid2;
		if(sscanf(params, "i", playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}teleportowaæ{DEDEDE} siê do {88b711}drzwi{DEDEDE} wpisz: {88b711}/tod [uid drzwi]", "Zamknij", "");
			return 1;
		}
		SetPlayerVirtualWorld(playerid, NieruchomoscInfo[playerid2][nVW]);
		TogglePlayerSpectating(playerid, 0);
		SetCameraBehindPlayer(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), NieruchomoscInfo[playerid2][nX], NieruchomoscInfo[playerid2][nY], NieruchomoscInfo[playerid2][nZ]);
		}
		else
		{
			Teleportuj(playerid, NieruchomoscInfo[playerid2][nX], NieruchomoscInfo[playerid2][nY], NieruchomoscInfo[playerid2][nZ]);
		}
		SetPlayerVirtualWorld(playerid, NieruchomoscInfo[playerid2][nVW]);
		SetPlayerInterior(playerid, NieruchomoscInfo[playerid2][nINT]);
	}
	return 1;
}
CMD:tm(playerid, params[])
{
	//printf("U¿yta komenda tm");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || (DaneGracza[playerid][gAdmGroup] == 11 && DaneGracza[playerid][gAdmLVL] >= 5)) && DutyAdmina[playerid] == 1)
	{
	    new playerid2;
		if(sscanf(params, "i", playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}teleportowaæ{DEDEDE} gracza do {88b711}siebie{DEDEDE} wpisz: {88b711}/tm [id gracza]", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz teleportowaæ do siebie {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[playerid2][gAdmGroup] == 4 && DaneGracza[playerid][gAdmGroup] != 4)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz {88b711}uprawnieñ{DEDEDE} do teleportowania tego gracza do siebie.", "Zamknij", "");
			return 0;
		}
		new vw = GetPlayerVirtualWorld(playerid);
		SetPlayerVirtualWorld(playerid2, vw);
		new Float: x, Float: y, Float: z;
		new Float: x2, Float: y2, Float: z2, Float: a2;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerPos(playerid2, x2, y2, z2);
		GetPlayerFacingAngle(playerid2, a2);
		TogglePlayerSpectating(playerid2, 0);
		SetCameraBehindPlayer(playerid2);
		if(IsPlayerInAnyVehicle(playerid2))
		{
			SetVehiclePos(GetPlayerVehicleID(playerid2), x, y + 2, z);
		}
		else Teleportuj(playerid2, x, y + 2, z);
		SetPlayerVirtualWorld(playerid2, GetPlayerVirtualWorld(playerid));
		SetPlayerInterior(playerid2, GetPlayerInterior(playerid2));
		new przelew[124];
		format(przelew, sizeof(przelew), "[TM] Gracz: %s (ID:%d) teleportuje do siebie gracza: %s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2);
		KomunikatAdmin(1, przelew);
		//Transakcja(T_TM, DaneGracza[playerid][gUID], DaneGracza[playerid2][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid2][gGUID], -1, -1, -1, -1, "-", gettime()-CZAS_LETNI);
	}
	return 1;
}
CMD:to(playerid, params[])
{
	//printf("U¿yta komenda to");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1)
    {
	    new playerid2;
		if(sscanf(params, "i", playerid2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}teleportowaæ{DEDEDE} siê do {88b711}gracza{DEDEDE} wpisz: {88b711}/to [id gracza]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego chcesz siê teleportowaæ {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[playerid2][gAdmGroup] == 4 && DaneGracza[playerid][gAdmGroup] != 4)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz {88b711}uprawnieñ{DEDEDE} do teleportowania siê do tego gracza.", "Zamknij", "");
			return 0;
		}
		new vw = GetPlayerVirtualWorld(playerid2);
		SetPlayerVirtualWorld(playerid, vw);
		new Float: x, Float: y, Float: z;
		new Float: x2, Float: y2, Float: z2, Float: a2;
		GetPlayerPos(playerid2, x, y, z);
		GetPlayerPos(playerid, x2, y2, z2);
		GetPlayerFacingAngle(playerid, a2);
		TogglePlayerSpectating(playerid, 0);
		SetCameraBehindPlayer(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		}
		else
		{
			y+=2;
			Teleportuj(playerid, x, y, z);
		}
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid2));
		SetPlayerInterior(playerid, GetPlayerInterior(playerid2));
		new przelew[124];
		format(przelew, sizeof(przelew), "[TO] Gracz: %s (ID:%d) teleportuje siê do gracza: %s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2);
		KomunikatAdmin(1, przelew);
	}
	return 1;
}
CMD:opis(playerid, cmdtext[])
{
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new text[800], String[256];
	if(sscanf(cmdtext, "s[800]",text))
	{
	    //DestroyDynamic3DTextLabel(Text3D:Opisek[playerid]);
		//format(str, sizeof(str), "%s\n{ffffff}(%s)", str, dol);
		UpdateDynamic3DTextLabelText(DaneGracza[playerid][gOpisPostaci], 0xAAAAFFFF, "");
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby ustawiæ {88b711}opis swojej postaci{DEDEDE} wpisz: {88b711}/opis [treœæ]\nJeœli mia³eœ teraz ustawiony opis swojej postaci zosta³ w³aœnie usuniêty.", "Zamknij", "");
 		return 1;
	}
	if(GraczPremium(playerid))
	{
		A_KOL(text);
    	A_KOLS(text);
    }
	format(String, sizeof(String), "%s", text);
	new liczba = 30;
	for(new i = 0; i < strlen(String); i++)
	{
		if(i >= liczba && String[i] == ' ')
		{
			strins(String, "\n", i);
			liczba+=30;
		}
	}
    DestroyDynamic3DTextLabel(Text3D:Opisek[playerid]);
    new string[256];
    format(string, sizeof(string), "{DEDEDE}Opis twojej {88b711}postaci{DEDEDE} zosta³ ustawiony na:\n''%s{DEDEDE}''\nAby {88b711}usun¹æ opis{DEDEDE} swojej postaci wpisz: {88b711}/opis", text);
    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", string, "Zamknij", "");
    //TextDrawShowForPlayer(playerid,brudny);
	strdel(tekst_globals, 0, 2048);
	format(tekst_globals, sizeof(tekst_globals), "%s", String);
	UpdateDynamic3DTextLabelText(DaneGracza[playerid][gOpisPostaci], 0xAAAAFFFF, tekst_globals);
	//Opisek[playerid] = CreateDynamic3DTextLabel(String,0xAAAAFFFF,0.0,0.0,-0.6,7.0,playerid,INVALID_VEHICLE_ID,0,-1,-1,-1,100.0);
	return 1;
}
CMD:gmx(playerid, paramas[])
{
	//printf("U¿yta komenda gmx");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(DaneGracza[playerid][gAdmGroup] == 4)
    {
        if(ogmx == 0)
        {
	        ForeachEx(i, IloscGraczy)
			{
			    if(IsPlayerConnected(KtoJestOnline[i]) && DaneGracza[i][gUID] != 0)
				{
				    if(zalogowany[KtoJestOnline[i]] == true)
				    {
						if(impreza == 1)
						{
							impreza = 0;
							ForeachEx(a, IloscGraczy)
							{
								if(GetPVarInt(KtoJestOnline[a],"spawn"))
								{
									DeletePVar(KtoJestOnline[a],"spawn");
									StopAudioStreamForPlayer(KtoJestOnline[a]);
								}
							}
						}
						if(DaneGracza[KtoJestOnline[i]][gBW] == 0)
						{
							DaneGracza[KtoJestOnline[i]][gQS] = gettime()+600;
							GetPlayerPos(KtoJestOnline[i], DaneGracza[KtoJestOnline[i]][gX],DaneGracza[KtoJestOnline[i]][gY],DaneGracza[KtoJestOnline[i]][gZ]);
							DaneGracza[KtoJestOnline[i]][gVW] = GetPlayerVirtualWorld(KtoJestOnline[i]);
							DaneGracza[KtoJestOnline[i]][gINT] = GetPlayerInterior(KtoJestOnline[i]);
						}
						/*if(DaneGracza[KtoJestOnline[i]][gBronUID] != 0)
						{
							UsunBronieGracza(KtoJestOnline[i], PrzedmiotInfo[DaneGracza[KtoJestOnline[i]][gBronUID]][pWar1]);
							PrzedmiotInfo[DaneGracza[KtoJestOnline[i]][gBronUID]][pUzywany] = 0;
							ZapiszPrzedmiot(DaneGracza[KtoJestOnline[i]][gBronUID]);
							DaneGracza[KtoJestOnline[i]][gBronUID] = 0;
							DaneGracza[KtoJestOnline[i]][gBronAmmo] = 0;
							DeletePVar(KtoJestOnline[i], "UzywanaBron");
						}*/
				        if(DaneGracza[KtoJestOnline[i]][gSluzba] != 0)
						{
							ZapiszDuty(DaneGracza[KtoJestOnline[i]][gSluzba], KtoJestOnline[i], DutyNR[KtoJestOnline[i]]);
						}
				        ZapiszGracza(KtoJestOnline[i]);
						ZapiszBankKasa(KtoJestOnline[i]);
						ZapiszGraczaGlobal(KtoJestOnline[i], 1);
						//zalogowany[KtoJestOnline[i]] = false;
						CancelEdit(KtoJestOnline[i]);
						//ForeachEx(si, 30) SendClientMessage(KtoJestOnline[i], KOLOR, " ");
				    }
				}
			}
	    	ogmx = 15;
	    	Transakcja(T_GMX, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "GMX", gettime()-CZAS_LETNI);
    	}else{
    	    
    	}
    }
    return 1;
}
CMD:o(playerid, params[])
{
	//printf("U¿yta komenda o");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new	comm1[32], comm2[128];
	if(sscanf(params, "s[32]S()[128]", comm1, comm2))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}oferowaæ{DEDEDE} coœ graczu wpisz: {88b711}/o [pojazd, elektryke, blokade, mandat, przejazd, trening, tankowanie, dokument]", "Zamknij", "");
		return 1;
	}
	new vehicleid = GetPlayerVehicleID(playerid);
	new uid = SprawdzCarUID(vehicleid);
	if(!strcmp(comm1,"pojazd",true))
	{
	    new typ, war1;
		if(sscanf(comm2, "dd", typ, war1))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}pojazd{DEDEDE} graczu wpisz: {88b711}/o pojazd [id gracza] [cena]", "Zamknij", "");
			return 1;
		}
		if(!IsPlayerInAnyVehicle(playerid))
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}pojazd{DEDEDE} musisz siê w nim znajdowaæ.", "Zamknij", "");
	        return 0;
	    }
		if(PojazdInfo[uid][pOwnerDzialalnosc] != 0 || PojazdInfo[uid][pOwnerPostac] != DaneGracza[playerid][gUID])
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd, który chcesz {88b711}sprzedaæ{DEDEDE} musi nale¿eæ do Ciebie.", "Zamknij", "");
		    return 0;
		}
		if(PojazdInfo[uid][pAukcja] != 0)
		{
			GameTextForPlayer(playerid, "~r~Ten pojazd jest wystawiony na aukcji.", 3000, 5);
			return 0;
		}
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Oferuj(playerid, typ, 0, 0, uid, 0, OFEROWANIE_POJAZDU, war1, "", 0);
		Transakcja(T_OVEH, DaneGracza[playerid][gUID], DaneGracza[typ][gUID], DaneGracza[playerid][gGUID], DaneGracza[typ][gGUID], war1, uid, vehicleid, -1, "-", gettime()-CZAS_LETNI);
	}
	if(!strcmp(comm1,"wyrejestrowanie",true))
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYREJEJST))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie dzialalnosci.", 3000, 5);
			return 0;
		}
	    new uida, playerid2;
		if(sscanf(comm2, "dd", uida, playerid2))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}wyrejestrowanie{DEDEDE} pojazdu wpisz: {88b711}/o tablice [uid pojazdu] [id gracza]", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 0;
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ tablice{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ tablice{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 0;
		}
		if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
			return 0;
		}
		if(!WlascicielpojazduUID(uida, playerid2))
		{
			GameTextForPlayer(playerid, "~r~Ten gracz nie posiada uprawnien do tego pojazdu!", 3000, 5);
			return 0;
		}
		if(PojazdInfo[uida][pTablicaON] == 0)
		{
			GameTextForPlayer(playerid, "~r~Ten pojazd nie posiada tablic!", 3000, 5);
			return 0;
		}
		Oferuj(playerid, playerid2, uida, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_WYREJ, 50,"", 0);
	}
	if(!strcmp(comm1,"tablice",true))
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYD_DOK))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie dzialalnosci.", 3000, 5);
			return 0;
		}
	    new uids, playerid2;
		if(sscanf(comm2, "dd", uids, playerid2))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}tablice{DEDEDE} graczu wpisz: {88b711}/o tablice [uid pojazdu] [id gracza]", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 0;
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ tablice{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ tablice{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 0;
		}
		if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
			return 0;
		}
		if(!WlascicielpojazduUID(uids, playerid2))
		{
			GameTextForPlayer(playerid, "~r~Ten gracz nie posiada uprawnien do tego pojazdu!", 3000, 5);
			return 0;
		}
		if(PojazdInfo[uids][pTablicaON] != 0)
		{
			GameTextForPlayer(playerid, "~r~Ten pojazd posiada tablice badz zostaly juz wydane!", 3000, 5);
			return 0;
		}
		Oferuj(playerid, playerid2, uids, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_TABLIC, 200,"", 0);
	}
	if(!strcmp(comm1,"oplate",true))
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYD_DOK))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie dzialalnosci.", 3000, 5);
			return 0;
		}
	    new uids, playerid2;
		if(sscanf(comm2, "dd", uids, playerid2))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}op³ate budynku{DEDEDE} graczu wpisz: {88b711}/o oplate [uid budynku] [id gracza]", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 0;
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ op³ate budynku{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ op³ate budynku{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 0;
		}
		if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
			return 0;
		}
		if(!OtwieranieBudynku(uids, playerid2))
		{
			GameTextForPlayer(playerid, "~r~Ten gracz nie posiada uprawnien do tego budynku!", 3000, 5);
			return 0;
		}
		Oferuj(playerid, playerid2, uids, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_OPLATY, 200,"", 0);
	}
	if(!strcmp(comm1,"dzialalnosc",true))
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYD_DOK) || GrupaInfo[DaneGracza[playerid][gSluzba]][gOwnerUID] != DaneGracza[playerid][gUID])
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie dzialalnosci.", 3000, 5);
			return 0;
		}
	    new playerid2;
		strdel(tekst_global, 0, 1024);
		if(sscanf(comm2, "ds[1024]", playerid2, tekst_global))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}dzia³alnoœæ{DEDEDE} graczu wpisz: {88b711}/o dzialalnosc [id gracza] [nazwa]", "Zamknij", "");
			return 1;
		}
		if(strlen(tekst_global) > 20 || strlen(tekst_global) < 3)
		{
			GameTextForPlayer(playerid, "~r~Podana nazwa musi miec od 3 do 20 znakow.", 3000, 5);
			return 0;
		}
		if(playerid == playerid2) return 0;
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ dzia³alnoœæ{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ dzia³alnoœæ{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
			return 0;
		}
		if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
			return 0;
		}
		if((GraczPremium(playerid) && DaneGracza[playerid2][gDzialalnosc1] != 0 && DaneGracza[playerid2][gDzialalnosc2] != 0 && DaneGracza[playerid2][gDzialalnosc3] != 0 && DaneGracza[playerid2][gDzialalnosc4] != 0 && DaneGracza[playerid2][gDzialalnosc5] != 0 && DaneGracza[playerid2][gDzialalnosc6] != 0) || (!GraczPremium(playerid) && DaneGracza[playerid2][gDzialalnosc1] != 0 && DaneGracza[playerid2][gDzialalnosc2] != 0 && DaneGracza[playerid2][gDzialalnosc3] != 0))
		{
			GameTextForPlayer(playerid, "~r~Ten gracz ma zajete wszystkie sloty.", 3000, 5);
			return 1;
		}
		else
		{
			SetPVarInt(playerid, "IDDZGR", playerid2);
			SetPVarString(playerid, "NAZWADZST", tekst_global);
			dShowPlayerDialog(playerid, DIALOG_STWORZ_DZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}»  {88b711}Warsztat\n{DEDEDE}»  {88b711}24/7\n{DEDEDE}»  {88b711}Elektryka\n{DEDEDE}»  {88b711}Gastronomia\n{DEDEDE}»  {88b711}Hotel\n{DEDEDE}»  {88b711}Taxi\n{DEDEDE}»  {88b711}Si³ownia", "Wybierz", "Zamknij");
			return 1;
		}
	}
	if(!strcmp(comm1,"dokument",true))
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYD_DOK))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie dzialalnosci.", 3000, 5);
			return 0;
		}
	    new typ[124], playerid2;
		if(sscanf(comm2, "s[124]d", typ, playerid2))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}dokument{DEDEDE} graczu wpisz: {88b711}/o dokument [dowod, prawkoa, prawkob, broni, niekaralnosci, niepoczytalnosci, wedkarska] [id gracza]", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 0;
		strtolower(typ);
		if(ComparisonString(typ, "dowod") || ComparisonString(typ, "prawkoa") || ComparisonString(typ, "prawkob") || ComparisonString(typ, "broni") || ComparisonString(typ, "niekaralnosci") || ComparisonString(typ, "niepoczytalnosci") || ComparisonString(typ, "wedkarska"))
		{
			if(!PlayerObokPlayera(playerid, playerid2, 3))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ dokument{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
				return 1;
			}
			if(zalogowany[playerid2] == false)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ dokument{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
				return 0;
			}
			if(ComparisonString(typ, "dowod"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_DOWOD))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_DOWOD, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 50,"", 0);
				}
			}
			else if(ComparisonString(typ, "prawkoa"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_PRAWKO_A))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_PRAWKO_A, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 150,"", 0);
				}
			}
			else if(ComparisonString(typ, "prawkob"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_PRAWKO_B))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_PRAWKO_B, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 300,"", 0);
				}
			}
			else if(ComparisonString(typ, "wedkarska"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_RZADOWA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_WEDKARSKA))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_WEDKARSKA, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 100,"", 0);
				}
			}
			else if(ComparisonString(typ, "broni"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_POLICYJNA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_BRON))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_BRON, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 1500,"", 0);
				}
			}
			else if(ComparisonString(typ, "niekaralnosci"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_POLICYJNA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_NIEKARALNOSC))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_NIEKARALNOSC, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 500,"", 0);
				}
			}
			else if(ComparisonString(typ, "niepoczytalnosci"))
			{
				if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA)
				{
					if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_MEDYCZNA)
					{
						GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes w budynku dzialalnosci.", 3000, 5);
						return 0;
					}
					if(Dokument(playerid2, D_NIEPOCZYTALNOSC))
					{
						GameTextForPlayer(playerid, "~r~Ten gracz posiada juz taki dokument.", 3000, 5);
						return 0;
					}
					Oferuj(playerid, playerid2, D_NIEPOCZYTALNOSC, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_DOKUMENTU, 400,"", 0);
				}
			}
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}dokument{DEDEDE} graczu wpisz: {88b711}/o dokument [dowod, prawkoa, prawkob, broni, niekaralnosci, niepoczytalnosci, wedkarska] [id gracza]", "Zamknij", "");
		}
	}
	else if(!strcmp(comm1,"przejazd",true))
	{
		new playerid2,cena;
		if(sscanf(comm2, "ii", playerid2, cena))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}przejazd{DEDEDE} taksówk¹ graczu wpisz: {88b711}/o przejazd [id gracza] [cena]", "Zamknij", "");
		    return 1;
		}
		if(!IsPlayerInAnyVehicle(playerid))
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}przejazd taksówk¹{DEDEDE} musisz siê w nim znajdowaæ.", "Zamknij", "");
	        return 0;
	    }
		if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}przejazd taksówk¹{DEDEDE} musisz siê znajdowaæ za kierownic¹.", "Zamknij", "");
	        return 0;
	    }
		new vehids = GetPlayerVehicleID(playerid);
		new uipd = SprawdzCarUID(vehids);
		if(GrupaInfo[PojazdInfo[uipd][pOwnerDzialalnosc]][gTyp] != DZIALALNOSC_TAXI)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd nie nale¿y do dzia³alnoœci{88b711} taksówkarskiej{DEDEDE}.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
			return 0;
		}
		new uidg = DaneGracza[playerid][gSluzba];
		if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_TAXI)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
			return 0;
		}
		if(!UprawnienieNaSluzbie(playerid, 47))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 1;
		}
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ {88b711}przejazd taksówk¹{DEDEDE} nie znajduje siê obok ciebie.", "Zamknij", "");
			return 0;
		}
		if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(playerid2))
		{
			return 0;
		}
		Oferuj(playerid, playerid2, vehids, uidg, uipd, 0, OFEROWANIE_TAXI, cena, "", 0);
		return 1;
	}
	else if(!strcmp(comm1,"wypozycz",true))
	{
		new typ, war1;
		if(sscanf(comm2, "dd", typ, war1))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby wypo¿yczyæ {88b711}pojazd{DEDEDE} graczu wpisz: {88b711}/o wypozycz [id gracza] [czas (1-60 min)]", "Zamknij", "");
			return 1;
		}
		if(!IsPlayerInAnyVehicle(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby wypo¿yczyæ {88b711}pojazd{DEDEDE} musisz siê w nim znajdowaæ.", "Zamknij", "");
			return 0;
		}
		if(PojazdInfo[uid][pOwnerPostac] != 0 && PojazdInfo[uid][pOwnerPostac] != DaneGracza[playerid][gUID])
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd, który chcesz {88b711}wypo¿yczyæ{DEDEDE} musi nale¿eæ do Ciebie.", "Zamknij", "");
			return 0;
		}
		if(PojazdInfo[uid][pOwnerDzialalnosc] != 0 && GrupaInfo[PojazdInfo[uid][pOwnerDzialalnosc]][gTyp] != DZIALALNOSC_WYPOZYCZALNIA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Pojazd, który chcesz {88b711}wypo¿yczyæ{DEDEDE} musi nale¿eæ do wypo¿yczalni pojazdów.", "Zamknij", "");
			return 0;
		}
		if(PojazdInfo[uid][pOwnerPostac] != 0 && PojazdInfo[uid][pOwnerPostac] == DaneGracza[playerid][gUID])
		{
			GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
			Oferuj(playerid, typ, 0, 0, uid, 0, OFEROWANIE_WYPOZYCZENIE, war1, "", 0);
			return 0;
		}
		else if(PojazdInfo[uid][pOwnerDzialalnosc] != 0 && GrupaInfo[PojazdInfo[uid][pOwnerDzialalnosc]][gTyp] == DZIALALNOSC_WYPOZYCZALNIA)
		{
			if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_WYPOZYCZANIE_POJ))
			{
				GameTextForPlayer(playerid, "~r~Brak uprawnieni do wypozyczania pojazdow, badz nie jestes na sluzbie dzialalnosci!", 3000, 5);
				return 0;
			}
			if(PojazdInfo[uid][pOwnerDzialalnosc] != DaneGracza[playerid][gSluzba])
			{
				GameTextForPlayer(playerid, "~r~Ten pojazd nie nalezy do twojej dzialalnosci!", 3000, 5);
				return 0;
			}
			GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
			Oferuj(playerid, typ, 0, 0, uid, 0, OFEROWANIE_WYPOZYCZENIE, war1, "", 0);
			return 0;
		}
	}
	else if(!strcmp(comm1,"paintjob",true))
	{
	    new playerid2, kolor1, cena;
		if(sscanf(comm2, "idd", playerid2, kolor1, cena))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}paintjob{DEDEDE} graczu wpisz: {88b711}/o paintjob [id gracza] [0-3] [cena]", "Zamknij", "");
			return 1;
		}
		if(kolor1 > 3 || kolor1 < 0) return 0;
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
		if(!MontazItemow(playerid, vw))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(!GraczaMaTypPrzedmiotuWu(playerid, 1, 41))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ graczu {88b711}lakierowanie{DEDEDE} pojazdu musisz trzymaæ w rêce opryskiwacz.", "Zamknij", "");
			return 0;
		}
		if(NaprawiaCzas[playerid] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}naprawiasz{DEDEDE} ju¿ jakiœ pojazd.", "Zamknij", "");
			return 0;
		}
		if(LakierujeCzas[playerid] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}lakierujesz{DEDEDE} ju¿ jakiœ pojazd.", "Zamknij", "");
			return 0;
		}
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ {88b711}malowanie pojazdu{DEDEDE} nie znajduje siê obok ciebie.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(playerid2))
		{
		    return 0;
		}
		if(!Wlascicielpojazdu(GetPlayerVehicleID(playerid2), playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w³aœcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
			return 0;
		}
		new uidss = SprawdzCarUID(GetPlayerVehicleID(playerid2));
		Oferuj(playerid, playerid2, DaneGracza[playerid][gSluzba], GetPlayerVehicleID(playerid2), kolor1, 0, OFEROWANIE_PJ, cena, "", uidss);
		return 1;
	}
	else if(!strcmp(comm1,"lakierowanie",true))
	{
	    new playerid2, kolor1, kolor2, cena;
		if(sscanf(comm2, "iddd", playerid2, kolor1, kolor2, cena))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}lakierowanie{DEDEDE} graczu wpisz: {88b711}/o lakierowanie [id gracza] [kolor 1] [kolor 2] [cena]", "Zamknij", "");
			return 1;
		}
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 0)
		{
			return 0;
		}
		if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
		if(!MontazItemow(playerid, vw))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(!GraczaMaTypPrzedmiotuWu(playerid, 1, 41))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ graczu {88b711}lakierowanie{DEDEDE} pojazdu musisz trzymaæ w rêce opryskiwacz.", "Zamknij", "");
			return 0;
		}
		if(NaprawiaCzas[playerid] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}naprawiasz{DEDEDE} ju¿ jakiœ pojazd.", "Zamknij", "");
			return 0;
		}
		if(LakierujeCzas[playerid] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}lakierujesz{DEDEDE} ju¿ jakiœ pojazd.", "Zamknij", "");
			return 0;
		}
		if(!PlayerObokPlayera(playerid, playerid2, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ {88b711}malowanie pojazdu{DEDEDE} nie znajduje siê obok ciebie.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(playerid2))
		{
		    return 0;
		}
		if(!Wlascicielpojazdu(GetPlayerVehicleID(playerid2), playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w³aœcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
			return 0;
		}
		new uidss = SprawdzCarUID(GetPlayerVehicleID(playerid2));
		Oferuj(playerid, playerid2, DaneGracza[playerid][gSluzba], GetPlayerVehicleID(playerid2), kolor1, kolor2, OFEROWANIE_LAKIEROWANIA, cena, "", uidss);
		return 1;
	}///amt 0 100 Mistral 74 0 0xFF88b711 0 1 (220022)Five*(000000)Boxton*Crips
	else if(!strcmp(comm1,"mandat",true))
	{
		if(!NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 36))
		{
			return 0;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie jesteœ na {88b711}s³u¿bie{DEDEDE} odpowiedniej dzia³alnoœci!", "Zamknij", "");
			return 0;
		}
		if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] != DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie jesteœ na {88b711}s³u¿bie{DEDEDE} odpowiedniej dzia³alnoœci!", "Zamknij", "");
			return 0;
		}
		/*new vw = GetPlayerVirtualWorld(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehids = GetPlayerVehicleID(playerid);
			new uipd = SprawdzCarUID(vehids);
			if(GrupaInfo[PojazdInfo[uipd][pOwnerDzialalnosc]][gTyp] != DZIALALNOSC_POLICYJNA)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd nie nale¿y do {88b711}Police Departament{DEDEDE}.", "Zamknij", "");
				return 0;
			}
		}
		else
		{
			if(GrupaInfo[NieruchomoscInfo[vw][nWlascicielD]][gTyp] != DZIALALNOSC_POLICYJNA)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz siê w budynku który nale¿y do {88b711}Police Departament{DEDEDE}.", "Zamknij", "");
				return 0;
			}
		}*/
	    new id, cena, pkt, powod[256];
		if(sscanf(comm2, "ddds[256]", id, cena, pkt, powod))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ graczu {88b711}mandat{DEDEDE} wpisz: {88b711}/o mandat [id gracza] [cena] [pkt karne] [powód]", "Zamknij", "");
			return 1;
		}
		if(cena <= 0) return 1;
		if(pkt < 0) return 1;
		if(playerid == id) return 1;
		if(!PlayerObokPlayera(playerid, id, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ {88b711}mandat{DEDEDE} nie znajduje siê obok ciebie.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[id] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ mandat {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		Oferuj(playerid, id, DaneGracza[playerid][gSluzba], pkt, 0, 0, OFEROWANIE_MANDATU, cena, powod, 0);
		Transakcja(T_OMANDAT, DaneGracza[playerid][gUID], DaneGracza[id][gUID], DaneGracza[playerid][gGUID], DaneGracza[id][gGUID], cena, pkt, -1, -1, powod, gettime()-CZAS_LETNI);
	}
	else if(!strcmp(comm1,"blokade",true))
	{
		if(!NalezyDoDziZUp(playerid, DZIALALNOSC_POLICYJNA, 27))
		{
			return 0;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie jesteœ na {88b711}s³u¿bie{DEDEDE} odpowiedniej dzia³alnoœci!", "Zamknij", "");
			return 0;
		}
		if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] != DZIALALNOSC_POLICYJNA)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie jesteœ na {88b711}s³u¿bie{DEDEDE} odpowiedniej dzia³alnoœci!", "Zamknij", "");
			return 0;
		}
	    new id;
		if(sscanf(comm2, "d", id))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ graczu {88b711}zdjêcie blokady{DEDEDE} wpisz: {88b711}/o blokade [id gracza]", "Zamknij", "");
			return 1;
		}
		if(playerid == id) return 1;
		if(!PlayerObokPlayera(playerid, id, 3))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ {88b711}zdjêcie blokady{DEDEDE} nie znajduje siê obok ciebie.", "Zamknij", "");
			return 1;
		}
		if(!IsPlayerInAnyVehicle(id))
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz oferowaæ {88b711}zdjêcie blokady{DEDEDE} nie znajduje siê w pojezdzie..", "Zamknij", "");
	        return 0;
	    }
		if(!Wlascicielpojazdu(GetPlayerVehicleID(id), id))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w³aœcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
			return 0;
		}
		new vehicleids = GetPlayerVehicleID(id);
		new uids = SprawdzCarUID(vehicleids);
		Oferuj(playerid, id, DaneGracza[playerid][gSluzba], uids, 0, 0, OFEROWANIE_BLOKADY, PojazdInfo[uids][pBlokada], "", 0);
		Transakcja(T_OBLOKADE, DaneGracza[playerid][gUID], DaneGracza[id][gUID], DaneGracza[playerid][gGUID], DaneGracza[id][gGUID], PojazdInfo[uids][pBlokada], uids, -1, -1, "", gettime()-CZAS_LETNI);
	}
	else if(!strcmp(comm1,"elektryke",true))
	{
	    new typ, war1, war2;
		if(sscanf(comm2, "ddd", typ, war1, war2))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ graczu {88b711}monta¿ elektryki{DEDEDE} wpisz: {88b711}/o elektryke [id gracza] [cena] [czas]", "Zamknij", "");
			return 1;
		}
		new uids = GetPVarInt(typ, "uiddrzwi");
		if(zalogowany[typ] == false)
		{
			return 0;
		}
		if(GetPlayerVirtualWorld(playerid) == 0)
	    {
	         return 0;
	    }
		if(OwnerDzialalnosci(uids, typ) || (NieruchomoscInfo[uids][nWlascicielP] == DaneGracza[typ][gUID] && NieruchomoscInfo[uids][nWlascicielD] == 0))
		{
			if(!MontowanieElektryki(playerid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie masz uprawnieñ do {88b711}zarz¹dzania{DEDEDE} instalacjami elektrycznymi, b¹dz nie jesteœ na s³u¿bie", "Zamknij", "");
				return 0;
			}
			GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
			Oferuj(playerid, typ, DaneGracza[playerid][gSluzba], 0, war2, GetPlayerVirtualWorld(playerid), OFEROWANIE_ELEKTRYKI, war1, "", 0);
			Transakcja(T_OBLOKADE, DaneGracza[playerid][gUID], DaneGracza[typ][gUID], DaneGracza[playerid][gGUID], DaneGracza[typ][gGUID], war1, war2, GetPlayerVirtualWorld(playerid), -1, "", gettime()-CZAS_LETNI);
			return 1;
		}
	}
	else if(!strcmp(comm1,"wyscig",true))
	{
	    new id;
		if(!UprawnienieNaSluzbie(playerid, U_ZAP_DOL_WYSCIGU))
		{
			return 0;
		}
		if(sscanf(comm2, "d", id))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zaprosic gracza {88b711}do wyœcigu{DEDEDE} wpisz: {88b711}/o wyscig [id gracza]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[id] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do wyœcigu, {88b711}nie jest{DEDEDE} zalogowany.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gWyscig] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie nale¿ysz {88b711}do ¿adnego{DEDEDE} wyœcigu.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[id][gWyscig] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz {88b711}uczestniczy{DEDEDE} ju¿ w jakimœ wyœcigu.", "Zamknij", "");
			return 0;
		}
		if(!IsPlayerInAnyVehicle(id) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz {88b711}nie znajduje{DEDEDE} siê w pojeŸdzie, b¹dz nie jest jego kierownic¹", "Zamknij", "");
	        return 0;
	    }
		Oferuj(playerid, id, DaneGracza[playerid][gWyscig], 0, 0, 0, OFEROWANIE_WYSCIG, 0,"", 0);
	}
	else if(!strcmp(comm1,"tankowanie",true))
	{
	    new id, litry, typ;
		if(zalogowany[playerid] == false)
		{
			return 0;
		}
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw != 0)
		{
			return 0;
		}
		if(DaneGracza[playerid][gBW] != 0)
		{
			return 0;
		}
		if(DaneGracza[playerid][gPracaTyp] != PRACA_TANKER)
		{
			return 0;
		}
		if(sscanf(comm2, "ddd", id, typ, litry))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ graczu {88b711}tankowanie{DEDEDE} pojazdu wpisz: {88b711}/o tankowanie [id gracza] [typ (1 - Diesel, 2 - Benzyna)] [iloœæ litrów (Aby zatankowaæ do pe³na wpisz: 100)]", "Zamknij", "");
			return 1;
		}
		if(typ != 1 && typ != 2)
		{
			GameTextForPlayer(playerid, "~r~Niepoprawny typ paliwa!", 3000, 5);
			return 0;
		}
		if(!PrzyObiekcie(playerid, 3465, 5))
		{
			GameTextForPlayer(playerid, "~r~Jestes zbyt daleko od dystrybutora!", 3000, 5);
			return 0;
		}
		new vec = GetPlayerVehicleID(id);
		new vehc = SprawdzCarUID(vec);
		if(!IsPlayerInAnyVehicle(id))
		{
			GameTextForPlayer(playerid, "~r~Gracz, ktoremu oferujesz tankowanie nie znajduje sie w pojezdzie!", 3000, 5);
			return 0;
		}
		if(litry <= 0 || (litry+PojazdInfo[vehc][pPaliwo]) > PaliwoIlosc(PojazdInfo[vehc][pModel]))
		{
			GameTextForPlayer(playerid, "~r~Niepoprawna ilosc litrow!", 3000, 5);
			return 0;
		}
		if(!Wlascicielpojazdu(vec, id))
		{
			GameTextForPlayer(playerid, "~r~Ten gracz nie posiada uprawnien do tego pojazdu!", 3000, 5);
			return 1;
		}
		if(PojazdInfo[vehc][pSilnik]==1)
		{
			GameTextForPlayer(playerid, "~r~Pojazd ktory chcesz zatankowac ma zapalony silnik!", 3000, 5);
			return 0;
		}
		if(typ == 1 || typ == 2)
		{
			new litrys;
			new litryow = floatround(PojazdInfo[vehc][pPaliwo]);
			if(litryow + litry >= PaliwoIlosc(PojazdInfo[vehc][pModel]))
			{
				litrys = PaliwoIlosc(PojazdInfo[vehc][pModel]);
			}
			else
			{
				litrys = litry+litryow;
			}
			Oferuj(playerid, id, vehc, litrys, litrys, 0, OFEROWANIE_TANKOWANIA, litrys,"", 0);
		}
	}
	else if(!strcmp(comm1,"wywiad",true))
	{
	    new id;
		if(!UprawnienieNaSluzbie(playerid, U_WYWIAD))
		{
			return 0;
		}
		if(sscanf(comm2, "d", id))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby przeprowadziæ z graczem {88b711}wywiad{DEDEDE} wpisz: {88b711}/o wywiad [id gracza]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[id] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do wywiadu, {88b711}nie jest{DEDEDE} zalogowany.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gWywiad] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie prowadzisz{88b711}wywiad{DEDEDE}, aby go zakoñczyæ wpisz: {88b711}/wywiad zakoncz.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[id][gWywiad] != 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz, któremu oferujesz {88b711}wywiad{DEDEDE} aktualnie uczestniczy ju¿ w wywiadzie.", "Zamknij", "");
			return 0;
		}
		Oferuj(playerid, id, 0, 0, 0, 0, OFEROWANIE_WYWIAD, 0,"", 0);
	}
	else if(!strcmp(comm1,"sztukawalki",true))
	{
	    new id, vw = GetPlayerVirtualWorld(playerid), cena, sztuka[124], typ;
		if(vw == 0)
		{
			return 0;
		}
		if(!UprawnienieNaSluzbie(playerid, U_KARNETY))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie jesteœ na s³u¿bie odpowiedniej dzia³alnoœæi, b¹dŸ {88b711}nie posiadasz{DEDEDE} uprawnieñ do oferowania sztuki walki.", "Zamknij", "");
			return 1;
		}
		if(NieruchomoscInfo[vw][nWlascicielD] != DaneGracza[playerid][gSluzba])
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz sie w {88b711}budynku{DEDEDE} si³owni.", "Zamknij", "");
			return 1;
		}
		if(sscanf(comm2, "ds[124]d", id, sztuka, cena))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ sztuke walki {88b711}graczu{DEDEDE} wpisz: {88b711}/o sztukawalki [id gracza] [box, kungfu, kravmaga] [cena]", "Zamknij", "");
			return 1;
		}
		strtolower(sztuka);
		if(ComparisonString(sztuka, "box") || ComparisonString(sztuka, "kungfu") || ComparisonString(sztuka, "kravmaga"))
		{
			if(cena < 120 && cena > 300)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Cena karnetu nie mo¿e byæ mniejsza ni¿ {88b711}120${DEDEDE} oraz wiêksza ni¿ {88b711}300${DEDEDE}.", "Zamknij", "");
				return 1;
			}
			if(zalogowany[id] == false)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz sztuke walki {88b711}nie jest{DEDEDE} zalogowany.", "Zamknij", "");
				return 0;
			}
			if(DaneGracza[id][gOstatniTrening] > gettime())
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz sztuke walki, musi odczekaæ {88b711}12 godzin{DEDEDE} od poprzedniego treningu.", "Zamknij", "");
				return 1;
			}
			if(DaneGracza[id][gZDROWIE] < 80)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz sztuke walki, nie ma wystarczaj¹cêj iloœci energi {88b711}(minimum 80 HP){DEDEDE} na kolejny trening.", "Zamknij", "");
				return 1;
			}
			if(DaneGracza[id][gGlod] < 54)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz sztuke walki, jest zbyt s³aby {88b711}(minimum 50% paska glodu){DEDEDE} na kolejny trening.", "Zamknij", "");
				return 1;
			}
			if(DaneGracza[id][gSILA] < 3200)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz sztuke walki, jest zbyt s³aby {88b711}(minimum 3200j si³y){DEDEDE} na kolejny trening.", "Zamknij", "");
				return 1;
			}
			if(ComparisonString(sztuka, "box")) typ = 5;
			if(ComparisonString(sztuka, "kungfu")) typ = 6;
			if(ComparisonString(sztuka, "kravmaga")) typ = 7;
			Oferuj(playerid, id, DaneGracza[playerid][gSluzba], typ, 0, 0, OFEROWANIE_SZTUKEWALKI, cena,"", 0);
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz karnet, jest zbyt s³aby {88b711}(minimum 50% paska glodu){DEDEDE} na kolejny trening.", "Zamknij", "");
		}
	}
	else if(!strcmp(comm1,"karnet",true))
	{
	    new id, vw = GetPlayerVirtualWorld(playerid), cena;
		if(vw == 0)
		{
			return 0;
		}
		if(!UprawnienieNaSluzbie(playerid, U_KARNETY))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie jesteœ na s³u¿bie odpowiedniej dzia³alnoœæi, b¹dŸ {88b711}nie posiadasz{DEDEDE} uprawnieñ do oferowania karnetów.", "Zamknij", "");
			return 1;
		}
		if(NieruchomoscInfo[vw][nWlascicielD] != DaneGracza[playerid][gSluzba])
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie znajdujesz sie w {88b711}budynku{DEDEDE} si³owni.", "Zamknij", "");
			return 1;
		}
		if(sscanf(comm2, "dd", id, cena))
		{
            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ karnet {88b711}graczu{DEDEDE} wpisz: {88b711}/o karnet [id gracza] [cena]", "Zamknij", "");
			return 1;
		}
		if(cena < 5 && cena > 50)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Cena karnetu nie mo¿e byæ mniejsza ni¿ {88b711}5${DEDEDE} oraz wiêksza ni¿ {88b711}50${DEDEDE}.", "Zamknij", "");
			return 1;
		}
		if(zalogowany[id] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz karnet {88b711}nie jest{DEDEDE} zalogowany.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[id][gOstatniTrening] > gettime())
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz karnet, musi odczekaæ {88b711}12 godzin{DEDEDE} od poprzedniego treningu.", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[id][gZDROWIE] < 80)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz karnet, nie ma wystarczaj¹cêj iloœci energi {88b711}(minimum 80 HP){DEDEDE} na kolejny trening.", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[id][gGlod] < 54)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu oferujesz karnet, jest zbyt s³aby {88b711}(minimum 50% paska glodu){DEDEDE} na kolejny trening.", "Zamknij", "");
			return 1;
		}
		Oferuj(playerid, id, DaneGracza[playerid][gSluzba], 0, 0, 0, OFEROWANIE_KARNET, cena,"", 0);
	}
	return 1;
}
stock GetClosestVehicleTow(playerid){
if (!IsPlayerConnected(playerid))return -1;new Float:Prevdist = 10.000,Prevcar;
for(new carid = 0; carid < MAX_VEHICLES; carid++) {
new Float:Dist = GetDistanceToCar(playerid,carid);
if ((Dist < Prevdist && GetPlayerVehicleID(playerid) != carid)) {Prevdist = Dist;Prevcar = carid;}
}
return Prevcar;
}

stock GetDistanceToCar(playerid,carid){
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:Dis;
if (!IsPlayerConnected(playerid))return -1;
GetPlayerPos(playerid,x1,y1,z1);GetVehiclePos(carid,x2,y2,z2);
Dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
return floatround(Dis);}

stock GetDistanceToTag(playerid,carid)
{
	new Float:x1,Float:y1,Float:z1,Float:Dis;
	if (!IsPlayerConnected(playerid))return -1;
	GetPlayerPos(playerid,x1,y1,z1);
	Dis = floatsqroot(floatpower(floatabs(floatsub(ObiektInfo[carid][objPozX],x1)),2)+floatpower(floatabs(floatsub(ObiektInfo[carid][objPozY],y1)),2)+floatpower(floatabs(floatsub(ObiektInfo[carid][objPozZ],z1)),2));
	return floatround(Dis);
}

stock IsPlayerFacingVehicle(playerid,vehicleid)
{

	new Float:Xv,Float:fY,Float:pqZ,Float:Xf,Float:Y,Float:Z,Float:ang;

	if(!IsPlayerConnected(playerid)) return 0;

	GetVehiclePos(vehicleid, Xf, Y, Z);
	GetPlayerPos(playerid, Xv, fY, pqZ);

	if( Y > fY ) ang = (-acos((Xf - Xv) / floatsqroot((Xf - Xv)*(Xf - Xv) + (Y - fY)*(Y - fY))) - 90.0);
	else if( Y < fY && Xf < Xv ) ang = (acos((Xf - Xv) / floatsqroot((Xf - Xv)*(Xf - Xv) + (Y - fY)*(Y - fY))) - 450.0);
	else if( Y < fY ) ang = (acos((Xf - Xv) / floatsqroot((Xf - Xv)*(Xf - Xv) + (Y - fY)*(Y - fY))) - 90.0);

	if(Xf > Xv) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);
	new Float:russia;
	GetPlayerFacingAngle(playerid,russia);
	if(ang-russia<-130 || ang-russia>130) return 0;
	else return 1;
}///amt 0 100 Mistral 74 0 0xFF88b711 0 1 (220022)Five*(000000)Boxton*Crips
stock IsPlayerFacingTag(playerid,vehicleid)
{

	new Float:aaX,Float:aaY,Float:pqZ,Float:X,Float:Y,Float:ang;
	if(!IsPlayerConnected(playerid)) return 0;
	X = ObiektInfo[vehicleid][objPozX];
	Y = ObiektInfo[vehicleid][objPozY];
	GetPlayerPos(playerid, aaX, aaY, pqZ);
	if( Y > aaY ) ang = (-acos((X - aaX) / floatsqroot((X - aaX)*(X - aaX) + (Y - aaY)*(Y - aaY))) - 90.0);
	else if( Y < aaY && X < aaX ) ang = (acos((X - aaX) / floatsqroot((X - aaX)*(X - aaX) + (Y - aaY)*(Y - aaY))) - 450.0);
	else if( Y < aaY ) ang = (acos((X - aaX) / floatsqroot((X - aaX)*(X - aaX) + (Y - aaY)*(Y - aaY))) - 90.0);
	if(X > aaX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);
	new Float:russia;
	GetPlayerFacingAngle(playerid,russia);
	if(ang-russia<-130 || ang-russia>130) return 0;
	else return 1;
}
CMD:qs(playerid, params[])
{
	//printf("U¿yta komenda qs");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podczas {88b711}BW{DEDEDE} nie mo¿esz korzystaæ z tej komendy!", "Zamknij", "");
	    return 1;
	}
	DaneGracza[playerid][gQS] = gettime()+600;
	GetPlayerPos(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
	DaneGracza[playerid][gVW] = GetPlayerVirtualWorld(playerid);
	DaneGracza[playerid][gINT] = GetPlayerInterior(playerid);
	new Float:Pose[3];
	GetPlayerPos(playerid,Pose[0],Pose[1],Pose[2]);
	new sstr[124];
	format(sstr,sizeof(sstr),"%s\n(/qs)",ZmianaNicku(playerid));
	Transakcja(T_WYSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "QS", gettime()-CZAS_LETNI);
	NapisWyszedl[playerid]=CreateDynamic3DTextLabel(sstr,0xDEDEDECC,Pose[0],Pose[1],Pose[2],10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,-1,-1,-1,10.0);
	Kick(playerid);
	return 1;
}
CMD:przedmioty(playerid,cmdtext[]) return cmd_p(playerid, cmdtext);
CMD:u(playerid,cmdtext[]) return cmd_p(playerid, cmdtext);
CMD:cb(playerid, params[])
{
	//printf("U¿yta komenda cb");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
    {
        return 0;
    }
	if(!IsPlayerInAnyVehicle(playerid))
	{
		return 0;
	}
	new	comm1[256], comm2[256];
	if(sscanf(params, "s[256]S()[256]", comm1, comm2))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby rozmawiaæ przez {88b711}CB - radio{DEDEDE} wpisz: {88b711}/cb [treœæ] {DEDEDE}b¹dz{88b711} /cb kanal [1-1000]", "Zamknij", "");
	    return 1;
	}
	else if(!strcmp(comm1,"kanal",true))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new uid = SprawdzCarUID(vehicleid);
		    if(!Wlascicielpojazdu(vehicleid, playerid))
			{
       			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
				return 1;
			}
			if(PojazdInfo[uid][pCB] == 0)
			{
				GameTextForPlayer(playerid, "~r~W pojezdzie nie ma CB-radia.", 3000, 5);
				return 0;
			}
			new kanal;
			if(sscanf(comm2, "d", kanal))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zmieniæ {88b711}kana³{DEDEDE} wpisz: {88b711}/cb kanal [1-1000]", "Zamknij", "");
				return 1;
			}
			if(kanal < 1 || kanal > 1000)
			{
				return 0;
			}
			PojazdInfo[uid][pKanal] = kanal;
			new kanstr[124];
			format(kanstr, sizeof(kanstr), "{DEDEDE}Kana³ zmieniony na: {88b711}%d", PojazdInfo[uid][pKanal]);
			SendClientMessage( playerid, SZARY, kanstr);
			ZapiszPojazd(uid, 1);
        }
		return 1;
	}
	else
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new uid = SprawdzCarUID(vehicleid);
		    if(!Wlascicielpojazdu(vehicleid, playerid))
			{
       			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
				return 1;
			}
			if(PojazdInfo[uid][pCB] == 0)
			{
				GameTextForPlayer(playerid, "~r~W pojezdzie nie ma CB-radia.", 3000, 5);
				return 0;
			}
			if(PojazdInfo[uid][pKanal] == 0)
			{
				GameTextForPlayer(playerid, "~r~Aby uzywac CB-radia musisz ustawic kanal.", 3000, 5);
				return 0;
			}
			new kanstr[256];
			ForeachEx(i, MAX_VEH)
			{
				if(PojazdInfo[i][pKanal] == PojazdInfo[uid][pKanal] && PojazdInfo[i][pKanal] != 0)
				{
					for(new is=0; is< IloscGraczy; is++)
					{
						if(GetPlayerVehicleID(KtoJestOnline[is]) == PojazdInfo[i][pID])
						{
							format(kanstr, sizeof(kanstr), "{88b711}CB %s: {DEDEDE}%s", ZmianaNicku(playerid), comm1);
							SendClientMessage(KtoJestOnline[is], SZARY, kanstr);
						}
					}
				}
			}
		}
	}
	return 1;
}

CMD:p(playerid, params[])
{
	//printf("U¿yta komenda p");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new	comm1[32], comm2[128];
	if(sscanf(params, "s[32]S()[128]", comm1, comm2))
	{
	    Przedmioty(playerid, playerid, DIALOG_PRZEDZMIOTY, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Przedmioty{88b711}:", TYP_WLASCICIEL, 0);
		return 1;
	}
	else if(!strcmp(comm1,"podnies",true))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
		new uid = SprawdzCarUID(vehicleid);
	    if(IsPlayerInAnyVehicle(playerid))
		{
		    if(!WlascicielpojazduBezWYP(vehicleid, playerid))
			{
       			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
				return 1;
			}
            Przedmioty(playerid, playerid, DIALOG_PRZEDZMIOTY_PODNIES_VEH, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Przedmioty{88b711}» {FFFFFF}Pojazd{88b711}:", TYP_AUTO, uid);
		}
	    else Przedmioty(playerid, playerid, DIALOG_PRZEDZMIOTY_PODNIES, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Przedmioty{88b711}» {FFFFFF}Ulica{88b711}:", TYP_ULICA, 0);
		return 1;
	}
	else
	{
	    ForeachEx(i, MAX_PRZEDMIOT)
		{
			if(PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pUID] != 0 && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL && strfind(PrzedmiotInfo[i][pNazwa], comm1, true) >= 0)
			{
				SetPVarInt( playerid, "UzytyItem", PrzedmiotInfo[i][pUID]);
				UzywanieItemu(playerid, PrzedmiotInfo[i][pUID]);
				break;
			}
		}
	}
	return 1;
}
CMD:pokaz(playerid, params[])
{
	//printf("U¿yta komenda pokaz");
    if(zalogowany[playerid] == false)
    {
        return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new	comm1[32], comm2[128];
	if(sscanf(params, "s[32]S()[128]", comm1, comm2))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby coœ {88b711}pokazaæ{DEDEDE} graczu wpisz: {88b711}/pokaz [identyfikator (skrót: id), dowod, prawko, przedmioty, broni, niepoczytalnosci, niekaralnosci, wedkarska]", "Zamknij", "");
		return 1;
	}
	else if(!strcmp(comm1,"id",true) || !strcmp(comm1,"identyfikator",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu {88b711}identyfikator{DEDEDE} wpisz: {88b711}/pokaz identyfikator [id gracza]", "Zamknij", "");
			return 1;
		}
		if(DaneGracza[playerid][gDzialalnosc1] == 0 &&
		DaneGracza[playerid][gDzialalnosc2] == 0 &&
		DaneGracza[playerid][gDzialalnosc3] == 0 &&
		DaneGracza[playerid][gDzialalnosc4] == 0 &&
		DaneGracza[playerid][gDzialalnosc5] == 0 &&
		DaneGracza[playerid][gDzialalnosc6] == 0)
		{
			GameTextForPlayer(playerid, "~r~Nie pracujesz w zadnej dzialalnosci gospodarczej.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new dz[512];
		if(DaneGracza[playerid][gDzialalnosc1] != 0) format(dz, sizeof(dz), "%s\n1.\t{DEDEDE}»  {88b711}%s {DEDEDE}(%s)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc1]][gNazwa],DaneGracza[playerid][gNazwaRangi1]);
		if(DaneGracza[playerid][gDzialalnosc2] != 0) format(dz, sizeof(dz), "%s\n2.\t{DEDEDE}»  {88b711}%s {DEDEDE}(%s)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc2]][gNazwa],DaneGracza[playerid][gNazwaRangi2]);
		if(DaneGracza[playerid][gDzialalnosc3] != 0) format(dz, sizeof(dz), "%s\n3.\t{DEDEDE}»  {88b711}%s {DEDEDE}(%s)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc3]][gNazwa],DaneGracza[playerid][gNazwaRangi3]);
		if(DaneGracza[playerid][gDzialalnosc4] != 0 && GraczPremium(playerid)) format(dz, sizeof(dz), "%s\n4.\t{DEDEDE}»  {88b711}%s {DEDEDE}(%s)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc4]][gNazwa],DaneGracza[playerid][gNazwaRangi4]);
		if(DaneGracza[playerid][gDzialalnosc5] != 0 && GraczPremium(playerid)) format(dz, sizeof(dz), "%s\n5.\t{DEDEDE}»  {88b711}%s {DEDEDE}(%s)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc5]][gNazwa],DaneGracza[playerid][gNazwaRangi5]);
		if(DaneGracza[playerid][gDzialalnosc6] != 0 && GraczPremium(playerid)) format(dz, sizeof(dz), "%s\n6.\t{DEDEDE}»  {88b711}%s {DEDEDE}(%s)", dz,GrupaInfo[DaneGracza[playerid][gDzialalnosc6]][gNazwa],DaneGracza[playerid][gNazwaRangi6]);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dzia³alnoœci gospodarcze{88b711}:", dz, "Wybierz", "Zamknij");
		GameTextForPlayer(playerid, "~y~Pokazales identyfikator graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"przedmioty",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu {88b711}przedmioty{DEDEDE} wpisz: {88b711}/pokaz przedmioty [id gracza]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		Przedmioty(idgracza, playerid, DIALOG_INFO, "{DEDEDE}"VER" » Przedmioty:", TYP_WLASCICIEL, 0);
		GameTextForPlayer(playerid, "~y~Pokazales przedmioty graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"prawko",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu {88b711}prawo jazdy{DEDEDE} wpisz: {88b711}/pokaz prawko [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!Dokument(playerid, D_PRAWKO_A) && !Dokument(playerid, D_PRAWKO_B))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz prawa jazdy.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new imie[50], nazwisko[50];
		sscanf(ImieGracza(playerid), "p<_>s[50]s[50]",imie,nazwisko);
		new dz[512];
		format(dz, sizeof(dz), "%s\nImiê: {88b711}%s{DEDEDE}\nNazwisko: {88b711}%s{DEDEDE}", dz,imie,nazwisko);
		new ka[5], kb[5];
		if(Dokument(playerid, D_PRAWKO_A)) ka="Tak"; else ka="Nie";
		if(Dokument(playerid, D_PRAWKO_B)) kb="Tak"; else kb="Nie";
		format(dz, sizeof(dz), "%s\n\n{DEDEDE}Kat. A: {88b711}%s\n{DEDEDE}Kat. B: {88b711}%s", dz,ka,kb);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Prawo jazdy{88b711}:", dz, "Zamknij", "");
		GameTextForPlayer(playerid, "~y~Pokazales prawo jazdy graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"dowod",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu {88b711}dowód{DEDEDE} wpisz: {88b711}/pokaz dowod [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!Dokument(playerid, D_DOWOD))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz dowodu osobistego.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new imie[50], nazwisko[50];
		sscanf(ImieGracza(playerid), "p<_>s[50]s[50]",imie,nazwisko);
		new dz[512];
		format(dz, sizeof(dz), "%s\nImiê: {88b711}%s{DEDEDE}\nNazwisko: {88b711}%s{DEDEDE}\nPochodzenie: {88b711}%s{DEDEDE}\nWiek: {88b711}%d lat{DEDEDE}", dz,imie,nazwisko,DaneGracza[playerid][gPOCHODZENIE],DaneGracza[playerid][gWIEK]);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Dowód osobisty{88b711}:", dz, "Zamknij", "");
		GameTextForPlayer(playerid, "~y~Pokazales dowod graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"broni",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu {88b711}licencje na broñ{DEDEDE} wpisz: {88b711}/pokaz broni [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!Dokument(playerid, D_BRON))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz licencje na bron.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new imie[50], nazwisko[50];
		sscanf(ImieGracza(playerid), "p<_>s[50]s[50]",imie,nazwisko);
		new dz[512];
		format(dz, sizeof(dz), "%s\nImiê: {88b711}%s{DEDEDE}\nNazwisko: {88b711}%s{DEDEDE}", dz,imie,nazwisko);
		new ka[5];
		if(Dokument(playerid, D_BRON)) ka="Tak"; else ka="Nie";
		format(dz, sizeof(dz), "%s\n\n{DEDEDE}Licencja na broñ: {88b711}%s", dz,ka);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Licencja na broñ{88b711}:", dz, "Zamknij", "");
		GameTextForPlayer(playerid, "~y~Pokazales prawo jazdy graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"niekaralnosci",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu zaœwiadczenie o{88b711}niekaralnoœci{DEDEDE} wpisz: {88b711}/pokaz niekaralosci [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!Dokument(playerid, D_NIEKARALNOSC))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz zaswiadzczenia o niekaralnosci.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new imie[50], nazwisko[50];
		sscanf(ImieGracza(playerid), "p<_>s[50]s[50]",imie,nazwisko);
		new dz[512];
		format(dz, sizeof(dz), "%s\nImiê: {88b711}%s{DEDEDE}\nNazwisko: {88b711}%s{DEDEDE}", dz,imie,nazwisko);
		new ka[5];
		if(Dokument(playerid, D_BRON)) ka="Tak"; else ka="Nie";
		format(dz, sizeof(dz), "%s\n\n{DEDEDE}Zaœwiadczenie o niekaralnoœci: {88b711}%s", dz,ka);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Zaœwiadczenie{88b711}:", dz, "Zamknij", "");
		GameTextForPlayer(playerid, "~y~Pokazales zaswiadczenie o niekaralnosci graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"niepoczytalnosci",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu zaœwiadczenie o{88b711}niepoczytalnosci{DEDEDE} wpisz: {88b711}/pokaz niepoczytalnosci [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!Dokument(playerid, D_NIEPOCZYTALNOSC))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz zaswiadzczenia o niepoczytalnosci.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new imie[50], nazwisko[50];
		sscanf(ImieGracza(playerid), "p<_>s[50]s[50]",imie,nazwisko);
		new dz[512];
		format(dz, sizeof(dz), "%s\nImiê: {88b711}%s{DEDEDE}\nNazwisko: {88b711}%s{DEDEDE}", dz,imie,nazwisko);
		new ka[5];
		if(Dokument(playerid, D_NIEPOCZYTALNOSC)) ka="Tak"; else ka="Nie";
		format(dz, sizeof(dz), "%s\n\n{DEDEDE}Zaœwiadczenie o niepoczytalnosci: {88b711}%s", dz,ka);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Zaœwiadczenie{88b711}:", dz, "Zamknij", "");
		GameTextForPlayer(playerid, "~y~Pokazales zaswiadczenie o niepoczytalnosci graczu.", 3000, 5);
		return 1;
	}
	else if(!strcmp(comm1,"wedkarska",true))
	{
		new idgracza;
		if(sscanf(comm2, "d", idgracza))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby pokazaæ graczu zaœwiadczenie o{88b711}niepoczytalnosci{DEDEDE} wpisz: {88b711}/pokaz niepoczytalnosci [id gracza]", "Zamknij", "");
			return 1;
		}
		if(!Dokument(playerid, D_WEDKARSKA))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz karty wedkarskiej.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid] == false) return 0;
		if(DaneGracza[idgracza][gBW] != 0) return 0;
		if(playerid == idgracza) return 0;
		if(!PlayerObokPlayera(playerid, idgracza, 3))
		{
			GameTextForPlayer(playerid, "~r~Znajdujesz sie zbyt daleko od gracza.", 3000, 5);
			return 0;
		}
		if(Predkosc(idgracza) > 1)
		{
			GameTextForPlayer(playerid, "~r~Nie mozesz tego zrobic, poniewaz ten gracz sie porusza.", 3000, 5);
			return 0;
		}
		new imie[50], nazwisko[50];
		sscanf(ImieGracza(playerid), "p<_>s[50]s[50]",imie,nazwisko);
		new dz[512];
		format(dz, sizeof(dz), "%s\nImiê: {88b711}%s{DEDEDE}\nNazwisko: {88b711}%s{DEDEDE}", dz,imie,nazwisko);
		new ka[5];
		if(Dokument(playerid, D_WEDKARSKA)) ka="Tak"; else ka="Nie";
		format(dz, sizeof(dz), "%s\n\n{DEDEDE}Karta wêdkarska: {88b711}%s", dz,ka);
		dShowPlayerDialog(idgracza, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Karta wêdkarska{88b711}:", dz, "Zamknij", "");
		GameTextForPlayer(playerid, "~y~Pokazales karte wedkarska graczu.", 3000, 5);
		return 1;
	}
	return 1;
}
CMD:dynamika(playerid, params[])
{
	//printf("U¿yta komenda dynamika");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
	{
		new	comm1[32], comm2[128];
		if(sscanf(params, "s[32]S()[128]", comm1, comm2))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Drzwi:\t{88b711}[dprzenies, dstworz, dwyjscie, dusun, doplac]\n\n{DEDEDE}Przedmioty:\t{88b711}[pstworz]\n\n{DEDEDE}Pojazdy:\t{88b711}[vstworz]\n\n{DEDEDE}Hurtownia:\t{88b711}[hstworz]\n\n{DEDEDE}Obiekty:\t{88b711}[owlasciciel]", "Zamknij", "");
			return 1;
		}
		else if(!strcmp(comm1,"hstworz",true))
		{
		    if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
			    new typ, cena, typp, war1, war2, nazwa[256];
				if(sscanf(comm2, "ddddds[50]", typ, cena, typp, war1, war2, nazwa))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}produkt{DEDEDE} w hurtowni wpisz: {88b711}/dynamika hstworz [typ] [cena] [typ przedmiotu] [wartosc1] [wartosc2] [nazwa]", "Zamknij", "");
					return 1;
				}
				DodajDoHurtowni(typ, nazwa, cena, typp, war1, war2);
			}
			return 1;
		}
		else if(!strcmp(comm1,"husun",true))
		{
		    if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
			    new typ;
				if(sscanf(comm2, "d", typ))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}produkt{DEDEDE} w hurtowni wpisz: {88b711}/dynamika husun [uid]", "Zamknij", "");
					return 1;
				}
				UsunHurtownie(typ);
			}
			return 1;
		}
		else if(!strcmp(comm1,"vstworz",true))
		{
		    if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
			    new typ, war1, war2, waga;
				if(sscanf(comm2, "dddd", typ, war1, war2, waga))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}pojazd{DEDEDE} wpisz: {88b711}/dynamika vstworz [model] [kolor1] [kolor2] [paliwo]", "Zamknij", "");
					return 1;
				}
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				new typ_poj = 0;
				DodajPojazd(DaneGracza[playerid][gUID], typ, war1, war2, x, y, z, waga, 0, typ_poj);
			}
			return 1;
		}
		else if(!strcmp(comm1,"pstworz",true))
		{
		    if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
			    new typ, war1, war2, name[32], waga;
				if(sscanf(comm2, "dddfs[32]", typ, war1, war2, waga, name))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}przedmiot{DEDEDE} wpisz: {88b711}/dynamika pstworz [rodzaj] [wartosc1] [wartosc2] [waga] [nazwa]", "Zamknij", "");
					return 1;
				}
				DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, typ, war1, war2, name, DaneGracza[playerid][gUID], waga, -1, 0, 0,0, "");
			}
			return 1;
		}
		else if(!strcmp(comm1,"doplac",true))
		{
			if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
				new uids, playerid2;
				if(sscanf(comm2, "dd", uids, playerid2))
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}op³ate budynku{DEDEDE} graczu wpisz: {88b711}/dynamika doplac [uid budynku] [id gracza]", "Zamknij", "");
					return 1;
				}
				if(zalogowany[playerid2] == false)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}oferowaæ op³ate budynku{DEDEDE} jest zbyt daleko od ciebie.", "Zamknij", "");
					return 0;
				}
				Oferuj(playerid, playerid2, uids, DaneGracza[playerid][gSluzba], 0, 0, OFEROWANIE_OPLATY, 200,"", 0);
			}
			return 1;
		}
		else if(!strcmp(comm1,"dusun",true))
		{
		   	if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
				new doorid;
				if(sscanf(comm2, "d", doorid))
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby przenieœ{88b711} pickup{DEDEDE} budynku wpisz: {88b711}/dynamika dusun [id drzwi]", "Zamknij", "");
					return 1;
				}
				if(NieruchomoscInfo[doorid][nMapa] == 1)
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
					return 0;
				}
				UsunNieruchomosc(doorid);
			}
			return 1;
		}
		else if(!strcmp(comm1,"dprzenies",true))
		{
		   	if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
		    new doorid;
			if(sscanf(comm2, "d", doorid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby przenieœ{88b711} pickup{DEDEDE} budynku wpisz: {88b711}/dynamika dprzenies [id drzwi]", "Zamknij", "");
				return 1;
			}
			if(NieruchomoscInfo[doorid][nMapa] == 1)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
				return 0;
			}
			new Float:X, Float:Y, Float:Z, Float:Ang;
	  		GetPlayerPos(playerid, X, Y, Z);
	  		GetPlayerFacingAngle(playerid, Ang);
	  		NieruchomoscInfo[doorid][nX] = X;
	  		NieruchomoscInfo[doorid][nY] = Y;
	  		NieruchomoscInfo[doorid][nZ] = Z;
	  		NieruchomoscInfo[doorid][na] = Ang;
	  		NieruchomoscInfo[doorid][nINT] = GetPlayerInterior(playerid);
	  		NieruchomoscInfo[doorid][nVW] = GetPlayerVirtualWorld(playerid);
			ZapiszNieruchomosc(doorid);
			DestroyDynamicMapIcon(NieruchomoscInfo[doorid][nIconaID]);
			if(NieruchomoscInfo[doorid][nVW] == 0)
			{
				if(NieruchomoscInfo[doorid][nWlascicielD] != 0)
				{
					new typ = GrupaInfo[NieruchomoscInfo[doorid][nWlascicielD]][gTyp];
					if(typ == 2 || typ == 11 || typ == 16)
					{
					
					}
					else
					{
						NieruchomoscInfo[doorid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[doorid][nX], NieruchomoscInfo[doorid][nY], NieruchomoscInfo[doorid][nZ], Ikonki[GrupaInfo[NieruchomoscInfo[doorid][nWlascicielD]][gTyp]][0], 0, NieruchomoscInfo[doorid][nVW]);
					}
				}
				else
				{
					if(NieruchomoscInfo[doorid][nTyp] == 0)
					{
						NieruchomoscInfo[doorid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[doorid][nX], NieruchomoscInfo[doorid][nY], NieruchomoscInfo[doorid][nZ], 31, 0, NieruchomoscInfo[doorid][nVW]);
					}
					else
					{
						NieruchomoscInfo[doorid][nIconaID] = CreateDynamicMapIcon(NieruchomoscInfo[doorid][nX], NieruchomoscInfo[doorid][nY], NieruchomoscInfo[doorid][nZ], 56, 0, NieruchomoscInfo[doorid][nVW]);
					}
				}
			}
			DestroyDynamicPickup(NieruchomoscInfo[doorid][nID]);
			NieruchomoscInfo[doorid][nID] = CreateDynamicPickup(NieruchomoscInfo[doorid][nPickup], 1, NieruchomoscInfo[doorid][nX], NieruchomoscInfo[doorid][nY], NieruchomoscInfo[doorid][nZ], NieruchomoscInfo[doorid][nVW]);
			}
			return 1;
		}
		else if(!strcmp(comm1,"owlasciciel",true))
		{
		   	if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
				new doorid,owner;
				if(sscanf(comm2, "dd", doorid, owner))
				{
					dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby przenieœæ {88b711}obiekt{DEDEDE} wpisz: {88b711}/dynamika owlascieil [uid obiektu] [owner]", "Zamknij", "");
					return 1;
				}
				ObiektInfo[doorid][objOwnerDz] = owner;
				ZapiszObiekt(doorid);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Obiekt podpisany", "Zamknij", "");
			}
			return 1;
		}
		else if(!strcmp(comm1,"dwyjscie",true))
		{
		   	if(DaneGracza[playerid][gAdmGroup] == 4)
		    {
		    new doorid;
			if(sscanf(comm2, "d", doorid))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby przenieœæ {88b711}drzwi wejœciowe{DEDEDE} wpisz: {88b711}/dynamika dwyjscie [id drzwi]", "Zamknij", "");
				return 1;
			}
			if(NieruchomoscInfo[doorid][nMapa] == 1)
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
				return 0;
			}
			new Float:X, Float:Y, Float:Z, Float:Ang;
	  		GetPlayerPos(playerid, X, Y, Z);
	  		GetPlayerFacingAngle(playerid, Ang);
	  		NieruchomoscInfo[doorid][nXW] = X;
	  		NieruchomoscInfo[doorid][nYW] = Y;
	  		NieruchomoscInfo[doorid][nZW] = Z;
	  		NieruchomoscInfo[doorid][naw] = Ang;
	  		NieruchomoscInfo[doorid][nINTW] = GetPlayerInterior(playerid);
	  		NieruchomoscInfo[doorid][nVWW] = GetPlayerVirtualWorld(playerid);
			ZapiszNieruchomosc(doorid);
			}
			return 1;
		}
		else if(!strcmp(comm1,"dstworz",true))
		{
		    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
		    {
			    new typ, name[32];
				if(sscanf(comm2, "ds[32]", typ, name))
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby stworzyæ {88b711}drzwi{DEDEDE} wpisz: {88b711}/dynamika dstworz [typ] [nazwa]", "Zamknij", "");
					return 1;
				}
				if(createddoor[playerid] == 0)
				{
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Tworzenie dzia³ki{88b711}:", "{DEDEDE}Rozpocz¹³eœ proces tworzenia {88b711}nieruchomoœci{DEDEDE} udaj siê do pierwszego {88b711}rogu{DEDEDE} dachu.", "Zamknij", "");
					createddoor[playerid] = 1;
				}
				else if(createddoor[playerid] == 1)
				{
				    new Float:x, Float:y, Float:z;
				    GetPlayerPos(playerid, x, y, z);
				    createdareax[playerid] = x;
				    createdareay[playerid] = y;
				    createdareah[playerid] = z;
				    createddoor[playerid] = 2;
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Tworzenie dzia³ki{88b711}:", "{DEDEDE}Przemieœæ siê do nastêpnego {88b711}rogu{DEDEDE} dzia³ki, nastêpnie {88b711}wpisz{DEDEDE} ponownie komende.", "Zamknij", "");
				}
				else if(createddoor[playerid] == 2)
				{
				    new Float:x, Float:y, Float:z;
				    GetPlayerPos(playerid, x, y, z);
				    createdareaxx[playerid] = x;
				    createdareayy[playerid] = y;
				    createddoor[playerid] = 3;
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Tworzenie dzia³ki{88b711}:", "{DEDEDE}Ustaw {88b711}wysokoœæ{DEDEDE}. Jeœli ma ona pozostaæ {88b711}niezmienna{DEDEDE} ponów komende.", "Zamknij", "");
				}
				else if(createddoor[playerid] == 3)
				{
				    new Float:x, Float:y, Float:z;
				    GetPlayerPos(playerid, x, y, z);
				    createdareahh[playerid] = z;
				    createddoor[playerid] = 4;
				    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Tworzenie dzia³ki{88b711}:", "{DEDEDE}Przemieœæ siê miejsca {88b711}wejœciowego{DEDEDE} budynku.", "Zamknij", "");
				}else{
				new Float:m2, Float:m1, Float:m3, Float:m4, Float:m5, Float:mh;
				if(createdareaxx[playerid] > createdareax[playerid])
				{
					if(createdareax[playerid] < 0)
					{
						m1 = createdareaxx[playerid] - (createdareax[playerid]);
					}else{
					    m1 = createdareaxx[playerid] - createdareax[playerid];
					}
				}else{

				    if(createdareaxx[playerid] < 0)
					{
						m1 = createdareax[playerid] - (createdareaxx[playerid]);
					}else{
					    m1 = createdareax[playerid] - createdareaxx[playerid];
					}
				}
				if(createdareayy[playerid] > createdareay[playerid])
				{
				    if(createdareay[playerid] < 0)
					{
					    m2 = createdareayy[playerid] - (createdareay[playerid]);
					}else{
					    m2 = createdareayy[playerid] - createdareay[playerid];
					}
				}else{

				    if(createdareayy[playerid] < 0)
					{
		                m2 = createdareay[playerid] - (createdareayy[playerid]);
					}else{
		                m2 = createdareay[playerid] - createdareayy[playerid];
					}
				}
				if(createdareahh[playerid] > createdareah[playerid])
				{
				    if(createdareah[playerid] < 0)
					{
					    mh = createdareahh[playerid] - (createdareah[playerid]);
					}else{
					    mh = createdareahh[playerid] - createdareah[playerid];
					}
				}else{

				    if(createdareahh[playerid] < 0)
					{
		                mh = createdareah[playerid] - (createdareahh[playerid]);
					}else{
		                mh = createdareah[playerid] - createdareahh[playerid];
					}
				}
				m3 = (m1*m2)*2;
				m4 = (m2*mh)*4;
				m5 = m3+m4/10000;
				new text[124], typp;
				if(typ == 0)
				{
					typp = 1273;
				}
				else
				{
					typp = 1239;
				}
				new uid = StworzDrzwi(playerid, DaneGracza[playerid][gUID], 0, name, typ, typp, createdareax[playerid], createdareay[playerid], createdareah[playerid], createdareaxx[playerid], createdareayy[playerid], createdareahh[playerid], m5);
				format(text, sizeof(text), "{DEDEDE}Nowe {88b711}drzwi{DEDEDE} stworzone pomyœlnie. {88b711}(uid %d) (%s) (m2: %0.0f)", uid, name, m3);
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", text, "Zamknij", "");
				createdareax[playerid] = 0;
			    createdareay[playerid] = 0;
			    createdareah[playerid] = 0;
			    createdareaxx[playerid] = 0;
			    createdareayy[playerid] = 0;
			    createdareahh[playerid] = 0;
			    createddoor[playerid] = 0;
				}
			}
			return 1;
		}
	}
	return 1;
}
stock GetFreeSQLUID(table[], row[])
{
	//printf("U¿yta komenda getfreesqluid");
	new r[25];
	format(zapyt, sizeof(zapyt), "SELECT (%s+1) FROM %s WHERE (%s+1) NOT IN (SELECT `%s` FROM %s) LIMIT 1", row, table, row, row, table);
	mysql_query2(zapyt);
	mysql_store_result();
	mysql_fetch_row(r);
	mysql_free_result();
	if(strval(r) == 0) return 1;
	else return strval(r);
}
CMD:sluzba(playerid, params[]) return cmd_duty(playerid, params);
CMD:duty(playerid, params[])
{
	//printf("U¿yta komenda duty");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new	comm1[32], comm2[128];
	if(DutyAdmina[playerid] != 0 && DutyDZ[playerid] != 0 && DutyNR[playerid] != 0 && DaneGracza[playerid][gSluzba] != 0)
	{
		ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		DutyAdmina[playerid] = 0;
		DutyDZ[playerid] = 0;
		DutyNR[playerid] = 0;
		DaneGracza[playerid][gSluzba] = 0;
		RefreshNick(playerid);
		GameTextForPlayer(playerid, "Schodzisz ze sluzby", 3000, 5);
	}
	else if(sscanf(params, "s[32]S()[128]", comm1, comm2))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby wejœæ na {88b711}s³u¿bê{DEDEDE} dzia³alnoœci wpisz: {88b711}/sluzba [Nr dzia³alnoœci: (1-6)]", "Zamknij", "");
		return 1;
	}
	else if(!strcmp(comm1,"gm",true))
	{
	    if(DaneGracza[playerid][gAdmGroup] == 11)
		{
		    if(DutyAdmina[playerid] == 1)
		    {
		        DutyAdmina[playerid] = 0;
		        DutyDZ[playerid] = 0;
		        DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		        RefreshNick(playerid);
				GameTextForPlayer(playerid, "Schodzisz ze sluzby GameMastera", 3000, 5);
				ZapiszGraczaGlobal(playerid, 8);
			}else{
				DutyDZ[playerid] = 0;
		        DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
				DutyAdmina[playerid] = 1;
			    RefreshNick(playerid);
				GameTextForPlayer(playerid, "Wchodzisz na sluzbe GameMastera", 3000, 5);
			}
		}
		return 1;
	}
	else if(!strcmp(comm1,"a",true))
	{
	    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
		{
		    if(DutyAdmina[playerid] == 1)
		    {
		        DutyAdmina[playerid] = 0;
		        DutyDZ[playerid] = 0;
		        DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		        RefreshNick(playerid);
				GameTextForPlayer(playerid, "Schodzisz ze sluzby Administratora", 3000, 5);
				ZapiszGraczaGlobal(playerid, 8);
			}else{
				DutyDZ[playerid] = 0;
		        DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
				DutyAdmina[playerid] = 1;
			    RefreshNick(playerid);
				GameTextForPlayer(playerid, "Wchodzisz na sluzbe Administratora", 3000, 5);
			}
		}
		return 1;
	}
	else if(!strcmp(comm1,"opiekun",true))
	{
        if(DaneGracza[playerid][gAdmGroup] == 10)
		{
            if(DutyAdmina[playerid] == 1)
		    {
		        DutyAdmina[playerid] = 0;
		        DutyDZ[playerid] = 0;
		        DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		        RefreshNick(playerid);
				GameTextForPlayer(playerid, "Schodzisz ze sluzby Opiekuna", 3000, 5);
				ZapiszGraczaGlobal(playerid, 8);
			}else{
				DutyDZ[playerid] = 0;
		        DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
				DutyAdmina[playerid] = 1;
			    RefreshNick(playerid);
				GameTextForPlayer(playerid, "Wchodzisz na sluzbe Opiekuna", 3000, 5);
			}
		}
		return 1;
	}
	else if(!strcmp(comm1,"1",true))
	{
	    if(DaneGracza[playerid][gDzialalnosc1] != 0)
	    {
		    if(DaneGracza[playerid][gSluzba] == 0)
		    {
		        DaneGracza[playerid][gSluzba] = DaneGracza[playerid][gDzialalnosc1];
		        DutyNR[playerid] = 1;
				if(DutyAdmina[playerid] == 1)
				{
					ZapiszGraczaGlobal(playerid, 8);
					DutyAdmina[playerid] = 0;
				}
		        new dutyr[124];
		        format(dutyr, sizeof(dutyr), "~w~Wchodzisz na sluzbe~n~~b~~h~~h~%s", GrupaInfo[DaneGracza[playerid][gSluzba]][gNazwa]);
		        GameTextForPlayer(playerid, dutyr, 3000, 5);
		        if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
				GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_GANGI || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
		        {
		        	DutyDZ[playerid] = 1;
	        	}
				RefreshNick(playerid);
		    }else{
		        ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		    	DutyDZ[playerid] = 0;
		    	DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		    	GameTextForPlayer(playerid, "Schodzisz ze sluzby.", 3000, 5);
		    }
	    }
	}
	else if(!strcmp(comm1,"2",true))
	{
	    if(DaneGracza[playerid][gDzialalnosc2] != 0)
	    {
	        if(DaneGracza[playerid][gSluzba] == 0)
		    {
		        DaneGracza[playerid][gSluzba] = DaneGracza[playerid][gDzialalnosc2];
		        DutyNR[playerid] = 2;
				if(DutyAdmina[playerid] == 1)
				{
					ZapiszGraczaGlobal(playerid, 8);
					DutyAdmina[playerid] = 0;
				}
		        new dutyr[124];
		        format(dutyr, sizeof(dutyr), "~w~Wchodzisz na sluzbe~n~~b~~h~~h~%s", GrupaInfo[DaneGracza[playerid][gSluzba]][gNazwa]);
		        GameTextForPlayer(playerid, dutyr, 3000, 5);
		        if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
				GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_GANGI || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
		        {
		        	DutyDZ[playerid] = 2;
	        	}
				RefreshNick(playerid);
		    }else{
		        ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		    	DutyDZ[playerid] = 0;
		    	DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		    	GameTextForPlayer(playerid, "Schodzisz ze sluzby.", 3000, 5);
		    }
	    }
	}
	else if(!strcmp(comm1,"3",true))
	{
	    if(DaneGracza[playerid][gDzialalnosc3] != 0)
	    {
	        if(DaneGracza[playerid][gSluzba] == 0)
		    {
		        DaneGracza[playerid][gSluzba] = DaneGracza[playerid][gDzialalnosc3];
		        DutyNR[playerid] = 3;
				if(DutyAdmina[playerid] == 1)
				{
					ZapiszGraczaGlobal(playerid, 8);
					DutyAdmina[playerid] = 0;
				}
		        new dutyr[124];
		        format(dutyr, sizeof(dutyr), "~w~Wchodzisz na sluzbe~n~~b~~h~~h~%s", GrupaInfo[DaneGracza[playerid][gSluzba]][gNazwa]);
		        GameTextForPlayer(playerid, dutyr, 3000, 5);
		        if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
				GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_GANGI || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
		        {
		        	DutyDZ[playerid] = 3;
	        	}
				RefreshNick(playerid);
		    }else{
		        ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		    	DutyDZ[playerid] = 0;
		    	DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		    	GameTextForPlayer(playerid, "Schodzisz ze sluzby.", 3000, 5);
		    }
	    }
	}
	else if(!strcmp(comm1,"4",true) && GraczPremium(playerid))
	{
	    if(DaneGracza[playerid][gDzialalnosc4] != 0)
	    {
	        if(DaneGracza[playerid][gSluzba] == 0)
		    {
		        DaneGracza[playerid][gSluzba] = DaneGracza[playerid][gDzialalnosc4];
		        DutyNR[playerid] = 4;
				if(DutyAdmina[playerid] == 1)
				{
					ZapiszGraczaGlobal(playerid, 8);
					DutyAdmina[playerid] = 0;
				}
		        new dutyr[124];
		        format(dutyr, sizeof(dutyr), "~w~Wchodzisz na sluzbe~n~~b~~h~~h~%s", GrupaInfo[DaneGracza[playerid][gSluzba]][gNazwa]);
		        GameTextForPlayer(playerid, dutyr, 3000, 5);
		        if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
				GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_GANGI || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
		        {
		        	DutyDZ[playerid] = 4;
	        	}
				RefreshNick(playerid);
		    }else{
		        ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		    	DutyDZ[playerid] = 0;
		    	DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		    	GameTextForPlayer(playerid, "Schodzisz ze sluzby.", 3000, 5);
		    }
	    }
	}
	else if(!strcmp(comm1,"5",true) && GraczPremium(playerid))
	{
	    if(DaneGracza[playerid][gDzialalnosc5] != 0)
	    {
	        if(DaneGracza[playerid][gSluzba] == 0)
		    {
		        DaneGracza[playerid][gSluzba] = DaneGracza[playerid][gDzialalnosc5];
		        DutyNR[playerid] = 5;
				if(DutyAdmina[playerid] == 1)
				{
					ZapiszGraczaGlobal(playerid, 8);
					DutyAdmina[playerid] = 0;
				}
		        new dutyr[124];
		        format(dutyr, sizeof(dutyr), "~w~Wchodzisz na sluzbe~n~~b~~h~~h~%s", GrupaInfo[DaneGracza[playerid][gSluzba]][gNazwa]);
		        GameTextForPlayer(playerid, dutyr, 3000, 5);
		        if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
				GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_GANGI || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
		        {
		        	DutyDZ[playerid] = 5;
	        	}
				RefreshNick(playerid);
		    }else{
		        ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		    	DutyDZ[playerid] = 0;
		    	DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		    	GameTextForPlayer(playerid, "Schodzisz ze sluzby.", 3000, 5);
		    }
		}
	}
	else if(!strcmp(comm1,"6",true) && GraczPremium(playerid))
	{
	    if(DaneGracza[playerid][gDzialalnosc6] != 0)
	    {
	        if(DaneGracza[playerid][gSluzba] == 0)
		    {
		        DaneGracza[playerid][gSluzba] = DaneGracza[playerid][gDzialalnosc6];
		        DutyNR[playerid] = 6;
				if(DutyAdmina[playerid] == 1)
				{
					ZapiszGraczaGlobal(playerid, 8);
					DutyAdmina[playerid] = 0;
				}
		        new dutyr[124];
		        format(dutyr, sizeof(dutyr), "~w~Wchodzisz na sluzbe~n~~b~~h~~h~%s", GrupaInfo[DaneGracza[playerid][gSluzba]][gNazwa]);
		        GameTextForPlayer(playerid, dutyr, 3000, 5);
		        if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
				GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_GANGI || GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
		        {
		        	DutyDZ[playerid] = 6;
	        	}
				RefreshNick(playerid);
		    }else{
		        ZapiszDuty(DaneGracza[playerid][gSluzba], playerid, DutyNR[playerid]);
		    	DutyDZ[playerid] = 0;
		    	DutyNR[playerid] = 0;
		    	DaneGracza[playerid][gSluzba] = 0;
		    	GameTextForPlayer(playerid, "Schodzisz ze sluzby.", 3000, 5);
		    }
	    }
	}
	RefreshNick(playerid);
	return 1;
}
stock MegafonVWZero(uid)
{
	if(GrupaInfo[uid][gTyp] == DZIALALNOSC_POLICYJNA)
	{
		return true;
 	}
    else if(GrupaInfo[uid][gTyp] == DZIALALNOSC_SANNEWS)
	{
		return true;
 	}
	else
	{
		return false;
 	}
}
CMD:megafon(playerid,cmdtext[])
{
	//printf("U¿yta komenda megafon");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new vw = GetPlayerVirtualWorld(playerid);
	strdel(tekst_global, 0, 2048);
	strdel(tekst_globals, 0, 2048);
	if(sscanf(cmdtext, "s[2048]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}megafonu/mikrofonu{DEDEDE} wpisz: {88b711}/m [treœæ]", "Zamknij", "");
		return 1;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}megafonu/mikrofonu{DEDEDE} musisz wejœæ na {88b711}s³u¿bê{DEDEDE} dzia³alnoœci.", "Zamknij", "");
		return 0;
	}
	if(!MegafonVWZero(DaneGracza[playerid][gSluzba]) && vw == 0)
	{
	   return 0;
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
	{
		if(ComparisonString(tekst_global, "1"))
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie {88b711}znajdujesz{DEDEDE} siê w pojeŸdzie.", "Zamknij", "");
			    return 1;
			}
		    new Float: x, Float: y, Float: z;
			GetPlayerPos(playerid, x, y, z);
			/*ForeachEx(i, IloscGraczy)
			{
				if(vw == GetPlayerVirtualWorld(KtoJestOnline[i]))
			    {
				    if(IsPlayerInRangeOfPoint(KtoJestOnline[i], 60, x, y, z))
				    {
						PlayAudioStreamForPlayer(KtoJestOnline[i], "http://five-rp.com/LSPDS.mp3", 0, 0, 0, 14.0, 0);
					}
				}
			}*/
			strdel(tekst_globals, 0, 2048);
			format(tekst_globals, sizeof(tekst_globals), "%s (mikrofon): Tutaj LSPD, zjedŸ na poboczê i zgaœ silnik!", ZmianaNicku(playerid));
			SendWrappedMessageToPlayerRange(playerid, 0xf6f42fFF, tekst_globals, 60);
			return 1;
		}
	}
	if(MegafonVWZero(DaneGracza[playerid][gSluzba]))
	{
	    if(!MikrofonWVW(playerid))
	    {
	        return 0;
	    }
	    if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
	    {
			format(tekst_globals, sizeof(tekst_globals), "%s (megafon) :o< %s!!!", ZmianaNicku(playerid), tekst_global);
		}
		else if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS)
		{
		    format(tekst_globals, sizeof(tekst_globals), "%s (mikrofon): %s", ZmianaNicku(playerid), tekst_global);
		}
	}else{
	    if(!UzywanieMikrofonu(playerid, vw))
	    {
	        return 0;
	    }
		format(tekst_globals, sizeof(tekst_globals), "%s (mikrofon): %s", ZmianaNicku(playerid), tekst_global);
	}
	SendWrappedMessageToPlayerRange(playerid, 0xf6f42fFF, tekst_globals, 60);
	return 1;
}
CMD:m(playerid,cmdtext[]) return cmd_megafon(playerid, cmdtext);
CMD:a(playerid, params[])
{
	//printf("U¿yta komenda a");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new str[512], temp = 0;
	format(str, sizeof(str), "%s\n{88b711}Grupa\t\t\tPoziom\t\t\tGracz{FFFFFF}", str);
	ForeachEx(i, IloscGraczy)
	{
		if(DaneGracza[KtoJestOnline[i]][gUID] != 0 && DutyAdmina[KtoJestOnline[i]] == 1)
		{
			UsunPLZnaki(DaneGracza[KtoJestOnline[i]][nickOOC]);
			UsunPolskieZnaki(DaneGracza[KtoJestOnline[i]][nickOOC]);
			UsunPLZnaki(DaneGracza[KtoJestOnline[i]][nickOOC]);
			temp++;
			if(DaneGracza[KtoJestOnline[i]][gAdmGroup] == 4 || DaneGracza[KtoJestOnline[i]][gAdmGroup] == 8)
			{
				if(DutyAdmina[KtoJestOnline[i]] == 1)	format(str, sizeof(str), "%s\nAdministrator\t\t%d\t\t\t%s", str, DaneGracza[KtoJestOnline[i]][gAdmLVL], DaneGracza[KtoJestOnline[i]][nickOOC]);
			}
			else if(DaneGracza[KtoJestOnline[i]][gAdmGroup] == 11)
			{
				//if(DutyAdmina[KtoJestOnline[i]] == 1) format(str, sizeof(str), "%s\nGameMaster\t\t%d\t\t\tGameMaster %s", str, DaneGracza[KtoJestOnline[i]][gAdmLVL], GM(KtoJestOnline[i]));
				if(DutyAdmina[KtoJestOnline[i]] == 1) format(str, sizeof(str), "%s\nGameMaster\t\t%d\t\t\t%s", str, DaneGracza[KtoJestOnline[i]][gAdmLVL], DaneGracza[KtoJestOnline[i]][nickOOC]);
			}
			else if(DaneGracza[KtoJestOnline[i]][gAdmGroup] == 10)
			{
				if(DutyAdmina[KtoJestOnline[i]] == 1) format(str, sizeof(str), "%s\nOpiekun\t\t1\t\t\t%s", str, ImieGracza2(KtoJestOnline[i]));
			}
		}
	}
	if(temp == 0) return GameTextForPlayer(playerid, "~r~Nie znaleziono ~w~adminow~n~~r~spelniajacych kryteria.", 3000, 5);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Ekipa online{88b711}:", str, "Zamknij", "");
	return 1;
}
/*CMD:frp(playerid,cmdtext[])
{
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(DaneGracza[playerid][gAdmGroup] == 4)
    {
		PlayerTextDrawSetString(playerid, TextOferty1[playerid], "~n~Typ oferty:~n~~g~~h~Tankowanie~n~~n~~w~Pojazd: ~y~Sultan~n~~w~Litrow: ~r~7~n~~n~~w~Koszt: ~y~23~g~~h~$~n~Przytrzymaj LALT aby tankowac pojazd~n~~n~~n~");
		PlayerTextDrawShow(playerid, TextOferty0[playerid]);
	    PlayerTextDrawShow(playerid, TextOferty1[playerid]);
	    PlayerTextDrawShow(playerid, TextOferty2[playerid]);
	    PlayerTextDrawShow(playerid, TextOferty3[playerid]);
	    PlayerTextDrawShow(playerid, TextOferty4[playerid]);
	    PlayerTextDrawShow(playerid, TextOferty5[playerid]);
	}
	return 1;
}*/
CMD:wyloguj(playerid,cmdtext[])
{
	//printf("U¿yta komenda wyloguj");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(Wylogowany[playerid] == 0)
	{
		if(DaneGracza[playerid][gBW] == 0)
		{
			DaneGracza[playerid][gQS] = gettime()+600;
			GetPlayerPos(playerid, DaneGracza[playerid][gX],DaneGracza[playerid][gY],DaneGracza[playerid][gZ]);
			DaneGracza[playerid][gVW] = GetPlayerVirtualWorld(playerid);
			DaneGracza[playerid][gINT] = GetPlayerInterior(playerid);
		}
		if(DaneGracza[playerid][gBronUID] != 0)
		{
			UsunBronieGracza(playerid, PrzedmiotInfo[DaneGracza[playerid][gBronUID]][pWar1]);
			PrzedmiotInfo[DaneGracza[playerid][gBronUID]][pUzywany] = 0;
			ZapiszPrzedmiot(DaneGracza[playerid][gBronUID]);
			DaneGracza[playerid][gBronUID] = 0;
			DaneGracza[playerid][gBronAmmo] = 0;
			DeletePVar(playerid, "UzywanaBron");
		}
		ZapiszGracza(playerid);
		ZapiszBankKasa(playerid);
		ZapiszGraczaGlobal(playerid, 1);
		//Transakcja(T_LOGOUT, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "-", gettime()-CZAS_LETNI);
		Relog[playerid] = 1;
		OnPlayerDisconnect(playerid, 1002);
		zalogowany[playerid] = false;
		SetPlayerHealth(playerid,100);
		OnPlayerConnect(playerid);
	}else{
    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Musisz odczekaæ {88b711}minutê{DEDEDE} od poprzedniego {88b711}zalogowania{DEDEDE} b¹dz od ostatniej bójki.", "Zamknij", "");
	}
	return 1;
}
CMD:amodel(playerid,cmdtext[])
{
	//printf("U¿yta komenda amodel");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(DaneGracza[playerid][gAdmGroup] == 4)
    {
		new metekst_global, model;
		if(sscanf(cmdtext, "dd", metekst_global, model))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}zmieniæ{DEDEDE} model pojazdu wpisz: /amodel [uid] [model]", "Zamknij", "");
			return 1;
		}
		//PojazdInfo[metekst_global][pModel] = model;
		//ZapiszPojazd(metekst_global, 1);
		SetPlayerWeather(playerid,model);
	}
	return 1;
}
stock GetPlayerDistanceToPoint( playerid, Float:x1, Float:y1, Float:z1 )
{
	new
		Float:x2,
		Float:y2,
		Float:z2
	;
	GetPlayerPos( playerid, x2, y2, z2);
	return floatround(GetDistanceBetweenPoints( x1, y1, z1, x2, y2, z2 ), floatround_tozero );
}
CMD:alogin(playerid,cmdtext[])
{
	//printf("U¿yta komenda alogin");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11)&& DutyAdmina[playerid] == 1)
    {
		new metekst_global;
		if(sscanf(cmdtext, "d", metekst_global))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}wylogowaæ{DEDEDE} gracza wpisz: /alogin [id]", "Zamknij", "");
			SetPVarInt(playerid, "Teleportacja", 1);
			SpawnPlayer(playerid);
			SetPVarInt(playerid, "Teleportacja", 0);
			return 1;
		}
		if(DaneGracza[playerid][gBronUID] != 0)
		{
			UsunBronieGracza(metekst_global, PrzedmiotInfo[DaneGracza[metekst_global][gBronUID]][pWar1]);
			PrzedmiotInfo[DaneGracza[metekst_global][gBronUID]][pUzywany] = 0;
			ZapiszPrzedmiot(DaneGracza[metekst_global][gBronUID]);
			DaneGracza[metekst_global][gBronUID] = 0;
			DaneGracza[metekst_global][gBronAmmo] = 0;
			DeletePVar(metekst_global, "UzywanaBron");
		}
		ZapiszGracza(metekst_global);
		ZapiszBankKasa(metekst_global);
		ZapiszGraczaGlobal(metekst_global, 1);
		zalogowany[metekst_global] = false;
		SetPlayerHealth(metekst_global,100);
		Transakcja(T_ALOGIN, DaneGracza[playerid][gUID], DaneGracza[metekst_global][gUID], DaneGracza[playerid][gGUID], DaneGracza[metekst_global][gGUID], -1, -1, -1, -1, "-", gettime()-CZAS_LETNI);
		Relog[playerid] = 1;
		OnPlayerDisconnect(metekst_global, 1000);
		OnPlayerRequestClass(metekst_global, 0);
		OnPlayerConnect(metekst_global);
		new kom[256], przelew[256];
		format(przelew, sizeof(przelew), "[ALOGIN] Gracz: %s (ID:%d) wylogowa³ gracza: %s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(metekst_global), metekst_global);
		KomunikatAdmin(1, przelew);
		format(kom, sizeof(kom), "Gracz: %s (ID:%d) wylogowa³ ciê.",ZmianaNicku(playerid), playerid);
		SendClientMessage(metekst_global, 0xDEDEDEFF, kom);
	}
	return 1;
}
forward SpamKomend3(playerid);
public SpamKomend3(playerid)
{
	AntySpam[playerid][2] = 0;
	return 1;
}
CMD:b(playerid,cmdtext[])
{
	//printf("U¿yta komenda b");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(BlokadaOOC(playerid))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
		\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
	    return 0;
	}
	strdel(tekst_globals, 0, 2048);
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "s[2048]", tekst_globals))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}czatu OOC{DEDEDE} wpisz: {88b711}/b [treœæ]", "Zamknij", "");
		return 1;
	}
	tekst_globals[0] = toupper(tekst_globals[0]);
	format(tekst_global, sizeof(tekst_global), "[ID:%d] %s: (( %s ))", playerid, ZmianaNicku(playerid), tekst_globals);
	SendWrappedMessageToPlayerRange(playerid, 0xe6e6e6FF, tekst_global, 10);
	Transakcja(T_OOC, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, tekst_globals, gettime()-CZAS_LETNI);
	return 1;
}
stock GetPlayerIdWithName(const playername[])
{
  	foreach(Player, C) if(!strcmp(ZmianaNicku(C), playername)) return C;
  	return -1;
}
stock isNumeric(tekst_global1[])
{
	new length=strlen(tekst_global1);
	if (length==0) return false;
	for (new i = 0; i < length; i++)
	{
		if ((tekst_global1[i] > '9' || tekst_global1[i] < '0' && tekst_global1[i]!='-' && tekst_global1[i]!='+') // Not a number,'+' or '-'
             || (tekst_global1[i]=='-' && i!=0)                                             // A '-' but not at first.
             || (tekst_global1[i]=='+' && i!=0)                                             // A '+' but not at first.
         ) return false;
    }
	if (length==1 && (tekst_global1[0]=='-' || tekst_global1[0]=='+')) return false;
	return true;
}
CMD:id(playerid, params[])
{
	//printf("U¿yta komenda id");
	new gracz[MAX_PLAYER_NAME];
	
	if(sscanf(params, "s[MAX_PLAYER_NAME]", gracz))
	    return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby wyszukaæ gracza po{88b711} nicku{DEDEDE} wpisz: {88b711}/id [Nick/id]", "Zamknij", "");
	if(isNumeric(gracz))
	{
	    new val = strval(gracz);
		if(zalogowany[val] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego szukasz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		} 
		PokazGraczy(playerid, ImieGracza(val));
	}
	else
	{
	    PokazGraczy(playerid, gracz);
	} 
	return 1;
}
stock IdPoNicku(playerid, name[])
{
	new cos, ammm = 0;
	ForeachEx(id, IloscGraczy)
	{

		if(strfind(ZmianaNickuP(KtoJestOnline[id]), name, true) >= 0 && zalogowany[KtoJestOnline[id]] == true && playerid != KtoJestOnline[id])
		{
			cos = KtoJestOnline[id];
			ammm++;
			break;
		}
	}
	if(ammm != 0) return cos;
	else return 2000;
}
stock PokazGraczy(playerid, name[MAX_PLAYER_NAME])
{
	new big_str[ 512 ], amount;
	ForeachEx(id, IloscGraczy)
	{
		if(zalogowany[KtoJestOnline[id]] == true)
		{
			if((!IsPlayerConnected(KtoJestOnline[id])) || (strfind(ImieGracza(KtoJestOnline[id]), name, true) == (-1)))
				continue;
			format(big_str, sizeof(big_str), "%s\n%d\t%s", big_str, KtoJestOnline[id], ZmianaNicku(KtoJestOnline[id]));
			amount++;
		}
	}
	if(amount) return dShowPlayerDialog( playerid, DIALOG_PW2, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", big_str, "PW", "Zamknij" );
	else return GameTextForPlayer( playerid, "~r~~h~nie znaleziono graczy.", 3000, 5);
}
CMD:w(playerid,params[])
{
	//printf("U¿yta komenda w");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(BlokadaOOC(playerid))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
		\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
	    return 0;
	}
	new mestring[128], playerid3[24];
	/*if(sscanf(cmdtext, "ds[128]", playerid2, mestring))
	{
  		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}napisaæ{DEDEDE} do gracza {88b711}prywatn¹ wiadomoœæ{DEDEDE} wpisz:{88b711} /w [id gracza] [wiadomoœæ]", "Zamknij", "");
		return 1;
	}*/
	if(sscanf(params, "s[24]s[126]", playerid3, mestring)) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}napisaæ{DEDEDE} do gracza {88b711}prywatn¹ wiadomoœæ{DEDEDE} wpisz:{88b711} /w [id/nick gracza/gamemaster] [wiadomoœæ]", "Zamknij", "");
	if(isNumeric(playerid3))
	{
		new playerid2 = strval(playerid3);
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(playerid == playerid2) return 1;
		if(DaneGracza[playerid][gBW] != 0)
		{
			if(!PlayerObokPlayera(playerid, playerid2, 5))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podczas {88b711}BW{DEDEDE} mo¿esz pisaæ wiadomoœci na {88b711}krótk¹{DEDEDE} odleg³oœæ.", "Zamknij", "");
				return 0;
			}
		}
		if(LOCKW[playerid2] == 1)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz ma {88b711}wy³¹czone{DEDEDE} prywatne wiadomoœci.", "Zamknij", "");
			return 0;
		}
		if(GraczJestAFK(playerid2))
		{
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 7;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "Gracz do ktorego piszesz ma status AFK");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		}
		mestring[0] = toupper(mestring[0]);
		if((DaneGracza[playerid2][gAdmGroup] == 4 || DaneGracza[playerid2][gAdmGroup] == 8 || DaneGracza[playerid2][gAdmGroup] == 11) && DutyAdmina[playerid2] == 1)
		{
			SendWrappedMessageToPlayerFormat(playerid, 0xf3be5eFF, "(( Wys³ano do %s: %s ))", ZmianaNicku(playerid2), mestring);
		}
		else
		{
			SendWrappedMessageToPlayerFormat(playerid, 0xf3be5eFF, "(( Wys³ano do %s (ID: %d): %s ))", ZmianaNicku(playerid2), playerid2, mestring);
		}
		if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1)
		{
			SendWrappedMessageToPlayerFormat(playerid2, 0xffa500FF, "(( %s napisa³: %s ))", ZmianaNicku(playerid), mestring);
		}
		else
		{
			SendWrappedMessageToPlayerFormat(playerid2, 0xffa500FF, "(( %s (ID: %d) napisa³: %s ))", ZmianaNicku(playerid), playerid, mestring);
		}
		SetPVarInt(playerid2, "RE", playerid);
		Transakcja(T_WHIPS, DaneGracza[playerid][gUID], DaneGracza[playerid2][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid2][gGUID], -1, -1, -1, -1, mestring, gettime()-CZAS_LETNI);
	}
	else
	{
		new playerid2 = IdPoNicku(playerid, playerid3);
		if(playerid2 == 2000)
		{
			GameTextForPlayer(playerid, "~r~Nick, ktory wpisales jest niepoprawny badz wpisales zly nick.", 3000, 5);
			return 0;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 0;
		}
		if(playerid == playerid2) return 1;
		if(DaneGracza[playerid][gBW] != 0)
		{
			if(!PlayerObokPlayera(playerid, playerid2, 5))
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podczas {88b711}BW{DEDEDE} mo¿esz pisaæ wiadomoœci na {88b711}krótk¹{DEDEDE} odleg³oœæ.", "Zamknij", "");
				return 0;
			}
		}
		if(LOCKW[playerid2] == 1)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz ma {88b711}wy³¹czone{DEDEDE} prywatne wiadomoœci.", "Zamknij", "");
			return 0;
		}
		if(GraczJestAFK(playerid2))
		{
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 7;
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], "Gracz do ktorego piszesz ma status AFK");
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		}
		mestring[0] = toupper(mestring[0]);
		if((DaneGracza[playerid2][gAdmGroup] == 4 || DaneGracza[playerid2][gAdmGroup] == 8 || DaneGracza[playerid2][gAdmGroup] == 11) && DutyAdmina[playerid2] == 1)
		{
			SendWrappedMessageToPlayerFormat(playerid, 0xf3be5eFF, "(( Wys³ano do %s: %s ))", ZmianaNicku(playerid2), mestring);
		}
		else
		{
			SendWrappedMessageToPlayerFormat(playerid, 0xf3be5eFF, "(( Wys³ano do %s (ID: %d): %s ))", ZmianaNicku(playerid2), playerid2, mestring);
		}
		if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11) && DutyAdmina[playerid] == 1)
		{
			SendWrappedMessageToPlayerFormat(playerid2, 0xffa500FF, "(( %s napisa³: %s ))", ZmianaNicku(playerid), mestring);
		}
		else
		{
			SendWrappedMessageToPlayerFormat(playerid2, 0xffa500FF, "(( %s (ID: %d) napisa³: %s ))", ZmianaNicku(playerid), playerid, mestring);
		}
		SetPVarInt(playerid2, "RE", playerid);
		Transakcja(T_WHIPS, DaneGracza[playerid][gUID], DaneGracza[playerid2][gUID], DaneGracza[playerid][gGUID], DaneGracza[playerid2][gGUID], -1, -1, -1, -1, mestring, gettime()-CZAS_LETNI);
	}
	return 1;
}
CMD:pm(playerid,cmdtext[]) return cmd_w(playerid, cmdtext);
CMD:re(playerid,params[])
{
	//printf("U¿yta komenda re");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(BlokadaOOC(playerid))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz tego zrobiæ, poniewa¿ posiadasz aktywn¹ {88b711}blokade czatów OOC{DEDEDE} \
		\nJeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz od niej apelowaæ na forum ({88b711}www.five-rp.com{DEDEDE}).", "Zamknij", "");
	    return 0;
	}
	if(isnull(params)) return dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby odpisaæ na {88b711}prywatn¹ wiadomoœæ{DEDEDE} wpisz: {88b711}/re [wiadomoœæ]", "Zamknij", "");
	if(zalogowany[GetPVarInt(playerid, "RE")] == false)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz {88b711}nie{DEDEDE} jest zalogowany.", "Zamknij", "");
	    return 0;
	}
	if(playerid == GetPVarInt(playerid, "RE")) return 1;
	if(DaneGracza[playerid][gBW] != 0)
	{
	    if(!PlayerObokPlayera(playerid, GetPVarInt(playerid, "RE"), 5))
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Podczas {88b711}BW{DEDEDE} mo¿esz pisaæ wiadomoœci na {88b711}krótk¹{DEDEDE} odleg³oœæ.", "Zamknij", "");
		    return 0;
		}
	}
	if(LOCKW[GetPVarInt(playerid, "RE")] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz do którego piszesz ma {88b711}wy³¹czone{DEDEDE} prywatne wiadomoœci.", "Zamknij", "");
	    return 0;
	}
	if(GraczJestAFK(GetPVarInt(playerid, "RE")))
	{
	    CzasWyswietlaniaTextuNaDrzwiach[playerid] = 7;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "Gracz do ktorego piszesz ma status AFK");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
	}
	SetPVarInt(GetPVarInt(playerid, "RE"), "RE", playerid);
	params[0] = toupper(params[0]);
	SendWrappedMessageToPlayerFormat(playerid, 0xf3be5eFF, "(( Wys³ano do %s (ID: %d): %s ))", ZmianaNicku(GetPVarInt(playerid, "RE")), GetPVarInt(playerid, "RE"), params);
	SendWrappedMessageToPlayerFormat(GetPVarInt(playerid, "RE"), 0xffa500FF, "(( %s (ID: %d) napisa³: %s ))", ZmianaNicku(playerid), playerid, params);
	Transakcja(T_WHIPS, DaneGracza[playerid][gUID], DaneGracza[GetPVarInt(playerid, "RE")][gUID], DaneGracza[playerid][gGUID], DaneGracza[GetPVarInt(playerid, "RE")][gGUID], -1, -1, -1, -1, params, gettime()-CZAS_LETNI);

	return 1;
}
CMD:tog(playerid,cmdtext[])
{
	//printf("U¿yta komenda tog");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
    if(ComparisonString(cmdtext, "w"))
    {
        if(LOCKW[playerid] == 0)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Prywatne wiadomoœci zosta³y {88b711}wy³¹czone{DEDEDE}.", "Zamknij", "");
			LOCKW[playerid] = 1;
		}
		else
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Prywatne wiadomoœci zosta³y {88b711}w³¹czone{DEDEDE}.", "Zamknij", "");
			LOCKW[playerid] = 0;
		}
	}
	else
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}zablokowaæ{DEDEDE} jeden z {88b711}czatów{DEDEDE} wpisz: {88b711}/tog [w]", "Zamknij", "");
	}
	return 1;
}
CMD:przeglad(playerid,cmdtext[])
{
	//printf("U¿yta komenda przeglad");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new id, cena;
	if(sscanf(cmdtext, "dd", id, cena))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby oferowaæ {88b711}naprawe silnika{DEDEDE} w pojezdzie wpisz: {88b711}/przeglad [id gracza] [cena]", "Zamknij", "");
		return 1;
	}
	if(playerid == id) return 0;
	if(cena < 1)
	{
	    GameTextForPlayer(playerid, "~r~Kwota musi byc wieksza od zera.", 3000, 5);
		return 0;
	}
	if(!PlayerObokPlayera(playerid, id, 5))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}naprawiæ{DEDEDE} pojazd jest zbyt daleko od ciebie.", "Zamknij", "");
		return 1;
	}
	if(!IsPlayerInAnyVehicle(id))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz {88b711}naprawiæ{DEDEDE} pojazd nie znajduje sie w pojezdzie.", "Zamknij", "");
		return 0;
	}
	new vw = GetPlayerVirtualWorld(playerid);
	if(NaprawiaCzas[playerid] != 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}naprawiasz{DEDEDE} ju¿ jakiœ pojazd.", "Zamknij", "");
		return 0;
	}
	if(!Wlascicielpojazdu(GetPlayerVehicleID(id), id))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja {88b711}:", "{DEDEDE}Ten gracz nie jest {88b711}w³aœcicielem{DEDEDE} tego pojazdu.", "Zamknij", "");
		return 0;
	}
	new vehids = GetPlayerVehicleID(id);
	new uipd = SprawdzCarUID(vehids);
	NaprawianieCena[playerid] = cena;
	new Float:HvP;
	GetVehicleHealth(vehids, HvP);
	NaprawiaID[playerid] = id;
	NaprawiaVeh[playerid] = vehids;
	new calkowita = cena + (1000 - floatround(HvP));
	if(vw == 0)
	{
		if(PojazdInfo[uipd][pStan] > 300)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd nie wymaga {88b711}naprawy{DEDEDE} poza budynkiem warsztatu.", "Zamknij", "");
			return 0;
		}
		if(DaneGracza[playerid][gSluzba] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby skokorzystaæ z tej {88b711}komendy{DEDEDE} musisz wejœæ na {88b711}s³u¿be{DEDEDE} dzia³alnoœci.", "Zamknij", "");
			return 0;
		}
		if(!NaprawianieVwZero(playerid, DaneGracza[playerid][gSluzba]))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		Oferuj(playerid, id, vw, vehids, DaneGracza[playerid][gSluzba], 1, OFEROWANIE_NAP_ENG, calkowita, "Naprawa Silnika", 0);
		return 0;
	}
	else
	{
		if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0)
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(!MontazItemow(playerid, vw))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		if(PojazdInfo[uipd][pStan] == 1000)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten {88b711}pojazd{DEDEDE} jest nie wymaga {88b711}naprawy{DEDEDE} silnika.", "Zamknij", "");
			return 0;
		}
		Oferuj(playerid, id, vw, vehids, 0, 1, OFEROWANIE_NAP_ENG, calkowita, "Naprawa Silnika", 0);
	}
	return 1;
}
CMD:tankuj(playerid,cmdtext[])
{
	//printf("U¿yta komenda tankuj");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw != 0)
	{
	    return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new litry, typ;
	if(sscanf(cmdtext, "dd", typ, litry))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}zatankowaæ{DEDEDE} pojazd wpisz: {88b711}/tankuj [typ (1 - Diesel, 2 - Benzyna, 3 - Gaz)] [iloœæ litrów]", "Zamknij", "");
		return 1;
	}
	if(typ != 1 && typ != 2 && typ != 3)
	{
		GameTextForPlayer(playerid, "~r~Niepoprawny typ paliwa!", 3000, 5);
		return 0;
	}
	if(!PrzyObiekcie(playerid, 3465, 5))
	{
		GameTextForPlayer(playerid, "~r~Jestes zbyt daleko od dystrybutora!", 3000, 5);
		return 0;
	}
	new vec = GetClosestVehicle(playerid, 15);
    new vehc = SprawdzCarUID(vec);
    if(vec == INVALID_VEHICLE_ID)
    {
        GameTextForPlayer(playerid, "~r~Nie stoisz przy zadnym pojezdzie!", 3000, 5);
	    return 1;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		GameTextForPlayer(playerid, "~r~Nie mozesz tankowac pojazdu bedac w pojezdzie!", 3000, 5);
		return 0;
	}
	if(litry <= 0 || litry > PaliwoIlosc(PojazdInfo[vehc][pModel]))
	{
		GameTextForPlayer(playerid, "~r~Niepoprawna ilosc litrow!", 3000, 5);
		return 0;
	}
	if(!Wlascicielpojazdu(vec, playerid))
	{
	    GameTextForPlayer(playerid, "~r~Nie posiadasz uprawnien do otwierania tego pojazdu!", 3000, 5);
	    return 1;
	}
	if(PojazdInfo[vehc][pSilnik]==1)
	{
		GameTextForPlayer(playerid, "~r~Pojazd ktory chcesz zatankowac ma zapalony silnik!", 3000, 5);
		return 0;
	}
	new kas;
	if(typ == 1) kas = 2;
	if(typ == 2) kas = 3;
	if(typ == 3) kas = 1;	
	if(typ == 1 || typ == 2)
	{
		new Float:pal = PojazdInfo[vehc][pPaliwo];
		if(pal + litry > PaliwoIlosc(PojazdInfo[vehc][pModel]))
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz tyle wolnego miejsca w baku!", 3000, 5);
			return 0;
		}
		if(DaneGracza[playerid][gPORTFEL] < litry*kas)
		{
			GameTextForPlayer(playerid, "~r~Nie posiadasz takiej gotowki przy sobie!", 3000, 5);
			return 0;
		}
		if(PojazdInfo[vehc][pTypPaliwa] != typ)
		{
			GameTextForPlayer(playerid, "~r~Niepoprawny typ paliwa!", 3000, 5);
			return 0;
		}
		new Float:ilosc = litry;
		PojazdInfo[vehc][pPaliwo] += ilosc;
		ZapiszPojazd(vehc, 1);
		ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
		cmd_fasdasfdfive(playerid, "wk³ada pistolet do baku.");
	}
	else
	{
		if(PojazdInfo[vehc][pGaz] != 0)
		{
			new Float:pal = PojazdInfo[vehc][pPaliwoGaz];
			if(pal + litry > 50)
			{
				GameTextForPlayer(playerid, "~r~Nie posiadasz tyle wolnego miejsca w butli!", 3000, 5);
				return 0;
			}
			if(DaneGracza[playerid][gPORTFEL] < litry*kas)
			{
				GameTextForPlayer(playerid, "~r~Nie posiadasz takiej gotowki przy sobie!", 3000, 5);
				return 0;
			}
			new Float:ilosc = litry;
			PojazdInfo[vehc][pPaliwoGaz] += ilosc;
			ZapiszPojazd(vehc, 1);
			ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
			cmd_fasdasfdfive(playerid, "nape³nia butle gazem.");
		}
		else
		{
			GameTextForPlayer(playerid, "~r~Ten pojazd nie posiada instalacji gazowej!", 3000, 5);
			return 0;
		}
	}
	Dodajkase(playerid, -litry*kas);
	return 1;
}
CMD:podaj(playerid,cmdtext[])
{
	//printf("U¿yta komenda podaj");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new id;
	if(sscanf(cmdtext, "d", id))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby podaæ {88b711}graczu{DEDEDE} przedmiot z {88b711}magazynu{DEDEDE} wpisz: {88b711}/podaj [id gracza]", "Zamknij", "");
		return 1;
	}
	/*if(playerid == id)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""VER" » Informacja", "Nie mo¿esz zaoferowaæ czegoœ samemu sobie.", "Zamknij", "");
	    return 1;
	}*/
	if(!PlayerObokPlayera(playerid, id, 5))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz podaæ przedmiot z magazynu {88b711}nie{DEDEDE} znajdujê siê obok Ciebie.", "Zamknij", "");
	    return 1;
	}
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0)
	{
		new uid_budki = PrzyObiekcie(playerid, 1340, 5);
		if(uid_budki == 0)
		{
			GameTextForPlayer(playerid, "~r~Jestes zbyt daleko od straganu!", 3000, 5);
			return 0;
		}
		if(ObiektInfo[uid_budki][objOwnerDz] != DaneGracza[playerid][gSluzba])
		{
			GameTextForPlayer(playerid, "~r~Ten stragan nie nalezy do twojej dzialalnosci!", 3000, 5);
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_SPRZEDAWANIE_P))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do sprzedawania przedmiotow, badz nie jestes na sluzbie dzialalnosci!", 3000, 5);
			return 0;
		}
		SetPVarInt(playerid, "idgrpodaj", id);
		Magazyn(playerid, DIALOG_GASTRO_KUP, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Podaj{88b711}:", TYP_MAGAZYN, ObiektInfo[uid_budki][objOwnerDz], "Wybierz", "Zamknij");
	}
	else
	{
		if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0)
		{
			return 0;
		}
		if(!Podaj(playerid, vw))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie", 3000, 5);
			return 0;
		}
		SetPVarInt(playerid, "idgrpodaj", id);
		Magazyn(playerid, DIALOG_GASTRO_KUP, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Podaj{88b711}:", TYP_MAGAZYN, NieruchomoscInfo[vw][nWlascicielD], "Wybierz", "Zamknij");
	}
	return 1;
}
CMD:cennik(playerid,cmdtext[])
{
	//printf("U¿yta komenda cennik");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new id;
	if(sscanf(cmdtext, "d", id))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby podaæ {88b711}graczu{DEDEDE} cennik wpisz: {88b711}/cennik [id gracza]", "Zamknij", "");
		return 1;
	}
	if(!PlayerObokPlayera(playerid, id, 5))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz podaæ cennik {88b711}nie{DEDEDE} znajdujê siê obok Ciebie.", "Zamknij", "");
	    return 1;
	}
	new vw = GetPlayerVirtualWorld(playerid);
	if(vw == 0)
	{
		new uid_budki = PrzyObiekcie(playerid, 1340, 5);
		if(uid_budki == 0)
		{
			GameTextForPlayer(playerid, "~r~Jestes zbyt daleko od straganu!", 3000, 5);
			return 0;
		}
		if(ObiektInfo[uid_budki][objOwnerDz] != DaneGracza[playerid][gSluzba])
		{
			GameTextForPlayer(playerid, "~r~Ten stragan nie nalezy do twojej dzialalnosci!", 3000, 5);
			return 0;
		}
		if(!UprDutyOn(playerid, DaneGracza[playerid][gSluzba], U_SPRZEDAWANIE_P))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien do sprzedawania przedmiotow, badz nie jestes na sluzbie dzialalnosci!", 3000, 5);
			return 0;
		}
		SetPVarInt(playerid, "idgrpodaj", id);
		Magazyn(id, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Cennik{88b711}:", TYP_MAGAZYN, ObiektInfo[uid_budki][objOwnerDz], "Zamknij", "");
	}
	else
	{
		if(NieruchomoscInfo[vw][nWlascicielP] != 0 && NieruchomoscInfo[vw][nWlascicielD] == 0)
		{
			return 0;
		}
		if(!Podaj(playerid, vw))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien, badz nie jestes na sluzbie", 3000, 5);
			return 0;
		}
		SetPVarInt(playerid, "idgrpodaj", id);
		Magazyn(id, DIALOG_INFO, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Cennik{88b711}:", TYP_MAGAZYN, NieruchomoscInfo[vw][nWlascicielD], "Zamknij", "");
	}
	return 1;
}
CMD:pay(playerid,cmdtext[]) return cmd_plac(playerid, cmdtext);
CMD:ja(playerid,cmdtext[]) return cmd_me(playerid, cmdtext);
CMD:spec(playerid,cmdtext[]) return cmd_rc(playerid, cmdtext);
CMD:fasdasfdfive(playerid,cmdtext[])
{
	//printf("U¿yta komenda fasdasf");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new mestring[200];
	if(sscanf(cmdtext, "s[200]", mestring))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}akcji role play{DEDEDE} wpisz: {88b711}/me [treœæ]", "Zamknij", "");
		return 1;
	}
	format(mestring, sizeof(mestring), "* %s %s", ZmianaNicku(playerid), mestring);
	SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, mestring, 10);
	return 1;
}
CMD:me(playerid,cmdtext[])
{
	//printf("U¿yta komenda me");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new mestring[200];
	if(sscanf(cmdtext, "s[200]", mestring))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}akcji role play{DEDEDE} wpisz: {88b711}/me [treœæ]", "Zamknij", "");
		return 1;
	}
	format(mestring, sizeof(mestring), "** %s %s", ZmianaNicku(playerid), mestring);
	SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, mestring, 10);
	DaneGracza[playerid][gMe] = gettime()+60;
	return 1;
}
CMD:do(playerid,cmdtext[])
{
	//printf("U¿yta komenda do");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new mestring[200];
	if(sscanf(cmdtext, "s[200]", mestring))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿ywaæ {88b711}akcji role play{DEDEDE} wpisz: {88b711}/do [treœæ]", "Zamknij", "");
		return 1;
	}
	format(mestring, sizeof(mestring), "** %s ((%s))", mestring, ZmianaNicku(playerid));
	SendWrappedMessageToPlayerRange(playerid, KOLOR_DO, mestring, 10);
	return 1;
}
CMD:sprobuj(playerid,cmdtext[])
{
	//printf("U¿yta komenda sproboj");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "s[200]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}spróbowaæ{DEDEDE} czegoœ wpisz: {88b711}/sproboj [akcja]", "Zamknij", "");
		return 1;
	}
	new rand = random(10);
	if(rand == 1 || rand == 2 || rand == 4 || rand == 7 || rand == 10)
	{
		format(tekst_global, sizeof(tekst_global), "* %s uda³o mu siê %s", ZmianaNicku(playerid), tekst_global);
	}
	else
	{
		format(tekst_global, sizeof(tekst_global), "* %s nie uda³o mu siê %s", ZmianaNicku(playerid), tekst_global);
	}
	SendWrappedMessageToPlayerRange(playerid, FIOLETOWY, tekst_global, 10);
	return 1;
}
CMD:paczka( playerid, params[ ] )
{
	//printf("U¿yta komenda paczka");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gPracaTyp] != PRACA_KURIER)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz posiadaæ prace kuriera.", "Zamknij", "");
		return 0;
	}
	if(DaneGracza[playerid][gPaczkaT] > gettime())
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz odczekaæ minute od poprzedniego razu.", "Zamknij", "");
		return 0;
	}
	if(DaneGracza[playerid][gPaczkaM] == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz siê znajdowaæ w pojezdzie.", "Zamknij", "");
			return 0;
		}
		new vehid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehid) == 510 || GetVehicleModel(vehid) == 509 || GetVehicleModel(vehid) == 481)
		{
			return 0;
		}
		new item_list[1024],find;
		strdel(item_list, 0, 1024);
		ForeachEx(i, 200)
		{
			if(PaczkaInfo[i][xUID] != 0)
			{
				format(item_list, sizeof(item_list), "%s\n%d\t\t%s", item_list, PaczkaInfo[i][xUID], NieruchomoscInfo[PaczkaInfo[i][xMIEJSCED]][nAdres]);
				find++;
			}
		}
		if(find == 0) dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}brak{DEDEDE} dostêpnych paczek.", "Zamknij", "");
		else dShowPlayerDialog(playerid, DIALOG_WEZ_PACZKE, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Paczki{88b711}:", item_list, "Wybierz", "Zamknij");
		return 1;
	}
	else if(DaneGracza[playerid][gPaczkaM] == 1)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz siê znajdowaæ w pojezdzie.", "Zamknij", "");
			return 0;
		}
		new vehid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehid) == 510 || GetVehicleModel(vehid) == 509 || GetVehicleModel(vehid) == 481)
		{
			return 0;
		}
		new is = DaneGracza[playerid][gPaczkaUID];
		new i = PaczkaInfo[is][xHURT];
		if(Dystans(5.0, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
		{
			if(DaneGracza[playerid][gMe] < gettime())
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz odegraæ {88b711}odpowiedni¹{DEDEDE} akcje role play.", "Zamknij", "");
				return 0;
			}
			DaneGracza[playerid][gPaczkaM] = 2;
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Paczka odebrana z hurtowni teraz udaj siê do miejsca dostarczenia.", "Zamknij", "");
			new id = PaczkaInfo[is][xMIEJSCED];
			SetPlayerCheckpoint(playerid, NieruchomoscInfo[id][nX], NieruchomoscInfo[id][nY], NieruchomoscInfo[id][nZ], 5.0);
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz znajdywaæ siê obok odpowiedniej hurtowni.", "Zamknij", "");
			new id = PaczkaInfo[is][xHURT];
			SetPlayerCheckpoint(playerid, NieruchomoscInfo[id][nX], NieruchomoscInfo[id][nY], NieruchomoscInfo[id][nZ], 5.0);
		}
		return 1;
	}
	else if(DaneGracza[playerid][gPaczkaM] == 2)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby od³o¿yæ paczke musisz znajdywaæ siê poza pojazdem.", "Zamknij", "");
			return 0;
		}
		new is = DaneGracza[playerid][gPaczkaUID];
		new i = PaczkaInfo[is][xMIEJSCED];
		if(Dystans(5.0, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
		{
			if(DaneGracza[playerid][gMe] < gettime())
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz odegraæ {88b711}odpowiedni¹{DEDEDE} akcje role play.", "Zamknij", "");
				return 0;
			}
			DodajDoMagazynu(PaczkaInfo[is][xUIDG], PaczkaInfo[is][xTYP], PaczkaInfo[is][xWAR1], PaczkaInfo[is][xWAR2], PaczkaInfo[is][xNAZWA],PaczkaInfo[is][xCENA], PaczkaInfo[is][xILOSC]);
			new dla_nuba = PaczkaInfo[is][xWARTOSC] / 10;
			if(dla_nuba > 50) dla_nuba = 50;
			if(dla_nuba < 18) dla_nuba = 18;
			Dodajkase( playerid, dla_nuba );
			ZapiszGracza(playerid);
			UsunPaczke(is);
			DaneGracza[playerid][gPaczkaM] = 0;
			DaneGracza[playerid][gPaczkaUID] = 0;
			DisablePlayerCheckpoint(playerid);
			TextDrawHideForPlayer(playerid, OBJ[playerid]);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Paczka dostarczona na miejsce.", "Zamknij", "");
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ tej komendy musisz znajdywaæ siê obok odpowiedniego budynku.", "Zamknij", "");
			SetPlayerCheckpoint(playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ], 5.0);
		}
		return 1;
	}
	DaneGracza[playerid][gPaczkaT] = gettime()+60;
	return 1;
}
/*
CMD:hurtownia( playerid, params[ ] )
{
	//printf("U¿yta komenda hurtownia");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	for(new i = 0; i < sizeof(NieruchomoscInfo); i++)
	{
		if(Dystans(1.0, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
		{
			if(NieruchomoscInfo[i][nTyp] == 3)
			{
				Hurtownia(playerid, 3, DZIALALNOSC_WARSZTAT, i);
				return 0;
			}
			if(NieruchomoscInfo[i][nTyp] == 4)
			{
			    //Hurtownia(playerid, 4, DZIALALNOSC_SALON, i);
				return 0;
			}
			if(NieruchomoscInfo[i][nTyp] == 5)
			{
				Hurtownia(playerid, 5, DZIALALNOSC_POLICYJNA, i);
				return 0;
			}
			if(NieruchomoscInfo[i][nTyp] == 6)
			{
				Hurtownia(playerid, 6, DZIALALNOSC_247, i);
				return 0;
			}
			if(NieruchomoscInfo[i][nTyp] == 7)//elektryka
		   	{
	    		Hurtownia(playerid, 7, DZIALALNOSC_ELEKTRTYKA, i);
		    	return 0;
		   	}
		   	if(NieruchomoscInfo[i][nTyp] == 8)
		   	{
	    		Hurtownia(playerid, 8, DZIALALNOSC_GASTRONOMIA, i);
		    	return 0;
		   	}
			if(NieruchomoscInfo[i][nTyp] == 9)
		   	{
	    		Hurtownia(playerid, 9, DZIALALNOSC_GANGI, i);
		    	return 0;
		   	}
			if(NieruchomoscInfo[i][nTyp] == 12)
		   	{
	    		Hurtownia(playerid, 12, DZIALALNOSC_MEDYCZNA, i);
		    	return 0;
		   	}
			if(NieruchomoscInfo[i][nTyp] == 13)
		   	{
	    		Hurtownia(playerid, 13, DZIALALNOSC_ZMOTORYZOWANA, i);
		    	return 0;
		   	}
			if(NieruchomoscInfo[i][nTyp] == 14)
		   	{
	    		Hurtownia(playerid, 14, DZIALALNOSC_MAFIE, i);
		    	return 0;
		   	}
		}
	}
	return 1;
}
*/
CMD:stats(playerid, cmdtext[])
{
	//printf("U¿yta komenda stats");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	Pokazstatsy(playerid);
	return 1;
}
////mt 0 100 Mistral 54 0 0xFF88b711 0 1 (220022)Five*(000000)Boxton*Crips
CMD:akceptujsmierc(playerid,cmdtext[])
{
	//printf("U¿yta komenda akceptujsmierc");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gCZAS_ONLINE] < 10 * 60 * 60)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Uœmiercenie swojej {88b711}postaci{DEDEDE} jest mo¿liwe tylko i wy³¹cznie wtedy, gdy ma ona wiêcej ni¿ {88b711}10{DEDEDE} godzin online.", "Zamknij", "");
		return 0;
	}
	if(DaneGracza[playerid][gBW]==0) 
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby akceptowaæ œmieræ twoja {88b711}postaæ{DEDEDE} musi byæ nieprzytomna.", "Zamknij", "");
		return 0;
	}
	new playerid2[256];
	if(sscanf(cmdtext, "s[256]", playerid2))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}uœmierciœ{DEDEDE} swoj¹ {88b711}postaæ{DEDEDE} wpisz: {88b711}/akceptujsmierc [powód]", "Zamknij", "");
		return 1;
	}
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "%s",ZmianaNicku(playerid));
	DodajPrzedmiot(DaneGracza[playerid][gUID], TYP_WLASCICIEL, P_TRUP, 0, 0, tekst_global, DaneGracza[playerid][gUID], 0, -1, 0, 0,0, "");
	format(tekst_global, sizeof(tekst_global),"** %s umiera. Wszystkie jego przedmioty, które posiada³ obecnie przy sobie zosta³y przy jego martwym ciele. **",ZmianaNicku(playerid));
	SendWrappedMessageToPlayerRange(playerid, KOLOR_DO, tekst_global, 10);
	ForeachEx(i, MAX_PRZEDMIOT)
	{
		if(PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pUID] != 0 && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL)
		{
			if(PrzedmiotInfo[i][pUzywany] != 0)
			{
				PrzedmiotInfo[i][pUzywany] = 0;
			}
            OdkladanieItemu(playerid, i);
		}
	}
	DaneGracza[playerid][gAKTYWNE] = 0;
	ZapiszGracza(playerid);
	DodajDoBazyKare(DaneGracza[playerid][gGUID], DaneGracza[playerid][gUID], 13, playerid2, gettime()-CZAS_LETNI, -1, "Nie", DaneGracza[playerid][gGUID]);
	Kick(playerid);
	return 1;
}
CMD:v(playerid, cmdtext[])
{
	//printf("U¿yta komenda v");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
    new	comm1[32], comm2[128];
    new vehicleid = GetPlayerVehicleID(playerid);
	new veh = SprawdzCarUID(vehicleid);
	spawns[playerid] = 0;
	if(sscanf(cmdtext, "s[32]S()[128]", comm1, comm2))
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
			{
				new	list_vehicles[512], find = 0;
				ForeachEx(i, MAX_VEH)
				{
				    if(PojazdInfo[i][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[i][pOwnerDzialalnosc] == 0)
				    {
				        if(PojazdInfo[i][pSpawn] != 0)
						{
							format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
							spawns[playerid]++;
						}
				        else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
				        find++;
				    }
				}
				if(find > 0)
				{
					if(!Osiagniecia(playerid, OSIAGNIECIE_PIERWSZY_POJAZD))
					{
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Pierwszy pojazd ~g~+100GS");
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
						DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_PIERWSZY_POJAZD] = 1;
						DaneGracza[playerid][gGAMESCORE] += 100;
						SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
						ZapiszGraczaGlobal(playerid, 1);
					}
					dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Zamknij");
				}
				else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie {88b711}posiadasz{DEDEDE} ¿adnych pojazdów.", "Zamknij", "");
				return 1;
			}else{
			new Szybatxt[124],Gaztxt[124];
			strdel(tekst_global, 0, 2048);
			strdel(Szybatxt, 0, 124);
			strdel(Gaztxt, 0, 124);
			if(PojazdInfo[veh][pSzyba] != 0) Szybatxt="Otwórz szyby w pojezdzie"; else Szybatxt="Zamknij szyby w pojezdzie";
			format(tekst_global, sizeof(tekst_global), "%s\n{DEDEDE}Zarz¹dzaj pojazdem:", tekst_global);
	        format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}Wy³¹cz/wy³¹cz œwiat³a", tekst_global);
	        format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}Otwórz/zamknij maske", tekst_global);
	        format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}Otwórz/zamknij baga¿nik", tekst_global);
	        format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}Zobacz komponenty pojazdu", tekst_global);
	        //format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}Ustaw unikaln¹ rejestracje", tekst_global);
	        format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}Przepisz pojazd pod dzia³alnoœæ", tekst_global);
			format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}%s", tekst_global, Szybatxt);
			if(PojazdInfo[veh][pGaz] != 0)
			{
				if(PojazdInfo[veh][pGaz] != 1) Gaztxt="W³¹cz gaz"; else Gaztxt="Wy³¹cz gaz";
				format(tekst_global, sizeof(tekst_global), "%s\n\t{DEDEDE}» {88b711}%s", tekst_global, Gaztxt);
			}
	        dShowPlayerDialog(playerid, DIALOG_MANIPULATION_VEH, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", tekst_global, "Wybierz", "Zamknij");
			}
	    }
		else
		{
			new list_vehicles[512], find = 0;
			ForeachEx(i, MAX_VEH)
			{
				if(PojazdInfo[i][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[i][pOwnerDzialalnosc] == 0)
				{
					if(PojazdInfo[i][pSpawn] != 0)
					{
						format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s (Na serwerze)", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
					}
					else format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
					find++;
				}
			}
			if(find > 0)
			{
				if(!Osiagniecia(playerid, OSIAGNIECIE_PIERWSZY_POJAZD))
				{
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Pierwszy pojazd ~g~+100GS");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
					DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_PIERWSZY_POJAZD] = 1;
					DaneGracza[playerid][gGAMESCORE] += 100;
					SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
					ZapiszGraczaGlobal(playerid, 1);
				}
				dShowPlayerDialog(playerid, DIALOG_VEH_SPAWN, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Zamknij");
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie {88b711}posiadasz{DEDEDE} ¿adnych pojazdów.", "Zamknij", "");
			}
		}
	}
	else if(!strcmp(comm1,"parkuj",true))
	{
	    if(vehicleid == INVALID_VEHICLE_ID)
		{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}przeprakowaæ{DEDEDE} pojazd musisz {88b711}znajdowaæ{DEDEDE} siê w pojezdzie.", "Zamknij", "");
		    return 1;
		}
		if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby {88b711}przeprakowaæ{DEDEDE} pojazd musisz {88b711}znajdowaæ{DEDEDE} siê za kierownic¹ pojazdu.", "Zamknij", "");
			return 1;
		}
		if(PojazdInfo[veh][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[veh][pOwnerDzialalnosc] == 0 || WlascicielpojazduBezWYP(vehicleid, playerid))
		{
			GetVehiclePos(vehicleid, PojazdInfo[veh][pX], PojazdInfo[veh][pY], PojazdInfo[veh][pZ]);
			GetVehicleZAngle(vehicleid, PojazdInfo[veh][pAngle]);
			PojazdInfo[veh][pVw] = GetVehicleVirtualWorld(vehicleid);
			ZapiszPojazd(veh, 1);
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Twój pojazd zosta³ {88b711}przeparkowany{DEDEDE} w nowe miejsce.", "Zamknij", "");
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd nie {88b711}nale¿y{DEDEDE} do ciebie - b¹dz nie jesteœ {88b711}ownerem{DEDEDE} grupy do której nale¿y pojazd.", "Zamknij", "");
		}
		return 1;
	}
	else if(!strcmp(comm1,"opis",true))
	{	
		if(!IsPlayerInAnyVehicle(playerid))
	    {
			return 0;
		}
		new veh1 = GetPlayerVehicleID(playerid);
		if(!Wlascicielpojazdu(veh1, playerid))
		{
		    GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
		    return 1;
		}
		strdel(tekst_global, 0, 2048);
		strdel(tekst_globals, 0, 2048);
		if(sscanf(comm2, "s[2048]",tekst_global))
		{
			UpdateDynamic3DTextLabelText(Vopis[veh1], 0xAAAAFFFF, " ");
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby ustawiæ {88b711}opis swojego pojazdu{DEDEDE} wpisz: {88b711}/v opis [treœæ]\nJeœli mia³eœ teraz ustawiony opis swojej postaci, b¹dz pojazdu zosta³ w³aœnie usuniêty.", "Zamknij", "");
			return 1;
		}
		UpdateDynamic3DTextLabelText(DaneGracza[playerid][gOpisPostaci], 0xAAAAFFFF, " ");
		new liczba = 30;
		for(new i = 0; i < strlen(tekst_global); i++)
		{
			if(i >= liczba && tekst_global[i] == ' ')
			{
				strins(tekst_global, "\n", i);
				liczba+=30;
			}
		}
		UpdateDynamic3DTextLabelText(Vopis[veh1], 0xAAAAFFFF, " ");
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Opis twojego {88b711}pojazdu{DEDEDE} zosta³ ustawiony.\nAby {88b711}usun¹æ opis{DEDEDE} swojego pojazdu wpisz: {88b711}/v opis");
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", tekst_globals, "Zamknij", "");
		UpdateDynamic3DTextLabelText(Vopis[veh1], 0xAAAAFFFF, tekst_global);
		OpisekJaki[playerid] = veh1;
		return 1;
	}
	else if(!strcmp(comm1,"z",true)||!strcmp(comm1,"zamknij",true))
	{
	    new vec = GetClosestVehicle(playerid, 15);
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        vec = GetPlayerVehicleID(playerid);
	    }
	    new vehc = SprawdzCarUID(vec);
	    if(vec == INVALID_VEHICLE_ID)
	    {
	        GameTextForPlayer(playerid, "~r~Nie stoisz przy zadnym pojezdzie!", 3000, 5);
		    return 1;
		}
		if(!Wlascicielpojazdu(vec, playerid) && DaneGracza[playerid][gAdmGroup] != 4)
		{
		    GameTextForPlayer(playerid, "~r~Nie posiadasz uprawnien do otwierania tego pojazdu!", 3000, 5);
		    return 1;
		}
		new lights,doors,bonnet,boot,objective,engine,alarm;
		GetVehicleParamsEx(vec,engine,lights,alarm,doors,bonnet,boot,objective);
		if(PojazdInfo[vehc][pLock] == 0)
		{
			PojazdInfo[vehc][pLock] = 1;
			GameTextForPlayer(playerid, "Pojazd ~r~zamkniety", 3000, 5);
            if(!IsPlayerInAnyVehicle(playerid)) 
			{
				if(PojazdInfo[vehc][pImmo] == 0)
				{
					ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
				}
				else
				{
					OnPlayerText(playerid, "-karta");
				}
			}
			SetVehicleParamsEx(vec,engine,lights,false,true,bonnet,boot,objective);
		}
		else
		{
			PojazdInfo[vehc][pLock] = 0;
			GameTextForPlayer(playerid, "Pojazd ~g~otwarty", 3000, 5);
			if(!IsPlayerInAnyVehicle(playerid)) 
			{
				if(PojazdInfo[vehc][pImmo] == 0)
				{
					ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
				}
				else
				{
					OnPlayerText(playerid, "-karta");
				}
			}
			SetVehicleParamsEx(vec,engine,lights,false,false,bonnet,boot,objective);
		}
		return 1;
	}
	else if(!strcmp(comm1,"alarm",true))
	{
	    new vec = GetClosestVehicle(playerid, 15);
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        vec = GetPlayerVehicleID(playerid);
	    }
	    new vehc = SprawdzCarUID(vec);
	    if(vec == INVALID_VEHICLE_ID)
	    {
	        GameTextForPlayer(playerid, "~r~Nie stoisz przy zadnym pojezdzie!", 3000, 5);
		    return 1;
		}
		if(!Wlascicielpojazdu(vec, playerid))
		{
		    GameTextForPlayer(playerid, "~r~Nie posiadasz uprawnien do otwierania tego pojazdu!", 3000, 5);
		    return 1;
		}
		new lights,doors,bonnet,boot,objective,engine,alarm;
		GetVehicleParamsEx(vec,engine,lights,alarm,doors,bonnet,boot,objective);
		if(PojazdInfo[vehc][pAlarm] == 1)
		{
			GameTextForPlayer(playerid, "Wlaczyles ~r~alarm", 3000, 5);
            if(!IsPlayerInAnyVehicle(playerid)) OnPlayerText(playerid, "-karta");
			SetVehicleParamsEx(vec,engine,lights,true,doors,bonnet,boot,objective);
		}
		return 1;
	}
	else if(!strcmp(comm1,"odpal",true))
	{
	    new vehc = SprawdzCarUID(vehicleid);
	    if(PojazdInfo[vehc][pModel] != 481 && PojazdInfo[vehc][pModel] != 510 && PojazdInfo[vehc][pModel] != 509)
		{
		    if(vehicleid == INVALID_VEHICLE_ID)
			{
			    return 0;
			}
			if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
			{
				return 0;
			}
		    if(!Wlascicielpojazdu(vehicleid, playerid))
			{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie posiadasz {88b711}uprawnieñ{DEDEDE} do odpalenia tego pojazdu.", "Zamknij", "");
			    return 0;
			}
			if(PojazdInfo[vehc][pBlokada] != 0)
	        {
				strdel(tekst_global, 0, 2048);
	            format(tekst_global, sizeof(tekst_global), "{DEDEDE}Na ten {88b711}pojazd{DEDEDE}zosta³a na³o¿ona {88b711}blokada{DEDEDE} na ko³o o wartoœci: {88b711}%d{DEDEDE}$.\nAby zdj¹æ blokade nale¿y skontaktowaæ siê z {88b711}Police Departament{DEDEDE}.", PojazdInfo[vehc][pBlokada]);
	            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", tekst_global, "Wybierz", "Zamknij");
	            return 0;
			}
			if(PojazdInfo[vehc][pStan] <= 300)
	        {
	            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten pojazd jest {88b711}zniszczony{DEDEDE} udaj siê do warsztatu aby go naprawiæ.\nZniszczone pojazdy mo¿na {88b711}naprawiaæ{DEDEDE} w ka¿dym miejscu.", "Zamknij", "");
	            return 0;
			}
			if(PojazdInfo[vehc][pTypPaliwa] == 0)
			{
				return 0;
			}
			new lights,doors,bonnet,boot,objective,engine,alarm;
		    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(PojazdInfo[vehc][pSilnik]==1)
			{//gasi
			GameTextForPlayer(playerid,"~r~Wylaczanie silnika!",3000,5);
			PojazdInfo[vehc][pSilnik] = 0;
			GetVehiclePos(vehicleid,dOstatniX[playerid],dOstatniY[playerid],dOstatniZ[playerid]);
			SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
			TextDrawHideForPlayer(playerid, Licznik[playerid]);
			KillTimer(PojazdInfo[vehc][pTimer]);
			}else{
			if(PojazdInfo[vehc][pPaliwo]<=0 && PojazdInfo[vehc][pGaz] != 2)
	        {
	            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz {88b711}odpaliæ{DEDEDE} pojazdu, poniewa¿ {88b711}skoñczy³o{DEDEDE} mu siê paliwo.", "Zamknij", "");
	            return 1;
	        }//odpala
			if(PojazdInfo[vehc][pPaliwoGaz]<=0 && PojazdInfo[vehc][pGaz] == 2)
	        {
	            dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Nie mo¿esz {88b711}odpaliæ{DEDEDE} pojazdu, poniewa¿ {88b711}skoñczy³{DEDEDE} siê gaz.", "Zamknij", "");
	            return 1;
	        }
			GameTextForPlayer(playerid,"~g~Wlaczanie silnika!",3000,5);
			GetVehiclePos(vehicleid,dOstatniX[playerid],dOstatniY[playerid],dOstatniZ[playerid]);
			KillTimer(PojazdInfo[vehc][pStartSilnik]);
			PojazdInfo[vehc][pStartSilnik] = SetTimerEx("SilnikStart",3500,0,"ddd",vehc,vehicleid, playerid);
			}
		}
	    return 1;
	}
	else if(!strcmp(comm1,"namierz",true))
	{
	    DisablePlayerCheckpoint(playerid);
	    new	list_vehicles[512], find = 0;
	   	ForeachEx(i, MAX_VEH)
		{
		    if(PojazdInfo[i][pOwnerPostac] == DaneGracza[playerid][gUID] && PojazdInfo[i][pOwnerDzialalnosc] == 0 && PojazdInfo[i][pSpawn] == 1)
		    {
		        format(list_vehicles, sizeof(list_vehicles), "%s\n%d\t%s", list_vehicles, PojazdInfo[i][pUID], GetVehicleModelName(PojazdInfo[i][pModel]));
		        find++;
		    }
		}
		if(find > 0) dShowPlayerDialog(playerid, DIALOG_VEH_NAMIERZ, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pojazdy{88b711}:", list_vehicles, "Wybierz", "Zamknij");
		else dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby namierzyæ {88b711}pojazd{DEDEDE} musi on byæ zespawnowany.", "Zamknij", "");
	    return 1;
	}
	else if(!strcmp(comm1,"info",true))
	{
	    if(vehicleid == INVALID_VEHICLE_ID)
		{
		    return 0;
		}
		if(!Wlascicielpojazdu(vehicleid, playerid))
		{
		    return 0;
		}
		new vehc = SprawdzCarUID(vehicleid);
	    new Tempomattxt[10], Audiotxt[10], Alarmtxt[10], Immotxt[10], CBtxt[10];
		if(PojazdInfo[vehc][pTempomat] == 0) Tempomattxt="N"; else Tempomattxt="T";
		if(PojazdInfo[vehc][pImmo] == 0) Immotxt="N"; else Immotxt="T";
		if(PojazdInfo[vehc][pCB] == 0) CBtxt="N"; else CBtxt="T";
		if(PojazdInfo[vehc][pAlarm] == 0) Alarmtxt="N"; else Alarmtxt="T";
		if(PojazdInfo[vehc][pAudio] == 0) Audiotxt="N"; else Audiotxt="T";
		strdel(tekst_global, 0, 2048);
	    format(tekst_global, sizeof(tekst_global), "~p~UID:~w~ %d  ~p~Owner:~w~ %d:%d  ~p~Model:~w~ %d~n~~p~ID:~w~ %d  ~p~Kolor:~w~ %d:%d~n~~b~Przebieg:~w~ %0.01f  ~b~HP:~w~ %0.01f  ~b~Paliwo:~w~ %0.01f~n~~n~~w~Alarm: %s  Immobilajzer: %s  CB Radio: %s (K: %d)~n~Audio: %s  Tempomat: %s  Zuzycie: %0.1f",
		PojazdInfo[vehc][pUID], PojazdInfo[vehc][pOwnerPostac], PojazdInfo[vehc][pOwnerDzialalnosc], PojazdInfo[vehc][pModel], PojazdInfo[vehc][pID], PojazdInfo[vehc][pKolor], PojazdInfo[vehc][pKolor2], PojazdInfo[vehc][pPrzebieg]/1000, PojazdInfo[vehc][pStan], PojazdInfo[vehc][pPaliwo], Alarmtxt, Immotxt, CBtxt, PojazdInfo[vehc][pKanal], Audiotxt, Tempomattxt, PojazdInfo[vehc][pNaprawy]);
		TextDrawSetString(OBJ[playerid], tekst_global);
		TextDrawShowForPlayer(playerid, OBJ[playerid]);
		SetTimerEx("NapisUsunsV",15000,0,"d",playerid);
	    return 1;
	}
	return 1;
}
forward SilnikStart(vehc,vehicleid,playerid);
public SilnikStart(vehc,vehicleid,playerid)
{
	new lights,doors,bonnet,boot,objective,alarm,engine;
	if(PojazdInfo[vehc][pStan] < 500)
	{
		new sd = random(3);
		if(sd == 0)
		{
			new bzstr[124];
			format(bzstr, sizeof(bzstr), "**W pojezdzie %s silnik nie odpala, poniewa¿ jego uszkodzenia s¹ zbyt wielkie**", GetVehicleModelName(PojazdInfo[vehc][pModel]));
			SendVehText(15.0, vehicleid, bzstr, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
		}
		else
		{
			PojazdInfo[vehc][pSilnik] = 1;
			SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
			TextDrawHideForPlayer(playerid,Licznik[playerid]);
			PojazdInfo[vehc][pTimer] = SetTimerEx("MinusPaliwo", 15000, 1, "i", vehicleid);
		}
	}
	else
	{
		PojazdInfo[vehc][pSilnik] = 1;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
		TextDrawHideForPlayer(playerid,Licznik[playerid]);
		PojazdInfo[vehc][pTimer] = SetTimerEx("MinusPaliwo", 15000, 1, "i", vehicleid);
	}
	return 1;
}
CMD:pomoc(playerid, cmdtext[])
{
	//printf("U¿yta komenda pomoc");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new stats[1024];
	format(stats, sizeof(stats), "%s\n{FFFFFF}1.\t{DEDEDE}» {88b711}Pocz¹tek gry", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}2.\t{DEDEDE}» {88b711}Podstawowe komendy", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}3.\t{DEDEDE}» {88b711}IC i OOC", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}4.\t{DEDEDE}» {88b711}Animacje", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}5.\t{DEDEDE}» {88b711}Przedmioty", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}6.\t{DEDEDE}» {88b711}Pojazdy", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}7.\t{DEDEDE}» {88b711}BW", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}8.\t{DEDEDE}» {88b711}Oferty", stats);
	format(stats, sizeof(stats), "%s\n{FFFFFF}9.\t{DEDEDE}» {88b711}Prace dorywcze", stats);
	dShowPlayerDialog(playerid, DIALOG_POMOC, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Wiêcej", "Zamknij");
	return 1;
}
CMD:przejazd(playerid, params[])
{
	//printf("U¿yta komenda przejazd");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(GraczPrzetrzymywany(playerid))
	{
		return 0;
	}
	new siedzenie;
	siedzenie = GetPlayerVehicleSeat(playerid);
	if(siedzenie != 0)
	{
		return 0;
	}
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid))
	{
		for(new i = 0; i < sizeof(NieruchomoscInfo); i++)
		{
			if(NieruchomoscInfo[i][nTyp] == 0 || NieruchomoscInfo[i][nTyp] == 1)
			{
				if(Dystans(5.0, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
				{
					if(NieruchomoscInfo[i][nZamek] == 1)
					{
					    if(NieruchomoscInfo[i][nPrzejazd] == 1)
						{
		       				if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
							{
								dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE} Nie mo¿esz u¿ywaæ {88b711}animacji{DEDEDE}, gdy edytujesz obiekt!", "Zamknij", "" );
								return 0;
							}
							WejscieDoBudynku(playerid, i, vehicleid, NieruchomoscInfo[i][nVWW]);
						}
					}
					else
					{
						GameTextForPlayer(playerid,"~r~~h~Drzwi sa zamkniete.",5000,3);
					}
				}
				if(Dystans(5.0, playerid, NieruchomoscInfo[i][nXW], NieruchomoscInfo[i][nYW], NieruchomoscInfo[i][nZW]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVWW])
				{
					if(NieruchomoscInfo[i][nZamek] == 1)
					{
					    if(NieruchomoscInfo[i][nPrzejazd] == 1)
						{
						    if(GetPVarInt(playerid, "idobiktu") != 0 || GetPVarInt(playerid, "inedit") != 0)
							{
								dShowPlayerDialog( playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:","{DEDEDE} Nie mo¿esz u¿ywaæ {88b711}animacji{DEDEDE}, gdy edytujesz obiekt!", "Zamknij", "" );
								return 0;
							}
							WyjscieZBudynku(playerid, i, vehicleid, NieruchomoscInfo[i][nVW]);
						}
					}
					else
					{
						GameTextForPlayer(playerid,"~r~~h~Drzwi sa zamkniete.",5000,3);
	 				}
				}
			}
		}
	}
	return 1;
}
////////////////////////////////////////////////////////////////////////////////
forward GetPlayerID2(globalacc);
public GetPlayerID2(globalacc)
{
	ForeachEx(i, IloscGraczy)
	{
	    if(DaneGracza[KtoJestOnline[i]][gGUID] == globalacc) return KtoJestOnline[i];
	}
	return INVALID_PLAYER_ID;
}
forward PrzyObiekcie(playerid, model, wykonanie);
public PrzyObiekcie(playerid, model, wykonanie)
{
	new find = 0, Float:radius = 0.2;
	new id_budynku = GetPlayerVirtualWorld(playerid);
	for(new i = 0; i < wykonanie; i++)
	{
		ForeachEx(h, NieruchomoscInfo[id_budynku][nStworzoneObiekty])
		{
			if(Dystans(radius, playerid, ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozX],ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozY],ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objPozZ]) && GetPlayerVirtualWorld(playerid) == ObiektInfo[NieruchomoscInfo[id_budynku][nObiekty][h]][objvWorld])
			{
				find = NieruchomoscInfo[id_budynku][nObiekty][h];
				if(ObiektInfo[find][objModel] == model){
				break;
				}
			}
		}
		radius+=0.5;
	}
	if(ObiektInfo[find][objModel] == model)
	{
	    return find;
	}
	else
	{
	    return 0;
	}
}
forward ObiektwBudynku(playerid, model, uid_budynku);
public ObiektwBudynku(playerid, model, uid_budynku)
{
	new find = 0;
    ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
	{
	    if(ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objModel] == model && uid_budynku == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld])
	    {
		    find = NieruchomoscInfo[uid_budynku][nObiekty][h];
		    break;
		}
	}
	if(find != 0)
	{
	    return find;
	}
	else
	{
	    return 0;
	}
}
forward SprawdzWartoscWlacznika(playerid, model, uid_budynku, znacznik);
public SprawdzWartoscWlacznika(playerid, model, uid_budynku, znacznik)
{
	new find = 0;
    ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
	{
	    if(ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objModel] == model && uid_budynku == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld] && ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objWlacznik] == znacznik)
	    {
		    find = NieruchomoscInfo[uid_budynku][nObiekty][h];
		    break;
		}
	}
	if(find != 0)
	{
	    return find;
	}
	else
	{
	    return 0;
	}
}
forward SprawdzZnacznikWlacznika(playerid, uid_budynku);
public SprawdzZnacznikWlacznika(playerid, uid_budynku)
{
	new find = 1, znalezione[250], znacznik;
    ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
	{
	    if(ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objModel] == 364 && uid_budynku == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld])
	    {
		    znalezione[find] =  ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objWlacznik];
			new find2 = find-1;
			if(find > 1 && znalezione[find] < znalezione[find2])
			{
				znalezione[find] = znalezione[find2];
				znalezione[find2] = ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objWlacznik];
			}
			find++;
		}
	}
	new i;
	for(i = 1; i <= find; i++)
	{
		if(znalezione[i] != i)
		{
			znacznik = i;
			break;
		}
	}
	if(find !=0)
	{
		return znacznik;
	}
	else
	{
		return 0;
	}
}
forward DodajElekr(model, Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz, vw, interior, playid, wl, war);
public DodajElekr(model, Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz, vw, interior, playid, wl, war)
{
		new id = false;
		format( zapyt, sizeof( zapyt ), "INSERT INTO `five_obiekty` (`model`, `vw`, `interior`, `pozX`, `pozY`, `pozZ`, \
		`rotX`, `rotY`, `rotZ`, `WLACZNIK`, `WARTOSC`) VALUES (%d, %d, %d, %f, %f, %f, %f, %f, %f, %d, %d)",
		 model, vw, interior, x, y, z, rotx, roty, rotz, wl, war);
		mysql_query(zapyt);
		id = mysql_insert_id();
		ObiektInfo[id][objUID] = id;
		ObiektInfo[id][objModel] = model;
		ObiektInfo[id][objvWorld] = vw;
		ObiektInfo[id][objInterior] = interior;
		ObiektInfo[id][objPozX] = x;
		ObiektInfo[id][objPozY] = y;
		ObiektInfo[id][objPozZ] = z;
		ObiektInfo[id][objPosX] = 0;
		ObiektInfo[id][objPosY] = 0;
		ObiektInfo[id][objPosZ] = 0;
		ObiektInfo[id][objBrama] = 0;
		ObiektInfo[id][objSprarowanyUID] = 0;
		ObiektInfo[id][objRotX] = rotx;
		ObiektInfo[id][objRotY] = roty;
		ObiektInfo[id][objRotZ] = rotz;
		ObiektInfo[id][objWlacznik] = wl;
		ObiektInfo[id][objWartosc] = war;
		ObiektInfo[id][objSAMP] = CreateDynamicObject(ObiektInfo[id][objModel], ObiektInfo[id][objPozX],
		ObiektInfo[id][objPozY], ObiektInfo[id][objPozZ], ObiektInfo[id][objRotX], ObiektInfo[id][objRotY],
		ObiektInfo[id][objRotZ], ObiektInfo[id][objvWorld], ObiektInfo[id][objInterior]);
		obiektinedit[id] = true;
		SetPVarInt(playid, "inedit", id);
		NieruchomoscInfo[ObiektInfo[id][objvWorld]][nStworzoneObiekty]++;
		for(new i = 0; i < 2048; i++)
		{
			if(NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] == 0)
		    {
				NieruchomoscInfo[ObiektInfo[id][objvWorld]][nObiekty][i] = ObiektInfo[id][objUID];
				break;
		    }
		}
		return id;
}
/*forward CoPietnacieSekund();
public CoPietnacieSekund()
{
	ForeachEx(i, IloscGraczy)
	{
		RemovePlayerAttachedObject(KtoJestOnline[i];, 1);
		SetPlayerAttachedObject(KtoJestOnline[i];, 1,18698,5,0.000000,0.000000,0.0,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000);
	}
	return 1;
}*/
forward Naprawa(v2,vir);
public Naprawa(v2,vir)
{
    SetVehicleVirtualWorld(v2,vir);
	return 1;
}
CMD:taguj(playerid, params[])
{
	//printf("U¿yta komenda taguj");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!UprawnienieNaSluzbie(playerid, U_ZARZ_TAGAMI))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby rozpocz¹æ proces {88b711}tagowania{DEDEDE} musisz wejœæ na s³u¿bê dzia³alnoœci, która posiada uprawnienia do tagowania.", "Zamknij", "");
		return 1;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		return 0;
	}
	if(!GraczaMaTypPrzedmiotuWu(playerid, 1, 41))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby rozpocz¹æ {88b711}tagowanie{DEDEDE} musisz trzymaæ w rêce spray.", "Zamknij", "");
		return 0;
	}
	if(NaprawiaCzas[playerid] != 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}naprawiasz{DEDEDE} jakiœ pojazd.", "Zamknij", "");
		return 0;
	}
	if(LakierujeCzas[playerid] != 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie {88b711}lakierujesz{DEDEDE} jakiœ pojazd.", "Zamknij", "");
		return 0;
	}
	new uid_obiektu = PrzyObiekcie(playerid, 18663, 5);
	if(uid_obiektu != 0)
	{
		if(ObiektInfo[uid_obiektu][gZajety] == 0)
		{
			dShowPlayerDialog(playerid, DIALOG_TAG, DIALOG_STYLE_INPUT, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Rozpocz¹³eœ proces {88b711}tagowania{DEDEDE} poni¿ej wpisz tag jaki ma siê pokazaæ po {88b711}zakoñczeniu{DEDEDE} tego procesu.\nAby przenieœæ wyraz poni¿ej u¿yj '*'\nAby pokolorowaæ tekst u¿yj '(kolor html) np (FF0000)Tekst(000000)Tekst'\nPrzyklad: '(FF0000)Five*(FFFFFF)Boxton*Crips'\n{DEDEDE}\n\t\t{FF0000}Five\n\t\t{FFFFFF}Boxton\n\t\tCrips", "Zatwierdz", "Zamknij");
			Tag[playerid] = uid_obiektu;
			ObiektInfo[uid_obiektu][gZajety] = 1;
		}
		else
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aktualnie ktoœ edytuje ten {88b711}tag{DEDEDE}, poszukaj innego.", "Zamknij", "");
		}
	}else{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteœ zbyt daleko od tagu.", "Zamknij", "");
	}
	return 1;
}
forward CoSekunde();
public CoSekunde()
{
	new godzina,
		minuta,
        second;
    gettime(godzina, minuta, second);
 	new m[3];
	getdate(m[0], m[1], m[2]);
    if(minuta == 00 && second == 00)
    {
		SetWorldTime(godzina);
		foreach(Player, i)
		SetPlayerTime(i,godzina,minuta);
		strdel(tekst_global, 0, 2048);
		format(tekst_global, sizeof(tekst_global), "** Dzwony w ratuszu bij¹ %d razy. **", godzina);
		SendClientMessageToAll(0xC2A2DAAA, tekst_global);

	}
	if(Xkara != 0)
	{
		Xkara--;
		if(Xkara < 1)
		{
			TextDrawHideForAll(Textdrawodkar);
			Xkara = 0;
		}
	}
	if(SNINFO != 0)
	{
		SNINFO--;
		if(SNINFO < 1)
		{
			TextDrawHideForAll(LosSantosFM);
			SNINFO = 0;
		}
	}
	if(ogmx > 0)
	{
		strdel(tekst_global, 0, 2048);
	    format( tekst_global, sizeof(tekst_global), "~w~Restart serwera za:~r~ %d", ogmx);
	    GameTextForAll( tekst_global, 1000, 6 );
	    ogmx--;
	    if(ogmx == 0)
	    {
	        ogmx = 0;
	        GameTextForAll( "~w~Restart serwera:~r~ wykonany", 3000, 6 );
			ForeachEx(i, MAX_VEH)
			{
				if(PojazdInfo[i][pSpawn] == 1)
				{
					PojazdInfo[i][pPrzepchany] = 1;
				}
			}
	        SendRconCommand("gmx");
	    }
	}
	ForeachEx(playerid, IloscGraczy)
	{
		if(IsPlayerConnected(KtoJestOnline[playerid]) && DaneGracza[KtoJestOnline[playerid]][gUID] != 0)
		{
		    if(zalogowany[KtoJestOnline[playerid]] == true)
		    {
				UpdateCameras(KtoJestOnline[playerid]);
				if(DaneGracza[KtoJestOnline[playerid]][gAJ] > 0)
				{
					DaneGracza[KtoJestOnline[playerid]][gAJ]--;
					if(DaneGracza[KtoJestOnline[playerid]][gAJ] == 0)
					{
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 5;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "Koniec AJ.");
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						SetPVarInt(KtoJestOnline[playerid], "Teleportacja", 1);
						SpawnPlayer(KtoJestOnline[playerid]);
						SetPVarInt(KtoJestOnline[playerid], "Teleportacja", 0);
					}
					else
					{
						new ga, ma, sa, str[256];
						strdel(str, 0, 256);
						przeliczniksectoh(DaneGracza[KtoJestOnline[playerid]][gAJ], ga, ma, sa);
						format(str, sizeof(str), "~w~Pozostala: ~r~%d ~y~min ~r~%d ~y~sec.",ma ,sa);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], str);
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						if(!IsPlayerInRangeOfPoint(KtoJestOnline[playerid], 10.0, 1174.3706,-1180.3267,87.0350))
						{
							Teleportuj(KtoJestOnline[playerid],1174.3706,-1180.3267,87.0350);
						}
					}
				}
				/*if(DaneGracza[KtoJestOnline[playerid]][gBW] > 0)
				{
					DaneGracza[KtoJestOnline[playerid]][gBW]--;
					if(DaneGracza[KtoJestOnline[playerid]][gBW] == 0)
					{
						UstawHP(KtoJestOnline[playerid],9);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 5;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "Koniec BW.");
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						Frezuj(KtoJestOnline[playerid], 1);
						ClearAnimations(KtoJestOnline[playerid]);
						ApplyAnimation(KtoJestOnline[playerid], "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
						SetCameraBehindPlayer(KtoJestOnline[playerid]);
						RefreshNick(KtoJestOnline[playerid]);
						SetPlayerDrunkLevel(KtoJestOnline[playerid], 10000);
						if(DaneGracza[KtoJestOnline[playerid]][gGlod] <= 20)
						{
							DaneGracza[KtoJestOnline[playerid]][gGlod] = 20;
							SetProgressBarValue(PasekGlodu[KtoJestOnline[playerid]], DaneGracza[KtoJestOnline[playerid]][gGlod]);
							if(PasekGloduWLACZONY[KtoJestOnline[playerid]] != 0)
							{
								ShowProgressBarForPlayer(KtoJestOnline[playerid], PasekGlodu[KtoJestOnline[playerid]]);
							}
						}
					}
					else
					{
						UstawHP(KtoJestOnline[playerid],100);
						Teleportuj(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gX],DaneGracza[KtoJestOnline[playerid]][gY],DaneGracza[KtoJestOnline[playerid]][gZ]);
						SetPlayerCameraPos(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gX]-3, DaneGracza[KtoJestOnline[playerid]][gY],DaneGracza[KtoJestOnline[playerid]][gZ]+7);
						SetPlayerCameraLookAt(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gX],DaneGracza[KtoJestOnline[playerid]][gY],DaneGracza[KtoJestOnline[playerid]][gZ]);
						SetPlayerVirtualWorld(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gVW]);
						SetPlayerInterior(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gINT]);
						new gs, ms, ss, str[256];
						strdel(str, 0, 256);
						przeliczniksectoh(DaneGracza[KtoJestOnline[playerid]][gBW], gs, ms, ss);
						format(str, sizeof(str), "~w~Pozostala: ~r~%d ~y~min ~r~%d ~y~sec.",ms ,ss);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], str);
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TogglePlayerControllable(KtoJestOnline[playerid], 0);
						ApplyAnimation(KtoJestOnline[playerid], "PED", "FLOOR_hit", 4.1, 0, 1, 1, 1, 1);
					}
				}*/
				if(DaneGracza[KtoJestOnline[playerid]][gBW] > 0 && DaneGracza[KtoJestOnline[playerid]][gAJ] == 0)
				{
					DaneGracza[KtoJestOnline[playerid]][gBW]--;
					if(DaneGracza[KtoJestOnline[playerid]][gBW] == 0)
					{
						UstawHP(KtoJestOnline[playerid],9);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 5;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "Koniec BW.");
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						Frezuj(KtoJestOnline[playerid], 1);
						ClearAnimations(KtoJestOnline[playerid]);
						ApplyAnimation(KtoJestOnline[playerid], "CARRY", "crry_prtial", 4, 0, 0, 0, 0, 0, 0);
						SetCameraBehindPlayer(KtoJestOnline[playerid]);
						RefreshNick(KtoJestOnline[playerid]);
						SetPlayerDrunkLevel(KtoJestOnline[playerid], 10000);
						if(DaneGracza[KtoJestOnline[playerid]][gGlod] <= 20)
						{
							DaneGracza[KtoJestOnline[playerid]][gGlod] = 20;
							SetProgressBarValue(PasekGlodu[KtoJestOnline[playerid]], DaneGracza[KtoJestOnline[playerid]][gGlod]);
							if(PasekGloduWLACZONY[KtoJestOnline[playerid]] != 0)
							{
								ShowProgressBarForPlayer(KtoJestOnline[playerid], PasekGlodu[KtoJestOnline[playerid]]);
							}
						}
					}
					else
					{
						UstawHP(KtoJestOnline[playerid],100);
						if(!IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
						{
							Teleportuj(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gX],DaneGracza[KtoJestOnline[playerid]][gY],DaneGracza[KtoJestOnline[playerid]][gZ]);
							ApplyAnimation(KtoJestOnline[playerid], "PED", "FLOOR_hit", 4.1, 0, 1, 1, 1, 1);
						}
						SetPlayerCameraPos(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gX]-3, DaneGracza[KtoJestOnline[playerid]][gY],DaneGracza[KtoJestOnline[playerid]][gZ]+7);
						SetPlayerCameraLookAt(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gX],DaneGracza[KtoJestOnline[playerid]][gY],DaneGracza[KtoJestOnline[playerid]][gZ]);
						SetPlayerVirtualWorld(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gVW]);
						SetPlayerInterior(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gINT]);
						new gs, ms, ss, str[256];
						strdel(str, 0, 256);
						przeliczniksectoh(DaneGracza[KtoJestOnline[playerid]][gBW], gs, ms, ss);
						format(str, sizeof(str), "~w~Pozostala: ~r~%d ~y~min ~r~%d ~y~sec.",ms ,ss);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], str);
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TogglePlayerControllable(KtoJestOnline[playerid], 0);
						//test/ApplyAnimation(KtoJestOnline[playerid], "PED", "FLOOR_hit", 4.1, 0, 1, 1, 1, 1);
					}
				}
				if(Pracuje[KtoJestOnline[playerid]] != 0)
				{
					if(DaneGracza[KtoJestOnline[playerid]][gSwp] > 0)
					{
						DaneGracza[KtoJestOnline[playerid]][gSwp]--;
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 5;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						new taxistra[256];
						format(taxistra, sizeof(taxistra), "~w~Czas do pokonania trasy: ~r~%d ~w~sec",DaneGracza[KtoJestOnline[playerid]][gSwp]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], taxistra);
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						if(DaneGracza[KtoJestOnline[playerid]][gSwp] < 1)
						{
							CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
							TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "Spozniles sie do nastepnego checkpointa, zlecenie zostalo anulowane.");
							TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							Pracuje[KtoJestOnline[playerid]] = 0;
							new Float: x, Float: y, Float: z;
							GetPlayerPos(KtoJestOnline[playerid], x, y, z);
							Teleportuj(KtoJestOnline[playerid], x, y, z + 5);
							PlayerPlaySound(KtoJestOnline[playerid], 1190, 0.0, 0.0, 0.0);
							DaneGracza[KtoJestOnline[playerid]][gSwp] = 0;
							DaneGracza[KtoJestOnline[playerid]][gCheckopintID] = 0;
							DaneGracza[KtoJestOnline[playerid]][gWyscig] = 0;
							DaneGracza[KtoJestOnline[playerid]][gCheckopintID] = 0;
							DisablePlayerRaceCheckpoint(KtoJestOnline[playerid]);
							DaneGracza[KtoJestOnline[playerid]][gKoniecWyscigu] = 0;
							DaneGracza[KtoJestOnline[playerid]][gRaceTimeStart] = 0;
						}
					}
					if(GraczJestAFK(KtoJestOnline[playerid]))
					{
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
						TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "Wysiadles z pojazdu, zlecenie zostalo anulowane.");
						TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
						Pracuje[KtoJestOnline[playerid]] = 0;
						RemovePlayerFromVehicle(KtoJestOnline[playerid]);
						RemovePlayerFromVehicle(KtoJestOnline[playerid]);
						CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
					}
				}
				if(taxijedz[KtoJestOnline[playerid]] != 0)
				{
					new vid = GetPVarInt(KtoJestOnline[playerid], "przejazvid");
					new vuid = GetPVarInt(KtoJestOnline[playerid], "przejazuid");
					new guid = GetPVarInt(KtoJestOnline[playerid], "przejazguid");
					new cena = GetPVarInt(KtoJestOnline[playerid], "przejazcena");
					new Float:przejechal, Float:cenak;
					przejechal = (PojazdInfo[vuid][pPrzebieg]/1000)-GetPVarFloat(KtoJestOnline[playerid], "przejechanes");
					cenak = przejechal*cena;
					if(zalogowany[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == true)
					{
						if(GetPlayerVehicleID(GetPVarInt(KtoJestOnline[playerid], "przejazt")) == vid)
						{
							if(IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
							{
								if(GetPlayerState(KtoJestOnline[playerid]) == PLAYER_STATE_PASSENGER)
								{
									if(DaneGracza[KtoJestOnline[playerid]][gPORTFEL] <= floatround(cenak))
									{
										new taxistr[256],taxisstr[256];
										format(taxistr, sizeof(taxistr), "~y~~h~Nie stac cie na dalsza podroz.",przejechal,floatround( cenak ));
										GameTextForPlayer(KtoJestOnline[playerid],taxistr,5000,4);
										format(taxisstr, sizeof(taxisstr), "~y~~h~Gracz ktorego wieziesz nie ma wystarczajacej gotowki.",przejechal,floatround( cenak ));
										GameTextForPlayer(GetPVarInt(KtoJestOnline[playerid], "przejazt"),taxisstr,5000,4);
									}else{
										new taxistr[256],taxisstr[256];
										format(taxistr, sizeof(taxistr), "~y~~h~Przejechane: ~w~%0.03fkm~n~~b~~h~~h~Koszt: %d$",przejechal,floatround( cenak ));
										GameTextForPlayer(KtoJestOnline[playerid],taxistr,5000,4);
										format(taxisstr, sizeof(taxisstr), "~y~~h~Przejechane: ~w~%0.03fkm~n~~b~~h~~h~Koszt: %d$",przejechal,floatround( cenak ));
										GameTextForPlayer(GetPVarInt(KtoJestOnline[playerid], "przejazt"),taxisstr,5000,4);
									}
								}
								/*else
								{
									taxijedz[KtoJestOnline[playerid]] = 0;
									DisablePlayerCheckpoint(GetPVarInt(KtoJestOnline[playerid], "przejazt"));
								}*/
							}
							else
							{
								if(DaneGracza[KtoJestOnline[playerid]][gPORTFEL] < floatround( cenak ))
								{
									cenak = DaneGracza[KtoJestOnline[playerid]][gPORTFEL];
								}
								strdel(tekst_global, 0, 2048);
								format(tekst_global, sizeof(tekst_global), "podaje %d$.", floatround( cenak ));
								cmd_fasdasfdfive(KtoJestOnline[playerid], tekst_global);
								new procent = floatround(cenak/10);
								if(procent > 20)
								{
									procent = 20;
								}
								DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPremia] += procent;
								GrupaInfo[guid][gSaldo] += (floatround( cenak )-procent);
								ZapiszSaldo(guid);
								if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 1) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][3]++;
								else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 2) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][9]++;
								else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 3) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][15]++;
								else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 4) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][21]++;
								else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 5) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][27]++;
								else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 6) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][33]++;
								StatykujTransakcje(guid, GetPVarInt(KtoJestOnline[playerid], "przejazt"), KtoJestOnline[playerid], "Przejazd", floatround( cenak ));
								Dodajkase( KtoJestOnline[playerid], -floatround( cenak ) );
								DisablePlayerCheckpoint(GetPVarInt(KtoJestOnline[playerid], "przejazt"));
								taxijedz[KtoJestOnline[playerid]] = 0;
								//GameTextForPlayer(KtoJestOnline[playerid], "~r~Kierowca nie jest zalogowany.", 3000, 5);
							}
						}
						else
						{
							if(DaneGracza[KtoJestOnline[playerid]][gPORTFEL] < floatround( cenak ))
							{
								cenak = DaneGracza[KtoJestOnline[playerid]][gPORTFEL];
							}
							strdel(tekst_global, 0, 2048);
							format(tekst_global, sizeof(tekst_global), "podaje %d$.", floatround( cenak ));
							cmd_fasdasfdfive(KtoJestOnline[playerid], tekst_global);
							new procent = floatround(cenak/10);
							if(procent > 20)
							{
								procent = 20;
							}
							DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPremia] += procent;
							GrupaInfo[guid][gSaldo] += (floatround( cenak )-procent);
							ZapiszSaldo(guid);
							if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 1) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][3]++;
							else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 2) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][9]++;
							else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 3) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][15]++;
							else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 4) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][21]++;
							else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 5) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][27]++;
							else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 6) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][33]++;
							StatykujTransakcje(guid, GetPVarInt(KtoJestOnline[playerid], "przejazt"), KtoJestOnline[playerid], "Przejazd", floatround( cenak ));
							Dodajkase( KtoJestOnline[playerid], -floatround( cenak ) );
							DisablePlayerCheckpoint(GetPVarInt(KtoJestOnline[playerid], "przejazt"));
							taxijedz[KtoJestOnline[playerid]] = 0;
							GameTextForPlayer(KtoJestOnline[playerid], "~r~Kierowca wyszedl z pojazdu.", 3000, 5);
						}
					}
					else
					{
						if(DaneGracza[KtoJestOnline[playerid]][gPORTFEL] < floatround( cenak ))
						{
							cenak = DaneGracza[KtoJestOnline[playerid]][gPORTFEL];
						}
						strdel(tekst_global, 0, 2048);
						format(tekst_global, sizeof(tekst_global), "podaje %d$.", floatround( cenak ));
						cmd_fasdasfdfive(KtoJestOnline[playerid], tekst_global);
						new procent = floatround(cenak/10);
						if(procent > 20)
						{
							procent = 20;
						}
						DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPremia] += procent;
						GrupaInfo[guid][gSaldo] += (floatround( cenak )-procent);
						ZapiszSaldo(guid);
						if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 1) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][3]++;
						else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 2) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][9]++;
						else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 3) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][15]++;
						else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 4) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][21]++;
						else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 5) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][27]++;
						else if(DutyNR[GetPVarInt(KtoJestOnline[playerid], "przejazt")] == 6) DaneGracza[GetPVarInt(KtoJestOnline[playerid], "przejazt")][gPrzynaleznosci][33]++;
						StatykujTransakcje(guid, GetPVarInt(KtoJestOnline[playerid], "przejazt"), KtoJestOnline[playerid], "Przejazd", floatround( cenak ));
						Dodajkase( KtoJestOnline[playerid], -floatround( cenak ) );
						new taxisstr[124];
						format(taxisstr, sizeof(taxisstr), "~b~~h~~h~Przychod: %d$",floatround( cenak ));
						GameTextForPlayer(GetPVarInt(KtoJestOnline[playerid], "przejazt"),taxisstr,5000,4);
						DisablePlayerCheckpoint(GetPVarInt(KtoJestOnline[playerid], "przejazt"));
						taxijedz[KtoJestOnline[playerid]] = 0;
					}
				}
				if(DaneGracza[KtoJestOnline[playerid]][gSluzba] == 0)
				{
					GPS[KtoJestOnline[playerid]] = 0;
				}
				if(GPS[KtoJestOnline[playerid]] == 1)
				{
					new slot = 0, Float:pozycjax, Float:pozycjay, Float:pozycjaz;
					ForeachEx(playeridg, IloscGraczy)
					{
						if(DaneGracza[KtoJestOnline[playerid]][gSluzba] == DaneGracza[KtoJestOnline[playeridg]][gSluzba] && IsPlayerInAnyVehicle(KtoJestOnline[playerid]) && KtoJestOnline[playerid] != KtoJestOnline[playeridg] && GetPlayerState(KtoJestOnline[playeridg])==PLAYER_STATE_DRIVER)
						{
							slot++;
							GetPlayerPos(KtoJestOnline[playeridg], pozycjax, pozycjay, pozycjaz);
							SetPlayerMapIcon( KtoJestOnline[playerid], slot, pozycjax, pozycjay, pozycjaz, 55, 0, MAPICON_GLOBAL );
						}
					}
				}
			/*	else if(GPS[KtoJestOnline[playerid]] == 0)
				{
					ForeachEx(ilosc, 99)
					{
						RemovePlayerMapIcon( KtoJestOnline[playerid], ilosc );
					}
				}*/
				if(DaneGracza[KtoJestOnline[playerid]][gRaceTimeStart] > 0)
				{
					DaneGracza[KtoJestOnline[playerid]][gRaceTimeStart]--;
					strdel(tekst_global, 0, 2048);
					if(DaneGracza[KtoJestOnline[playerid]][gRaceTimeStart] > 0)
					{
						format(tekst_global, sizeof(tekst_global), "~w~%d", DaneGracza[KtoJestOnline[playerid]][gRaceTimeStart]);
						PlayerPlaySound(KtoJestOnline[playerid], 1056, 0.0, 0.0, 0.0);
					}
					else
					{
						format(tekst_global, sizeof(tekst_global), "~r~S~b~T~p~A~g~R~w~T");
						DaneGracza[KtoJestOnline[playerid]][gWyscigCzasLast] = gettime();
						Frezuj(KtoJestOnline[playerid], 1);
						PlayerPlaySound(KtoJestOnline[playerid], 1057, 0.0, 0.0, 0.0);
					}
					GameTextForPlayer(KtoJestOnline[playerid], tekst_global, 1000, 4);
				}
				if(LakierujeCzas[KtoJestOnline[playerid]] != 0)
				{
					if(Tag[KtoJestOnline[playerid]] != -1)
					{
						if(GetPlayerVirtualWorld(KtoJestOnline[playerid]) != 0)
						{
							GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Tagowanie przerwane!", 1000,3);
							UpdateDynamic3DTextLabelText(ObiektInfo[Tag[KtoJestOnline[playerid]]][objNapis], 0xC2A2DAFF, " ");
							Tag[KtoJestOnline[playerid]] = -1;
							RoznicaLakieru[KtoJestOnline[playerid]] = 0;
							LakierujeCzas[KtoJestOnline[playerid]] = 0;
						}
						new bron_uid = GetPVarInt(KtoJestOnline[playerid], "UzywanaBronUID");
						if(GetDistanceToTag(KtoJestOnline[playerid], Tag[KtoJestOnline[playerid]]) > 5.0) 
						{
							if(LakierujeCzas[KtoJestOnline[playerid]] == 5)
							{
								GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Tagowanie przerwane!", 1000,3);
								UpdateDynamic3DTextLabelText(ObiektInfo[Tag[KtoJestOnline[playerid]]][objNapis], 0xC2A2DAFF, " ");
								RoznicaLakieru[KtoJestOnline[playerid]] = 0;
								ObiektInfo[Tag[KtoJestOnline[playerid]]][gZajety] = 0;
								Tag[KtoJestOnline[playerid]] = -1;
								LakierujeCzas[KtoJestOnline[playerid]] = 0;
							}
							else
							{
								GameTextForPlayer(KtoJestOnline[playerid], "~r~Nie oddalaj sie od tagu!", 1000, 3);
								LakierujeCzas[KtoJestOnline[playerid]]++;
							}
							PoziomLakieru[KtoJestOnline[playerid]] = PrzedmiotInfo[bron_uid][pWar2];
						}
						else
						{
							if(!IsPlayerFacingTag(KtoJestOnline[playerid], Tag[KtoJestOnline[playerid]]))
							{
								if(LakierujeCzas[KtoJestOnline[playerid]] == 5)
								{
									GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Tagowanie przerwane!", 1000,3);
									UpdateDynamic3DTextLabelText(ObiektInfo[Tag[KtoJestOnline[playerid]]][objNapis], 0xC2A2DAFF, " ");
									ObiektInfo[Tag[KtoJestOnline[playerid]]][gZajety] = 0;
									RoznicaLakieru[KtoJestOnline[playerid]] = 0;
									Tag[KtoJestOnline[playerid]] = -1;
									LakierujeCzas[KtoJestOnline[playerid]] = 0;
								}else{
									GameTextForPlayer(KtoJestOnline[playerid],"~w~odwroc sie w strone ~n~tagu, inaczej tagowanie zostanie ~r~przerwane~w~!", 1000, 3);
									PoziomLakieru[KtoJestOnline[playerid]] = PrzedmiotInfo[bron_uid][pWar2];
									LakierujeCzas[KtoJestOnline[playerid]]++;
								}
							}
							else
							{
								LakierujeCzas[KtoJestOnline[playerid]] = 1;
								new Float:of;
								of = (RoznicaLakieru[KtoJestOnline[playerid]] * 100) / 5000;
								if(GetPlayerWeapon(KtoJestOnline[playerid]) == 41 && PoziomLakieru[KtoJestOnline[playerid]] > PrzedmiotInfo[bron_uid][pWar2])
								{
									new str[126];
									RoznicaLakieru[KtoJestOnline[playerid]] += PoziomLakieru[KtoJestOnline[playerid]]-PrzedmiotInfo[bron_uid][pWar2];
									format(str, 126, "Malowanie tagu.\nUkoñczone w %0.0f%%", of);
									UpdateDynamic3DTextLabelText(ObiektInfo[Tag[KtoJestOnline[playerid]]][objNapis], 0xC2A2DAFF, str);
									PoziomLakieru[KtoJestOnline[playerid]] = PrzedmiotInfo[bron_uid][pWar2];//100/5000*2500
								}
								if(of >= 100.0)
								{
									GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Tagowanie zakonczone", 3000,4);
									new sted[256];
									new pmsg[256];
									GetPVarString(KtoJestOnline[playerid], "tagnapis", pmsg, 256);
									format(sted, sizeof(sted), "%s",pmsg);
									DodajTexture(Tag[KtoJestOnline[playerid]], 1, 0, 100, "Mistral", 74, 0, "0xFF88b711", "0", 1, sted);
									UpdateDynamic3DTextLabelText(ObiektInfo[Tag[KtoJestOnline[playerid]]][objNapis], 0xC2A2DAFF, " ");
									RoznicaLakieru[KtoJestOnline[playerid]] = 0;
									ObiektInfo[Tag[KtoJestOnline[playerid]]][gZajety] = 0;
									Tag[KtoJestOnline[playerid]] = -1;
									LakierujeCzas[KtoJestOnline[playerid]] = 0;
								}
							}
						}
					}
					else
					{
						if(GetPlayerVirtualWorld(KtoJestOnline[playerid]) != NaprawianieVW[KtoJestOnline[playerid]] || GetPlayerVirtualWorld(NaprawiaID[KtoJestOnline[playerid]]) != NaprawianieVW[KtoJestOnline[playerid]] || GetVehicleVirtualWorld(NaprawiaVeh[KtoJestOnline[playerid]]) != NaprawianieVW[KtoJestOnline[playerid]])
						{
							GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Malowanie przerwane!", 3000,4);
							RoznicaLakieru[KtoJestOnline[playerid]] = 0;
							NaprawiaID[KtoJestOnline[playerid]] = 0;
							UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pID]], 0xAAAAFFFF, " ");
							LakierujeCzas[KtoJestOnline[playerid]] = 0;
							GameTextForPlayer(NaprawiaID[KtoJestOnline[playerid]], "~n~~g~Malowanie przerwane!", 5000, 3);
							NaprawianieVW[KtoJestOnline[playerid]] = 0;
						}
						if(zalogowany[NaprawiaID[KtoJestOnline[playerid]]] == false)
						{
							GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Malowanie przerwane!", 3000,4);
							RoznicaLakieru[KtoJestOnline[playerid]] = 0;
							UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pID]], 0xAAAAFFFF, " ");
							LakierujeCzas[KtoJestOnline[playerid]] = 0;
							NaprawiaID[KtoJestOnline[playerid]] = 0;
							GameTextForPlayer(NaprawiaID[KtoJestOnline[playerid]], "~n~~g~Malowanie przerwane!", 5000, 3);
							NaprawianieVW[KtoJestOnline[playerid]] = 0;
							GameTextForPlayer(KtoJestOnline[playerid], "~r~~h~Gracz ktoremu lakierowales pojazd wyszedl z serwera.", 5000, 3);
						}
						new bron_uid = GetPVarInt(KtoJestOnline[playerid], "UzywanaBronUID");
						if(GetDistanceToCar(KtoJestOnline[playerid], MalowanieKolor[KtoJestOnline[playerid]][2]) > 3.0) 
						{
							if(LakierujeCzas[KtoJestOnline[playerid]] == 5)
							{
								GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Malowanie przerwane!", 3000,4);
								RoznicaLakieru[KtoJestOnline[playerid]] = 0;
								NaprawiaID[KtoJestOnline[playerid]] = 0;
								UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pID]], 0xAAAAFFFF, " ");
								LakierujeCzas[KtoJestOnline[playerid]] = 0;
							}
							else
							{
								GameTextForPlayer(KtoJestOnline[playerid], "~r~Nie oddalaj sie od pojazdu!", 1000, 3);
								LakierujeCzas[KtoJestOnline[playerid]]++;
							}
							PoziomLakieru[KtoJestOnline[playerid]] = PrzedmiotInfo[bron_uid][pWar2];
						}
						else
						{
							if(!IsPlayerFacingVehicle(KtoJestOnline[playerid], MalowanieKolor[KtoJestOnline[playerid]][2]))
							{
								GameTextForPlayer(KtoJestOnline[playerid],"~w~odwroc sie w strone ~n~auta, inaczej malowanie zostanie ~r~przerwane~w~!", 3000, 3);
								PoziomLakieru[KtoJestOnline[playerid]] = PrzedmiotInfo[bron_uid][pWar2];
								LakierujeCzas[KtoJestOnline[playerid]]++;
							}
							else
							{
								LakierujeCzas[KtoJestOnline[playerid]] = 1;
								new Float:of;
								if(PJ[KtoJestOnline[playerid]] == 1)
								{
									of = (RoznicaLakieru[KtoJestOnline[playerid]] * 100) / 10000;
								}
								else
								{
									of = (RoznicaLakieru[KtoJestOnline[playerid]] * 100) / 5000;
								}
								if(GetPlayerWeapon(KtoJestOnline[playerid]) == 41 && PoziomLakieru[KtoJestOnline[playerid]] > PrzedmiotInfo[bron_uid][pWar2])
								{
									new str[126];
									new model = GetVehicleModel(MalowanieKolor[KtoJestOnline[playerid]][2])-400;
									RoznicaLakieru[KtoJestOnline[playerid]] += PoziomLakieru[KtoJestOnline[playerid]]-PrzedmiotInfo[bron_uid][pWar2];
									format(str, 126, "Malowanie pojazdu %s.\nUkoñczone w %0.0f%%",NazwyAut[model], of);
									UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pID]], 0xAAAAFFFF, str);
									PoziomLakieru[KtoJestOnline[playerid]] = PrzedmiotInfo[bron_uid][pWar2];//100/5000*2500
								}
								if(of >= 100.0)
								{
									ForeachEx(x, IloscGraczy)
									{
										if(PlayerObokPojazdu(KtoJestOnline[x],	MalowanieKolor[KtoJestOnline[playerid]][2]) < 10.0)
										{
											PlayerPlaySound(KtoJestOnline[playerid], 1134, 0.0, 0.0, 10.0);
										}
									}
									GameTextForPlayer(KtoJestOnline[playerid],"~n~~g~Przemalowano", 3000,4);
									UpdateDynamic3DTextLabelText(Vopis[PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pID]], 0xAAAAFFFF, " ");
									if(PJ[KtoJestOnline[playerid]] == 1)
									{
										PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pPJ] = MalowanieKolor[KtoJestOnline[playerid]][0];
										ChangeVehiclePaintjob(MalowanieKolor[KtoJestOnline[playerid]][2], MalowanieKolor[KtoJestOnline[playerid]][0]);
									}
									else
									{
										PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pKolor] = MalowanieKolor[KtoJestOnline[playerid]][0];
										PojazdInfo[MalowanieKolor[KtoJestOnline[playerid]][3]][pKolor2] = MalowanieKolor[KtoJestOnline[playerid]][1];
										ChangeVehicleColor(MalowanieKolor[KtoJestOnline[playerid]][2], MalowanieKolor[KtoJestOnline[playerid]][0], MalowanieKolor[KtoJestOnline[playerid]][1]);
									}
									MalowanieKolor[KtoJestOnline[playerid]][0] = -1;
									MalowanieKolor[KtoJestOnline[playerid]][1] = -1;
									RoznicaLakieru[KtoJestOnline[playerid]] = 0;
									LakierujeCzas[KtoJestOnline[playerid]] = 0;
									ZapiszPojazd(MalowanieKolor[KtoJestOnline[playerid]][3], 1);
								}
							}
						}
					}
				}
				if(OferujeA[KtoJestOnline[playerid]] != -1)
				{
					if(zalogowany[OferujeA[KtoJestOnline[playerid]]] == false)
					{
						GameTextForPlayer(KtoJestOnline[playerid],"~n~~r~Gracz ktoremu oferowales przedmiot opusicil serwer.", 3000,4);
						OferujeA[KtoJestOnline[playerid]] = -1;
					}
					else
					{
						SelectTextDraw(OferujeA[KtoJestOnline[playerid]], 0xFF4040AA);
					}
				}
				if(WybralMozliwoscPoker[KtoJestOnline[playerid]] != 0)
				{
					SelectTextDraw(KtoJestOnline[playerid], 0xFFFFFFFF);
					//new tresc_wiadomosci[124];
					//format(tresc_wiadomosci, sizeof(tresc_wiadomosci), "~w~Masz ~r~%d ~w~sec~n~ na wykonanie ruchu", WybralMozliwoscPoker[KtoJestOnline[playerid]]);
					//GameTextForPlayer(KtoJestOnline[playerid], tresc_wiadomosci, 1000, 3);
					new uid_stolu = DaneGracza[KtoJestOnline[playerid]][gPoker];
					for(new i = 0; i < 6; i++)
					{
						if(ObiektInfo[uid_stolu][objPoker][i] != -1 && GraWPokera[KtoJestOnline[playerid]] != 0)
						{
							switch(DaneGracza[KtoJestOnline[playerid]][gPokerStanowisko])
							{
								case 0:{
									PlayerTextDrawHide(ObiektInfo[uid_stolu][objPoker][i],KartyGracza1[ObiektInfo[uid_stolu][objPoker][i]]);
								}
								case 1:{
									PlayerTextDrawHide(ObiektInfo[uid_stolu][objPoker][i],KartyGracza2[ObiektInfo[uid_stolu][objPoker][i]]);
								}
								case 2:{
									PlayerTextDrawHide(ObiektInfo[uid_stolu][objPoker][i],KartyGracza3[ObiektInfo[uid_stolu][objPoker][i]]);
								}
								case 3:{
									PlayerTextDrawHide(ObiektInfo[uid_stolu][objPoker][i],KartyGracza4[ObiektInfo[uid_stolu][objPoker][i]]);
								}
								case 4:{
									PlayerTextDrawHide(ObiektInfo[uid_stolu][objPoker][i],KartyGracza5[ObiektInfo[uid_stolu][objPoker][i]]);
								}
								case 5:{
									PlayerTextDrawHide(ObiektInfo[uid_stolu][objPoker][i],KartyGracza6[ObiektInfo[uid_stolu][objPoker][i]]);
								}
							}
						}
					}
					new Float:wartosc = 1.666*WybralMozliwoscPoker[KtoJestOnline[playerid]] + 4;
					OdswiesBarGracza(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gPoker], wartosc);
					WybralMozliwoscPoker[KtoJestOnline[playerid]]--;
					if(WybralMozliwoscPoker[KtoJestOnline[playerid]] == 0)
					{
						WybralMozliwoscPoker[KtoJestOnline[playerid]] = 0;
						for(new i = 0; i < 6; i++)
						{
							if(ObiektInfo[DaneGracza[KtoJestOnline[playerid]][gPoker]][gAktualniGracze][i] == KtoJestOnline[playerid])
							{
								ObiektInfo[DaneGracza[KtoJestOnline[playerid]][gPoker]][gAktualniGracze][i] = -1;
								DaneGracza[KtoJestOnline[playerid]][gPokerKarty][0] = 0;
								DaneGracza[KtoJestOnline[playerid]][gPokerKarty][1] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][0] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][1] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][2] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][3] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][4] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][5] = 0;
								DaneGracza[KtoJestOnline[playerid]][gInformacjePoker][6] = 0;
							}
						}
						PlayerTextDrawHide(KtoJestOnline[playerid],Poker2[KtoJestOnline[playerid]]);
						PlayerTextDrawHide(KtoJestOnline[playerid],Poker3[KtoJestOnline[playerid]]);
						PlayerTextDrawHide(KtoJestOnline[playerid],Poker4[KtoJestOnline[playerid]]);
						PlayerTextDrawHide(KtoJestOnline[playerid],Poker5[KtoJestOnline[playerid]]);
						PlayerTextDrawHide(KtoJestOnline[playerid],Poker6[KtoJestOnline[playerid]]);
						new ilosc = SprawdzIloscGraczy(DaneGracza[KtoJestOnline[playerid]][gPoker]);
						if(ilosc >= 2)
						{
							SprawdzKolejGracza(KtoJestOnline[playerid]);
						}
						else
						{
							KoniecRundy(DaneGracza[KtoJestOnline[playerid]][gPoker]);
						}
						dShowPlayerDialog(KtoJestOnline[playerid], DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czas na wybranie mo¿liwosci{88b711} min¹³{DEDEDE} - system wybra³ za ciebie opcje \"Pasuje\"", "Zamknij", "");
						CancelSelectTextDraw(KtoJestOnline[playerid]);
					}
				}
				if(WpisalKase[KtoJestOnline[playerid]] != 0)
				{
					new tresc_wiadomosci[124];
					format(tresc_wiadomosci, sizeof(tresc_wiadomosci), "~w~Masz ~r~%d ~w~sec na wpisanie kwoty", WpisalKase[KtoJestOnline[playerid]]);
					GameTextForPlayer(KtoJestOnline[playerid], tresc_wiadomosci, 1000, 4);
					WpisalKase[KtoJestOnline[playerid]]--;
					if(WpisalKase[KtoJestOnline[playerid]] == 0)
					{
						new id_pokera = DaneGracza[KtoJestOnline[playerid]][gPoker];
						for(new i = 0; i < 6; i++)
						{
							if(ObiektInfo[id_pokera][objPoker][i] == KtoJestOnline[playerid])
							{
								ObiektInfo[id_pokera][objPoker][i] = -1;
								DaneGracza[KtoJestOnline[playerid]][gPoker] = 0;
								DaneGracza[KtoJestOnline[playerid]][gPokerStanowisko] = 0;
								break;
							}
						}
						Frezuj(KtoJestOnline[playerid],1);
						SetCameraBehindPlayer(KtoJestOnline[playerid]);
						WpisalKase[KtoJestOnline[playerid]] = 0;
						GraWPokera[KtoJestOnline[playerid]] = 0;
						dShowPlayerDialog(KtoJestOnline[playerid], DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Czas na wpisanie kwoty{88b711} min¹³{DEDEDE} - aby do³¹czyæ do gry wpisz /poker", "Zamknij", "");
						return 0;
					}
				}
				if(DaneGracza[KtoJestOnline[playerid]][gRundaPokerCzas] != 0)
				{
					new tresc_wiadomosci1[124];
					format(tresc_wiadomosci1, sizeof(tresc_wiadomosci1), "Oczekiwanie na graczy, rozpoczecie rundy za ~r~%d~w~ sec", DaneGracza[KtoJestOnline[playerid]][gRundaPokerCzas]);
					GameTextForPlayer(KtoJestOnline[playerid], tresc_wiadomosci1, 1000, 5);
					DaneGracza[KtoJestOnline[playerid]][gRundaPokerCzas]--;
					if(DaneGracza[KtoJestOnline[playerid]][gRundaPokerCzas] == 0)
					{
						ObiektInfo[DaneGracza[KtoJestOnline[playerid]][gPoker]][gRundaPoker] = 1;
						DaneGracza[KtoJestOnline[playerid]][gRundaPokerCzas] = 0;
						RozpocznijPokera(KtoJestOnline[playerid], DaneGracza[KtoJestOnline[playerid]][gPoker]);
					}
				}
				if(DaneGracza[KtoJestOnline[playerid]][gPrzetrzmanie] != 0)
				{
					if(!GraczPrzetrzymywany(KtoJestOnline[playerid]))
					{
						new vw = DaneGracza[KtoJestOnline[playerid]][gPUID];
						DaneGracza[KtoJestOnline[playerid]][gPrzetrzmanie] = 0;
						RefreshNick(KtoJestOnline[playerid]);
						SendClientMessage(KtoJestOnline[playerid], 0xFFb00000, "{CC0000}Twoje przetrzymanie siê skoñczy³o.");
						if(NieruchomoscInfo[vw][nWlascicielD] != 0)
						{
							ForeachEx(is, IloscGraczy)
							{
								if(DaneGracza[KtoJestOnline[is]][gDzialalnosc1] == NieruchomoscInfo[vw][nWlascicielD] ||
								DaneGracza[KtoJestOnline[is]][gDzialalnosc2] == NieruchomoscInfo[vw][nWlascicielD] ||
								DaneGracza[KtoJestOnline[is]][gDzialalnosc3] == NieruchomoscInfo[vw][nWlascicielD] ||
								DaneGracza[KtoJestOnline[is]][gDzialalnosc4] == NieruchomoscInfo[vw][nWlascicielD] ||
								DaneGracza[KtoJestOnline[is]][gDzialalnosc5] == NieruchomoscInfo[vw][nWlascicielD] ||
								DaneGracza[KtoJestOnline[is]][gDzialalnosc6] == NieruchomoscInfo[vw][nWlascicielD])
								{
									new strs[256];
									format(strs, sizeof(strs), "{CC0000}Przetrzymanie gracza: %s (ID:%d) siê skoñczy³o.",ZmianaNicku(KtoJestOnline[playerid]), KtoJestOnline[playerid]);
									SendClientMessage(KtoJestOnline[is], 0xFFb00000, strs);
								}
							}
						}else{
							new strs[256];
							format(strs, sizeof(strs), "{CC0000}Przetrzymanie gracza: %s (ID:%d) siê skoñczy³o.",ZmianaNicku(KtoJestOnline[playerid]), KtoJestOnline[playerid]);
							SendClientMessage(KtoJestOnline[playerid], 0xFFb00000, strs);
						}
					}
				}
		        if(NaprawiaCzas[KtoJestOnline[playerid]] > 0)
		        {
		            if(GetPlayerVirtualWorld(KtoJestOnline[playerid]) != NaprawianieVW[KtoJestOnline[playerid]] || GetPlayerVirtualWorld(NaprawiaID[KtoJestOnline[playerid]]) != NaprawianieVW[KtoJestOnline[playerid]] || GetVehicleVirtualWorld(NaprawiaVeh[KtoJestOnline[playerid]]) != NaprawianieVW[KtoJestOnline[playerid]])
                    {
                    	GameTextForPlayer(KtoJestOnline[playerid], "~r~~h~Naprawa pojazdu zostala zakonczona niepowodzeniem.", 5000, 3);
                        GameTextForPlayer(NaprawiaID[KtoJestOnline[playerid]], "~r~~h~Naprawa pojazdu zostala zakonczona niepowodzeniem.", 5000, 3);
                        NaprawiaODL[KtoJestOnline[playerid]] = 0;
                        NaprawiaID[KtoJestOnline[playerid]] = 0;
                        NaprawianieVW[KtoJestOnline[playerid]] = 0;
						NaprawiaVeh[KtoJestOnline[playerid]] = 0;
						NaprawiaIUID[KtoJestOnline[playerid]] = 0;
						NaprawiaCzas[KtoJestOnline[playerid]] = 0;
						DeletePVar(KtoJestOnline[playerid],"TypM");
                    }
                    if(PlayerObokPojazdu(KtoJestOnline[playerid],	NaprawiaVeh[KtoJestOnline[playerid]]) > 5.0)
                    {
                        GameTextForPlayer(KtoJestOnline[playerid], "Jestes zbyt daleko naprawianego pojazdu.", 1000, 3);
                        NaprawiaODL[KtoJestOnline[playerid]]++;
                        if(NaprawiaODL[KtoJestOnline[playerid]] == 5)
                        {
                            NaprawiaODL[KtoJestOnline[playerid]] = 0;
                            GameTextForPlayer(NaprawiaID[KtoJestOnline[playerid]], "~g~~h~Anulowano montaz komponentu.", 5000, 3);
                            NaprawiaID[KtoJestOnline[playerid]] = 0;
						    NaprawiaVeh[KtoJestOnline[playerid]] = 0;
						    NaprawiaIUID[KtoJestOnline[playerid]] = 0;
						    NaprawianieVW[KtoJestOnline[playerid]] = 0;
						    NaprawiaCzas[KtoJestOnline[playerid]] = 0;
						    DeletePVar(KtoJestOnline[playerid],"TypM");
						    GameTextForPlayer(KtoJestOnline[playerid], "~g~~h~Anulowales montaz komponentu.", 5000, 3);
                        }
                    }
                    else
                    {
						NaprawiaODL[KtoJestOnline[playerid]] = 0;
                        if(zalogowany[NaprawiaID[KtoJestOnline[playerid]]] == false)
                        {
                            NaprawiaODL[KtoJestOnline[playerid]] = 0;
                            NaprawiaID[KtoJestOnline[playerid]] = 0;
                            NaprawianieVW[KtoJestOnline[playerid]] = 0;
						    NaprawiaVeh[KtoJestOnline[playerid]] = 0;
						    NaprawiaIUID[KtoJestOnline[playerid]] = 0;
						    NaprawiaCzas[KtoJestOnline[playerid]] = 0;
						    DeletePVar(KtoJestOnline[playerid],"TypM");
						    GameTextForPlayer(KtoJestOnline[playerid], "~r~~h~Gracz ktoremu montowales komponent wyszedl z serwera.", 5000, 3);
                        }
                        new uzy = GetPVarInt(KtoJestOnline[playerid], "UzytyItem");
                        if(NaprawiaIUID[KtoJestOnline[playerid]] == -1)
                        {
							strdel(tekst_global, 0, 2048);
                            NaprawiaODL[KtoJestOnline[playerid]] = 0;
					        NaprawiaCzas[KtoJestOnline[playerid]]--;
				    		format( tekst_global, sizeof(tekst_global), "~w~Naprawianie:~r~ %d sec", NaprawiaCzas[KtoJestOnline[playerid]]);
				    		GameTextForPlayer(KtoJestOnline[playerid], tekst_global, 1000, 6);
				    		format( tekst_global, sizeof(tekst_global), "~w~Naprawianie:~r~ %d sec", NaprawiaCzas[KtoJestOnline[playerid]]);
				    		GameTextForPlayer(NaprawiaID[KtoJestOnline[playerid]], tekst_global, 1000, 6);
					        if(NaprawiaCzas[KtoJestOnline[playerid]]==0)
					        {
					            new Float:HvP;
								GetVehicleHealth(NaprawiaVeh[KtoJestOnline[playerid]], HvP);
					            new calkowita = NaprawianieCena[KtoJestOnline[playerid]] + (1000 - floatround(HvP));
	                        	Oferuj(KtoJestOnline[playerid], NaprawiaID[KtoJestOnline[playerid]], NaprawiaIUID[KtoJestOnline[playerid]], 0, 0, 0, OFEROWANIE_AKC_NAP, calkowita, "", 0);
					        }
                        }
                        else
                        {
	                        if(PrzedmiotInfo[uzy][pOwner] == DaneGracza[KtoJestOnline[playerid]][gUID] && PrzedmiotInfo[uzy][pTypWlas] == TYP_WLASCICIEL)
	                        {
		                        NaprawiaODL[KtoJestOnline[playerid]] = 0;
					            NaprawiaCzas[KtoJestOnline[playerid]]--;
				    			format( tekst_global, sizeof(tekst_global), "~w~Naprawianie:~r~ %d sec", NaprawiaCzas[KtoJestOnline[playerid]]);
				    			GameTextForPlayer(KtoJestOnline[playerid], tekst_global, 1000, 6);
				    			format( tekst_global, sizeof(tekst_global), "~w~Naprawianie:~r~ %d sec", NaprawiaCzas[KtoJestOnline[playerid]]);
				    			GameTextForPlayer(NaprawiaID[KtoJestOnline[playerid]], tekst_global, 1000, 6);
					            if(NaprawiaCzas[KtoJestOnline[playerid]]==0)
					            {
	                                Oferuj(KtoJestOnline[playerid], NaprawiaID[KtoJestOnline[playerid]], NaprawiaIUID[KtoJestOnline[playerid]], 0, 0, 0, OFEROWANIE_AKC_NAP, NaprawianieCena[KtoJestOnline[playerid]], "", 0);
					            }
				            }
				            else
							{
							    NaprawiaODL[KtoJestOnline[playerid]] = 0;
	                            NaprawiaID[KtoJestOnline[playerid]] = 0;
	                            NaprawianieVW[KtoJestOnline[playerid]] = 0;
							    NaprawiaVeh[KtoJestOnline[playerid]] = 0;
							    NaprawiaIUID[KtoJestOnline[playerid]] = 0;
							    NaprawiaCzas[KtoJestOnline[playerid]] = 0;
							    DeletePVar(KtoJestOnline[playerid],"TypM");
							    GameTextForPlayer(KtoJestOnline[playerid], "~g~~h~Montaz komponentu zostala anulowana~n~przedmiot ktory oferowales nie znajduje sie w twoim ekwipunku.", 5000, 3);
							}
						}
		            }
		        }
				if(DaneGracza[KtoJestOnline[playerid]][gKajdanki] != -1 && !IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
				{
					if(zalogowany[DaneGracza[KtoJestOnline[playerid]][gKajdanki]] == false)
					{
						DaneGracza[KtoJestOnline[playerid]][gKajdanki] = -1;
						DaneGracza[DaneGracza[KtoJestOnline[playerid]][gKajdanki]][gKajdankiS] = 0;
						SetPlayerSpecialAction(KtoJestOnline[playerid],SPECIAL_ACTION_NONE);
						RemovePlayerAttachedObject(KtoJestOnline[playerid], 1);
						Frezuj(KtoJestOnline[playerid], 1);
						GameTextForPlayer(KtoJestOnline[playerid], "~r~Gracz ktory cie skul opuscil serwer.", 3000, 5);
					}
					if(DaneGracza[DaneGracza[KtoJestOnline[playerid]][gKajdanki]][gAJ] != 0)
					{
						DaneGracza[KtoJestOnline[playerid]][gKajdanki] = -1;
						DaneGracza[DaneGracza[KtoJestOnline[playerid]][gKajdanki]][gKajdankiS] = 0;
						SetPlayerSpecialAction(KtoJestOnline[playerid],SPECIAL_ACTION_NONE);
						RemovePlayerAttachedObject(KtoJestOnline[playerid], 1);
						Frezuj(KtoJestOnline[playerid], 1);
						GameTextForPlayer(KtoJestOnline[playerid], "~r~Gracz ktory cie skul dostal admin jaila.", 3000, 5);
					}
					else
					{
						new Float:x, Float:y, Float:z;
						GetPlayerPos(DaneGracza[KtoJestOnline[playerid]][gKajdanki], x, y, z);
						Teleportuj(KtoJestOnline[playerid], x + 2, y, z);
						SetPlayerVirtualWorld(KtoJestOnline[playerid], GetPlayerVirtualWorld(DaneGracza[KtoJestOnline[playerid]][gKajdanki]));
						SetPlayerInterior(KtoJestOnline[playerid], GetPlayerInterior(DaneGracza[KtoJestOnline[playerid]][gKajdanki]));
					}
				}
				if(DaneGracza[KtoJestOnline[playerid]][gSznur] != -1 && !IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
				{
					if(zalogowany[DaneGracza[KtoJestOnline[playerid]][gSznur]] == false)
					{
						DaneGracza[KtoJestOnline[playerid]][gSznur] = -1;
						Frezuj(KtoJestOnline[playerid], 1);
						GameTextForPlayer(KtoJestOnline[playerid], "~r~Gracz ktory cie skul opuscil serwer.", 3000, 5);
					}
					else
					{
						new Float:x, Float:y, Float:z;
						GetPlayerPos(DaneGracza[KtoJestOnline[playerid]][gSznur], x, y, z);
						Teleportuj(KtoJestOnline[playerid], x + 2, y, z);
						SetPlayerVirtualWorld(KtoJestOnline[playerid], GetPlayerVirtualWorld(DaneGracza[KtoJestOnline[playerid]][gSznur]));
						SetPlayerInterior(KtoJestOnline[playerid], GetPlayerInterior(DaneGracza[KtoJestOnline[playerid]][gSznur]));
					}
				}
		        if(Wylogowany[KtoJestOnline[playerid]] > 0)
				{
					Wylogowany[KtoJestOnline[playerid]]--;
					if(Wylogowany[KtoJestOnline[playerid]] == 0)
					{
						Wylogowany[KtoJestOnline[playerid]] = 0;
					}
				}
		        if(!GraczJestAFK(KtoJestOnline[playerid]))
		        {
				    new vw = GetPlayerVirtualWorld(KtoJestOnline[playerid]);
					DaneGracza[KtoJestOnline[playerid]][gCZAS_ONLINE]++;
					if(DutyAdmina[playerid] == 1) DaneGracza[KtoJestOnline[playerid]][gSLUZBAA]++;
					new g, mss, s;
					przelicznikonline(KtoJestOnline[playerid], g, mss, s);
					if(g >= 10)
					{
						if(!Osiagniecia(KtoJestOnline[playerid], OSIAGNIECIE_10H))
						{
							CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
							TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "~y~OSIAGNIECIE~n~~w~Zasiedlony (10h) ~g~+50GS");
							TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							DaneGracza[KtoJestOnline[playerid]][gOsiagniecia][OSIAGNIECIE_10H] = 1;
							DaneGracza[KtoJestOnline[playerid]][gGAMESCORE] += 50;
							SetPlayerScore(KtoJestOnline[playerid],DaneGracza[KtoJestOnline[playerid]][gGAMESCORE]);
							ZapiszGraczaGlobal(playerid, 1);
						}
					}
					if(g >= 50)
					{
						if(!Osiagniecia(KtoJestOnline[playerid], OSIAGNIECIE_50H))
						{
							CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
							TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "~y~OSIAGNIECIE~n~~w~Mieszkaniec (50h) ~g~+150GS");
							TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							DaneGracza[KtoJestOnline[playerid]][gOsiagniecia][OSIAGNIECIE_50H] = 1;
							DaneGracza[KtoJestOnline[playerid]][gGAMESCORE] += 150;
							SetPlayerScore(KtoJestOnline[playerid],DaneGracza[KtoJestOnline[playerid]][gGAMESCORE]);
							ZapiszGraczaGlobal(playerid, 1);
						}
					}
					if(g >= 100)
					{
						if(!Osiagniecia(KtoJestOnline[playerid], OSIAGNIECIE_100H))
						{
							CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] = 30;
							TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							TextDrawSetString(TextNaDrzwi[KtoJestOnline[playerid]], "~y~OSIAGNIECIE~n~~w~Staly gracz (100h) ~g~+500GS");
							TextDrawShowForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
							DaneGracza[KtoJestOnline[playerid]][gOsiagniecia][OSIAGNIECIE_100H] = 1;
							DaneGracza[KtoJestOnline[playerid]][gGAMESCORE] += 500;
							SetPlayerScore(KtoJestOnline[playerid],DaneGracza[KtoJestOnline[playerid]][gGAMESCORE]);
							ZapiszGraczaGlobal(playerid, 1);
						}
					}
					if(DaneGracza[KtoJestOnline[playerid]][gSluzba] != 0)
					{
						if(GrupaInfo[DaneGracza[KtoJestOnline[playerid]][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA || GrupaInfo[DaneGracza[KtoJestOnline[playerid]][gSluzba]][gTyp] == DZIALALNOSC_ZMOTORYZOWANA || GrupaInfo[DaneGracza[KtoJestOnline[playerid]][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS ||
						GrupaInfo[DaneGracza[KtoJestOnline[playerid]][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA  || GrupaInfo[DaneGracza[KtoJestOnline[playerid]][gSluzba]][gTyp] == DZIALALNOSC_GANGI  || GrupaInfo[DaneGracza[KtoJestOnline[playerid]][gSluzba]][gTyp] == DZIALALNOSC_ELEKTRTYKA)
					    {
							if(DutyNR[KtoJestOnline[playerid]] == 1)
						    {
						    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][1]++;
							}
							else if(DutyNR[KtoJestOnline[playerid]] == 2)
						    {
						    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][7]++;
							}
							else if(DutyNR[KtoJestOnline[playerid]] == 3)
						    {
						    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][13]++;
							}
							else if(DutyNR[KtoJestOnline[playerid]] == 4)
						    {
						    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][19]++;
							}
							else if(DutyNR[KtoJestOnline[playerid]] == 5)
						    {
						    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][25]++;
							}
							else if(DutyNR[KtoJestOnline[playerid]] == 6)
						    {
						    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][31]++;
							}
						}
						else
						{
						    if(IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
						    {
							    new vehicleid = GetPlayerVehicleID(KtoJestOnline[playerid]);
								new veh = SprawdzCarUID(vehicleid);
								if(PojazdInfo[veh][pOwnerDzialalnosc] == DaneGracza[KtoJestOnline[playerid]][gSluzba] && PojazdInfo[veh][pOwnerPostac] == 0)
								{
	                                if(DutyNR[KtoJestOnline[playerid]] == 1)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][1]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 2)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][7]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 3)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][13]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 4)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][19]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 5)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][25]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 6)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][31]++;
									}
								}
		                    }
						    else
							{
							    if(NieruchomoscInfo[vw][nWlascicielD] == DaneGracza[KtoJestOnline[playerid]][gSluzba])
							    {
							        if(DutyNR[KtoJestOnline[playerid]] == 1)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][1]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 2)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][7]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 3)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][13]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 4)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][19]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 5)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][25]++;
									}
									else if(DutyNR[KtoJestOnline[playerid]] == 6)
								    {
								    	DaneGracza[KtoJestOnline[playerid]][gPrzynaleznosci][31]++;
									}
							    }
						    }
					    }
					}
				}
				PRZEBYTE[KtoJestOnline[playerid]]++;
		        if(BUSS[KtoJestOnline[playerid]] != 0)
				{
					strdel(tekst_global, 0, 2048);
					format(tekst_global, sizeof(tekst_global), "~n~~n~~n~~n~~n~~y~Pozostalo: ~p~%d ~y~sekund~n~podrozy.", BUSS[KtoJestOnline[playerid]]);
					GameTextForPlayer(KtoJestOnline[playerid], tekst_global, 1000, 3);
					BUSS[KtoJestOnline[playerid]]--;
				}
			}
			if(CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] > 0)
			{
				CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]]--;
				if(CzasWyswietlaniaTextuNaDrzwiach[KtoJestOnline[playerid]] == 0)
				{
					TextDrawHideForPlayer(KtoJestOnline[playerid], TextNaDrzwi[KtoJestOnline[playerid]]);
				}
			}
			if(DaneGracza[KtoJestOnline[playerid]][gCzasTrwaniaUzaleznienia] > 0)
			{
				if(Extasa[KtoJestOnline[playerid]] > gettime() || LSD[KtoJestOnline[playerid]] > gettime() || Grzyby[KtoJestOnline[playerid]] > gettime())
				{
					SetPlayerWeather(KtoJestOnline[playerid],-66);
				}
				if(LSD[KtoJestOnline[playerid]] > gettime() && !IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
				{
					OnPlayerText(KtoJestOnline[playerid], ".pijak");
				}
				if(Mefedron[KtoJestOnline[playerid]] > gettime())
				{
					if(DaneGracza[KtoJestOnline[playerid]][gZDROWIE]+5 >= 100)
					{
						DaneGracza[KtoJestOnline[playerid]][gZDROWIE] = 100;
						UstawHP(KtoJestOnline[playerid],DaneGracza[KtoJestOnline[playerid]][gZDROWIE]);
					}
					else
					{
						DodajHP(KtoJestOnline[playerid], 5);
					}
				}
				DaneGracza[KtoJestOnline[playerid]][gCzasTrwaniaUzaleznienia]--;
				if(DaneGracza[KtoJestOnline[playerid]][gCzasTrwaniaUzaleznienia] == 0)
				{
					SetPlayerWeather(KtoJestOnline[playerid], 2);
					OnPlayerText(KtoJestOnline[playerid], "-stopani");
					RefreshNick(KtoJestOnline[playerid]);
				}
				new rand = random(10);
				if(rand == 0 || rand == 2 || rand == 4 || rand == 6 || rand == 8 || rand == 10)
				{
					FadeColorForPlayer(KtoJestOnline[playerid], 255, 0, 255, floatround(90),255,0,0,0,floatround(10),0);
				}
			}
			if(Dostal[KtoJestOnline[playerid]] != 0)
			{
				Dostal[KtoJestOnline[playerid]]--;
				if(Dostal[KtoJestOnline[playerid]] == 0)
				{
					Frezuj(KtoJestOnline[playerid], 1);
					OnPlayerText(KtoJestOnline[playerid], "-stopani");
				}
			}
			if(FrezzPlayer[KtoJestOnline[playerid]] != 0)
			{
				FrezzPlayer[KtoJestOnline[playerid]]--;
				if(FrezzPlayer[KtoJestOnline[playerid]] == 0)
				{
					Frezuj(KtoJestOnline[playerid], 1);
				}
			}
	        new keysa, uda, lra;
	   		GetPlayerKeys(KtoJestOnline[playerid], keysa, uda, lra);
	        if(uda & KEY_UP || uda & KEY_DOWN || lra & KEY_LEFT || lra & KEY_RIGHT)
	        {
	        	if(AFK[KtoJestOnline[playerid]] == 1)
					GraczWrocilZAFK(KtoJestOnline[playerid]);
			}
		}
	}
	return 1;
}
stock SetWeaponAmmo(playerid, weaponid, ammo)
{
    for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo2;
		GetPlayerWeaponData(playerid, slot, wep, ammo2);
    	if(wep == weaponid)
    	{
    	    SetPlayerAmmo(playerid, slot, ammo);
			return 1;
    	}
	}
	return 0;
}
forward GetPlayerWeaponAmmo(playerid, weaponid);
public GetPlayerWeaponAmmo(playerid, weaponid)
{
	new zwrot, weapons[13][2];
	ForeachEx(i, 13)
	{
		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
		if(weapons[i][0] == weaponid)
		{
			zwrot = weapons[i][1];
		}
	}
	return zwrot;
}
stock Pokazstatsy(playerid)
{
	new stats[1024], IP[16], plec_gracza[24], praca_gracza[24];
	GetPlayerIp(playerid, IP, sizeof(IP));
	new g, m, s;
	new GLOD = DaneGracza[playerid][gGlod]-4;
	przelicznikonline(playerid, g, m, s);
	GetPlayerHealth(playerid,ACHP);
	switch(DaneGracza[playerid][gPLEC])
	{
		case 0:{
			plec_gracza = "Mê¿czyzna";
		}
		case 1:{
			plec_gracza = "Kobieta"; 
		}
	}
	switch(DaneGracza[playerid][gPracaTyp])
	{
		case 0:{
			praca_gracza = "Brak";
		}
		case 1:{
			praca_gracza = "Sprz¹tacz Ulic";
		}
		case 2:{
			praca_gracza = "Wêdkarz";
		}
		case 3:{
			praca_gracza = "Pomocnik Stacji";
		}
		case 4:{
			praca_gracza = "Kurier";
		}
	}
	format(stats, sizeof(stats), "%s\n{88B711}Podstawowe Informacje", stats);
	format(stats, sizeof(stats), "%s\n\tGlobalny Nick: \t\t%s", stats, DaneGracza[playerid][nickOOC]);
	format(stats, sizeof(stats), "%s\n\tCzas Online: \t\t%dh, %dm, %ds", stats, g,m,s);
	format(stats, sizeof(stats), "%s\n\tGameScore: \t\t%d", stats, DaneGracza[playerid][gGAMESCORE]);
	format(stats, sizeof(stats), "%s\n{88B711}Dotycz¹ce Postaci", stats);
	format(stats, sizeof(stats), "%s\n\tImie Nazwisko: \t\t%s", stats, ImieGracza2(playerid));
	format(stats, sizeof(stats), "%s\n\tWiek: \t\t\t%d lat", stats, DaneGracza[playerid][gWIEK]);
	format(stats, sizeof(stats), "%s\n\tPochodzenie: \t\t%s", stats, DaneGracza[playerid][gPOCHODZENIE]);
	format(stats, sizeof(stats), "%s\n\tPlec: \t\t\t%s", stats, plec_gracza);
	format(stats, sizeof(stats), "%s\n\tZdrowie: \t\t%0.1f", stats, DaneGracza[playerid][gZDROWIE]);
	format(stats, sizeof(stats), "%s\n\tG³ód: \t\t\t%d", stats, GLOD);
	format(stats, sizeof(stats), "%s\n\tUzale¿nienie: \t\t%0.1f", stats, DaneGracza[playerid][gUzaleznienie]);
	format(stats, sizeof(stats), "%s\n\tSila: \t\t\t%dj", stats, DaneGracza[playerid][gSILA]);
	//format(stats, sizeof(stats), "%s\n\tWaga: \t\t\t%dkg", stats, DaneGracza[playerid][gWAGA]);
	format(stats, sizeof(stats), "%s\n\tRasa: \t\t\t%s", stats, DaneGracza[playerid][gRASA]);
	format(stats, sizeof(stats), "%s\n\tStan Cywilny: \t\t%s", stats, DaneGracza[playerid][gSTAN_CYWILNY]);
	format(stats, sizeof(stats), "%s\n\tPraca Dodatkowa: \t%s", stats, praca_gracza);
	format(stats, sizeof(stats), "%s\n\tSkin: \t\t\tUbranie[%d]", stats, DaneGracza[playerid][gSKIN]);
	format(stats, sizeof(stats), "%s\n{88B711}Opcje Postaci", stats);
	format(stats, sizeof(stats), "%s\n\tAnimacja chodzenia: \t[%d]", stats, DaneGracza[playerid][gTYPCHODZENIA]);
	format(stats, sizeof(stats), "%s\n{88B711}Zasoby Postaci", stats);
	format(stats, sizeof(stats), "%s\n\tPortfel: \t\t%d$", stats, DaneGracza[playerid][gPORTFEL]);
 	if(DaneGracza[playerid][gKONTO_W_BANKU] != 0)
 	{
        format(stats, sizeof(stats), "%s\n\tStan Konta: \t\t%d$", stats, DaneGracza[playerid][gSTAN_KONTA]);
		format(stats, sizeof(stats), "%s\n\tKredyt: \t\t\t%d$", stats, DaneGracza[playerid][gKREDYT]);
		format(stats, sizeof(stats), "%s\n\tNazwa Banku: \t\t%s", stats, DaneGracza[playerid][gNAZWA_BANKU]);
		format(stats, sizeof(stats), "%s\n\tNumer Konta: \t\t%d", stats, DaneGracza[playerid][gNUMER_KONTA]);
		format(stats, sizeof(stats), "%s\n\tNumer Karty: \t\t%d", stats, DaneGracza[playerid][gNUMER_KARTY]);
		format(stats, sizeof(stats), "%s\n\tBIC: \t\t\t%s", stats, DaneGracza[playerid][gBIC]);
		format(stats, sizeof(stats), "%s\n\tIBAN: \t\t\t%s", stats, DaneGracza[playerid][gIBAN]);
	}
	strdel(tekst_global, 0, 2048);
	format(tekst_global,sizeof(tekst_global),"%s (ID: %d, UID: %d, GUID %d) [%s]",ImieGracza2(playerid),playerid,DaneGracza[playerid][gUID],DaneGracza[playerid][gGUID],IP);
	dShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_LIST, tekst_global, stats, "Zamknij", "");
	return 1;
}
stock PoczatekGry(playerid)
{
	new stats[2048];
	format(stats, sizeof(stats), "%s\n{DEDEDE}Witaj na {88b711}Five Role Play{DEDEDE}! Poni¿ej znajdziesz kilka", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}wskazówek, jak odnaleŸæ siê w wirtualnym œwiecie.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Swoj¹ przygodê rozpoczynasz na spawnie, jakim jest {88b711}Stacja", stats);
	format(stats, sizeof(stats), "%s\n{88b711}Autobusowa{DEDEDE}. Mo¿esz po prostu kupiæ bilet i dojechaæ autobusem do ", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}wybranego miejsca. Dopóki nie przegrasz 3 godzin bilety s¹ darmowe.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Je¿eli preferujesz Taxówkê, mo¿esz po prostu po ni¹ zadzwoniæ z telefonu,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}który znajdziesz w sklepach 24/7 lub skorzystaæ z budki telefonicznej -", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}rozmieszczone s¹ po ca³ym mieœcie. Nie mo¿esz nocowaæ na dworcu, wiêc", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}musisz udaæ siê do jakiegoœ hotelu i wynaj¹æ pokój. Warto by by³o równie¿", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}pojechaæ do {88b711}urzêdu{DEDEDE} w celu wyrobienia niezbêdnych", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}dokumentów. Je¿eli chodzi o pracê, to mo¿esz wys³aæ swoje CV za", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}poœrednictwem internetu (forum) lub osobiœcie porozmawiaæ z kierownikiem", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}b¹dŸ szefem danego lokalu. Mo¿esz te¿ podj¹æ siê pracy dorywczej, które", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}przydzielane s¹ przez Urz¹d.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Na forum w dziale \"{88b711}Poradniki{DEDEDE}\" znajdziesz bardziej", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}obszerne informacje dotycz¹ce ca³ego œwiata Role Play na naszym serwerze.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Musisz wiedzieæ, ¿e Administracja nigdy nie poprosi Ciê o has³o, za", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}wszelk¹ cenê nie podawaj go nikomu poniewa¿ mo¿e to doprowadziæ do", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}kradzie¿y konta lub wykradniêcia wirtualnego maj¹tku.", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock PodstawoweKomendy(playerid)
{
	new stats[1024];
	format(stats, sizeof(stats), "%s\n{DEDEDE}Komendy: /q (Wyjœcie z gry) /wyloguj i /qs (relog) /me (Opis zdarzenia)", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}/do (Opis otoczenia) /c (szept) /k (Krzyk) /w (prywatna wiadomoœæ) /re", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}(OdpowiedŸ na prywatn¹ wiadomoœæ) /b (czat OOC) /dg (Grupy) /v (Pojazd)", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}/p (Przedmioty) /o (Oferty) /anim (Lista animacji) /kup (Kupno w sklepie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}24/7) /przebierz (przebranie w ubranie s³u¿bowe) /raport (Zg³oszenie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}gracza administracji) /stats (Statusy postaci) /plac, /drzwi, /pokaz,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}/tog, /brama, /sprobuj, /wyrzuc, /a", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock ICOOC(playerid)
{
	new stats[1024];
	format(stats, sizeof(stats), "%s\n{DEDEDE}W œwiecie Role Play wyró¿niamy dwa rodzaje czatów: {88b711}IC{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}oraz {88b711}OOC{DEDEDE}.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}1. Czat {88b711}IC{DEDEDE} (In Character) dotyczy tylko i wy³¹cznie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}postaci odgrywanych przez graczy i nie mog¹ byæ w nim zawarte informacje", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}z poza wirtualnego œwiata.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}2. Czat {88b711}OOC{DEDEDE} (Out Of Character) dotyczy wszelkich spraw,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}które nie s¹ zwi¹zane z postaci¹ przez postacie odgrywane przez graczy i", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}pochodz¹ ze œwiata realnego (OOC).", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}3. Informacji ze œwiata realnego, czyli OOC nie mo¿na podawaæ na czacie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}IC. Zjawisko to nazywamy MetaGamingiem, który jest odpowiednio karany.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}4. Komendy do pisania na czatach IC i OOC znajdziesz w /pomoc, dzia³", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}\"{88b711}Komendy{DEDEDE}\".", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock Animacje(playerid)
{
	new stats[1024];
	format(stats, sizeof(stats), "%s\n{DEDEDE}Nasz serwer oferuje mo¿liwoœæ korzystania z animacji. Mog¹ one s³u¿yæ za", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}uzupe³nienie akcji Role Play rozgrywanych na {88b711}/me{DEDEDE} i", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}{88b711}/do{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}S¹ dwa sposoby na u¿ycie animacji:", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}1. Na czacie wpisujemy jej nazwê poprzedzon¹ kropk¹, np.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}\"{88b711}-idz6{DEDEDE}\"", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}2. U¿ywamy komendy {88b711}/anim{DEDEDE} i z listy wybieramy po¿¹dan¹", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}animacjê.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Pamiêtaj, ¿e niektóre animacje musz¹ byæ u¿yte dwa razy, poniewa¿ za", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}pierwszym razem siê nie w³¹czaj¹. Wina nie le¿y po naszej stronie. Do ich", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}zakoñczenia u¿ywamy prawego przycisku myszy, b¹dŸ awaryjnie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}\"{88b711}-stopani{DEDEDE}\".", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock PrzedmiotyPomoc(playerid)
{
	new stats[1524];
	format(stats, sizeof(stats), "%s\n{DEDEDE}System przedmiotów jest funkcjonalny i intuicyjny. Dostêp do przedmiotów,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}które mamy przy sobie mo¿na uzyskaæ za pomoc¹ komendy {88b711}/p{DEDEDE}.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}S¹ one przedstawione w formie listy i po klikniêciu w któryœ z nich mamy", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}do wyboru kilka opcji.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Przedmiotu mo¿emy u¿yæ, zniszczyæ go, oferowaæ komuœ za pewn¹ kwotê lub", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}za darmo (wystarczy wpisaæ 0 w okienku kwoty), schowaæ do magazynu, szafy", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}b¹dŸ torby czy wreszcie po prostu od³o¿yæ go na ziemiê lub do pojazdu. Do", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}podnoszenia przedmiotów s³u¿y komenda /p podnies. Istnieje równie¿", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}uproszczony i szybszy sposób na ich u¿ycie. W tym celu mo¿na wpisaæ pe³n¹", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}nazwê b¹dŸ kilka pierwszych liter poprzedzaj¹c j¹ komend¹ /p, np.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}{88b711}\"/p nokia\"{DEDEDE}. Oczywiœcie przed wyjêciem telefonu", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}komórkowego, broni a¿ na wêdce koñcz¹c jesteœmy zobowi¹zani do odegrania", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}stosownej akcji Role Play.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Przechowywanie przedmiotu w szafie jest mo¿liwe po uprzednim jej", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}zakupieniu w swoim domku. Natomiast odk³adanie przedmiotów w magazynie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}jest dostêpne tylko i wy³¹cznie w biznesach czy organizacjach.", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock Pojazdy(playerid)
{
	new stats[1524];
	format(stats, sizeof(stats), "%s\n{DEDEDE}W zale¿noœci od naszych funduszy, mo¿emy kupiæ pojazd nowy w salonie lub", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}u¿ywany od innego gracza. Ze wzglêdu na bezpieczeñstwo musisz pamiêtaæ,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}¿eby akceptowaæ tylko oferty sprzeda¿y pojazdu a nie transakcje na", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}zasadzie: najpierw pieni¹dze, potem auto. Liczba mo¿liwych pojazdów", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}zespawnowanych jednoczeœnie wynosi {88b711}2{DEDEDE}. {88b711}Konto", stats);
	format(stats, sizeof(stats), "%s\n{88b711}premium{DEDEDE} zwiêksza t¹ liczbê do {88b711}3{DEDEDE}.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Dokument prawa jazdy jest niezbêdny, jeœli chcemy czegoœ wiêcej ni¿ tylko", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}przechowywaæ przedmioty w pojeŸdzie ;) Aby uzyskaæ prawo jazdy najpierw", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}musimy odbyæ kurs w jednej ze szkó³ nauki jazdy. W przypadku, kiedy nie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}posiadamy owego dokumentu jazda pojazdem jest niemo¿liwa. Opcje zwi¹zane", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}z pojazdem mo¿emy zobaczyæ dziêki komendzie {88b711}/v{DEDEDE}. Mo¿emy", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}otwieraæ/zamykaæ baga¿nik, maskê oraz okna, ustawiæ unikaln¹ rejestracjê,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}w³¹czyæ œwiat³a a tak¿e przepisaæ pojazd pod grupê czy przejrzeæ", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}komponenty zainstalowane w pojeŸdzie. System pojazdów na naszym serwerze", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}umo¿liwia tuning, dziêki czemu twój pojazd mo¿e byæ unikatowy.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Pojazdy mo¿na tankowaæ na stacjach benzynowych, natomiast naprawiaæ je ", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}mo¿na w warsztatach. Nale¿y pamiêtaæ, ¿e wraz ze wzrostem liczby napraw", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}roœnie spalanie benzyny.", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock BW(playerid)
{
	new stats[1024];
	format(stats, sizeof(stats), "%s\n{DEDEDE}{88b711}BW{DEDEDE} (Brutally Wounded) oznacza, ¿e nasza postaæ jest", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}nieprzytomna. Do takiego stanu mog³o dojœæ poprzez pobicie, postrzelenie,", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}upadek z wysokoœci, wypadek komunikacyjny czy wyg³odzenie. W takiej", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}sytuacji pomóc nam mo¿e medyk, który posiada odpowiedni medykament. Akcjê", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}ratownicz¹ trzeba rzecz jasna odegraæ poprzez stosowne", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}{88b711}/me{DEDEDE} i {88b711}/do{DEDEDE}. Tak wiêc jeœli widzisz", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}nieprzytomn¹ osobê czym prêdzej zadzwoñ na pogotowie! Je¿eli wybudzimy", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}siê po okreœlonym czasie bez pomocy medyka, to nie pamiêtamy ostatniej", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}akcji ani jej sprawców.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Podczas BW mo¿na uœmierciæ swoj¹ postaæ za pomoc¹ komendy", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}/akceptujsmierc. Po jej wpisaniu zalogowanie na dan¹ postaæ nie bêdzie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}ju¿ nigdy wiêcej mo¿liwe. {88b711}CK{DEDEDE} (Character Kill) jest to", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}proces nieodwracalny.", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock Oferty(playerid)
{
	new stats[1024];
	format(stats, sizeof(stats), "%s\n{DEDEDE}Oferty zosta³y stworzone, aby oferowaæ innym graczom ró¿nego rodzaju", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}us³ugi. Na przyk³ad za pomoc¹ oferty policjant mo¿e wystawiæ mandat a", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}lekarz zaœwiadczenie o poczytalnoœci.", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock PracaInfo(playerid)
{
	new stats[1524];
	format(stats, sizeof(stats), "%s\n{DEDEDE}Pracê dorywcz¹ mo¿na otrzymaæ poprzez udanie siê do urzêdu. W urzêdzie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}jest umieszczony pickup przy którym nale¿y wpisaæ {88b711}/praca{DEDEDE}. Dalsze kroki postêpowania", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}s¹ wyjaœnione. Prace jak¹ mo¿emy otrzymaæ to:", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}-Pomocnik stacji (Jak sama nazwa wskazuje, gracz staje siê pomocnikiem", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}stacji, jego praca to tankowanie pojazdów na stacjach benzynowych za", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}pomoc¹ komendy /o tankowanie.)", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}-Wêdkarz (Aby zacz¹æ ³owiæ ryby, nale¿y w pierwszej kolejnoœci udaæ siê", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}do 24/7, za pomoc¹ komendy /kup trzeba nabyæ wêdkê, haczyk, przynêtê.", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Kiedy owe rzeczy mamy w /p udajemy siê na molo z ko³em, tam stajemy obok", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}wêdki, klikaj¹c zarazem przycisk \"Enter\")", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}-Sprz¹tacz ulic (Ostatnia praca jaka zostaje nam do wybrania to sprz¹tacz", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}ulic. Dla tej¿e pracy komend nie ma. Poprostu gracz który wybiera ow¹", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}pracê, musi udaæ siê po samochód zwany \"Sweeperem\" który znajduje siê na", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}przeciw Komisariatu policji - LSPD. Wsiadaj¹c do tego pojazdu, wyœwietl¹", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}nam siê checkpointy przez które mamy obowi¹zek przeje¿d¿aæ, jest to trasa", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}któr¹ wykonujemy. Po wyjœciu z tego pojazdu jest on automatycznie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}odspawnowywany na swoje miejsce)", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}Oczywiœcie je¿eli Ci nie odpowiada praca z wy¿ej wymienionych, wcale nie", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}musisz siê zatrudniaæ! Wystarczy, ¿e wejdziesz na forum i napiszes", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}odpowiednie podanie w biznesach graczy. Oferty prac z biznesów bêdziesz", stats);
	format(stats, sizeof(stats), "%s\n{DEDEDE}móg³ dojrzeæ na gie³dzie serwera.", stats);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Pomoc{88b711}:", stats, "Zamknij", "");
	return 1;
}
stock Maska(playerid, zmienna=0)
{
	if(zmienna == 0) zmienna = DaneGracza[playerid][gUID];
	new text[32];
	format(text, sizeof(text), "%d", zmienna);
	new char1[5], char2[5], char3[5], char4[4], charcode2[5];
	strmid(charcode2, MD5_Hash(text), 0, strlen(MD5_Hash(text)), 255);
	strmid(char1, charcode2[0], 0, 1, 255);
	strmid(char2, charcode2[1], 0, 1, 255);
	strmid(char3, charcode2[2], 0, 1, 255);
	strmid(char4, charcode2[3], 0, 1, 255);
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "%s%s%s%s", char1, char2, char3, char4);
	strtoupper(tekst_global);
	return tekst_global;
}
stock Tablice(playerid, zmienna=0)
{
	if(zmienna == 0) zmienna = playerid;
	new text[32];
	format(text, sizeof(text), "%d", zmienna);
	new char1[5], char2[5], char3[5], char4[4], charcode2[5];
	strmid(charcode2, MD5_Hash(text), 0, strlen(MD5_Hash(text)), 255);
	strmid(char1, charcode2[0], 0, 1, 255);
	strmid(char2, charcode2[1], 0, 1, 255);
	strmid(char3, charcode2[2], 0, 1, 255);
	strmid(char4, charcode2[3], 0, 1, 255);
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "%s%s%s%s", char1, char2, char3, char4);
	strtoupper(tekst_global);
	return tekst_global;
}
stock ZmianaNickuP(playerid)
{
	new nick[60];
	if(DutyAdmina[playerid] == 1 && Nieznajomy[playerid] == 0)
	{
	    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
		{
		    format(nick, sizeof(nick), "%s",DaneGracza[playerid][nickOOC]);
		}
		else if(DaneGracza[playerid][gAdmGroup] == 11)
		{
			format(nick, sizeof(nick), "GM %s",DaneGracza[playerid][nickOOC]);
		}
		else if(DaneGracza[playerid][gAdmGroup] == 10)
		{
			format(nick, sizeof(nick), "%s",ImieGracza(playerid));
		}
	}
	else if(DutyAdmina[playerid] == 0 && Nieznajomy[playerid] == 1)
	{
		format(nick, sizeof(nick), "Nieznajomy %s",Maska(playerid));
	}
	else
	{
	    format(nick, sizeof(nick), "%s",ImieGracza(playerid));
	}
	return nick;
}
stock ZmianaNicku(playerid)
{
	new nick[60];
	if(DutyAdmina[playerid] == 1 && Nieznajomy[playerid] == 0)
	{
		UsunPolskieZnaki(DaneGracza[playerid][nickOOC]);
	    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
		{
		    format(nick, sizeof(nick), "%s",DaneGracza[playerid][nickOOC]);
		}
		else if(DaneGracza[playerid][gAdmGroup] == 11)
		{
			//format(nick, sizeof(nick), "GameMaster %s",GM(playerid));
			format(nick, sizeof(nick), "[GM] %s",DaneGracza[playerid][nickOOC]);
		}
		else if(DaneGracza[playerid][gAdmGroup] == 10)
		{
			format(nick, sizeof(nick), "%s",ImieGracza2(playerid));
		}
	}
	else if(DutyAdmina[playerid] == 0 && Nieznajomy[playerid] == 1)
	{
		format(nick, sizeof(nick), "Nieznajomy %s",Maska(playerid));
	}
	else
	{
	    format(nick, sizeof(nick), "%s",ImieGracza2(playerid));
	}
	UsunPLZnaki(nick);
	UsunPolskieZnaki(nick);
	UsunPLZnaki(nick);
	return nick;
}
stock Uderzony(playerid, kolor)
{
	new str[256];
	new g, m, s, dol[128];
	przelicznikonline(playerid, g, m, s);
	if(DaneGracza[playerid][gCZAS_ONLINE] < 10 * 60 * 60 && (DutyAdmina[playerid] == 0 || DaneGracza[playerid][gAdmGroup] == 10))
	{
		if(Nieznajomy[playerid] == 1)
		{
			format(str, sizeof(str), "%s", ZmianaNicku(playerid));
		}
		else
		{
			if(GraczPremium(playerid))
			{
				format(str, sizeof(str), "%s (%d, %dh)", ZmianaNicku(playerid), playerid, g);
			}else{
				format(str, sizeof(str), "%s (%d, %dh)", ZmianaNicku(playerid), playerid, g);
			}
		}
	}
	else if(DaneGracza[playerid][gCZAS_ONLINE] >= 10 * 60 * 60 && (DutyAdmina[playerid] == 0 || DaneGracza[playerid][gAdmGroup] == 10))
	{
		if(Nieznajomy[playerid] == 1)
		{
			format(str, sizeof(str), "%s", ZmianaNicku(playerid));
		}
		else
		{
			if(GraczPremium(playerid))
			{
				format(str, sizeof(str), "%s (%d)", ZmianaNicku(playerid), playerid);
			}else{
				format(str, sizeof(str), "%s (%d)", ZmianaNicku(playerid), playerid);
			}
		}
	}
	else
	{
	    format(str, sizeof(str), "%s", ZmianaNicku(playerid));
	}
	format(dol, sizeof(dol), "%s%dj", dol, DaneGracza[playerid][gSILA]);
	if(DaneGracza[playerid][gBW] >= 1)
	{
		format(dol, sizeof(dol), "%s, nieprzytomny", dol);
	}
	if(DaneGracza[playerid][gAdmGroup] == 10 && DutyAdmina[playerid] == 1)
	{
		format(dol, sizeof(dol), "%s, Opiekun IC", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
 	{
		format(dol, sizeof(dol), "%s, LSPD", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS)
 	{
		format(dol, sizeof(dol), "%s, SN", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA)
 	{
		format(dol, sizeof(dol), "%s, LSGH", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
 	{
		format(dol, sizeof(dol), "%s, GOV", dol);
	}
	if(Rekawiczki[playerid] == 1 && !GraczJestAFK(playerid))
 	{
		format(dol, sizeof(dol), "%s, Rêkawiczki", dol);
	}
	if(GraczJestAFK(playerid))
 	{
 	    new godzina, minuta;
		gettime(godzina, minuta);
		format(dol, sizeof(dol), "%s, AFK od %02d:%02d", dol, godzina, minuta);
	}
	if(GraczPrzetrzymywany(playerid))
 	{
		format(dol, sizeof(dol), "%s, przetrzymywany", dol);
	}
	if(Rolki[playerid] != 0)
	{
		format(dol, sizeof(dol), "%s, rolki", dol);
	}
	if(Discman[playerid] != 0)
	{
		format(dol, sizeof(dol), "%s, discman", dol);
	}
	if(PASY[playerid] != 0)
	{
		if(Jednoslady(GetPlayerVehicleID(playerid)))
		{
			format(dol, sizeof(dol), "%s, kask", dol);
		}
		else
		{
			format(dol, sizeof(dol), "%s, pasy", dol);
		}
	}
	if(DaneGracza[playerid][gCzasTrwaniaUzaleznienia] != 0)
	{
		format(dol, sizeof(dol), "%s, naæpany", dol);
	}
	if(GetPlayerDrunkLevel(playerid) >= 14000)
	{
		format(dol, sizeof(dol), "%s, pijany", dol);
	}
	if(strlen(dol) == 0) format(str, sizeof(str), "%s", str);
	else format(str, sizeof(str), "%s\n{ffffff}(%s)", str, dol);
	UpdateDynamic3DTextLabelText(DaneGracza[playerid][gNICK], kolor, str); //0xFF0000FF
	SetTimerEx("RefUderzony", 2000, 0, "u", playerid);
	FadeColorForPlayer(playerid, 255, 0, 0, floatround(90),255,0,0,0,floatround(10),0);
	return 1;
}
stock RefreshNick(playerid)
{
	new str[256];
	new g, m, s, dol[128];
	przelicznikonline(playerid, g, m, s);
	if(DaneGracza[playerid][gCZAS_ONLINE] < 10 * 60 * 60 && (DutyAdmina[playerid] == 0 || DaneGracza[playerid][gAdmGroup] == 10))
	{
		if(Nieznajomy[playerid] == 1)
		{
			format(str, sizeof(str), "%s", ZmianaNicku(playerid));
		}
		else
		{
			if(GraczPremium(playerid))
			{
				format(str, sizeof(str), "%s (%d, %dh)", ZmianaNicku(playerid), playerid, g);
			}else{
				format(str, sizeof(str), "%s (%d, %dh)", ZmianaNicku(playerid), playerid, g);
			}
		}
	}
	else if(DaneGracza[playerid][gCZAS_ONLINE] >= 10 * 60 * 60 && (DutyAdmina[playerid] == 0 || DaneGracza[playerid][gAdmGroup] == 10))
	{
		if(Nieznajomy[playerid] == 1)
		{
			format(str, sizeof(str), "%s", ZmianaNicku(playerid));
		}
		else
		{
			if(GraczPremium(playerid))
			{
				format(str, sizeof(str), "%s (%d)", ZmianaNicku(playerid), playerid);
			}else{
				format(str, sizeof(str), "%s (%d)", ZmianaNicku(playerid), playerid);
			}
		}
	}
	else
	{
	    format(str, sizeof(str), "%s", ZmianaNicku(playerid));
	}
	format(dol, sizeof(dol), "%s%dj", dol, DaneGracza[playerid][gSILA]);
	if(DaneGracza[playerid][gBW] >= 1)
	{
		format(dol, sizeof(dol), "%s, nieprzytomny", dol);
	}
	if(DaneGracza[playerid][gAdmGroup] == 10 && DutyAdmina[playerid] == 1)
	{
		format(dol, sizeof(dol), "%s, Opiekun IC", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_POLICYJNA)
 	{
		format(dol, sizeof(dol), "%s, LSPD", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_SANNEWS)
 	{
		format(dol, sizeof(dol), "%s, SN", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_MEDYCZNA)
 	{
		format(dol, sizeof(dol), "%s, LSGH", dol);
	}
	if(GrupaInfo[DaneGracza[playerid][gSluzba]][gTyp] == DZIALALNOSC_RZADOWA)
 	{
		format(dol, sizeof(dol), "%s, GOV", dol);
	}
	if(Rekawiczki[playerid] == 1 && !GraczJestAFK(playerid))
 	{
		format(dol, sizeof(dol), "%s, Rêkawiczki", dol);
	}
	if(GraczJestAFK(playerid))
 	{
 	    new godzina, minuta;
		gettime(godzina, minuta);
		format(dol, sizeof(dol), "%s, AFK od %02d:%02d", dol, godzina, minuta);
	}
	if(GraczPrzetrzymywany(playerid))
 	{
		format(dol, sizeof(dol), "%s, przetrzymywany", dol);
	}
	if(Rolki[playerid] != 0)
	{
		format(dol, sizeof(dol), "%s, rolki", dol);
	}
	if(Discman[playerid] != 0)
	{
		format(dol, sizeof(dol), "%s, discman", dol);
	}
	if(PASY[playerid] != 0)
	{
		if(Jednoslady(GetPlayerVehicleID(playerid)))
		{
			format(dol, sizeof(dol), "%s, kask", dol);
		}
		else
		{
			format(dol, sizeof(dol), "%s, pasy", dol);
		}
	}
	if(DaneGracza[playerid][gCzasTrwaniaUzaleznienia] != 0)
	{
		format(dol, sizeof(dol), "%s, naæpany", dol);
	}
	if(GetPlayerDrunkLevel(playerid) >= 14000)
	{
		format(dol, sizeof(dol), "%s, pijany", dol);
	}
	if(DutyDZ[playerid] == 1)
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "{%s}%s", DaneGracza[playerid][gKolorNicku1], str);
	else format(str, sizeof(str), "{%s}%s\n{ffffff}(%s)", DaneGracza[playerid][gKolorNicku1], str, dol);
	}
	else if(DutyDZ[playerid] == 2)
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "{%s}%s", DaneGracza[playerid][gKolorNicku2], str);
	else format(str, sizeof(str), "{%s}%s\n{ffffff}(%s)", DaneGracza[playerid][gKolorNicku2], str, dol);
	}
	else if(DutyDZ[playerid] == 3)
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "{%s}%s", DaneGracza[playerid][gKolorNicku3], str);
	else format(str, sizeof(str), "{%s}%s\n{ffffff}(%s)", DaneGracza[playerid][gKolorNicku3], str, dol);
	}
	else if(DutyDZ[playerid] == 4)
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "{%s}%s", DaneGracza[playerid][gKolorNicku4], str);
	else format(str, sizeof(str), "{%s}%s\n{ffffff}(%s)", DaneGracza[playerid][gKolorNicku4], str, dol);
	}
	else if(DutyDZ[playerid] == 5)
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "{%s}%s", DaneGracza[playerid][gKolorNicku5], str);
	else format(str, sizeof(str), "{%s}%s\n{ffffff}(%s)", DaneGracza[playerid][gKolorNicku5], str, dol);
	}
	else if(DutyDZ[playerid] == 6)
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "{%s}%s", DaneGracza[playerid][gKolorNicku6], str);
	else format(str, sizeof(str), "{%s}%s\n{ffffff}(%s)", DaneGracza[playerid][gKolorNicku6], str, dol);
	}
	else
	{
	if(strlen(dol) == 0) format(str, sizeof(str), "%s", str);
	else format(str, sizeof(str), "%s\n{ffffff}(%s)", str, dol);
	}
	UpdateDynamic3DTextLabelText(DaneGracza[playerid][gNICK], DaneGracza[playerid][gKOLOR], str);
	return 1;
}
stock przelicznikonline(playerid, &hours, &minutes, &second)
{
	hours 	= DaneGracza[playerid][gCZAS_ONLINE] / 3600;
	minutes = (DaneGracza[playerid][gCZAS_ONLINE] - (hours * 3600)) / 60;
	second 	= ((DaneGracza[playerid][gCZAS_ONLINE] - (hours * 3600)) - (minutes * 60));
	return 1;
}
stock przeliczniksectoh(zmienna, &hours, &minutes, &second)
{
	hours 	= zmienna / 3600;
	minutes = (zmienna - (hours * 3600)) / 60;
	second 	= ((zmienna - (hours * 3600)) - (minutes * 60));
	return 1;
}
stock Sluchawka(playerid, msg[], range = 20, maxlength=100, const prefix[]="[...]")
{
    new length = strlen(msg);
    if(length <= maxlength) {
        TextBezPlayera(range, playerid, msg, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
        return;
    }
    new idx;
    for(new i, space, plen, bool:useprefix; i < length; i++) {
        if(i - idx + plen >= maxlength) {
            if(idx == space || i - space >= 25) {
                strmid(tekst_global, msg, idx, i);
                idx = i;
            } else {
                strmid(tekst_global, msg, idx, space);
                idx = space + 1;
            }
            if(useprefix) {
                strins(tekst_global, prefix, 0);
            } else {
                plen = strlen(prefix);
                useprefix = true;
            }
            format(tekst_global, sizeof(tekst_global), "%s...", tekst_global);
            TextBezPlayera(range, playerid, tekst_global, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
        } else if(msg[i] == ' ') {
            space = i;
        }
    }
    if(idx < length) {
        strmid(tekst_global, msg, idx, length);
        strins(tekst_global, prefix, 0);
        TextBezPlayera(range, playerid, tekst_global, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
    }
    return;
}
stock CzatGlobalny(playerid, msg[], range = 20, maxlength=100, const prefix[]="[...]")
{
    new length = strlen(msg);
    if(length <= maxlength) {
        SendPlayerText(range, playerid, msg, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
        return;
    }
    new idx;
    for(new i, space, plen, bool:useprefix; i < length; i++) {
        if(i - idx + plen >= maxlength) {
            if(idx == space || i - space >= 25) {
                strmid(tekst_global, msg, idx, i);
                idx = i;
            } else {
                strmid(tekst_global, msg, idx, space);
                idx = space + 1;
            }
            if(useprefix) {
                strins(tekst_global, prefix, 0);
            } else {
                plen = strlen(prefix);
                useprefix = true;
            }
            format(tekst_global, sizeof(tekst_global), "%s...", tekst_global);
            SendPlayerText(range, playerid, tekst_global, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
        } else if(msg[i] == ' ') {
            space = i;
        }
    }
    if(idx < length) {
        strmid(tekst_global, msg, idx, length);
        strins(tekst_global, prefix, 0);
        SendPlayerText(range, playerid, tekst_global, 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
    }
    return;
}
stock SendWrappedMessageToPlayerRange(playerid, colour, msg[], range = 20, maxlength=100, const prefix[]="[...]")
{
    new length = strlen(msg);
    if(length <= maxlength) {
        SendPlayerText(range, playerid, msg, colour, colour, colour, colour, colour);
        return;
    }
    new string[128], idx;
    for(new i, space, plen, bool:useprefix; i < length; i++) {
        if(i - idx + plen >= maxlength) {
            if(idx == space || i - space >= 25) {
                strmid(string, msg, idx, i);
                idx = i;
            } else {
                strmid(string, msg, idx, space);
                idx = space + 1;
            }
            if(useprefix) {
                strins(string, prefix, 0);
            } else {
                plen = strlen(prefix);
                useprefix = true;
            }
            format(string, sizeof(string), "%s...", string);
            SendPlayerText(range, playerid, string, colour, colour, colour, colour, colour);
        } else if(msg[i] == ' ') {
            space = i;
        }
    }
    if(idx < length) {
        strmid(string, msg, idx, length);
        strins(string, prefix, 0);
        SendPlayerText(range, playerid, string, colour, colour, colour, colour, colour);
    }
    return;
}
forward SendVehText(Float:radi, playerid, text[], col1, col2, col3, col4, col5);
public SendVehText(Float:radi, playerid, text[], col1, col2, col3, col4, col5)
{

	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetVehiclePos(playerid, oldposx, oldposy, oldposz);
	ForeachEx(i, IloscGraczy)
	{
		if(IsPlayerConnected(KtoJestOnline[i]) && (GetVehicleVirtualWorld(playerid) == GetPlayerVirtualWorld(KtoJestOnline[i])))
		{
			GetPlayerPos(KtoJestOnline[i], posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);
			if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
			{
				SendClientMessage(KtoJestOnline[i], col1, text);
			}
			else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
			{
				SendClientMessage(KtoJestOnline[i], col2, text);
			}
			else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
			{
				SendClientMessage(KtoJestOnline[i], col3, text);
			}
			else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
			{
				SendClientMessage(KtoJestOnline[i], col4, text);
			}
			else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			{
				SendClientMessage(KtoJestOnline[i], col5, text);
			}
		}
	}
	return 1;
}
forward TextBezPlayera(Float:radi, playerid, text[], col1, col2, col3, col4, col5);
public TextBezPlayera(Float:radi, playerid, text[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		ForeachEx(i, IloscGraczy)
		{
			if(IsPlayerConnected(KtoJestOnline[i]) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(KtoJestOnline[i])) && playerid != KtoJestOnline[i])
			{
				GetPlayerPos(KtoJestOnline[i], posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(KtoJestOnline[i], col1, text);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(KtoJestOnline[i], col2, text);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(KtoJestOnline[i], col3, text);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(KtoJestOnline[i], col4, text);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(KtoJestOnline[i], col5, text);
				}
			}
		}
	}//not connected
	return 1;
}
forward SendPlayerText(Float:radi, playerid, text[], col1, col2, col3, col4, col5);
public SendPlayerText(Float:radi, playerid, text[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		ForeachEx(i, IloscGraczy)
		{
			if(IsPlayerConnected(KtoJestOnline[i]) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(KtoJestOnline[i])))
			{
				GetPlayerPos(KtoJestOnline[i], posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(KtoJestOnline[i], col1, text);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(KtoJestOnline[i], col2, text);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(KtoJestOnline[i], col3, text);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(KtoJestOnline[i], col4, text);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(KtoJestOnline[i], col5, text);
				}
			}
		}
	}//not connected
	return 1;
}
forward Minuta();
public Minuta()
{
    new godzina, minuta, sec;
	gettime(godzina, minuta, sec);
	if(godzina == 5 && minuta == 0)
	{
		ForeachEx(i, IloscGraczy)
		{
			if(DaneGracza[KtoJestOnline[i]][gSluzba] != 0)
			{
				ZapiszDuty(DaneGracza[KtoJestOnline[i]][gSluzba], KtoJestOnline[i], DutyNR[KtoJestOnline[i]]);
			}
			ZapiszGracza(KtoJestOnline[i]);
			ZapiszBankKasa(KtoJestOnline[i]);
			ZapiszGraczaGlobal(KtoJestOnline[i], 1);
			//zalogowany[KtoJestOnline[i]] = false;
			CancelEdit(KtoJestOnline[i]);
			ogmx = 10;
		}
	}
	new str[256];
	strdel(str, 0, 256);
    ForeachEx(i, IloscGraczy)
	{
	    DaneGracza[KtoJestOnline[i]][gDoPelnejGodziny]++;
		if(DaneGracza[KtoJestOnline[i]][gDoPelnejGodziny]==60)
		{
		    if(GraczPremium(KtoJestOnline[i]))
		    {
		    DaneGracza[KtoJestOnline[i]][gGAMESCORE] += 45 + random(5);
		    }else{
		    DaneGracza[KtoJestOnline[i]][gGAMESCORE] += 30 + random(5);
		    }
	    	DaneGracza[KtoJestOnline[i]][gDoPelnejGodziny] = 0;
	    	SetPlayerScore(KtoJestOnline[i],DaneGracza[KtoJestOnline[i]][gGAMESCORE]);
	    	ZapiszGraczaGlobal(KtoJestOnline[i], 1);
		}
	}
	return 1;
}
stock Dodajkase(playerid, money)
{
	if(!Osiagniecia(playerid, OSIAGNIECIE_PIERWSZA_KASA) && money > 0)
	{
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Pierwsze zarobione pieniadze ~g~+15GS");
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_PIERWSZA_KASA] = 1;
		DaneGracza[playerid][gGAMESCORE] += 15;
	    SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
		ZapiszGraczaGlobal(playerid, 1);
	}
    DaneGracza[playerid][gPORTFEL] += money;
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, DaneGracza[playerid][gPORTFEL]);
}
forward Brakprawka();
public Brakprawka()
{
	ForeachEx(playerid, IloscGraczy)
	{
		if(IsPlayerInAnyVehicle(KtoJestOnline[playerid]))
		{
			if(GetPlayerState(KtoJestOnline[playerid]) == PLAYER_STATE_DRIVER)
			{
				if((Jednoslady(GetPlayerVehicleID(KtoJestOnline[playerid])) && !Dokument(KtoJestOnline[playerid], D_PRAWKO_A)) ||
				(!Jednoslady(GetPlayerVehicleID(KtoJestOnline[playerid])) && !Dokument(KtoJestOnline[playerid], D_PRAWKO_B)))
				{
					if(Predkosc(KtoJestOnline[playerid]) > 30)
					{
						new uid = GetPlayerVehicleID(KtoJestOnline[playerid]);
						if(GetVehicleModel(uid) != 481 && GetVehicleModel(uid) != 509 && GetVehicleModel(uid) != 510 && GetVehicleModel(uid) != 574)
						{
							new rand = random(10);
							if(rand == 1 || rand == 2 || rand == 4 || rand == 7 || rand == 10)
							{
								new Float:at;
								new sd = random(20) + 10;
								GetVehicleZAngle(uid, at);
								SetVehicleZAngle(uid,at+sd);
							}
							else
							{
								new Float:at;
								new sd = random(20) + 10;
								GetVehicleZAngle(uid, at);
								SetVehicleZAngle(uid,at-sd);
							}
						}
					}
				}
			}
		}
	}
	return 1;
}/*
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat) {
	new
	 Float: fVehicle[3];

	GetVehiclePos(vehicleid, fVehicle[0], fVehicle[1], fVehicle[2]);

	if(!IsPlayerInRangeOfPoint(playerid, 10, fVehicle[0], fVehicle[1], fVehicle[2]))
	{
		//SetVehiclePos(vehicleid, fVehicle[0], fVehicle[1], fVehicle[2]);
		new playerState = GetPlayerState(playerid);
		if(playerState == PLAYER_STATE_DRIVER || playerState == PLAYER_STATE_PASSENGER)
		{
			//new uid = SprawdzCarUID(vehicleid);
			//SetVehiclePos(vehicleid, PojazdInfo[uid][pOX], PojazdInfo[uid][pOY], PojazdInfo[uid][pOZ]);
			
			//StworzPojazd(playerid, uid);
		}
	}
	return 1;
}*/
CMD:impreza(playerid, params[])
{
	//printf("U¿yta komenda impreza");
    if(DaneGracza[playerid][gAdmGroup] != 4) return 0;
	if(impreza == 1)
	{
		impreza = 0;
		ForeachEx(i, IloscGraczy)
		{
			if(GetPVarInt(KtoJestOnline[i],"spawn"))
			{
				DeletePVar(KtoJestOnline[i],"spawn");
				StopAudioStreamForPlayer(KtoJestOnline[i]);
			}
		}
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}impreza off", "Zamknij", "");
	}
	else
	{
		impreza = 1;
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}impreza on", "Zamknij", "");	
	}
    return 1;
}
CMD:haslo(playerid, params[])
{
	//printf("U¿yta komenda haslo");
    if(DaneGracza[playerid][gAdmGroup] != 4) return 0;
	SendRconCommand("password 0");
    return 1;
}
CMD:slap(playerid, params[])
{
	//printf("U¿yta komenda slap");
    if(DaneGracza[playerid][gAdmGroup] != 4) return 0;
	new playerid2;
	if(sscanf(params, "i", playerid2))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}graczu{DEDEDE} klapsa wpisz: /slap [id gracza]", "Zamknij", "");
		return 1;
	}
	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid2, x, y, z);
	Teleportuj(playerid2, x, y, z + 5);
	PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid2, 1190, 0.0, 0.0, 0.0);
    return 1;
}
CMD:reset(playerid, params[])
{
	//printf("U¿yta komenda reset");
	if((DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8 || DaneGracza[playerid][gAdmGroup] == 11)&& DutyAdmina[playerid] == 1)
    {
		new playerid2;
		if(sscanf(params, "i", playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zresetowaæ {88b711}gracza{DEDEDE} na spawn wpisz: /reset [id gracza]", "Zamknij", "");
			return 1;
		}
		SetPVarInt(playerid2, "Teleportacja", 1);
		SpawnPlayer(playerid2);
		SetPVarInt(playerid2, "Teleportacja", 0);
		PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid2, 1190, 0.0, 0.0, 0.0);
		new kom[256], przelew[256];
		format(przelew, sizeof(przelew), "[RESET] Gracz: %s (ID:%d) zresetowa³ gracza: %s (ID:%d)",ZmianaNicku(playerid), playerid, ZmianaNicku(playerid2), playerid2);
		KomunikatAdmin(1, przelew);
		format(kom, sizeof(kom), "Gracz: %s (ID:%d) zresetowa³ ciê na spawnpoint.",ZmianaNicku(playerid), playerid);
		SendClientMessage(playerid2, 0xDEDEDEFF, kom);
	}
    return 1;
}
CMD:dajpasek(playerid, params[])
{
	//printf("U¿yta komenda dajpasek");
    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
	{
		new playerid2;
		if(sscanf(params, "i", playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}graczu{DEDEDE} pasek g³odu wpisz: /dajpasek [id gracza]", "Zamknij", "");
			return 1;
		}
		DaneGracza[playerid2][gGlod] = 104;
		PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid2, 1190, 0.0, 0.0, 0.0);
	}
    return 1;
}
CMD:zabierz(playerid, params[])
{
    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
	{
		new playerid2;
		if(sscanf(params, "d", playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby zabraæ {88b711}graczu{DEDEDE} przedmiot wpisz: /zabierz [id gracza]", "Zamknij", "");
			return 1;
		}
		if(zalogowany[playerid2] == false)
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz któremu chcesz zabraæ {88b711}przedmiot{DEDEDE} jest zalogowany.", "Zamknij", "");
			return 1;
		}
		if(playerid == playerid2) return 1;
		SetPVarInt(playerid, "IDZAB", playerid2);
		Przedmioty(playerid, playerid2, DIALOG_ZABIERZ, "{DEDEDE}"VER" » Przedmioty:", TYP_WLASCICIEL, 0);
	}
	return 1;
}
CMD:dajhp(playerid, params[])
{
	//printf("U¿yta komenda dajpasek");
    if(DaneGracza[playerid][gAdmGroup] == 4 || DaneGracza[playerid][gAdmGroup] == 8)
	{
		new playerid2;
		if(sscanf(params, "i", playerid2))
		{
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby nadaæ {88b711}graczu{DEDEDE} HP wpisz: /dajhp [id gracza]", "Zamknij", "");
			return 1;
		}
		UstawHP(playerid2,100);
		PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid2, 1190, 0.0, 0.0, 0.0);
	}
    return 1;
}
CMD:naprawpojazd(playerid, params[])
{
	//printf("U¿yta komenda naprawpojazd");
    if(DaneGracza[playerid][gAdmGroup] != 4) return 0;
	new playerid2;
	if(sscanf(params, "d", playerid2))
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby naprawiæ pojazd {88b711}graczu{DEDEDE} wpisz: /naprawpojazd [id gracza]", "Zamknij", "");
		return 1;
	}
	AntyCheatWizualizacja[playerid] = 1;
	PojazdInfo[playerid2][pStan] = 1000.0;
	RepairVehicle(PojazdInfo[playerid2][pID]);
	PojazdInfo[playerid2][pStan] = 1000.0;
	GetVehicleDamageStatus(PojazdInfo[playerid2][pID], PojazdInfo[playerid2][pUszkodzenie1], PojazdInfo[playerid2][pUszkodzenie2], PojazdInfo[playerid2][pUszkodzenie3], PojazdInfo[playerid2][pUszkodzenie4]);
	KillTimer(AntyCheatWizualizacjaTimer[playerid]);
	AntyCheatWizualizacjaTimer[playerid] = SetTimerEx("WlaczAntyWizualizacje",2000,0,"d",playerid);
	return 1;
}
forward UsunLPM(playerid);
public UsunLPM(playerid)
{
	UzylLPM[playerid] = 0;
	return 1;
}
forward WlaczAntyWizualizacje(playerid);
public WlaczAntyWizualizacje(playerid)
{
	AntyCheatWizualizacja[playerid] = 0;
	return 1;
}
forward WlaczAntyCheata(playerid);
public WlaczAntyCheata(playerid)
{
	AntyCheatBroni[playerid] = 0;
	return 1;
}
forward HolowanyTimer(playerid);
public HolowanyTimer(playerid)
{
	PojazdInfo[playerid][pHolowany] = 0;
	return 1;
}
forward AntyCheatSystem();
public AntyCheatSystem()
{
	ForeachEx(i, IloscGraczy)
	{
	    if(zalogowany[KtoJestOnline[i]] == true)
		{
			////////////////////////////////////////////////////////////////////////////////
			/*new vw = GetPlayerVirtualWorld(i);
			new budynek = GraczWBudynku(i, vw);
			if(budynek == 1 && vw != 0 && zalogowany[i] == true && !ZarzadzanieBudynkiem(vw, i))
			{
				new nazwadrzwi[124];
				CzasWyswietlaniaTextuNaDrzwiach[i] = 5;
				format(nazwadrzwi, sizeof(nazwadrzwi), "Twoja pozycja zostala przywrocona do drzwi budynku poniewaz wykroczyles poza metraz tego budynku.");
				TextDrawHideForPlayer(i, TextNaDrzwi[i]);
				TextDrawSetString(TextNaDrzwi[i], nazwadrzwi);
				TextDrawShowForPlayer(i, TextNaDrzwi[i]);
				Teleportuj(i, NieruchomoscInfo[vw][nXW],NieruchomoscInfo[vw][nYW],NieruchomoscInfo[vw][nZW]);
			}*/
			////////////////////////////////////////////////////////////////////////////////
			/*new PlayerWeapon = GetPlayerWeapon(i);
			new findgun = DaneGracza[i][gBronUID];
			new ammo = GetPlayerAmmo(i);
			if(ammo > PrzedmiotInfo[findgun][pWar2]+5 && PlayerWeapon != 0 && zalogowany[i] == true)
			{
				SetPlayerAmmo(i, DaneGracza[i][gBronAmmo], PrzedmiotInfo[i][pWar2]);
				NadajKare(i,-1, 0, "Infinity Ammo :>", 0);
			}*/
			////////////////////////////////////////////////////////////////////////////////
			GetPlayerHealth(KtoJestOnline[i],ACHP);
			if(DaneGracza[KtoJestOnline[i]][gPORTFEL] != GetPlayerMoney(KtoJestOnline[i]))
			{
				ResetPlayerMoney(KtoJestOnline[i]);
				GivePlayerMoney(KtoJestOnline[i], DaneGracza[KtoJestOnline[i]][gPORTFEL]);//ANTY MONEY
			}
			new Float:xa, Float:ya, Float:za;
			GetPlayerPos(KtoJestOnline[i], xa, ya, za);
			if((GetPlayerAnimationIndex(KtoJestOnline[i]) == 1544 || GetPlayerAnimationIndex(KtoJestOnline[i]) == 1538 || GetPlayerAnimationIndex(KtoJestOnline[i]) == 1543) && za > 10)
			{
				NadajKare(KtoJestOnline[i],-1, 0, "Prawdopodobny Airbreak v2", -1);
			}
			if(GetPlayerAnimationIndex(KtoJestOnline[i]) == 984)
			{
				NadajKare(KtoJestOnline[i],-1, 2, "Anim Cheat", -1);
			}
			////////////////////////////////////////////////////////////////////////////////
			/*if(ACHP!=dHP[i])
			{
				if(ACHP>dHP[i])
				{
					SetPlayerHealth(i,dHP[i]);//ANTY HEAL
				}
				else
				{
					dHP[i]=ACHP;
				}
			}*/
			////////////////////////////////////////////////////////////////////////////////
			new vehicleid = GetPlayerVehicleID(KtoJestOnline[i]);
			if(IsPlayerInAnyVehicle(KtoJestOnline[i]) && GetPlayerState(KtoJestOnline[i]) == PLAYER_STATE_DRIVER)
			{
				if(!Wlascicielpojazdu(vehicleid, KtoJestOnline[i]))
				{
					new armour[256];
					format(armour, sizeof(armour), "Anty Cheat System (WP, V: %d)", vehicleid);
					NadajKare(KtoJestOnline[i],-1, 0, armour, -1);
					/*new Float: x, Float: y, Float: z;
					GetPlayerPos(KtoJestOnline[i], x, y, z);
					Teleportuj(KtoJestOnline[i], x, y, z + 5);
					PlayerPlaySound(KtoJestOnline[i], 1190, 0.0, 0.0, 0.0);*/
				}
			}
			/*new vehicleid = GetPlayerVehicleID(i);
			new Float:HvP;
			GetVehicleHealth(vehicleid, HvP );
			new uid = SprawdzCarUID(vehicleid);
			if(IsPlayerInAnyVehicle(i))
			{
				if(PojazdInfo[uid][pStan]+50<HvP&&GetPlayerState(i)==PLAYER_STATE_DRIVER && ACOFF[uid] == 0)
				{
					SetVehicleHealth(vehicleid, PojazdInfo[uid][pStan]);
					NadajKare(i,-1, 2, "Wymuszona naprawa pojazdu", -1);
					Kick(i);
				}
			}*///ANTY REPAIRVEH
			//new vehicleid = GetPlayerVehicleID(i);
			new uid = SprawdzCarUID(vehicleid);
			for(new zapytaj = 0; zapytaj<=13; zapytaj++)
			{
				if(GetVehicleComponentInSlot(vehicleid, zapytaj) != 0)
				{
					new banik = 0;
					for(new slot = 0; slot<=13; slot++)
					{
						if(GetVehicleComponentInSlot(vehicleid, zapytaj) == PojazdInfo[uid][pTuning][slot])
						{
							banik++;
						}
					}
					if(banik == 0) 
					{
						NadajKare(i,-1, 1, "Wymuszony tuning pojazdu", -1);
					}
				}
			}
			////////////////////////////////////////////////////////////////////////////////
			if(GetPlayerSpecialAction(KtoJestOnline[i]) == SPECIAL_ACTION_USEJETPACK)
			{
				NadajKare(KtoJestOnline[i],-1, 2, "Jet - Pack", 720);
			}
			////////////////////////////////////////////////////////////////////////////////
			/*ACBron=GetPlayerWeapon(KtoJestOnline[i]);
			if(ACBron>0 && ACBron < 46)
			{
				ACAmmo = GetPlayerAmmo(KtoJestOnline[i]);
				if(ACAmmo>0 && dBron[KtoJestOnline[i]][ACBron]==false)
				{
					ResetPlayerWeapons(KtoJestOnline[i]);
					format(ACtekst_global, sizeof(ACtekst_global),"Weapon Cheat (%s)",NazwaBroni[ACBron]);
					NadajKare(KtoJestOnline[i],-1, 0, ACtekst_global, 30);
					ResetPlayerWeapons(KtoJestOnline[i]);
				}
				if(dBron[KtoJestOnline[i]][ACBron]==true && dAmmo[KtoJestOnline[i]][ACBron]!=ACAmmo)
				{
					dAmmo[KtoJestOnline[i]][ACBron]=ACAmmo;
				}
			}*/
			/*if(GetPlayerWeapon(i) != 0)
			{
				if(DaneGracza[i][gBronAmmo] != GetPlayerWeapon(i) && GetPlayerWeapon(i) != 0 && zalogowany[i] == true)
				{
					ResetPlayerWeapons(i);
					format(ACtekst_global, sizeof(ACtekst_global),"Weapon Cheat v2 (%s)",NazwaBroni[ACBron]);
					NadajKare(i,-1, 2, ACtekst_global, 30);
				}
			}*/
			////////////////////////////////////////////////////////////////////////////////
			if(AntyCheatBroni[KtoJestOnline[i]] == 0)
			{
				if(PosiadanaBron[KtoJestOnline[i]] == 0)
				{
					if(GetPlayerWeapon(KtoJestOnline[i]) != 0)
					{
						ResetPlayerWeapons(KtoJestOnline[i]);
						format(ACtekst_global, sizeof(ACtekst_global),"Anty Cheat System (%s)",NazwaBroni[GetPlayerWeapon(KtoJestOnline[i])]);
						NadajKare(KtoJestOnline[i],-1, 2, ACtekst_global, 30);
					}
				}
				else
				{
					if(GetPlayerWeapon(KtoJestOnline[i]) != PosiadanaBron[KtoJestOnline[i]])
					{
						if(GetPlayerWeapon(KtoJestOnline[i]) != 0)
						{
							ResetPlayerWeapons(KtoJestOnline[i]);
							format(ACtekst_global, sizeof(ACtekst_global),"Anty Cheat System (%s)",NazwaBroni[GetPlayerWeapon(KtoJestOnline[i])]);
							NadajKare(KtoJestOnline[i],-1, 2, ACtekst_global, 30);
						}
					}
				}
			}
			/*if(IsPlayerInAnyVehicle(KtoJestOnline[i]))
			{
				if(MozeBycWPojezdzie[KtoJestOnline[i]] == 0 && SprawdzaniePojazdu[KtoJestOnline[i]] == 0)
				{
					NadajKare(KtoJestOnline[i],-1, 0, "Anty Cheat System (Teleport do pojazdu)", -1);
				}
			}*/
			new Float:kamizelka;
			GetPlayerArmour(KtoJestOnline[i], kamizelka);
			if(kamizelka > 0)
			{
				new armour[256];
				format(armour, sizeof(armour), "Anty Cheat System (Armour: %f)", kamizelka);
				NadajKare(KtoJestOnline[i],-1, 0, armour, -1);
			}
		}	
	}
	return 1;
}
stock DodajHP(playerid,Float:HP)
{
	//SetPVarInt(playerid, "USetHP", 0);
	//dHP[playerid]+=HP;
	DaneGracza[playerid][gZDROWIE] += HP;
	//if(dHP[playerid]>100) dHP[playerid]=9;
	if(DaneGracza[playerid][gBW] == 0)
	{
		Uderzony(playerid, 0xFF0000FF);
	}
    SetPlayerHealth(playerid,DaneGracza[playerid][gZDROWIE]);
	//SetPVarInt(playerid, "USetHP", 1);
	return 1;
}
stock UstawHP(playerid,Float:HP)
{
	dHP[playerid]=HP;
	DaneGracza[playerid][gZDROWIE] = HP;
	if(DaneGracza[playerid][gBW] == 0)
	{
		Uderzony(playerid, 0xFF0000FF);
	}
	//if(dHP[playerid]>100) dHP[playerid]=9;
	SetPlayerHealth(playerid,HP);
	return 1;
}
stock ZabierzHP(playerid, Float: hp)
{
	new Float: ghp;
	GetPlayerHealth(playerid, ghp);
	SetPlayerHealth(playerid, ghp + hp);
	DaneGracza[playerid][gZDROWIE] += hp;
	if(DaneGracza[playerid][gZDROWIE] > 100)
	{
	    DaneGracza[playerid][gZDROWIE] = 100;
	}
}
stock sukces(playerid, typ, guid, uid, ip[],czas)
{
	if(typ == 1)
	{
		format(zapyt, sizeof(zapyt), "INSERT INTO `five_logowania` (`GUID`, `UID_POSTACI`, `ADRES_IP`, `DATA`, `SUKCES`, `CZAS_SESJI`) VALUES (%d, %d, '%s', '%d', 'TAK', '%d')", guid, uid, ip, gettime()-CZAS_LETNI, czas);
		mysql_check();
		mysql_query2(zapyt);
		mysql_free_result();
		printf("[SQL_LOGOWANIE][Gracz: %s][GUID: %d][UID: %d][SUKCES: TAK][IP: %s]", ImieGracza2(playerid), guid, uid, ip);
	}
	else if(typ == 2)
	{
		format(zapyt, sizeof(zapyt), "INSERT INTO `five_logowania` (`GUID`, `UID_POSTACI`, `ADRES_IP`, `DATA`, `SUKCES`) VALUES (%d, %d, '%s', '%d', 'NIE')", guid, uid, ip, gettime()-CZAS_LETNI);
		mysql_check();
		mysql_query2(zapyt);
		mysql_free_result();
		//printf("[SQL_LOGOWANIE][Gracz: %s][GUID: %d][UID: %d][SUKCES: NIE][IP: %s]", ImieGracza2(playerid), guid, uid, ip);
	}
	else
	{
	    //printf("[SQL_LOGOWANIE][Brak przypisanego typu opuszczenia serwera]", ImieGracza2(playerid));
	}
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
	/*new string[128], victim[MAX_PLAYER_NAME], attacker[MAX_PLAYER_NAME];
    new weaponname[24];
    GetPlayerName(playerid, attacker, sizeof (attacker));
    GetPlayerName(damagedid, victim, sizeof (victim));
 
    GetWeaponName(weaponid, weaponname, sizeof (weaponname));
    format(string, sizeof(string), "%s has made %.0f damage to %s, weapon: %s", attacker, amount, victim, weaponname);
    SendClientMessageToAll(0xFFFFFFFF, string);*/
    if(AntyCheatBroni[playerid] == 0)
	{
		if(PosiadanaBron[playerid] == 0)
		{
			if(weaponid != 0)
			{
				ResetPlayerWeapons(playerid);
				format(ACtekst_global, sizeof(ACtekst_global),"Anty Cheat System (%s, %d)",NazwaBroni[weaponid], amount);
				NadajKare(playerid,-1, 2, ACtekst_global, 30);
			}
		}
		else
		{
			if(weaponid != PosiadanaBron[playerid])
			{
				if(weaponid != 0)
				{
					ResetPlayerWeapons(playerid);
					format(ACtekst_global, sizeof(ACtekst_global),"Anty Cheat System (%s, %d)",NazwaBroni[weaponid], amount);
					NadajKare(playerid,-1, 2, ACtekst_global, 30);
				}
			}
		}
	}
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
	/* new
            infoString[128],
            weaponName[24],
            victimName[MAX_PLAYER_NAME],
            attackerName[MAX_PLAYER_NAME];
 
        GetPlayerName(playerid, victimName, sizeof (victimName));
        GetPlayerName(issuerid, attackerName, sizeof (attackerName));
 
        GetWeaponName(weaponid, weaponName, sizeof (weaponName));
 
        format(infoString, sizeof(infoString), "%s has made %.0f damage to %s, weapon: %s", attackerName, amount, victimName, weaponName);
        SendClientMessageToAll(0xFF0000FF, infoString);*/
	if(AntyCheatBroni[issuerid] == 0)
	{
		if(PosiadanaBron[issuerid] == 0)
		{
			if(weaponid != 0)
			{
				ResetPlayerWeapons(issuerid);
				format(ACtekst_global, sizeof(ACtekst_global),"Anty Cheat System (%s, %d)",NazwaBroni[weaponid], amount);
				NadajKare(issuerid,-1, 2, ACtekst_global, 30);
			}
		}
		else
		{
			if(weaponid != PosiadanaBron[issuerid])
			{
				if(weaponid != 0)
				{
					ResetPlayerWeapons(issuerid);
					format(ACtekst_global, sizeof(ACtekst_global),"Anty Cheat System (%s, %d)",NazwaBroni[weaponid], amount);
					NadajKare(issuerid,-1, 2, ACtekst_global, 30);
				}
			}
		}
	}
	DaneGracza[issuerid][pShotPlayer][playerid] = true;
	if(DaneGracza[playerid][gBW] != 0)
	{
		Frezuj(issuerid, 0);//frezz
		Frezuj(issuerid, 1);
		GameTextForPlayer(issuerid, "~r~Atak zabroniony.", 3000, 5);
		return 0;
	}
	/*if(issuerid != INVALID_PLAYER_ID && amount > 5.0 && (weaponid != 23 || weaponid != 34))
    {
		ApplyAnimation(playerid,"CRACK","crckidle1",4.1,0,0,0,1,0);
		Frezuj(playerid, 0);
		Dostal[playerid] = 10;
    }*/
	if(issuerid != INVALID_PLAYER_ID && weaponid == 23 && !IsPlayerInAnyVehicle(playerid))
    {
		Frezuj(playerid, 0);
		Dostal[playerid] = 20;
		ApplyAnimation(playerid, "CRACK", "crckidle2", 4, 0, 0, 1, 1, 0, 0);
		ApplyAnimation(playerid, "CRACK", "crckidle2", 4, 0, 0, 1, 1, 0, 0);
		//KillTimer(DaneGracza[playerid][gTimerParliator]);
		//DaneGracza[playerid][gTimerParliator] = SetTimerEx("Paral", 5000, 0, "i", playerid);
    }
	else if(issuerid != INVALID_PLAYER_ID && weaponid >= 22 && weaponid <= 38 && !IsPlayerInAnyVehicle(playerid))
    {
		Frezuj(playerid, 0);
		Dostal[playerid] = 10;
		new losowa = random(3);
		if(losowa == 0)
		{
			ApplyAnimation(playerid, "CRACK", "crckidle2", 4, 0, 0, 1, 1, 0, 0);
			ApplyAnimation(playerid, "CRACK", "crckidle2", 4, 0, 0, 1, 1, 0, 0);
		}
		else if(losowa == 1)
		{
			ApplyAnimation(playerid, "SWEET", "gnstwall_injurd", 4, 1, 0, 0, 1, 1, 1);
			ApplyAnimation(playerid, "SWEET", "gnstwall_injurd", 4, 1, 0, 0, 1, 1, 1);
		}
		else
		{
			ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4, 1, 0, 0, 1, 1, 1);
			ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4, 1, 0, 0, 1, 1, 1);
		}
    }
	if(weaponid == 0)
	{
		if(DaneGracza[issuerid][gCZAS_ONLINE] < 18000)
		{
			//UstawHP(playerid, DaneGracza[playerid][gZDROWIE]);
			ZabierzHP(playerid, 0);
			dShowPlayerDialog(issuerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ze wzglêdu bezpieczeñstwa przed ({88b711}DM{DEDEDE}) ze strony nowych graczy:\n\nNie mo¿esz zadaæ obra¿eñ poniewa¿ nie masz przegranych 5 godzin.", "Zamknij", "");
			return 1;
		}
		else
		{
			if(DaneGracza[playerid][gCZAS_ONLINE] < 18000)
			{
				//UstawHP(playerid, DaneGracza[playerid][gZDROWIE]);
				ZabierzHP(playerid, 0);
				dShowPlayerDialog(issuerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ze wzglêdu bezpieczeñstwa przed ({88b711}DM{DEDEDE}) na nowych graczach:\n\nNie mo¿esz zadaæ obra¿eñ poniewa¿ ten gracz nie ma przegranych 5 godzin.", "Zamknij", "");
				return 1;
			}
			else
			{
				if(DaneGracza[issuerid][gSILA] >= 3000 && DaneGracza[issuerid][gSILA] <= 3050)
				{
					amount = 1;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3051 && DaneGracza[issuerid][gSILA] <= 3100)
				{
					amount = 2;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3101 && DaneGracza[issuerid][gSILA] <= 3150)
				{
					amount = 3;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3151 && DaneGracza[issuerid][gSILA] <= 3200)
				{
					amount = 4;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3201 && DaneGracza[issuerid][gSILA] <= 3250)
				{
					amount = 5;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3251 && DaneGracza[issuerid][gSILA] <= 3300)
				{
					amount = 6;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3301 && DaneGracza[issuerid][gSILA] <= 3350)
				{
					amount = 7;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3351 && DaneGracza[issuerid][gSILA] <= 3400)
				{
					amount = 8;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3401 && DaneGracza[issuerid][gSILA] <= 3450)
				{
					amount = 9;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3451 && DaneGracza[issuerid][gSILA] <= 3500)
				{
					amount = 10;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3501 && DaneGracza[issuerid][gSILA] <= 3550)
				{
					amount = 11;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3551 && DaneGracza[issuerid][gSILA] <= 3600)
				{
					amount = 12;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3601 && DaneGracza[issuerid][gSILA] <= 3650)
				{
					amount = 13;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3651 && DaneGracza[issuerid][gSILA] <= 3700)
				{
					amount = 14;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3701 && DaneGracza[issuerid][gSILA] <= 3750)
				{
					amount = 15;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3751 && DaneGracza[issuerid][gSILA] <= 3800)
				{
					amount = 16;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3801 && DaneGracza[issuerid][gSILA] <= 3850)
				{
					amount = 17;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3851 && DaneGracza[issuerid][gSILA] <= 3900)
				{
					amount = 18;
				}
				else if(DaneGracza[issuerid][gSILA] >= 3901 && DaneGracza[issuerid][gSILA] <= 3950)
				{
					amount = 19;
				}
				else if(DaneGracza[issuerid][gSILA] >= 4000)
				{
					amount = 20;
				}
				UstawHP(playerid, DaneGracza[playerid][gZDROWIE]-amount);
				return 1;
			}

		}
	}
	else if(weaponid == 38)
	{
		NadajKare(issuerid,-1, 2, "Anty Cheat System (Minigun)", 30);
		return 1;
	}
	DodajHP(playerid, -amount);
	//new Float:HP = DaneGracza[playerid][gZDROWIE];
	//DodajHP(playerid, -amount);
	//if(DaneGracza[playerid][gZDROWIE] != (HP-amount))
	//{
	//	NadajKare(playerid,-1, 0, "Prawdopodobny GodMode", -1);
	//}
	return 1;
}
forward RefUderzony(playerid);
public RefUderzony(playerid)
{
    RefreshNick(playerid);
	return 1;
}
forward Kicks(playerid);
public Kicks(playerid)
{
    Kick(playerid);
	return 1;
}
forward Logowanie(playerid, haslo[]);
public Logowanie(playerid, haslo[])
{
 	new sql3[512], tekst[254];
 	ResetPlayerWeapons(playerid);
	format(sql3, sizeof(sql3), "SELECT * FROM `five_users` WHERE `uid` = '%d' AND `password` = '%s'", DaneGracza[playerid][gGUID], MD5_Hash(haslo));
	mysql_query(sql3);
	mysql_store_result();
	if(mysql_num_rows() != 0)
	{
		if(ogmx != 0)
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~r~Prosze czekac, serwer jest w trakcje restartowania!", 2000, 5);
			new str5[256];
			format(str5, sizeof(str5), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerów Role Play!\n\n{DEDEDE}Próbujesz zalogowaæ siê na postaæ:{88B711} %s\n{DEDEDE}Wpisz swoje has³o(Globalne) i kliknij ''Zaloguj'' aby sie zalogowaæ!",ImieGracza2(playerid));
			dShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Panel Logowania{88b711}:", str5, "Zaloguj", "Wyjdz");
		}
		else
		{
			if(JestIG(DaneGracza[playerid][gGUID]) == 1)
			{
				SendClientMessage(playerid, SZARY,  "{DEDEDE}Na tym globalu jest ju¿ zalogowana postaæ.");
				SetTimerEx("Kicks", 1000, 0, "d", playerid);
				return 0;
			}
			else
			{
				new sql2[612], str[512], zero[50];
				format(sql2, sizeof(sql2), "SELECT * FROM `five_postacie` WHERE `IMIE_NAZWISKO` = '%s'", ImieGracza(playerid));
				mysql_query(sql2);
				mysql_store_result();
				mysql_fetch_row(sql2);
				sscanf(sql2, "p<|>dds[20]dddddfddds[20]s[124]s[60]s[124]s[20]ddfffdds[124]dddddddddddddfffdddddddddfddds[124]ddddd", DaneGracza[playerid][gUID]
					,DaneGracza[playerid][gGUID]
					,zero
					,DaneGracza[playerid][gCZAS_ONLINE]
					,DaneGracza[playerid][gOSTATNIO_NA_SERWERZE]
					,DaneGracza[playerid][gPORTFEL]
					,DaneGracza[playerid][gPLEC]
					,DaneGracza[playerid][gSKIN]
					,DaneGracza[playerid][gZDROWIE]
					,DaneGracza[playerid][gSILA]
					,DaneGracza[playerid][gWIEK]
					,DaneGracza[playerid][gWAGA]
					,DaneGracza[playerid][gRASA]
					,DaneGracza[playerid][gDokumenty]
					,DaneGracza[playerid][gSTAN_CYWILNY]
					,DaneGracza[playerid][gPOCHODZENIE]
					,zero
					,DaneGracza[playerid][gONLINE]
					,DaneGracza[playerid][gBW]
					,DaneGracza[playerid][gX]
					,DaneGracza[playerid][gY]
					,DaneGracza[playerid][gZ]
					,DaneGracza[playerid][gVW]
					,DaneGracza[playerid][gINT]
					,DaneGracza[playerid][gIP]
					,DaneGracza[playerid][gOCZEKIWANA_WYPLATA]
					,DaneGracza[playerid][gAKTYWNE]
					,DaneGracza[playerid][gBronAmmo]
					,DaneGracza[playerid][gBronUID]
					,DaneGracza[playerid][gDoPelnejGodziny]
					,DaneGracza[playerid][gLskin]
					,DaneGracza[playerid][gWynajem]
					,DaneGracza[playerid][gAJ]
					,DaneGracza[playerid][gQS]
					,DaneGracza[playerid][gPromile]
					,DaneGracza[playerid][gPktKarne]
					,DaneGracza[playerid][gPrzetrzmanie]
					,DaneGracza[playerid][gPUID]
					,DaneGracza[playerid][gPX]
					,DaneGracza[playerid][gPY]
					,DaneGracza[playerid][gPZ]
					,DaneGracza[playerid][gGlod]
					,DaneGracza[playerid][gEdytor]
					,DaneGracza[playerid][gKONTO_W_BANKU]
					,DaneGracza[playerid][gOstatniTrening]
					,DaneGracza[playerid][gStylWalki]
					,DaneGracza[playerid][gNrTreningu]
					,DaneGracza[playerid][gTrenowanyStyl]
					,DaneGracza[playerid][gOczekujacaKasa]
					,DaneGracza[playerid][gBetaTester]
					,DaneGracza[playerid][gUzaleznienie]
					,DaneGracza[playerid][gCzasTrwaniaUzaleznienia]
					,DaneGracza[playerid][gPracaTyp]
					,DaneGracza[playerid][gTelefon]
					,DaneGracza[playerid][gOsiagniecia]
					,DaneGracza[playerid][gPrzyczepiony1]
					,DaneGracza[playerid][gPrzyczepiony2]
					,DaneGracza[playerid][gZasilek]
					,DaneGracza[playerid][gZamHot]
					,DaneGracza[playerid][gTYPCHODZENIA]
				);
				if(DaneGracza[playerid][gZDROWIE] < 5)
				{
					DaneGracza[playerid][gZDROWIE] = 6;
					DaneGracza[playerid][gBW] = 1;
				}
				if(BlokadaBAN(playerid))
				{
					SendClientMessage(playerid, 0xFFb00000, "{DEDEDE}Global z którego próbujesz siê {88b711}zalogowaæ{DEDEDE} jest zbanowany.");
					SendClientMessage(playerid, 0xFFb00000, "{DEDEDE}Jeœli uwa¿asz, ¿e kara zosta³a nadana {88b711}nies³usznie{DEDEDE} mo¿esz apelowaæ od tej kary na forum. ({88b711}www.five-rp.com{DEDEDE})");
					SetTimerEx("Kicks", 1000, 0, "d", playerid);
					return 0;
				}
				/*if(DaneGracza[playerid][gBetaTester] == 0)
				{
					SendClientMessage(playerid, 0xFFb00000, "{DEDEDE}Global z którego próbujesz siê {88b711}zalogowaæ{DEDEDE} nie posiada statusu {88b711}Beta Testera{DEDEDE}.");
					SetTimerEx("Kicks", 1000, 0, "d", playerid);
					return 0;
				}*/
				new dok[124];
				format(dok,sizeof(dok), "%s", DaneGracza[playerid][gDokumenty]);
				new ilosc_znakow_a = strlen(dok), uprawsa = 0;
				for(new u = 0; u < ilosc_znakow_a; u++)
				{
					if(dok[u] == '1' || dok[u] == '0')
					{
						new znak[256];
						format(znak,sizeof(znak), "%c", dok[u]);
						new uprawnienie_dodaj = strval(znak);
						DaneGracza[playerid][gDokumenty][uprawsa] = uprawnienie_dodaj;		
						uprawsa++;
					}
				}
				if(DaneGracza[playerid][gKONTO_W_BANKU] != 0)
				{
					new sql4[200];
					format(sql4, sizeof(sql4), "SELECT * FROM `five_bank` WHERE `UID_POSTACI` = '%d' AND `ID` = '%d' LIMIT 1", DaneGracza[playerid][gUID], DaneGracza[playerid][gKONTO_W_BANKU]);
					mysql_query(sql4);
					mysql_store_result();
					if(mysql_num_rows() != 0)
					{
						mysql_fetch_row(sql4);
						sscanf(sql4, "p<|>ds[124]ddds[124]ds[124]{d}{d}", DaneGracza[playerid][gUID_BANKU]
							,DaneGracza[playerid][gNAZWA_BANKU]
							,DaneGracza[playerid][gNUMER_KONTA]
							,DaneGracza[playerid][gNUMER_KARTY]
							,DaneGracza[playerid][gSTAN_KONTA]
							,DaneGracza[playerid][gBIC]
							,DaneGracza[playerid][gKREDYT]
							,DaneGracza[playerid][gIBAN]
						);
					}
				}
				zalogowany[playerid] = true;
				if(DaneGracza[playerid][gOczekujacaKasa] != 0)
				{
					DaneGracza[playerid][gSTAN_KONTA] += DaneGracza[playerid][gOczekujacaKasa];
					DaneGracza[playerid][gOczekujacaKasa] = 0;
					new strs[124];
					strdel(strs, 0, 124);
					format(strs, sizeof(strs), "UPDATE `five_postacie` SET `OCZEKUJACA_KASA` = '%d' WHERE `ID` = '%d'", DaneGracza[playerid][gOczekujacaKasa], DaneGracza[playerid][gUID]);
					mysql_query(strs);
					ZapiszBankKasa(playerid);
				}
				if(DaneGracza[playerid][gRASA] == 'B')
				{
					format( DaneGracza[playerid][gRASA],128,RASA_BIALA);
				}
				else if(DaneGracza[playerid][gRASA] == 'Z')
				{
					format( DaneGracza[playerid][gRASA],128,RASA_ZOLTA);
				}
				else
				{
					format( DaneGracza[playerid][gRASA],128,RASA_CZARNA);
				}
				ResetPlayerWeapons(playerid);
				if(!GraczPremium(playerid))
				{
					format(tekst, sizeof(tekst), "Witaj %s, zalogowa³eœ siê jako %s (ID: %d, UID: %d, GUID: %d){DEDEDE}, ¿yczymy mi³ej gry!", DaneGracza[playerid][nickOOC], ImieGracza2(playerid), playerid, DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
					SendClientMessage(playerid, 0x88B711FF, tekst);
					DaneGracza[playerid][gKOLOR] = 0xFFFFFFFF;
				}
				else
				{
					format(tekst,sizeof tekst,"Witaj %s, zalogowa³eœ siê jako %s (ID: %d, UID: %d, GUID: %d){DEDEDE}, dziêkujemy za zakup Konta Premium i ¿yczymy mi³ej gry!", DaneGracza[playerid][nickOOC], ImieGracza2(playerid), playerid, DaneGracza[playerid][gUID], DaneGracza[playerid][gGUID]);
					SendClientMessage(playerid,0x88B711FF,tekst);
					DaneGracza[playerid][gKOLOR] = 0x88B711FF;
				}
				//Transakcja(T_WSZEDL, DaneGracza[playerid][gUID], -1, DaneGracza[playerid][gGUID], -1, -1, -1, -1, -1, "", gettime()-CZAS_LETNI);
				ZaladujPojazdyGracza(playerid);
				DaneGracza[playerid][gTimerGlodu] = SetTimerEx("Glod", 140000, 1, "i", playerid);
				AFK[playerid] = 0;
				Wylogowany[playerid] = 60;
				RefreshNick(playerid);
				new IP[16];
				GetPlayerIp(playerid, IP, sizeof(IP));
				format(DaneGracza[playerid][gIP], 32, "%s", IP);
				UstawHP(playerid,DaneGracza[playerid][gZDROWIE]);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(KtoJestOnline[i] == -1)
					{
						KtoJestOnline[i] = playerid;
						IloscGraczy++;
						break;
					}
				}
				SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
				OstatnieDrzwi[playerid] = GetPlayerVirtualWorld(playerid);
				strdel(str, 0, 512);
				format(str, sizeof(str), "UPDATE `five_postacie` SET `ONLINE` = '1', `IP` = '%s' WHERE `ID` = '%d'", DaneGracza[playerid][gIP], DaneGracza[playerid][gUID]);
				DaneGracza[playerid][gONLINE] = 1;
				mysql_query(str);
				SetPVarInt(playerid, "Teleportacja", 1);
				if(DaneGracza[playerid][gLskin] == 0)
				{
					SetPlayerSkin(playerid, DaneGracza[playerid][gSKIN]);
				}else{
					SetPlayerSkin(playerid, DaneGracza[playerid][gLskin]);
				}
				SetPVarInt(playerid, "Teleportacja", 0);
				RefreshNick(playerid);
				////////////////////////////////////////////////////////////////////////////////
				new nr = 0;
				format(zapyt, sizeof(zapyt), "SELECT * FROM `five_pracownicy` WHERE `UID_POSTACI`='%d' LIMIT 6", DaneGracza[playerid][gUID]);
				mysql_check();
				mysql_query2(zapyt);
				mysql_store_result();
				while(mysql_fetch_row_format(zapyt))
				{
					if(nr == 0)
					{
						sscanf(zapyt,  "p<|>{dd}ddddddds[512]", DaneGracza[playerid][gDzialalnosc1]
						,DaneGracza[playerid][gPrzynaleznosci][0]
						,DaneGracza[playerid][gPrzynaleznosci][1]
						,DaneGracza[playerid][gPrzynaleznosci][2]
						,DaneGracza[playerid][gPrzynaleznosci][3]
						,DaneGracza[playerid][gPrzynaleznosci][4]
						,DaneGracza[playerid][gPrzynaleznosci][5]
						,DaneGracza[playerid][gUprawnieniaGracza1]);
						DaneGracza[playerid][gPrzynaleznosci][1] = 0;
						DaneGracza[playerid][gPrzynaleznosci][3] = 0;
					}
					else if(nr == 1)//2,8,14,20,26,32,DaneGracza[playerid][gPrzynaleznosci][6]
					{
						sscanf(zapyt,  "p<|>{dd}ddddddds[512]", DaneGracza[playerid][gDzialalnosc2]
						,DaneGracza[playerid][gPrzynaleznosci][6]
						,DaneGracza[playerid][gPrzynaleznosci][7]
						,DaneGracza[playerid][gPrzynaleznosci][8]
						,DaneGracza[playerid][gPrzynaleznosci][9]
						,DaneGracza[playerid][gPrzynaleznosci][10]
						,DaneGracza[playerid][gPrzynaleznosci][11]
						,DaneGracza[playerid][gUprawnieniaGracza2]);
						DaneGracza[playerid][gPrzynaleznosci][7] = 0;
						DaneGracza[playerid][gPrzynaleznosci][9] = 0;
					}
					else if(nr == 2)
					{
						sscanf(zapyt,  "p<|>{dd}ddddddds[512]", DaneGracza[playerid][gDzialalnosc3]
						,DaneGracza[playerid][gPrzynaleznosci][12]
						,DaneGracza[playerid][gPrzynaleznosci][13]
						,DaneGracza[playerid][gPrzynaleznosci][14]
						,DaneGracza[playerid][gPrzynaleznosci][15]
						,DaneGracza[playerid][gPrzynaleznosci][16]
						,DaneGracza[playerid][gPrzynaleznosci][17]
						,DaneGracza[playerid][gUprawnieniaGracza3]);
						DaneGracza[playerid][gPrzynaleznosci][13] = 0;
						DaneGracza[playerid][gPrzynaleznosci][15] = 0;
					}
					else if(nr == 3)
					{
						sscanf(zapyt,  "p<|>{dd}ddddddds[512]", DaneGracza[playerid][gDzialalnosc4]
						,DaneGracza[playerid][gPrzynaleznosci][18]
						,DaneGracza[playerid][gPrzynaleznosci][19]
						,DaneGracza[playerid][gPrzynaleznosci][20]
						,DaneGracza[playerid][gPrzynaleznosci][21]
						,DaneGracza[playerid][gPrzynaleznosci][22]
						,DaneGracza[playerid][gPrzynaleznosci][23]
						,DaneGracza[playerid][gUprawnieniaGracza4]);
						DaneGracza[playerid][gPrzynaleznosci][19] = 0;
						DaneGracza[playerid][gPrzynaleznosci][21] = 0;
					}
					else if(nr == 4)
					{
						sscanf(zapyt,  "p<|>{dd}ddddddds[512]", DaneGracza[playerid][gDzialalnosc5]
						,DaneGracza[playerid][gPrzynaleznosci][24]
						,DaneGracza[playerid][gPrzynaleznosci][25]
						,DaneGracza[playerid][gPrzynaleznosci][26]
						,DaneGracza[playerid][gPrzynaleznosci][27]
						,DaneGracza[playerid][gPrzynaleznosci][28]
						,DaneGracza[playerid][gPrzynaleznosci][29]
						,DaneGracza[playerid][gUprawnieniaGracza5]);
						DaneGracza[playerid][gPrzynaleznosci][25] = 0;
						DaneGracza[playerid][gPrzynaleznosci][27] = 0;
					}
					else if(nr == 5)
					{
						sscanf(zapyt,  "p<|>{dd}ddddddds[512]", DaneGracza[playerid][gDzialalnosc6]
						,DaneGracza[playerid][gPrzynaleznosci][30]
						,DaneGracza[playerid][gPrzynaleznosci][31]
						,DaneGracza[playerid][gPrzynaleznosci][32]
						,DaneGracza[playerid][gPrzynaleznosci][33]
						,DaneGracza[playerid][gPrzynaleznosci][34]
						,DaneGracza[playerid][gPrzynaleznosci][35]
						,DaneGracza[playerid][gUprawnieniaGracza6]);
						DaneGracza[playerid][gPrzynaleznosci][31] = 0;
						DaneGracza[playerid][gPrzynaleznosci][33] = 0;
					}
					nr++;
				}
				new numerek = 0;
				for(new i = 1; i <= nr; i++)
				{
					new dzial[10], upraw[350];
					dzial[1] = DaneGracza[playerid][gDzialalnosc1];
					dzial[2] = DaneGracza[playerid][gDzialalnosc2];
					dzial[3] = DaneGracza[playerid][gDzialalnosc3];
					dzial[4] = DaneGracza[playerid][gDzialalnosc4];
					dzial[5] = DaneGracza[playerid][gDzialalnosc5];
					dzial[6] = DaneGracza[playerid][gDzialalnosc6];
					switch(i)
					{
						case 1:
							format(upraw, sizeof(upraw), "%s", DaneGracza[playerid][gUprawnieniaGracza1]);
						case 2:
							format(upraw, sizeof(upraw), "%s", DaneGracza[playerid][gUprawnieniaGracza2]);
						case 3:
							format(upraw, sizeof(upraw), "%s", DaneGracza[playerid][gUprawnieniaGracza3]);
						case 4:
							format(upraw, sizeof(upraw), "%s", DaneGracza[playerid][gUprawnieniaGracza4]);
						case 5:
							format(upraw, sizeof(upraw), "%s", DaneGracza[playerid][gUprawnieniaGracza5]);
						case 6:
							format(upraw, sizeof(upraw), "%s", DaneGracza[playerid][gUprawnieniaGracza6]);
					}
					ZaladujDzialalnoscisPracownika(dzial[i], playerid);
					kolorchatu(playerid, dzial[i], i);
					new strs[125], pobierz[300];
					format(strs, sizeof(strs), "ranga:%d", DaneGracza[playerid][gPrzynaleznosci][numerek]);
					if(ComparisonString(upraw, strs))
					{
						format(pobierz, sizeof(pobierz), "SELECT `RANGA_%d` FROM `five_rangi` WHERE `UID_DZIALALNOSCI`='%d' LIMIT 1", DaneGracza[playerid][gPrzynaleznosci][numerek],dzial[i]);
						mysql_check();
						mysql_query2(pobierz);
						mysql_store_result();
						mysql_fetch_row_format(pobierz);
						new rangowanie[300];
						format(rangowanie, sizeof(rangowanie), "%s", pobierz);
						new znaki = strfind(pobierz, "|", true);
						if(znaki != -1)
						{
							new usun = znaki+1;
							strdel(pobierz, 0, usun);
						}
						new ilosc_znakow = strlen(pobierz), upraws = 0;
						for(new u = 0; u < ilosc_znakow; u++)
						{
							if(pobierz[u] == '1' || pobierz[u] == '0')
							{
								new znak[25];
								format(znak,sizeof(znak), "%c", pobierz[u]);
								new uprawnienie_dodaj = strval(znak);
								switch(i)
								{
									case 1:
									{
										DaneGracza[playerid][gUprawnienia1][upraws] = uprawnienie_dodaj;
										sscanf(rangowanie, "p<|>s[124]{s[300]}",DaneGracza[playerid][gNazwaRangi1]);
									}
									case 2:
									{
										DaneGracza[playerid][gUprawnienia2][upraws] = uprawnienie_dodaj;
										sscanf(rangowanie, "p<|>s[124]{s[300]}",DaneGracza[playerid][gNazwaRangi2]);
									}
									case 3:
									{
										DaneGracza[playerid][gUprawnienia3][upraws] = uprawnienie_dodaj;
										sscanf(rangowanie, "p<|>s[124]{s[300]}",DaneGracza[playerid][gNazwaRangi3]);
									}
									case 4:
									{
										DaneGracza[playerid][gUprawnienia4][upraws] = uprawnienie_dodaj;
										sscanf(rangowanie, "p<|>s[124]{s[300]}",DaneGracza[playerid][gNazwaRangi4]);
									}
									case 5:
									{
										DaneGracza[playerid][gUprawnienia5][upraws] = uprawnienie_dodaj;
										sscanf(rangowanie, "p<|>s[124]{s[300]}",DaneGracza[playerid][gNazwaRangi5]);
									}
									case 6:
									{
										DaneGracza[playerid][gUprawnienia6][upraws] = uprawnienie_dodaj;
										sscanf(rangowanie, "p<|>s[124]{s[300]}",DaneGracza[playerid][gNazwaRangi6]);
									}
								}
								upraws++;
							}
						}
					}
					else
					{
						new ilosc_znakows = strlen(upraw), upraws1 = 0;
						for(new us = 0; us < ilosc_znakows; us++)
						{
							if(upraw[us] == '1' || upraw[us] == '0')
							{
								new znak1[256];
								format(znak1,sizeof(znak1), "%c", upraw[us]);
								new uprawnienie_dodaj1 = strval(znak1);
								switch(i)
								{
									case 1:
										DaneGracza[playerid][gUprawnienia1][upraws1] = uprawnienie_dodaj1;
									case 2:
										DaneGracza[playerid][gUprawnienia2][upraws1] = uprawnienie_dodaj1;
									case 3:
										DaneGracza[playerid][gUprawnienia3][upraws1] = uprawnienie_dodaj1;
									case 4:
										DaneGracza[playerid][gUprawnienia4][upraws1] = uprawnienie_dodaj1;
									case 5:
										DaneGracza[playerid][gUprawnienia5][upraws1] = uprawnienie_dodaj1;
									case 6:
										DaneGracza[playerid][gUprawnienia6][upraws1] = uprawnienie_dodaj1;
								}
								upraws1++;
							}
						}
					}
					numerek += 6;
				}
				new osiag[124];
				format(osiag,sizeof(osiag), "%s", DaneGracza[playerid][gOsiagniecia]);
				new ilosc_znakow_f = strlen(osiag), uprawsf = 0;
				for(new u = 0; u < ilosc_znakow_f; u++)
				{
					if(osiag[u] == '1' || osiag[u] == '0')
					{
						new znak[256];
						format(znak,sizeof(znak), "%c", osiag[u]);
						new uprawnienie_dodaj = strval(znak);
						DaneGracza[playerid][gOsiagniecia][uprawsf] = uprawnienie_dodaj;		
						uprawsf++;
					}
				}
				SetProgressBarValue(Bar:PasekGlodu[playerid], DaneGracza[playerid][gGlod]);
				if(PasekGloduWLACZONY[playerid] != 0)
				{
					ShowProgressBarForPlayer(playerid, PasekGlodu[playerid]);
				}
				AntyCheatBroni[playerid] = 1;
				KillTimer(TimerAntyCheat[playerid]);
				TimerAntyCheat[playerid] = SetTimerEx("WlaczAntyCheata",5000,0,"d",playerid);
				SetPVarInt(playerid, "Teleportacja", 1);
				//SpawnPlayer(playerid);
				SetTimerEx("Spawns",500, 0, "d", playerid);
				SetPVarInt(playerid, "Teleportacja", 0);
				AIR[playerid] = SetTimerEx("Air",2000, 1, "d", playerid);
			}
		}
////////////////////////////////////////////////////////////////////////////////
	}
	else
	{
		Proby[playerid]++;
		if(Proby[playerid] == 3)
		{
			new str2[256];
			format(str2, sizeof(str2), "{DEDEDE}Próbowa³eœ zalogowaæ siê na Postac:{88B711} %s\n\n{DEDEDE}3 razy wpisa³eœ z³e has³o - zosta³o to zanotowane w logach.",ImieGracza2(playerid));
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", str2, "Zamknij", "");
			new IP[16];
			GetPlayerIp(playerid, IP, sizeof(IP));
			sukces(playerid, 1, DaneGracza[playerid][gGUID], DaneGracza[playerid][gUID], IP,PRZEBYTE[playerid]);
			Kick(playerid);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~r~Podano bledne haslo!", 2000, 5);
		}
		new str5[256];
    	format(str5, sizeof(str5), "{88B711}Witaj na Five Role Play - Jednym z nowoczesnych i stale rozwijanych serwerów Role Play!\n\n{DEDEDE}Próbujesz zalogowaæ siê na postaæ:{88B711} %s\n{DEDEDE}Wpisz swoje has³o(Globalne) i kliknij ''Zaloguj'' aby sie zalogowaæ!",ImieGracza2(playerid));
		dShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Panel Logowania{88b711}:", str5, "Zaloguj", "Wyjdz");
	}
	return 1;
}
stock Bluzgi(text[])
{
	if(strfind(text[0],"huj",false)!=-1||
	strfind(text[0],"chuj",false)!=-1||
	strfind(text[0],"kurwa",false)!=-1||
	strfind(text[0],"suka",false)!=-1||
	strfind(text[0],"szmata",false)!=-1||
	strfind(text[0],"dziwka",false)!=-1||
	strfind(text[0],"jebaæ",false)!=-1||
	strfind(text[0],"jebac",false)!=-1||
	strfind(text[0],"spierdalaj",false)!=-1||
	strfind(text[0],"pierdoliæ",false)!=-1||
	strfind(text[0],"pierdolic",false)!=-1||
	strfind(text[0],"jeb",false)!=-1||
	strfind(text[0],"ssij",false)!=-1||
	strfind(text[0],"suki",false)!=-1||
	strfind(text[0],"skurwysyn",false)!=-1||
	strfind(text[0],"kurwy",false)!=-1)
	{
	    return 1;
	}
    return 0;
}
stock SendWrappedMessageToAll(colour, const msg[], maxlength=120, const prefix[]="...")
{
    new length = strlen(msg);
    if(length <= maxlength) {
        SendClientMessageToAll(colour, msg);
        return;
    }
    new string[128], idx;
    for(new i, space, plen, bool:useprefix; i < length; i++) {
        if(i - idx + plen >= maxlength) {
            if(idx == space || i - space >= 25) {
                strmid(string, msg, idx, i);
                idx = i;
            } else {
                strmid(string, msg, idx, space);
                idx = space + 1;
            }
            if(useprefix) {
                strins(string, prefix, 0);
            } else {
                plen = strlen(prefix);
                useprefix = true;
            }
            format(string, sizeof(string), "%s...", string);
            SendClientMessageToAll(colour, string);
        } else if(msg[i] == ' ') {
            space = i;
        }
    }
    if(idx < length) {
        strmid(string, msg, idx, length);
        strins(string, prefix, 0);
        SendClientMessageToAll(colour, string);
    }
    return;
}
stock DGCZAT(playerid, kol[], colour, const msg[], maxlength=100, const prefix[]="[...]")
{
	strdel(tekst_global, 0, 2048);
    new length = strlen(msg);
    if(length <= maxlength) {
        new msgi[256];
        format(msgi, sizeof(msgi), "{%s}%s", kol, msg);
        SendClientMessage(playerid, colour, msgi);
        return 1;
    }
    new idx;
    for(new i, space, plen, bool:useprefix; i < length; i++) {
        if(i - idx + plen >= maxlength) {
            if(idx == space || i - space >= 25) {
                strmid(tekst_global, msg, idx, i);
                idx = i;
            } else {
                strmid(tekst_global, msg, idx, space);
                idx = space + 1;
            }
            if(useprefix) {
                strins(tekst_global, prefix, 0);
            } else {
                plen = strlen(prefix);
                useprefix = true;
            }
            format(tekst_global, sizeof(tekst_global), "{%s}%s...", kol, tekst_global);
            SendClientMessage(playerid, colour, tekst_global);
        } else if(msg[i] == ' ') {
            space = i;
        }
    }
    if(idx < length) {
        strmid(tekst_global, msg, idx, length);
        new pref[256];
        format(pref, sizeof(pref), "{%s}%s", kol, prefix);
        strins(tekst_global, pref, 0);
        SendClientMessage(playerid, colour, tekst_global);
    }
    return 1;
}
stock SendWrappedMessageToPlayer(playerid, colour, const msg[], maxlength=100, const prefix[]="[...]")
{
    new length = strlen(msg);
    if(length <= maxlength) {
        SendClientMessage(playerid, colour, msg);
        return;
    }
    new string[128], idx;
    for(new i, space, plen, bool:useprefix; i < length; i++) {
        if(i - idx + plen >= maxlength) {
            if(idx == space || i - space >= 25) {
                strmid(string, msg, idx, i);
                idx = i;
            } else {
                strmid(string, msg, idx, space);
                idx = space + 1;
            }
            if(useprefix) {
                strins(string, prefix, 0);
            } else {
                plen = strlen(prefix);
                useprefix = true;
            }
            format(string, sizeof(string), "%s...", string);
            SendClientMessage(playerid, colour, string);
        } else if(msg[i] == ' ') {
            space = i;
        }
    }
    if(idx < length) {
        strmid(string, msg, idx, length);
        strins(string, prefix, 0);
        SendClientMessage(playerid, colour, string);
    }
    return;
}
stock UsunBronieGracza(playerid, weaponid)
{
	new aass;
	aass = weaponid;
  /*  new plyWeapons[12];
    new plyAmmo[12];

    for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);
    	if(wep != weaponid)
    	{
    	    GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
    	}
	}
*/
    ResetPlayerWeapons(playerid);
    /*for(new slot = 0; slot != 12; slot++)
    {
    	dDajBron(playerid, plyWeapons[slot], plyAmmo[slot]);
    }*/
}
stock dDajBron(playerid,id,ammo)
{
	if((id<1||id>46)||id==19||id==20||id==21||id==40) return 0;
	dBron[playerid][id]=true;
	dAmmo[playerid][id]=ammo;
	GivePlayerWeapon(playerid,id,ammo);
	return 1;
}
forward SprawdzDostepnoscDzialalnosci(playerid, playeridz, dzialalnoscid);
public SprawdzDostepnoscDzialalnosci(playerid, playeridz, dzialalnoscid)
{
    if(DaneGracza[playeridz][gDzialalnosc1] == 0)
	{
	    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do dzia³alnoœci ju¿ siê w niej znajduje.", "Zamknij", "");
        	return 1;
		}
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Oferuj(playerid, playeridz, DaneGracza[playeridz][gUID], dzialalnoscid, DaneGracza[playerid][gPrzynaleznosci][0], -1, OFEROWANIE_INVITE, 0, "0|0", 0);
		Transakcja(T_OINV, DaneGracza[playerid][gUID], DaneGracza[playeridz][gUID], DaneGracza[playerid][gGUID], DaneGracza[playeridz][gGUID], -1, dzialalnoscid, -1, -1, "-", gettime()-CZAS_LETNI);
	    return 0;
	}
	else if(DaneGracza[playeridz][gDzialalnosc2] == 0)
	{
	    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do dzia³alnoœci ju¿ siê w niej znajduje.", "Zamknij", "");
        	return 1;
		}
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Transakcja(T_OINV, DaneGracza[playerid][gUID], DaneGracza[playeridz][gUID], DaneGracza[playerid][gGUID], DaneGracza[playeridz][gGUID], -1, dzialalnoscid, -1, -1, "-", gettime()-CZAS_LETNI);
        Oferuj(playerid, playeridz, DaneGracza[playeridz][gUID], dzialalnoscid, DaneGracza[playerid][gPrzynaleznosci][6], -1, OFEROWANIE_INVITE, 0, "0|0", 0);
	    return 0;
	}
	else if(DaneGracza[playeridz][gDzialalnosc3] == 0)
	{
	    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do dzia³alnoœci ju¿ siê w niej znajduje.", "Zamknij", "");
        	return 1;
	    }
	    GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
	    Transakcja(T_OINV, DaneGracza[playerid][gUID], DaneGracza[playeridz][gUID], DaneGracza[playerid][gGUID], DaneGracza[playeridz][gGUID], -1, dzialalnoscid, -1, -1, "-", gettime()-CZAS_LETNI);
        Oferuj(playerid, playeridz, DaneGracza[playeridz][gUID], dzialalnoscid, DaneGracza[playerid][gPrzynaleznosci][12], -1, OFEROWANIE_INVITE, 0, "0|0", 0);
	    return 1;
	}
	else if(DaneGracza[playeridz][gDzialalnosc4] == 0 && GraczPremium(playeridz))
	{
	    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do dzia³alnoœci ju¿ siê w niej znajduje.", "Zamknij", "");
        	return 1;
		}
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Transakcja(T_OINV, DaneGracza[playerid][gUID], DaneGracza[playeridz][gUID], DaneGracza[playerid][gGUID], DaneGracza[playeridz][gGUID], -1, dzialalnoscid, -1, -1, "-", gettime()-CZAS_LETNI);
        Oferuj(playerid, playeridz, DaneGracza[playeridz][gUID], dzialalnoscid, DaneGracza[playerid][gPrzynaleznosci][18], -1, OFEROWANIE_INVITE, 0, "0|0", 0);
	    return 0;
	}
	else if(DaneGracza[playeridz][gDzialalnosc5] == 0 && GraczPremium(playeridz))
	{
	    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
	    {
			dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do dzia³alnoœci ju¿ siê w niej znajduje.", "Zamknij", "");
        	return 1;
		}
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Transakcja(T_OINV, DaneGracza[playerid][gUID], DaneGracza[playeridz][gUID], DaneGracza[playerid][gGUID], DaneGracza[playeridz][gGUID], -1, dzialalnoscid, -1, -1, "-", gettime()-CZAS_LETNI);
        Oferuj(playerid, playeridz, DaneGracza[playeridz][gUID], dzialalnoscid, DaneGracza[playerid][gPrzynaleznosci][24], -1, OFEROWANIE_INVITE, 0, "0|0", 0);
	    return 0;
	}
	else if(DaneGracza[playeridz][gDzialalnosc6] == 0 && GraczPremium(playeridz))
	{
	    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid || DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid  || DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
	    {
	        dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Gracz którego chcesz {88b711}zaprosiæ{DEDEDE} do dzia³alnoœci ju¿ siê w niej znajduje.", "Zamknij", "");
        	return 1;
		}
		GameTextForPlayer(playerid, "~y~Oferta:~n~~w~Zostala wyslana czekaj na reakcje gracza.", 3000, 5);
		Transakcja(T_OINV, DaneGracza[playerid][gUID], DaneGracza[playeridz][gUID], DaneGracza[playerid][gGUID], DaneGracza[playeridz][gGUID], -1, dzialalnoscid, -1, -1, "-", gettime()-CZAS_LETNI);
        Oferuj(playerid, playeridz, DaneGracza[playeridz][gUID], dzialalnoscid, DaneGracza[playerid][gPrzynaleznosci][30], -1, OFEROWANIE_INVITE, 0, "0|0", 0);
	    return 0;
	}
	else
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ten gracz nie posiada wystarczaj¹cej iloœci {88b711}slotów{DEDEDE} aby do³¹czyæ do danej dzia³alnoœci", "Zamknij", "");
	}
	return 1;
}
stock PlayerObokPlayera(playerid, playerid2, range)
{
	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid2, x, y, z);
	if(IsPlayerInRangeOfPoint(playerid, range, x, y, z))
	{
	    return true;
	}
	else return false;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == TextOferty2[playerid])
    {
		PlayerTextDrawHide(playerid, TextOferty0[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty1[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty2[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty3[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty4[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty5[playerid]);
        CancelSelectTextDraw(playerid);
        Akceptacja(playerid, 0, -1);
        return 1;
    }
    else if(playertextid == TextOferty3[playerid])
    {
		PlayerTextDrawHide(playerid, TextOferty0[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty1[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty2[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty3[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty4[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty5[playerid]);
        CancelSelectTextDraw(playerid);
        Akceptacja(playerid, 1, 0);
    }
    else if(playertextid == TextOferty4[playerid])
    {
        if(DaneGracza[playerid][gKONTO_W_BANKU] != 0)
        {
			PlayerTextDrawHide(playerid, TextOferty0[playerid]);
		    PlayerTextDrawHide(playerid, TextOferty1[playerid]);
		    PlayerTextDrawHide(playerid, TextOferty2[playerid]);
		    PlayerTextDrawHide(playerid, TextOferty3[playerid]);
		    PlayerTextDrawHide(playerid, TextOferty4[playerid]);
		    PlayerTextDrawHide(playerid, TextOferty5[playerid]);
	        CancelSelectTextDraw(playerid);
        	Akceptacja(playerid, 1, 1);
        	return 1;
        }else{
            GameTextForPlayer(playerid, "~r~Nie posiadasz konta w banku.", 3000, 5);
            return 1;
        }
    }
    else if(playertextid == TextOferty5[playerid])
    {
		PlayerTextDrawHide(playerid, TextOferty0[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty1[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty2[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty3[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty4[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty5[playerid]);
        CancelSelectTextDraw(playerid);
        Akceptacja(playerid, 0, 0);
    }
    else if(playertextid == TextOferty6[playerid])
    {
		PlayerTextDrawHide(playerid, TextOferty0[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty1[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty2[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty6[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty7[playerid]);
        CancelSelectTextDraw(playerid);
        Akceptacja(playerid, 1, 2);
    }
    else if(playertextid == TextOferty7[playerid])
    {
		PlayerTextDrawHide(playerid, TextOferty0[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty1[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty2[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty6[playerid]);
	    PlayerTextDrawHide(playerid, TextOferty7[playerid]);
        CancelSelectTextDraw(playerid);
        Akceptacja(playerid, 0, 0);
    }
	else if(playertextid == Poker6[playerid])
	{
		CancelSelectTextDraw(playerid);
		cmd_poker(playerid, "");
	}
	else if(playertextid == Poker3[playerid])
	{
		WybralMozliwoscPoker[playerid] = 0;
		PlayerTextDrawHide(playerid,Poker2[playerid]);
		PlayerTextDrawHide(playerid,Poker3[playerid]);
		PlayerTextDrawHide(playerid,Poker4[playerid]);
		PlayerTextDrawHide(playerid,Poker5[playerid]);
		PlayerTextDrawHide(playerid,Poker6[playerid]);
		new roznica;
		roznica = ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][13] - DaneGracza[playerid][gPokerPostawione];
		if(roznica > 0)
		{
			new kasa[128];
			if(roznica >= DaneGracza[playerid][gPokerZetony])
			{
				DaneGracza[playerid][gInformacjePoker][0] = 1;
				roznica = DaneGracza[playerid][gPokerZetony];
				format(kasa, sizeof(kasa), "All-in ~r~($%d)", roznica);
			}
			else
			{
				format(kasa, sizeof(kasa), "Sprawdza");
			}
			NadajTextTextdraw(playerid, DaneGracza[playerid][gPoker], kasa);
			DaneGracza[playerid][gPokerZetony] -= roznica;
			ObiektInfo[DaneGracza[playerid][gPoker]][gPokerInfo][1] += roznica;
			DaneGracza[playerid][gPokerPostawione] += roznica;
			for(new i = 0; i < 30; i++)
			{
				if(DaneGracza[playerid][gPokerObj][i] != 0)
				{
					DestroyDynamicObject(DaneGracza[playerid][gPokerObj][i]);
					DaneGracza[playerid][gPokerObj][i] = 0;
				}
			}
			for(new i = 0; i < 30; i++)
			{
				if(DaneGracza[playerid][gNumeryObiektowPostawionych][i] != 0)
				{
					DestroyDynamicObject(DaneGracza[playerid][gNumeryObiektowPostawionych][i]);
					DaneGracza[playerid][gNumeryObiektowPostawionych][i] = 0;
				}
			}
			PrzeliczZetony(playerid, DaneGracza[playerid][gPoker], 0, 0);
			PrzeliczZetony(playerid, DaneGracza[playerid][gPoker], DaneGracza[playerid][gPokerPostawione], 5);
		}
		else
		{
			NadajTextTextdraw(playerid, DaneGracza[playerid][gPoker], "Czeka");
		}
		OdswiezTexdrawyPoker(DaneGracza[playerid][gPoker], 0);
		CancelSelectTextDraw(playerid);
		new ilosc = SprawdzIloscGraczy(DaneGracza[playerid][gPoker]);
		if(ilosc >= 2)
		{
			SprawdzKolejGracza(playerid);
		}
		else
		{
			KoniecRundy(DaneGracza[playerid][gPoker]);
		}
	}
	else if(playertextid == Poker4[playerid])
	{
		CancelSelectTextDraw(playerid);
		dShowPlayerDialog(playerid, DIALOG_POKER_PRZEBIJ, DIALOG_STYLE_INPUT, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Wpisz {88b711}kwotê{DEDEDE} któr¹ chcesz przebiæ zak³ad.", "Zatwierdz", "Zamknij");
		return 0;
	}
	else if(playertextid == Poker5[playerid])
	{
		WybralMozliwoscPoker[playerid] = 0;
		PlayerTextDrawHide(playerid,Poker2[playerid]);
		PlayerTextDrawHide(playerid,Poker3[playerid]);
		PlayerTextDrawHide(playerid,Poker4[playerid]);
		PlayerTextDrawHide(playerid,Poker5[playerid]);
		PlayerTextDrawHide(playerid,Poker6[playerid]);
		CancelSelectTextDraw(playerid);
		for(new i = 0; i < 6; i++)
		{
			if(ObiektInfo[DaneGracza[playerid][gPoker]][gAktualniGracze][i] == playerid)
			{
				ObiektInfo[DaneGracza[playerid][gPoker]][gAktualniGracze][i] = -1;
				DaneGracza[playerid][gPokerKarty][0] = 0;
				DaneGracza[playerid][gPokerKarty][1] = 0;
				DaneGracza[playerid][gInformacjePoker][0] = 0;
				DaneGracza[playerid][gInformacjePoker][1] = 0;
				DaneGracza[playerid][gInformacjePoker][2] = 0;
				DaneGracza[playerid][gInformacjePoker][3] = 0;
				DaneGracza[playerid][gInformacjePoker][4] = 0;
				DaneGracza[playerid][gInformacjePoker][5] = 0;
				DaneGracza[playerid][gInformacjePoker][6] = 0;
			}
		}
		NadajTextTextdraw(playerid, DaneGracza[playerid][gPoker], "Pasuje");
		OdswiezTexdrawyPoker(DaneGracza[playerid][gPoker], 2);
		new ilosc = SprawdzIloscGraczy(DaneGracza[playerid][gPoker]);
		if(ilosc >= 2)
		{
			SprawdzKolejGracza(playerid);
		}
		else
		{
			KoniecRundy(DaneGracza[playerid][gPoker]);
		}
	}
    return 1;
}
stock NickGraczaGlobalSQL(sqlid)
{
	if(sqlid == 0)
	{
		new nick[MAX_PLAYER_NAME];
		format(nick, sizeof(nick), "Brak");
		return nick;
	}
	new nick[MAX_PLAYER_NAME];
	format(zapyt, sizeof(zapyt), "SELECT `username` FROM `five_users` WHERE `uid` = '%d' LIMIT 1", sqlid);
	mysql_check();
	mysql_query2(zapyt);
	mysql_store_result();
	mysql_fetch_row(nick);
	UsuwanieTwardejSpacji(nick);
	mysql_free_result();
	return nick;
}
stock JestIG(guid)
{
	new sql4[200];
	format(sql4, sizeof(sql4), "SELECT * FROM `five_postacie` WHERE `ONLINE` = 1 AND `GUID` = '%d'", guid);
	mysql_query(sql4);
	mysql_store_result();
	if(mysql_num_rows() != 0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
stock SendClientMessageEx(playerid,color,type[],{Float,_}:...)
{
	strdel(tekst_global, 0, 2048);
	for(new i = 0;i<numargs() -2;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +3,a) != 0;a++)
				{
				    result[a] = getarg(i +3,a);
				}
				if(!strlen(tekst_global))
				{
				    format(tekst_global,sizeof tekst_global,"%s",result);
				} else format(tekst_global,sizeof tekst_global,"%s%s",tekst_global,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +3);
				if(!strlen(tekst_global))
				{
				    format(tekst_global,sizeof tekst_global,"%i",result);
				} else format(tekst_global,sizeof tekst_global,"%s%i",tekst_global,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +3);
				if(!strlen(tekst_global))
				{
				    format(tekst_global,sizeof tekst_global,"%f",result);
				} else format(tekst_global,sizeof tekst_global,"%s%f",tekst_global,result);
	        }
	    }
	}
    SendClientMessage(playerid,color,tekst_global);
    return 1;
}
forward Przebieg();
public Przebieg()
{
    ForeachEx(i, IloscGraczy)
    {
	    if(GetPlayerState(KtoJestOnline[i])==PLAYER_STATE_DRIVER)
		{
			new VehID=GetPlayerVehicleID(KtoJestOnline[i]);
			new uid = SprawdzCarUID(VehID);
            new lights,doors,bonnet,boot,objective,engine,alarm;
			GetVehicleParamsEx(VehID,engine,lights,alarm,doors,bonnet,boot,objective);
	       	if(engine)
	       	{
			    dDystans = GetPlayerDistanceFromPoint(KtoJestOnline[i], dOstatniX[KtoJestOnline[i]],dOstatniY[KtoJestOnline[i]],dOstatniZ[KtoJestOnline[i]]);
	      	    PojazdInfo[uid][pPrzebieg]+=dDystans;
			}
			GetVehiclePos(VehID,dOstatniX[KtoJestOnline[i]],dOstatniY[KtoJestOnline[i]],dOstatniZ[KtoJestOnline[i]]);
		}
	}
	return 1;
}
forward MinusAuto();
public MinusAuto()
{
    ForeachEx(i, IloscPojazdow)
    {
		if(GetVehiclePlayer(PojazdInfo[PojazdySerwera[i]][pID]) == -1)
		{		
			if(PojazdInfo[PojazdySerwera[i]][pSpawn] == 1 && !IsTrailerAttachedToVehicle(PojazdInfo[PojazdySerwera[i]][pID]) && PojazdInfo[PojazdySerwera[i]][pHolowany] == 0)
			{
				new Float:pXv, Float:pYv, Float:pZv;
				GetVehiclePos(PojazdInfo[PojazdySerwera[i]][pID],pXv,pYv,pZv);
				if(PojazdInfo[PojazdySerwera[i]][pOX]+5 < pXv || PojazdInfo[PojazdySerwera[i]][pOX]-5 > pXv || PojazdInfo[PojazdySerwera[i]][pOY]+5 < pYv || PojazdInfo[PojazdySerwera[i]][pOY]-5 > pYv || PojazdInfo[PojazdySerwera[i]][pOZ]+5 < pZv || PojazdInfo[PojazdySerwera[i]][pOZ]-5 > pZv)
				{
					if(PojazdInfo[PojazdySerwera[i]][pModel] == 574)
					{
						SetVehicleToRespawn(PojazdInfo[PojazdySerwera[i]][pID]);
						PojazdInfo[PojazdySerwera[i]][pStan] = 1000.0;
						PojazdInfo[PojazdySerwera[i]][pPaliwo] = 100;
						SetVehicleHealth(PojazdInfo[PojazdySerwera[i]][pID], PojazdInfo[PojazdySerwera[i]][pStan] );
						RepairVehicle(PojazdInfo[PojazdySerwera[i]][pID]);
					}
					else
					{
						//if(Jednoslady(PojazdInfo[i][pID]))
						//{
						//	GetVehiclePos(PojazdInfo[i][pID], PojazdInfo[i][pOX], PojazdInfo[i][pOY], PojazdInfo[i][pOZ]);
						//}
						PojazdInfo[PojazdySerwera[i]][pPrzepchany] = 1;
						PojazdInfo[PojazdySerwera[i]][pSpawn] = 0;
						UsunPojazdUID(PojazdySerwera[i]);
					}
				}
			}
		}
		else
		{
			if(GetVehiclePlayerKierownica(PojazdInfo[PojazdySerwera[i]][pID]) == 0)
			{
				if(PojazdInfo[PojazdySerwera[i]][pSpawn] == 1 && !IsTrailerAttachedToVehicle(PojazdInfo[PojazdySerwera[i]][pID]) && PojazdInfo[PojazdySerwera[i]][pHolowany] == 0)
				{
					new Float:pXv, Float:pYv, Float:pZv;
					GetVehiclePos(PojazdInfo[PojazdySerwera[i]][pID],pXv,pYv,pZv);
					if(PojazdInfo[PojazdySerwera[i]][pOX]+10 < pXv || PojazdInfo[PojazdySerwera[i]][pOX]-10 > pXv || PojazdInfo[PojazdySerwera[i]][pOY]+10 < pYv || PojazdInfo[PojazdySerwera[i]][pOY]-10 > pYv || PojazdInfo[PojazdySerwera[i]][pOZ]+10 < pZv || PojazdInfo[PojazdySerwera[i]][pOZ]-10 > pZv)
					{
						if(PojazdInfo[PojazdySerwera[i]][pModel] == 574)
						{
							SetVehicleToRespawn(PojazdInfo[PojazdySerwera[i]][pID]);
							PojazdInfo[PojazdySerwera[i]][pStan] = 1000.0;
							PojazdInfo[PojazdySerwera[i]][pPaliwo] = 100;
							SetVehicleHealth(PojazdInfo[PojazdySerwera[i]][pID], PojazdInfo[PojazdySerwera[i]][pStan] );
							RepairVehicle(PojazdInfo[PojazdySerwera[i]][pID]);
						}
						else
						{
							//if(Jednoslady(PojazdInfo[i][pID]))
							//{
							//	GetVehiclePos(PojazdInfo[i][pID], PojazdInfo[i][pOX], PojazdInfo[i][pOY], PojazdInfo[i][pOZ]);
							//}
							PojazdInfo[PojazdySerwera[i]][pPrzepchany] = 1;
							PojazdInfo[PojazdySerwera[i]][pSpawn] = 0;
							UsunPojazdUID(PojazdySerwera[i]);
						}
					}
				}
			}
		}
	}
	return 1;
}
forward Paral(playerid);
public Paral(playerid)
{
	OnPlayerText(playerid, "-crack");
	Dostal[playerid] = 5;
	return 1;
}
forward Glod(playerid);
public Glod(playerid)
{
	if(!GraczJestAFK(playerid) && DutyAdmina[playerid] == 0)
	{
		if(DaneGracza[playerid][gBW] == 0)
		{
			if(Kokaina[playerid] < gettime())
			{
				if(DaneGracza[playerid][gGlod] > 4)
				{
					DaneGracza[playerid][gGlod]-= 1;
					SetProgressBarValue(PasekGlodu[playerid], DaneGracza[playerid][gGlod]);
					if(PasekGloduWLACZONY[playerid] != 0)
					{
						ShowProgressBarForPlayer(playerid, PasekGlodu[playerid]);
					}
					if(DaneGracza[playerid][gGlod] <= 24)
					{
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], "Twoj organizm odczuwa lekki glod, udaj sie do sklepu po jakies pozywienie.");
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
					}
				}
				else
				{
					if(DaneGracza[playerid][gPromile] < 9500)
					{
						DaneGracza[playerid][gPromile] += 1000;
					}
					SetPlayerDrunkLevel(playerid, DaneGracza[playerid][gPromile]);
					DodajHP(playerid, -1);
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 10;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Twoj organizm jest wyglodzony, udaj sie do sklepu po jakies pozywienie.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
			}
		}
	}
}
forward MinusPaliwo(vehicleid);
public MinusPaliwo(vehicleid)
{
	new uid = SprawdzCarUID(vehicleid);
	if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510)
    {
	    PojazdInfo[uid][pPaliwo] = 50;
		return 1;
	}
	if(PojazdInfo[uid][pGaz] == 2)
	{
		PojazdInfo[uid][pPaliwoGaz]-= 0.1;
		if(PojazdInfo[uid][pPaliwoGaz] <= 0)
		{
			if(PojazdInfo[uid][pPaliwo] > 0)
			{
				PojazdInfo[uid][pGaz] = 1;
				new playerid = -1;
				for(new is=0; is< IloscGraczy; is++)
				{
					if(GetPlayerVehicleID(KtoJestOnline[is]) == PojazdInfo[uid][pID])
					{
						playerid = KtoJestOnline[is];
						break;
					}
				}
				if(playerid != -1)
				{
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Skonczyla sie gaz - zostales przelaczony na benzyne.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
			}
			SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
			PojazdInfo[uid][pSilnik] = 0;
			new eng, lights, alarm, drs, bonnet, boot, obj;
			GetVehicleParamsEx(vehicleid, eng, lights, alarm, drs, bonnet, boot, obj);
			SetVehicleParamsEx(vehicleid, PojazdInfo[uid][pSilnik], lights, 0, drs, bonnet, boot, obj);
			//format(bzstr, sizeof(bzstr), "**W pojezdzie %s skoñczy³o siê paliwo**", GetVehicleModelName(PojazdInfo[uid][pModel]));
			//SendVehText(15.0, vehicleid, bzstr, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
			KillTimer(PojazdInfo[uid][pTimer]);
		}
	}
	else
	{
        PojazdInfo[uid][pPaliwo]-= 0.1;
		if(PojazdInfo[uid][pPaliwo] <= 0)
		{
			if(PojazdInfo[uid][pGaz] != 0 && PojazdInfo[uid][pPaliwoGaz] > 0)
			{
				PojazdInfo[uid][pGaz] = 2;
				PojazdInfo[uid][pGaz] = 1;
				new playerid = -1;
				for(new is=0; is< IloscGraczy; is++)
				{
					if(GetPlayerVehicleID(KtoJestOnline[is]) == PojazdInfo[uid][pID])
					{
						playerid = KtoJestOnline[is];
						break;
					}
				}
				if(playerid != -1)
				{
					CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
					TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
					TextDrawSetString(TextNaDrzwi[playerid], "Skonczyla sie benzyna - zostales przelaczony na gaz.");
					TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
				}
			}
			else
			{
				SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
				PojazdInfo[uid][pSilnik] = 0;
				new eng, lights, alarm, drs, bonnet, boot, obj;
				GetVehicleParamsEx(vehicleid, eng, lights, alarm, drs, bonnet, boot, obj);
				SetVehicleParamsEx(vehicleid, PojazdInfo[uid][pSilnik], lights, 0, drs, bonnet, boot, obj);
				//format(bzstr, sizeof(bzstr), "**W pojezdzie %s skoñczy³o siê paliwo**", GetVehicleModelName(PojazdInfo[uid][pModel]));
				//SendVehText(15.0, vehicleid, bzstr, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
				KillTimer(PojazdInfo[uid][pTimer]);
			}
		}
	}
	if(PojazdInfo[uid][pStan] < 400)
	{
		SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
		PojazdInfo[uid][pSilnik] = 0;
		new eng, lights, alarm, drs, bonnet, boot, obj,bzstr[124];
		GetVehicleParamsEx(vehicleid, eng, lights, alarm, drs, bonnet, boot, obj);
		SetVehicleParamsEx(vehicleid, PojazdInfo[uid][pSilnik], lights, 0, drs, bonnet, boot, obj);
		format(bzstr, sizeof(bzstr), "**W pojezdzie %s zgas³ silnik, poniewa¿ jego uszkodzenia s¹ zbyt wielkie**", GetVehicleModelName(PojazdInfo[uid][pModel]));
		SendVehText(15.0, vehicleid, bzstr, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO, KOLOR_DO);
		KillTimer(PojazdInfo[uid][pTimer]);
	}
	ZapiszPojazd(uid, 1);
	return 1;
}
forward AdminFly(playerid);
public AdminFly(playerid)
{
	if(!IsPlayerConnected(playerid))
		return flying[playerid] = false;

	if(flying[playerid])
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
			new
			    keys,
				ud,
				lr,
				Float:x[2],
				Float:y[2],
				Float:z;
            UstawHP(playerid,1000000000);
			GetPlayerKeys(playerid, keys, ud, lr);
			GetPlayerVelocity(playerid, x[0], y[0], z);
			if(ud == KEY_UP)
			{
				GetPlayerCameraPos(playerid, x[0], y[0], z);
				GetPlayerCameraFrontVector(playerid, x[1], y[1], z);
    			ApplyAnimation(playerid, "SWIM", "SWIM_crawl", 4.1, 0, 1, 1, 0, 0);
				SetPlayerToFacePos(playerid, x[0] + x[1], y[0] + y[1]);
				SetPlayerVelocity(playerid, x[1], y[1], z);
			}
			else
			SetPlayerVelocity(playerid, 0.0, 0.0, 0.02);
		}
		SetTimerEx("AdminFly", 100, 0, "d", playerid);
	}
	return 0;
}
forward Float:SetPlayerToFacePos(playerid, Float:X, Float:Y);
public Float:SetPlayerToFacePos(playerid, Float:X, Float:Y)
{
	new
		Float:pX1,
		Float:pY1,
		Float:pZ1,
		Float:ang;

	if(!IsPlayerConnected(playerid)) return 0.0;

	GetPlayerPos(playerid, pX1, pY1, pZ1);

	if( Y > pY1 ) ang = (-acos((X - pX1) / floatsqroot((X - pX1)*(X - pX1) + (Y - pY1)*(Y - pY1))) - 90.0);
	else if( Y < pY1 && X < pX1 ) ang = (acos((X - pX1) / floatsqroot((X - pX1)*(X - pX1) + (Y - pY1)*(Y - pY1))) - 450.0);
	else if( Y < pY1 ) ang = (acos((X - pX1) / floatsqroot((X - pX1)*(X - pX1) + (Y - pY1)*(Y - pY1))) - 90.0);

	if(X > pX1) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	ang += 180.0;

	SetPlayerFacingAngle(playerid, ang);

 	return ang;
}
forward DodajPracownika(uidp, uidd, uidr, skin, powod[]);
public DodajPracownika(uidp, uidd, uidr, skin, powod[])
{
	uidr = 0;
	skin = -1;
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_pracownicy` (`UID_POSTACI`, `UID_DZIALALNOSCI`, `UID_RANGI`, `SKIN`, `UPRAWNIENIA`) VALUES ('%d', '%d', '%d', '%d', '%s')",
	uidp, uidd, uidr, skin, powod);
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();
	return 1;
}
stock kolorchatu(playerid, uid, nr)
{
	if(nr == 1)
	{
		format(zapyt, sizeof(zapyt), "SELECT `KOLOR_CZATU`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID`='%d' LIMIT 1", uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_store_result();
		mysql_fetch_row_format(zapyt);
		sscanf(zapyt,  "p<|>s[20]s[20]", DaneGracza[playerid][gKolorChatu1], DaneGracza[playerid][gKolorNicku1]);
	}
	else if(nr == 2)
	{
		format(zapyt, sizeof(zapyt), "SELECT `KOLOR_CZATU`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID`='%d' LIMIT 1", uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_store_result();
		mysql_fetch_row_format(zapyt);
		sscanf(zapyt,  "p<|>s[20]s[20]", DaneGracza[playerid][gKolorChatu2], DaneGracza[playerid][gKolorNicku2]);
	}
	else if(nr == 3)
	{
		format(zapyt, sizeof(zapyt), "SELECT `KOLOR_CZATU`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID`='%d' LIMIT 1", uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_store_result();
		mysql_fetch_row_format(zapyt);
		sscanf(zapyt,  "p<|>s[20]s[20]", DaneGracza[playerid][gKolorChatu3], DaneGracza[playerid][gKolorNicku3]);
	}
	else if(nr == 4)
	{
		format(zapyt, sizeof(zapyt), "SELECT `KOLOR_CZATU`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID`='%d' LIMIT 1", uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_store_result();
		mysql_fetch_row_format(zapyt);
		sscanf(zapyt,  "p<|>s[20]s[20]", DaneGracza[playerid][gKolorChatu4], DaneGracza[playerid][gKolorNicku4]);
	}
	else if(nr == 5)
	{
		format(zapyt, sizeof(zapyt), "SELECT `KOLOR_CZATU`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID`='%d' LIMIT 1", uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_store_result();
		mysql_fetch_row_format(zapyt);
		sscanf(zapyt,  "p<|>s[20]s[20]", DaneGracza[playerid][gKolorChatu5], DaneGracza[playerid][gKolorNicku5]);
	}
	else if(nr == 6)
	{
		format(zapyt, sizeof(zapyt), "SELECT `KOLOR_CZATU`, `KOLOR_NICKU` FROM `five_dzialalnosci` WHERE `ID`='%d' LIMIT 1", uid);
		mysql_check();
		mysql_query2(zapyt);
		mysql_store_result();
		mysql_fetch_row_format(zapyt);
		sscanf(zapyt,  "p<|>s[20]s[20]", DaneGracza[playerid][gKolorChatu6], DaneGracza[playerid][gKolorNicku6]);
	}
}
HexToInt(text[])
{
   if (text[0]==0) return 0;
   new i;
   new cur=1;
   new res=0;
   for (i=strlen(text);i>0;i--)
   {
     if(text[i-1]<58)
	 {
	 	res=res+cur*(text[i-1]-48);
	 }
	 else
	 {
	 	res=res+cur*(text[i-1]-65+10);
	 }
     cur=cur*16;
   }
   return res;
}
forward AFKT();
public AFKT()
{
	static
  Float:OldPosX[MAX_PLAYERS],
  Float:OldPosY[MAX_PLAYERS],
  Float:OldPosZ[MAX_PLAYERS];
	for (new playerid = 0; playerid < IloscGraczy; playerid++)
	{
		if (!IsPlayerConnected(KtoJestOnline[playerid])) continue;
		new
			Float:NewPosX,
			Float:NewPosY,
			Float:NewPosZ;
		GetPlayerPos(KtoJestOnline[playerid], NewPosX, NewPosY, NewPosZ);
		if(NewPosX == OldPosX[KtoJestOnline[playerid]] && NewPosY == OldPosY[KtoJestOnline[playerid]] && NewPosZ == OldPosZ[KtoJestOnline[playerid]])
		{
		    if(AFK[KtoJestOnline[playerid]] == 0)
		    {
				AFK[KtoJestOnline[playerid]] = 1;
				RefreshNick(KtoJestOnline[playerid]);
			}
		}
		else
		{
			GraczWrocilZAFK(KtoJestOnline[playerid]);
		}
		OldPosX[KtoJestOnline[playerid]] = NewPosX;
		OldPosY[KtoJestOnline[playerid]] = NewPosY;
		OldPosZ[KtoJestOnline[playerid]] = NewPosZ;
	}
	return 1;
}
stock GraczWrocilZAFK(playerid)
{
    AFK[playerid] = 0;
	RefreshNick(playerid);
}
forward WlaczKary(playerid);
public WlaczKary(playerid)
{
	WlaczNadajKare[playerid] = 0;
	return 1;
}
forward KickujGracza(playerid);
public KickujGracza(playerid)
{
	Kick(playerid);
	return 1;
}
forward SprawdzWlacznik(playerid, uid_budynku, znacznik);
public SprawdzWlacznik(playerid, uid_budynku, znacznik)
{
	new find = 0;
	ForeachEx(h, NieruchomoscInfo[uid_budynku][nStworzoneObiekty])
	{
		if(ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objWlacznik] == znacznik && uid_budynku == ObiektInfo[NieruchomoscInfo[uid_budynku][nObiekty][h]][objvWorld])
		{
			find = NieruchomoscInfo[uid_budynku][nObiekty][h];
			break;
		}
	}
	if(find != 0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

forward Air(playerid);
public Air(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(AB[playerid] == 1 && GetPlayerVirtualWorld(playerid) == 0)
	{
		if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerState(playerid) != PLAYER_STATE_SPAWNED&& zalogowany[playerid] == true && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && Rolki[playerid] == 0)
		{
			if((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > 35 || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > 35 ||
			(floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > 35 || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > 35 ||
			(floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > (35*3) || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > (35*3))
			{
				if(DaneGracza[playerid][gAJ] == 0)
				{
					NadajKare(playerid,-1, 0, "Anty Cheat System (AirBrake)", -1);
				}
			}
			else if((floatabs(pos[0] - GetPVarFloat(playerid, "OldPosX"))) > 15 || (floatabs(GetPVarFloat(playerid, "OldPosX") - pos[0])) > 15 ||
			(floatabs(pos[1] - GetPVarFloat(playerid, "OldPosY"))) > 15 || (floatabs(GetPVarFloat(playerid, "OldPosY") - pos[1])) > 15 ||
			(floatabs(pos[2] - GetPVarFloat(playerid, "OldPosZ"))) > (15*3) || (floatabs(GetPVarFloat(playerid, "OldPosZ") - pos[2])) > (15*3))
			{
				if(DaneGracza[playerid][gAJ] == 0)
				{
					OstrzezeniaAir[playerid] +=1;
					new bh[124];
					format(bh, sizeof(bh), " {b00000}[OSTRZE¯ENIE]{DEDEDE} Wykonujesz BH, jakie nie jest dozwolone na naszym serwerze! System nadaje ci %d ostrze¿enie!",OstrzezeniaAir[playerid]);
					SendClientMessage(playerid, SZARY, bh);
					if(OstrzezeniaAir[playerid] >= 3)
					{
						NadajKare(playerid,-1, 0, "Brak reakcji na ostrze¿enia o wykonywaniu BH", -1);
					}
				}
			}
		}
	}
	SetPVarFloat(playerid, "OldPosX", pos[0]);
	SetPVarFloat(playerid, "OldPosY", pos[1]);
	SetPVarFloat(playerid, "OldPosZ", pos[2]);
	return 1;
}
CMD:praca( playerid, params[ ] )
{
	//printf("U¿yta komenda praca");
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	for(new i = 0; i < sizeof(NieruchomoscInfo); i++)
	{
		if(Dystans(1.0, playerid, NieruchomoscInfo[i][nX], NieruchomoscInfo[i][nY], NieruchomoscInfo[i][nZ]) && GetPlayerVirtualWorld(playerid) == NieruchomoscInfo[i][nVW])
		{
			if(NieruchomoscInfo[i][nTyp] == 11)
		   	{
				dShowPlayerDialog(playerid, DIALOG_PRACA, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}»  {88b711}Wêdkarz\n{DEDEDE}»  {88b711}Pracownik Stacji\n{DEDEDE}»  {88b711}Sprz¹tacz Ulic\n{DEDEDE}»  {88b711}Kurier", "Wybierz", "Zamknij");
	    		break;
		   	}
		}
	}
	return 1;
}
stock Frezuj(playerid, frezz)
{
	TogglePlayerControllable(playerid, frezz);
	if(frezz == 1)
	{
		Frezowany[playerid] = 0;
	}
	else
	{
		Frezowany[playerid] = 1;
	}
}
stock Teleportuj(playerid, Float:x, Float:y, Float:z)
{
	KillTimer(ABTimer[playerid]);
	AB[playerid] = 0;
	SetPVarInt(playerid, "Teleportacja", 1);
	SetPlayerPos(playerid, x, y, z);
	SetPVarInt(playerid, "Teleportacja", 0);
	ABTimer[playerid] = SetTimerEx("ABTimerer",5000, 0, "d", playerid);
	return 1;
}
forward ABTimerer(playerid);
public ABTimerer(playerid)
{
	AB[playerid] = 1;
    return 1;
}
forward Teleport2(playerid);
public Teleport2(playerid)
{
	new Float:xx, Float:yy, Float:zz;
	GetPlayerPos(playerid, xx, yy, zz);
	SetPVarFloat(playerid, "OldPosX", xx);
	SetPVarFloat(playerid, "OldPosY", yy);
	SetPVarFloat(playerid, "OldPosZ", zz);
    return 1;
}
forward WylaczSwiatlo(uids, playerid);
public WylaczSwiatlo(uids, playerid)
{
	NieruchomoscInfo[uids][nSwiatlo] = 1;
	foreach(Player, i)
	{
		if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
		TextDrawShowForPlayer(i, Light);
	}
	ZapiszNieruchomosc(uids);
	return 1;
}
forward WlaczSwiatlo(uids, playerid);
public WlaczSwiatlo(uids, playerid)
{
    if(NieruchomoscInfo[uids][nMapa] == 1)
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}W³aœciciel budynku w³aœnie wgrywa {88b711}mape obiektów{DEDEDE} do budynku.\nTa opcja jest {88b711}niedostêpna{DEDEDE} do czasu zakoñczenia tej operacji.", "Zamknij", "");
		return 0;
	}
	if(NieruchomoscInfo[uids][nSwiatlo] == 1)
	{
		NieruchomoscInfo[uids][nSwiatlo] = 0;
		foreach(Player, i)
		{
		    if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
			TextDrawHideForPlayer(i, Light);
		}
	}
	else
	{
	    NieruchomoscInfo[uids][nSwiatlo] = 1;
		foreach(Player, i)
		{
			if(NieruchomoscInfo[uids][nVWW] == GetPlayerVirtualWorld(i))
			TextDrawShowForPlayer(i, Light);
		}
	}
    ZapiszNieruchomosc(uids);
	return 1;
}
stock sekundytodata(unix_timestamp = 0, &year = 1970, &mies = 1, &day = 1, &hour = 0, &minute = 0, &second = 0)
{
	year = unix_timestamp / 31557600;
	unix_timestamp -= year * 31557600;
	year += 1970;

	if ( year % 4 == 0 ) unix_timestamp -= 21600;

	day = unix_timestamp / 86400;

	switch ( day )
	{
		case    0..30 : { second = day;       mies =  1; }
		case   31..58 : { second = day -  31; mies =  2; }
		case   59..89 : { second = day -  59; mies =  3; }
		case  90..119 : { second = day -  90; mies =  4; }
		case 120..150 : { second = day - 120; mies =  5; }
		case 151..180 : { second = day - 151; mies =  6; }
		case 181..211 : { second = day - 181; mies =  7; }
		case 212..242 : { second = day - 212; mies =  8; }
		case 243..272 : { second = day - 243; mies =  9; }
		case 273..303 : { second = day - 273; mies = 10; }
		case 304..333 : { second = day - 304; mies = 11; }
		case 334..366 : { second = day - 334; mies = 12; }
	}

	unix_timestamp -= day * 86400;
	hour = unix_timestamp / 3600;

	unix_timestamp -= hour * 3600;
	minute = unix_timestamp / 60;

	unix_timestamp -= minute * 60;
	day = second + 1;
	second = unix_timestamp;
}
forward GraczaMaTypPrzedmiotu(playerid, typ);
public GraczaMaTypPrzedmiotu(playerid, typ)
{
	new is = 0;
	ForeachEx(i, MAX_PRZEDMIOT)
	{
	    if(PrzedmiotInfo[i][pTyp] == typ && PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL)
	    {
	        is = i;
			break;
	    }
	}
	return is;
}
forward GraczaMaTypPrzedmiotuWu(playerid, typ, war);
public GraczaMaTypPrzedmiotuWu(playerid, typ, war)
{
	new is = 0;
	ForeachEx(i, MAX_PRZEDMIOT)
	{
	    if(PrzedmiotInfo[i][pTyp] == typ && PrzedmiotInfo[i][pOwner] == DaneGracza[playerid][gUID] && PrzedmiotInfo[i][pTypWlas] == TYP_WLASCICIEL && PrzedmiotInfo[i][pWar1] == war && PrzedmiotInfo[i][pUzywany] != 0)
	    {
	        is = i;
			break;
	    }
	}
	return is;
}
CMD:gps(playerid, cmdtext[])
{
	//printf("U¿yta komenda gps");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		return 1;
	}
	if(!UprawnienieNaSluzbie(playerid, 42))
	{
		return 1;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		return 1;
	}
	if(GPS[playerid] == 0)
	{
		GPS[playerid] = 1;
		cmd_fasdasfdfive(playerid, "aktywuje namierzanie GPS.");
	}
	else
	{
		GPS[playerid] = 0;
		ForeachEx(ilosc, 99)
		{
			RemovePlayerMapIcon( playerid, ilosc );
		}
		cmd_fasdasfdfive(playerid, "dezaktywuje namierzanie GPS.");
	}
	return 1;
}
CMD:atag( playerid, params[ ] ) cmd_amt(playerid, "0 100 Mistral 74 0 0xFF88b711 0 1 (220022)Five*(000000)Boxton*Crips");
CMD:kask(playerid, cmdtext[])
{
	//printf("U¿yta komenda kask");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		return 1;
	}
	if(!Jednoslady(GetPlayerVehicleID(playerid)))
	{
		return 0;
	}
	if(PASY[playerid] == 0)
	{
		PASY[playerid] = 1;
		GameTextForPlayer(playerid, "~g~Kask: ~w~zalozony", 3000, 6);
	}
	else
	{
		PASY[playerid] = 0;
		GameTextForPlayer(playerid, "~r~Kask: ~w~sciagniety", 3000, 6);
	}
	RefreshNick(playerid);
	return 1;
}
CMD:pasy(playerid, cmdtext[])
{
	//printf("U¿yta komenda pasy");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		return 1;
	}
	if(Jednoslady(GetPlayerVehicleID(playerid)))
	{
		return 0;
	}
	if(PASY[playerid] == 0)
	{
		PASY[playerid] = 1;
		GameTextForPlayer(playerid, "~g~Pasy: ~w~zapiete", 3000, 6);
	}
	else
	{
		PASY[playerid] = 0;
		GameTextForPlayer(playerid, "~r~Pasy: ~w~odpiete", 3000, 6);
	}
	RefreshNick(playerid);
	return 1;
}
CMD:holuj(playerid, cmdtext[])
{
	//printf("U¿yta komenda holuj");
	if(!MaUprawnieie(playerid, 41))
	{
		return 1;
	}
	new v=GetPlayerVehicleID(playerid);
	if(GetVehicleModel(v)==525)
    {
		new Float:Xs,Float:Ys,Float:Zs;
		GetPlayerPos(playerid,Xs,Ys,Zs);
		new Float:vaX,Float:vaY,Float:vaZ;
		new bool:Found=false;
		new vid=0;
		while((vid<MAX_VEH)&&(!Found))
		{
			vid++;
			GetVehiclePos(vid,vaX,vaY,vaZ);
			if ((floatabs(Xs-vaX)<7.0)&&(floatabs(Ys-vaY)<7.0)&&(floatabs(Zs-vaZ)<7.0)&&(vid!=v))
		    {
			    Found=true;
				if(IsTrailerAttachedToVehicle(v))
				{
					DetachTrailerFromVehicle(v);
			  	}
	 		    AttachTrailerToVehicle(vid,v);
				new id_p = SprawdzCarUID(vid);
				PojazdInfo[id_p][pHolowany] = v;
		    }
	    }
    }
	return 1;
}
CMD:budka(playerid, cmdtext[])
{
	//printf("U¿yta komenda budka");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	if(GetPlayerVirtualWorld(playerid) != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new uid_obiektu = PrzyObiekcie(playerid, 1216, 2);
	if(uid_obiektu == 0)
	{
		return 0;
	}
	if(ObiektInfo[uid_obiektu][objPoker][0] == 1)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Budka przy której {88b711}stoisz{DEDEDE} obecnie jest {88b711}u¿ywana{DEDEDE} przez innego gracza.", "Zamknij", "");
		return 0;
	}
	UzywaBudkiUID[playerid] = uid_obiektu;
	ObiektInfo[uid_obiektu][objPoker][0] = 1;
	strdel(tekst_global, 0, 2048);
	format(tekst_global, sizeof(tekst_global), "{DEDEDE}Opcje budki telefonicznej:\n\t{DEDEDE}»  {88B711}Pomoc, s³u¿by porz¹dkowe{88B711}\n\t{DEDEDE}»  {88B711}Taxi, restauracje i inne{88B711}\n\n{DEDEDE}Za wysy³anie wiadomoœci z budki\ntelefonicznej naliczane sa oplaty w wysokosci {88b711}2{dedede}$");
	dShowPlayerDialog(playerid, DIALOG_BUDKA, DIALOG_STYLE_LIST, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Budka telefoniczna{88b711}:", tekst_global, "Wybierz", "Zamknij");
	return 1;
}
/*
CMD:awaryjne(playerid,params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
				//----------------------Œwiat³a Awaryjne
		for(new i = 0; i < MAX_KIEUNKI; i++)
		{
			if(KierunekInfo[i][VID] == GetVehicleModel(vehicleid))//Porównanie Modelu pojazdu z modelem w tablicy
			{
				if(KierunekPrawyOn[vehicleid] == true || KierunekLewyOn[vehicleid] == true) return 0;
			    if(KierunkiAwaryjneIn[vehicleid] == false)
			    {
					KierunkiAwaryjneIn[vehicleid] = true;
				    //Kierunkowskaz Prawy Przedni
					KierunekObiekt[vehicleid][0] = CreateObject( 19294,0,0,0,0,0,0,80 );
				    AttachObjectToVehicle(KierunekObiekt[vehicleid][0], vehicleid, KierunekInfo[i][PXPP], KierunekInfo[i][PYPP], KierunekInfo[i][PZPP], 0, 0, 0);
					//Kierunkowskaz Prawy Tylny
					KierunekObiekt[vehicleid][1] = CreateObject( 19294,0,0,0,0,0,0,80 );
				    AttachObjectToVehicle(KierunekObiekt[vehicleid][1], vehicleid, KierunekInfo[i][PXPT], KierunekInfo[i][PYPT], KierunekInfo[i][PZPT], 0, 0, 0);
				    //Kierunkowskaz Lewy Przedni
					KierunekObiekt[vehicleid][2] = CreateObject( 19294,0,0,0,0,0,0,80 );
				    AttachObjectToVehicle(KierunekObiekt[vehicleid][2], vehicleid, KierunekInfo[i][PXLP], KierunekInfo[i][PYLP], KierunekInfo[i][PZLP], 0, 0, 0);
					//Kierunkowskaz Lewy Tylny
					KierunekObiekt[vehicleid][3] = CreateObject( 19294,0,0,0,0,0,0,80 );
				    AttachObjectToVehicle(KierunekObiekt[vehicleid][3], vehicleid, KierunekInfo[i][PXLT], KierunekInfo[i][PYLT], KierunekInfo[i][PZLT], 0, 0, 0);
				}else
				{
				    KierunkiAwaryjneIn[vehicleid] = false;
				    DestroyObject(KierunekObiekt[vehicleid][0]);
				    DestroyObject(KierunekObiekt[vehicleid][1]);
				    DestroyObject(KierunekObiekt[vehicleid][2]);
				    DestroyObject(KierunekObiekt[vehicleid][3]);
				}
				break;
			}
		}
	}
	return 1;
}*/
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(taxijedz[playerid]==1)
	{
		strdel(tekst_global, 0, 2048);
		new id = GetPVarInt(playerid, "przejazt");
		format(tekst_global, sizeof(tekst_global), "** %s zaznacza nowe miejsce na GPS.", ZmianaNicku(playerid));
		SendClientMessage(id, FIOLETOWY, tekst_global);
		format(tekst_global, sizeof(tekst_global), "** %s zaznacza nowe miejsce na GPS.", ZmianaNicku(playerid));
		SendClientMessage(playerid, FIOLETOWY, tekst_global);
    	SetPlayerCheckpoint(id, fX, fY, fZ, 5.0);
        return 1;
	}
    return 1;
}
stock GetNearestVehicle(playerid, Float:Distance = 1000.0)
{
Distance = floatabs(Distance);
if(Distance == 0.0) Distance = 1000.0;
new Float:X[2], Float:Y[2], Float:Z[2];
new Float:NearestPos = Distance;
new NearestVehicle = INVALID_VEHICLE_ID;
GetPlayerPos(playerid, X[0], Y[0], Z[0]);
for(new i; i<MAX_VEHICLES; i++)
{
if(!IsVehicleStreamedIn(i, playerid) || i == GetPlayerVehicleID(playerid)) continue;
GetVehiclePos(i, X[1], Y[1], Z[1]);
if(NearestPos > GetDistanceBetweenPoints(X[0], Y[0], Z[0], X[1], Y[1], Z[1])) NearestPos = GetDistanceBetweenPoints(X[0], Y[0], Z[0], X[1], Y[1], Z[1]), NearestVehicle = i;
}
if(NearestPos < Distance) return NearestVehicle;
return INVALID_VEHICLE_ID;
}
CMD:silownia(playerid, params[])
{
	if(silka[playerid] != 0)
	{
	   	sek[playerid]=0;
		podnoszenie[playerid]=0;
		new name_door[256];
		CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
		format(name_door, sizeof(name_door), "~w~Anulowales trening silowy.");
		TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
		TextDrawSetString(TextNaDrzwi[playerid], name_door);
		TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
		karnet[playerid] = 0;
		ObiektInfo[silka[playerid]][gZajety] = 0;
		silka[playerid]=0;
		RemovePlayerAttachedObject(playerid, 5);
		wyciskanie[playerid]=0;
		ApplyAnimation(playerid,"benchpress","gym_bp_getoff",4.1,0,0,0,0,0);
		ApplyAnimation(playerid,"benchpress","gym_bp_getoff",4.1,0,0,0,0,0);
		return 0;
	}
	new id_laweczki = PrzyObiekcie(playerid, 2629, 4);
	if(id_laweczki != 0)
	{
	    if(ObiektInfo[id_laweczki][objRotZ] == 0)
	    {
	        if(ObiektInfo[id_laweczki][gZajety] == 0)
	        {
	            //if(karnet[playerid] == 1)
				//{
					if(silka[playerid] ==0)
				    {
				        new Float:oldposx,Float:oldposy,Float:oldposz;
				        SetPlayerAttachedObject(playerid,5,2913,6,0.000000,0.000000,-0.100000,0.0000000,0.000000,0.000000);
				        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
						Teleportuj(playerid, ObiektInfo[id_laweczki][objPozX],ObiektInfo[id_laweczki][objPozY]-1,oldposz);
				        SetPlayerFacingAngle(playerid, ObiektInfo[id_laweczki][objRotZ]);
					    silka[playerid] = id_laweczki;
					    ObiektInfo[id_laweczki][gZajety] = 1;
					    SetPVarInt( playerid, "zajobj", id_laweczki );
				    	ApplyAnimation(playerid,"benchpress","gym_bp_geton",4.1,0,0,0,1,0);
						ApplyAnimation(playerid,"benchpress","gym_bp_geton",4.1,0,0,0,1,0);
						new name_door[256];
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
						if(karnet[playerid] == 1)
						{
							format(name_door, sizeof(name_door), "~y~~h~Wyciskanie: %d~n~~w~aby zwiekszyc swoja sile musisz uniesc sztange 50 razy, sztange podnosi sie klawiszem ~k~~PED_SPRINT~",wyciskanie[playerid]);
						}
						else
						{
							format(name_door, sizeof(name_door), "~y~~h~Wyciskanie: %d~n~~w~twoja sila nie zostanie zwiekszona poniewaz nie masz wykupionego karnetu, sztange podnosi sie klawiszem ~k~~PED_SPRINT~",wyciskanie[playerid]);
						}
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], name_door);
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
					}
					else
					{
					   	silka[playerid]=0;
					   	sek[playerid]=0;
						podnoszenie[playerid]=0;
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 0;
						karnet[playerid] = 0;
						ObiektInfo[id_laweczki][gZajety] = 0;
						RemovePlayerAttachedObject(playerid, 5);
						wyciskanie[playerid]=0;
						ApplyAnimation(playerid,"benchpress","gym_bp_getoff",4.1,0,0,0,0,0);
						ApplyAnimation(playerid,"benchpress","gym_bp_getoff",4.1,0,0,0,0,0);
					}

				//}else{
				//	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby æwiczyæ musisz posiadaæ {88b711}karnet{DEDEDE} si³owy który mo¿esz nabyæ u sprzedawcy.", "Zamknij", "");
				//}
			}else{
			    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta ³aweczka treningowa jest {88b711}zajêta{DEDEDE} znajdz sobie inn¹.", "Zamknij", "");
			}
		}else{
		    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Ta ³aweczka ma Ÿle ustawion¹ {88b711}rotacje{DEDEDE}. Rotacja Z powinna wynosiæ 0.0.", "Zamknij", "");
		}
	}else{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteœ zbyt daleko od {88b711}modelu{DEDEDE} ³awczki treningowej (obiekt id: {88b711}2629{DEDEDE}).", "Zamknij", "");
	}
    return 1;
}
forward cwiczenie(playerid);
public cwiczenie(playerid)
{
    if(silka[playerid]!=0)
	{
		if(podnoszenie[playerid]== 1)
		{
		    sek[playerid]++;
        	testzabez[playerid] = SetTimerEx("cwiczenie", 800, 0, "i", playerid);
		    if(sek[playerid] == 3)
		    {
		        GameTextForPlayer(playerid,"~y~~h~Silownia:~n~~w~teraz opusc sztange w dol.",2000,3);
   		     	sek[playerid]=0;
   		     	wyciskanie[playerid]++;
   		     	KillTimer(testzabez[playerid]);
			}
			new name_door[256];
			CzasWyswietlaniaTextuNaDrzwiach[playerid] = 60;
			if(karnet[playerid] == 1)
			{
				format(name_door, sizeof(name_door), "~y~~h~Wyciskanie: %d~n~~w~aby zwiekszyc swoja sile musisz uniesc sztange 50 razy, sztange podnosi sie klawiszem ~k~~PED_SPRINT~",wyciskanie[playerid]);
			}
			else
			{
				format(name_door, sizeof(name_door), "~y~~h~Wyciskanie: %d~n~~w~twoja sila nie zostanie zwiekszona poniewaz nie masz wykupionego karnetu, sztange podnosi sie klawiszem ~k~~PED_SPRINT~",wyciskanie[playerid]);
			}
			TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
			TextDrawSetString(TextNaDrzwi[playerid], name_door);
			TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
			if(wyciskanie[playerid]== 50 && karnet[playerid] == 1)
			{
				if(Amfeta[playerid] > gettime() || Hera[playerid] > gettime())
				{
					if(Hera[playerid] > gettime())
					{
						DaneGracza[playerid][gSILA] += 10;
						Hera[playerid] = 0;
					}
					else
					{
						DaneGracza[playerid][gSILA] += 8;
						Amfeta[playerid] = 0;
					}
				}
				else
				{
					DaneGracza[playerid][gSILA] += 5;
				}
				if(DaneGracza[playerid][gSILA] >= 3100)
				{
					if(!Osiagniecia(playerid, OSIAGNIECIE_SPORTOWIEC))
					{
						CzasWyswietlaniaTextuNaDrzwiach[playerid] = 30;
						TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
						TextDrawSetString(TextNaDrzwi[playerid], "~y~OSIAGNIECIE~n~~w~Silacz (3100j) ~g~+200GS");
						TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
						DaneGracza[playerid][gOsiagniecia][OSIAGNIECIE_SPORTOWIEC] = 1;
						DaneGracza[playerid][gGAMESCORE] += 200;
						SetPlayerScore(playerid,DaneGracza[playerid][gGAMESCORE]);
						ZapiszGraczaGlobal(playerid, 1);
					}
				}
			    CzasWyswietlaniaTextuNaDrzwiach[playerid] = 0;
			    silka[playerid]=0;
			   	sek[playerid]=0;
				podnoszenie[playerid]=0;
				karnet[playerid] = 0;
				new find = GetPVarInt(playerid, "zajobj");
				ObiektInfo[find][gZajety] = 0;
				RemovePlayerAttachedObject(playerid, 5);
				wyciskanie[playerid]=0;
				ApplyAnimation(playerid,"benchpress","gym_bp_getoff",4.1,0,0,0,0,0);
				CzasWyswietlaniaTextuNaDrzwiach[playerid] = 15;
				TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
				TextDrawSetString(TextNaDrzwi[playerid], "Zwiekszyles swoja sile.");
				TextDrawShowForPlayer(playerid, TextNaDrzwi[playerid]);
			}
		}
		else if(podnoszenie[playerid]==0&&sek[playerid]>0&&sek[playerid]<3)
		{
            GameTextForPlayer(playerid,"~y~~h~Silownia:~n~~w~za wczesnie pusciles klawisz.",2000,3);
            sek[playerid]= 0;
		}
    }
	return 1;
}
CMD:craft(playerid, params[])
{
	//printf("U¿yta komenda craft");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new find = PrzyObiekcie(playerid, 2419, 5);
	if(find != 0)
	{
		Przedmioty(playerid, playerid, DIALOG_CRAFT, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Przedmioty na stole{88b711}:", TYP_CRAFT, find);
		SetPVarInt( playerid, "UIDCRAFT", find);
	}
	else
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteœ zbyt daleko od {88b711}modelu{DEDEDE} sto³u do craftingu (obiekt id: {88b711}2419{DEDEDE}).", "Zamknij", "");
	}
    return 1;
}
CMD:gril(playerid, params[])
{
	//printf("U¿yta komenda gril");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	new find = PrzyObiekcie(playerid, 1481, 5);
	if(find != 0)
	{
		Przedmioty(playerid, playerid, DIALOG_GRIL, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Przedmioty na grilu{88b711}:", TYP_GRIL, find);
		SetPVarInt( playerid, "UIDGRIL", find);
	}
	else
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Jesteœ zbyt daleko od {88b711}modelu{DEDEDE} grila (obiekt id: {88b711}1481{DEDEDE}).", "Zamknij", "");
	}
    return 1;
}
CMD:anims(playerid,cmdtext[])
{
	//printf("U¿yta komenda anims");
	if(zalogowany[playerid] == false)
	{
		return 0;
	}
	/*if(DaneGracza[playerid][gAdmGroup] != 4)
	{
		return 0;
	}*/
	new strs[64],strss[64];
	if(sscanf(cmdtext, "s[50]s[50]", strs,strss))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "{88b711}» {FFFFFF}"VER" {88b711}» {FFFFFF}Informacja{88b711}:", "{DEDEDE}Aby u¿yæ komendy tworzenia animacji wpisz: {88b711}/anims [x] [y]{DEDEDE}nastêpnie wpisz parametry.", "Zamknij", "");
		return 1;
	}
	ApplyAnimation(playerid,strs,strss,4.1,0,0,0,1,0);
	return 1;
}
public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid,Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
    SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
	if(index == 7)
	{
		if(DaneGracza[playerid][gPrzyczepiony1] == 7)
		{
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt),"UPDATE `five_dodadtki` SET `modelid` = '%d', `boneid` = '%d', `fOffsetX`='%f', `fOffsetY`='%f', `fOffsetZ`='%f', `fRotX`='%f', `fRotY`='%f', `fRotZ`='%f', `fScaleX`='%f', `fScaleY`='%f', `fScaleZ`='%f' WHERE `UID`='%d' AND `index` = '%d'",
			modelid, boneid,fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX, fScaleY, fScaleZ,	DaneGracza[playerid][gUID], index);
			mysql_query(zapyt);
		}
		else 
		{
			DaneGracza[playerid][gPrzyczepiony1] = 7;
			strdel(zapyt, 0, 1024);
			format(zapyt, sizeof(zapyt), "INSERT INTO `five_dodadtki` (`UID`, `index`, `modelid`, `boneid`, `fOffsetX`, `fOffsetY`, `fOffsetZ`, `fRotX`, `fRotY`, `fRotZ`, `fScaleX`, `fScaleY`, `fScaleZ`) VALUES ('%d', '%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f')",
			DaneGracza[playerid][gUID],index,modelid, boneid,fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX, fScaleY, fScaleZ);
			mysql_query2(zapyt);
		}
	}
	if(index == 8)
	{
		if(DaneGracza[playerid][gPrzyczepiony2] == 8)
		{
			format(zapyt, sizeof(zapyt),"UPDATE `five_dodadtki` SET `modelid`='%d', `boneid`='%d', `fOffsetX`='%f', `fOffsetY`='%f', `fOffsetZ`='%f', `fRotX`='%f', `fRotY`='%f', `fRotZ`='%f', `fScaleX`='%f', `fScaleY`='%f', `fScaleZ`='%f' WHERE `UID`='%d' AND `index`='%d'",
			modelid, boneid,fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX, fScaleY, fScaleZ,	DaneGracza[playerid][gUID], index);
			mysql_query(zapyt);
		}
		else 
		{
			DaneGracza[playerid][gPrzyczepiony2] = 8;
			format(zapyt, sizeof(zapyt), "INSERT INTO `five_dodadtki` (`UID`, `index`, `modelid`, `boneid`, `fOffsetX`, `fOffsetY`, `fOffsetZ`, `fRotX`, `fRotY`, `fRotZ`, `fScaleX`, `fScaleY`, `fScaleZ`) VALUES ('%d', '%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f')",
			DaneGracza[playerid][gUID],index,modelid, boneid,fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX, fScaleY, fScaleZ);
			mysql_query2(zapyt);
		}
	}
	//DaneGracza[playerid][gPrzyczepiony][2];
    return 1;
}
/*public OnPlayerCleoDetected( playerid, cleoid )
{
    switch( cleoid )
    {
        case CLEO_FAKEKILL:
        {
        	SendClientMessage(playerid, SZARY,"Fake Kill.");
        }
        case CLEO_CARWARP:
        {
        	SendClientMessage(playerid, SZARY,"Warpowanie pojazdow.");
        }
        case CLEO_CARSWING:
        {
        	SendClientMessage(playerid, SZARY,"Przewracanie pojazdow cheatem.");
        }
        case CLEO_CAR_PARTICLE_SPAM:
        {
            SendClientMessage(playerid, SZARY,"Car Spam.");
        }
    }
    return 1;
}*/
public OnPlayerCheat(playerid, cheatid)
{
    if(cheatid==1)
    {
		/*new text[124];
		strdel(text, 0, 124);
		format(text, sizeof(text), "CHEAT MONEY (%d)", GetPlayerMoney(playerid));
		NadajKare(playerid,-1, 2, text, 7);*/
    }
    else if(cheatid==2)
    {
		//new text[124];
		//strdel(text, 0, 124);
		//format(text, sizeof(text), "CHEAT WEAPON (%d)", GetPlayerWeapon(playerid));
		//NadajKare(playerid,-1, 2, text, 7);
    }
    else if(cheatid==3)
    {
		new text[124];
		strdel(text, 0, 124);
		format(text, sizeof(text), "CHEAT AMMO (%d)", GetPlayerWeapon(playerid));
		NadajKare(playerid,-1, 2, text, 7);
    }
    else if(cheatid==4)
    {
		new text[124];
		strdel(text, 0, 124);
		format(text, sizeof(text), "CHEAT BLOCK AMMO (%d)", GetPlayerWeapon(playerid));
		NadajKare(playerid,-1, 2, text, 7);
    }
    else if(cheatid==5)
    {
		new text[124];
		strdel(text, 0, 124);
		format(text, sizeof(text), "CHEAT SPEEDHACK (%d)", Predkosc(playerid));
		NadajKare(playerid,-1, 2, text, 7);
    }
    else if(cheatid==6)
    {
		//NadajKare(playerid,-1, 1, "(CHEAT AIBREAK/TELEPORT).", 0);
    }
    else if(cheatid==7)
    {
		//NadajKare(playerid,-1, 1, "(CHEAT HEALTH).", 0);
    }
    else if(cheatid==8)
    {
		//NadajKare(playerid,-1, 1, "(CHEAT ARMOUR).", 0);
    }
	/*else
	{
		NadajKare(playerid,-1, 1, "(CHEAT Vehicle Spawn).", 0);
	}*/
	return 1;
}
forward WywalzDZ(playerid, playeridz, dzialalnoscid);
public WywalzDZ(playerid, playeridz, dzialalnoscid)
{
    if(DaneGracza[playeridz][gDzialalnosc1] == dzialalnoscid)
    {
		strdel(tekst_globals, 0, 2048);
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Zosta³eœ wyproszony z dzia³alnoœci {88b711}%s{DEDEDE} przez {88b711}%s{DEDEDE}.", GrupaInfo[dzialalnoscid][gNazwa], ZmianaNicku(playerid));
        SendClientMessage(playeridz, SZARY, tekst_globals);
		format(zapyt, sizeof(zapyt), "DELETE FROM `five_pracownicy` WHERE `UID_POSTACI` = '%d' AND `UID_DZIALALNOSCI` = '%d'", DaneGracza[playeridz][gUID], dzialalnoscid);
		DaneGracza[playeridz][gDzialalnosc1] = 0;
		mysql_check();
		mysql_query2(zapyt);
		GameTextForPlayer(playerid, "~y~Wyprosiles gracza z dzialalnosci.", 3000, 5);
       	return 1;
	}
	else if(DaneGracza[playeridz][gDzialalnosc2] == dzialalnoscid)
    {
		strdel(tekst_globals, 0, 2048);
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Zosta³eœ wyproszony z dzia³alnoœci {88b711}%s{DEDEDE} przez {88b711}%s{DEDEDE}.", GrupaInfo[dzialalnoscid][gNazwa], ZmianaNicku(playerid));
        SendClientMessage(playeridz, SZARY, tekst_globals);
		format(zapyt, sizeof(zapyt), "DELETE FROM `five_pracownicy` WHERE `UID_POSTACI` = '%d' AND `UID_DZIALALNOSCI` = '%d'", DaneGracza[playeridz][gUID], dzialalnoscid);
		DaneGracza[playeridz][gDzialalnosc2] = 0;
		mysql_check();
		mysql_query2(zapyt);
		GameTextForPlayer(playerid, "~y~Wyprosiles gracza z dzialalnosci.", 3000, 5);
       	return 1;
	}
	else if(DaneGracza[playeridz][gDzialalnosc3] == dzialalnoscid)
    {
		strdel(tekst_globals, 0, 2048);
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Zosta³eœ wyproszony z dzia³alnoœci {88b711}%s{DEDEDE} przez {88b711}%s{DEDEDE}.", GrupaInfo[dzialalnoscid][gNazwa], ZmianaNicku(playerid));
        SendClientMessage(playeridz, SZARY, tekst_globals);
		format(zapyt, sizeof(zapyt), "DELETE FROM `five_pracownicy` WHERE `UID_POSTACI` = '%d' AND `UID_DZIALALNOSCI` = '%d'", DaneGracza[playeridz][gUID], dzialalnoscid);
		DaneGracza[playeridz][gDzialalnosc3] = 0;
		mysql_check();
		mysql_query2(zapyt);
		GameTextForPlayer(playerid, "~y~Wyprosiles gracza z dzialalnosci.", 3000, 5);
       	return 1;
	}
	else if(DaneGracza[playeridz][gDzialalnosc4] == dzialalnoscid)
    {
		strdel(tekst_globals, 0, 2048);
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Zosta³eœ wyproszony z dzia³alnoœci {88b711}%s{DEDEDE} przez {88b711}%s{DEDEDE}.", GrupaInfo[dzialalnoscid][gNazwa], ZmianaNicku(playerid));
        SendClientMessage(playeridz, SZARY, tekst_globals);
		format(zapyt, sizeof(zapyt), "DELETE FROM `five_pracownicy` WHERE `UID_POSTACI` = '%d' AND `UID_DZIALALNOSCI` = '%d'", DaneGracza[playeridz][gUID], dzialalnoscid);
		DaneGracza[playeridz][gDzialalnosc4] = 0;
		mysql_check();
		mysql_query2(zapyt);
		GameTextForPlayer(playerid, "~y~Wyprosiles gracza z dzialalnosci.", 3000, 5);
       	return 1;
	}
	else if(DaneGracza[playeridz][gDzialalnosc5] == dzialalnoscid)
    {
		strdel(tekst_globals, 0, 2048);
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Zosta³eœ wyproszony z dzia³alnoœci {88b711}%s{DEDEDE} przez {88b711}%s{DEDEDE}.", GrupaInfo[dzialalnoscid][gNazwa], ZmianaNicku(playerid));
        SendClientMessage(playeridz, SZARY, tekst_globals);
		format(zapyt, sizeof(zapyt), "DELETE FROM `five_pracownicy` WHERE `UID_POSTACI` = '%d' AND `UID_DZIALALNOSCI` = '%d'", DaneGracza[playeridz][gUID], dzialalnoscid);
		DaneGracza[playeridz][gDzialalnosc5] = 0;
		mysql_check();
		mysql_query2(zapyt);
		GameTextForPlayer(playerid, "~y~Wyprosiles gracza z dzialalnosci.", 3000, 5);
       	return 1;
	}
	else if(DaneGracza[playeridz][gDzialalnosc6] == dzialalnoscid)
    {
		strdel(tekst_globals, 0, 2048);
		format(tekst_globals, sizeof(tekst_globals), "{DEDEDE}Zosta³eœ wyproszony z dzia³alnoœci {88b711}%s{DEDEDE} przez {88b711}%s{DEDEDE}.", GrupaInfo[dzialalnoscid][gNazwa], ZmianaNicku(playerid));
        SendClientMessage(playeridz, SZARY, tekst_globals);
		format(zapyt, sizeof(zapyt), "DELETE FROM `five_pracownicy` WHERE `UID_POSTACI` = '%d' AND `UID_DZIALALNOSCI` = '%d'", DaneGracza[playeridz][gUID], dzialalnoscid);
		DaneGracza[playeridz][gDzialalnosc6] = 0;
		mysql_check();
		mysql_query2(zapyt);
		GameTextForPlayer(playerid, "~y~Wyprosiles gracza z dzialalnosci.", 3000, 5);
       	return 1;
	}
	return 1;
}