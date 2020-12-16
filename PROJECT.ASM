.model small

;constants
SCREEN_WIDTH=640
SCREEN_HEIGHT=350 ;update MARIO_ON_LAND
MARIO_HEIGHT=60 ;update MARIO_ON_LAND
MARIO_WIDTH=40
BACKGROUND_COLOR=9
JUMP_PER_KEYSTROKE=5
MARIO_ON_LAND=290 ;SCREEN_HEIGHT - MARIO_HEIGHT
HURDLE_COLOR=0010b
HURDLE1STARTS=120
HURDLE1ENDS=160
Hurdle1BaseHeight=50
HURDLE2STARTS=270
HURDLE2ENDS=310
Hurdle2BaseHeight=100
HURDLE3STARTS=415
HURDLE3ENDS=465
Hurdle3BaseHeight=40
HurdleTopHeight=25
HURDLE_WIDTH=20
Hurdle1Height=75;=hurdle1baseheight+hurdletopheight
hurdle2Height=100;=hurdle2baseheight+hurdletopheight
hurdle3Height=65;=hurdle3baseheight+hurdletopheight
JUMP_INC=125 
MONSTER_HEIGHT=10
coinHeight=20
M_OBJ1=130
M_OBJ2=280
M_OBJ3=430

.stack 100h

include flag.inc  
include flower.inc  
include castle.inc  

.data
lives byte 1
score word 0
level byte 0 ;0->start page, 1->level 1, 2->level 2, 3->level 3, 4->end page
marioRow word MARIO_ON_LAND
marioCol word 0
enemy1Row word 323
enemy1Col word HURDLE1ENDS
enemy2Row word 323
enemy2Col word HURDLE2ENDS
enemyDirection word 0 ;0 means go right, 1 means go left
;monsterRow word 10
;monsterCol word 500
monsterDirection word 1 ;0 means right, 1 means left
monsterObject1Row word 100
monsterObject1Col word -5
monsterObject2Row word 100
monsterObject2Col word -5
monsterObject3Row word 100
monsterObject3Col word -5
TextRow byte 0
TextCol byte 0
temp word 0 ;for calling printing of flag from macro and flower
temp1 word 5 ;for flower macro
flowerPowerTimer word 0
enableBlink byte 0
marioPrint word 4,26,0,6,04h ;top of cap;height,width,row,col,pixel color ;mario is 60x40
		   word 4,6,4,32,04h ;extension of cap
		   word 16,8,24,0,04h ;left arm
		   word 16,8,24,30,04h ;right arm
		   word 4,10,56,6,06h ;left foot
		   word 4,10,56,22,06h ;right foot
		   word 22,22,22,8,01h ;body
		   word 12,6,44,10,01h ;left leg
		   word 12,6,44,22,01h ;right leg
		   word 4,4,40,2,0Fh ;left hand
		   word 4,4,40,32,0Fh ;right hand
		   word 18,26,4,6,0Fh ;face
		   word 4,4,6,22,01h ;eye
		   word 4,8,14,24,01h ;mouth
		   word 4,4,24,12,0Eh ;left button
		   word 4,4,24,22,0Eh ;right button
enemyPrint word 11 dup(BACKGROUND_COLOR), 3 dup(04h), 11 dup(BACKGROUND_COLOR)
		   word 10 dup(BACKGROUND_COLOR), 5 dup(04h), 10 dup(BACKGROUND_COLOR)
		   word 9 dup(BACKGROUND_COLOR), 7 dup(04h), 9 dup(BACKGROUND_COLOR)
		   word 8 dup(BACKGROUND_COLOR), 9 dup(04h), 8 dup(BACKGROUND_COLOR)
		   word 7 dup(BACKGROUND_COLOR),1 dup(04h),3 dup (00h),3 dup(04h),3 dup(00h),1 dup (01h),7 dup(BACKGROUND_COLOR)
		   word 6 dup(BACKGROUND_COLOR),04h,5 dup(00h),04h,5 dup(00h),04h,6 dup(BACKGROUND_COLOR)
		   word 5 dup(BACKGROUND_COLOR),2 dup(04h),5 dup(00h),04h,5 dup(00h),2 dup(04h),5 dup(BACKGROUND_COLOR)
		   word 4 dup(BACKGROUND_COLOR),3 dup(04h),5 dup(00h),04h,5 dup(00h),3 dup(04h),4 dup(BACKGROUND_COLOR)
		   word 4 dup(BACKGROUND_COLOR),4 dup(04h),3 dup(00h),3 dup(04h),3 dup(00h),4 dup(04h),4 dup(BACKGROUND_COLOR)
		   word 2 dup(4 dup(BACKGROUND_COLOR),17 dup(04h),4 dup(BACKGROUND_COLOR))
		   word 4 dup(BACKGROUND_COLOR),3 dup(04h),00h,9 dup(04h),00h,3 dup(04h),4 dup(BACKGROUND_COLOR)
		   word 4 dup(BACKGROUND_COLOR),3 dup(04h),2 dup(00h),7 dup(04h),2 dup(00h),3 dup(04h),4 dup(BACKGROUND_COLOR)
		   word 3 dup(BACKGROUND_COLOR),5 dup(04h),2 dup(00h),5 dup(04h),2 dup(00h),5 dup(04h),3 dup(BACKGROUND_COLOR)
		   word 2 dup(BACKGROUND_COLOR),7 dup(04h),7 dup(00h),7 dup(04h),2 dup(BACKGROUND_COLOR)
		   word BACKGROUND_COLOR,9 dup(04h),5 dup(00h),9 dup(04h),BACKGROUND_COLOR
		   word 6 dup(04h),BACKGROUND_COLOR,3 dup(3 dup(04h),BACKGROUND_COLOR),6 dup(04h)
		   word 7 dup(4 dup(BACKGROUND_COLOR),2 dup(04h),3 dup(BACKGROUND_COLOR,3 dup(04h)),BACKGROUND_COLOR,2 dup(04h),4 dup(BACKGROUND_COLOR))
		   word 7 dup(BACKGROUND_COLOR),3 dup(3 dup(04h),BACKGROUND_COLOR),6 dup(BACKGROUND_COLOR)
		   word 8 dup(BACKGROUND_COLOR),04h,2 dup(BACKGROUND_COLOR),3 dup(04h),2 dup(BACKGROUND_COLOR),04h,8 dup(BACKGROUND_COLOR)
		   word 12 dup(BACKGROUND_COLOR),04h,12 dup(BACKGROUND_COLOR)
