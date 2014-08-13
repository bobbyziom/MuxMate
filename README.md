MuxMate
=======

16 channel (de-)multiplexer library for electric imp

Usage
---

Constructor takes 5 arguments in which the control and signal pins for the multiplexer are defined (controlpin1, controlpin2, controlpin3, controlpin4, signalpin).
Optionally a 6th boolean argument can be provided to configure as de-multiplexer (true) or default multiplexer (false). 
```javascript
mux <- MuxMate(hardware.pin1, hardware.pin2, hardware.pin5, hardware.pin7, hardware.pin9);
```

Use the read() method for reading the multiplexer pins if configured as multiplexer. Provide channel number (0-15) to be read as argument. In this example reading channel 10. 
```javascript
local value = mux.read(10);
```

Use the write() method for writing a value to a channel on the multiplexer. Provide channel number (0-15) and value to be written as arguments.
```javascript
mux.write(10, 1);
```
