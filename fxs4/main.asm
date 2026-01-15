;---------------------------------------------------------------
;reconstruction from disassebly of Music routine from FX SOUND 4
;---------------------------------------------------------------

ROM_KEY_SCAN	equ	028Eh		;THE 'KEYBOARD SCANNING' SUBROUTINE
ROM_MASK_INT	equ	0038h		;THE 'MASKABLE INTERRUPT' ROUTINE

AY_REG_PORT	EQU	0FFFDh		;AY register select port
AY_DATA_PORT	EQU	0BFFDh		;AY data write port


	org	085d4h	;34260	

MusY:	incbin	"Fuxoft -Y-85d4- Indiana Jones 3.bin"

MusX:	incbin	"Fuxoft -X-89e4- Golden Triangle Anthem.bin"

	db	0,0,0,0,0,0

MusW:	incbin	"Fuxoft -W-8b83- Belegost.bin"

	db	0,0,0

MusZ:	incbin	"Fuxoft -Z-8e2b- Magnetic Fields II.bin"

	db	0,0,0

MusV:	incbin	"Fuxoft -V-940c- View to a Kill.bin"

	db	0,0,0,0,0,0

MusU:	incbin	"Fuxoft -U-98f8- RendezVous IV.bin"

MusT:	incbin	"Fuxoft -T-9ce0- Land Of Confusion.bin"

	ds	0A64Ah-$

MusS:	incbin	"Fuxoft -S-a64a- Where Time Dropped Dead.bin"

	db	0,0,0,0,0,0

MusR:	incbin	"Fuxoft -R-aa50- FIRE.bin"

	db	0,0

MusQ:	incbin	"Fuxoft -Q-ade8- Alla Turca.bin"

	db	0,0,0

MusP:	incbin	"Fuxoft -P-b234- Jet Story.bin"

	db	0,0,0,0
	
MusO:	incbin	"Fuxoft -O-b748-Eqinoxe V.bin"

	db	0,0,0,0,0,0,0,0,0,0
		
MusN:	incbin	"Fuxoft -N-ba54- E.T. Flying.bin"

	db	0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0

MusM:	incbin	"Fuxoft -M-bcfc- Axel F. Theme.bin"

	db	0,0,0,0,0,0,0

;	org	49152		;= C000h

MusicTick:
	call	ROM_KEY_SCAN	;načti do DE stav klávesnice
	ld	a,e		;klávesa do A

SongEntry:
	call	SongTable	;podle A vrať adresu hudebních dat
	ld	de,channels	;kam
	ld	bc,6		;3x2
	ldir			;přenes informaci o kanálech
	call	stoppl		;zastav předchozí hudbu (+ nastav Noise+)
	call	StartMusic	;spusť novou melodii
	ret			;a návrat

; ============================================================
; SONG TABLE
; ============================================================
; Manual song dispatch using comparisons
; This avoids a jump table and allows sparse IDs
;
; Input:
;   A = song ID / Key pressed
; Output:
;   HL = pointer to song data
; ============================================================

SongTable:
	ld	hl,stopp+1
	ld	(hl),0fh
	cp	26h		;"A"
	jr	nz,SongB
	ld	hl,MusA
	ret	

SongB:	cp	00h		;"B"
	jr	nz,SongC
	ld	hl,MusB
	ret	

SongC:	cp	0fh		;"C"
	jr	nz,SongD
	ld	hl,MusC
	ret	

SongD:	cp	16h		;"D"
	jr	nz,SongE
	ld	hl,MusD
	ret	

SongE:	cp	15h		;"E"
	jr	nz,SongF
	ld	hl,MusE
	ret	

SongF:	cp	0eh		;"F"
	jr	nz,SongG
	ld	hl,MusF
	ret	

SongG:	cp	06h		;"G"
	jr	nz,SongH
	ld	hl,MusG
	ret	

SongH:	cp	01h		;"H"
	jr	nz,SongI
	ld	hl,MusH
	ret	

SongI:	cp	12h		;"I"
	jr	nz,SongJ
	ld	hl,MusI
	ret	

SongJ:	cp	09h		;"J"
	jr	nz,SongK
	ld	hl,MusJ
	ret	

SongK:	cp	11h		;"K"
	jr	nz,SongL
	ld	hl,MusK
	ret	

SongL:	ld	hl,stopp+1
	ld	(hl),1fh
	cp	19h		;"L"
	jr	nz,SongM
	ld	hl,MusL
	ret	

SongM:	cp	10h		;"M"
	jr	nz,SongN
	ld	hl,MusM
	ret	

SongN:	cp	08h		;"N"
	jr	nz,SongO
	ld	hl,MusN
	ret	

SongO:	cp	1ah		;"O"
	jr	nz,SongP
	ld	hl,musO
	ret	

SongP:	cp	22h		;"P"
	jr	nz,SongQ
	ld	hl,MusP
	ret	

SongQ:	cp	25h		;"Q"
	jr	nz,SongR
	ld	hl,MusQ
	ret	

SongR:	cp	0dh		;"R"
	jr	nz,SongS
	ld	hl,MusR
	ret	

SongS:	cp	1eh		;"S"
	jr	nz,SongU
	ld	hl,MusS
	ret	

SongU:	cp	0ah		;"U"
	jr	nz,SongT
	ld	hl,MusU
	ret	

SongT:	cp	05h		;"T"
	jr	nz,SongV
	ld	hl,MusT
	ret	

SongV:	cp	07h		;"V"
	jr	nz,SongZ
	ld	hl,MusV
	ret	

SongZ:	cp	1fh		;"Z"
	jr	nz,SongW
	ld	hl,MusZ
	ret	

SongW:	cp	1dh		;"W"
	jr	nz,SongX
	ld	hl,MusW
	ret	

SongX:	cp	17h		;"X"
	jr	nz,SongY
	ld	hl,MusX
	ret	

SongY:	cp	02h		;"Y"
	jr	nz,SongT2
	ld	hl,85d4h
	ret	

SongT2:	cp	05h		;"T"  -> omylem podruhé ??
	jr	nz,nokey
	ld	hl,MusT
	ret	

nokey:	pop	de		;zahodit návratovou adresu
	ld	a,03h		;fialový border						
	out	(0feh),a	;nastav
	call	UpdateAllChannels
	xor	a		;černý border
	out	(0feh),a	;nastav
	call	ROM_KEY_SCAN
	ld	a,e		;klávesa do A
	cp	21h		;je to ENTER ?
	di			;zakaž přerušení	
	push	af		;uschovej příznak
	call	z,UpdateAllChannels		;pro ENTER přidej
	pop	af		;obnov příznaky
	call	z,UpdateAllChannels		;pro ENTER ještě jednou
	ret			;a návrat

	ds	49500-$		;troška volna
		
;start zde - 49500 (C15Ch)
;-------------------------
start:	ld	a,26h		;kód klávesy "A"
	jp	SongEntry

;
stoppl:	ld	hl,NoPl+1	;adresa masky v NOISE+
stopp:	ld	(hl),1fh	;nastav (hondota se mění !!)
	jp	StopMusic	;a zastav hraní
;
	db	0,0,0,0,0,0,0

setIM1:	di			;zákaz přerušení
	im	1		;režim 1
	ld	a,3fh		;standardní hodnota pro I
	ld	i,a		;nastav
	ret			;a návrat

	db	0,0,0,0,0,0,0,0	

