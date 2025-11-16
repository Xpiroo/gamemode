#include <a_samp>
#include <a_mysql>
#include <sscanf22>
#include <zcmd>
#include <md5>
//#include <streamer>
#include <audio>
#include <face>
#include <file>

#define VERSION_MAP "IC-GP v0.1"

#define SQL_HOST "localhost"
#define SQL_DB 	 "urp"
#define SQL_USER "root"
#define SQL_PASS "mateusz"

#define STREAMER_TYPE_OBJECT (0)
#define STREAMER_TYPE_PICKUP (1)
#define STREAMER_TYPE_CP (2)
#define STREAMER_TYPE_RACE_CP (3)
#define STREAMER_TYPE_MAP_ICON (4)
#define STREAMER_TYPE_3D_TEXT_LABEL (5)
#define STREAMER_TYPE_AREA (6)

#define _strlib_sma_string 128
#define _strlib_med_string 256
#define _strlib_big_string 512

//Kolory
#define BIALY 0xFFFFFFFF
#define CZARNY 0x000000FF
#define CZERWONY 0xFF0000FF
#define ZIELONY 0x42B542FF
#define SZARY 0xAFAFAFAA
#define KOLOR_DO      0x9A9CCDFF
#define FIOLETOWY     0xC2A2DAFF
#define COLOR_RADIO   0xfff16eAA

#define COLOR_GRAD1   0xB4B5B7FF
#define COLOR_GRAD2   0xBFC0C2FF
#define COLOR_GRAD3   0xCBCCCEFF
#define COLOR_GRAD4   0xD8D8D8FF
#define COLOR_GRAD5   0xE3E3E3FF
#define COLOR_GRAD6   0xF0F0F0FF

#define COLOR_FRAC	  0x5990ffFF
#define COLOR_BIZ	  0xfca637FF
#define COLOR_ORG	  0x308204FF
#define COLOR_YELLOW  0xf6f42fFF

#define FIOLETOWA     0xAAAAAAFF
#define ForeachEx(%2,%1) for(new %2 = 0; %2 < %1; %2++)



//MAX_XXX
#undef  MAX_PLAYERS
#define MAX_PLAYERS 		200
#define MAX_DOORS			800
#define MAX_FRAKCJA			50
#define MAX_ORG				300
#define MAX_BIZ				200
#define MAX_ANIM			400
#define MAX_ITEMS			8000
#define MAX_ORDER_INFO		1000
#define MAX_ORDERS			1000
#define MAX_PRODUCTS		1000
#define MAX_VEH				3000
#define MAX_OBJECT			400
#define MAX_RADIOSTATIONS   200
#define MAX_SPAWNS			400
#define MAX_CAM         	100
//#define MAX_BANK			200
//#define MAX_CHANGE		50
#define MAX_GANGZONE		300
#undef  MAX_VEHICLES
#define MAX_VEHICLES        1500
//#define MAX_DB      		500
#define MAX_BANS			100
#define MAX_VCARD			100
#define MAX_RACE			800

#define CASH_CHARITY		1
#define CASH_WYPLAC			2
#define CASH_WPLAC			3
#define CASH_DANIE			4
#define CASH_NAPOJ			5
#define CASH_ALKOHOL		6
#define CASH_ZAMOWIENIE		7
#define CASH_TUNING			8
#define CASH_SKIN			9
#define CASH_ALARM			10

#define DOOR_SALON			10
#define DOOR_STACJA			11


#define SPAWN_AJ			50

#define TAK					1
#define NIE					0

//Dialog ID
#define DIALOG_LOGIN					11221
#define DIALOG_NICK						11222
#define DIALOG_INFO						11223
#define DIALOG_HELP						11224
#define DIALOG_STATS					11225
#define DIALOG_ANIM						11226
#define DIALOG_AFK						11227
#define DIALOG_LAST_ONLINE				11228
#define DIALOG_RADIOPASS           		11229
#define DIALOG_RADIOCHANGEPASS     		11230

#define DIALOG_PYTANIAB			   		11231

#define DIALOG_KUP				   		11232

#define DIALOG_SELECT_SPAWN		   		11233

#define DIALOG_VEHICLE_LIST				13
#define DIALOG_VEHICLE_SPAWN			14
#define DIALOG_VEHICLE_FIND				15
#define DIALOG_VEHICLE_LIST_OPTION		16

//Owner
#define OWNER_NONE						0
#define OWNER_PLAYER					1
#define OWNER_BUSINESS					2
#define OWNER_ORGANISATION				3
#define OWNER_FRACTION					4
#define OWNER_HOUSE						5
#define OWNER_247						6
#define OWNER_JAIL						7
#define OWNER_GUN						8
#define OWNER_HOTEL						9
#define OWNER_BANK						10
#define OWNER_FRAC						11
#define OWNER_JOB						12
#define OWNER_BANKOMAT					13
#define OWNER_TOHOUSE					14
#define OWNER_GANG						15
#define OWNER_PACZKI					16
#define OWNER_DRUGS						17

#define BRON_MAFIA						1
#define BRON_GANG						2
#define BRON_SC							4
#define BRON_RACE						8
#define BRON_NARKOTYKI					16
#define ADMIN_SUPPORT					32

#define DIALOG_ITEM_DELETE          201
#define DIALOG_ITEM_LIST            202
#define DIALOG_ITEM_MAIN            203
#define DIALOG_ITEM_OPTION          204
#define DIALOG_ITEM_USE             205
#define DIALOG_ITEM_PUT             206
#define DIALOG_ITEM_CALL            207
#define DIALOG_ITEM_SEARCH          208
#define DIALOG_ITEM_CALL2           209
#define DIALOG_ITEM_SHARE           210
#define DIALOG_ITEM_SHARE2          211
#define DIALOG_ITEM_AMMO			212

#define DIALOG_KURIER_SELECT		300
#define DIALOG_KURIER_PRODUCT		301
#define DIALOG_KURIER_VALUE			302
#define DIALOG_KURIER_FINISH		303
#define DIALOG_KURIER_PHONE 		304
#define DIALOG_KURIER_LIST			305
#define DIALOG_KURIER_INFO			306

#define DIALOG_ADMIN_VEHICLE		400
#define DIALOG_ADMIN_VEHICLE_OPTION	401

#define DIALOG_PROSBA				500
#define DIALOG_ADMIN_PROSBA			501
#define DIALOG_ADMIN_PROSBA_OPT		502

#define DIALOG_CALL_EMERGENCY		600

#define DIALOG_LIST_MAGAZYNE		700
#define DIALOG_LIST_MAGAZYNE_VALUE	701
#define DIALOG_PUT_MAGAZYNE			702
#define DIALOG_PUT_MAGAZYNE_PRICE	703
//Koniec - tutaj nie dopisuj

// Radio

#define DIALOG_SELECT_JOB		   1000

#define DIALOG_BUY_PRODUCT		   1100

#define DIALOG_PRIV_MSG			   1200

#define DIALOG_ACCEPT_OFFER		   1300

#define DIALOG_SET_SKIN			   1400

#define DIALOG_ZMIANY			   1500

#define DIALOG_SALON_MAIN		   	1600
#define DIALOG_SALON_VEHICLES	   	1601
#define DIALOG_SALON_VEHICLES_COLOR	1602

#define DIALOG_BANS					1700
#define DIALOG_BANS_INFO			1701
#define DIALOG_BANS_OPTION			1702
#define DIALOG_FILTR_UID			1703
#define DIALOG_FILTR_IP				1704

#define DIALOG_YELLOWDOC			1800

#define DIALOG_PHONE_TUNE			1900

#define DIALOG_PHONE_MENU			2000
#define DIALOG_PHONE_CASE			2001

#define DIALOG_SELECTCASH_FUEL		2100

#define DIALOG_VEHICLE_MAIN			2200
#define DIALOG_VEHICLE_RADIO		2201

#define DIALOG_BANKOMAT				2300
#define DIALOG_BANKOMAT_INFO		2301
#define DIALOG_BANKOMAT_CASH		2302

#define DIALOG_TUNING				2401

#define DIALOG_GANG					2500

#define DIALOG_KARTOTEKA				2600
#define DIALOG_KARTOTEKA_INPUT 			2601
#define DIALOG_KARTOTEKA_SEARCH_ROW		2602

#define DIALOG_OFFER_ITEMS			2700
#define DIALOG_OFFER_ITEMS_PLAYERS	2701

#define DIALOG_OFFER_VEHICLES			2800
#define DIALOG_OFFER_VEHICLES_PLAYERS	2801



#define JOB_MECHANIK	1
#define JOB_SMIECIARZ	2
#define JOB_LISTONOSZ	3
#define JOB_PRZEMYTNIK	4

#define ITEM_WEAPON         1
#define ITEM_CLOTHES        2
#define ITEM_FOOD	        3
#define ITEM_LIC			4
#define ITEM_CARKEY			5
#define ITEM_PHONE			6
#define ITEM_RADIO			7
#define ITEM_PRODUCT		8
#define ITEM_DOWOD			9
#define ITEM_PASZPORT		10
#define ITEM_VEHICLE		11
#define ITEM_AMMO			12
#define ITEM_TIME			13
#define ITEM_FUEL			14
#define ITEM_CIGGY			15
#define ITEM_BEER   		16
#define ITEM_WINE			17
#define ITEM_CUFF			18
#define ITEM_TUNING			19
#define ITEM_YELLOWDOC		20
#define ITEM_DRINK			21
#define ITEM_PAINTWZOR		22
#define ITEM_ALARM			23
#define ITEM_VEHAUDIO		24
#define ITEM_SYRENA			25
#define ITEM_REKAWICZKI		26
#define ITEM_STRZYKAWKA		27
#define ITEM_KOSTKA			28
#define ITEM_WYTRYCH		29
#define ITEM_LOM			30
#define ITEM_KLIN			31
#define ITEM_TIRE			32
#define ITEM_PACZKA			33
#define ITEM_NARKOTYKI		34
#define ITEM_KOKAINA		35
#define ITEM_MARIHUANA		36
#define ITEM_CRACK			37
#define ITEM_SODA			38
#define ITEM_KANISTER		39

#define PRAWY_TYL			1
#define PRAWY_PRZOD			2
#define LEWY_TYL			4
#define LEWY_PRZOD			8

#define ACCEPT				1
#define REJECT				2

#define ITEM_OWNER_NONE          0
#define ITEM_OWNER_PLAYER        1
#define ITEM_OWNER_VEHICLE       2
#define ITEM_OWNER_BUSINESS      3
#define ITEM_OWNER_ORGANISATION  4
#define ITEM_OWNER_FRACTION      5

#define LIST_ITEM_PLAYER        1
#define LIST_ITEM_SEARCH        2
#define LIST_ITEM_SEARCH_VEH	3

#define ITEM_ACTION_CALL    1

#define OFFER_ITEM  	1
#define OFFER_VEHICLE   2
#define OFFER_BUSINESS  3
#define OFFER_BUSS_USL  4
#define OFFER_FUEL		5
#define OFFER_REPAIR	6
#define OFFER_MANDAT	7
#define OFFER_PAINCAR	8
#define OFFER_WYWIAD	9
#define OFFER_REKLAMA	10
#define OFFER_NEWS  	11
#define OFFER_VCARD		12
#define OFFER_VEHWZOR	13
#define OFFER_REGISTER	14
#define OFFER_HOUSE		15
#define OFFER_DANIE		16
#define OFFER_ALKOHOL	17
#define OFFER_NAPOJ		18
#define OFFER_TUNING	19
#define OFFER_SKIN		20
#define OFFER_ALARM		21
#define OFFER_RACE		22
#define OFFER_TEREN		23

#define COLOR_FADE1   0xE6E6E6E6
#define COLOR_FADE2   0xC8C8C8C8
#define COLOR_FADE3   0xAAAAAAAA
#define COLOR_FADE4   0x8C8C8C8C
#define COLOR_FADE5   0x6E6E6E6E

