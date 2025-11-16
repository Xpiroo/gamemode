#include <pDefinitions>

stock getPanel(vehicleid, element)
{
	if(GetVehicleModel(vehicleid) != 0 && element > 0 && element < 3)
	{
	    new part[4];
	    new str[30];
	    new strtemp[30];
	    new length;
	    new status;
	    GetVehicleDamageStatus(vehicleid,part[0],part[1],part[2],part[3]);
	    format(str,sizeof(str),"%b",part[0]);
	    length = strlen(str);
	    strcat(strtemp,str);
	    if(length != 26)
	    {
			if(length != 25)
			{
	        	length = 26 - length;
	    		new length2 = 26 - length;

	    		for(new i = 0; i < length; i++)
	    		{
     				str[i] = '0';
     				strdel(str,length,length2);
      			}
				strins(str,strtemp,length);
			}
	    }
	    strdel(strtemp,0,26);
	    strcat(strtemp,str);


	   	if(element == FRONT_PANEL)
		{
		    strdel(str,0,3); //Begin Removed
		    strdel(str,3,26);
		    if(strcmp(str,"110",true) == 0 || strcmp(str,"011",true) == 0)
		        return REMOVED; //End Removed

			strdel(str,0,26); //Begin Damaged
			strcat(str,strtemp);
			new length3 = strlen(str);
			strdel(str,0,4);
			strdel(str,2,26);
  			if(strcmp(str,"10",true) == 0 && length3 == 25 || strcmp(str,"01",true) == 0 && length3 == 26)
			    return DAMAGED; //End Damaged

			if(strcmp(str,"01",true) == 0 && length3 == 25 || strcmp(str,"10",true) == 0 && length3 == 26) //Begin Shaked
			    return SHAKED;

			strdel(str,0,26);
			strcat(str,strtemp);
			strdel(str,6,26);
			if(strcmp(str,"100100",true) == 0)
			    return SHAKED; //End shaked

		}
	   	else if(element == BACK_PANEL)
		{
			strdel(str,3,26);
			if(strcmp(str,IN_BACK_PANEL_DAMAGED,true) == 0 && str[25] == '\0')
				status = DAMAGED;

		    else if(strcmp(str,IN_BACK_PANEL_DAMAGED,true) == 0)
				status = SHAKED;

		    else if(strcmp(str,IN_BACK_PANEL_REMOVED,true) == 0)
		        status = REMOVED;

		    else if(strcmp(str,IN_BACK_PANEL_FULL,true) == 0)
		        status = FULL;
	   	}
	   	return status;
	}
	return -1;
}