rutIM2:	db	0,0,0,0,0,0,0,0,0,0	;4 byly nula a 6 pro vynechání efektů
;	call	0fec4h		;efekty
;	call	0ff28h		;efekty
	jp	MusicTick	;proveď test kláves a přehraj Tick melodie

	ds	0C200h-$

;tabulka vektorů pro skok přerušení

VECTOR_PAGE:			;C200h
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dw	0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh,0FFFFh
	dW	0FFFFh

	ds	50000-$

; ===================
; ENGINE ENTRY POINTS
; ===================

StartMusic:			;50000 - C350
	jp	InitEngine
StopMusic:
	jp	StopEngine
UpdateMusic:
	jp	UpdateAllChannels

;
InitEngine:
	di			;zákaz přeruení
	ld	hl,(channels)
	ld	(CH1_STRUCT),hl
	ld	hl,(channels+2)
	ld	(CH2_STRUCT),hl
	ld	hl,(channels+4)
	ld	(CH3_STRUCT),hl

;----------------
; Enable channels
;----------------

	ld	a,1
	ld	(CH1_STRUCT+2),a
	ld	(CH2_STRUCT+2),a
	ld	(CH3_STRUCT+2),a

;----------------------
; Initial note duration
;----------------------

	ld	a,8
	ld	(CH1_STRUCT+3),a
	ld	(CH2_STRUCT+3),a
	ld	(CH3_STRUCT+3),a

; ---------------------
; Pattern pointer bases
; ---------------------

	ld	hl,CH_1e
	ld	de,0020h	;velikost oblasti 32 bajtů
	ld	(CH_PTR1),hl	;nastav konec
	add	hl,de		;posuň se na CH_2e
	ld	(CH_PTR2),hl	;nastav konec
	add	hl,de		;posuň se na CH_3e
	ld	(CH_PTR3),hl	;nastav konec

; --------------------------------------------
; Clear pitch accumulators and counters
; --------------------------------------------

	ld	hl,0		;vynuluj HL
	ld	(CH1_STRUCT+14),hl
	ld	(CH2_STRUCT+14),hl
	ld	(CH3_STRUCT+14),hl
	ld	(CH1_STRUCT+16),hl
	ld	(CH2_STRUCT+16),hl
	ld	(CH3_STRUCT+16),hl

	xor	a
	ld	(GLOBAL_Noise),a

; ----------
; IM 2 setup
; ----------

	ld	a,VECTOR_PAGE/256	;vyšší bajt adresy tabulky vektorů přerušení
	ld	i,a		; nastav
	ld	a,18h		;instrukce JR xx
	ld	(0ffffh),a	;dej na konec paměti (sem ukazuje vektor přerušení)
	ld	a,0c3h		;instrukce JP
	ld	(0fff4h),a	;nastav -> sem je skok z JR na 65535
	ld	hl,MusicISR	;adresa výkonné rutiny
	ld	(0fff5h),hl	;nastav za JP
	im	2		;režim přerušení 2
	ei			;povol přerušení
	ret			;a návrat

;výkonná rutina pro IM2
;----------------------
MusicISR:
	di			;zakaž další přerušení	
	push	af		;uschovej registry
	push	bc
	push	de
	push	hl
	push	ix
	call	rutIM2
	pop	ix		;obnov registry
	pop	hl
	pop	de
	pop	bc
	pop	af
	jp	ROM_MASK_INT	;a dokonči v ROM klasickým přerušením

StopEngine:			;C3D7
	call	setIM1
	ld	a,0ffh
	ld	d,7
	call	AY_WriteShadow
	call	AY_Flush
	ei			;povol přerušení
	ret			;a návrat

;-----------
;DATA rutiny
;----------- 

; -------------------------
; AY register shadow (0–13)
; -------------------------
AY_SHADOW:			;50150 - c3e6 
	db	71h		;0
	db	0ffh		;1
	db	0f6h		;2
	db	03h		;3
	db	0beh		;4
	db	0		;5
	db	0dh		;6
	db	0ffh		;7
	db	6		;8
	db	0ch		;9
	db	9		;10
	db	0		;11
	db	0		;12
	db	0		;13
GLOBAL_Noise:
	db	13		;50164 - c3f4
CUR_CHANNEL:			;50165 - c3f5
	db	3
tmp1:	dw	6953h		;50166 - c3f6
tmp2:	 dw	0c45ch		;50168 - c3f8
CH_PTR1: dw	0C416h		;50170 - c3fa
CH_PTR2: dw	0C43ch		;50172 - c3fc
CH_PTR3: dw	0C45ch		;50174 - c3fe
;c400 - spodek zásobníku kanálu 1
	dw	0,0,0,0
	dw	0c794h,0d81ch,0c794h,0c794h
	dw	0c794h
	db	0FBh,8Fh,0B5h,0C6h,68h,0AAh,5Ah,0AAh
	db	0FEh,07h,58h,0AAh,0FEh,06h
CH_1e:				;vrchol zásobníku kanálu 1
	dw	0,0,0,0,0,0
	dw	0c794h,0d81ch,0c7d7h,0c6b5h
	db	7Eh,0FCh
	dw	0c7d7h,0c6b5h,0c6b5h
	db	05h,0ABh,0E6h,02h
CH_2e:				;vrchol zásobníku kanálu 2
	dw	0,0,0,0,0
	dw	0c794h,0c794h,0c794h,0c6b5h
	db	0EDh,93h
	dw	0c794h,0c7d7h,0c6b5h,0c6b5h
	db	0C5h,0ABh,0E6h,02h
CH_3e:				;vrchol zásobníku kanálu 3
CH1_STRUCT:			;c460
	db	0FAh,0AAh,03h,01h
	db	0D6h,0AAh,01h,71h
	db	0FFh,06h,0CCh,0AAh
	db	07h,00h,00h,00h
	db	00h,00h,4Dh,0Fh
CH2_STRUCT:			;c474
	db	09h,0ABh,0Dh,08h
	db	9Fh,0ABh,03h,0F6h
	db	03h,0Ch,97h,0ABh
	db	0A9h,0ABh,00h,00h
	db	0A2h,0ABh,19h,08h
CH3_STRUCT:			;c488
	db	0CFh,0ABh,03h,08h
	db	0D2h,0ADh,0FEh,0BEh
	db	00h,09h,0C4h,0ADh
	db	0D6h,0ADh,00h,00h
	db	0D5h,0ADh,36h,04h

