TriOsc a => dac;
TriOsc b => dac;
TriOsc c => dac;

.1 => a.gain;
.1 => b.gain;
.1 => c.gain;

fun void playChord(int root)
{
    Std.mtof(root) => a.freq;
    Std.mtof(root + 3) => b.freq;
    Std.mtof(root + 7) => c.freq;
    1::second => now;
}

while(true)
{
    playChord(60);
    playChord(65);
}