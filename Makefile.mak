CC=cl
LD=link
CFLAGS=/Ox /W3 /Ilibctb/include /nologo /TC /MT
HTTPOBJ=httppil.obj http.obj httpxml.obj httphandler.obj httppost.obj httpauth.obj loadplugin.obj
HEADERS=httpint.h httpapi.h httpxml.h

DEFINES= /D_CRT_SECURE_NO_DEPRECATE /DNDEBUG /DNODEBUG /DWIN32
LDFLAGS= WSock32.Lib

!ifdef ENABLE_SERIAL
HTTPOBJ+= httpserial.obj libctb/src/fifo.obj libctb/src/serportx.obj
HEADERS+= httpserial.h
DEFINES+= -Ilibctb/include
!endif

default: miniweb

miniweb: miniweb.exe

miniweb.exe: $(HTTPOBJ) miniweb.obj
	$(LD) $(LDFLAGS) $(HTTPOBJ) miniweb.obj /OUT:miniweb.exe

all : miniweb postfile plugin

must_build:

postfile : must_build 
	$(CC) $(CFLAGS) $(DEFINES) /Ipostfile postfile/*.c /link $(LDFLAGS) /OUT:postfile.exe

plugin : must_build
	$(CC) $(CFLAGS) /I. $(DEFINES) plugin/plugin.c /link $(LDFLAGS) /DLL /OUT:plugin.dll

.c.obj::
	$(CC) $(DEFINES) $(CFLAGS) /c $<

clean:
	del /Q *.obj *.exe
	del /Q *.obj
	rd /Q /S Win32