;tabulka nastavení frekvencí
;---------------------------
FREQ_TABLE:			;c49c
	dw	0fbfh
	dw	0edch
	dw	0e07h
	dw	0d3dh
	dw	0c7fh
	dw	0bcch
	dw	0b22h
	dw	0a82h
	dw	09ebh
	dw	095dh
	dw	08d6h
	dw	0857h
	dw	07dfh	
	dw	076eh
	dw	0703h	
	dw	069fh
	dw	0640h
	dw	05e6h
	dw	0591h
	dw	0541h
	dw	04f6h
	dw	04aeh
	dw	046bh
	dw	042ch
	dw	03f0h
	dw	03b7h
	dw	0382h
	dw	034fh
	dw	0320h
	dw	02f3h
	dw	02c8h
	dw	02a1h
	dw	027bh
	dw	0257h
	dw	0236h
	dw	0216h
	dw	01f8h
	dw	01dch
	dw	01c1h
	dw	01a8h
	dw	0190h
	dw	0179h
	dw	0164h
	dw	0150h
	dw	013dh
	dw	012ch
	dw	011bh
	dw	010bh
	dw	00fch
	dw	00eeh
	dw	00e0h
	dw	00d4h
	dw	00c8h
	dw	00bdh
	dw	00b2h
	dw	00a8h
	dw	009fh
	dw	0096h
	dw	008dh
	dw	0085h
	dw	007eh
	dw	0077h
	dw	0070h
	dw	006ah
	dw	0064h
	dw	005eh
	dw	0059h
	dw	0054h
	dw	004fh
	dw	004bh
	dw	0047h
	dw	0043h
	dw	003fh
	dw	003bh
	dw	0038h
	dw	0035h
	dw	0032h
	dw	002fh
	dw	002dh
	dw	002ah
	dw	0028h
	dw	0025h
	dw	0023h
	dw	0021h

; ============================================================
; UPDATE ALL CHANNELS (PER INTERRUPT)
; ============================================================
;50500

UpdateAllChannels:
	ld	ix,CH1_STRUCT
	ld	hl,(CH_PTR1)
	ld	a,1
	call	ChannelTick
	ld	(CH_PTR1),hl
	ld	ix,CH2_STRUCT
	ld	hl,(CH_PTR2)
	ld	a,2
	call	ChannelTick
	ld	(CH_PTR2),hl
	ld	ix,CH3_STRUCT
	ld	hl,(CH_PTR3)
	ld	a,3
	call	ChannelTick
	ld	(CH_PTR3),hl
	ld	a,(CH3_STRUCT+3)
	rlca	
	ld	b,a
	ld	a,(CH2_STRUCT+3)
	or	b
	rlca	
	ld	b,a
	ld	a,(CH1_STRUCT+3)
	or	b
	ld	d,7
	call	AY_WriteShadow
	
; ======================================
; AY FLUSH — WRITE ALL REGISTERS TO CHIP
; ======================================
AY_Flush:
	ld	d,13			;13 registrů
	ld	hl,AY_SHADOW+13
Floop:	ld	a,d
	ld	bc,AY_REG_PORT
	out	(c),a
	ld	a,(hl)
	ld	b,AY_DATA_PORT/256
	out	(c),a
	dec	hl
	dec	d
	jp	p,Floop
	ret	

; ============================================================
; AY SHADOW REGISTER WRITE
; ============================================================
; Input:
;   D = AY register number
;   A = value
; ============================================================
;
AY_WriteShadow:			;50587 - c59b
	ld	bc,AY_SHADOW	;báze stínových registrů
	ld	l,d		;D do HL
	ld	h,0
	add	hl,bc		;přičti
	ld	(hl),a		;a ulož tam hodnotu
	ret			;návrat

; --------------------
; Stack restore helper
; --------------------
Channel_SP_Restore:		;50596 - c5a4
	ld	(tmp2),sp
	ld	hl,(tmp2)
	ld	sp,(tmp1)
	ret	

; =========================
; CHANNEL INTERPRETER ENTRY
; =========================
; Core engine:
; • Decodes pattern bytecode
; • Handles notes, envelopes, effects
; • Updates AY shadow registers

; -----------------
; ChannelTick entry
; -----------------
ChannelTick:			;50608 - c5b0
	ld	(tmp1),sp
	ld	sp,hl
	ld	(CUR_CHANNEL),a
	dec	(ix+02h)
	jp	z,Chan_NextEvent

;---------------
; Tick countdown
;---------------

Chan_Tick:
	dec	(ix+06h)
	jr	nz,Chan_Update_Vib

;--------------
; Pattern fetch
;--------------

Fetch_Pattern:
	ld	l,(ix+04h)
	ld	h,(ix+05h)
;Fetch_Byte	
	ld	a,(hl)
	cp	80h
	jr	nz,Check_Note
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(ix+04h),e
	ld	(ix+05h),d
	jr	Fetch_Pattern

;-----------------------
; Note / duration decode
;-----------------------

Check_Note:
	cp	1eh
	jr	c,Short_Note
	sub	32h
	ld	(ix+09h),a
	ld	(ix+06h),01h
	inc	hl
	jr	Store_Ptr

Short_Note:
	ld	(ix+09h),a
	inc	hl
	ld	a,(hl)
	ld	(ix+06h),a
	inc	hl

Store_Ptr:
	ld	(ix+04h),l
	ld	(ix+05h),h

;---------------
; Vibrato update
;---------------

Chan_Update_Vib:
	ld	a,(ix+07h)
	or	(ix+08h)
	jp	z,Chan_Output
	bit	2,(ix+0eh)
	jp	nz,Chan_Output
	ld	l,(ix+0ch)
	ld	h,(ix+0dh)
UpV1:	ld	a,(hl)
	inc	hl
	ld	(ix+0ch),l
	ld	(ix+0dh),h
	cp	80h
	jr	nz,UpV2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jr	UpV1
UpV2:	cp	82h
	jp	nz,UpV3
	set	3,(ix+0eh)
	jp	UpV1
UpV3:	cp	83h
	jp	nz,UpV4
	res	3,(ix+0eh)
	jp	UpV1
UpV4:	cp	84h
	jp	nz,UpV5
	ld	a,09h
	xor	(ix+03h)
	ld	(ix+03h),a
	jp	UpV1
UpV5:	bit	3,(ix+0eh)
	jp	z,UpV6
	add	a,(ix+12h)
	ld	(ix+12h),a
	dec	a
	add	a,a		;2x
	ld	e,a		;do DE
	ld	d,0
	ld	hl,FREQ_TABLE
	add	hl,de
	ld	a,(hl)
	ld	(ix+07h),a
	inc	hl
	ld	a,(hl)
	ld	(ix+08h),a
	jp	Chan_Output
UpV6:	ld	e,a
	ld	d,00h
	ld	l,(ix+07h)
	ld	h,(ix+08h)
	and	80h
	jp	z,UpV7
	ld	d,0ffh
UpV7:	add	hl,de
	ld	(ix+07h),l
	ld	(ix+08h),h

; ---------
; AY output
; ---------

Chan_Output:
	ld	a,(GLOBAL_Noise)
	ld	d,06h
	call	AY_WriteShadow
	res	2,(ix+0eh)
	ld	a,(CUR_CHANNEL)
	add	a,07h
	ld	d,a
	ld	a,(ix+07h)
	or	(ix+08h)
	jr	z,No_Note
	ld	a,(ix+09h)

No_Note:
	call	AY_WriteShadow
	ld	a,(CUR_CHANNEL)
	dec	a
	add	a,a
	ld	d,a
	ld	a,(ix+07h)
	call	AY_WriteShadow
	inc	d
	ld	a,(ix+08h)
	call	AY_WriteShadow
	jp	Channel_SP_Restore

;---------------------
; Save pattern pointer
;---------------------

Save_Ptr:			;50872 - c6b8
	ld	(ix+00h),l
	ld	(ix+01h),h
	ret	

;--------------------
; New event / command
;--------------------

