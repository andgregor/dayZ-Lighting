	if (isServer) then {
	axe_server_log = compile preprocessFileLineNumbers "tools\logtorpt.sqf";
	"axeDiagLog" addPublicVariableEventHandler {_id = (_this select 1) spawn axe_server_log};
	};
	
	if (!isDedicated) then {
	//Lights
	[false,12] execVM "lights\local_lights_init.sqf";//[REQUIRE GENERATOR (true/false),Light Chance %]
	};
