/* 
    _/  _/_/_/    _/_/_/          _/_/_/ _/_/_/   _/  _/
       _/    _/  _/    _/        _/     _/    _/ _/ _/
  _/  _/_/_/    _/_/_/          _/_/_/ _/    _/ _/_/
 _/  _/    _/  _/                  _/ _/    _/ _/  _/
_/  _/    _/  _/              _/_/_/ _/_/_/   _/    _/
   Inter Role Play Source Development Kit (v1.0 R1)
*/


#if defined irpsdk_loaded
  #endinput
#endif
#define irpsdk_loaded

#include <a_samp>


#define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#define foreach(%2,%1) \
        for (new %2 = 0; %2 < %1; %2++)

// Max
#undef MAX_PLAYERS
#undef MAX_VEHICLES
#define MAX_PLAYERS          350
#define MAX_VEHICLES         400
#define MAX_DB_VEHICLES      400
#define MAX_DOORS            200
#define MAX_ITEMS            1000  
#define MAX_ANIMATIONS       200
#define MAX_ORGANISATIONS    20
#define MAX_BUSINESS         50

// Kolory
#define BEZOWY        0xFFFFADAA
#define BIALY         0xFFFFFFFF
#define BLEKITNY      0x33CCFFFF
#define BORDOWY       0x99001FFF
#define BRAZOWY       0x997A00FF
#define DARK_ZIELONY  0x336633FF
#define CZARNY        0x000000FF
#define CZERWONY      0xFF0000FF
#define FIOLETOWY     0xC2A2DAFF
#define FIOLETOWY2    0xE0EA64FF
#define NIEBIESKI     0x0000FFFF
#define POMARANCZOWY  0xFF8000FF
#define ROZOWY        0xFF66CCFF
#define SZARY         0xB0B0B0FF
#define ZIELONY       0x00CC00FF
#define ZOLTY         0xFFFF00FF
#define CZERWONY      0xFF0000FF
#define LCZERWONY     0xFF6347FF

#define COLOR_INFO    0xFFFFFFFF
#define COLOR_ERROR   0xAE0000FF
#define COLOR_WARNING 0xEDB50CFF
#define COLOR_SUCCESS 0x00D700FF

#define COLOR_SENTW   0xFFC973FF
#define COLOR_REVIW   0xFDAE33FF

// Dialogs
#define DIALOG_CORE_END 1000

// Owners
#define OWNER_NONE         0
#define OWNER_PLAYER       1
#define OWNER_ORGANISATION 2
#define OWNER_BUSINESS     3
#define OWNER_WORK         4
#define OWNER_ADMIN        5
#define OWNER_HOUSE        6

// Typy ofert
#define OFFER_ITEM      1
#define OFFER_VEHICLE   2
#define OFFER_INTERVIEW 3
#define OFFER_LICENSE   4
#define OFFER_MANDATE   6
#define OFFER_REPAIR    7
#define OFFER_ISSUING   8
#define OFFER_PAY       9
#define OFFER_AD        10
#define OFFER_NEWVEH    11
#define OFFER_LICENCE   12
#define OFFER_GAS       13
#define OFFER_FOOD      14
#define OFFER_PRODUCT   15

// Miejsce przedmiotow
#define PLACE_NONE              0
#define PLACE_PLAYER            1
#define PLACE_VEHICLE           2
#define PLACE_HOUSE             3

// Typy organizacji
#define ORGANISATION_PD         1
#define ORGANISATION_ERS        2
#define ORGANISATION_GOV        3
#define ORGANISATION_CRIME      4
#define ORGANISATION_NEWS       5
#define ORGANISATION_WEAPONS    5
#define ORGANISATION_WEATHER    6
#define ORGANISATION_FIRE       7

// Typy biznesów
#define BUSINESS_NONE		    0
#define BUSINESS_GASTRONOMY     1
#define BUSINESS_CARDEALER      2
#define BUSINESS_GASSTATION     3
#define BUSINESS_WORKSHOP       4
#define BUSINESS_SHOP           5
#define BUSINESS_TRANS          6

