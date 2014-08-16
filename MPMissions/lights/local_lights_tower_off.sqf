/*
	DayZ Epoch Lighting System - Illuminant Tower Lights
	Made for DayZ Epoch by axeman please ask permission to use/edit/distribute email vbawol@veteranbastards.com.
*/
private ["_nrTowers","_nrstTrig","_rng","_twrCl","_nrTLs"]; 
_rng = _this select 0;
_nrstTrig = _this select 1;
_twrCl = "Land_Ind_IlluminantTower";
_nrTowers = nearestObjects [_nrstTrig, [_twrCl], _rng];

if(count _nrTowers >0)then{
	{
	_nrTLs= position _x nearObjects ["#lightpoint",28];
		{
		deleteVehicle _x;
		sleep .2;
		}forEach _nrTLs;
	}forEach _nrTowers;	
};
