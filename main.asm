	.386p
	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 301h
	?debug	S "main.c"
	?debug	C E90CA8A72E066D61696E2E63
_TEXT	segment byte public use16 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public use16 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public use16 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public use16 'CODE'
   ;	
   ;	void main(void)
   ;	
	assume	cs:_TEXT,ds:DGROUP
_main	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;	        puts(VERSION);
   ;	
	push	offset DGROUP:s@
	call	near ptr _puts
	pop	cx
   ;	
   ;	        puts(GOODBYE);
   ;	
	push	offset DGROUP:s@+55
	call	near ptr _puts
	pop	cx
   ;	
   ;	}
   ;	
	pop	bp
	ret	
_main	endp
_TEXT	ends
_DATA	segment word public use16 'DATA'
_pos	label	word
	db	128
	db	2
_DATA	ends
_TEXT	segment byte public use16 'CODE'
   ;	
   ;	void puts(char *string) 
   ;	
	assume	cs:_TEXT,ds:DGROUP
_puts	proc	near
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,word ptr [bp+4]
   ;	
   ;	{
   ;	        int i = 0;
   ;	
	xor	cx,cx
	jmp	short @2@226
@2@58:
   ;	
   ;	
   ;	        while(string[i]!=0) {
   ;	                _AL = string[i];
   ;	
	mov	bx,cx
	mov	al,byte ptr [bx+si]
   ;	
   ;	                if(_AL==0x0a) {
   ;	
	cmp	al,10
	jne	short @2@114
   ;	
   ;	                        pos += 80*2 - pos%(80*2);
   ;	
	mov	ax,word ptr DGROUP:_pos
	mov	bx,160
	cwd	
	idiv	bx
	mov	ax,160
	sub	ax,dx
	add	word ptr DGROUP:_pos,ax
   ;	
   ;	                } else {
   ;	
	jmp	short @2@198
@2@114:
   ;	
   ;	                        putc(_AL,pos,7);
   ;	
	mov	ah,7
	mov	di,word ptr DGROUP:_pos
 	stosw	
   ;	
   ;	                        pos += 2;
   ;	
	add	word ptr DGROUP:_pos,2
@2@198:
   ;	
   ;	                }
   ;	                i++;
   ;	
	inc	cx
@2@226:
	mov	bx,cx
	cmp	byte ptr [bx+si],0
	jne	short @2@58
   ;	
   ;	        }
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_puts	endp
	?debug	C E9
	?debug	C FA00000000
_TEXT	ends
_DATA	segment word public use16 'DATA'
s@	label	byte
	db	'npuBeT u3 protected mode'
	db	10
	db	'build: 21:34:30, May  7 2003'
	db	10
	db	0
	db	'DocBuDaHu9I!!!'
	db	10
	db	0
_DATA	ends
_TEXT	segment byte public use16 'CODE'
_TEXT	ends
_s@	equ	s@
	public	_puts
	public	_main
	public	_pos
	end
