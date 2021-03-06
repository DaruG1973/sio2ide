;
; File generated by cc65 v 2.8.0
;
	.fopt		compiler,"cc65 v 2.8.0"
	.autoimport	on
	.case		on
	.debuginfo	on
	.importzp	sp, sreg, regsave, regbank, tmp1, ptr1, ptr2
	.macpack	longbranch
	.dbg		file, "qsort.c", 2483, 1279048568
	.dbg		file, "plat.h", 1225, 1279048568
	.dbg		file, "type.h", 1140, 1279048570
	.dbg		file, "C:\Work\CMPLRS\cc65\include/atari.h", 9513, 1030607464
	.dbg		file, "C:\Work\CMPLRS\cc65\include/_gtia.h", 5733, 1018643664
	.dbg		file, "C:\Work\CMPLRS\cc65\include/_pbi.h", 3057, 1018643664
	.dbg		file, "C:\Work\CMPLRS\cc65\include/_pokey.h", 4268, 1018643664
	.dbg		file, "C:\Work\CMPLRS\cc65\include/_pia.h", 2655, 1018643664
	.dbg		file, "C:\Work\CMPLRS\cc65\include/_antic.h", 3412, 1018643664
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/cfg.h", 800, 1279048570
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/ptable.h", 2129, 1279048570
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/direntry.h", 4014, 1279048570
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/iso.h", 8718, 1279048570
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/idestruc.h", 1307, 1279048570
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/fatstruc.h", 3099, 1279048570
	.dbg		file, "C:\Work\Projects\SIO2IDE\\VER.400\SOFT\AVR\FAT_1632/siocmds.h", 2388, 1279048570
	.dbg		file, "keys.h", 865, 1279048568
	.dbg		file, "siosrv.h", 1744, 1279048568
	.dbg		file, "screen.h", 1856, 1279048568
	.dbg		file, "menu.h", 1328, 1279048568
	.dbg		file, "listv.h", 1458, 1279048568
	.dbg		file, "qsort.h", 847, 1279048568
	.export		_QuickSort

.segment	"BSS"

_Cmp:
	.res	2,$00
_Swp:
	.res	2,$00

; ---------------------------------------------------------------
; void QuickSort (signed short, signed short, function returning signed short*, function returning void*)
; ---------------------------------------------------------------

.segment	"CODE2"

.proc	_QuickSort

	.dbg	line, "qsort.c", 120
	ldy     #$03
	jsr     ldaxysp
	sta     _Cmp
	stx     _Cmp+1
	.dbg	line, "qsort.c", 121
	ldy     #$01
	jsr     ldaxysp
	sta     _Swp
	stx     _Swp+1
	.dbg	line, "qsort.c", 123
	ldy     #$09
	jsr     pushwysp
	ldy     #$09
	jsr     pushwysp
	jsr     _IntQuickSort
	.dbg	line, "qsort.c", 124
	jmp     incsp8
	.dbg	line

.endproc

; ---------------------------------------------------------------
; void IntQuickSort (signed short, signed short)
; ---------------------------------------------------------------

.segment	"CODE2"

.proc	_IntQuickSort

	.dbg	line, "qsort.c", 92
	jsr     decsp4
	ldy     #$07
	jsr     ldaxysp
	jsr     decax1
	ldy     #$02
	jsr     staxysp
	.dbg	line, "qsort.c", 93
	ldy     #$05
	jsr     ldaxysp
	ldy     #$00
	jsr     staxysp
	.dbg	line, "qsort.c", 95
	ldy     #$07
	jsr     pushwysp
	ldy     #$09
	jsr     ldaxysp
	jsr     tosicmp
	jmi     incsp8
	jeq     incsp8
	.dbg	line, "qsort.c", 99
L00DD:	ldy     #$02
	ldx     #$00
	lda     #$01
	jsr     addeqysp
	jsr     pushax
	ldy     #$09
	jsr     pushwysp
	lda     _Cmp
	ldx     _Cmp+1
	ldy     #$04
	jsr     callax
	cpx     #$00
	bmi     L00DD
	.dbg	line, "qsort.c", 100
L00DF:	ldx     #$00
	lda     #$01
	ldy     #$00
	jsr     subeqysp
	jsr     pushax
	ldy     #$09
	jsr     pushwysp
	lda     _Cmp
	ldx     _Cmp+1
	ldy     #$04
	jsr     callax
	cpx     #$00
	bmi     L00E4
	ldy     #$03
	jsr     pushwysp
	ldy     #$09
	jsr     ldaxysp
	jsr     tosicmp
	bne     L00DF
	.dbg	line, "qsort.c", 102
L00E4:	ldy     #$05
	jsr     pushwysp
	ldy     #$03
	jsr     ldaxysp
	jsr     tosicmp
	bpl     L00DB
	.dbg	line, "qsort.c", 104
	ldy     #$05
	jsr     pushwysp
	ldy     #$05
	jsr     pushwysp
	lda     _Swp
	ldx     _Swp+1
	ldy     #$04
	jsr     callax
	.dbg	line, "qsort.c", 105
	jmp     L00DD
	.dbg	line, "qsort.c", 106
L00DB:	ldy     #$05
	jsr     pushwysp
	ldy     #$09
	jsr     pushwysp
	lda     _Swp
	ldx     _Swp+1
	ldy     #$04
	jsr     callax
	.dbg	line, "qsort.c", 108
	ldy     #$09
	jsr     pushwysp
	ldy     #$05
	jsr     ldaxysp
	jsr     decax1
	jsr     pushax
	jsr     _IntQuickSort
	.dbg	line, "qsort.c", 109
	ldy     #$03
	jsr     ldaxysp
	jsr     incax1
	jsr     pushax
	ldy     #$09
	jsr     pushwysp
	jsr     _IntQuickSort
	.dbg	line, "qsort.c", 110
	jmp     incsp8
	.dbg	line

.endproc

