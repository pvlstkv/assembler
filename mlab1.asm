;***************************************************************************************************
; MLAB1.ASM - ćē„”­ė© ÆąØ¬„ą ¤«ļ ¢ėÆ®«­„­Øļ
; « ”®ą ā®ą­®© ą ”®āė N1 Æ® ¬ čØ­­®-®ąØ„­āØą®¢ ­­®¬ć Æą®£ą ¬¬Øą®¢ ­Øī
; 10.09.02: „£®¤  ..
;***************************************************************************************************
        .MODEL SMALL
        .STACK 200h
	.386
;       įÆ®«ģ§ćīāįļ ¤„Ŗ« ą ęØØ Ŗ®­įā ­ā Ø ¬ Ŗą®į®¢
        INCLUDE MLAB1.INC
        INCLUDE MLAB1.MAC

; „Ŗ« ą ęØØ ¤ ­­ėå
        .DATA
X DD 0
Y DD 0
Z DD 0
F1 DB 'F = TRUE', 0
F0 DB 'F = FALSE', 0
INPUT_X_STR DB 'PLEASE ENTER A BINARY X', 0
INPUT_Y_STR DB 'PLEASE ENTER A BINARY Y', 0
ERROR_NUM_STR DB 'ERROR IN INPUTED NUMBER, RECHEK IT', 0
FUNCTION DB 'f = x1x2x3 | x2!x3x4 | !x1!x2 | x1!x2x3!x4 | x3x4', 0
Z3 DB 'z3=!z3', 0
Z2 DB 'z2|=z19', 0
Z7 DB 'z7&=z8', 0
Z_STR DB 'f1 ? X/4+4*Y : X/8 - Y', 0
Z_BEFORE_DEC DB 'Z BEFORE CHANGES (DECIMAL):', 0
Z_BEFORE_BIN DB 'Z BEFORE CHANGES (BINARY):', 0
Z_AFTER_DEC DB 'Z AFTER CHANGES (DECIAML)', 0
Z_AFTER_BIN DB 'Z AFTER CHANGES (BINARY)', 0

SLINE	DB	78 DUP (CHSEP), 0
REQ	DB	" ¬Ø«Øļ ..: ",0FFh
MINIS	DB	"   ",0
ULSTU	DB	"   ",0
DEPT	DB	" ä„¤ą  ¢ėēØį«Øā„«ģ­®© ā„å­ØŖØ",0
MOP	DB	" čØ­­®-®ąØ„­āØą®¢ ­­®„ Æą®£ą ¬¬Øą®¢ ­Ø„",0
LABR	DB	" ”®ą ā®ą­ ļ ą ”®ā  N 1",0
REQ1    DB      " ¬„¤«Øāģ(-),ćįŖ®ąØāģ(+),¢ė©āØ(ESC), FUNC(1)? ",0FFh
TACTS   DB	"ą„¬ļ ą ”®āė ¢ ā Ŗā å: ",0FFh
EMPTYS	DB	0
BUFLEN = 70
BUF	DB	BUFLEN
LENS	DB	?
SNAME	DB	BUFLEN DUP (0)
PAUSE	DW	0, 0 ; ¬« ¤č„„ Ø įā ąč„„ į«®¢  § ¤„ą¦ŖØ ÆąØ ¢ė¢®¤„ įāą®ŖØ

TI	DB	LENNUM+LENNUM/2 DUP(?), 0 ; įāą®Ŗ  ¢ė¢®¤  ēØį«  ā Ŗā®¢
                                          ; § Æ į ¤«ļ ą §¤„«Øā„«ģ­ėå "`"

MYBUF DB BUFLEN


;========================= ą®£ą ¬¬  =========================
        .CODE
;  Ŗą®į § Æ®«­„­Øļ įāą®ŖØ LINE ®ā Æ®§ØęØØ POS į®¤„ą¦Ø¬ė¬ CNT ®”ź„Ŗā®¢,
;  ¤ą„įć„¬ėå  ¤ą„į®¬ ADR ÆąØ čØąØ­„ Æ®«ļ ¢ė¢®¤  WFLD
BEGIN	LABEL	NEAR
	; Ø­ØęØ «Ø§ ęØļ į„£¬„­ā­®£® ą„£Øįāą 
	MOV	AX,	@DATA
	MOV	DS,	AX
	; Ø­ØęØ «Ø§ ęØļ § ¤„ą¦ŖØ
	MOV	PAUSE,	PAUSE_L
	MOV	PAUSE+2,PAUSE_H

	PUTLS	REQ	; § Æą®į Ø¬„­Ø
	; ¢¢®¤ Ø¬„­Ø
	LEA	DX,	BUF
	CALL	GETS