Chan_NextEvent:			;50879 - c6bf
	ld	l,(ix+00h)
	ld	h,(ix+01h)
	ld	a,(hl)
	inc	hl
	call	Save_Ptr
	bit	7,a
	jp	nz,Command_Dispatch
	ld	(tmp2),hl
	or	a
	jr	z,Zero_Note
	add	a,(ix+0fh)
	ld	(ix+12h),a
	res	3,(ix+0eh)
	dec	a
	add	a,a
	ld	e,a
	ld	d,00h
	ld	hl,FREQ_TABLE
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(tmp2)
	jr	Note_Duration

Zero_Note:
	ld	de,0

;-----------------
; Duration + setup
;-----------------

Note_Duration:
	ld	a,(hl)
	inc	hl
	call	Save_Ptr
	ld	(ix+02h),a
	ld	(ix+07h),e
	ld	(ix+08h),d
	ld	a,(ix+10h)
	ld	(ix+0ch),a
	ld	a,(ix+11h)
	ld	(ix+0dh),a
	set	2,(ix+0eh)
	bit	1,(ix+0eh)
	jp	nz,Chan_Tick
	bit	0,(ix+0eh)
	jp	z,Load_Envelope
	set	1,(ix+0eh)

Load_Envelope:
	ld	c,(ix+0ah)
	ld	b,(ix+0bh)
	ld	a,(bc)
	ld	(ix+09h),a
	inc	bc
	ld	a,(bc)
	inc	bc
	ld	(ix+06h),a
	ld	(ix+04h),c
	ld	(ix+05h),b
	jp	Chan_Output

;-----------------
; Command dispatch
;-----------------

Command_Dispatch:
	and	7fh		;zruš bit7
	ld	(tmp2),hl	;ulož ukazatel
	add	a,a		;Cmd x2
	ld	e,a		;dej do DE
	ld	d,0
	ld	hl,Command_Table	;báze tabulky příkazů
	add	hl,de		;indexuj
	ld	a,(hl)		;vyzvedni adresu příslušné rutiny
	inc	hl
	ld	h,(hl)
	ld	l,a		;do HL
	push	hl		;dej ji na zásobník (vrátíme se přes ni)
	ld	hl,(tmp2)	;obnov ukazatel
	ret			;a návrat

; ============================================================
; COMMAND JUMP TABLE
; ============================================================
; Used by Command_Dispatch
; Must be at ORG 51026
; ============================================================
Command_Table:			;51026 - c752
	dw	Cmd_Jump	;Cmd_SetPtr 51056		80 Jump
	dw	Cmd_Call	;Cmd_SetPtrPush 51068		81 Call
	dw	Cmd_Loop	;Cmd_LoopStart 51082		82 Loop
	dw	Cmd_Next	;Cmd_LoopEnd 51092		83 Next
	dw	Cmd_Noise	;Cmd_SetTempo 51110		84 Noise
	dw	Cmd_Type	;Cmd_SetVolume 51121		85 Type
	dw	Cmd_Vib		;Cmd_SetPitchBase 51166		86 Vib
	dw	Cmd_Env		;Cmd_SetInstrument 51132	87 Env
	dw	Cmd_TR		;Cmd_SetTranspose 51148		88 TR
	dw	Cmd_Ret		;Cmd_Return 51159		89 Ret
	dw	Cmd_Leg_pl	;Cmd_FlagsOn 51182		8a Leg+
	dw	Cmd_Leg_mi	;Cmd_FlagsOff 51196		8b Leg-
	dw	Cmd_CallSub	;Cmd_CallSub 51210		8c Externall_Call (Indiana Jones 3 only)
	dw	Cmd_Noise_pl	;Cmd_AdjustGlobVolume 51223	8d Noise+
	dw	Cmd_TR_pl	;Cmd_RelTranspose 51239		8e TR+

; ============================================================
; COMMAND ROUTINES
; ============================================================

Cmd_Jump:			;51056 - c770
	ld	a,(hl)
	ld	(ix+00h),a
	inc	hl
	ld	a,(hl)
	ld	(ix+01h),a
	jp	Chan_NextEvent

Cmd_Call:			;51068 - c77C
	ld	a,(hl)
	ld	(ix+00h),a
	inc	hl
	ld	a,(hl)
	ld	(ix+01h),a
	inc	hl
	push	hl
	jp	Chan_NextEvent

Cmd_Loop:			;51082 - c78a
	ld	b,(hl)
	push	bc
	inc	hl
	push	hl
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_Next:			;51092 - c794
	pop	de
	pop	bc
	djnz	LoopCont
	jp	Chan_NextEvent

LoopCont:
	push	bc
	push	de
	ld	(ix+00h),e
	ld	(ix+01h),d
	jp	Chan_NextEvent

Cmd_Noise:			;51110 - c7a6
	ld	a,(hl)
	inc	hl
	ld	(GLOBAL_Noise),a
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_Type:			;51121 - c7b1
	ld	a,(hl)
	inc	hl
	call	Save_Ptr
	ld	(ix+03h),a
	jp	Chan_NextEvent

Cmd_Env:			;51166 - c7de
	ld	a,(hl)
	ld	(ix+0ah),a
	inc	hl
	ld	a,(hl)
	ld	(ix+0bh),a
	inc	hl
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_TR:				;51148 - c7cc
	ld	a,(hl)
	inc	hl
	call	Save_Ptr
	ld	(ix+0fh),a
	jp	Chan_NextEvent

Cmd_Ret:			;51159 - c7d7
	pop	hl
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_Vib:			;51166 - c7de
	ld	a,(hl)
	ld	(ix+10h),a
	inc	hl
	ld	a,(hl)
	ld	(ix+11h),a
	inc	hl
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_Leg_pl:			;51182 - 0c7ee
	set	0,(ix+0eh)
	res	1,(ix+0eh)
	call	Save_Ptr
	jp	Chan_NextEvent
	
Cmd_Leg_mi:			;51196 - c7fc
	res	0,(ix+0eh)
	res	1,(ix+0eh)
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_CallSub:			;51210 - c80a = Externall_Call (Indiana Jones 3 only)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	call	Save_Ptr
	ld	bc,Chan_NextEvent
	push	bc
	push	de
	ret	

Cmd_Noise_pl:			;51223 - c817
	ld	a,(GLOBAL_Noise)
	add	a,(hl)
NoPl:	and	1fh
	ld	(GLOBAL_Noise),a
	inc	hl
	call	Save_Ptr
	jp	Chan_NextEvent

Cmd_TR_pl:			;51239 - c827
	ld	a,(hl)
	add	a,(ix+0fh)
	ld	(ix+0fh),a
	inc	hl
	call	Save_Ptr
	jp	Chan_NextEvent


channels:
	dw	0aa56h
	dw	0aafdh
	dw	0abbdh
	db	135
	
;data melodie "A"
;----------------	
;makra a návěští pro definice skladeb
;------------------------------------

#macro	Jmp	adresa		;Jump
	db	80h
	dw	adresa
#endm
#macro	Cal	adresa		;Call
	db	81h
	dw	adresa
#endm
#macro	Lop	pocet		;Loop
	db	82h
	db	pocet
#endm
#macro	Nxt			;Next
	db	83h
#endm	
Noi	equ	84h		;Noise
Typ	equ	85h		;Type

#macro	Vib	adresa		;Vib
	db	86h
	dw	adresa
#endm
#macro	Env	adresa		;Env
	db	87h
	dw	adresa
