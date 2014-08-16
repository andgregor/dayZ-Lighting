/*
	DayZ Epoch Lighting System - Light Init
	Made for DayZ Epoch by axeman please ask permission to use/edit/distribute email gregory.andrew@gmail.com.

*/

if(!isDedicated)then{
	private ["_plyPos","_sunrise","_slpTime","_lpRange","_hsRange","_nrGen","_genCount","_genClass","_doLight","_fnHr","_stHr","_plyr","_trgRng","_rngPlyr","_lightTrig","_lmpCol","_houseNum","_noStreetLights"];

	if(isNil"DZE_LightChance")then{DZE_LightChance=0};
	if(isNil"DZE_RequireGenerator")then{DZE_RequireGenerator=false};
	if(isNil"DZE_StreetLights")then{DZE_StreetLights=false};
	if(isNil"DZE_HouseLights")then{DZE_HouseLights=true};
	if(isNil"DZE_TowerLights")then{DZE_TowerLights=true};
	
	
	if(DZE_LightChance<1)exitWith{};//EXIT
	_trgRng = 280;//Distance from Gen
	_rngPlyr = 480;//Distance from Player
	_lmpCol = [0.698, 0.556, 0.419];//Light colour
	_genClass = "Generator_DZ";
	_slpTime = 6;
	_doLight = true;
	_nrGen = [];
	_genCount = 0;
	_hsRange = 250;//set var
	_houseNum = 0;//Monitor house numbers in range.. Pass around and reduce range if too many and/or client lag (NOT server / client lag)
	_lightTrig = vehicle player;//Central point around which to run the lights
	_plyPos = [0,0,0];
	call compile preprocessFileLineNumbers "lights\fn_lightFunctions.sqf";
	axeTowerLights = compile preprocessFileLineNumbers "lights\local_lights_tower.sqf";
	axeHouseLights = compile preprocessFileLineNumbers "lights\local_lights_house.sqf";
	axeTowerLightsOff = compile preprocessFileLineNumbers "lights\local_lights_tower_off.sqf";
	axeHouseLightsOff = compile preprocessFileLineNumbers "lights\local_lights_house_off.sqf";

	waitUntil {getPos Player select 0 > 0};

	//Detect Dusk and Dawn
	_sunrise = call world_sunRise;
	_fnHr =  _sunrise + 0.5;
	_stHr =  (24 - _sunrise) - 0.5;
	if(DZE_LightChance>75)then{DZE_LightChance=75;};//Max allowed
	//axeDiagLog = format["IL:LIGHTS STARTED: _stHr:%1 | _fnHr:%2 | time:%3 | for:%4",_stHr,_fnHr, dayTime, vehicle player];
	//publicVariable "axeDiagLog";
				
	while {alive player}do{
		if(daytime<_fnHr||daytime>_stHr)then{
		_plyr = vehicle player;
			//if(_plyPos distance _plyr > 6)then{//Only run if player moves
			_lightTrig = _plyr;
			
			if(DZE_RequireGenerator)then{
			_nrGen = nearestObjects [_plyr, [_genClass], _rngPlyr];
			_genCount = count _nrGen;
			
			//Set Generator to use and Assign trigger object
			
				if(_genCount>0)then{
					{
						if(_x getVariable["GeneratorRunning",false])exitWith{
						_lightTrig = _x;
						};
					}forEach _nrGen;
				};
			};
			
			//if(!DZE_RequireGenerator)then{_lightTrig = _plyr;};
			
			//Nearby Generator ?
			if(DZE_RequireGenerator && _genCount<1)then{_doLight = false;}else{_doLight=true;};
			
			//Generator not required !
			if(!DZE_RequireGenerator)then{_doLight = true;};
			
			//Choose range, player or generator
			if(DZE_RequireGenerator)then{_hsRange = _trgRng;}else{_hsRange = _rngPlyr;};
			
			//100% chance of lights with nearby generator - ToDo, make this slightly lower.
			if(DZE_RequireGenerator && _genCount>0&&(_lightTrig getVariable["GeneratorRunning",false]))then{
			DZE_LightChance = 75;
			};
			
			if(DZE_RequireGenerator && !(_lightTrig getVariable["GeneratorRunning",false]))then{_doLight = false;};//Final check - Not run if nearest gen isn't running
			
			//axeDiagLog = format["IL:RUNNING: _doLight:%1 | DZE_RequireGenerator:%2 | _lightTrig:%3 | DZE_LightChance:%4",_doLight,DZE_RequireGenerator,_lightTrig,DZE_LightChance];
			//publicVariable "axeDiagLog";
					
					if(_doLight)then{
						//if(speed _plyr > 0 )then{
						if(DZE_HouseLights)then{
						//axeDiagLog = format["IL:RUNNING HOUSE: _doLight:%1 | DZE_RequireGenerator:%2 | _lightTrig:%3 | DZE_LightChance:%4",_doLight,DZE_RequireGenerator,_lightTrig,DZE_LightChance];
						//publicVariable "axeDiagLog";
						_houseNum = [_hsRange,_lightTrig,DZE_LightChance,_lmpCol,_plyr,_houseNum] call axeHouseLights;
						};
						//};
						if(DZE_TowerLights)then{
						//axeDiagLog = format["IL:RUNNING TOWER: _doLight:%1 | DZE_RequireGenerator:%2 | _lightTrig:%3 | DZE_LightChance:%4",_doLight,DZE_RequireGenerator,_lightTrig,DZE_LightChance];
						//publicVariable "axeDiagLog";
						[_rngPlyr,_lightTrig,DZE_LightChance] call axeTowerLights;
						};					
					}else{
						if(DZE_HouseLights)then{//House lights off
						[_hsRange,_lightTrig,DZE_LightChance,_lmpCol,_plyr,_houseNum] call axeHouseLightsOff;
						};
						
						if(DZE_TowerLights)then{//Tower lights off
						[_rngPlyr,_lightTrig,DZE_LightChance] call axeTowerLightsOff;
						};
					};
					
					if(!DZE_StreetLights)then{
					[player,_hsRange] call axe_NoStreetLights
					};
			//};
		_plyPos = getPos player;
		};	
	sleep _slpTime;
	};
};
