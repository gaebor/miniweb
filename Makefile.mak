CC=cl
LD=link
CFLAGS=/Ox /W3 /Ilibctb/include /c /nologo /TC /MT
HTTPOBJ=httppil.obj http.obj httpxml.obj httphandler.obj httppost.obj httpauth.obj
HEADERS=httpint.h httpapi.h httpxml.h
TARGET=miniweb

DEFINES= /D_CRT_SECURE_NO_DEPRECATE /DNDEBUG /DNODEBUG /DWIN32
LDFLAGS= WSock32.Lib

!ifdef ENABLE_SERIAL
HTTPOBJ+= httpserial.obj libctb/src/fifo.obj libctb/src/serportx.obj
HEADERS+= httpserial.h
DEFINES+= -Ilibctb/include
!endif

default: all

all: $(HTTPOBJ) miniweb.obj
	$(LD) $(LDFLAGS) $(HTTPOBJ) miniweb.obj /OUT:$(TARGET).exe

.c.obj:
	$(CC) $(DEFINES) $(CFLAGS) $<

min: $(HTTPOBJ) httpmin.obj
	$(LD) $(LDFLAGS) $(HTTPOBJ) httpmin.obj /OUT:httpd.exe

clean:
	del /Q *.obj *.exe
	del /Q *.obj
	rd /Q /S Debug Release