monsterFire word 2 dup(9 dup(BACKGROUND_COLOR),4,4,9 dup(BACKGROUND_COLOR))
			word 7 dup(BACKGROUND_COLOR),6 dup(4),7 dup(BACKGROUND_COLOR)
			word 7 dup(BACKGROUND_COLOR),4,4,12,12,4,4,7 dup(BACKGROUND_COLOR)
			word 3 dup(BACKGROUND_COLOR),4,3 dup(BACKGROUND_COLOR),4,4 dup(12),4,3 dup(BACKGROUND_COLOR),4,3 dup(BACKGROUND_COLOR)
			word 3 dup(BACKGROUND_COLOR),4,4,2 dup(BACKGROUND_COLOR),4,4 dup(12),4,3 dup(BACKGROUND_COLOR),4,4,3 dup(BACKGROUND_COLOR)
			word 2 dup(BACKGROUND_COLOR),3 dup(4),2 dup(BACKGROUND_COLOR),4,4 dup(12),4,2 dup(BACKGROUND_COLOR),3 dup(4),2 dup(BACKGROUND_COLOR)
			word 3 dup(2 dup(BACKGROUND_COLOR),4,12,4,2 dup(BACKGROUND_COLOR),4,12,14,14,12,4,2 dup(BACKGROUND_COLOR),4,12,4,2 dup(BACKGROUND_COLOR))
			word 2 dup(BACKGROUND_COLOR),4,12,4,BACKGROUND_COLOR,4,4,12,14,14,12,4,4,BACKGROUND_COLOR,4,12,4,2 dup(BACKGROUND_COLOR)
			word 2 dup(2 dup(BACKGROUND_COLOR),4,12,4 dup(4),12,14,14,12,4 dup(4),12,4,2 dup(BACKGROUND_COLOR))
			word 3 dup(BACKGROUND_COLOR,4,12,12,12 dup(14),12,12,4,BACKGROUND_COLOR)
			word 2 dup(4,4,16 dup(12),4,4)
			word BACKGROUND_COLOR,18 dup(4),BACKGROUND_COLOR
			word BACKGROUND_COLOR,BACKGROUND_COLOR,16 dup(4),BACKGROUND_COLOR,BACKGROUND_COLOR
groundAt word MARIO_ON_LAND

;hurdle array elements: base's starting point, base height,base width ending point, base width starting point, top starting point, top height,top width ending point, top width starting point
hurdle1 word 300,Hurdle1BaseHeight,150,130,275,HurdleTopHeight,HURDLE1ENDS,HURDLE1STARTS
hurdle2 word 275,Hurdle2BaseHeight,300,280,250,HurdleTopHeight,HURDLE2ENDS,HURDLE2STARTS
hurdle3 word 310,Hurdle3BaseHeight,450,430,285,HurdleTopHeight,HURDLE3ENDS,HURDLE3STARTS
;starting row, height, ending col, startingcol
monsterCOORD word 50,50,440,400
coin1 word 250,coinHeight,150,130
coin2 word 225,coinHeight,300,280
coin3 word 260,coinHeight,450,430
level1str byte "Level: 1$"
level2str byte "Level: 2$"
level3str byte "Level: 3$"
scorestr byte "Score: $"
GameEndMessage byte " Game is over $"
GameEndScore byte "Your score is: $"
EntryMessageName byte "Enter your username to play: $"
username byte 127 dup("$")
SuperMario byte "Super Mario$"
EntryMessage byte "Press Enter to start the game:$"
GameEndM byte " Game is over $"
GameInstruction byte "Instructions:$"
Instruction1 byte "1) Use arrow keys to move Mario.$"
Instruction2 byte "2) Coins and completing level gives points.$"
Instruction3 byte "3) Collision with Enemy or Bullets loses points.$"
win byte "You win!$"
lose byte "You loose!$"
playAgain byte "Press Enter if you wish to play again$"

.code

main PROC

mov ax,@data
mov ds,ax

call InputUserName

;set video mode
mov ah,0h
mov al,10h
int 10h

;set typematic rate such that repeat delay=250ms, repeat rate=30/sec
mov ax,0305h
mov bx,000Fh
int 16h

cmp Level,0
jne StartHere
call StartPage

StartHere::

Level1Once:
call changeBackground
call drawHurdles
call printMario
call drawCoins
call PrintLevel
call PrintScore


cmp level,3
jge continue
;not for level3
flag temp

continue:
cmp level,1
jle LoopAway

Level2Once:
call drawFlower

cmp level,2
jle LoopAway

Level3Once:
castle temp

LoopAway:

Level1:
;if mario not on land then make it come back to land
call updateLandAndCheckEnemyCollission
;if mario doesn't land on hurdle, than decerement
mov ax,groundAt
cmp marioRow,ax
jnl onLand
call clearMario
add marioRow,5
call printMario
call drawHurdles