#define	FRACTION_GOV	1
#define FRACTION_PD		2
#define FRACTION_ERS	3
#define FRACTION_BP		4
#define FRACTION_FD		5
#define FRACTION_DMV	6
#define FRACTION_TRANS	7
#define FRACTION_TAXI	8
#define FRACTION_BUILD  9
#define FRACTION_RADIO	10
#define FRACTION_JAIL	11
#define FRACTION_FBI	12
#define FRACTION_SS		13

#define BUSINESS_FOOD 		1
#define BUSINESS_CAR		2//Car shop
#define BUSINESS_WORK		3//Warsztat
#define BUSINESS_GYM		4//Silownia
#define BUSINESS_TAXI		5
#define BUSINESS_SERV		6//Czyszczenie etc
#define BUSINESS_SEC		7//Ochrona
#define BUSINESS_FUEL		8//Paliwo
#define BUSINESS_DET		9//Detektyw
#define BUSINESS_SHOP		10
#define BUSINESS_SHOPGUN 	11
#define BUSINESS_RESTAURANT	12
#define BUSINESS_BAR		13
#define BUSINESS_TUNING		14
#define BUSINESS_PIZZA		15
#define BUSINESS_PACZKARNIA 16	
#define BUSINESS_CLUB		17
#define BUSINESS_PUB		18
#define BUSINESS_FASTFOOD   19
#define BUSINESS_BUILD		20
#define BUSINESS_LODZIARNIA 21
#define BUSINESS_CLOTHES	22		

#define ORGANISATION_CRIM	1
#define ORGANISATION_PUBL	2
#define ORGANISATION_SC		3//scigantow
#define ORGANISATION_SWAT	4
#define ORGANISATION_SS 	5
#define ORGANISATION_CARTEL	6

#define	LIC_A		4
#define LIC_B		8
#define LIC_C		16
#define	LIC_D		32
#define LIC_E		64
#define	LIC_S		128
#define LIC_MPIL	256
#define LIC_DPIL	512

#define COLOR_CREAM 0xffd395FF
#define COLOR_FADE  0xDADADAFF
#define FIOLETOWA     0xAAAAAAFF
#define FIOLETOWY     0xC2A2DAFF
#define COLOR_OFFER   0xffd395FF

#define CREATE  1
#define SELECT    2

#define BLOCK_OBJAZD    1
#define BLOCK_DROGA     2
#define BLOCK_BARIERKA1 3
#define BLOCK_BARIERKA2 4
#define BLOCK_BARIERKA3 5
#define BLOCK_BARIERKA4 6
#define BLOCK_PLOTEK    7

#define CAT_JEDNOSLADY 	1
#define CAT_TRZYD		2
#define CAT_PIECD		4
#define CAT_TERENOWE	8
#define CAT_CIEZAROWE	16
#define CAT_SPORTOWE 	32
#define CAT_KLASYCZNE	64
#define CAT_INNE		128
#define CAT_PREMIUM		256

#define GPERM_PANEL		1
#define GPERM_VEH		2
#define GPERM_DOOR		4
#define GPERM_CHAT		8
#define GPERM_OOC		16
#define GPERM_PRODUCT	32
#define GPERM_PODAJ		64
#define GPERM_NOPERM	128
#define GPERM_GROUP		256
#define GPERM_RESPAWN	512

#define BLOCK_NOACCEPT	8
#define BLOCK_BLOCK		16
#define BLOCK_DEAD		32
#define BLOCK_NORUN		64
#define BLOCK_OOC		128
#define BLOCK_GUN		256
#define BLOCK_VEH		512
#define BLOCK_ACCEPT	1024
#define BLOCK_BAN		2048

#define SAVE_ALL			10
#define SAVE_AJ				1
#define SAVE_BLOCK			2
#define SAVE_BW				4
#define SAVE_HP				8
#define SAVE_MONEY			16
#define SAVE_CRASH			32
#define SAVE_SKIN			64
#define SAVE_ONLINE			128
#define SAVE_HOUSE			256
#define SAVE_RADIO			512
#define SAVE_DOC			1024
#define SAVE_SPAWN			2048
#define SAVE_ARESZT			4096
#define SAVE_DILER			8192
#define SAVE_PHONE			16384
#define SAVE_WYPLATA		32768
#define SAVE_JOB			65536
#define SAVE_OPTION			131072
#define SAVE_ACHIEV			262144
//262143

#define ACHIEV_NOWKA_SZTUKA				1
#define ACHIEV_PASJONAT					2
#define ACHIEV_BIZNESMAN				4
#define ACHIEV_PREZES					8
#define ACHIEV_DYKTATOR					16
#define ACHIEV_LOKUM					32
#define ACHIEV_KONTAKT					64
#define ACHIEV_BANK_5000				128
#define ACHIEV_BANK_25000				256
#define ACHIEV_BANK_50000				512
#define ACHIEV_BANK_1000000				1024
#define ACHIEV_PRACA_BIZNES				2048
#define ACHIEV_PRACA_FRAKCJA			4096
#define ACHIEV_PRACA_ORG 				8192

#define ACHIEV_JAPA_KONIU 				16384
#define ACHIEV_SZESCIAN					32768
#define ACHIEV_KOLIZJA	 				65536
#define ACHIEV_MARATONCZYK 				131072
#define ACHIEV_WYKROCZENIE				262144

#define ACHIEV_ZAMELDOWANY				524288//10h
#define ACHIEV_TUBYLEC					1048576//100h
#define ACHIEV_OSADNIK					2097152//250h
#define ACHIEV_RODOWITY					4194304//500h
#define ACHIEV_DZIAD					8388608//1000h
#define ACHIEV_ARESZT					16777216//1000h
#define ACHIEV_PIRAT					33554432
#define ACHIEV_OBYWATELSTWO				67108864//350
#define ACHIEV_KIEROWCA					134217728//200
#define ACHIEV_DOSWIADCZONY_KIEROWCA	268435456//1000
#define ACHIEV_WCZASOWICZ				536870912//150
#define ACHIEV_ZASADA_ULICY				1073741824//150

			

#define OPTION_FREEZE		1
#define OPTION_KRZYK		2
#define OPTION_MOWA			4

#define TASK_SKIN			1
#define TASK_WEAPON			2
#define TASK_ITEM			3
#define TASK_PRODUCT		4
#define TASK_TEXT			5

#define FINGER_ITEM			1
#define FINGER_VEHICLE		2
#define FINGER_DOOR			3

#define DYS					22



#include "../include/Perm.inc"

new qr = 0;
enum pinfo
{
	lGID,
	lUID,
	GID, //UID globalne
	UID, //UID postaci
	AL, //LVL uprawnieñ
	Cash, //Iloœæ gotówki
	Skin, //Skin g³ówny
	Last_Skin, //Ostatni skin
	BW, //Czas BW
	AJ, //Czas AJ
	Frakcja, //UID frakcji
	FrakcjaR, //Ranga we Frakcji
	FrakcjaSkin,
	FrakcjaRanga[32],
	Org, //UID org
	OrgR, //Ranga we org
	OrgSkin,
	OrgRanga[32],
	Biznes, //UID biznesu
	BiznesR, //Ranga w biznesie
	BiznesSkin,
	BiznesRanga[32],
	BiznesGPerm,
	FrakcjaGPerm,
	OrgGPerm,
	Sex, //P³eæ
	Float:HP, //Health
	Float:HPLast, //Health
	Online, //Czas gry
	LastOnline,
	Float:Last[4], //Ostatnia pozycja
	Last_IntVW[2], //Ostatni Int i VW
	//
	Text3D:Nick, //3D NickName
	Text3D:DescTag,
	Text3D:DescTagVeh,
	NickPlayer[40], //Nick
	Duty[6], //0- Admin, 1- Assistanse
	Pasy,
	Freeze,
	House,
	RadioCanal,
	RadioOff,
	Lic,
	CarPkt,
	Praktyka,
	Teoria,//Do usuniêcia wraz z tabel¹ w bazie.
	Age,
	Dowod,
	Paszport,
	Niekaralnosc,
	Poczytalnosc,
	Przepustka,
	Metryczka,
	Spawn,
	SpawnType,
	Color,
	Block,
	Areszt,
	AresztCzas,
	DealerGun,
	DealerGunCzas,
	DealerDrug,
	Hotel,
	Phone,
	Daytime,
	Wyplata,
	FrakcjaWyplata,
	BiznesWyplata,
	OrgWyplata,
	Bank,
	TogW,
	PlayerParaliz,
	Cuffed,	
	Praca,
	Key[20],
	PrivTo,
	PrivMess[128],
	Opis[128],
	OpisOn,
	Qs,
	PktKar,
	Chusta,
	SpawnVehicle,
	NameOOC[20],
	Namierz,
	PhoneTune,
	PhoneOd,
	PhoneTuneHandle,
	DoorHandle,
	Wywiad,
	ServerKick,
	Bieg,
	VehEnter,
	AudioVeh,
	ShowAdmin,
	ReportCzas,
	LoggedTime,
	APerm,
	Rekawiczki,
	JobTime,
	JobDay,
	WyplataInt,
	Worek,
	Logged,
	Option,
	OnlineEnd,
	Achievm,
	AchievmPkt,
	AchievmTime,
	Premium,
	TimerP,
	TimerNick,
	AntyTime,
	SpawnTime,
	Weapon,
	WeaponItem,
	SoundGate,
	
	NaprawaCzas,
	NaprawaWoz,
	TuningCzas,
	TuningWoz,
	TuningItem,
	
	RaceID,
	RaceCpID,
	RaceTime,
	RaceTimeLast,
	RaceTimeFinish,
	RaceTimeStart,
	RaceFinish,
	RaceCreated,
	RaceCreatedCP,
	RaceCreatedName[32],
	RacePlace,
	Event,
	
	Knebel,
	Zwiazany,
	KupUbranie,
	OstatnieUbranie,
	
	ZamowNarkotyki,
	
	DrugLaugh,
	
	//AFK
	PlayerAfk,
	PlayerAfkTime,
	PlayerAfkTimeOld,
	AFK,
	AFKStay,
	
	TimeLic,
	HotelDoor
};
new PlayerInfo[MAX_PLAYERS][pinfo];

enum
{
    E_STREAMER_ATTACHED_PLAYER,
    E_STREAMER_ATTACHED_VEHICLE,
    E_STREAMER_COLOR,
    E_STREAMER_DISTANCE,
    E_STREAMER_DRAW_DISTANCE,
    E_STREAMER_EXTRA_ID,
    E_STREAMER_INTERIOR_ID,
    E_STREAMER_MAX_X,
    E_STREAMER_MAX_Y,
    E_STREAMER_MAX_Z,
    E_STREAMER_MIN_X,
    E_STREAMER_MIN_Y,
    E_STREAMER_MIN_Z,
    E_STREAMER_MODEL_ID,
    E_STREAMER_MOVE_SPEED,
    E_STREAMER_MOVE_X,
    E_STREAMER_MOVE_Y,
    E_STREAMER_MOVE_Z,
    E_STREAMER_NEXT_X,
    E_STREAMER_NEXT_Y,
    E_STREAMER_NEXT_Z,
    E_STREAMER_PLAYER_ID,
    E_STREAMER_R_X,
    E_STREAMER_R_Y,
    E_STREAMER_R_Z,
    E_STREAMER_SIZE,
    E_STREAMER_STYLE,
    E_STREAMER_TEST_LOS,
    E_STREAMER_TYPE,
    E_STREAMER_WORLD_ID,
    E_STREAMER_X,
    E_STREAMER_Y,
    E_STREAMER_Z
}

enum bBlokada
{
	bUID,
	Float: bX,
	Float: bY,
	Float: bZ,
	bUse,
	bStatus
}
new Blokada[25][bBlokada];