#endm
Trn	equ	88h		;TR
#macro	Rtn			;Ret
	db	89h
#endm
#macro	Lgp			;Leg+
	db	8Ah
#endm
#macro	Lgm			;Leg-
	db	8Bh
#endm
#macro	Exc	adresa	;External call (Indiana Jones 3 only)
	db	8Ch
	dw	adresa
#endm
#macro	Nsp		;Noise+
	db	8Dh
#endm
#macro	Trp		;TR+
	db	8Eh
#endm

;data melodie "A"
;----------------
MusA:	dw	MusA1
	dw	MusA2
	dw	MusA3

MusA1:	Env	ld05e
	Vib	ld07a
	db	00h, 04h, 51h, 7Ch
	Env	ld14d
	Vib	ld057
	db	45h, 40h, 46h, 40h, 45h, 40h, 4Ah, 40h
	db	45h, 40h, 46h, 40h, 45h, 40h, 3Eh, 40h
	Cal	lcc8f
	db	39h, 40h
	Lgp
	Vib	ld07a
	db	39h,80h
	Lgm
	db	0, 40h
	Cal	lcbfd
	Cal	lcbb5
	Cal	lcb4c
	Cal	lcb37
	Cal	lcbfd
	Cal	lcbb5
	Cal	lcb4c
	Cal	lcb37
	Cal	lca7f
	Cal	lcc8f
	Cal	lcbfd
	Env	ld0ec
	db	0, 0, 0, 0
	Vib	ld129
	db	2Dh,60h
	Vib	ld13f
	db	2Bh, 10h, 2Ch, 10h
	Vib	ld129
	db	2Dh, 68h
	Vib	ld13f
	db	2Dh, 08h, 30h, 08h, 32h, 08h, 32h, 60h
	Vib	ld129
	db	2Bh, 20h, 2Dh, 68h
	Vib     ld13f
	db	28h, 08h, 2Bh, 08h, 2Dh, 08h
	db	2Dh, 20h, 30h, 20h, 32h, 20h
	Vib	ld134
	db	31h, 10h, 30h, 10h, 2Dh, 68h
	Vib     ld13f
	db	2Dh, 08h, 30h, 08h, 32h, 08h
	db	33h, 04h, 34h, 3Ch, 33h, 04h, 32h, 14h
	db	30h, 18h, 2Bh, 10h
	Vib	ld129
	db	2Dh, 68h
	Vib	ld13f
	db	2Dh, 08h, 34h, 08h
	db	37h, 08h
	Lop	10h
	db	39h, 08h, 39h, 08h
	db	38h, 08h, 39h, 08h
	Nxt
	Lop	30h
	db	45h, 04h, 48h, 04h
	Nxt
	Cal	lca6e
	db	88h, 0FEh
	Cal	lca6e
	db	88h, 0FCh
	Cal	lca6e
	db	88h, 0FAh
	Cal	lca6e
	Vib	ld07A
	Env	ld0cd
	db	88h, 00h, 48h, 00h
	db	00h, 0C0h
	Cal	lcd8f
	db	85h, 08h
	Env	ld091
	Vib	ld08d
	Lop	02h
	db	00h, 50h
	db	32h, 10h, 32h, 10h, 32h, 10h, 00h, 20h
	db	2Ch, 08h, 2Ch, 08h, 2Ch, 10h, 00h, 10h
	db	2Bh, 10h, 00h, 10h, 2Fh, 08h, 2Eh, 08h
	db	00h, 50h, 30h, 10h, 2Fh, 10h, 2Eh, 10h
	cal	lce3e
	Env	ld091
	db	00h, 38h
	db	31h, 08h, 2Fh, 08h, 2Dh, 08h
	db	2Bh, 08h, 29h, 08h, 27h, 10h
	db	88h, 0FAh
	Nxt
	db	88h, 00h
	Vib	ld0dc
	Env	ld14d
	Lop	02h
	db	2Dh, 18h, 2Fh, 08h, 30h, 18h
	db	2Dh, 04h, 2Fh, 04h, 30h, 08h, 30h, 08h
	db	2Fh, 08h, 2Dh, 08h, 2Fh, 10h, 28h, 10h
	db	2Fh, 18h, 30h, 08h, 32h, 18h, 2Fh, 04h
	db	30h, 04h, 32h, 08h, 32h, 08h, 30h, 08h
	db	2Fh, 08h, 2Dh, 20h, 34h, 10h, 39h, 10h
	db	37h, 08h, 39h, 10h, 37h, 08h, 35h, 08h
	db	35h, 08h, 34h, 08h, 32h, 08h, 34h, 10h
	db	2Dh, 18h, 35h, 10h, 32h, 08h, 34h, 18h
	db	2Fh, 04h, 30h, 04h, 32h, 08h, 32h, 08h
	db	30h, 08h, 2Fh, 08h, 2Dh, 20h
	Nxt
	Env     ld05e
	Vib	ld0B1
	Lop	02h
	db	3Eh, 10h
	db	3Bh, 08h, 3Ch, 08h, 3Eh, 10h, 3Bh, 08h
	db	3Ch, 08h, 3Eh, 04h, 40h, 04h, 3Eh, 04h
	db	3Ch, 04h, 3Bh, 08h, 3Ch, 08h, 39h, 10h
	db	41h, 08h, 40h, 08h, 3Eh, 10h, 3Bh, 08h
	db	3Ch, 08h, 3Eh, 10h, 3Bh, 08h, 3Ch, 08h
	db	40h, 04h, 41h, 04h, 40h, 04h, 3Eh, 04h
	db	40h, 08h, 44h, 08h, 45h, 20h
	Nxt
	Lop	02h
	db	39h, 08h, 45h, 10h, 41h, 08h
	db	40h, 04h, 41h, 04h, 40h, 04h, 3Eh, 04h
	db	3Ch, 10h, 3Bh, 08h, 39h, 10h, 38h, 08h
	db	39h, 20h
	lop	04h
	db	39h, 04h, 3Bh, 04h
	db	3Ch, 04h, 3Bh, 04h
	Nxt
	db	3Ch, 08h, 3Bh
	db	10h, 3Ah, 08h, 3Bh, 20h
	Lop	04h
	db	3Eh, 04h, 40h, 04h, 41h, 04h, 40h, 04h
	Nxt
	Lop	04h
	db	3Ch, 04h, 3Eh, 04h, 40h, 04h, 3Eh, 04h
	Nxt
	Lop	04h
	db	3Bh, 04h, 3Ch, 04h, 3Eh, 04h, 3Ch, 04h
	Nxt
	db	3Bh, 08h, 39h, 10h, 38h, 08h, 39h, 20h
	Nxt
	Env     ld10a
	cal	lcf3a
	db	88h, 00h
	Jmp	MusA1			;opakuj od začátku kanál 1
;
lca6e:	db	48h, 04h, 43h, 04h, 3Fh, 04h
	db	3Ch, 04h, 47h, 04h, 42h, 04h, 3Eh, 04h
lca7c:	db	3Bh, 04h
	Rtn
;
lca7f:	Env	ld05e
	Vib	ld057
	db	88h, 0Bh
	Lop	02h
	db	32h, 18h, 32h, 04h
	db	34h, 04h, 35h, 08h, 37h, 08h, 35h, 08h
	db	34h, 08h, 32h, 18h, 31h, 08h, 32h, 10h
