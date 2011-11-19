; FOO_OS -- учебная операционная система
; (c) 2003, Kolia Morev <kolia39@mail.ru>
;
; Начальная загрузка ОС.

.386p

include startup.mac

; Из main.c
extrn  C main:proc

DGROUP        group        _DATA,_BSS
        assume        cs:_TEXT,ds:DGROUP
_DATA        segment word public use16 'DATA'

gdt        label  word
;
gdt_null   descr  <0,0,0,0,0,0>
sel_code   = 10q
gdt_code   descr  <0FFFFh,,,10011010b>
sel_data   = 20q
gdt_data   descr  <0FFFFh,,,10010010b>
sel_stack  = 30q
gdt_stack  descr  <size _stack-1,,,10010010b>
sel_screen = 40q
gdt_screen descr  <3999,8000h,0bh,0f2h>
;
gdt_size = $ - gdt

idt  label word
     intr  256 dup (<>)
idt_size = 256 * size intr

; Поля данных программы
tmpdescr        descr <>
message_exit    db    '* exit: PeaJIbHbIu Pe>|<uM.$'

_DATA   ends

_BSS    segment word public use16 'BSS'
_BSS    ends


_TEXT   segment byte public use16 'CODE'
        assume cs:_TEXT,ds:DGROUP

startup:
        mov     ax,dgroup
        mov     ds,ax

        perehod_v_prot_mode

; Переход в защищённый режим
        mov     eax,cr0
        or      eax,1b
        mov     cr0,eax

; Теперь процессор работает в защищённом режиме
; Загрузка в CS селектора сегмента команд,
; перезагрузка буфера команд
        db      0eah
        dw      offset continue
        dw      sel_code
continue:

; Инициализируем сегментные регистры
        mov     ax,sel_data
        mov     ds,ax
        mov     ax,sel_stack
        mov     ss,ax
        mov     ax,sel_screen
        mov     es,ax
        mov     ax,0
        mov     gs,ax
        mov     fs,ax

; Запускаем ядро ОС
        call    main

        perehod_v_real_mode

; Проверим выполнение функций DOS и завершим программу
        mov     ah,09h
        mov     dx,offset message_exit
        int     21h
        mov     ax,4c00h
        int     21h

_TEXT   ends

_STACK  segment stack 'stack'
        org 200h
_STACK  ends

        end     startup