enum kKamera
{
	kUID,
	Float: kPosX,
	Float: kPosY,
	Float: kPosZ,
	Float: kRotZ,
	Float: kLookX,
	Float: kLookY,
	Float: kLookZ,
	Float: kLocX,
	Float: kLocY,
	Float: kLocZ,
	kName[32],
	kVw,
	kInt
}
new Kamera[MAX_CAM][kKamera];

enum pPickup
{
	Door
}
new PickupInfo[MAX_DOORS][pPickup];

enum kKolczatka
{
	kUID,
	Float: kX,
	Float: kY,
	Float: kZ,
	Float: kA,
	kUse
}
new Kolczatka[20][kKolczatka];

/*enum kZmiany
{
	UID,
	Text[128],
	Date[20],
	Max
}
new Zmiany[MAX_CHANGE][kZmiany];
*/
enum iIgnor
{
	Max,
	IgnoredID,
	PlayerID
}
new Ignored[MAX_PLAYERS][iIgnor];

enum fInfo
{
	UID,
	Name[32],
	Type,
	Cash,
	OOC,
	Spawn,
	Tel
};
new FrakcjaInfo[MAX_FRAKCJA][fInfo];

enum uInfo
{
	UID,
	Model,
	Cash,
	Sex,
	Otype,
	O
};
new Ubrania[400][uInfo];

enum oInfo
{
	UID,
	Name[40],
	Cash,
	Type,
	OOC,
	Spawn,
	Tel,
	Color
};
new OrgInfo[MAX_ORG][oInfo];

enum binfo
{
	UID,
	Name[32],
	Type,
	Cash,
	OOC,
	Tel
};
new BiznesInfo[MAX_BIZ][binfo];

enum bbans
{
	UID,
	Admin,
	Owner,
	AdresIP[15],
	Reason[32],
	Time,
	Filtr
};
new Bans[MAX_BANS][bbans];

enum ainfo
{
	UID,
	CMD[12],
	Lib[16], 
	Name[24],
	Float:Speed,
	Loop,
	Lock[2],
	Freeze,
	Time,
	Toggle
};
new AnimInfo[MAX_ANIM][ainfo];

/*enum bankinfo
{
	UID,
	Owner,
	Numer,
	Cash,
	Time
};
new Bank[MAX_BANK][bankinfo];*/

/*enum cinfo
{
	vUID,
	vModel,
	vOwnerType,
	vOwner,
	vLock,
	vColor[2],
	Float:vParking[4],
	vSpawn,
	vPanels,
	vRezerwa,
	vTow
};
new DbVehicles[MAX_VEH][cinfo];	

enum carinfo
{
	vehUID,
	Float:vHP,
	Float:vFuel,
	Float:vDistance,
	Float:vDistanceDay,
	vSilnik,
	vTimer,
	
};
new VehicleData[MAX_VEHICLES][carinfo];*/

enum vSalon
{
	UID,
	Model,
	Price,
	Cat
}
new Salon[400][vSalon];

enum rRace
{
	UID,
	Float: raceX,
	Float: raceY,
	Float: raceZ,
	Mother,
	Finish,
	Created,
	Name[32],
	Place,
	Cash
}
new Race[MAX_RACE][rRace];

enum eCar
{
	vehUID,
	vehLights,
	vehEngine,		
	Float: LastX,
	Float: LastY,
	Float: LastZ,
	Maska,
	Bagaznik,
	Audio,
	Syrena
}
new VehicleData[MAX_VEHICLES][eCar];

// Vehicles in-database
enum eVehicles
{
	vUID,
	vModel,
	Float:vParking[4],
	vColor[2],
	vOwnerType,
	vOwner,
	vLock,
	Float:vFuel,
	vFuelType,
	Float: vDistance,
	Float:vHP,
	vTow,
	vAudio,
	vAudioURL[128],
	Float: vDistanceDay,
	vPaint,
	vBlock,
	vRadarID,
	vSpawn,
	vVw,
	vInt,
	vTablica[10],
	vDt
}
new DbVehicles[MAX_VEH][eVehicles];

enum gzone
{
	UID,
	Float: minX,
	Float: minY,
	Float: maxX,
	Float: maxY,
	Color[10],
	Owner,
	SampID,
	Name[32]
};
new GangZone[MAX_GANGZONE][gzone];	

enum dDoors
{
	dUID,

	dOwnerType,
	dOwner,

	Float:dEnterX,
	Float:dEnterY,
	Float:dEnterZ,
	Float:dEnterAng,
	dEnterInt,
	dEnterVw,
	dEnterInfo[128],

	Float:dExitX,
	Float:dExitY,
	Float:dExitZ,
	Float:dExitAng,
	dExitInt,
	dExitVw,

	dLock,
	dPickupID, // 1318 - default
	dName[50],
	dGarage,
	dPickup,
	dEnVw,
	dExVw,
	dUrl[64],
	dAlarm,
	dAlarmOn,
	dKlin,
	dValue
}
new DoorData[MAX_DOORS][dDoors];

enum oObject
{
	oUID,
	oModel,
	Float: oX,
	Float: oY,
	Float: oZ,
	Float: orotX,
	Float: orotY,
	Float: orotZ,
	oGroup,
	oVW
}
new Object[3000][oObject];

enum iItems
{
	iUID,
	iType,
	iOwner,
	iValue1,
	iValue2,
	iName[32],
	iOwnertype,
	Float: iX,
	Float: iY,
	Float: iZ,
	iDoor,
	iUse,
	Text3D:i3DText,
	iCreate,
	iTermin
}
new Item[MAX_ITEMS][iItems];

enum iIrc
{
	iUID,
	Owner,
	Channel
}
new Irc[400][iIrc];

enum vCard
{
	UID,
	Phone,
	Owner,
	Date,
	Name[32],
	Number
}
new Card[MAX_VCARD][vCard];

enum gGate
{
	gUID,
	gOwnertype,
	gOwner,
	gModel,
	Float: gOx,
	Float: gOy,
	Float: gOz,
	Float: gOrx,
	Float: gOry,
	Float: gOrz,
	Float: gCx,
	Float: gCy,
	Float: gCz,
	Float: gCrz,
	Float: gDokladnosc,
	gOpen,
	gScale,
	gVW
}
new Gate[800][gGate];

enum oOferta//Index to id gracza wysy³aj¹cego
{
	oCustomer,
	oPrice,
	oType,
	oValue1,
	oSeller
}
new OfertaInfo[MAX_PLAYERS][oOferta];

enum einfo
{
	Text:Penalty, //TextDraw od kar
	Timer_Penalty, //Czas TD
	Minutnik, //Timer Minutowy
	MAX_FRAKCJE, //Iloœæ frakcji
	MAX_ORGANIZACJE, //Iloœæ org
	MAX_BIZNES, //Iloœæ biznesów
	MAX_ANIMS, //Iloœæ animacji
	MAX_DOOR, //Iloœæ drzwi
	MAX_CARS, //Iloœæ aut
	MAX_UBRANIA, // Iloœæ ubrañ
	Piec
};
new ServerInfo[einfo];

enum orderinfo
{
	UID,
	Type,
	Value1,
	Value2,
	Ownertype,
	Owner,
	Price,
	Group,
	GroupType,
	Name[32]
};
new OrderInfo[MAX_ORDER_INFO][orderinfo];

enum order
{
	UID,
	Type,
	Ownertype,
	Owner,
	Value,
	Value1,
	Value2,
	Phone,
	Date,
	Name[32],
	Accept,
	Price
};
new Order[MAX_ORDERS][order];

enum prod
{
	UID,
	Type,
	Ownertype,
	Owner,
	Value,
	Value1,
	Value2,
	Price,
	Name[32]
};
new Product[MAX_PRODUCTS][prod];

/*enum prosby
{
	Owner,
	Text[128],
	Max,
	Date
}
new Prosba[200][prosby];
*/
enum rRadio
{
	rUID,
	rOwnerType,
	rOwner,
	rPassword[32],
	rCanal
}
new Radio[MAX_RADIOSTATIONS][rRadio];

enum sSpawn
{
	UID,
	Ownertype,
	Owner,
	Float: sX,
	Float: sY,
	Float: sZ,
	Float: sA,
	sVw,
	sInt
}
new FracSpawn[MAX_SPAWNS][sSpawn];

/*new VehName[212][]=
{
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Pereniel", "Sentinel", "Dumper", "Firetruck",
	"Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah",
	"Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee",
	"BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion",
	"Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
	"Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
	"Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway",
	"RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad",
	"Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR3 50", "Walton", "Regina",
	"Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick",
	"News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer", "Hotring Racer",
	"Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropdust",
	"Stunt", "Tanker", "RoadTrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Rhino",
	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck",
	"Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade",
	"Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck",
	"Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility",
	"Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan",
	"Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
	"Freight", "Trailer", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado",
	"AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer",
	"Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Trailer", "Trailer", "Andromeda",
	"Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car", "Police Ranger", "Picador",
	"S.W.A.T. Van", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer", "Luggage Trailer", "Stair Trailer",
	"Boxville", "Farm Plow", "Utility Trailer"
};*/

enum Coords
{
	SPU,
	VehicleID,
	Float:sX,
	Float:sY,
	Float:sZ,
};

new SyrenaPos[33][Coords] = {
	{1, 560, 0.398071289,0.75390625,0.43879509},
	{2, 560, -0.35644531250, 0.0388183593, 0.863788605}, 
	{3, 415, 0.409729004, 0.526367188, 0.206963539}, 
	{4, 415, -0.290039062, -0.284179688, 0.631957054},
	{5, 421, 0.421691895, 0.804931641, 0.256482124}, 
	{6, 421, -0.323303223, 0.0207519532, 0.731482506}, 
	{7, 426, 0.575378418, 0.786132812, 0.361483574}, 
	{8, 426, -0.455505371, -0.143066406, 0.861475945}, 
	{9, 579, 0.454345703, 0.575683594, 0.645122528}, 
	{10, 579, -0.442626953, -0.269042969, 1.27014542}, 
	{11, 402, 0.53515625, 0.562988281, 0.278743744}, 
	{12, 402, -0.412841797, -0.474365234, 0.778804779}, 
	{13, 596, 0.53515625, 0.771728516, 0.373809814},
	{14, 596, -0.0048828125, -0.860107422, 0.848770142}, 
	{15, 597, 0.53515625, 0.771728516, 0.373809814}, 
	{16, 597, -0.0048828125, -0.860107422, 0.848770142}, 
	{17, 598, 0.406738281, 0.696777344, 0.398208618}, 
	{18, 598, -0.0048828125, -0.860107422, 0.848770142}, 
	{19, 544, 0.522338867, 2.5925293, 1.46867275},
	{20, 528, 0.563842773, 0.754882812, 0.487258911}, 
	{21, 525, -0.0089111328, 0.273193359, 1.4037838}, 
	{22, 409, 0.420776367, 1.80236816, 0.368680954}, 
	{23, 409, -0.439941406, 0.824829102, 0.842817307}, 
	{24, 461, 0.00000000, -0.932861328, 0.494509697}, 
	{25, 521, 0.00000000, -0.928955078, 0.558652878}, 
	{26, 586, 0.00000000, -1.20178223, 0.671886444}, 
	{27, 506, 0.541137695, 0.282714844, 0.272130013}, 
	{28, 482, 0.493530273, 1.39465332, 0.442443848}, 
	{29, 482, -0.392211914, 0.565551758, 0.941601753}, 
	{30, 424, -0.624511719, 0.139648438, 0.918135643},
	{31, 470, -0.617797851, 0.056640625, 1.10928631},
	{32, 433, -0.577392578, 1.23217773, 1.70311642},
	{33, 432, -1.21105957, -3.84765625, 1.17495251}
};


#define COLOR_ERROR 			0xFB0000FF
#define COLOR_MSG               0xFFFFFF00