// Typy przedmiotów
#define ITEM_NONE        0 // bez funkcji
#define ITEM_WEAPON      1 // bronie        (val1 = model, val2 = ammo)
#define ITEM_PHONE       2 // telefon       (val1 = numer, val2 = flagi)
#define ITEM_RADIO       3 // radio         (val1 = ostatni kanal)
#define ITEM_WATCH       4 // zegarek       
#define ITEM_KANISTER    5 // kanister      (val1 = ilosc paliwa, val2 = rodzaj)
#define ITEM_BALL        6 // pilka do nogi 
#define ITEM_CUBE        7 // kostka do gry 
#define ITEM_CIGGY       8 // fajki         (val1 = iloœæ)
#define ITEM_LICENSE     9 // licencje      (val1 = uid gracza, którego jest licencja, val2 = rodzaj licencji)
#define ITEM_SKATE      10 // rolki         
#define ITEM_AMMO       11 // amunicja      (val1 = model broni do ktorej jest ammo, val2 = ilosc do dodania przy uzyciu) 
#define ITEM_FOOD       12 // jedzenie      (val1 = hp ile daje, val2 = iloœæ)
#define ITEM_BANDANA    13 // bandana       
#define ITEM_CLOTH      14 // ubranie       (val1 - id skina)
#define ITEM_TUNING     15 // tuning        (val1 - id komponentu, !dzia³a po od³o¿eniu do pojazu)
#define ITEM_PAINT      16 // lakier        (val1 - kolor #1, val2 - kolor #2)
#define ITEM_CONTAINER  17 // kontener      (val1 - pojemnoœæ w gramach)
#define ITEM_MEGAFONE   18 // megafon       
#define ITEM_BEER       19 // piwo/wino     (val1 = hp ile daje, val2 = iloœæ)
#define ITEM_HANDCUFFS  20 // kajdanki      
#define ITEM_ARMOR		21 // kamizelka     (val1 = iloœæ armoru)
#define ITEM_AUDIO      22 // audio         (przyjmuje wartosci tylko na czas odtwarzania)

// Typy produktów
#define PRODUCT_ITEM    1
#define PRODUCT_VEHICLE 2

// Zapis gracza
#define SAVE_BASIC        1
#define SAVE_ORG          2
#define SAVE_BIZ          4
#define SAVE_TIME         8
#define SAVE_BLOCKS      16
#define SAVE_ONLINE      32
#define SAVE_BANK        64
#define SAVE_AJBW       128
#define SAVE_POS        256
#define SAVE_HOTEL      512
#define SAVE_LASTPAY   1024
#define SAVE_HOUSE     2048

stock string[128];
// Players on-server cache
enum ePlayer
{
	// sql things
	pUID,
	pName[MAX_PLAYER_NAME],
	pGlobname[32],
	pAdmin,
	pGlobalAcc,
	pSkin,
	Float:pHP,
	pCash,
	pCapacity,
	pAge,
	pSex,
	pBlock,
	
	pOrg,
	pOrgRank,
	pOrgTitle[32],
	pOrgPay,
	
	pBiz,
	pBizRank,
	pBizTitle[32],
	pBizPay,
	
	pMinutes,
	
	pBankCash,
	pBankNr,
	
	pAJ,
	pBW,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	pInterior,
	pVW,
	
	pHotel, 		// identyfikator hotelu
	pHotelLock,		// 1/0

	pHouse,
	pRentHouse,
}
stock Cache:PlayerData[MAX_PLAYERS][ePlayer];

// Vehicles on-server
enum eCar
{
	vehUID, // vehicle UID lub INVALID_VEHICLE_ID
	vehLights,
	vehEngine
}
stock Cache:VehicleData[MAX_VEHICLES][eCar];

// Vehicles cached
enum eVehicles
{
	vUID,
	vModel,
	Float:vX,
	Float:vY,
	Float:vZ,
	Float:vAngle,
	vColor1,
	vColor2,
	vOwnerType,
	vOwner,
	vLock,
	Float:vFuel,
	vFuelType,
	vDistance,
	Float:vHP,
	vTow
}
stock Cache:DbVehicles[MAX_DB_VEHICLES][eVehicles];

enum eDoors
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

	Float:dExitX,
	Float:dExitY,
	Float:dExitZ,
	Float:dExitAng,
	dExitInt,
	dExitVw,

	dLock,
	dPickupID,
	dName[32],
	dGarage
}
stock Cache:DoorData[MAX_DOORS][eDoors];

enum eItems
{
	iUID,
	iType,
	iName[32],
	iOwner,
	iValue1,
	iValue2,
	iPlace,
	Float:iPosX,
	Float:iPosY,
	Float:iPosZ,
	iWeight,
	iUsed,
	iReserved,
	iBelongTo,
	iVW,
	Text3D:i3DText
}
stock Cache:ItemData[MAX_ITEMS][eItems];

