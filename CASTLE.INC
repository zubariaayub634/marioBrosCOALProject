castle macro temp

;drawing of base
mov cx,100 ;sets height of base
Castle1:
	push cx
	mov cx,639 ;sets width end point of base
	Castle2:
		mov bp,sp
		mov dx,[bp]
		add dx,280
		mov al,0110b
		mov bh,0
		mov ah,0ch
		int 10h		
		cmp cx,540 ;checks if width start point of base reached
		je EndCastle
	loop Castle2
	EndCastle:
	pop cx
loop Castle1

;drawing upper part
mov cx,50 ;sets height
Castle3:
	push cx
	mov cx,620 ;sets width end point
	Castle4:
		mov bp,sp
		mov dx,[bp]
		add dx,230
		mov al,0110b
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,565 ; checks width start reached
		je EndCastle2
	loop Castle4
	EndCastle2:
	pop cx
loop Castle3

;drawing door
mov cx,60 ;sets height of base
CastleDoor1:
	push cx
	mov cx,610 ;sets width end point of base
	CastleDoor2:
		mov bp,sp
		mov dx,[bp]
		add dx,300
		mov al,0000b
		mov bh,0
		mov ah,0ch
		int 10h		
		cmp cx,575 ;checks if width start point of base reached
		je EndCastleDoor
	loop CastleDoor2
	EndCastleDoor:
	pop cx
loop CastleDoor1

;drawing windows
mov cx,25 ;sets height
CastleWindowR3:
	push cx
	mov cx,610 ;sets width end point
	CastleWindowR4:
		mov bp,sp
		mov dx,[bp]
		add dx,240
		mov al,0000b
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,597 ; checks width start reached
		je EndCastleWindowR2
	loop CastleWindowR4
	EndCastleWindowR2:
	pop cx
loop CastleWindowR3

mov cx,25 ;sets height
CastleWindowL3:
	push cx
	mov cx,588 ;sets width end point
	CastleWindowL4:
		mov bp,sp
		mov dx,[bp]
		add dx,240
		mov al,0000b
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,575 ; checks width start reached
		je EndCastleWindowL2
	loop CastleWindowL4
	EndCastleWindowL2:
	pop cx
loop CastleWindowL3

;---details---
mov cx,15 ;sets height
CastleDetail13:
	push cx
	mov cx,620 ;sets width end point
	CastleDetail14:
		mov bp,sp
		mov dx,[bp]
		add dx,215
		mov al,0110b
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,610 ; checks width start reached
		je EndCastleDetail12
	loop CastleDetail14
	EndCastleDetail12:
	pop cx
loop CastleDetail13

mov cx,15 ;sets height
CastleDetail23:
	push cx
	mov cx,597 ;sets width end point
	CastleDetail24:
		mov bp,sp
		mov dx,[bp]
		add dx,215
		mov al,0110b
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,587 ; checks width start reached
		je EndCastleDetail22
	loop CastleDetail24
	EndCastleDetail22:
	pop cx
loop CastleDetail23

mov cx,15 ;sets height
CastleDetail33:
	push cx
	mov cx,575 ;sets width end point
	CastleDetail34:
		mov bp,sp
		mov dx,[bp]
		add dx,215
		mov al,0110b
		mov bh,0
		mov ah,0ch
		int 10h
		cmp cx,565 ; checks width start reached
		je EndCastleDetail32
	loop CastleDetail34
	EndCastleDetail32:
	pop cx
loop CastleDetail33

endm