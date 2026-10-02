TriOsc s => dac;
SinOsc b => dac;

2 => s.gain;
400 => s.freq;

1 => b.gain;
900 => b.freq;

10::second => now;

3 => s.gain;
300 => s.freq;

4 => b.gain;
10 => b.freq;

15::second => now;