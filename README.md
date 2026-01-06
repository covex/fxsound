# fxsound

Fuxoft Sound 1 routine in Z80 assembler (for ZX Spectrum)

This is disassembly and recompilation of Fuxofts' ZX Spectrum fxsound1 AY-8912 music chip player routine using sjasmplus

+ Disassembly was done using https://github.com/skoolkid/skoolkit
+ FUSE ZX Spectrum emulator Profiler was used to create a map file from
https://worldofspectrum.org/archive/software/demos/fuxoft-soundtrack-1-fuxoft

Then ChatGPT was used to analyze, comment the code, convert it to sjasmplus format.

## Howto build and run (linux)

Clone the repo, install sjasmplus and FUSE emulator.

`fxs1data.tap` are a song data extracted from fxsound1 (start address 51260)

`fxs1bas.tap` is simple BASIC program to load data and routine

```
sjasmplus fxs1rut
```

compiles a `fxs1rut.tap` (start address 49152)

merge the taps with `cat`

```
cat fxs1bas.tap fxs1data.tap fxs1rut.tap > fxs1.tap
```

Run in FUSE ZX Spectrum emulator

```
fuse fxs1.tap
```

## References

Refer to https://github.com/fuxoft/fxmasm for more information how song data work. 

Details how to build song data for this routine https://github.com/fuxoft/fxmasm/issues/1#issuecomment-3714352940

Some details how this was made in https://www.lowlevel.cz/log/cats/speccy/FXSound%20disassemblov%c3%a1n.html (Czech only).