// GangZone Colors
#define BLACK                  	0x00000055
#define WHITE                  	0xFFFFFF55
#define ORANGE                  0xFF800055
#define RED                     0xFF000055
#define BLUE                    0x0000FF55
#define VIOLET                  0x8000FF55
#define GREEN                   0x00FF0055
#define YELLOW                  0xFFFF0055
#define PINK                    0xFF80FF55
#define SEABLUE                 0x5BB9E655
#define BROWN                   0x562C2C55

// Max Zones You Can Create
#define MAX_ZONES               100

new
	bool: GangZonePL[MAX_PLAYERS],
	bool: GetPos[MAX_PLAYERS],
	CreatedZone[MAX_ZONES],
	gColor,
	Float: pMaxX = 0.0,
	Float: pMaxY = 0.0,
	Float: pMinX = 0.0,
	Float: pMinY = 0.0,
	Float: pZ = 0.0,
	gCount;
	
ShowDefaultDialog(playerid)
{
	return ShowPlayerDialog(playerid, 9540, DIALOG_STYLE_LIST, "Tworzenie terenu gangu...", "Utwórz teren gangu", "Wybierz", "WyjdŸ");
}	

stock RefreshNick(playerid)
{
	new str[256], dol[128], cyfra;
	if(GetAccountPremium(playerid)) format(str, sizeof(str), "* %s (%d)", PlayerName2(playerid), playerid);
	else format(str, sizeof(str), "%s (%d)", PlayerName2(playerid), playerid);
	if(PlayerInfo[playerid][BW] != 0)
	{
		format(str, sizeof(str), "%s\nNieprzytomny", str);
	}	
	else
	{
		format(str, sizeof(str), "%s", str);
	}
	if(PlayerInfo[playerid][Pasy] == 1)
	{
		format(dol, sizeof(dol), "pasy");
		cyfra = 1;
	}
	if(PlayerUseGloves(playerid))
	{
		if(cyfra == 1) format(dol, sizeof(dol), "%s, rêkawiczki", dol);
		else format(dol, sizeof(dol), "rêkawiczki");
		cyfra = 2;
	}
	if(PlayerInfo[playerid][TimerP] != 0)
	{
		if(cyfra == 2) format(dol, sizeof(dol), "%s, ranny", dol);
		else format(dol, sizeof(dol), "ranny");
		cyfra = 3;
	}
	if(GetPlayerDrunkLevel(playerid) > 1000 && GetPlayerDrunkLevel(playerid) < 17000)
	{
		if(cyfra == 3) format(dol, sizeof(dol), "%s, pijany", dol);
		else format(dol, sizeof(dol), "pijany");
		cyfra = 4;
	}
	if(GetPlayerDrunkLevel(playerid) >= 17000)
	{
		if(cyfra == 3) format(dol, sizeof(dol), "%s, upity", dol);
		else format(dol, sizeof(dol), "upity");
		cyfra = 4;
	}	
	if(PlayerInfo[playerid][AL] < 0 && PlayerInfo[playerid][Duty][0] == 1)
	{
		format(str, sizeof(str), "Assistance\n%s (%d)", PlayerName2(playerid), playerid);
	}
	if(strlen(dol) == 0) format(str, sizeof(str), "%s", str);
	else format(str, sizeof(str), "%s\n(%s)", str, dol);
	
	if(PlayerInfo[playerid][Chusta] > 0)
	{
		format(str, sizeof(str), " ");
	}	
	Update3DTextLabelText(PlayerInfo[playerid][Nick], PlayerInfo[playerid][Color], str);
	if(GetPlayerDrunkLevel(playerid) > 6000) ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4, 1, 1, 1, 1, 1);
	return 1;
}

stock GetPlayerGender(playerid)
{
	new gender[2];
	if(PlayerInfo[playerid][Sex] == 0) format(gender, sizeof(gender), "K");
	else if(PlayerInfo[playerid][Sex] == 1) format(gender, sizeof(gender), "M");
	return gender;
}

stock GetPlayerGenderFull(playerid)
{
	new gender[20];
	if(PlayerInfo[playerid][Sex] == 0) format(gender, sizeof(gender), "Kobieta");
	else if(PlayerInfo[playerid][Sex] == 1) format(gender, sizeof(gender), "Mê¿czyzna");
	return gender;
}
		
stock dechex(number)
{
	new hexadecimal_string[15];
	format(hexadecimal_string, 15, "%x", number + 100);
	return hexadecimal_string;
}

stock GameTextAdmin(const string[], style)
{
	ForeachEx(i, MAX_PLAYERS)
	{
		if(PlayerInfo[i][UID] != 0 && PlayerInfo[i][AL] != 0 ) GameTextForPlayer(i, string, 5000, style);
	}
	return 1;
}

stock SendAdminMessage(color, const string[], duty, al)
{
	ForeachEx(i, MAX_PLAYERS)
	{
		if(PlayerInfo[i][UID] != 0)
		if(duty == 1)
		{
			if(al == 1)
			{
				if(PlayerInfo[i][AL] > 0 && PlayerInfo[i][Duty][0] == 1) SendClientMessage(i, color, string);
			}
			else if(al == 0)
			{
				if(PlayerInfo[i][AL] != 0 && PlayerInfo[i][Duty][0] == 1) SendClientMessage(i, color, string);
			}
			else if(al == -1) 
			{
				if(PlayerInfo[i][AL] < 0 && PlayerInfo[i][Duty][1] == 1) SendClientMessage(i, color, string);
			}
		}
		else
		{
			if(al == 1)
			{
				if(PlayerInfo[i][AL] > 0 && PlayerInfo[i][Duty][0] == 1) SendClientMessage(i, color, string);
			}
			else if(al == 0)
			{
				if(PlayerInfo[i][AL] != 0 && PlayerInfo[i][Duty][0] == 1) SendClientMessage(i, color, string);
			}
			else if(al == -1) 
			{
				if(PlayerInfo[i][AL] < 0 && PlayerInfo[i][Duty][1] == 1) SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

stock GetPlayedTime(playerid, &hours, &minutes) 
{ 
	hours = PlayerOnline(playerid) / 3600;
	minutes = (PlayerOnline(playerid) - hours * 3600) / 60;
	return 1;
}

stock GetPlayedTimeSec(playerid, &hours, &minutes, &second) 
{ 
	hours 	= PlayerOnline(playerid) / 3600;
	minutes = (PlayerOnline(playerid) - (hours * 3600)) / 60;
	second 	= ((PlayerOnline(playerid) - (hours * 3600)) - (minutes * 60));
	return 1;
}

stock GetPlayedTimeSecZ(zmienna, &hours, &minutes, &second) 
{ 
	hours 	= zmienna / 3600;
	minutes = (zmienna - hours * 3600) / 60;
	second 	= ((zmienna - (hours * 3600)) - (minutes * 60));
	return 1;
}

stock ConvertSecondTime(playerid, &hours, &minutes) 
{ 
	hours = playerid / 3600;
	minutes = (playerid - hours * 3600) / 60;
	return 1;
}
			
stock GetPlayedTimeAFK(playerid, &hours, &minutes, &second) 
{ 
	hours = PlayerInfo[playerid][AFK] / 3600;
	minutes = (PlayerInfo[playerid][AFK] - hours * 3600) / 60;
	second 	= ((PlayerInfo[playerid][AFK] - (hours * 3600)) - (minutes * 60));
	return 1;
}

stock mysql_check()
{
	if(mysql_ping() == (-1))
	{
		print("[MySQL] Utracono po³¹czenie. Ponawiam... [Próba: 1/3]");
		mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
		if(!mysql_reload())
		{
			print("[MySQL] Próba nie powiod³a siê, ponawiam... [Próba: 2/3]");
			if(!mysql_reload())
			{
				print("[MySQL] Próba nie powiod³a siê, ponawiam... [Próba: 3/3]");
				if(!mysql_reload())
				{
					print("[MySQL] Próba nie powiod³a siê. [Zakoñczono]");
					SendRconCommand("hostname [g-rp.pl] B³¹d bazy danych, proszê czekaæ...");
					SendRconCommand("password qweqweqwe");
					SetGameModeText("SQL_ERROR");
				}
				else print("[MySQL] Po³¹czenie powiod³o siê.");
			}
			else print("[MySQL] Po³¹czenie powiod³o siê.");
		}
		else print("[MySQL] Po³¹czenie powiod³o siê.");
	}
	return 1;
}
		
stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, Float:a, vw, int)
{
	SetPlayerPos(playerid, Float:x, Float:y, Float:z);
	SetPlayerFacingAngle(playerid, Float:a);
	SetPlayerVirtualWorld(playerid, vw);
	SetPlayerInterior(playerid, int);
	return 1;
}
		
stock LoginName(playerid)
{
	new loginname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, loginname, sizeof(loginname));
	return loginname;
}
		
stock NickName(playerid)
{
	new NickRP[MAX_PLAYER_NAME];
	GetPlayerName(playerid, NickRP, sizeof(NickRP));
	ForeachEx(i, strlen(NickRP))
	{
		if(NickRP[i] == '_') NickRP[i] = ' ';
	}
	return NickRP;
}

stock PreloadAnimLibraries(playerid) // By Ziomal
{
	static AnimLibraries[][] =
	{
		"AIRPORT","Attractors","BAR","BASEBALL","BD_FIRE","BEACH","benchpress",
		"BF_injection","BIKED","BIKEH","BIKELEAP","BIKES","BIKEV","BIKE_DBZ","BMX",
		"BOMBER","BOX","BSKTBALL","BUDDY","BUS","CAMERA","CAR","CARRY","CAR_CHAT",
		"CASINO","CHAINSAW","CHOPPA","CLOTHES","COACH","COLT45","COP_AMBIENT",
		"COP_DVBYZ","CRACK","CRIB","DAM_JUMP","DANCING","DEALER","DILDO","DODGE",
		"DOZER","DRIVEBYS","FAT","FIGHT_B","FIGHT_C","FIGHT_D","FIGHT_E","FINALE",
		"FINALE2","FLAME","Flowers","FOOD","Freeweights","GANGS","GHANDS",
		"GHETTO_DB","goggles","GRAFFITI","GRAVEYARD","GRENADE","GYMNASIUM",
		"HAIRCUTS","HEIST9","INT_HOUSE","INT_OFFICE","INT_SHOP","JST_BUISNESS",
		"KART","KISSING","KNIFE","LAPDAN1","LAPDAN2","LAPDAN3","LOWRIDER",
		"MD_CHASE","MD_END","MEDIC","MISC","MTB","MUSCULAR","NEVADA","ON_LOOKERS",
		"OTB","PARACHUTE","PARK","PAULNMAC","ped","PLAYER_DVBYS","PLAYIDLES",
		"POLICE","POOL","POOR","PYTHON","QUAD","QUAD_DBZ","RAPPING","RIFLE","RIOT",
		"ROB_BANK","ROCKET","RUSTLER","RYDER","SCRATCHING","SHAMAL","SHOP",
		"SHOTGUN","SILENCED","SKATE","SMOKING","SNIPER","SPRAYCAN","STRIP",
		"SUNBATHE","SWAT","SWEET","SWIM","SWORD","TANK","TATTOOS","TEC","TRAIN",
		"TRUCK","UZI","VAN","VENDING","VORTEX","WAYFARER","WEAPONS","WUZI"
	};
	for(new l; l < sizeof(AnimLibraries); l++) ApplyAnimation(playerid, AnimLibraries[l], "null", 0.0, 0, 0, 0, 0, 0);
}

stock SendClientMessageEx(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
	new Float:posx, Float:posy, Float:posz, Float:oldposx, Float:oldposy, Float:oldposz, Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	ForeachEx(i, MAX_PLAYERS)
	{
		if(IsPlayerConnected(i) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
		{
			GetPlayerPos(i, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);
			if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) SendClientMessage(i, col1, string);
			else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) SendClientMessage(i, col2, string);
			else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) SendClientMessage(i, col3, string);
			else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) SendClientMessage(i, col4, string);
			else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) SendClientMessage(i, col5, string);
		}
	}
	return 1;
}

