SqrOsc s => dac;

[60, 63, 67, 65, 63, 62, 60] @=> int A[];
[.4, .4, .6, .4, .4, .3, .8] @=> float notes[];

<<< A.cap() >>>;

for(0 => int i; i < A.cap(); i++)
{
    <<< i, A[i] >>>;
    Std.mtof(A[i]) => s.freq;
    notes[i]::second => now;
}