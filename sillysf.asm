//------------------------------------------------------------------------
//	Silly Starfield by SuN 2019 grzegorzsun@gmail.com
//------------------------------------------------------------------------

Timer equ 552
VTimr equ 538

	org	$9f2f
go equ *
    mva #$1 755; cursor off

// initialization
    ldy #255
in	lda $d20a
	sta tab,y
	lda $d20a
	and #3
	adc #1
	sta tad,y
	dey
	bne in
	
// timer do mrygania gwiazdami
    lda #150
    ldx <mrygaj
    ldy >mrygaj
    stx Timer
    sty Timer+1
    sta Vtimr
	
	ldy	#0
	sty 710; tlo
	sty	$d008; size player0
	sty $d009; size player1
    iny
    sty $D00D; rejestr grafiki gracza 0    
	sty $D00E; rejestr grafiki gracza 1

    tya; y=1 do akumulatora
//------------------------------------------------------------------------
//	Animacja
//------------------------------------------------------------------------

loop lda $D40B; vcount
     sta $d40a;
     bne loop
	
    ldy	#220
rp  lda tab,y
    sta $D40A; wsync
    sta $D000; pozycja player0
    tax
	eor #$ff
	sta $D001; pozycja player1
	txa
    adc tad,y
	sta tab,y
	
// kolorujemy gwiazdy
;    tax
mryg tya; to zmieniamy albo na nop albo na tya na timerze :)
	sta $D017; kolor
    and #$0f
    sta $D012; kolor player0
;    eor #$f0
	sta $D013; kolor player1
;	txa

    dey
	bne	rp

;up  lda:cmp:req 20
    jmp	loop

//------------------------------------------------------------------------
mrygaj equ *
      lda #200
	sta Vtimr
	lda mryg
	cmp #$ea; czy to NOP?
	beq etya; jest to NOP!
	lda #$ea; kod NOP
	sta mryg
	rts
etya 	lda #$98; kod TYA
       sta mryg
	   rts

tab equ *
tad equ *+256
sw  equ *+256
// tekst prosto w pamiêæ ekranu bez basica
	org	$bc40+9+400
	dta	d'-=[ Silly Starfield ]=-'
// kolejne wiersze logosa :)
	org $bc40+12+400+80
	dta d'   ***  *   *'
	org $bc40+12+400+120
	dta d'  *     *   *'
	org $bc40+12+400+160
	dta d'   **   *   *'
	org $bc40+12+400+200
	dta d'     *   * *'
	org $bc40+12+400+240
	dta d'  ***     *'    

//------------------------------------------------------------------------
	run	go
