/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

The MIT License (MIT)

Copyright (c) 2014 Bobby Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

class MuxMate {
    
    _ctrl_pin = null;
    _sig_pin = null;

    _mux16_channel = [
        [0,0,0,0], //channel 0
        [1,0,0,0], //channel 1
        [0,1,0,0], //channel 2
        [1,1,0,0], //channel 3
        [0,0,1,0], //channel 4
        [1,0,1,0], //channel 5
        [0,1,1,0], //channel 6
        [1,1,1,0], //channel 7
        [0,0,0,1], //channel 8
        [1,0,0,1], //channel 9
        [0,1,0,1], //channel 10
        [1,1,0,1], //channel 11
        [0,0,1,1], //channel 12
        [1,0,1,1], //channel 13
        [0,1,1,1], //channel 14
        [1,1,1,1]  //channel 15
    ];
    
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    constructor(ctrl1, ctrl2, ctrl3, ctrl4, signal, demux = false) 
    {
        _sig_pin = signal;
        _ctrl_pin = [ ctrl1, ctrl2, ctrl3, ctrl4 ];
        foreach(pin in _ctrl_pin) {
            pin.configure(DIGITAL_OUT);
        }
        if(demux) {
            _sig_pin.configure(DIGITAL_OUT);
        } else {
            _sig_pin.configure(ANALOG_IN);
        }
    }
    
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    function open(channel) 
    {
        for(local i = 0; i < _mux16_channel[channel].len(); i++) {
            _ctrl_pin[i].write(_mux16_channel[channel][i]);
        }
    }
    
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    function write(channel, value) 
    {
        open(channel);
        _sig_pin.write(value);
    }
    
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    function read(channel) 
    {
        open(channel);
        return _sig_pin.read();
    }
    
}

/* sample application below */
mux <- MuxMate(hardware.pin1, hardware.pin2, hardware.pin5, hardware.pin7, hardware.pin9, true);

function blink() 
{

    mux.write(8, 1);
    imp.sleep(0.2);
    mux.write(11, 1);
    imp.sleep(0.2);
    mux.write(15, 1);
    imp.wakeup(0.2, blink);
  
}
 
blink();