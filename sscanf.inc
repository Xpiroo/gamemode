#if defined sscanf_included
	#endinput
#endif
#define sscanf_included

native sscanf(const data[], const format[], {Float,_}:...);
native unformat(const data[], const format[], {Float,_}:...) = sscanf;