onLand:

cmp level,1
jle ForAllLevels

Level2:
call enemyMovement
call checkFlowerCollission
mov ax,0
cmp flowerPowerTimer,ax
jle continue2
dec flowerPowerTimer
cmp flowerPowerTimer,ax
jg continue2
mov enableBlink,0

continue2:
cmp level,2
jle ForAllLevels

Level3:
call monsterMovement
call drawAndMoveAllMonsterObjects

cmp level,3
jle ForAllLevels

call EndScreen
jmp quit

ForAllLevels:
;check if keys in typeahead buffer
mov ah,11h
int 16h
jz LoopAway ;ZF=0 when typeahead buffer is empty
;retrieves the pressed key from typeahead buffer
mov ah,10h
int 16h
cmp ah,1 ;escape key is pressed
je quit
cmp ah,77 ;right key is pressed
jne notRight
call clearMario
add marioCol,JUMP_PER_KEYSTROKE
call printMario
call drawHurdles
jmp LoopAway
notRight:
cmp ah,75 ;left key is pressed
jne notLeft
call clearMario
sub marioCol,JUMP_PER_KEYSTROKE
mov bx,0
cmp marioCol,0
jge cont
add marioCol,JUMP_PER_KEYSTROKE
cont:
call printMario
call drawHurdles
jmp LoopAway
notLeft:
cmp ah,72 ;up key is pressed
jne LoopAway
mov ax,groundAt
cmp marioRow,ax
jnge LoopAway
call clearMario
sub marioRow,JUMP_INC
call printMario
call drawHurdles
jmp LoopAway

quit::
.exit

main endp

;------------------------------------------------------------------------------------------------------------------------------------------------
;takes input of monsterObjectRow([bp]) and offset monsterObjectCol([bp+2])
checkMonsterObjectCollission proc
	;implemented condition -> marioCol+marioWidth-20 >= monsterObjectCol /*ending col*/ && marioCol-20/*objectWidth*/-20 <= monsterObjectCol /*endingcol*/ 
	;&& marioRow+marioHeight >= monsterObjectRow /*starting row*/ && marioRow-20-20 <= monsterObjectRow /*ending Row*/
	push bp
	mov bp,sp
	add bp,4
condition1:
	mov ax,marioCol
	add ax,MARIO_WIDTH
	sub ax,20
	cmp ax,[bp+2]
	jnge return
condition2:
	mov ax,marioCol
	sub ax,40
	cmp ax,[bp+2]
	jnle return
condition3:
	mov ax,marioRow
	add ax,MARIO_HEIGHT
	cmp ax,[bp]
	jnge return
condition4:
	mov ax,marioRow
	sub ax,40
	cmp ax,[bp]
	jnle return
	;destroy object
	mov ax,-5
	mov [bp+2],ax
	call NegativeCollission
return:
	pop bp
	ret
checkMonsterObjectCollission endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
drawAndMoveAllMonsterObjects proc
Object1:
	mov ax,monsterObject1Col
	cmp ax,0
	jl Object2
	push ax
	mov ax,monsterObject1Row
	push ax
	mov bx,0
	call drawMonsterObject
	pop ax
	add monsterObject1Row,5
	mov ax,monsterObject1Row
	push ax
	add ax,20
	cmp ax,coin1[0]
	jg A11
	mov bx,1
	call drawMonsterObject
	jmp A1
	A11:
	mov ax,-5
	mov monsterObject1Col,ax
	A1:
	add sp,4
Object2:
	mov ax,monsterObject2Col
	cmp ax,0
	jl Object3
	push ax
	mov ax,monsterObject2Row
	push ax
	mov bx,0
	call drawMonsterObject
	pop ax
	add monsterObject2Row,5
	mov ax,monsterObject2Row
	push ax
	add ax,20
	cmp ax,coin2[0]
	jg A22
	mov bx,1
	call drawMonsterObject
	jmp A2
	A22:
	mov ax,-5
	mov monsterObject2Col,ax
	A2:
	add sp,4
Object3:
	mov ax,monsterObject3Col
	cmp ax,0
	jl return
	push ax
	mov ax,monsterObject3Row
	push ax
	mov bx,0
	call drawMonsterObject
	pop ax
	add monsterObject3Row,5
	mov ax,monsterObject3Row
	push ax
	add ax,20
	cmp ax,coin3[0]
	jg A33
	mov bx,1
	call drawMonsterObject
	jmp A3
	A33:
	mov ax,-5
	mov monsterObject3Col,ax
	A3:
	add sp,4
return:
	ret
drawAndMoveAllMonsterObjects endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
;receives in stack: monsterObjectRow([bp]) monsterObjectCol([bp+2])
;receives value in bx such that: if bx==0, clearMonsterObject else printMonsterObject
drawMonsterObject proc
	push bp
	mov bp,sp
	add bp,4
	mov cx,20
	mov si, offset monsterFire
	mov al,20
	mov ah,20
	mul ah
	shl ax,1 ;multiply by 2
	add si,ax
	L1:
		mov dx, cx
		mov cx,20
		L2:
			mov al,[si]
			cmp al,BACKGROUND_COLOR
			je continue1
			cmp bx,0
			jne continue2
			mov al,BACKGROUND_COLOR
			continue2:
			add cx,[bp+2]
			add dx,[bp]
			mov bh,0
			mov ah,0Ch
			int 10h
			sub cx,[bp+2]
			sub dx,[bp]
			continue1:
			sub si,2
		loop L2
		mov cx,dx
	loop L1
	pop bp
	ret
