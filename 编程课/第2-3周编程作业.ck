SinOsc s => dac;
SqrOsc t => dac;

1 => s.gain;
0 => t.gain;

for(0 => int i; i < 200; i++)
{
    i => s.freq;
    0.02::second => now;
}

1 => t.gain;
0 => s.gain;

for(0 => int i; i < 440; i++)
{
    i => t.freq;
    0.02::second => now;
} 