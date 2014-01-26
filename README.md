dayZ Lighting
=============

House and Illuminant Tower Lights.

Current version should take into account previous lag issues causesd by lighting.

INSTALLATION:

This is currently a mission until testing complete:

Copy lights folder to your mission directory and call with:

USAGE:

From your mission init.sqf call:

if (!isDedicated) then {
[false,12] execVM "lights\local_lights_init.sqf";
};

Parameters:

1: Generator required ? (Boolean) - If true a generator of class name "Generator_DZ" is required to light houses. (Currently not tested) So stick with false. Is using the old code for generator detection so should work fine..

2: Lighting Amount (percentage). Is a percentage of houses within 480m of the player that can be lit. Only houses with windows that can be illuminated are counted.

CHANGELOG:

When lighting a window on a house with "_house animate ["Lights_1",1];" the state of the house "animationPhase" is broadcast to all players on the server (this can not be changed). This was the previous cause of lag as each player created more lit houses. Every change was broadcast, ultimately all houses would be lit.

Additionally, randomly failed house lights and street lights were broadcast as changes. With no control over specific lights being failed each player randomly failed their 'own' lights and broadcast each change to all other players, causing too much network traffic.

This version uses the "animationPhase" of each house as the basis for lighting for all players (incl. JIP). There is a set amount of houses that can be lit within a radius, currently 480m from the player, that is decided by the percentage entered in the init (default = 12).

No matter how many players join there will never be more than 12% (unless changed) of houses lit within 480m of each player. Other players can only light more houses if the threshold is not reached..

OPTIMISATION:
Additionally, there is a boundary around the edge of the lighting radius where lightpoints are deleted as the player moves out of the area. Existing lights' brightness is updated as the player moves around, more distant lights are brighter. No updates are made until the player moves 6m from their current position..