drawMonsterObject endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
StartPage proc
	call ChangeBackground
	call PrintMario
	StartGameEnter:

	;printing game name

	mov si,offset supermario
	mov cx,lengthof supermario
	sub cx,1
	mov textcol,45
	mov textrow,10
	call PrintText

	;printing press enter message
	mov si,offset EntryMessage
	mov cx, lengthOF EntryMessage
	sub cx,1
	mov textCol,54
	mov textRow,12
	call PrintText

	call PrintInstructions

	;check if enter key pressed
	mov ah,11h
	int 16h
	mov ah,10h
	int 16h
	cmp ah,1ch
	je SGE
	jmp StartGameEnter

	SGE:
	add level,1 ;to continue game
	call ClearSc
	mov textRow,0 ;to retain remaining texts
	ret
StartPage endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
drawFlower proc
	cmp temp1,0
	jl return
	flower temp temp1
return:
	ret
drawFlower endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
;takes offset of coin array in si
checkCoinCollission proc
	;implemented condition -> marioCol+width >= [si+4] /*ending col*/ && marioCol-20/*coinWidth*/ <= [si+4] /*endingcol*/ && marioRow+height >= [si] /*starting row*/ && marioRow-coinHeight <= [si] /*ending Row*/
c1:
	mov ax,marioCol
	add ax,MARIO_WIDTH
	cmp ax,[si+4]
	jnge return
c2:
	mov ax,marioCol
	sub ax,20
	cmp ax,[si+4]
	jnle return
c3:
	mov ax,marioRow
	add ax,MARIO_HEIGHT
	cmp ax,[si]
	jnge return
c4:
	mov ax,marioRow
	sub ax,coinHeight
	cmp ax,[si]
	jnle return
	;print box of background color in place of the coin
	mov ax, coinHeight
	push ax
	push ax
	mov ax,[si]
	push ax
	mov ax,[si+6]
	push ax
	mov ax,BACKGROUND_COLOR
	push ax
	call printRectangle
	add sp,10
	add score,5
	call printMario
	call PrintScore
	mov cx,4
	mov ax,-5
	L1:
		mov [si],ax
		add si,2
	loop L1
return:
	ret
checkCoinCollission endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
checkFlowerCollission proc
	;implemented condition -> marioCol+width >= 250 && marioCol-25 <= 250 && marioRow+height >= 190 && marioRow <= 215
c1:
	mov ax,marioCol
	add ax,MARIO_WIDTH
	cmp ax,250
	jnge return
c2:
	mov ax,marioCol
	sub ax,25
	cmp ax,250
	jnle return
c3:
	mov ax,marioRow
	add ax,MARIO_HEIGHT
	cmp ax,190
	jnge return
c22:
	mov ax,marioRow
	cmp ax,215
	jnle return
	mov enableBlink,4
	mov flowerPowerTimer,30
	mov temp1,-5
	mov ax,30
	push ax
	push ax
	mov ax,185
	push ax
	mov ax,250
	push ax
	mov ax,BACKGROUND_COLOR
	push ax
	call printRectangle
	add sp,10
	call printMario
return:
	ret
checkFlowerCollission endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
;mario hit something its not supposed to
NegativeCollission proc
	cmp enableBlink,0
	jne return
	call clearMario
	mov marioCol,0
	sub score,25
	cmp score,0
	jg continue1
	call EndScreen
	jmp quit
	continue1:
	mov marioRow,MARIO_ON_LAND
	call printMario
return:
	ret
NegativeCollission endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 monsterMovement proc
	mov bx,0
	call drawMonster
	cmp monsterDirection,0
	jne continue1
	add monsterCOORD[4],1
	add monsterCOORD[6],1
	cmp monsterCOORD[6],500 ;the right limit for monster
	jl continue2
	mov monsterDirection,1
	jmp return
	continue1:
	sub monsterCOORD[4],1
	sub monsterCOORD[6],1
	cmp monsterCOORD[6],100 ;the left limit for monster
	jg continue2
	mov monsterDirection,0
	continue2:
	mov bx,1
	call drawMonster
	;check if monster is ready to launch the object
	;first check if monster's centre is at that col, then check if the object is available
	;starting row, height, ending col, startingcol
	;monsterCOORD word 50,50,440,400
	mov ax,monsterCOORD[6]
	;add ax,monsterCOORD[4]
	;shr ax,1
	obj1:
	cmp ax,M_OBJ1
	jne obj2
	mov monsterObject1Col,M_OBJ1
	mov bx,monsterCOORD[0]
	add bx,40
	mov monsterObject1Row,bx
	obj2:
	cmp ax,M_OBJ2
	jne obj3
	mov monsterObject2Col,M_OBJ2
	mov bx,monsterCOORD[0]
	add bx,40
	mov monsterObject2Row,bx
	obj3:
	cmp ax,M_OBJ3
	jne return
	mov monsterObject3Col,M_OBJ3
	mov bx,monsterCOORD[0]
	add bx,40
	mov monsterObject3Row,bx
	return:
	ret
monsterMovement endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
ChangeBackground proc
MOV AH, 06h
MOV AL, 0
MOV CX, 0
MOV DH, 80
MOV DL, 80
MOV BH, BACKGROUND_COLOR
INT 10h
ret
ChangeBackground endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
;arg1: height 
;arg2: width 
;arg3: row 
;arg4: col 
;arg5: pixel color 
;stack entry order: arg1,arg2, arg3, arg4, arg5 and top points at arg5
;throughout procedure [bp]=arg5,to access values pushed inside proc, [bp-6-i] where i is the order in which value was pushed
printRectangle proc 
	push bp
	mov bp,sp
	add bp,4 ;bp now points at arg5
	mov cx,[bp+8] ;height of rectangle
	L2:
		push cx
		mov cx,[bp+6] ;width of rectangle
		L1:
			;y coordinate is counter of L2
			mov dx,[bp-6]
			;reach the appropriate row
			add dx,[bp+4]
			;x coordinate is counter of L1 which is already present in cx
			;add col in cx
			add cx,[bp+2]
			;move pixel color to al
			mov al,byte ptr [bp]
			;set video page to 0
			mov bh,0
			;set function to print pixel
			mov ah,0Ch
			int 10h
			sub cx,[bp+2];restore value of cx for the loop
		loop L1
		pop cx
	loop L2
	pop bp
	ret