enum oInfo
{
	oUID,
	oName[32],
	oType,
	oCash,
	oRankDriver,
	oRankDoor,
	oRankOffer,
	oGovPay,
	oTogChat
}
stock Cache:OrgData[MAX_ORGANISATIONS][oInfo];

enum bInfo
{
	bUID,
	bName[32],
	bType,
	bCash,
	bRankDriver,
	bRankDoor,
	bRankOffer,
	bGovPay,
	bTogChat
}
stock Cache:BizData[MAX_BUSINESS][bInfo];


stock Logged[MAX_PLAYERS];

// fff
native SendClientMessageFormat(playerid, color, const format[], {Float,_}:...);
native SendClientMessageToAllFormat(color, const format[], {Float,_}:...);
native SendPlayerInfoDialog(playerid, const title[], const format[]);
native SendPlayerInfoDialogFormat(playerid, const title[], const format[], {Float,_}:...);

// yo
native md5(str[]);
native time();
native wordwrap(givenString[]);

// mySQL
stock MySQL:irp = 0;
native mysql_check(MySQL:handle = (MySQL:0)); 
native MySQL:mysql_connect(const host[], const user[], const pass[], const db[], auto_reconnect = 0);
native mysql_log(logtype, windowerrors = (1), MySQL:handle = (MySQL:0));
native mysql_close(MySQL:handle = (MySQL:0));
native mysql_reload(MySQL:handle = (MySQL:0));
native mysql_select_db(const db[], MySQL:handle = (MySQL:0));
native mysql_query(const query[], resultid = (-1), spareid = (0), MySQL:handle = (MySQL:0));
native mysql_query_array(const query[], resultid = (-1), {Float,_}:extravars[], MySQL:handle = (MySQL:0));
native mysql_store_result(MySQL:handle = (MySQL:0));
native mysql_free_result(MySQL:handle = (MySQL:0));
native mysql_result_stored(MySQL:handle = (MySQL:0));
native mysql_fetch_field(const fieldname[], dest[], MySQL:handle = (MySQL:0));
native mysql_fetch_field_num(fieldnum, dest[], MySQL:handle = (MySQL:0));
native mysql_fetch_row(dest[], const splitter[] = "|", MySQL:handle = (MySQL:0));
native mysql_fetch_row_data(MySQL:handle = (MySQL:0));
native mysql_real_escape_string(const string[], dest[], MySQL:handle = (MySQL:0));
native mysql_num_rows(MySQL:handle = (MySQL:0));
native mysql_num_fields(MySQL:handle = (MySQL:0));
native mysql_affected_rows(MySQL:handle = (MySQL:0));
native mysql_insert_id(MySQL:handle = (MySQL:0));
native mysql_ping(MySQL:handle = (MySQL:0));
native mysql_error(dest[], MySQL:handle = (MySQL:0));
native mysql_errno(MySQL:handle = (MySQL:0));
native mysql_warning_count(MySQL:handle = (MySQL:0));
native mysql_info(dest[], MySQL:handle = (MySQL:0));
native mysql_stat(dest[], MySQL:handle = (MySQL:0));
native mysql_get_server_info(dest[], MySQL:handle = (MySQL:0));
native mysql_get_host_info(dest[], MySQL:handle = (MySQL:0));
native mysql_data_seek(rownum, MySQL:handle = (MySQL:0));
native mysql_set_character_set(const csname[], MySQL:handle = (MySQL:0));
native mysql_fetch_int(MySQL:handle = (MySQL:0));
native Float:mysql_fetch_float(MySQL:handle = (MySQL:0));
native mysql_fetch_string(dest[], MySQL:handle = (MySQL:0));

// nickname
native PlayerName(playerid); //return: Player_Name
native PlayerName2(playerid); //return: Player Name
native GetPlayerSQLName(playeruid); // return: Player_Name from DB
native GetPlayerSQLName2(playeruid); // return: Player Name from DB
native GetPlayerID(playeruid); // return: playerid

// positions
native PlayerToPlayer(playerid, destid, Float:radius);
native PlayerToVehicle(playerid, vehicleid, Float:radi);
native GetXYBehindPlayer(playerid, &Float:q, &Float:w, Float:distance);
native GetXYInFrontOfPlayer(playerid, &Float:q, &Float:w, Float:distance);
native IsPlayerInArea(playerid, Float:max_x, Float:min_x, Float:max_y, Float:min_y);

