flag macro temp
	;-----flag top-----
	mov temp,625
	mov cx,10 ;height control
	L3:
		push cx
		mov cx,630 ;width end point
		L4:
			mov bp,sp 
			mov dx,[bp]
			add dx,10
			mov al,0010b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,620 ; width start reached check
			je ftope
		loop L4
		ftope:
		pop cx
	loop L3

	;----- pole -----
	mov cx,349;50  ;height control
	L2:
		push cx
		mov cx,627 ;639 ;width control
		L1:
			mov bp,sp 
			mov dx,[bp] ;
			add dx,20
			mov al,1000b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,624 ;width start reached check
			je fpole
		loop L1
		fpole:
		pop cx
	loop L2
	;-----flag-----
	mov cx,40  ;height control
	L6:
		push cx
		mov cx,627 ;width control
		L5:
			mov bp,sp 
			mov dx,[bp]
			add dx,21
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,temp ;width start reached check
			je flagE
		loop L5
		flagE:
		;triangle control
		mov cx,temp
		sub cx,1
		mov temp,cx
		pop cx
	loop L6
	;-----flag logo----- 
	; creating rectangle
	mov cx,15; height control
	L8:
	push cx
	mov cx,624
	L7:
	mov bp,sp 
			mov dx,[bp]
			add dx,25
			mov al,0010b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,608
			je flagDesign
		loop L7
		flagDesign:
		pop cx
	loop L8
	; creating logo

	;---lower right---

	mov cx,4; height control
	L9:
	push cx
	mov cx,624
	L10:
	mov bp,sp 
			mov dx,[bp]
			add dx,36
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,620
			je lowright
		loop L10
		lowright:
		pop cx
	loop L9

	;---lower left---
	
	mov cx,4; height control
	L11:
	push cx
	mov cx,612
	L12:
	mov bp,sp 
			mov dx,[bp]
			add dx,36
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,608
			je lowleft
		loop L12
		lowleft:
		pop cx
	loop L11

	;---upper right---
	mov cx,3; height control
	L13:
	push cx
	mov cx,624
	L14:
	mov bp,sp 
			mov dx,[bp]
			add dx,25
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,622
			je upperright
		loop L14
		upperright:
		pop cx
	loop L13
	
	;---upper left---
	mov cx,3; height control
	L15:
	push cx
	mov cx,610
	L16:
	mov bp,sp 
			mov dx,[bp]
			add dx,25
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,608
			je upperleft
		loop L16
		upperleft:
		pop cx
	loop L15
	;---left eye---
	mov cx,2; height control
	L17:
	push cx
	mov cx,614
	L18:
	mov bp,sp 
			mov dx,[bp]
			add dx,28
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,612
			je lefteye
		loop L18
		lefteye:
		pop cx
	loop L17

	;---right eye---
	mov cx,2; height control
	L19:
	push cx
	mov cx,620
	L20:
			mov bp,sp 
			mov dx,[bp]
			add dx,28
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,618
			je righteye
		loop L20
		righteye:
		pop cx
	loop L19

	;---mouth---
	mov cx,3; height control
	L21:
	push cx
	mov cx,617
	L22:
			mov bp,sp 
			mov dx,[bp]
			add dx,33
			mov al,1111b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,616
			je mouth
		loop L22
		mouth:
		pop cx
	loop L21
	
	
	
endm