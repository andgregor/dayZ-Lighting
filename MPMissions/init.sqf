	//Used to log to server .rpt file - If you're not sure then don't add this bit
	if (isServer) then {
	axe_server_log = compile preprocessFileLineNumbers "tools\logtorpt.sqf";
	"axeDiagLog" addPublicVariableEventHandler {_id = (_this select 1) spawn axe_server_log};
	};
	
	
	
	
	//Do Add this bit:
	//Required for mission lighting system (Testing new lights - comment out existing light init from Epoch standard init.sqf)
	if (!isDedicated) then {
	//Lights
	[false,12] execVM "lights\local_lights_init.sqf";//[REQUIRE GENERATOR (true/false),Light Chance %]
	};