printRectangle endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
;take one arg in bx,if (bx==0) all colors replaced by background_color
;draws enemy using the coordinates enemyPrintRow([bp+2]), enemyPrintCol([bp]) (found in stack) as the top left point
drawEnemy proc 
	push bp
	mov bp,sp
	add bp,4 ;now points at enemyPrintCol
	mov cx,27
	mov si, offset enemyPrint
	mov al,25
	mov ah,27
	mul ah
	shl ax,1 ;multiply by 2
	add si,ax
	L1:
		mov dx, cx
		mov cx,25
		L2:
			add cx,[bp]
			add dx,[bp+2]
			cmp bx,0
			jne continue
			mov al,BACKGROUND_COLOR
			jmp continue2
			continue:
			mov al,[si]
			continue2:
			mov bh,0
			mov ah,0Ch
			int 10h
			sub si,2
			sub cx,[bp]
			sub dx,[bp+2]
		loop L2
		mov cx,dx
	loop L1
	pop bp
	ret
drawEnemy endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
;take one arg in bx,if (bx==0) all colors replaced by background_color
;draws mario using the coordinates (marioRow,marioCol) as the top left point
drawMario proc 
	mov cx,16
	mov si,offset marioPrint
	L1:
		push cx
		;push height,width
		push [si]
		;push marioPrint
		push [si+2]
		;push row,col
		mov ax,marioRow
		add ax,[si+4]
		push ax
		mov ax,marioCol
		add ax,[si+6]
		push ax
		;push pixel color
		cmp bx,0
		jne continue
		mov ax,BACKGROUND_COLOR
		jmp continue2
		continue:
		mov ax,[si+8] ;red for hat
		add al,enableBlink
		continue2:
		push ax
		call printRectangle
		add sp,10 ;to discard 5 arguments
		;pop si
		add si,10
		pop cx
	loop L1
	ret
drawMario endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
printMario proc uses bx
	mov bx,1
	call drawMario
	ret
printMario endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
clearMario proc uses bx
	mov bx,0
	call drawMario
	ret
clearMario endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
timer proc uses cx dx ax
mov cx,0000h
mov dx,0FFFFh
mov ah,86h
int 15h
ret
timer endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
clearSc proc uses ax
	mov al,10h
	mov ah,0
	int 10h
	ret
clearSc endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
drawHurdle proc uses cx
;drawing of base
mov cx,[si+2] ;sets height of base
loopH1:
	push cx
	mov cx,[si+4] ;sets width end point of base
	loopH2:
		mov bp,sp
		mov dx,[bp]
		add dx,[si]
		mov al,HURDLE_COLOR
		mov bh,0
		mov ah,0ch
		int 10h		
		cmp cx,[si+6] ;checks if width start point of base reached
		je EndBaseH
	loop loopH2
	EndBaseH:
	pop cx
loop loopH1

;drawing the upper part of hurdle
mov cx,[si+10] ;sets height
loopH3:
	push cx
	mov cx,[si+12] ;sets width end point
	loopH4:
		mov bp,sp
		mov dx,[bp]
		add dx,[si+8]
		mov al,HURDLE_COLOR
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,[si+14] ; checks width start reached
		je EndH
	loop loopH4
	EndH:
	pop cx
loop loopH3
ret

drawHurdle endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
drawHurdles proc  ;si has offset of hurdle array
	mov si, offset hurdle1
	call drawHurdle
	mov si, offset hurdle2
	call drawHurdle
	mov si, offset hurdle3
	call drawHurdle
	ret
drawHurdles endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
enemyMovement proc
	;clear enemy
	mov bx,0
	push enemy1Row
	push enemy1Col
	call drawEnemy
	add sp,4 ;discards 2 arguments
	mov bx,0
	push enemy2Row
	push enemy2Col
	call drawEnemy
	add sp,4 ;discads 2 arguments

	cmp enemyDirection,0
	jne moveLeft
	add enemy1Col,1
	add enemy2Col,1
	mov ax,enemy1Col
	add ax,25;width of enemy
	cmp ax,HURDLE2STARTS
	jl ReprintEnemy
	mov enemyDirection,1
	jmp ReprintEnemy
	moveLeft:
	sub enemy1Col,1
	sub enemy2Col,1
	cmp enemy1Col,HURDLE1ENDS
	jg ReprintEnemy
	mov enemyDirection,0

	;reprint enemy
	ReprintEnemy:
	mov bx,1
	push enemy1Row
	push enemy1Col
	call drawEnemy
	add sp,4 ;discards 2 arguments
	mov bx,1
	push enemy2Row
	push enemy2Col
	call drawEnemy
	add sp,4 ;discards 2 arguments
	ret
enemyMovement endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
updateLandAndCheckEnemyCollission proc
	mov ax,MARIO_WIDTH
	shr ax,1;divide by 2
	add ax,marioCol
condition1: ;between starting point and hurdle1
	cmp ax, Hurdle1Starts
	jnl condition2
	mov groundAt, MARIO_ON_LAND
	jmp return