lca9c:	db	3Eh, 04h, 40h, 04h, 41h, 04h, 40h, 04h
	db	41h, 04h, 40h, 04h, 3Eh, 08h, 00h, 04h
	db	32h, 04h, 34h, 04h, 35h, 04h, 37h, 08h
	db	35h, 08h, 34h, 08h, 32h, 08h, 31h, 08h
lcabc:	db	32h, 38h
	db	88h, 0Ch
	Nxt
	db	88h, 0FFh
	Vib	ld0dc
	Env	ld0e7
	db	2Ch, 18h
	db	2Ah, 08h, 29h, 10h, 27h, 08h, 26h, 08h
	db	27h, 18h, 29h, 08h, 27h, 20h, 2Ch, 18h
lcadc:	db	2Ah, 08h, 29h, 10h, 27h, 08h, 26h, 08h
	db	27h, 40h
	db	88h, 00h
	Env	ld05e
	Vib     ld06b
	db	32h, 18h, 32h, 04h, 34h, 04h
	db	35h, 08h, 37h, 08h, 35h, 08h, 34h, 08h
lcafc:	db	33h, 18h, 33h, 04h, 35h, 04h, 36h, 08h
	db	38h, 08h, 36h, 08h, 35h, 08h
	Env	ld09e
	db	34h, 08h, 34h, 04h, 36h, 04h, 37h
	db	08h, 36h, 08h, 34h, 08h, 33h, 08h, 34h
lcb1c:	db	08h, 32h, 08h, 30h, 08h, 30h, 04h, 32h
	db	04h, 33h, 08h, 32h, 08h, 30h, 08h, 2Fh
	db	08h, 30h, 08h, 32h, 08h
	Cal	lcb37
	db	88h, 00h
	Rtn
;
lcb37:	Env	ld05e
	Vib	ld0dc
lcb3d:	db	34h, 08h, 34h, 10h, 35h, 10h, 34h
	db	10h, 32h, 08h, 34h, 10h, 00h, 30h
	Rtn
;
lcb4c:	Env	ld0cd
	Vib	ld0dc
	Cal	lcb58
	Jmp	lcb8d
;
lcb58:	db	21h, 08h, 24h, 08h
	db	23h, 08h, 24h, 08h, 21h, 08h, 30h, 08h
	db	2Fh, 08h, 2Dh, 08h, 28h, 08h, 2Bh, 08h
	db	2Ah, 08h, 2Bh, 08h, 28h, 08h, 37h, 08h
	db	36h, 08h, 34h, 08h, 88h, 0FEh, 2Dh, 08h
	db	30h, 08h, 2Fh, 08h, 30h, 08h, 2Dh, 08h
	db	3Ch, 08h, 3Bh, 08h, 39h, 08h, 88h, 00h
	Rtn
;
lcb8d:	db	88h, 05h, 3Ch, 08h, 3Bh, 08h, 39h
	db	08h, 34h, 08h, 30h, 08h, 2Fh, 08h, 2Dh
	db	08h, 28h, 08h, 88h, 00h
	Cal	lcb58
	db	2Dh, 08h, 30h, 08h, 2Fh, 08h, 30h, 08h
	db	2Dh, 08h, 30h, 08h, 32h, 08h, 33h, 08h
	Rtn
;
lcbb5:	Env	ld09e
	Vib	ld057
	db	88h, 00h
lcbbd:	Cal	lcbc8
	db	88h, 05h
	cal	lcbc8
	db	88h, 00h
	Rtn

;
lcbc8:	Env	ld05e
	db	3Eh, 40h, 00h, 10h
	Env	ld09e
	db	41h, 04h
	db	40h, 04h, 41h, 04h, 40h, 04h, 41h, 08h
lcbdc:	db	43h, 08h, 41h, 08h, 40h, 08h
	Env	ld05e
	db	3Eh, 40h
	Env	ld09e
	db	00h, 10h
	db	41h, 04h, 40h, 04h, 41h, 04h, 40h, 04h
	db	41h, 08h, 43h, 08h, 41h, 08h, 3Eh, 08h
	Rtn
;
lcbfd:	Env	ld09e
	Vib	ld0b1
	db	2Dh
	db	08h, 34h, 04h, 34h, 04h, 33h, 08h, 34h
	db	08h, 39h, 08h, 34h, 08h, 33h, 08h, 34h
	db	08h, 2Dh, 08h, 34h, 04h, 34h, 04h, 33h
lcc1c:	db	08h, 34h, 08h, 39h, 08h, 38h, 08h, 39h
	db	08h, 3Bh, 08h, 3Ch, 08h, 3Eh, 04h, 3Ch
	db	04h, 3Bh, 08h, 39h, 08h, 41h, 08h, 43h
	db	04h, 41h, 04h, 40h, 08h, 3Eh, 08h
	Env	ld05e
lcc3e:	db	40h, 3Ch, 00h, 04h
	Env	ld09e
	db	2Dh, 08h, 34h, 04h, 34h, 04h, 33h
	db	08h, 34h, 08h, 39h, 08h, 34h, 08h, 33h
	db	08h, 34h, 08h, 2Dh, 08h, 34h, 04h, 34h
lcc5c:	db	04h, 33h, 08h, 34h, 08h, 39h, 08h, 38h
	db	08h, 39h, 08h, 3Bh, 08h, 3Ch, 08h, 3Eh
	db	04h, 3Ch, 04h, 3Bh, 08h, 39h, 08h, 41h
	db	08h, 43h, 04h, 41h, 04h, 40h, 08h, 3Eh
lcc7c:	db	08h, 3Ch, 08h, 3Eh, 04h, 3Ch, 04h, 3Bh
	db	08h, 40h, 08h
	Env	ld05e
	db	39h, 1Ch, 00h, 04h
	Rtn

lcc8f:	Env	ld05e
	Vib	ld06b
	db	26h, 38h, 26h, 08h, 29h, 38h, 29h
lcc9c:	db	08h, 28h, 38h, 28h, 08h, 2Bh, 38h, 00h
	db	08h, 29h, 38h, 29h, 08h, 2Ch, 38h, 2Ch
	db	08h, 2Bh, 38h, 2Bh, 08h, 8Ah, 2Eh, 20h
	db	2Dh, 04h, 2Ch, 04h, 2Bh, 04h, 2Ah, 04h
lccbc:	db	29h, 04h, 28h, 04h, 27h, 04h, 26h, 04h
	db	8Bh, 2Ah, 38h, 2Ah, 08h, 2Dh, 38h, 2Dh
	db	08h, 2Ch, 38h, 2Ch, 08h, 2Fh, 38h, 00h
	db	08h, 2Dh, 38h, 2Dh, 08h, 30h, 38h, 30h
lccdc:	db	08h, 2Fh, 38h, 2Fh, 08h, 8Ah, 32h, 28h
	db	33h, 04h, 34h, 04h, 35h, 04h, 36h, 04h
	db	37h, 04h, 38h, 04h, 8Bh
	Rtn
;
lccf2:	db	88h, 0FDh
	Jmp	lcc8f

MusA2:	db	85h, 08h
	Vib	ld07a
