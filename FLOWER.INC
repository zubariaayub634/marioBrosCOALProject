flower macro temp,temp1
; flower coordinates are height=25, starting width=250, ending width=275, drawing starting point=190
; creating rectangle
	mov cx,25; height control
	flower1:
	push cx
	mov cx,275
	flower2:
	mov bp,sp 
			mov dx,[bp]
			add dx,190
			mov al,0101b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,250
			je flowerRect
		loop flower2
		flowerRect:
		pop cx
	loop flower1
;creating stem
	;---right---
	mov cx,5; height control
	flower3:
	push cx
	mov cx,275
	flower4:
	mov bp,sp 
			mov dx,[bp]
			add dx,205
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,267
			je upperR
		loop flower4
		upperR:
		pop cx
	loop flower3
	
	;---left---
	mov cx,5; height control
	flower5:
	push cx
	mov cx,259
	flower6:
			mov bp,sp 
			mov dx,[bp]
			add dx,205
			mov al,1001b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,250
			je upperL
		loop flower6
		upperL:
		pop cx
	loop flower5

	; flower centre
	mov cx,10; height control
	flower7:
	push cx
	mov cx,270
	flower8:
	mov bp,sp 
			mov dx,[bp]
			add dx,192
			mov al,1101b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,255
			je flowerCen
		loop flower8
		flowerCen:
		pop cx
	loop flower7

	; flower inner centre
	mov cx,5; height control
	flower9:
	push cx
	mov cx,267
	flower10:
	mov bp,sp 
			mov dx,[bp]
			add dx,194
			mov al,0011b
			mov bh,0
			mov ah,0Ch
			int 10h
			cmp cx,260
			je flowerCent
		loop flower10
		flowerCent:
		pop cx
	loop flower9
	
endm