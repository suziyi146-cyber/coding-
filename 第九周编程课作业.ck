class MyMandolin
{
    Mandolin m => dac;
    .3 => m.gain;
    
    fun void play(int note, float length)
    {
        Std.mtof(note) => m.freq;
        1.0 => m.noteOn;
        length::second => now;
    }
}

MyMandolin player;

[60, 63, 67, 70, 67, 65, 63, 60] @=> int notes[];

repeat(2)
{
    for(0 => int i; i < notes.cap(); i++)
    {
        player.play(notes[i], .4);
    }
    
    for(0 => int i; i < notes.cap(); i++)
    {
        player.play(notes[i] + 12, .2);
    }
}

player.play(67, .4);
player.play(63, .4);
player.play(60, 2.0);