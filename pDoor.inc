#include <pDefinitions>

stock getDoor(vehicleid, element)
{
	if(GetVehicleModel(vehicleid) != 0 && element > 0 && element < 5)
	{
	new part[4];
	new str[50];
	new temp[10];
	new strtemp[50];
	new length;
	GetVehicleDamageStatus(vehicleid,part[0],part[1],part[2],part[3]);
	
	format(str,sizeof(str),"%b",part[1]);
	length = strlen(str);
	strcat(strtemp,str);
	if(length != 31 || str[0] == '0')
	{
	    length = 32 - length;
	    new length2 = 32 - length;

	    for(new i = 0; i < length; i++)
	    {
     		str[i] = '0';
     		strdel(str,length,length2);
        }
		strins(str,strtemp,length);
	}

	if(element == HOOD)
	    strmid(temp,str,24,32,9);
	    
    else if(element == TRUNK)
	    strmid(temp,str,16,24,9);
        
    else if(element == LEFT_DOOR)
        strmid(temp,str,8,16,9);
        
    else if(element == RIGHT_DOOR)
        strmid(temp,str,0,8,9);
        
    if(strcmp(temp,IN_FULL,true) == 0)
		return FULL;
		
	else if(strcmp(temp,IN_OPENED,true) == 0)
	   	return OPENED;
	    
	else if(strcmp(temp,IN_DAMAGED,true) == 0)
	    return DAMAGED;
	    
	else if(strcmp(temp,IN_OPENED_DAMAGED,true) == 0)
		return OPENED_DAMAGED;
	    
	else if(strcmp(temp,IN_REMOVED,true) == 0)
		return REMOVED;
	}
	    
	return -1;
}

stock setDoor(vehicleid, element, status)
{
	if(GetVehicleModel(vehicleid) != 0 && element > 0 && element < 5 && status > - 1 && status < 5)
	{
	new str[50];
	new tmp[4][30];
	new door[4];
	door[0] = getDoor(vehicleid,HOOD);
	door[1] = getDoor(vehicleid,TRUNK);
	door[2] = getDoor(vehicleid,LEFT_DOOR);
	door[3] = getDoor(vehicleid,RIGHT_DOOR);
	
	if(element == HOOD)
	    door[0] = status;

	else if(element == TRUNK)
		door[1] = status;
		
	else if(element == LEFT_DOOR)
	    door[2] = status;
	    
	else if(element == RIGHT_DOOR)
	    door[3] = status;
	
	for(new i = 0; i < 4; i++)
	{
	    if(door[i] == FULL)
	    {
            tmp[i] = IN_FULL;
     	}

		else if(door[i] == OPENED)
		{
		    tmp[i] = IN_OPENED;
	  	}
		    
		else if(door[i] == DAMAGED)
		{
		    tmp[i] = IN_DAMAGED;
		}
		    
		else if(door[i] == OPENED_DAMAGED)
		{
		    tmp[i] = IN_OPENED_DAMAGED;
  		}
		    
		else if(door[i] == REMOVED)
		{
		    tmp[i] = IN_REMOVED;
  		}
	}
	format(str,sizeof(str),"%s%s%s%s",tmp[3],tmp[2],tmp[1],tmp[0]);
	new val = BinToDec(str);
	new part[4];
	GetVehicleDamageStatus(vehicleid,part[0],part[1],part[2],part[3]);
	UpdateVehicleDamageStatus(vehicleid,part[0],val,part[2],part[3]);
	}
}