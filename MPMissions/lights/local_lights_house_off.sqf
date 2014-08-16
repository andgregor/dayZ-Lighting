/*
	DayZ Epoch Lighting System - House Lights
	Made for DayZ Epoch by axeman please ask permission to use/edit/distribute email gregory.andrew@gmail.com.
*/
private ["_animPhase","_objHouse","_rng","_nrstTrig","_litHouses","_objLightPoint"];

		
_rng = _this select 0;//player range to light windows - REDUCE if individual players experience lag (Is client based)
_nrstTrig = _this select 1;

_litHouses = [];

_objHouse = nearestObjects [_nrstTrig, ["House"], _rng]; 

		
if(!isNil "_objHouse")then{

	{
		_animPhase = getNumber(configFile >> "cfgVehicles" >> typeOf _x >> "AnimationSources" >> "Lights_1" >> "animPeriod");
						
		if(_animPhase>0)then{//Only if has a window (Lights_1)
			if(_x animationPhase "Lights_1" >0)then{
				[_litHouses , _x] call BIS_fnc_arrayPush;
			};

		};
		
	} forEach _objHouse;
	
	
	if(count _litHouses > 0 )then{
		{
		_objLightPoint = nearestObject [_x, "#lightpoint"];
		deleteVehicle _objLightPoint;
		_x animate ["Lights_1",0];
		_x animate ["Lights_2",0];
		}forEach _litHouses;
	};
	
};
