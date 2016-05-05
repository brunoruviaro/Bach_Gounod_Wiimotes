// Wiimote stuff

//////////////////////
// Calibrate: turn wiimote up/down & sideways
// This step automatically boots server
//////////////////////
~calibrateWii = {
	// Let's call this Wiimote "~wii"
	~wii = WiiMote.all[0];
	// Enable motion sensor and buttons
	~wii.enableMotionSensor(1); ~wii.enableButtons(1);
	// Create a user interface
	g = WiiMoteGUI.new(~wii);
	// Boot server!
	s.boot;
	// Calibrate
	~wiiXmin = 0.5;
	~wiiXmax = 0.5;
	~wiiYmin = 0.5;
	~wiiYmax = 0.5;
	// turn Wiimote sideways slowly
	~wii.setAction(\ax, { arg v;
		~wiiXmin = min(~wiiXmin, v);
		~wiiXmax = max(~wiiXmax, v);
	});
	// turn Wiimote up down slowly
	~wii.setAction(\ay, { arg v;
		~wiiYmin = min(~wiiYmin, v);
		~wiiYmax = max(~wiiYmax, v);
	});
};


//////////////////////
// Reset wiimote actions
//////////////////////
~finalizeWii = {

	~wii.removeAction(\ax);
	~wii.removeAction(\ay);
	["X", ~wiiXmin, ~wiiXmax].postln;
	["Y", ~wiiYmin, ~wiiYmax].postln;
	["battery", ~wii.battery].postln;

	// Create bus on the server
	~wiiXbus = Bus.control(s, 1).value_(0); // x axis
	~wiiYbus = Bus.control(s, 1).value_(0); // y axis

	~wii.setAction(\ax, { arg v;
		~wiiXbus.set(v.linlin(~wiiXmin, ~wiiXmax, 0, 1.1)) } );

	~wii.setAction(\ay, { arg v;
		~wiiYbus.set(v.linlin(~wiiYmin, ~wiiYmax, 1.0, -0.5)) } ); // 1-0 for up-down amplitude

	// "Home" button: start from bar number specified with +- buttons.
	~wii.setAction(\bHome, { arg v; if(v==1,
		{
			~divisi.do({ arg item; item.release });
			r.reset; // reset routine
			// ~startAtMeasure = 1; // start "da capo"
			r.next(~startAtMeasure); // start here
			//if(p.notNil, {p.stop; p = nil}); // stop Pbind bell (if there is one running)
		})
	});

	// "A" button: next move
	~wii.setAction(\bA, { arg v; if(v==1, {r.next})});

	// "Plus" and "Minus" buttons: choose measure number to start from.
	// Note: variable ~numberOfMeasures determined at end of score file.
	~wii.setAction(\bPlus, { arg v; if(v==1, {
		(~startAtMeasure = min(~startAtMeasure + 1, ~numberOfMeasures)).postln;
		// And in case button remains pushed,
		{
			1.wait;
			while(
				{~wii.at(\bPlus).value==1},
				{(~startAtMeasure = min(~startAtMeasure + 1, ~numberOfMeasures)).postln; 0.05.wait})
		}.fork;
		}
	)});

	~wii.setAction(\bMinus, { arg v; if(v==1, {
		(~startAtMeasure = max(~startAtMeasure - 1, 1)).postln;
		// And in case button remains pushed,
		{
			1.wait;
			while(
				{~wii.at(\bMinus).value==1},
				{(~startAtMeasure = max(~startAtMeasure - 1, 1)).postln; 0.05.wait})
		}.fork;
		}
	)});
};
















// Test only
// {In.kr(~wiiXbus).poll.(3)}.play;
// {In.kr(~wiiYbus).poll(3)}.play;

// {SinOsc.ar(freq: 1000 + Lag.kr((In.kr(~wiiXbus) * 500), 1), mul: Lag.kr(In.kr(~wiiYbus), 1))}.play;