lccfc:	Env	ld05e
	db	51h, 00h, 00h, 00h, 00h, 80h
	Cal	lccf2
	db	88h, 00h
	db	30h, 40h
	db	8Ah
	Vib	ld07a
	db	30h, 80h
	db	88h, 00h
	db	8Bh 
	Cal	lcd8f
	Lop	30h
	Cal	lcdc3
lcd1c:	Nxt
	Cal	lcdef
	lop	30h
	Cal	lcdc3
	Nxt
	Cal	lcdef
	Lop	1Ch
	Cal	lcdc3
	Nxt
	db	85h, 08h
	Vib	ld08d
	Env	ld0e7
	db	2Dh, 08h, 00h, 08h
lcd3c:	db	28h, 08h, 00h, 28h, 2Ch, 08h, 00h, 08h
	db	27h, 08h, 00h, 28h
	Cal	lcdef
	db	88h, 00h
	db	85h, 08h
	Vib	ld07e
	Lop	10h
	Env	ld0bc
	db	0Eh, 08h, 00h, 08h, 81h
lcd5c:	db	3Eh, 0CEh
	Env	ld0bc
	db	15h, 10h
	Cal	lce3e
	Nxt
	Lop	90h
	cal	lcdc3
	Nxt
	db	85h, 08h
	Env	ld091
	Vib	ld08d
	db	88h, 00h
	Lop	2Ch
	db	28h, 10h
	Cal	lce3e
	Env	ld091
	db	23h, 10h
	cal	lce3e
	Env	ld091
	Nxt
	db	85h, 08h
	Jmp	MusA2			;opakování kanálu 2
;
lcd8f:	db	00h, 08h
	Env	ld091
	Vib	ld08d
	db	2Fh, 08h, 2Fh, 08h, 2Dh, 08
	db	2Bh, 08h, 2Bh, 08h, 85h, 01h, 84h
	db	1Eh, 8Ah
	Env	ld05e
	db	07h, 02h, 84h
	db	19h, 07h, 02h, 84h, 14h, 07h, 02h, 84h
	db	0Fh, 07h, 02h, 84h, 0Ah, 07h, 02h, 84h
	db	05h, 07h, 02h, 00h, 04h, 8Bh
	Rtn

lcdc3:	db	85h, 00h
	db	84h, 00h
	Env	ld09e
	db	07h, 01h
	db	00h, 07h, 07h, 01h, 00h, 03h, 07h, 01h
	db	00h, 03h, 8Ah, 84h, 19h, 07h, 02h, 84h
lcddc:	db	14h, 07h, 02h, 84h, 0Fh, 07h, 02h, 84h
	db	0Ah, 07h, 03h, 84h, 05h, 07h, 03h, 00h
	db	04h, 8Bh
	Rtn

lcdef:	db	88h, 00h, 85h, 08h
	Vib     ld057
	Env	ld05e
	db	34h, 08h, 34h
lcdfc:	db	10h, 35h, 10h, 34h, 10h, 32h, 08h, 34h
	db	10h
	Vib	ld08d
	db	2Ch, 08h, 2Ch, 08h
	Env	ld05e
	db	84h, 1Fh, 85h, 01h, 8Ah
	db	07h, 03h, 84h, 1Ch, 07h, 03h, 84h, 19h
lce1c:	db	07h, 03h, 84h, 16h, 07h, 03h, 84h, 13h
	db	07h, 03h, 84h, 10h, 07h, 03h, 84h, 0Dh
	db	07h, 03h, 84h, 0Ah, 07h, 03h, 84h, 07h
	db	07h, 03h, 84h, 04h, 07h, 05h, 8Bh, 85h
lce3c:	db	08h
	Rtn

;
lce3e:	Env	ld0fd
	db	85h, 01h, 8Ah
	db	84h, 0Fh, 07h, 02h, 84h, 0Ch, 07h, 02h
	db	84h, 09h, 07h, 02h, 84h, 06h, 07h, 02h
	db	84h, 03h, 07h, 02h, 84h, 00h, 07h, 02h
lce5c:	db	84h, 00h, 07h, 02h, 84h, 00h, 07h, 02h
	db	8Bh, 85h, 08h
	Rtn

MusA3:	db	85h, 08h
	Env	ld05e
	Vib	ld148
	Lop	34h
	db	02h, 20h
	Nxt
	Lop	04h
	Cal	lcfa0
	Nxt
	Cal     lcfb4
	cal	lcfe1
	Cal	ld00a
	Cal	ld022
	db	85h, 08h
	db	88h, 00h
	Cal	lcfb4
	Cal	lcfe1
	Cal	ld00a
	Cal	ld022
	db	85h, 08h
	db	88h, 00h
	Cal	lcf63
	db	85h, 08h
	Cal	lccf2
	Cal	lcfb4
	Lop	08h
	db	88h, 00h
	Cal	lcf8a
	db	88h, 0FEh
	Cal	lcf8a
	db	88h, 0F9h
	Cal	lcf8a
	db	88h, 00h
	Cal	lcf8a
	Nxt
	Lop	02h
	db	88h, 00h
	Cal	lcfa0
	Cal	lcfad
	db	88h, 0FBh
	Cal	lcfa0
	Cal	lcfa0
	db	88h, 00h
	Cal	lcfa0
	Cal	lcfad
	db	11h, 10h, 1Ch, 08h, 1Dh
lcedc:	db	08h
	Cal	lcfad
	db	11h, 10h, 1Ch, 08h
	db	1Dh, 08h
	cal	lcfad
	db	10h, 10h, 1Bh
	db	08h, 1Ch, 08h
	cal	lcfad
	Nxt
	Lop	04h
	db	88h, 0FBh
	cal	lcfad
	cal	lcfa0
lcefd:	db	88h, 00h
	cal	lcfad
	Nxt
	Lop	02h
	cal	lcfa0
	cal	lcfa0
	cal	lcfa0
	db	88h, 0FBh
	cal	lcfa0
	cal	lcfa0
	db	88h, 00h
	cal	lcfa0
	db	88h, 0FBh
	cal	lcfa0
	db	88h, 00h
	cal	lcfa0
	Nxt
	db	3Eh, 40h, 3Fh, 40h
	db	40h, 40h, 41h, 40h
	Jmp	MusA3
	
lcf31:	Vib	ld13F
	cal	lcf3a
	Jmp	MusA3
;
lcf3a:	db	88h, 0FDh
	cal	lcf4f
	db	88h, 0FEh
	cal	lcf4f
	db	88h, 0FFh
	cal	lcf4f
	db	88h, 00h
	cal	cf4Fh
	Rtn
;
lcf4f:	Lop	02h
	db	41h, 04h, 44h
	db	04h, 43h, 04h, 41h, 04h, 43h, 04h, 46h
	db	04h, 44h, 04h, 43h, 04h
	Nxt
	Rtn
;
lcf63:	db	88h, 0FDh
	Lop	04h
	Cal	lcfa0
	Nxt
	db	88h, 0FEh
	Lop	07h
	Cal	lcfa0
	Nxt
	db	88h, 0F9h
	Cal	lcfa0
	Cal	lcfa0
	db	88h, 0FAh
	Cal	lcfa0
	db	88h, 00h
	db	1Ch, 40h
	db	18h, 40h
	Cal	ld022
	Rtn

lcf8a:	Env	ld0bc
	Vib	ld07e
	Lop	02h
	db	15h, 10h, 20h, 08h
	db	21h, 08h, 15h, 10h
	db	13h, 08h, 14h, 08h
	Nxt
	Rtn
