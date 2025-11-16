/**
 *
	* Carlton's MapIcon Streamer.
	*
	* @Author - Carlton
	* @Copyright - 2010
	* @Contact - Carltonr88@gmail.com | MSN & EMAIL
	*
	*   Functions
	*   native CreateStreamedMapIcon(playerid, icon, Float: x, Float: y, Float: z, markertype, color, Float:distance);
	*   native RemoveStreamedMapIcon(playerid, icon);
	*   native MoveStreamedMapIcon(icon, Float: x, Float: y, Float: z);
	*   native ChangeDistanceOfStreamedMapIcon(icon, Float: distance);
	*   native ChangeStreamMapIconColor(icon, color);
	*   native ChangeStreamMapIconMarkerType(icon, markertype);
	*   native MapStreamer_OnPlayerConnect(playerid);
	*   native MapStreamer_OnPlayerDisconnect(playerid);
	*   native GetStreamedMapIconMarkerType(icon);
	*   native GetStreamedMapIconColor(icon);
	*   native ReloadPlayerStream(playerid);
	*   native CountStreamedMapIcons();
	*   native IsAValidStreamedMapIcon(icon);
	*   native DestroyAllStreamedMapIcons();
	*   native EnableAllStreamedMapIcons();
	*   native DisableAllStreamedMapIcons();
 *
*/

stock DisableAllStreamedMapIcons() {
    CallRemoteFunction("DisableAllStreamedMapIcons", "");
}

stock EnableAllStreamedMapIcons() {
    CallRemoteFunction("EnableAllStreamedMapIcons", "");
}

stock DestroyAllStreamedMapIcons() {
    CallRemoteFunction("DestroyAllStreamedMapIcons", "");
}

stock IsAValidStreamedMapIcon(icon) {
    CallRemoteFunction("IsAValidStreamedMapIcon", "i", icon);
}

stock CountStreamedMapIcons() {
    CallRemoteFunction("CountStreamedMapIcons", "");
}

stock ReloadPlayerStream() {
    CallRemoteFunction("ReloadPlayerStream", "");
}

stock GetStreamedMapIconColor(icon) {
    CallRemoteFunction("GetStreamedMapIconColor", "i", icon);
}

stock GetStreamedMapIconMarkerType(icon) {
    CallRemoteFunction("GetStreamedMapIconMarkerType", "i", icon);
}

stock MapStreamer_OnPlayerConnect(playerid) {
    CallRemoteFunction("MapStreamer_OnPlayerConnect", "i", playerid);
}

stock MapStreamer_OnPlayerDisconnect(playerid) {
    CallRemoteFunction("MapStreamer_OnPlayerDisconnect", "i", playerid);
}

stock CreateStreamedMapIcon(playerid, icon, Float: x, Float: y, Float: z, markertype, color, Float: distance) {
    CallRemoteFunction("CreateStreamedMapIcon", "iifffiif", playerid, icon, Float: x, Float: y, Float: z, markertype, color, Float:distance);
}

stock MoveStreamedMapIcon(icon, Float: x, Float: y, Float: z) {
    CallRemoteFunction("MoveStreamedMapIcon", "ifff", icon, Float: x, Float: y, Float: z);
}

stock RemoveStreamedMapIcon(playerid,icon) {
    CallRemoteFunction("RemoveStreamedMapIcon", "ii", playerid,icon);
}

stock ChangeDistanceOfStreamedMapIcon(icon, Float: distance) {
    CallRemoteFunction("ChangeDistanceOfStreamedMapIcon", "if", icon, distance);
}

stock ChangeStreamMapIconColor(icon, color) {
    CallRemoteFunction("ChangeStreamMapIconColor", "ii", icon, color);
}

stock ChangeStreamMapIconMarkerType(icon, markertype) {
    CallRemoteFunction("ChangeStreamMapIconMarkerType", "ii", icon, markertype);
}
