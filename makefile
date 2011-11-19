# FOO_OS -- учебная операционная система
# (c) 2003, Kolia Morev <kolia39@mail.ru>
# 
# Makefile.

CC = bcc
AS = tasm
LD = tlink 

CFLAGS  = -3 -c -v
ASFLAGS = /m2
LDFLAGS = /3

LISTING = ,
ASDEBUG = /zi  
LDDEBUG = /v /m

OBJS = startup.obj main.obj


all:  foo_os.exe

foo_os.exe:  $(OBJS) makefile
  $(LD) $(LDFLAGS) $(LDDEBUG) $(OBJS), foo_os.exe,,

.asm.obj:
  $(AS) $(ASFLAGS) $(ASDEBUG) $<, $(LISTING)

.c.obj:
  $(CC) $(CFLAGS) $<

# Зависимости
startup.obj:  makefile startup.asm startup.mac \
        main.obj
main.obj: makefile main.c