/*ConvertPolishToEnglish(string[])
{
	new Characters[16][16] =
	{
		{ 185, 97 },
		{ 165, 65 },
		{ 230, 99 },
		{ 198, 67 },
		{ 234, 101 },
		{ 202, 69 },
		{ 179, 108 },
		{ 163, 76 },
		{ 243, 111 },
		{ 211, 79 },
		{ 156, 115 },
		{ 140, 83 },
		{ 191, 122 },
		{ 175, 90 },
		{ 159, 122 },
		{ 143, 90 }
	};

	for (new i, len = strlen(string); i < len; i++)
		for (new g; g < 16; g++)
			if (string[i] == Characters[g][0])
			{
				string[i] = Characters[g][1];
				break;
			}
	return 1;
}*/

stock PlayerName2(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	UnderscoreToSpace(name);
	return name;
}

forward SearchRadio(Canal);
public SearchRadio(Canal)
{
	new find = 0;
	ForeachEx(i, MAX_RADIOSTATIONS)
	{
	    if(Radio[i][rCanal] == Canal)
		{
		    find = i;
		}
	}
	return find;
}

forward LoadRadioStation();
public LoadRadioStation()
{
	new row[60], uid, i = 0;
    mysql_query("SELECT * FROM `grp_radiostation`");
    mysql_store_result();
    while(mysql_fetch_row_format(row, "|"))
    {
        sscanf(row, "p<|>d", uid);

   		sscanf(row,"p<|>ddds[32]d",		Radio[uid][rUID],
			   							Radio[uid][rOwnerType],
										Radio[uid][rOwner],
										Radio[uid][rPassword],
										Radio[uid][rCanal]);
		i++;
		//printf("Wczytano kana³ radiowy o UID: %d", Radio[uid][rUID]);
    }
    printf("Radia       - %d", i);
}

forward AddRadioStation(OwnerType, Ow, Password[], Canal);
public AddRadioStation(OwnerType, Ow, Password[], Canal)
{
	new query[256];
	format(query, sizeof(query), "INSERT INTO `grp_radiostation` (`id` ,`ownertype` ,`owner` ,`pass` ,`canal`) VALUES (NULL , '%d', '%d', '%s', '%d')",
	OwnerType, Ow, Password, Canal);

	mysql_check();
	mysql_query(query);
	new uid = mysql_insert_id();

	Radio[uid][rUID] = uid;
	Radio[uid][rOwnerType] = OwnerType;
	Radio[uid][rOwner] = Ow;
	format(Radio[uid][rPassword], 32, "%s", Password);
	Radio[uid][rCanal] = Canal;
	return uid;
}

forward SaveRadioStation(radioid);
public SaveRadioStation(radioid)
{
	new query[256];
	format(query, sizeof(query), "UPDATE `grp_radiostation` SET `OwnerType` = '%d', `Owner` = '%d', `Password` = '%s', `Canal` = '%d' WHERE `id` = %d",
			Radio[radioid][rOwnerType],
			Radio[radioid][rOwner],
			Radio[radioid][rPassword],
			Radio[radioid][rCanal],
			radioid);

	mysql_check();
	mysql_query(query);
	return 1;
}

/*new Float:SpawnPos[7][4] = { // positions where players in vehicles spawn
{1469.9108,-1741.7598,13.5469,7.5200},
{1104.3431,-1754.0862,13.5469,98.7009},
{1129.7296,-1466.8353,15.7451,359.3733},
{650.5795,-1413.9825,13.5578,356.2633},
{1022.9061,-1132.4042,23.8281,179.8550},
{1777.2306,-1161.5022,23.8281,169.8516},
{2499.7788,-1685.3342,13.4515,13.0385}
};*/

new Float:PackPos[34][3] = { 
{2846.3745,916.9916,10.7500},
{2792.3982,2608.8171,10.8203},
{2302.1333,2770.3806,10.8203},
{1066.2948,2265.2056,10.8126},
{978.7938,2095.8191,10.8203},
{1052.3934,2170.3342,10.8203},
{1125.6398,1963.4684,10.8203},
{962.1481,1732.0588,8.6484},
{1077.4506,1255.7197,10.8203},
{580.7252,1215.0197,11.8220},
{348.7184,874.4588,20.4063},
{-2261.5610,2297.3938,4.8202},
{-2405.1912,974.4553,45.2969},
{-2472.7031,785.7183,35.1719},
{-1741.0449,1418.0184,7.1875},
{-1864.4241,1410.3427,7.1875},
{-2633.4534,1359.6428,7.1160},
{-1824.3389,70.4077,15.1228},
{-1733.8503,210.1693,3.5547},
{-1545.5565,127.4792,3.5547},
{-2121.5537,-233.6937,35.3203},
{-2521.0698,-609.1926,132.5625},
{-1903.8673,-1725.2172,21.7564},
{-546.5793,-490.2556,25.5234},
{-21.1425,-283.2737,5.4297},
{-181.3224,-216.2047,1.4219},
{90.2643,-304.0842,1.5781},
{807.2786,-605.2440,16.3432},
{876.2291,-1256.1672,14.9908},
{1897.7573,-2261.6802,13.5469},
{1747.2919,-2068.1277,13.6214},
{2177.4065,-2283.1829,13.5452},
{2768.4580,-2453.8230,13.6432},
{2484.7649,-2113.7178,13.5469}
};

/*ew Float:CzujnikPos[3][3] = { 
{523.5593,469.2017,18.9297},
{-179.4006,331.4546,12.0781},
{2766.2937,556.1342,8.2898}
};*/

/*
new Float:VehicleSpawnPos[6][4] = { 
{1084.2820,-1382.2788,13.5523,178.8258},
{1084.3954,-1376.7487,13.5539,178.8251},
{1084.4929,-1370.9774,13.5531,178.7657},
{1087.6810,-1382.1766,13.5534,181.9939},
{1087.5525,-1376.2896,13.5518,180.3586},
{1087.4985,-1367.7058,13.5525,180.3573}
};
*/

/*new Float:IdlewoodPos[36][4] = {
{1854.0056,-1914.9154,15.2568},
{1872.1388,-1912.6749,15.2568},
{1892.0770,-1916.0425,15.2568},
{1913.8887,-1913.5216,15.2568},
{1929.0188,-1916.9707,15.2568},
{1937.7205,-1911.3300,15.2568},
{1933.9302,-1863.9095,13.5619},
{2045.4916,-1907.7045,13.5619},
{2238.1448,-1906.4088,14.9375},
{2241.5308,-1882.6575,14.2344},
{2261.1926,-1906.1014,14.9375},
{2269.1455,-1883.2985,14.2344},
{2284.9351,-1905.9957,14.9297},
{2296.5479,-1883.0740,14.2344},
{2356.4924,-1990.3569,13.5469},
{2400.5469,-1981.8154,13.5469},
{2437.8672,-2020.6888,13.9025},
{2465.3259,-1995.9357,13.6889},
{2465.1162,-2020.2832,14.1242},
{2483.1877,-1996.5508,13.8343},
{2508.0044,-2020.5336,14.2101},
{2508.2161,-1998.7422,13.9025},
{2522.2654,-2017.9832,13.8125},
{2524.4346,-1998.4303,14.1131},
{2434.5806,-1941.6901,13.5469},
{2492.7810,-1957.7190,13.5469},
{2751.8091,-1963.5654,13.5469},
{2751.9404,-1937.2008,13.5469},
{2786.1804,-1926.1238,13.5469},
{2786.1462,-1952.0717,13.5469},
{2402.5625,-1715.7908,14.0698},
{2386.3977,-1713.0431,14.1718},
{2326.9490,-1717.3413,13.9074},
{2308.6829,-1714.9841,14.6496},
{2292.5635,-1723.1222,13.5469},
{2228.0925,-1721.6831,13.5639}
};*/


new Float:BusPos[32][4] = { 
{1253.8190,-1831.1973,13.1410,271.1346},
{864.5341,-1767.6943,13.1250,89.7950},
{381.7278,-1511.6466,32.2032,307.0751},
{525.4685,-1270.7068,15.8787,308.2579},
{794.3054,-1353.1985,13.1369,180.5179},
{1153.2133,-1408.6165,13.2462,268.6796},
{1360.6017,-1258.6528,13.1273,358.2532},
{1432.1975,-1036.9169,23.3991,271.5791},
{1787.0410,-1281.4944,13.2116,310.9977},
{2241.4980,-1143.0121,25.4624,255.1205},
{2792.1812,-1887.8104,10.6422,93.5755},
{2268.4099,-1749.4218,13.1276,93.5114},
{1906.6495,-1749.1787,13.1324,87.0792},
{1526.4437,-1677.8212,13.1289,178.6380},
{1692.9891,-1835.9335,13.1325,358.8566},
{1710.9186,-2321.9041,13.1283,270.4171},
{1692.6746,-2322.2236,-3.1053,268.7993},

{1710.4578,-2316.3391,13.1582,89.2234},
{1687.0526,-1829.4010,13.1603,179.4329},
{1532.2865,-1663.9066,13.1644,1.2133},
{1906.9808,-1754.7524,13.1626,272.2218},
{2243.3516,-1752.5885,13.1660,270.3456},
{2786.5842,-1893.9248,10.6709,269.3531},
{2257.0645,-1140.9016,26.4168,73.9108},
{1800.7089,-1265.0433,13.2468,118.1852},
{1440.9434,-1030.9978,23.4339,92.4975},
{1339.0719,-1256.6455,13.3828,178.0241},
{1180.4644,-1392.5054,13.0660,89.3739},
{800.5013,-1352.7469,13.1623,0.3786},
{520.0692,-1254.2825,15.9141,128.4773},
{367.4805,-1501.5717,32.3362,127.5689},
{807.5058,-1786.8341,13.2118,268.0337}
};
/*enum Area
{
	COLOR
}	
	

new ZoneColor[][Area] = {
{"0x6cac07AA"},
{"0xdf5454AA"},
{"0xfff368AA"},
{"0x4060fdAA"},
{"0xff9000AA"},
{"0xff00f0AA"},
{"0xbfff8bAA"},
{"0xad03e5AA"}//Fiolet
};*/ 

//new ZoneColor[0] = {"0x6cac07AA"};

enum Pyt
{
	NUM,
	ODP_A[128],
	ODP_B[128],
	ODP_C[128],
	PYT[128],
	ODP
}

/*new PytaniaB[][Pyt] = {
		{ 1, "powinien zatrzymaæ pojazd.", "mo¿e przejechaæ przez przejazd, je¿eli upewni³ siê, ¿e nie zbli¿a siê poci¹g.", "jest informowany o kontroli drogowej.", "Widz¹c dwa na przemian migaj¹ce czerwone sygna³y przed przejazdem kolejowym, kieruj¹cy pojazdem:", 1 },
		{ 2, "watê", "ligninê", "ja³ow¹ gazê", "Bezpoœrednio na ranê nale¿y po³o¿yæ:", 3 },
		{ 3, "swoje dane personalne", "pieni¹dze z portfela", "rozwalony samochód i zbiec z miejsca wypadku", "W razie uczestniczenia w wypadku drogowym, kieruj¹cy pojazdem powinien podaæ na ¿adanie osób w nim uczestnicz¹cych:", 1 },
		{ 4, "podj¹æ dzia³ania zapewniaj¹ce bezpieczeñstwo ruchu w miejscu wypadku", "powiadomic swoj¹ nabli¿s¿a rodzinê", "niezw³ocznie usun¹æ pojazd z miejsca wypadku", "W razie uczestniczenia w wypadku drogowym, w którym s¹ ofiary, kieruj¹ce pojazdem powinien:", 1 },
		{ 5, "zamówiæ pizze", "zadzwoniæ po stra¿ graniczn¹.", "zadzwoniæ na 112 i poinformowaæ odpowiednie s³u¿by. ", "W razie uczestniczenia w wypadku drogowym, w którym s¹ ofiary, kieruj¹cy pojazdem powinien:", 3 },
		{ 6, "przejechaæ pieszych", "zatrzymaæ siê", "zjechac na lew¹ stronê jezdni i omin¹æ pieszych", "Wid¹c chwiej¹cych siê pieszych przy poboczu drogi, kieruj¹cy pojazdem powinien:", 2 },
		{ 7, "pieni¹dze w portfelu", "dzia³anie uk³adu hamulcowego i kierowniczego, oraz œwiat³a zewnetrzne pojazdu", "czy ma czyste buty", "Przed rozpoczêciem d³u¿szej jazdy nale¿y sprawdziæ:", 2 },
		{ 8, "wycieku krwistej wydzieliny z ucha", "krwotoku", "zmia¿d¿enia koñczyny", "Opatrunek uciskowy stosujemy przy:", 2 }
};*/

