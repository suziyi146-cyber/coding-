Mandolin m => NRev rev => dac;
Shakers shaker => dac;

.3 => m.gain;
.2 => rev.mix;
.25 => m.bodySize;
.6 => m.pluckPos;

0 => shaker.preset;
.15 => shaker.gain;

[60, 63, 65, 67, 70, 67, 65, 63] @=> int notes[];

fun void one()
{
    repeat(4)
    {
        for(0 => int i; i < notes.cap(); i++)
        {
            Std.mtof(notes[i]) => m.freq;
            1.0 => m.noteOn;
            .5::second => now;
        }
    }
}

fun void two()
{
    repeat(32)
    {
        .8 => shaker.noteOn;
        .25::second => now;
        
        .4 => shaker.noteOn;
        .25::second => now;
    }
}

spork ~ one();
spork ~ two();

18::second => now;