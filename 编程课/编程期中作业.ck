
//Oscs and samples-------------------------------------------------------------------------------------------
//samples
SndBuf kick => LPF lpfkick => JCRev kickRev => dac;
SndBuf snare2 => LPF lpf => JCRev snare2Rev => dac;
SndBuf snare => JCRev snareRev => dac;
SndBuf hat => JCRev hatRev => dac;

me.dir() + "SampleChuck/AbletonSamplesForChuck/JngKick.wav" => kick.read;
me.dir() + "SampleChuck/AbletonSamplesForChuck/JngHat.wav" => hat.read;
me.dir() + "SampleChuck/AbletonSamplesForChuck/JngSnare.wav" => snare.read;
me.dir() + "SampleChuck/AbletonSamplesForChuck/JngSnare2.wav" => snare2.read;

.3  => lpfkick.Q;
0.2 => kick.gain;
.1 => lpf.Q;
1.2 => snare.gain;
0.5 => snare2.gain;
.1 => snareRev.mix;
.1 => snare2Rev.mix;

//Oscs
//Click-glitchy
TriOsc triClick =>ADSR triEnv =>JCRev trirev=>  dac;
.2 => trirev.mix;

triEnv.set(1::ms, 5::ms, 0.3, 40::ms);0.1 => triClick.gain;

//Chords
SawOsc oscs[7];
SawOsc saw => LPF lfpSin => JCRev revSaw => dac;
Gain chordBus => ADSR chordEnv => LPF chordLpf => dac;
for (0 => int i; i < oscs.size(); i++) oscs[i] => chordBus;
500 => chordLpf.freq;
chordEnv.set(2000::ms, 2000::ms, 0.3, 4000::ms);0.0 => saw.gain;
.018 => revSaw.mix; 


//Chords----------------------------------------------------------------------------------------------------

9 => int numChords;
0.05 => float voiceGain;

fun int[] useChord(int index) {
    if (index == 0) return [53,57,60,64,69,71,76]; //Fmaj7(11)
    if (index == 1) return [51,55,58,62,67,69,74]; //Ebmaj7(11)
    if (index == 2) return [49,53,56,60,65,67,72]; //Dbmaj7(11)
    if (index == 3) return [48,52,55,59,64,66,71]; //Cmaj7(11)
    if (index == 4) return [47,51,54,58,61,66,70]; //Bmaj7
    if (index == 5) return [47,51,54,58,61,66,70]; //Bmaj7
    if (index == 6) return [49,53,56,60,65,67,72]; //Dbmaj7(11)
    if (index == 7) return [47,51,54,58,61,66,70]; //Bmaj7
    if (index == 8) return [47,51,54,58,61,66,70]; //"Abmaj7(9)"
    return [43,48,51,55,58,63,67]; //"Abmaj7(9)"
    }

fun string getChordName(int index) {
    if (index == 0) return "Fmaj7(11)";
    if (index == 1) return "Ebmaj7(11)";
    if (index == 2) return "Dbmaj7(11)";
    if (index == 3) return "Cmaj7(11)";
    if (index == 4) return "Bmaj7";
    if (index == 5) return "Bmaj7";
    if (index == 6) return "Dbmaj7(11)";
    if (index == 7) return "Bmaj7";
    if (index == 8) return "Abmaj7(9)"; 
    return "Abmaj7(9)"; 

}

fun void setChord(int index) {
    useChord(index) @=> int chord[];
    for (0 => int i; i < oscs.size(); i++) {
        if (i < chord.size()) {
            Std.mtof(chord[i]) + Math.random2f(-0.35, 0.35) => oscs[i].freq;
            voiceGain => oscs[i].gain;
        } else {
            0.0 => oscs[i].gain;
        }
    }
}
 

 fun int chance(float p) {
     return Math.random2f(0.0, 1.0) < p;
 }
 
 //Beat and Rhythm ----------------------------------------------------------------------------------------
for (0 => int counter; true; counter++)
{
    counter % 32 => int beat;
    
    (counter / 32) % numChords => int chordIndex; 
    useChord(chordIndex) @=> int chord[];
    
    if (beat % 1 == 0){
        chord[Math.random2(0, chord.size() - 1)] => int note;  
        Std.mtof(note) => triClick.freq;
    }
    
   if (counter < 128)
{
    if (chance(0.1)) triEnv.keyOn();
    else triEnv.keyOff();
}
else if (counter <= 256)
{
    if (chance(1.0)) triEnv.keyOn();
    else triEnv.keyOff();
}
else
{
    if (chance(0.5)) triEnv.keyOn();
    else triEnv.keyOff();
}         
    if ((beat==0)||(beat==6)||(beat==14)||(beat==18)||(beat==24)||(beat==26))
    {
        0 => kick.pos;
    }
    
    if (counter >= 128)
    {
        if ((beat==4)||(beat==10)||(beat==14)||(beat==20)||(beat==24)||(beat==30))
        {
            0 => snare2.pos;
            Math.random2f(.5, 1.5) => snare2.rate;
        }
        if ((beat==3)||(beat==7)||(beat==9)||(beat==13)||(beat==17)||(beat==23)||(beat==29))
        {
            0 => snare.pos;
        }
        if ((beat==0)||(beat==4)||(beat==8)||(beat==12)||(beat==16)||(beat==20)||(beat==24)||(beat==28))
        {
            0 => hat.pos;
        }
    }
    
    <<< "counter:", counter, "beat:", beat >>>;
    
    if (beat == 0) {
        (counter / 32) % numChords => int chordIndex;
        setChord(chordIndex);
        chordEnv.keyOn();
        <<< "chord:", getChordName(chordIndex) >>>;
    }
    
    if (beat == 20) chordEnv.keyOff();
    
    if (counter >= 64)
    {
        if (beat >= 20) Math.random2(400, 1000) => chordLpf.freq;
        else 500 => chordLpf.freq;
    }
    
    120::ms => now;
}

120::second => now;