;
lcfa0:	Env	ld0bc
	Vib	ld07e
	Cal	lcfad
	Cal	lcfad
	Rtn
;
lcfad:	db	15h, 10h, 20h, 08h, 21h, 08h
	Rtn
;
lcfb4:	db	88h, 00h
	Cal	lcfa0
	Cal	lcfa0
lcfbc:	db	88h, 0FCh
	cal	lcfa0
	db	88h, 00h, 10h
	db	10h, 12h, 10h, 13h, 10h, 14h, 10h
	Cal	lcfa0
	Cal	lcfa0
	db	88h, 0FCh
	Cal	lcfa0
	db	88h, 0FBh
	Cal	lcfad
	db	88h, 00h
lcfdd:	Cal	lcfad
	Rtn

lcfe1:	db	88h, 00h, 82h
	db	02h, 0Eh, 10h, 1Ah, 10h, 0Eh, 10h, 1Ah
	db	10h, 11h, 10h, 1Dh, 10h, 11h, 10h, 1Dh
	db	10h, 83h, 82h, 02h, 13h, 10h, 1Fh, 10h
	db	13h, 10h, 1Fh, 10h, 16h, 10h, 22h, 10h
	db	16h, 10h, 22h, 10h, 83h
	Rtn
;
ld00a:	db	82h, 02h
	db	88h, 00h
	Cal	lcfa0
	db	88h, 0FBh
	Cal	lcfa0
	db	88h, 0FEh
	Cal	lcfa0
	db	88h, 05h
	Cal	lcfa0
	db	83h
	Rtn
;
ld022:	Env	ld05e
	db	8Ah, 84h, 00h, 85h, 01h, 07h, 05h
	db	84h, 04h, 07h, 05h, 84h, 08h, 07h, 05h
	db	84h, 0Ch, 07h, 05h, 84h, 10h, 07h, 05h
ld03c:	db	84h, 14h, 07h, 05h, 84h, 18h, 07h, 05h
	db	84h, 1Ch, 07h, 05h, 84h, 1Fh, 07h, 08h
	db	8Bh, 00h, 30h, 82h, 08h, 07h, 01h, 00h
	db	03h, 83h
	Rtn
;
ld057:	db	00h, 0FFh, 01h, 00h
	Jmp	ld057

;
ld05e:	db	0Fh, 02h, 0Eh, 02h, 0Dh, 02h
	db	0Ch, 02h, 0Bh, 0C7h, 80h, 5Eh, 0D0h

ld06b:	db	02h
	db	02h, 01h, 0FFh, 0FEh, 0FEh, 0FEh, 0FEh, 0FFh
	db	01h, 02h, 02h, 80h, 6Bh, 0D0h
;
ld07a:	db	04h, 80h
	db	7Ah, 0D0h

ld07e:	db	05h, 05h, 05h, 0FBh, 0FBh, 0FBh
	db	0FBh, 0FBh, 0FBh, 05h, 05h, 05h
	Jmp	ld07e
ld08d	db	14h
	Jmp	ld08d
ld091:	db	0Fh, 03h, 0Eh
	db	02h, 0Dh, 02h, 0Ch, 07h, 00h, 0FAh
	Jmp	ld091
ld09e:	db	0Fh, 01h, 0Eh, 01h, 0Dh, 01h
	db	0Ch, 01h, 0Bh, 02h, 0Ah, 02h, 09h, 02h
	db	00h, 0C7h
	jmp	ld09e
ld0b1:	db	01h, 01h, 0FFh
	db	0FFh, 0FFh, 0FFh, 01h, 01h
	Jmp	ld0b1
ld0bc:	db	0Fh, 01h, 0Eh, 02h, 0Dh, 01h, 0Ch, 01h
	db	0Bh, 01h, 0Ah, 01h, 09h, 01h
	Jmp	ld0bc
ld0cd	db	0Fh, 02h, 00h, 01h, 0Dh, 02h, 00h
	db	01h, 0Bh, 01h, 00h, 01h
	Jmp	ld0cd
ld0dc:	db	0FCh, 04h, 04h, 0FCh, 0F8h, 08h, 08h, 0F8h
	Jmp	ld0dc
ld0e7:	db	0Eh, 0C7h
	Jmp	ld0e7
ld0ec:	db	00h, 01h, 0Fh, 01h, 0Eh, 01h, 0Dh, 46h
	db	0Ch, 09h, 0Bh, 09h, 0Ah, 0C7h
	jmp	ld0ec

ld0fd:	db	0Dh, 02h, 0Ch, 02h, 0Bh, 02h, 0Ah
	db	02h, 09h, 0DEh
	Jmp	ld0fd
ld10a:	db	0Dh, 03h
	db	00h, 01h, 0Bh, 01h, 00h, 01h, 09h, 01h
	db	00h, 01h, 07h, 01h, 00h, 01h, 05h, 01h
ld11c:	db	00h, 01h, 03h, 01h, 00h, 01h, 01h, 01h
	db	00h, 0C7h
	Jmp	ld10a
ld129:	db	15h, 0FDh, 0FDh
	db	0FDh, 0FDh, 0FDh, 0FDh, 0FDh
	Jmp	ld13f
ld134:	db	0EBh, 03h, 03h, 03h, 03h, 03h, 03h, 03h
ld13c:	Jmp	ld13f

ld13f:	db	02h, 01h, 0FFh, 0FEh, 0FFh
	db	01h
	Jmp	ld13f

ld148:	db	3Ch
ld149:	db	03h
	Jmp	ld149
;
ld14d:	db	0Fh, 02h, 00h, 01h, 0Fh, 02h, 00h
	db	01h, 0Eh, 02h, 00h, 01h, 0Eh, 02h, 00h
ld15c:	db	01h, 0Dh, 02h, 00h, 01h, 0Ch, 02h, 00h
	db	01h, 0Bh, 02h, 00h, 01h, 0Ah, 02h, 00h
	db	01h
ld16d:	db	09h, 02h, 00h, 01h
	Jmp	ld16d

	db	0,0,0,0,0	;trošku místa

MusB:	incbin	"Fuxoft -B-d179- Master of Magic.bin"

	db	0,0

MusC:	incbin	"Fuxoft -C-d4da- Magnetic Fields IV.bin"

	db	0,0
MusD:	incbin	"Fuxoft -D-d7b4- Terra Cresta.bin"

	db	0,0,0

MusE:	incbin	"Fuxoft -E-d9d5- ZUB.bin"

	db	0,0,0,0,0

MusF:	incbin	"Fuxoft -F-deb2- Crazy Comets and Penetrator.bin"

	db	0,0,0,0,0,0

MusG:	incbin	"Fuxoft -G-e14b- Fugue.bin"

	db	0,0,0,0,0

MusH:	incbin	"Fuxoft -H-e894- Feud.bin"

	db	0,0,0
	
MusI:	incbin	"Fuxoft -I-ec31- The Last V8.bin"

	db	0,0,0

MusJ:	incbin	"Fuxoft -J-ee8e- Chimera.bin"

	db	0,0,0,0,0,0,0

MusK:	incbin	"Fuxoft -K-f23a- Commando.bin"

	db	0,0

MusL:	incbin	"Fuxoft -L-f9b0- Ghostbusters.bin"
