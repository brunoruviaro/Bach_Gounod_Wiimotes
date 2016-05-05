// Wiimote stuff
// Do once


// Press Wii buttons 1+2 together, then evaluate this line
WiiMote.discover; // wait for post about connected

// Load wii settings:
"Bach_WiiFunctions.scd".loadRelative;

// Run this line, then turn wiimote sideways slowly, then up and down slowly to calibrate it.
~calibrateWii.value;

// Run this to finalize settings
~finalizeWii.value;

// GO BACK TO MAIN FILE TO CONTINUE SETUP






















// Test only
// {In.kr(~wiiXbus).poll.(3)}.play;
// {In.kr(~wiiYbus).poll(3)}.play;

// {SinOsc.ar(freq: 1000 + Lag.kr((In.kr(~wiiXbus) * 500), 1), mul: Lag.kr(In.kr(~wiiYbus), 1))}.play;


