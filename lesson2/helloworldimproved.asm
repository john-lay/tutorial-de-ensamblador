include "../hardware.inc"

section "start", ROM0[$0100]
    nop
    jp begin

rept $150 - $104
    db 0
endr

begin:
    nop 
    di                  ; disable interrupts
    ld sp, $ffff

init:
    ld a, %11100100     ; Palette colors from the darkest to
                        ; Lighter, 11 10 01 00
    ld [rBGP], a        ; We write this in the palette register
 
    ld a, 0             ; write 0 records scroll in X and Y 
    ld [rSCX], a        ; whereby the visible screen positioned
    ld [rSCY], a        ; at the beginning (upper left) of the fund.
 
    call turn_off_LCD   ; We call the routine that turns off the LCD
 
    ; We load the tiles in memory of tiles
 
    ld hl, Tiles        ; HL loaded in the direction of our tile
    ld de, _VRAM        ; address in the video memory
    ld b, 32            ; b = 32, number of bytes to copy (2 tiles)
 
.load_loop:
    ld a,[hl]           ; A load in the data pointed to by HL
    ld [de], a          ; and we put in the address pointed in DE 
    dec b               ; decrement b, b = b-1
    jr z, .fin_load_loop; if b = 0, we're finished, nothing left to copy
    inc hl              ; We increase the read direction
    inc de              ; We increase the write direction
    jr .load_loop       ; we follow

.fin_load_loop:
 
    ; We clean the screen (fill entire background map), with tile 0
 
    ld hl, _SCRN0
    ld de, 32*32        ; number of tiles on the background map

.cleanup_loop:
    ld a, 0             ; tile 0 is our empty tile 
    ld [hl], a
    dec de
    ; Now I have to check if 'from' is zero, to see if I have it 
    ; finishes copying. DEC does not modify any flag, so I can not
    ; check the zero flag directly, but to 'of' zero, dye
    ; They must be zero two, so I can make or including
    ; and if the result is zero, both are zero.
    ld a, d                 ; d loaded in to
    or e                    ; and make a or e
    jp z, .fin_cleanup_loop ; if d or e is zero, it is zero.  We ended.
    inc hl                  ; We increased the write direction
    jp .cleanup_loop

.fin_cleanup_loop
 
    ; Well, we have all the map tiles filled with tile 0,
    ; We can now paint ours
 
    ; We write our tile, tiles on the map
 
    ld hl, _SCRN0       ; HL in the direction of the background map 
    ld [hl], $01        ; $01 = the tile 1, Our tile.
 
    ; configure and activate the display 
    ld a, LCDCF_ON|LCDCF_BG8000|LCDCF_BG9800|LCDCF_BGON|LCDCF_OBJ8|LCDCF_OBJOFF
    ld [rLCDC], a
 
    ; infinite loop
loop:
    halt
    nop
    jr loop
 
; LCD shutdown routine
turn_off_LCD:
    ld a, [rLCDC]
    rlca                ; It sets the high bit of LCDC in the carry flag
    ret nc              ; Display is already off, again.
 
    ; We VBlank hope to, because we can not turn off the screen
    ; some other time
 
.wait_VBlank
    ld a, [rLY]
    cp 145
    jr nz, .wait_VBlank
 
    ; we are in VBlank, we turn off the LCD 
    ld a, [rLCDC]       ; in A, the contents of the LCDC 
    res 7, a            ; we zero bit 7 (on the LCD)
    ld [rLCDC], a       ; We wrote in the LCDC register content A
 
    ret                 ; return
 
; Our tiles
Tiles:
    DB  $00, $00, $00, $00, $00, $00, $00, $00
    DB  $00, $00, $00, $00, $00, $00, $00, $00
    DB  $7C, $7C, $82, $FE, $82, $D6, $82, $D6
    DB  $82, $FE, $82, $BA, $82, $C6, $7C, $7C
EndTiles:
