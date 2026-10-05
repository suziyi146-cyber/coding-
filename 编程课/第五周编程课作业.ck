SndBuf kick => dac;
SndBuf snare => dac;

me.dir() + "/audio-2/kick_01.wav" => kick.read;
me.dir() + "/audio-2/snare_01.wav" => snare.read;

kick.samples() => kick.pos;
snare.samples() => snare.pos;

.5 => kick.gain;
.4 => snare.gain;

while(true)
{
    0 => kick.pos;
    .5::second => now;
    
    Math.random2f(.8, 1.2) => snare.rate;
    0 => snare.pos;
    .5::second => now;
}