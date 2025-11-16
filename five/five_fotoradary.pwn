AntiDeAMX();
enum _camera
{
	UID,
	Float:_x,
	Float:_y,
	Float:_z,
	Float:_rot,
	_range,
	_limit,
	_fine,
	_usemph,
	_objectid
}
new FotoInfo[MAX_FOTO][_camera],loaded_cameras = 0,Text:flash;
////////////////////////////////////////////////////////////////////////////////
forward ZaladujFotoradary();
public ZaladujFotoradary()
{
	new result[1024], uid = 0;
    format(zapyt, sizeof(zapyt), "SELECT * FROM `five_fotoradary`");
    mysql_check();
	mysql_query2(zapyt);
    mysql_store_result();
    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    //new uid;
    	//sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>dffffdddd", FotoInfo[uid][UID],
		    FotoInfo[uid][_x],
			FotoInfo[uid][_y],
			FotoInfo[uid][_z],
			FotoInfo[uid][_rot],
			FotoInfo[uid][_range],
			FotoInfo[uid][_limit],
			FotoInfo[uid][_fine],
			FotoInfo[uid][_usemph]);

		FotoInfo[uid][_objectid] = STREAMER_ADD(18880,FotoInfo[uid][_x],FotoInfo[uid][_y],FotoInfo[uid][_z],0,0,FotoInfo[uid][_rot]);
		uid++;
		loaded_cameras++;
	}
	mysql_free_result();
	//printf("Fotoradary       - %d", uid);
}
stock CreateSpeedCam(Float:x,Float:y,Float:z,Float:rot,range,limit,fine,use_mph = 0)
{
    //new newid = mysql_insert_id();
    loaded_cameras++;
	FotoInfo[loaded_cameras][_x] = x;
	FotoInfo[loaded_cameras][_y] = y;
	FotoInfo[loaded_cameras][_z] = z;
	FotoInfo[loaded_cameras][_rot] = rot;
	FotoInfo[loaded_cameras][_range] = range;
	FotoInfo[loaded_cameras][_limit] = limit;
	FotoInfo[loaded_cameras][_fine] = fine;
	FotoInfo[loaded_cameras][_usemph] = use_mph;
	FotoInfo[loaded_cameras][_objectid] = STREAMER_ADD(18880,x,y,z,0,0,rot);
	format(zapyt, sizeof(zapyt), "INSERT INTO `five_fotoradary` (`x`, `y`, `z`, `rot`, `angle`, `limit`, `grzywna`, `typ`) VALUES ('%f', '%f', '%f', '%f', '%d', '%d', '%d', '%d')",
	FotoInfo[loaded_cameras][_x], FotoInfo[loaded_cameras][_y], FotoInfo[loaded_cameras][_z], FotoInfo[loaded_cameras][_rot], FotoInfo[loaded_cameras][_range], FotoInfo[loaded_cameras][_limit], FotoInfo[loaded_cameras][_fine], FotoInfo[loaded_cameras][_usemph]);
	mysql_check();
	mysql_query2(zapyt);
	return loaded_cameras;
}
stock ZapiszFotoradary(uid)
{
	format(zapyt, sizeof(zapyt), "UPDATE `five_fotoradary` SET `x` = '%f', `y` = '%f', `z` = '%f', `rot` = '%f', `angle` = '%d', `limit` = '%d', `grzywna` = '%d', `typ` = '%d' WHERE `ID` = '%d'",
	FotoInfo[uid][_x],
	FotoInfo[uid][_y],
	FotoInfo[uid][_z],
	FotoInfo[uid][_rot],
	FotoInfo[uid][_range],
	FotoInfo[uid][_limit],
	FotoInfo[uid][_fine],
	FotoInfo[uid][_usemph],
	FotoInfo[uid][UID]);
	mysql_check();
	mysql_query2(zapyt);
	mysql_free_result();
}
stock UsunFotoradar(uid)
{
    STREAMER_REMOVE(FotoInfo[uid][_objectid]);
    new sql[100];
	format( sql, sizeof( sql ), "DELETE FROM `five_fotoradary` WHERE `ID` = %d", FotoInfo[uid][UID] );
	mysql_query( sql );
	FotoInfo[uid][UID] = 0;
	FotoInfo[uid][_x] = 0;
	FotoInfo[uid][_y] = 0;
	FotoInfo[uid][_z] = 0;
	FotoInfo[uid][_rot] = 0;
	FotoInfo[uid][_range] = 0;
	FotoInfo[uid][_limit] = 0;
	FotoInfo[uid][_fine] = 0;
	FotoInfo[uid][_usemph] = 0;
	return 1;
}
stock SetSpeedCamRange(cameraid,limit)
{
	FotoInfo[cameraid][_limit] = limit;
	return 1;
}
stock SetSpeedCamFine(cameraid,fine)
{
    FotoInfo[cameraid][_fine] = fine;
	return 1;
}
forward UpdateCameras(a);
public UpdateCameras(a)
{
	//if(!IsPlayerConnected(a)) continue;
	//if(!IsPlayerInAnyVehicle(a)) continue;
    if(GetPVarInt(a,"PlayerHasBeenFlashed") == 1)
	{
		//continue;
	} 
	else if (GetPVarInt(a,"PlayerHasBeenFlashed") == 2)
	{
		DeletePVar(a,"PlayerHasBeenFlashed");
		//continue;
	}
    for(new b = 0;b<loaded_cameras +1;b++)
    {
        if(IsPlayerInRangeOfPoint(a,FotoInfo[b][_range],FotoInfo[b][_x],FotoInfo[b][_y],FotoInfo[b][_z]))
        {
            new speed = Predkosc(a);
            new limit = FotoInfo[b][_limit];
            if(speed > limit)
            {
                TextDrawShowForPlayer(a,flash);
                #if CAMERA_PERSPECTIVE == true
                SetPlayerCameraPos(a,FotoInfo[b][_x],FotoInfo[b][_y],FotoInfo[b][_z] + 5);
                new Float:x,Float:y,Float:z;GetPlayerPos(a,x,y,z);
                SetPlayerCameraLookAt(a,x,y,z);
                #endif
                SetPVarInt(a,"PlayerHasBeenFlashed",1);
                SetTimerEx("RemoveFlash",USUNIECIE_FLASHA,false,"i",a);
				if(GetPlayerState(a) == PLAYER_STATE_DRIVER)
				{
					//new veh = GetPlayerVehicleID(a);
					//new uid = SprawdzCarUID(veh);
					//SendClientMessageEx(a,0xF88b711FF,"sisis","Zbyt szybka jazda. Masz odpa³ jazdy. ",Predkosc(a),"KM/H, w którym zosta³y dopuszczone do jazdy ",limit, "kmh.");
					new nazwadrzwi[124];
					CzasWyswietlaniaTextuNaDrzwiach[a] = 10;
					format(nazwadrzwi, sizeof(nazwadrzwi), "~b~~h~Fotoradar~w~~n~Przekroczyles dopuszczalna predkosc w tej okolicy. Jechales ~y~~h~%d~w~km/h na ~r~%d~w~km/h.", Predkosc(a), limit);
					TextDrawHideForPlayer(a, TextNaDrzwi[a]);
					TextDrawSetString(TextNaDrzwi[a], nazwadrzwi);
					TextDrawShowForPlayer(a, TextNaDrzwi[a]);
					/*if(ComparisonString(PojazdInfo[uid][pTablice], " "))
					{
					    //SendClientMessage(a,0xDEDEDEFF,"Mia³eœ szczêœcie, ¿e twój pojazd nie podiada tablic rejestracyjnych - policja w³aœcie siê o tym dowiedzia³a.");
					}else{
					    //SendClientMessage(a,0xDEDEDEFF,"Zosta³eœ w³aœcie zanotowany w bazie policyjnej.");
					}*/
							//GivePlayerMoney(a, - FotoInfo[b][_fine]);
				}
            }
        }
    }
}
forward RemoveFlash(playerid);
public RemoveFlash(playerid)
{
	TextDrawHideForPlayer(playerid,flash);
	SetPVarInt(playerid,"PlayerHasBeenFlashed",2);
	#if CAMERA_PERSPECTIVE == true
	SetCameraBehindPlayer(playerid);
	#endif
}

stock GetClosestCamera(playerid)
{
	new Float:distance = 10,Float:temp,Float:x,Float:y,Float:z,current = -1;GetPlayerPos(playerid,x,y,z);
	for(new i = 0;i<loaded_cameras +1;i++)
	{
		temp = GetDistanceBetweenPoints(x,y,FotoInfo[i][_x],FotoInfo[i][_y]);
		if(temp < distance)
		{
			distance = temp;
			current = i;
		}
	}
	return current;
}
stock GetDistanceBetweenPoints(Float:x,Float:y,Float:tx,Float:ty)
{
  new Float:temp1, Float:temp2;
  temp1 = x-tx;
  temp2 = y-ty;
  return floatround(temp1*temp1+temp2*temp2);
}
