	//Used to log to server .rpt file - If you're not sure then don't add this bit
	if (isServer) then {
	axe_server_log = compile preprocessFileLineNumbers "tools\logtorpt.sqf";
	"axeDiagLog" addPublicVariableEventHandler {_id = (_this select 1) spawn axe_server_log};
	};
	
	
	//Do Add this bit:
	//Required for mission lighting system
	if (!isDedicated) then {
	//Lights
	DZE_RequireGenerator = false;
	DZE_StreetLights = false;
	DZE_HouseLights = true;
	DZE_TowerLights = true;
	DZE_LightChance = 42;
	[] execVM "lights\local_lights_init.sqf";
	};