@@L:	; ęØŖ«Øē„įŖØ© Æą®ę„įį Æ®¢ā®ą„­Øļ ¢ė¢®¤  § įā ¢ŖØ
	; ¢ė¢®¤ § įā ¢ŖØ
	;    
	FIXTIME
	PUTL	EMPTYS
	PUTL	SLINE	; ą §¤„«Øā„«ģ­ ļ ē„ąā 
	PUTL	EMPTYS
	PUTLSC	MINIS	; Æ„ą¢ ļ
	PUTL	EMPTYS
	PUTLSC	ULSTU	;  Ø
	PUTL	EMPTYS
	PUTLSC	DEPT	;   Æ®į«„¤ćīéØ„
	PUTL	EMPTYS
	PUTLSC	MOP	;    įāą®ŖØ
	PUTL	EMPTYS
	PUTLSC	LABR	;     § įā ¢ŖØ
	PUTL	EMPTYS
	; ÆąØ¢„āįā¢Ø„
	PUTLSC	SNAME   ;  įāć¤„­ā 
	PUTL	EMPTYS
	; ą §¤„«Øā„«ģ­ ļ ē„ąā 
	PUTL	SLINE
	;    
	DURAT    	; Æ®¤įē„ā § āą ē„­­®£® ¢ą„¬„­Ø
	; ą„®”ą §®¢ ­Ø„ ēØį«  āØŖ®¢ ¢ įāą®Ŗć Ø ¢ė¢®¤
	LEA	DI,	TI
	CALL	UTOA10
	PUTL	TACTS
	PUTL	TI      ; ¢ė¢®¤ ēØį«  ā Ŗā®¢
	; ®”ą ”®āŖ  Ŗ®¬ ­¤ė
	PUTL	REQ1
	CALL	GETCH
	CMP	AL,	'-'    ; ć¤«Ø­­ļāģ § ¤„ą¦Ŗć?
	JNE	CMINUS
	INC	PAUSE+2        ; ¤®” ¢Øāģ 65536 ¬Ŗį
	JMP	@@L
CMINUS:	CMP	AL,	'+'    ; ćŖ®ą ēØ¢ āģ § ¤„ą¦Ŗć?
	JNE	CEXIT
	CMP	WORD PTR PAUSE+2, 0
	JE	BACK
	DEC	PAUSE+2        ; ć” ¢Øāģ 65536 ¬Ŗį
BACK:	JMP	@@L
CEXIT:
  CMP AL, '1'    ;įą ¢­„­Ø„ į 1 Ø Æ„ą„å®¤ ­  Æ®¤įē„ā äć­ŖęØØ
  JE MY_PROG
  CMP	AL,	CHESC
	JE	@@E
	TEST	AL,	AL
  CMP AL, '1'
  JE MY_PROG
  PUTLSC	SNAME   ;  įāć¤„­ā 
	JNE	BACK
	CALL	GETCH
	JMP	@@L





MY_PROG:
 ;¢¢®¤ ēØį«  
  PUTL	EMPTYS
  LEA ESI, INPUT_X_STR
  CALL PUTSS
  ;§ ÆØį āģ EAX ¢ X Æ„ą„¬„­­ćī
  LEA EDI, X
  CALL READ_NUM
  PUTL EMPTYS
  ;   10   
  MOV EAX, X
  CALL PRINT_DEC
  PUTL EMPTYS

  ;¢¢®¤ ēØį«  
  ; XOR EDI, EDI
  LEA ESI, INPUT_Y_STR
  CALL PUTSS
 ;§ ÆØį āģ EAX ¢  Æ„ą„¬„­­ćī
  LEA EDI, Y
  CALL READ_NUM
  PUTL EMPTYS

  ;   10   
  MOV EAX, Y
  CALL PRINT_DEC
  PUTL EMPTYS

  LEA ESI, FUNCTION
  CALL PUTSS
  LEA ESI, Z_STR
  CALL PUTSS
  LEA ESI, Z3
  CALL PUTSS
  LEA ESI, Z2
  CALL PUTSS
  LEA ESI, Z7
  CALL PUTSS

  ;-------------------------------------------------
  ; ­ ē «® Æ®¤įē„ā 
  ; ”„ą„¬ å1-å4 ”Øāė
  MOV EAX, X
  AND EAX, 11110b ;¬ įŖ  ­  å1-å4 ”Øā 

  ; 1-4      
  CMP EAX, 100b
  JE FALSE
  CMP EAX, 1100b
  JE FALSE
  CMP EAX, 10b
  JE FALSE
  CMP EAX, 10010b
  JE FALSE
  CMP EAX, 110b
  JE FALSE
  ;         
  JMP TRUE

; ¢ėēØį«„­Ø„ Z „į«Ø ØįāØ­­  Ø«Ø «®¦ģ į®®ā¢„āįā¢„­­®
TRUE:
  LEA ESI, F1
  CALL PUTSS
  MOV EAX, X
  SHR EAX, 2
  MOV EBX, Y
  SHL EBX, 2
  ADD EAX, EBX
  MOV Z, EAX
  JMP CHANGE_Z
FALSE:
  LEA ESI, F0
  CALL PUTSS
  MOV EAX, X
  SHR EAX, 3
  MOV EBX, Y
  SUB EAX, EBX
  MOV Z, EAX