condition2: ;on hurdle1
	cmp ax, Hurdle1Ends
	jnl condition3
	mov groundAt, MARIO_ON_LAND
	Sub groundAt, Hurdle1Height
	;check if collides with coin
	mov si,offset coin1
	mov bx,0
	cmp [si],bx
	jl return
	call checkCoinCollission
	cmp level,3
	jl return
	mov cx,monsterObject1Col
	push cx
	mov cx,monsterObject1Row
	push cx
	call checkMonsterObjectCollission
	pop cx
	push monsterObject1Col
	push cx
	mov bx,0
	call drawMonsterObject
	add sp,4
	pop monsterObject1Col
	jmp return
condition3: ;between hurdle1 and hurdle2
	cmp ax, Hurdle2Starts
	jnl condition4
	mov groundAt, MARIO_ON_LAND
	;check collission with enemy1
	cmp level,2
	jl return
	cmp enableBlink,0
	jnle return
	mov cx,enemy1Col
	call checkEnemyCollission
	jmp return
condition4: ;on hurdle2
	cmp ax,Hurdle2Ends
	jnl condition5
	mov groundAt, MARIO_ON_LAND
	sub groundAt,Hurdle2Height
	;check if collides with coin
	mov si,offset coin2
	call checkCoinCollission
	cmp level,3
	jl return
	mov cx,monsterObject2Col
	push cx
	mov cx,monsterObject2Row
	push cx
	call checkMonsterObjectCollission
	pop cx
	push monsterObject2Col
	push cx
	mov bx,0
	call drawMonsterObject
	add sp,4
	pop monsterObject2Col
	jmp return
condition5: ;between hurdle2 and hurdle3
	cmp ax,Hurdle3Starts
	jnl condition6
	mov groundAt,MARIO_ON_LAND
	;check collission with enemy2
	cmp level,2
	jl return
	cmp enableBlink,0
	jnle return
	mov cx,enemy2Col
	call checkEnemyCollission
	jmp return
condition6: ;on hurdle3
	cmp ax,Hurdle3Ends
	jnl condition7
	mov groundAt,MARIO_ON_LAND
	sub groundAt,Hurdle3Height
	;check if collides with coin
	mov si,offset coin3
	call checkCoinCollission
	cmp level,3
	jl return
	mov cx,monsterObject3Col
	push cx
	mov cx,monsterObject3Row
	push cx
	call checkMonsterObjectCollission
	pop cx
	push monsterObject3Col
	push cx
	mov bx,0
	call drawMonsterObject
	add sp,4
	pop monsterObject3Col
	jmp return
condition7: ;between hurdle3 and flag
	cmp level,2
	jnle castleCheck
	flagCheck:
	cmp ax,624;the beginning of the pole
	jnl elsecase
	jmp comeHere
	castleCheck:
	cmp ax,540
	jnl elsecase
	comeHere:
	mov groundAt,MARIO_ON_LAND
	jmp return
elsecase: ;crossed flag
	inc level
	call clearMario
	mov marioCol,0
	add score,100
	mov enableBlink,0
	mov temp1,1
	flag temp
	jmp StartHere
return:
	ret
updateLandAndCheckEnemyCollission endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
;takes value of enemyCol in cx
checkEnemyCollission proc
	;if (!(marioCol+width<enemyCol || marioCol>enemyCol+25/*width of enemy*/)) collide and die
	;implemented condition -> marioCol+width >= enemyCol && marioCol-25 <= enemyCol && marioRow+height >= enemyRow
	mov bx,marioCol
	sub bx,25
	cmp bx,cx 
	jnle return
	mov bx,marioCol
	add bx,MARIO_WIDTH
	cmp bx,cx
	jnge return
	mov bx,marioRow
	add bx,MARIO_HEIGHT
	cmp bx,enemy1Row
	jnge return
	call PrintScore
	call NegativeCollission
return:
	ret
