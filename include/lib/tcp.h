/*                                                      System dependencies in the W3 library
                                   SYSTEM DEPENDENCIES
                                             
   System-system differences for TCP include files and macros. This file includes for each
   system the files necessary for network and file I/O.  Part of libwww.
   
  AUTHORS
  
  TBL                     Tim Berners-Lee, W3 project, CERN, <timbl@info.cern.ch>
                         
  EvA                     Eelco van Asperen <evas@cs.few.eur.nl>
                         
  MA                      Marc Andreesen NCSA
                         
  MD                      Mark Donszelmann <duns@vxcern.cern.ch>
                         
  AT                      Aleksandar Totic <atotic@ncsa.uiuc.edu>
                         
  SCW                     Susan C. Weber <sweber@kyle.eitech.com>
                         
  HF                      Henrik Frystyk, <frystyk@dxcern.cern.ch>
                         
  HISTORY:
  
  22 Feb 91               Written (TBL) as part of the WWW library.
                         
  16 Jan 92               PC code from (EvA)
                         
  22 Apr 93               Merged diffs bits from xmosaic release
                         
  29 Apr 93               Windows/NT code from (SCW)
                         
  29 Sep 93               VMS fixes (MD)
                         
 */

#ifndef TCP_H
#define TCP_H

#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>

#if defined(__unix__)
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/select.h>
#include <netdb.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <dirent.h>
#include <sys/wait.h>
#include <sys/param.h>

#define NETCLOSE close

#define SELECT
#define GOT_SYSTEM
#define POSIXWAIT

#define USE_DIRENT
#define GOT_READ_DIR
#define STRUCT_DIRENT struct dirent

#define FORKING
#endif

typedef struct sockaddr_in SockA;

#define NETREAD(x,y,z) recv(x,y,z,0)
#define NETWRITE(x,y,z) send(x,y,z,0)

#define GLOBALDEF
#define GLOBALREF extern

#define HTStat stat
#define HTLstat lstat

#define TOASCII(c) (c)
#define FROMASCII(c) (c)

#if defined(MAXPATHLEN)
#define HT_MAX_PATH MAXPATHLEN
#elif defined(PATH_MAX)
#define HT_MAX_PATH PATH_MAX
#endif

#define WHITE(c) (((unsigned char)(TOASCII(c))) <= 32)
/*

  CACHE FILE PREFIX
  
   This is something onto which we tag something meaningful to make a cache file name.
   used in HTWSRC.c at least. If it is nor defined at all, caching is turned off.
   
 */

#ifndef CACHE_FILE_PREFIX
#ifdef unix
#define CACHE_FILE_PREFIX  "/usr/wsrc/"
#endif
#endif

#endif
/*

   End of system-specific file  */
