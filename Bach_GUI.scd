w = Window.new("bar numbers", Rect(50, 50, 1000, 650)).front;
a = StaticText.new(w, w.bounds);
a.string = "-";
a.align = \center;
a.font = Font("Arial", 384);
a.stringColor = Color.red;



b = Button.new(w, Rect(5, 5, 100, 40));
b.states = [["sine1"], ["sine3"], ["sine4"], ["sine5b"]];
b.value = 3;
b.action = { arg bt;
	case
	{bt.value==0} {~synth = "sine1"}
	{bt.value==1} {~synth = "sine3"}
	{bt.value==2} {~synth = "sine4"}
	{bt.value==3} {~synth = "sine5b"};
};