checkEnemyCollission endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
drawMonster proc
	mov si,offset monsterCOORD
	mov cx,[si+2] ;height control
	monsterBody:
		 push cx
		 mov cx,[si+4] ;width end point
		 monsterBody1:
			  mov bp,sp 
			  mov dx,[bp]
			  add dx,[si]
			  cmp bx,0
			  jne continue
			  mov al,BACKGROUND_COLOR
			  jmp continue2
			  continue:
			  mov al,1000b
			  continue2:
			  mov bh,0
			  mov ah,0Ch
			  int 10h
			  cmp cx,[si+6] ; width start reached check
			  je monst
		 loop monsterBody1
		 monst:
		 pop cx
	loop monsterBody

	;---monster legs---

	mov cx,[si+4]
	sub cx,8
	mov temp,cx
	mov cx,6
	MlegLEFT:
		 push cx
		 mov cx,[si+4]
		 MlegLEFT2:
			  mov bp,sp
			  mov dx,[bp]
			  add dx,[si]
			  add dx,[si+2]
			  cmp bx,0
			  jne continue3
			  mov al,BACKGROUND_COLOR
			  jmp continue4
			  continue3:
			  mov al,1000b
			  continue4:
			  mov bh,0
			  mov ah,0ch
			  int 10h
			  cmp cx,temp
			  je legL
		 loop MlegLEFT2
		 legL:
		 pop cx
	loop MlegLEFT

	mov cx,[si+6]
	mov temp,cx
	mov cx,6
	MlegRIGHT:
		 push cx
		 mov cx,[si+6]
		 add cx,8
		 MlegRIGHT2:
			  mov bp,sp
			  mov dx,[bp]
			  add dx,[si]
			  add dx,[si+2]
			  cmp bx,0
			  jne continue5
			  mov al,BACKGROUND_COLOR
			  jmp continue6
			  continue5:
			  mov al,1000b
			  continue6:
			  mov bh,0
			  mov ah,0ch
			  int 10h
			  cmp cx,temp
			  je legR
		 loop MlegRIGHT2
		 legR:
		 pop cx
	loop MlegRIGHT

	;---monster eyes---
	mov cx,[si+4]
	sub cx,14
	mov temp,cx
	mov cx,10
	MeyeLEFT:
		 push cx
		 mov cx,[si+4]
		 sub cx,8
		 MeyeLEFT2:
			  mov bp,sp
			  mov dx,[bp]
			  add dx,[si]
			  add dx,15
			  cmp bx,0
			  jne continue7
			  mov al,BACKGROUND_COLOR
			  jmp continue8
			  continue7:
			  mov al,0100b
			  continue8:
			  mov bh,0
			  mov ah,0ch
			  int 10h
			  cmp cx,temp
			  je eyeL
		 loop MeyeLEFT2
		 eyeL:
		 pop cx
	loop MeyeLEFT

	mov cx,[si+6]
	add cx,12
	mov temp,cx
	mov cx,10
	MeyeRIGHT:
		 push cx
		 mov cx,[si+6]
		 add cx,18
		 MeyeRIGHT2:
			  mov bp,sp
			  mov dx,[bp]
			  add dx,[si]
			  add dx,15
			  cmp bx,0
			  jne continue9
			  mov al,BACKGROUND_COLOR
			  jmp continue10
			  continue9:
			  mov al,0100b
			  continue10:
			  mov bh,0
			  mov ah,0ch
			  int 10h
			  cmp cx,temp
			  je eyeR
		 loop MeyeRIGHT2
		 eyeR:
		 pop cx
	loop MeyeRIGHT

	cmp bx,0
	jne continue1
	ret
	continue1:

	;----monster mouth---
	mov cx,[si+6]
	add cx,11
	mov temp,cx
	mov cx,15 ;height control
	monsterMouth:
		 push cx
		 mov cx,[si+4]
		 sub cx,8 ;width end point
		 monsterMouth1:
			  mov bp,sp 
			  mov dx,[bp]
			  add dx,[si]
			  add dx,30
			  mov al,1111b
			  mov bh,0
			  mov ah,0Ch
			  int 10h
			  cmp cx,temp ; width start reached check
			  je monstMouth
		 loop monsterMouth1
		 monstMouth:
		 pop cx
	loop monsterMouth

	;----monster tongue---
	mov cx,[si+6]
	add cx,15
	mov temp,cx
	mov cx,10 ;height control
	monsterTongue:
		 push cx
		 mov cx,[si+4]
		 sub cx,12 ;width end point
		 monsterTongue1:
			  mov bp,sp 
			  mov dx,[bp]
			  add dx,[si]
			  add dx,35
			  mov al,1100b
			  mov bh,0
			  mov ah,0Ch
			  int 10h
			  cmp cx,temp ; width start reached check
			  je monstTongue
		 loop monsterTongue1
		 monstTongue:
		 pop cx
	loop monsterTongue
	ret
drawMonster endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
drawCoin proc uses cx
;mov temp,625
	mov cx,[si+2] ;height control
	C3:
		push cx
		mov cx,[si+4] ;width end point
		C4:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			mov al,1110b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,[si+6] ; width start reached check
			je fope
		loop C4
		fope:
		pop cx
	loop C3
	;top right corner
	mov cx,[si+6]
	add cx,15
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C5:
		push cx
		mov cx,[si+4]
		;sub cx, ;width end point
		C6:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinS
		loop C6
		coinS:
		pop cx
	loop C5

	;top left corner
	mov cx,[si+6]
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C7:
		push cx
		mov cx,[si+4] ;width end point
		sub cx,15
		C8:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinSS
		loop C8
		coinSS:
		pop cx
	loop C7

	;------coin shaping cont-----
	;top right corner
	mov cx,[si+6]
	add cx,17
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C9:
		push cx
		mov cx,[si+4]
		;sub cx, ;width end point
		C10:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,3
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinS1
		loop C10
		coinS1:
		pop cx
	loop C9

	;top left corner
	mov cx,[si+6]
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C11:
		push cx
		mov cx,[si+4] ;width end point
		sub cx,17
		C12:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,3
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinSS1
		loop C12
		coinSS1:
		pop cx
	loop C11


	;------coin shaping cont-----
	;top right corner
	mov cx,[si+6]
	add cx,19
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C13:
		push cx
		mov cx,[si+4]
		;sub cx, ;width end point
		C14:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,6
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinS2
		loop C14
		coinS2:
		pop cx
	loop C13

	;top left corner
	mov cx,[si+6]
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C15:
		push cx
		mov cx,[si+4] ;width end point
		sub cx,19
		C16:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,6
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinSS2
		loop C16
		coinSS2:
		pop cx
	loop C15

	;-----------coin bottom shape---------
	;top right corner
	mov cx,[si+6]
	add cx,15
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C50:
		push cx
		mov cx,[si+4]
		;sub cx, ;width end point
		C60:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,15
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinS0
		loop C60
		coinS0:
		pop cx
	loop C50

	;top left corner
	mov cx,[si+6]
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C70:
		push cx
		mov cx,[si+4] ;width end point
		sub cx,15
		C80:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,15
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinSS0
		loop C80
		coinSS0:
		pop cx
	loop C70

	;------coin shaping cont-----
	;top right corner
	mov cx,[si+6]
	add cx,17
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C90:
		push cx
		mov cx,[si+4]
		;sub cx, ;width end point
		C100:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,12
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinS10
		loop C100
		coinS10:
		pop cx
	loop C90

	;top left corner
	mov cx,[si+6]
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C110:
		push cx
		mov cx,[si+4] ;width end point
		sub cx,17
		C120:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,12
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinSS10
		loop C120
		coinSS10:
		pop cx
	loop C110


	;------coin shaping cont-----
	;top right corner
	mov cx,[si+6]
	add cx,19
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C130:
		push cx
		mov cx,[si+4]
		;sub cx, ;width end point
		C140:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,9
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinS20
		loop C140
		coinS20:
		pop cx
	loop C130
	;top left corner
	mov cx,[si+6]
	mov temp,cx
	mov cx,[si+2] ;height control
	sub cx,17
	C150:
		push cx
		mov cx,[si+4] ;width end point
		sub cx,19
		C160:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,9
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ; width start reached check
			je coinSS20
		loop C160
		coinSS20:
		pop cx
	loop C150
	
	;-------line------;
	mov cx,2
	CC:
	push cx
	mov cx,[si+4] ;width end point
		CC4:
			mov bp,sp 
			mov dx,[bp]
			add dx,[si]
			add dx,18
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,[si+6] ; width start reached check
			je Cfope
		loop CC4
		Cfope:
		pop cx
	loop CC
	ret