stock WolneUIDKolczatki()
{
	ForeachEx(i, 20)
	{
	    if(i != 0)
	    {
		    if(Kolczatka[i][kUse] == 0)
		    {
		        return i;
		    }
		    else continue;
		}
	}
	return 1;
}

forward LoadOrderInfo();
public LoadOrderInfo()
{
	new result[256], query[128], i = 0, uid;
    format(query, sizeof(query), "SELECT * FROM `grp_orderinfo`");

    qr++; mysql_query(query);

    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
		sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>ddddddddds[32]", OrderInfo[uid][UID],
											OrderInfo[uid][Type],
											OrderInfo[uid][Value1],
											OrderInfo[uid][Value2],
											OrderInfo[uid][Ownertype],
											OrderInfo[uid][Owner],
											OrderInfo[uid][Price],
											OrderInfo[uid][Group],
											OrderInfo[uid][GroupType],
											OrderInfo[uid][Name]);
							
		i++;
	}
	mysql_free_result();
	//printf("[Wczytywanie] Wczytano %d informacji do zamówieñ.", i);
}

forward SearchFreeOrderInfoIndex();
public SearchFreeOrderInfoIndex()
{
	new find = 0;
	ForeachEx(i, MAX_ORDER_INFO)
	{
	    if(i != 0)
	    {
			if(OrderInfo[i][UID] < 1)
			{
			    find = i;
			}
			if(find != 0)
			{
				return find;
			}
		}
	}
	return find;
}

forward SaveOrderInfo(uid);
public SaveOrderInfo(uid)
{
    //if(ServerRestart != -1) return 1;
	new query[200];
	new index = uid;
	format(query, sizeof(query), "UPDATE `grp_orderinfo` SET `type` = '%d', `ownertype` = '%d', `owner` = '%d', `value1` = '%d', `value2` = '%d', `name` = '%s', `price` = '%d', `group` = '%d', `groupt` = '%d' WHERE `id` = '%d'",
	OrderInfo[index][Type],
	OrderInfo[index][Ownertype],
	OrderInfo[index][Owner],
	OrderInfo[index][Value1],
	OrderInfo[index][Value2],
	OrderInfo[index][Name],
	OrderInfo[index][Price],
	OrderInfo[index][Group],
	OrderInfo[index][GroupType],
	uid);
	qr++; mysql_query(query);
	mysql_free_result();
	//printf("[ZAPIS] Informacja o zamówieniu (uid %d) zapisana pomyœlnie.", uid);
	return 1;
}

forward DeleteOrderInfo(uid);
public DeleteOrderInfo(uid)
{
	new query[64];
	format(query, sizeof(query), "DELETE FROM `grp_orderinfo` WHERE `id` = '%d'", uid);

	qr++; mysql_query(query);

	
	new index = uid;
	OrderInfo[index][UID] = 0;
	OrderInfo[index][Type] = 0;
	OrderInfo[index][Ownertype] = 0;
	OrderInfo[index][Owner] = 0;
	OrderInfo[index][Name] = 0;
	mysql_free_result();
	//printf("Informacja o produkcie (uid %d) usuniêta pomyœlnie.", uid);
	return 1;
}

forward AddOrderInfo(type, ownertype, owner, price, value1, value2, group, groupt, name[]);
public AddOrderInfo(type, ownertype, owner, price, value1, value2, group, groupt, name[])
{
	new query[500];
	new index = GetFreeSQLUID("grp_orderinfo", "id");
	format(query, sizeof(query), "INSERT INTO `grp_orderinfo` (`id`, `type`, `ownertype`, `owner`, `value1`, `value2`, `name`, `price`, `group`, `groupt`) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%s', '%d', '%d', '%d')",
	index, type, ownertype, owner, value1, value2, name, price, group, groupt);
	qr++; mysql_query(query);

	
    OrderInfo[index][UID] = index;
	OrderInfo[index][Type] = type;
	OrderInfo[index][Ownertype] = ownertype;
	OrderInfo[index][Owner] = owner;
	format(OrderInfo[index][Name], 32, "%s", name);
	OrderInfo[index][Price] = price;
	OrderInfo[index][Value1] = value1;
	OrderInfo[index][Value2] = value2;
	OrderInfo[index][GroupType] = groupt;
	OrderInfo[index][Group] = group;
	mysql_free_result();
    //printf("[STWORZ] Informacja o zamówieniu (uid %d) stworzona pomyœlnie.", uid);
	return index;
}

forward SearchFreeOrderIndex();
public SearchFreeOrderIndex()
{
	new find = 0;
	ForeachEx(i, MAX_ORDERS)
	{
	    if(i != 0)
	    {
			if(Order[i][UID] < 1)
			{
			    find = i;
			}
			if(find != 0)
			{
				return find;
			}
		}
	}
	return find;
}

forward LoadProducts();
public LoadProducts()
{
	new result[256], query[50], i = 0;
    format(query, sizeof(query), "SELECT * FROM `grp_products`");

    qr++; mysql_query(query);

    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
		new uid;
		sscanf(result,  "p<|>d", uid);
		sscanf(result,  "p<|>dddddddds[32]", Product[uid][UID],
											Product[uid][Type],
											Product[uid][Ownertype],
											Product[uid][Owner],
											Product[uid][Value],
											Product[uid][Value1],
											Product[uid][Value2],
											Product[uid][Price],
											Product[uid][Name]);

		i++;
	}
	mysql_free_result();
	//printf("[Wczytywanie] Wczytano %d produktów.", i);
}

forward SaveProduct(uid);
public SaveProduct(uid)
{
    //if(ServerRestart != -1) return 1;
	new query[256];
	format(query, sizeof(query), "UPDATE `grp_products` SET `type` = '%d', `ownertype` = '%d', `owner` = '%d', `value` = '%d', `value1` = '%d', `value2` = '%d', `price` = '%d', `name` = '%s' WHERE `id` = '%d'",
	Product[uid][Type],
	Product[uid][Ownertype],
	Product[uid][Owner],
	Product[uid][Value],
	Product[uid][Value1],
	Product[uid][Value2],
	Product[uid][Price],
	Product[uid][Name],
	uid);
	qr++; mysql_query(query);
	mysql_free_result();
	//printf("[ZAPIS] Produkt (uid %d) zapisany pomyœlnie.", uid);
	return 1;
}

forward DeleteProduct(uid);
public DeleteProduct(uid)
{
	new query[64];
	format(query, sizeof(query), "DELETE FROM `grp_products` WHERE `id` = '%d'", uid);

	qr++; mysql_query(query);

	Product[uid][UID] = 0;
	Product[uid][Type] = 0;
	Product[uid][Ownertype] = 0;
	Product[uid][Owner] = 0;
	Product[uid][Value] = 0;
	Product[uid][Name] = 0;
	mysql_free_result();
	//printf("Produkt (uid %d) usuniêty pomyœlnie.", uid);
	return 1;
}

forward AddProduct(type, ownertype, owner, value, value1, value2, name[], price);
public AddProduct(type, ownertype, owner, value, value1, value2, name[], price)
{
	new query[256];
	new uid = GetFreeSQLUID("grp_products", "id");
	format(query, sizeof(query), "INSERT INTO `grp_products` (`id`, `type`, `ownertype`, `owner`, `value`, `value1`, `value2`, `name`, `price`) VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d', '%s', '%d')",
	uid, type, ownertype, owner, value, value1, value2, name, price);
	qr++; mysql_query(query);

    Product[uid][UID] = uid;
	Product[uid][Type] = type;
	Product[uid][Ownertype] = ownertype;
	Product[uid][Owner] = owner;
	Product[uid][Value] = value;
	Product[uid][Value1] = value1;
	Product[uid][Value2] = value2;
	Product[uid][Price] = price;
	format(Product[uid][Name], 32, "%s", name);
	mysql_free_result();
    //printf("[STWORZ] Produkt (uid %d) stworzony pomyœlnie.", uid);
	return uid;
}

forward GetPlayerID2(globalacc);
public GetPlayerID2(globalacc)
{
	ForeachEx(playerid, MAX_PLAYERS)
	{
	    if(PlayerInfo[playerid][GID] == globalacc) return playerid;
	}
	return INVALID_PLAYER_ID;
}

stock str_replace(sSearch[], sReplace[], const sSubject[], &iCount = 0)
{
	new
		iLengthTarget = strlen(sSearch),
		iLengthReplace = strlen(sReplace),
		iLengthSource = strlen(sSubject),
		iItterations = (iLengthSource - iLengthTarget) + 1;

	new
		sTemp[128],
		sReturn[_strlib_sma_string];

	strcat(sReturn, sSubject, _strlib_sma_string);
	iCount = 0;

	for(new iIndex; iIndex < iItterations; ++iIndex)
	{
		strmid(sTemp, sReturn, iIndex, (iIndex + iLengthTarget), (iLengthTarget + 1));

		if(!strcmp(sTemp, sSearch, false))
		{
			strdel(sReturn, iIndex, (iIndex + iLengthTarget));
			strins(sReturn, sReplace, iIndex, iLengthReplace);

			iIndex += iLengthTarget;
			iCount++;
		}
	}

	return sReturn;
}

stock PlayerOnlineUID(uid)
{
	ForeachEx(i, MAX_PLAYERS)
	{
		if(uid == PlayerInfo[i][UID])
		{
			return i + 1;
		}
	}
	return 0;
}	

