TriOsc s => dac;
SinOsc b => dac;

0.9 => s.gain;
60 => s.freq;

0.5 => b.gain;
81 => b.freq;

10::second => now;

0.1 => s.gain;
500 => s.freq;

0.2 => b.gain;
100 => b.freq;

15::second => now;