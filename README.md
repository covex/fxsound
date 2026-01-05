# fxsound
Fuxoft Sound 1 routine

This is disassembly and recompilation of fuxoft fxsound1 AY player routine using sjasmplus

Disassembly was done using https://github.com/skoolkid/skoolkit
+ FUSE ZX Spectrum emulator Profiler was used to create a map file from
https://worldofspectrum.org/archive/software/demos/fuxoft-soundtrack-1-fuxoft

Then ChatGPT was used to analyze, comment the code, convert it to sjasmplus format.

fxs1data.tap are a song data

fxs1bas.tap it simple BASIC program to load data and routine

```
sjasmplus fxs1rut
```

creates a fxs1rut.tap

merge the taps with "cat"

```
cat fxs1bas.tap fxs1data.tap fxs1rut.tap > fxs1.tap
```

Run in FUSE ZX Spectrum emulator

```
fuse fxs1.tap
```

Reffer to https://github.com/fuxoft/fxmasm
for more information how song data work.

Some details on how this was made in https://www.lowlevel.cz/log/cats/speccy/FXSound%20disassemblov%c3%a1n.html (Czech only).
