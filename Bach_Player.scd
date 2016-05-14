///////////////////////////////////////
// Bach player
// Spring 2016
// Concert SCLOrk + Theremin + Singer
// 2016-06-02
///////////////////////////////////////

// Open Wiimote file and go through it to set up wiimote:
("".resolveRelative ++ "Bach_Wiimote_Setup.scd").openDocument;

// Load score:
"Bach_Score.scd".loadRelative;

// Define SATB for this particular player. Options are:
// ~sopranoScore, ~altoScore, ~tenorScore, ~baritoneScore, ~bassScore
~originalScore = ~sopranoScore;

// Load synths:
"Bach_SynthDefs.scd".loadRelative;

// Load functions:
"Bach_Functions.scd".loadRelative;

// Open GUI:
"Bach_GUI.scd".loadRelative;



// "HOME" button: get ready to start from specified measure number
// "A" button: move to next note
// "+" and "-" buttons: choose measure to start from (for rehearsals)
// Press home button after choosing a measure start









// TEST ONLY.
r.reset
r.next(1);
r.next;
r.stop


// END OF FILE