drawCoin endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
drawCoins proc  ;si has offset of coin array
	mov si, offset coin1
	call drawCoin
	mov si, offset coin2
	call drawCoin
	mov si, offset coin3
	call drawCoin
	ret
drawCoins endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
PrintText proc ;uses cx for length of string and si for offset of string, and TextRow, TextCol
printT:
	mov  dl,TextCol   ;Column
	sub dl,cl
	mov  dh, TextRow  ;Row
	mov  bh, 0    ;Display page
	mov  ah, 02h  ;SetCursorPosition
	int  10h

	mov  al, [si]
	mov  bl, 0010b  ;Color is red
	mov  bh, 0    ;Display page
	mov  ah, 0Eh  ;Teletype
	int  10h
	inc si
loop printT
ret
PrintText endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 

PrintLevel proc
push cx

mov textcol,45
mov cx,8

cmp level,1
je PrintLVL1
cmp level,2
je PrintLVL2

mov si, offset level3str
jmp EndLevelPrinting

PrintLVL1:
	mov si, offset level1str
	jmp EndLevelPrinting

PrintLVL2:
	mov si,offset level2str

EndLevelPrinting:
call PrintText
pop cx
ret
PrintLevel endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
;recursive func
;void print(int x) {
;if (x<10)
; cout<<x
; return
; print (x/10)
; print(x%10)
;}
;receives one argument in stack: the no. to be printed
printIntString proc
push bp
mov bp,sp
add bp,4 ;skip bp and ip in stack
push ax
mov ax,[bp]
cmp ax,10
jl baseCase
pop ax
push ax
mov ax,[bp]
push bx
mov bl,10
div bl
;quotient in al and remainder in ah
mov bl,ah
mov ah,0
push ax
call printIntString
add sp,2 ;discard parameter
mov al,bl
push ax
call printIntString
add sp,2 ;discard parameter
pop bx
pop ax
jmp funcEnd
baseCase:
pop ax
push dx
push ax
;---colour changing and string printing by mishaal 
push bx
mov dx,[bp]
add dl,'0'
mov al,dl
mov  bl, 0010b  ;Color is red
mov  bh, 0    ;Display page
mov  ah, 0Eh
int 10h
pop bx
pop ax
pop dx
funcEnd:
pop bp
ret
printIntString endp
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
PrintScore proc
; printing "score: "
push cx
mov textcol,8
mov cx,7
mov si, offset scoreStr
call Printtext
pop cx

; printing user's score
push ax
mov ax,score
push ax
call printIntString
pop ax
pop ax
ret
PrintScore endp
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
EndScreen proc
call clearSc
call ChangeBackground
;printing game over
mov si, offset GameEndM
mov cx, lengthOF GameEndM
sub cx,1
mov textCol,45
mov textRow,10
call Printtext

;print win or loose
mov si, offset win
mov cx, lengthOF win
cmp score,0
jg continue2
mov si,offset lose
mov cx,lengthOF lose
continue2:
sub cx,1
mov textCol,46
mov textRow,8
call Printtext

;printing final score
mov si,offset GameEndScore
mov cx, lengthOF GameEndScore
sub cx,1
mov textCol,44
mov textRow,12
call PrintText
mov ax,score
cmp ax,0
jg continue
mov ax,0
continue:
push ax
call printIntString
pop ax

flag temp
call printMario


ret
EndScreen endp

;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
NextLine proc
mov ah, 02h
mov dl,0Ah
int 21h
mov dl,0Dh
int 21h
ret
NextLine endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
InputUserName proc

;printing message
mov ah,09h
mov dx,offset EntryMessageName
int 21h

call NextLine

;Inputing username
mov dx, OFFSET username
mov ah, 03Fh
INT 21h
ret
InputUserName endp
;------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------
 
PrintInstructions proc
	;printing instructions
	mov si, offset GameInstruction
	mov cx, lengthOf GameInstruction
	sub cx,1
	mov textCol,46
	mov textRow,16
	call PrintText
	mov si, offset Instruction1
	mov cx, lengthOf Instruction1
	sub cx,1
	mov textCol,53
	mov textRow,17
	call PrintText
	mov si, offset Instruction2
	mov cx, lengthOf Instruction2
	sub cx,1
	mov textCol,64
	mov textRow,18
	call PrintText
	mov si, offset Instruction3
	mov cx, lengthOf Instruction3
	sub cx,1
	mov textCol,69
	mov textRow,19
	call PrintText
	ret
PrintInstructions endp
;------------------------------------------------------------------------------------------------------------------------------------------------


end main