stock setPanel(vehicleid, element, status)
{
	if(GetVehicleModel(vehicleid) != 0 && element > 0 && element < 3 && status > -1 && status < 6)
	{
		new panel[2];
		new tmp[2][30];
		panel[0] = getPanel(vehicleid,FRONT_PANEL);
		panel[1] = getPanel(vehicleid,BACK_PANEL);

		if(element == FRONT_PANEL)
			panel[0] = status;

		else if(element == BACK_PANEL)
	  	   panel[1] = status;

		if(panel[0] == FULL) //FRONT
     		tmp[0] = IN_FRONT_PANEL_FULL;


 		if(panel[1] == FULL) //BACK
 			tmp[1] = IN_BACK_PANEL_FULL;

 		else if(panel[1] == DAMAGED || panel[1] == SHAKED)
 	 	   tmp[1] = IN_BACK_PANEL_DAMAGED;

    	else if(panel[1] == REMOVED)
  			tmp[1] = IN_BACK_PANEL_REMOVED;

 		new str[30];
 		new part[4];
 		GetVehicleDamageStatus(vehicleid,part[0],part[1],part[2],part[3]);

		if(element == FRONT_PANEL)
 		{
 	    	if(panel[0] == FULL)
 	    	{
 	     		format(str,sizeof(str),"%s%s",tmp[1],tmp[0]);
 	     		if(panel[1] == DAMAGED)
 	     	   	 	str[25] = '\0';
 	        	UpdateVehicleDamageStatus(vehicleid,0,0,0,0);
 	    	}
 	    	else if(panel[0] == DAMAGED)
 	    	{
 	        	if(panel[1] == FULL)
      	   			format(str,sizeof(str),"%s%s",IN_BACK_PANEL_FULL,"100000000000000010000");
 	        	else if(panel[1] == DAMAGED)
 	            	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"0100000000000000000000");
 	       	    else if(panel[1] == SHAKED || panel[1] == REMOVED)
 	            	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"00100000000000000010000");
 	    	}
 	    	else if(panel[0] == SHAKED)
 	    	{
				if(panel[1] == FULL || panel[1] == DAMAGED)
			    	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_FULL,"1000000000000000100000");
				else if(panel[1] == SHAKED)
			    	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"01000000000000000100000");
				else if(panel[1] == REMOVED)
			    	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"01000000000000000000010");
   			}
   			else if(panel[0] == REMOVED)
			{
			    if(panel[1] == FULL)
		        	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_FULL,"1100000000000000100010");
				else if(panel[1] == DAMAGED)
			    	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"1100110000000000110010");
				else if(panel[1] == SHAKED)
			    	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"01100100000000000100000");
				else if(panel[1] == REMOVED)
			    	format(str,sizeof(str),"%s%s",IN_BACK_PANEL_REMOVED,"01100110000000000110011");
			}
 		}
 		else if(element == BACK_PANEL)
 		{
 	    	if(panel[1] == FULL)
 	    	{
				if(panel[0] == FULL)
				    str = "0";
				else if(panel[0] == DAMAGED)
				   format(str,sizeof(str),"%s%s",IN_BACK_PANEL_FULL,"100000000000000010000");
				else if(panel[0] == SHAKED)
				    format(str,sizeof(str),"%s%s",IN_BACK_PANEL_FULL,"1000010000000000000001");
				else if(panel[0] == REMOVED)
				    format(str,sizeof(str),"%s%s",IN_BACK_PANEL_FULL,"1100100000000000110000");
				   
                UpdateVehicleDamageStatus(vehicleid,0,0,0,0);
 	    	}
 	    	else if(panel[1] == DAMAGED)
 	    	{
 	    	    if(panel[0] == FULL)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"0000000000000000000000");
 	    	    else if(panel[0] == DAMAGED)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"0100000000000000000000");
 	    	    else if(panel[0] == SHAKED)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"1000000000000000010000");
 	    	    else if(panel[0] == REMOVED)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"1100010000000000100010");
 	    	}
 	    	else if(panel[1] == SHAKED)
 	    	{
 	    	    if(panel[0] == FULL)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"00000000000000000000000");
 	    	    else if(panel[0] == DAMAGED)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"00100000000000000010000");
 	    	    else if(panel[0] == SHAKED)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"01000000000000000100000");
 	    	    else if(panel[0] == REMOVED)
 	    	        format(str,sizeof(str),"%s%s",IN_BACK_PANEL_DAMAGED,"01100010000000000000010");
 	    	}
 	    	else if(panel[1] == REMOVED)
			{
			    if(panel[0] == FULL)
                    format(str,sizeof(str),"%s%s",IN_BACK_PANEL_REMOVED,"00000000000000000000000");
                else if(panel[0] == DAMAGED)
                    format(str,sizeof(str),"%s%s",IN_BACK_PANEL_REMOVED,"00100000000000000000001");
                else if(panel[0] == SHAKED)
                    format(str,sizeof(str),"%s%s",IN_BACK_PANEL_REMOVED,"01000000000000000100000");
                else if(panel[0] == REMOVED)
                    format(str,sizeof(str),"%s%s",IN_BACK_PANEL_REMOVED,"01100000000000000100000");
			}
 		}
 		new val = BinToDec(str);
 		UpdateVehicleDamageStatus(vehicleid,val,part[1],part[2],part[3]);
 	}
}