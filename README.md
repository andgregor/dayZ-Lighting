dayZ House, Illuminant Tower and Street Lighting by axeman.
-----------------------------------------------------------

This addon is designed for usage with dayZ Epoch as it includes a generator requirement. However, this can probably be used on other dayZ mode simply by disabling the generator requirement (not tested).

This version is currently at a further / final test stage. The aim is to remove lag issues from creating too many light sources / vehicles and to add in more stringent management of the lights created.

**What This Does**: This addon is run entirely clientside, this is a requirement of the engine as light sources are local only. It will light up the windows of nearby houses and create an ambient light source to light the surrounding area. Street lights can be disabled. Illuminant towers will create a strong light source with 4 light points.

**House Lights**: It looks for houses that have windows that can be lit using the house animationSources Lights_1 / lights_2 etc. The script manages already lit houses to reduce constant looping and too many instances of #lightpoint on each house.

**Street Lights**: As it is designed for Epoch, this current version, when set to true, will leave the street lights on. When set to false will loop through nearby objects and switch off any sreetlights found.

**Tower Lights**: Will create four #lightpoint objects aligned to match the light tower model.


Usage / Installation
--------------------

Add to your init.sqf (within your mpmission folder) the following:

`if (!isDedicated) then {
//Lights
	DZE_RequireGenerator = false;
	DZE_StreetLights = true;
	DZE_HouseLights = true;
	DZE_TowerLights = true;
	DZE_LightChance = 42;
	[] execVM "lights\local_lights_init.sqf";
};`

Parameters
---------

**DZE_RequireGenerator** : Require a running Epoch generator, in the vicinity, to allow lighting of houses and towers. The generator logic hasn't really changed in this version.

**DZE_StreetLights** : Set to false to switch off street lights within a specified range of the player.

**DZE_HouseLights** : Set to true to light up houses around the player.

**DZE_TowerLights** : Set to true to light up Illuminant Towers around the player.

**DZE_LightChance** : Adds a percentage chance for houses to be lit. Allows an element of control for the server host to reduce the number of lit houses.


Requirements
------------

This new code has been tested locally and has been released for server owners to try out and to provide feedback. You must be comfortable with running custom scripts and diagnosing any issues that may arise from adding custom scripts to your server.
