VC = 2.17
VD = 3.0A+nishi

DESTDIR = 
PREFIX = /usr/w3c
CC = gcc
AR = ar
CFLAGS = -Iinclude/lib -Iinclude/daemon -DVC='"$(VC)"' -DVD='"$(VD)"' -D_DEFAULT_SOURCE -DPREFIX='"$(PREFIX)"'
LDFLAGS =
LIBS = -lcrypt

.PHONY: all clean install
.SUFFIXES: .c .o

all: httpd$(EXEC) htadm$(EXEC) cgiparse$(EXEC) cgiutils$(EXEC) htimage$(EXEC)

WWW_OBJS = \
	src/lib/HTParse.o src/lib/HTAccess.o src/lib/HTTP.o \
        src/lib/HTFile.o src/lib/HTBTree.o src/lib/HTFTP.o src/lib/HTTCP.o \
        src/lib/SGML.o src/lib/HTML.o src/lib/HTMLPDTD.o src/lib/HTChunk.o \
        src/lib/HTPlain.o src/lib/HTWriter.o src/lib/HTFWriter.o \
        src/lib/HTMLGen.o src/lib/HTTee.o\
        src/lib/HTAtom.o src/lib/HTAnchor.o src/lib/HTStyle.o \
        src/lib/HTList.o src/lib/HTString.o src/lib/HTAlert.o \
        src/lib/HTRules.o src/lib/HTFormat.o src/lib/HTInit.o src/lib/HTMIME.o \
        src/lib/HTHistory.o src/lib/HTNews.o src/lib/HTGopher.o \
        src/lib/HTTelnet.o src/lib/HTWSRC.o \
        src/lib/HTAAUtil.o src/lib/HTAABrow.o src/lib/HTAssoc.o \
        src/lib/HTUU.o src/lib/HTMulti.o src/lib/HTTeXGen.o \
        src/lib/HTDirBrw.o src/lib/HTDescript.o src/lib/HTGuess.o \
        src/lib/HTIcons.o src/lib/HTError.o src/lib/HTErrorMsg.o

HTTPD_OBJS = \
	src/daemon/HTDaemon.o src/daemon/HTRequest.o src/daemon/HTRetrieve.o src/daemon/HTScript.o src/daemon/HTLoad.o \
        src/daemon/HTCache.o src/daemon/HTCacheInfo.o src/daemon/HTConfig.o src/daemon/HTWild.o \
        src/daemon/HTSInit.o src/daemon/HTSUtils.o src/daemon/HTims.o \
        src/daemon/HTPasswd.o src/daemon/HTAuth.o src/daemon/HTLex.o src/daemon/HTGroup.o src/daemon/HTACL.o src/daemon/HTAAProt.o \
        src/daemon/HTAAServ.o src/daemon/HTAAFile.o src/daemon/HTLog.o src/daemon/HTgc.o src/daemon/HTUserInit.o src/daemon/HTRFC931.o

HTADM_OBJS = \
	src/daemon/HTAdm.o src/daemon/HTPasswd.o src/daemon/HTAAFile.o

CGIPARSE_OBJS = \
	src/daemon/CGIParse.o

CGIUTILS_OBJS = \
	src/daemon/cgiutils.o src/daemon/HTSUtils.o

HTIMAGE_OBJS = \
	src/daemon/HTImage.o

httpd$(EXEC): $(HTTPD_OBJS) libwww.a
	$(CC) $(LDFLAGS) -o $@ $(HTTPD_OBJS) libwww.a $(LIBS)

htadm$(EXEC): $(HTADM_OBJS) libwww.a
	$(CC) $(LDFLAGS) -o $@ $(HTADM_OBJS) libwww.a $(LIBS)

cgiparse$(EXEC): $(CGIPARSE_OBJS) libwww.a
	$(CC) $(LDFLAGS) -o $@ $(CGIPARSE_OBJS) libwww.a $(LIBS)

cgiutils$(EXEC): $(CGIUTILS_OBJS) libwww.a
	$(CC) $(LDFLAGS) -o $@ $(CGIUTILS_OBJS) libwww.a $(LIBS)

htimage$(EXEC): $(HTIMAGE_OBJS) libwww.a
	$(CC) $(LDFLAGS) -o $@ $(HTIMAGE_OBJS) libwww.a $(LIBS)

libwww.a: $(WWW_OBJS)
	$(AR) rcs $@ $(WWW_OBJS)

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f libwww.a httpd$(EXEC) htadm$(EXEC) cgiparse$(EXEC) cgiutils$(EXEC) htimage$(EXEC) src/*/*.o

install: all
	mkdir -p $(DESTDIR)/$(PREFIX)/
	mkdir -p $(DESTDIR)/$(PREFIX)/bin
	mkdir -p $(DESTDIR)/$(PREFIX)/etc
	mkdir -p $(DESTDIR)/$(PREFIX)/icons
	cd root/icons && for i in *; do \
		if [ '!' -f $(DESTDIR)/$(PREFIX)/icons/$$i ]; then \
			cp $$i $(DESTDIR)/$(PREFIX)/icons/ ; \
		fi ; \
	done
	cd root/config && for i in *; do \
		if [ '!' -f $(DESTDIR)/$(PREFIX)/etc/$$i ]; then \
			cp $$i $(DESTDIR)/$(PREFIX)/etc/ ; \
		fi ; \
	done
	for i in httpd$(EXEC) htadm$(EXEC) cgiparse$(EXEC) cgiutils$(EXEC) htimage$(EXEC); do \
		cp $$i $(DESTDIR)/$(PREFIX)/bin/ ; \
	done