new Float:VinewoodPos[493][4] = {
{1406.3,-810.2,75.0,185.4952},
{1409.9,-810.3,75.2,185.4952},
{1413.4,-810.3,75.4,185.4952},
{1417.3,-810.2,75.6,185.4952},
{1420.7,-810.2,75.7,185.4952},
{1424.4,-810.2,75.8,185.4952},
{1428.1,-810.2,75.9,185.4952},
{1431.4,-810.2,76.0,185.4952},
{1434.2,-810.2,76.1,185.4952},
{1437.2,-810.2,76.1,185.4952},
{1440.8,-810.2,76.2,185.4952},
{1444.5,-810.2,76.1,185.4952},
{1447.8,-810.2,75.8,185.4952},
{1451.3,-810.1,75.5,185.4952},
{1454.0,-810.1,75.3,185.4952},
{1453.6,-811.1,74.5,185.4952},
{1450.8,-811.1,74.7,185.4952},
{1447.1,-811.2,74.9,185.4952},
{1444.0,-811.3,75.1,185.4952},
{1440.3,-811.4,75.1,185.4952},
{1436.8,-811.4,75.1,185.4952},
{1433.6,-811.2,75.1,185.4952},
{1430.9,-811.2,75.1,185.4952},
{1427.7,-811.3,74.9,185.4952},
{1424.1,-811.1,75.0,185.4952},
{1420.3,-811.1,75.0,185.4952},
{1417.0,-811.2,74.8,185.4952},
{1413.2,-811.0,74.8,185.4952},
{1409.6,-811.2,74.5,185.4952},
{1406.2,-810.9,74.5,185.4952},
{1402.6,-810.9,74.3,185.4952},
{1453.5,-812.2,73.6,185.4952},
{1450.4,-812.3,73.7,185.4952},
{1446.8,-812.3,74.0,185.4952},
{1443.8,-812.3,74.2,185.4952},
{1440.0,-812.3,74.3,185.4952},
{1436.6,-812.2,74.4,185.4952},
{1433.4,-812.1,74.4,185.4952},
{1430.7,-812.1,74.3,185.4952},
{1427.5,-812.1,74.2,185.4952},
{1423.6,-812.1,74.2,185.4952},
{1419.7,-812.0,74.2,185.4952},
{1416.6,-812.1,74.1,185.4952},
{1413.3,-811.9,74.1,185.4952},
{1409.4,-812.0,73.8,185.4952},
{1405.7,-811.9,73.7,185.4952},
{1402.1,-811.9,73.6,185.4952},
{1402.2,-813.1,72.6,185.4952},
{1406.2,-813.2,72.7,185.4952},
{1409.8,-813.2,72.9,185.4952},
{1413.6,-813.2,73.1,185.4952},
{1417.1,-813.2,73.2,185.4952},
{1420.6,-813.2,73.0,185.4952},
{1424.1,-813.1,73.3,185.4952},
{1428.1,-813.2,73.3,185.4952},
{1431.2,-813.1,73.5,185.4952},
{1433.6,-813.1,73.5,185.4952},
{1436.8,-813.2,73.5,185.4952},
{1440.7,-813.2,73.5,185.4952},
{1444.5,-813.2,73.5,185.4952},
{1447.0,-813.1,73.3,185.4952},
{1450.6,-813.0,73.1,185.4952},
{1453.8,-813.4,72.6,185.4952},
{1402.7,-814.3,71.8,185.4952},
{1406.7,-814.4,71.8,185.4952},
{1410.7,-814.5,72.0,185.4952},
{1414.3,-814.6,72.1,185.4952},
{1417.4,-814.6,71.9,185.4952},
{1421.0,-814.4,72.1,185.4952},
{1424.5,-814.2,72.3,185.4952},
{1428.7,-814.3,72.4,185.4952},
{1431.7,-814.0,72.6,185.4952},
{1434.0,-814.1,72.7,185.4952},
{1437.2,-814.2,72.6,185.4952},
{1441.0,-814.1,72.8,185.4952},
{1445.1,-814.1,72.6,185.4952},
{1447.6,-814.4,72.2,185.4952},
{1451.1,-814.3,72.0,185.4952},
{1453.7,-815.1,71.1,185.4952},
{1403.5,-815.5,70.9,185.4952},
{1407.2,-815.7,70.9,185.4952},
{1411.4,-815.8,71.1,185.4952},
{1415.0,-815.9,70.8,185.4952},
{1418.0,-815.8,70.7,185.4952},
{1421.5,-815.6,71.0,185.4952},
{1425.3,-815.3,71.3,185.4952},
{1429.3,-815.4,71.4,185.4952},
{1432.4,-815.2,71.6,185.4952},
{1434.7,-815.1,71.8,185.4952},
{1437.9,-815.3,71.6,185.4952},
{1441.6,-815.2,71.9,185.4952},
{1445.7,-815.1,71.7,185.4952},
{1447.8,-815.3,71.3,185.4952},
{1451.5,-815.4,71.0,185.4952},
{1453.9,-816.3,70.0,185.4952},
{1404.0,-816.9,69.8,185.4952},
{1408.0,-817.1,69.9,185.4952},
{1411.8,-817.3,69.7,185.4952},
{1415.5,-817.0,69.8,185.4952},
{1419.0,-816.9,69.5,185.4952},
{1422.2,-816.7,70.1,185.4952},
{1425.9,-816.4,70.4,185.4952},
{1429.8,-816.4,70.5,185.4952},
{1433.1,-816.3,70.7,185.4952},
{1435.2,-816.3,70.7,185.4952},
{1438.5,-816.5,70.6,185.4952},
{1442.3,-816.2,70.9,185.4952},
{1446.0,-816.3,70.6,185.4952},
{1448.9,-816.5,70.2,185.4952},
{1451.9,-816.8,69.8,185.4952},
{1454.3,-817.6,68.9,185.4952},
{1451.4,-817.8,68.9,185.4952},
{1448.0,-817.7,69.3,185.4952},
{1445.2,-817.4,69.7,185.4952},
{1442.0,-817.3,70.0,185.4952},
{1438.1,-817.4,69.8,185.4952},
{1434.4,-817.4,69.8,185.4952},
{1432.4,-817.4,69.7,185.4952},
{1429.2,-817.3,69.7,185.4952},
{1425.3,-817.6,69.3,185.4952},
{1421.6,-817.8,69.0,185.4952},
{1418.7,-817.8,68.7,185.4952},
{1415.1,-817.9,68.9,185.4952},
{1411.4,-818.3,68.9,185.4952},
{1407.4,-818.1,69.1,185.4952},
{1403.6,-817.9,69.1,185.4952},
{1403.8,-819.4,67.9,185.4952},
{1408.1,-819.4,68.0,185.4952},
{1412.3,-819.5,67.6,185.4952},
{1415.6,-819.2,67.6,185.4952},
{1419.3,-819.0,67.6,185.4952},
{1422.2,-818.8,68.2,185.4952},
{1426.2,-818.7,68.4,185.4952},
{1429.9,-818.6,68.6,185.4952},
{1433.4,-818.4,68.8,185.4952},
{1435.4,-818.4,68.8,185.4952},
{1438.5,-818.5,68.9,185.4952},
{1442.5,-818.3,69.1,185.4952},
{1445.9,-818.7,68.5,185.4952},
{1448.7,-818.8,68.3,185.4952},
{1452.0,-818.9,68.0,185.4952},
{1455.1,-818.7,67.9,185.4952},
{1404.1,-820.8,66.9,185.4952},
{1408.7,-820.8,66.7,185.4952},
{1413.0,-820.7,66.5,185.4952},
{1416.1,-820.4,66.5,185.4952},
{1419.7,-820.0,66.6,185.4952},
{1422.7,-819.8,67.3,185.4952},
{1426.8,-819.6,67.6,185.4952},
{1430.1,-819.4,67.9,185.4952},
{1434.0,-819.4,67.9,185.4952},
{1435.9,-819.4,68.0,185.4952},
{1438.7,-819.7,67.8,185.4952},
{1442.9,-819.5,68.1,185.4952},
{1446.3,-819.8,67.6,185.4952},
{1449.4,-819.9,67.3,185.4952},
{1452.6,-820.0,67.1,185.4952},
{1455.6,-820.1,67.0,185.4952},
{1455.2,-821.2,66.5,185.4952},
{1452.3,-821.2,66.6,185.4952},
{1448.7,-821.0,66.7,185.4952},
{1445.6,-820.8,66.9,185.4952},
{1442.3,-820.5,67.2,185.4952},
{1438.0,-820.6,67.0,185.4952},
{1435.0,-820.5,67.0,185.4952},
{1431.8,-820.5,67.0,185.4952},
{1428.1,-820.5,66.9,185.4952},
{1424.6,-820.7,66.6,185.4952},
{1420.7,-821.0,66.0,185.4952},
{1417.2,-821.1,65.7,185.4952},
{1413.3,-821.5,65.6,185.4952},
{1409.5,-821.6,65.8,185.4952},
{1405.4,-821.6,66.2,185.4952},
{1402.3,-821.5,66.3,185.4952},
{1403.1,-822.5,65.5,185.4952},
{1406.4,-822.9,64.9,185.4952},
{1409.5,-822.9,64.6,185.4952},
{1412.9,-822.8,64.4,185.4952},
{1416.5,-822.2,64.7,185.4952},
{1420.3,-822.1,64.9,185.4952},
{1423.5,-822.0,65.4,185.4952},
{1427.3,-821.6,65.9,185.4952},
{1430.4,-821.4,66.1,185.4952},
{1434.0,-821.4,66.2,185.4952},
{1437.4,-821.5,66.2,185.4952},
{1440.9,-821.3,66.5,185.4952},
{1444.2,-821.5,66.6,185.4952},
{1447.5,-821.9,66.4,185.4952},
{1450.2,-822.2,66.2,185.4952},
{1452.9,-822.2,66.1,185.4952},
{1455.8,-822.6,65.9,185.4952},
{1455.1,-824.4,65.1,185.4952},
{1454.9,-825.3,64.7,185.4952},
{1454.6,-826.6,64.1,185.4952},
{1454.5,-827.5,63.7,185.4952},
{1454.3,-828.4,63.3,185.4952},
{1452.8,-823.8,65.4,185.4952},
{1452.9,-825.0,64.9,185.4952},
{1452.9,-826.2,64.3,185.4952},
{1452.8,-827.4,63.8,185.4952},
{1452.7,-828.3,63.4,185.4952},
{1450.3,-823.1,65.7,185.4952},
{1450.6,-824.2,65.2,185.4952},
{1450.7,-825.5,64.7,185.4952},
{1450.9,-826.4,64.3,185.4952},
{1451.1,-827.6,63.7,185.4952},
{1451.3,-828.5,63.3,185.4952},
{1448.6,-822.6,66.0,185.4952},
{1448.7,-823.5,65.6,185.4952},
{1448.7,-824.4,65.2,185.4952},
{1448.8,-825.3,64.8,185.4952},
{1448.8,-826.2,64.4,185.4952},
{1448.9,-827.1,64.0,185.4952},
{1448.8,-828.5,63.4,185.4952},
{1447.1,-822.3,66.2,185.4952},
{1447.1,-823.5,65.7,185.4952},
{1447.0,-824.6,65.1,185.4952},
{1446.9,-825.5,64.7,185.4952},
{1446.8,-826.4,64.3,185.4952},
{1446.7,-827.3,64.0,185.4952},
{1446.5,-828.1,63.5,185.4952},
{1445.6,-822.3,66.2,185.4952},
{1445.4,-823.2,65.8,185.4952},
{1445.3,-824.3,65.3,185.4952},
{1445.4,-825.5,64.7,185.4952},
{1445.3,-826.6,64.0,185.4952},
{1445.2,-827.6,63.4,185.4952},
{1443.8,-822.3,66.1,185.4952},
{1443.8,-823.2,65.6,185.4952},
{1443.6,-824.3,64.8,185.4952},
{1443.4,-825.2,64.2,185.4952},
{1443.1,-826.3,63.4,185.4952},
{1442.3,-821.9,65.9,185.4952},
{1442.2,-823.0,65.2,185.4952},
{1442.1,-823.9,64.6,185.4952},
{1441.9,-824.8,64.0,185.4952},
{1440.9,-822.0,65.8,185.4952},
{1440.8,-823.0,65.0,185.4952},
{1440.8,-823.8,64.3,185.4952},
{1440.6,-825.1,63.4,185.4952},
{1439.5,-821.8,65.9,185.4952},
{1439.5,-822.8,65.1,185.4952},
{1438.9,-824.1,63.9,185.4952},
{1403.8,-823.7,64.4,185.4952},
{1406.2,-824.0,63.9,185.4952},
{1409.9,-823.8,63.7,185.4952},
{1413.4,-823.8,63.4,185.4952},
{1417.2,-823.2,63.7,185.4952},
{1421.1,-822.9,64.3,185.4952},
{1424.2,-822.9,64.6,185.4952},
{1427.9,-822.6,65.0,185.4952},
{1430.9,-822.4,65.3,185.4952},
{1433.7,-822.5,65.3,185.4952},
{1435.9,-822.6,65.2,185.4952},
{1402.3,-824.7,63.4,185.4952},
{1404.6,-825.1,63.0,185.4952},
{1406.6,-825.4,62.5,185.4952},
{1410.9,-825.2,62.3,185.4952},
{1413.9,-824.9,62.4,185.4952},
{1417.7,-824.3,62.6,185.4952},
{1421.6,-823.9,63.5,185.4952},
{1425.0,-823.8,63.9,185.4952},
{1428.7,-823.7,64.1,185.4952},
{1431.7,-823.6,64.2,185.4952},
{1434.3,-823.6,64.2,185.4952},
{1436.2,-823.8,64.2,185.4952},
{1373.3,-808.5,91.6,185.4952},
{1375.8,-808.4,91.6,185.4952},
{1380.2,-808.7,91.6,185.4952},
{1382.5,-808.6,91.6,185.4952},
{1384.1,-808.5,93.7,185.4952},
{1386.5,-808.5,93.7,185.4952},
{1389.2,-808.6,92.3,185.4952},
{1391.6,-808.6,92.3,185.4952},
{1394.8,-808.5,92.3,185.4952},
{1397.5,-808.5,92.3,185.4952},
{1400.1,-808.5,92.1,185.4952},
{1402.5,-808.5,92.1,185.4952},
{1406.2,-808.5,92.1,185.4952},
{1408.4,-808.5,91.9,185.4952},
{1410.9,-808.5,91.9,185.4952},
{1414.9,-808.5,91.9,185.4952},
{1416.0,-808.5,91.9,185.4952},
{1420.0,-808.4,91.9,185.4952},
{1421.7,-808.5,91.9,185.4952},
{1424.4,-808.4,92.5,185.4952},
{1426.2,-808.5,93.9,185.4952},
{1427.9,-808.5,93.9,185.4952},
{1430.1,-808.5,93.9,185.4952},
{1432.3,-808.4,91.8,185.4952},
{1434.5,-808.5,91.9,185.4952},
{1436.8,-808.5,93.9,185.4952},
{1440.6,-808.5,93.9,185.4952},
{1446.1,-808.5,92.5,185.4952},
{1448.6,-808.6,92.5,185.4952},
{1451.6,-808.5,92.5,185.4952},
{1453.4,-808.5,90.9,185.4952},
{1413.9,-823.5,63.6,185.4952},
{1411.0,-823.4,64.0,185.4952},
{1406.8,-823.5,64.3,185.4952},
{1404.7,-823.2,64.7,185.4952},
{1402.1,-822.9,65.1,185.4952},
{1435.5,-824.8,63.2,185.4952},
{1433.5,-824.9,63.1,185.4952},
{1430.7,-824.9,63.0,185.4952},
{1427.9,-824.8,63.0,185.4952},
{1424.6,-824.8,62.9,185.4952},
{1421.2,-825.0,62.4,185.4952},
{1417.2,-825.3,61.7,185.4952},
{1413.7,-825.7,61.5,185.4952},
{1411.4,-826.2,61.3,185.4952},
{1407.4,-826.6,61.2,185.4952},
{1404.6,-826.3,61.8,185.4952},
{1401.7,-825.7,62.4,185.4952},
{1434.8,-825.9,62.3,185.4952},
{1432.5,-825.9,62.1,185.4952},
{1430.0,-826.0,62.1,185.4952},
{1427.1,-825.9,62.1,185.4952},
{1424.2,-826.1,61.8,185.4952},
{1420.7,-826.1,61.3,185.4952},
{1416.6,-826.2,60.9,185.4952},
{1413.0,-826.8,60.6,185.4952},
{1410.4,-827.2,60.4,185.4952},
{1407.0,-827.7,60.3,185.4952},
{1404.8,-827.4,60.6,185.4952},
{1401.8,-826.9,61.2,185.4952},
{1402.0,-827.5,60.5,185.4952},
{1402.4,-828.7,59.2,185.4952},
{1402.7,-829.7,58.2,185.4952},
{1403.0,-830.6,57.2,185.4952},
{1403.4,-831.4,56.3,185.4952},
{1403.7,-832.3,55.4,185.4952},
{1404.1,-833.2,54.4,185.4952},
{1404.5,-834.3,53.3,185.4952},
{1404.9,-835.3,52.3,185.4952},
{1405.3,-836.2,51.3,185.4952},
{1405.1,-828.6,59.4,185.4952},
{1405.4,-829.3,58.7,185.4952},
{1405.9,-830.1,57.8,185.4952},
{1406.2,-830.8,57.0,185.4952},
{1406.7,-831.6,56.2,185.4952},
{1407.1,-832.4,55.4,185.4952},
{1407.6,-833.3,54.4,185.4952},
{1408.1,-834.2,53.5,185.4952},
{1408.6,-835.2,52.5,185.4952},
{1407.6,-828.3,59.6,185.4952},
{1408.1,-828.8,59.1,185.4952},
{1408.7,-829.6,58.3,185.4952},
{1409.3,-830.2,57.7,185.4952},
{1409.8,-830.8,57.0,185.4952},
{1410.4,-831.5,56.3,185.4952},
{1411.0,-832.2,55.6,185.4952},
{1411.6,-832.9,54.9,185.4952},
{1412.2,-833.6,54.2,185.4952},
{1412.8,-834.3,53.4,185.4952},
{1411.2,-828.2,59.4,185.4952},
{1411.7,-829.0,58.7,185.4952},
{1412.2,-829.9,57.7,185.4952},
{1412.8,-830.7,56.9,185.4952},
{1413.3,-831.6,56.0,185.4952},
{1413.9,-832.5,55.1,185.4952},
{1414.4,-833.3,54.2,185.4952},
{1414.9,-834.1,53.5,185.4952},
{1414.0,-827.3,60.0,185.4952},
{1414.6,-828.3,59.1,185.4952},
{1415.1,-829.3,58.1,185.4952},
{1415.7,-830.2,57.1,185.4952},
{1416.2,-831.3,56.1,185.4952},
{1416.8,-832.2,55.2,185.4952},
{1417.3,-833.0,54.3,185.4952},
{1417.2,-827.0,60.0,185.4952},
{1417.6,-827.8,59.2,185.4952},
{1418.0,-828.8,58.3,185.4952},
{1418.3,-829.6,57.5,185.4952},
{1418.8,-830.6,56.8,185.4952},
{1419.2,-831.6,55.9,185.4952},
{1419.6,-832.6,55.1,185.4952},
{1421.1,-827.2,60.3,185.4952},
{1421.2,-828.1,59.6,185.4952},
{1421.4,-829.0,58.8,185.4952},
{1421.6,-829.9,58.0,185.4952},
{1421.8,-830.9,57.2,185.4952},
{1422.0,-831.9,56.3,185.4952},
{1422.2,-832.8,55.6,185.4952},
{1422.4,-833.7,54.8,185.4952},
{1422.5,-834.6,54.0,185.4952},
{1422.7,-835.5,53.2,185.4952},
{1422.6,-836.3,52.4,185.4952},
{1424.3,-826.9,61.1,185.4952},
{1424.4,-827.7,60.4,185.4952},
{1424.4,-828.4,59.8,185.4952},
{1424.5,-829.2,59.1,185.4952},
{1424.6,-830.0,58.4,185.4952},
{1424.7,-830.8,57.7,185.4952},
{1424.7,-831.5,57.1,185.4952},
{1424.8,-832.3,56.4,185.4952},
{1424.9,-833.1,55.7,185.4952},
{1425.0,-834.0,54.9,185.4952},
{1425.1,-834.8,54.2,185.4952},
{1425.1,-835.6,53.5,185.4952},
{1425.2,-836.5,52.6,185.4952},
{1427.0,-826.6,61.4,185.4952},
{1427.3,-827.6,60.5,185.4952},
{1427.4,-828.5,59.7,185.4952},
{1427.5,-829.5,58.9,185.4952},
{1427.6,-830.3,58.2,185.4952},
{1427.7,-831.1,57.5,185.4952},
{1427.8,-831.9,56.8,185.4952},
{1427.9,-832.9,55.9,185.4952},
{1428.0,-833.7,55.2,185.4952},
{1428.1,-834.5,54.5,185.4952},
{1428.2,-835.3,53.8,185.4952},
{1428.3,-836.2,53.2,185.4952},
{1428.4,-837.2,52.5,185.4952},
{1459.1,-783.5,158.6,185.4952},
{1401.0,-824.3,64.1,185.4952},
{1401.1,-822.2,66.0,185.4952},
{1401.3,-819.7,67.7,185.4952},
{1401.6,-817.2,69.5,185.4952},
{1401.9,-815.0,71.2,185.4952},
{1402.0,-812.6,73.0,185.4952},
{1402.0,-811.0,74.2,185.4952},
{1402.0,-809.4,75.4,185.4952},
{1400.8,-809.4,75.4,185.4952},
{1400.7,-811.0,74.2,185.4952},
{1400.6,-812.6,73.1,185.4952},
{1400.5,-814.8,71.6,185.4952},
{1400.3,-817.2,70.1,185.4952},
{1400.1,-819.5,68.5,185.4952},
{1399.8,-822.2,66.7,185.4952},
{1399.5,-809.7,75.5,185.4952},
{1399.1,-811.5,74.8,185.4952},
{1399.0,-812.8,73.9,185.4952},
{1399.0,-813.9,73.2,185.4952},
{1399.0,-815.3,72.1,185.4952},
{1399.1,-816.6,71.2,185.4952},
{1398.9,-818.0,70.2,185.4952},
{1398.9,-819.3,69.3,185.4952},
{1398.7,-820.5,68.6,185.4952},
{1398.7,-822.2,67.4,185.4952},
{1398.0,-809.8,75.5,185.4952},
{1398.0,-811.1,75.3,185.4952},
{1397.5,-812.5,74.9,185.4952},
{1397.5,-813.7,74.1,185.4952},
{1397.8,-815.4,72.8,185.4952},
{1397.7,-816.5,72.0,185.4952},
{1397.8,-817.9,71.1,185.4952},
{1397.7,-819.2,70.1,185.4952},
{1397.7,-820.5,69.2,185.4952},
{1397.7,-822.0,68.0,185.4952},
{1396.4,-810.1,75.4,185.4952},
{1396.6,-811.6,75.2,185.4952},
{1396.3,-813.3,75.0,185.4952},
{1396.4,-814.7,74.0,185.4952},
{1396.3,-816.2,73.1,185.4952},
{1396.2,-817.2,72.3,185.4952},
{1396.2,-818.6,71.4,185.4952},
{1396.2,-819.8,70.6,185.4952},
{1396.2,-821.2,69.4,185.4952},
{1396.3,-822.2,68.2,185.4952},
{1395.1,-810.0,75.5,185.4952},
{1395.1,-811.6,75.1,185.4952},
{1395.0,-813.4,74.9,185.4952},
{1394.9,-814.7,74.8,185.4952},
{1394.8,-816.1,73.8,185.4952},
{1395.0,-817.2,73.0,185.4952},
{1395.0,-818.4,72.2,185.4952},
{1394.9,-819.8,71.2,185.4952},
{1394.8,-821.3,70.2,185.4952},
{1394.8,-822.5,68.7,185.4952},
{1394.0,-810.3,75.4,185.4952},
{1393.9,-811.5,75.0,185.4952},
{1393.6,-813.2,74.8,185.4952},
{1393.5,-815.0,74.7,185.4952},
{1393.3,-816.7,74.3,185.4952},
{1393.2,-818.0,73.4,185.4952},
{1393.2,-819.5,72.4,185.4952},
{1393.1,-821.1,71.2,185.4952},
{1391.6,-817.4,74.5,185.4952},
{1390.5,-818.8,74.3,185.4952},
{1389.3,-820.4,73.9,185.4952},
{1388.1,-822.1,73.4,185.4952},
{1387.3,-823.9,73.2,185.4952},
{1386.6,-825.6,73.1,185.4952},
{1385.8,-827.4,72.9,185.4952},
{1384.9,-829.0,72.7,185.4952},
{1383.5,-830.9,72.1,185.4952},
{1382.6,-832.4,71.7,185.4952},
{1428.1,-808.7,81.5,185.4952},
{1405.3,-808.6,79.7,185.4952},
{1404.4,-808.6,85.9,185.4952},
{1438.5,-808.6,81.5,185.4952},
{1449.7,-808.6,80.2,185.4952}
};