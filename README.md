# fxsound
FUXOFT Sound 1 routine

This is disassembly and recompilation of fuxoft fxsound1 AY player routine using sjasmplus

fxs1data.tap are a song data

fxs1bas.tap it simple BASIC program to load data and rutine

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