CHANGE_Z:
  XOR ECX, ECX
  XOR EDX, EDX
  LEA ESI, Z_BEFORE_DEC
  CALL PUTSS
  MOV EAX, Z
  CALL PRINT_DEC
  PUTL EMPTYS
  PUTL EMPTYS

  XOR ECX, ECX
  XOR EDX, EDX
  LEA ESI, Z_BEFORE_BIN
  CALL PUTSS
  MOV EAX, Z
  CALL PRINT_BIN
  PUTL EMPTYS
  PUTL EMPTYS



  ;  3 
  MOV EAX, Z
  XOR EAX, 1000b ;  3 

  ;----------------------------------------
  ; 7 

  MOV EBX, EAX
  AND EBX, 10000000b    ;  7 
  SHR EBX, 7    ;  EBX   Z7

  MOV ECX, EAX
  AND ECX, 100000000b    ;  8 
  SHR ECX, 8    ;  EBX   Z8

  AND EBX, ECX  ;  Z7&=Z8
  SHL EBX, 7    ;      Z7
  CMP EBX, 0
  JE WRITE_0_Z7
  WRITE_1_Z7:
  OR EAX, EBX  ;   EBX  EAX
  JMP CNT
  WRITE_0_Z7:
  OR EBX, 10000000b  ;   EBX  7  
  NOT EBX
  AND EAX, EBX ;   EBX  EAX

  CNT:

  ;----------------------------------------
  ;  2 
  MOV EBX, EAX
  AND EBX, 100b  ; ¬ įŖ  2 ”Øā 
  SHR EBX, 2    ;  EBX   Z2

  MOV ECX, EAX
  AND ECX, 10000000000000000000b   ; ¬ įŖ  19 ”Øā 
  SHR ECX, 19   ;  ECX   Z19

  OR EBX, ECX  ;  Z2|=Z19
  SHL EBX, 2    ;      Z2
  OR EAX, EBX  ;   EBX  EAX


  MOV Z, EAX

  XOR ECX, ECX
  XOR EDX, EDX
  LEA ESI, Z_AFTER_DEC
  CALL PUTSS
  MOV EAX, Z
  CALL PRINT_DEC
  PUTL EMPTYS
  PUTL EMPTYS


  XOR ECX, ECX
  XOR EDX, EDX
  LEA ESI, Z_AFTER_BIN
  CALL PUTSS
  MOV EAX, Z
  CALL PRINT_BIN
  PUTL EMPTYS
  PUTL EMPTYS


JMP @@E

ERROR_NUM:
  PUTL EMPTYS
  LEA ESI, ERROR_NUM_STR
  XOR EAX, EAX
  XOR EDX, EDX
  XOR ECX, ECX
  CALL PUTSS
  JMP @@E

; RESULT IN EAX , STRING WITH BINARY NUMBER IN MYBUFF
READ_NUM PROC NEAR
  LEA EDX, [MYBUF]
  CALL GETS
  xor eax, eax
  xor ebx, ebx
  ADD EDX, 1
  MOV CL, [EDX]
  ADD EDX, 1
  l1:
     mov bl, [EDX]
     sub bl, 48
     CMP BL, 0
     JE CONTINUE
     CMP BL, 1
     JNE ERROR_NUM
     CONTINUE:
       add EAX, EBX
       shl EAX, 1
       inc EDX
      LOOP L1
  shr EAX,1
; PUT EAX VALUE INTO VARIABLE WITH EDI ADDRESS
  MOV [EDI], EAX
  RET
READ_NUM ENDP

; WRITE DEC NUMBER FROM EAX
PRINT_DEC PROC NEAR
  ; PUSH EAX
  ; PUTL EMPTYS
  ; POP EAX
  MOV EBX, 10
  XOR ECX, ECX
  DIVISION:
    XOR EDX, EDX
    DIV EBX
    ADD EDX, 48
    push EDX
    ADD ECX, 1
    CMP EAX, 0
    JG DIVISION
  PRINT:
    XOR EAX, EAX
    POP EAX
    CALL PUTC
    LOOP PRINT
    RET
  PRINT_DEC ENDP

  ; WRITE DEC NUMBER FROM EAX
  PRINT_BIN PROC NEAR
    ; PUSH EAX
    ; PUTL EMPTYS
    ; POP EAX
    MOV EBX, 2
    XOR ECX, ECX
    DIVISION_BIN:
      XOR EDX, EDX
      DIV EBX
      ADD EDX, 48
      push EDX
      ADD ECX, 1
      CMP EAX, 0
      JG DIVISION_BIN
    MOV EBX, ECX
    SUB EBX, 20
    PRINT_ZEROS:
      MOV AL, '0'
      CALL PUTC
      INC EBX
      CMP EBX, 0
      JL PRINT_ZEROS
    PRINT_B:
      XOR EAX, EAX
      POP EAX
      CALL PUTC
      LOOP PRINT_B
      RET
    PRINT_BIN ENDP

	; ėå®¤ Ø§ Æą®£ą ¬¬ė
@@E:	EXIT
        EXTRN	PUTSS:  NEAR
        EXTRN	PUTC:   NEAR
	EXTRN   GETCH:  NEAR
	EXTRN   GETS:   NEAR
	EXTRN   SLEN:   NEAR
	EXTRN   UTOA10: NEAR
	END	BEGIN