// itemid jest indeksem w tablicy ItemData, itemuid jest identyfikatorem przedmiotu w bazie.
native GetItemID(itemuid);
native GetItemUID(itemid);
native GivePlayerItem(playerid, name[], type, value1, value2, weighta);
native HavePlayerWeapon(playerid, weaponid);
native GetPlayerWeaponAmmo(playerid, weaponid);
native GetPlayerUseWeapon(playerid); // return: item id (not item uid)
native GetPlayerUseWeaponUID(playerid); // return: item uid 
native GetPlayerItemTypeCount(playerid, itemtype);
native GetPlayerItemTypeUID(playerid, itemtype);
native GetVehicleItemTypeUID(vehicleuid, itemtype);
native ListPlayerItems(playerid, ownerid, type, button[32]);
native ListContainerItems(playerid, container_uid, type, with_this);
native ListVehicleItems(playerid, vehicleid);
native ListNearItems(playerid, Float:radious, me);
native GetContainerWeight(container_uid);
native GetCurrentCapacity(playerid);
native GetItemRoot(uid);
native GetItemTypeName(type);

native SetWeaponAmmo(playerid, weaponid, ammo);
native RemovePlayerWeapon(playerid, weaponid);

native AddItem(type, name[], owner, value1, value2, place, Float:posx, Float:posy, Float:posz, vehid, houseid, reserved, belongto, weight);
native AddVehicle(model, Float:x, Float:y, Float:z, Float:angle, color1, color2, ownertype, owner, fueltype);
native AddRadioStation(OwnerType, Owner, Password[], Canal);
native AddOrder(Type, ItemType, Value1, Value2, Price, Weight, OwnerType, Owner, Number, Name[]);
native AddProduct(Type, ItemType, OwnerType, Owner, Value1, Value2, Weight, Name[], Number, Price);
native AddProductInfo(Type, ItemType, Value1, Value2, Price, Weight, OrgType, BizType, Name[]);

native SaveOrganisation(uid);
native SaveBusiness(uid);
native SaveDoors(uid);
native SavePos(uid);
native SaveItem(itemuid);
native SaveVehicle(vehicleuid);
native SaveObject(uid);
native SaveRadioStation(radioid);
native SaveOrder(orderid);
native SaveProduct(productid);
native SaveProductInfo(productid);

native DeleteDoors(itemid);
native DeleteTask(taskid);
native DeleteItem(itemuid);
native DeleteVehicle(vehicleuid);
native DeleteOrder(orderid);
native DeleteProduct(productid);

native SendPlayerText(Float:radi, playerid, string2[], col1, col2, col3, col4, col5);
native SendClientMessageToAdmins(color, string1[]);
native SendClientMessageToBussinesType(type, text[]);
native SendClientMessageToGMs(color, string1[]);
native ClearClientChat(playerid);

// vehicleid jest indeksem w tablicy VehicleData,
// vehicleuid jest indeksem w tablicy DbVehicles
native GetVehicleID(vehicleuid);
native GetVehicleUID(vehicleid);
native iRP_CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay);
native CreateVehicleFromDB(uid);
native GetVehicleMaxFuel(model);
native IsAnyPlayerInVehicle(vehicleid);
native GetVehicleDriver(vehicleid);
native GetVehicleSpeed(vehicleid);
native GetClosestVehicle(playerid, Float:Distance2 = 100.0);
native GetDistanceToVehicle(playerid, vehicleid);
native GetVehicleModelName(modelid);
native GetVehicleName(vehicleid);

native GetPlayerDoor(playerid);
native GetPlayerEnterDoor(playerid);

native OnPlayerSave(playerid, what); // mo¿na u¿ywaæ kombinacji definicji z prefiksem SAVE_ np. OnPlayerSave(playerid, SAVE_BASIC | SAVE_BIZ);
native iRP_GivePlayerMoney(playerid, cash);

native RegisterCommand(cmd[32]); // W OnPluginInit
native RegisterPlugin(pluginid, name[32]); // W OnPluginInit
native RegisterPluginAuthor(pluginid, author[32]); // W OnPluginInit
native IsPluginAlive(pluginid);

// sscanf
native sscanf(const data[], const format[], {Float,_}:...);
native unformat(const data[], const format[], {Float,_}:...) = sscanf;