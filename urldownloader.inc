/*
Native function(s) for urldownloader plugin 0.1

© Nubworx 2009
*/

#if defined urldownloader_included
	#endinput
#endif
#define urldownloader_included


native urldownload(url[], file[]);

#define UrlDownload(%0) urldownload(%0)
