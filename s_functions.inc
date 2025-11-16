#if defined s_functions_included
  #endinput
#endif

#define s_functions_included

stock MyIsNumeric(String[])
{
	new Length = strlen(String);

	if (Length == 0)
		return false;

	for (new Char = 0; Char < Length; Char++)
		if ((String[Char] > '9' || String[Char] < '0' && String[Char] != '-' && String[Char] != '+') || (String[Char] == '-' && Char != 0) || (String[Char] == '+' && Char != 0))
			return false;

	if (Length == 1 && (String[0] == '-' || String[0] == '+'))
		return false;

	return true;
}

stock MyStrCmp(StringOne[], StringTwo[])
{
	if(strlen(StringOne) != strlen(StringTwo))
	    return false;
	for(new Char = 0; Char < strlen(StringOne); Char++)
	    if(StringOne[Char] != StringTwo[Char])
	        return false;
	return true;
}

stock MyName(PlayerId)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(PlayerId, Name, sizeof(Name));
	return Name;
}