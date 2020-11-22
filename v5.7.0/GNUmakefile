SHELL := cmd.exe
GCCBIN := gcc
INST_DRV := c:
INST_TOP := $(INST_DRV)\perl
#INST_VER	:= \__INST_VER__
#INST_ARCH	:= \$(ARCHNAME)
#USE_SITECUST	:= define
USE_MULTI	:= define
USE_ITHREADS	:= define
USE_IMP_SYS	:= define
USE_LARGE_FILES	:= define
#USE_64_BIT_INT	:= define
#USE_LONG_DOUBLE :=define
#USE_NO_REGISTRY := define
CCTYPE		:= GCC
#CFG		:= Debug
#USE_PERLCRT	= define
#USE_SETARGV	:= define
#USE_5005THREADS:= define
#CRYPT_SRC	= .\fcrypt.c
#CRYPT_LIB	= fcrypt.lib
#PERL_MALLOC	:= define
#DEBUG_MSTATS	:= define
CCHOME		:= C:\MinGW

CCINCDIR := $(CCHOME)\include
CCLIBDIR := $(CCHOME)\lib
CCDLLDIR := $(CCHOME)\bin
ARCHPREFIX :=

BUILDOPT	:= $(BUILDOPTEXTRA)

BUILDOPT	+= -DPERL_TEXTMODE_SCRIPTS

EXTRALIBDIRS	:=


D_CRYPT		?= undef
PERL_MALLOC	?= undef
DEBUG_MSTATS	?= undef

USE_SITECUST	?= undef
USE_MULTI	?= undef
USE_ITHREADS	?= undef
USE_IMP_SYS	?= undef
USE_LARGE_FILES	?= undef
USE_64_BIT_INT	?= undef
USE_LONG_DOUBLE	?= undef
USE_NO_REGISTRY	?= undef
USE_5005THREADS ?= undef

ifneq ("$(CRYPT_SRC)$(CRYPT_LIB)", "")
D_CRYPT		= define
CRYPT_FLAG	= -DHAVE_DES_FCRYPT
endif

ifeq ($(USE_IMP_SYS),define)
PERL_MALLOC	= undef
endif

ifeq ($(PERL_MALLOC),undef)
DEBUG_MSTATS	= undef
endif

ifeq ($(DEBUG_MSTATS),define)
BUILDOPT	+= -DPERL_DEBUGGING_MSTATS
endif

ifeq ("$(USE_IMP_SYS) $(USE_MULTI)","define undef")
USE_MULTI	= define
endif

ifeq ("$(USE_ITHREADS) $(USE_MULTI)","define undef")
USE_MULTI	= define
endif

ifeq ($(USE_SITECUST),define)
BUILDOPT	+= -DUSE_SITECUSTOMIZE
endif

ifneq ($(USE_MULTI),undef)
BUILDOPT	+= -DPERL_IMPLICIT_CONTEXT
endif

ifneq ($(USE_IMP_SYS),undef)
BUILDOPT	+= -DPERL_IMPLICIT_SYS
endif

ifeq ($(USE_NO_REGISTRY),define)
BUILDOPT	+= -DWIN32_NO_REGISTRY
endif

WIN64 := define
PROCESSOR_ARCHITECTURE := x64
USE_64_BIT_INT = define
ARCHITECTURE = x64

ifeq ($(USE_5005THREADS),define)
ARCHNAME	= MSWin32-$(ARCHITECTURE)-thread
else ifeq ($(USE_MULTI),define)
ARCHNAME	= MSWin32-$(ARCHITECTURE)-multi
else
endif

ifeq ($(USE_ITHREADS),define)
ARCHNAME	:= $(ARCHNAME)-thread
endif

ifneq ($(WIN64),define)
ifeq ($(USE_64_BIT_INT),define)
ARCHNAME	:= $(ARCHNAME)-64int
endif
endif

ifeq ($(USE_LONG_DOUBLE),define)
ARCHNAME	:= $(ARCHNAME)-ld
endif

ARCHDIR		= ..\lib\$(ARCHNAME)
COREDIR		= ..\lib\CORE
AUTODIR		= ..\lib\auto
LIBDIR		= ..\lib
EXTDIR		= ..\ext
DISTDIR		= ..\dist
CPANDIR		= ..\cpan
PODDIR		= ..\pod
EXTUTILSDIR	= $(LIBDIR)\ExtUtils
HTMLDIR		= .\html

#
INST_SCRIPT	= $(INST_TOP)$(INST_VER)\bin
INST_BIN	= $(INST_SCRIPT)$(INST_ARCH)
INST_LIB	= $(INST_TOP)$(INST_VER)\lib
INST_ARCHLIB	= $(INST_LIB)$(INST_ARCH)
INST_COREDIR	= $(INST_ARCHLIB)\CORE
INST_HTML	= $(INST_TOP)$(INST_VER)\html

#
# Programs to compile, build .lib files and link
#

MINIBUILDOPT    :=

CC		= $(ARCHPREFIX)gcc
LINK32		= $(ARCHPREFIX)g++
LIB32		= $(ARCHPREFIX)ar rc
IMPLIB		= $(ARCHPREFIX)dlltool
RSC		= $(ARCHPREFIX)windres

ifeq ($(USE_LONG_DOUBLE),define)
BUILDOPT        += -D__USE_MINGW_ANSI_STDIO
MINIBUILDOPT    += -D__USE_MINGW_ANSI_STDIO
endif

BUILDOPT        += -fwrapv
MINIBUILDOPT    += -fwrapv

i = .i
o = .o
a = .a

#
# Options
#

INCLUDES	= -I.\include -I. -I..
DEFINES		= -DWIN32 -DWIN64 -DCONSERVATIVE -DNO_STRICT $(CRYPT_FLAG)
LOCDEFS		= -DPERLDLL -DPERL_CORE
CXX_FLAG	= -xc++
LIBC		=
LIBFILES	= $(LIBC) -lmoldname -lkernel32 -luser32 -lgdi32 -lwinspool \
	-lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -lnetapi32 \
	-luuid -lws2_32 -lmpr -lwinmm -lversion -lodbc32 -lodbccp32

ifeq ($(CFG),Debug)
OPTIMIZE	= -g -O2 -DDEBUGGING
LINK_DBG	= -g
else
OPTIMIZE	= -s -O2
LINK_DBG	= -s
endif

EXTRACFLAGS	=
CFLAGS		= $(EXTRACFLAGS) $(INCLUDES) $(DEFINES) $(LOCDEFS) $(OPTIMIZE)
LINK_FLAGS	= $(LINK_DBG) -L"$(INST_COREDIR)" -L"$(CCLIBDIR)"
OBJOUT_FLAG	= -o
EXEOUT_FLAG	= -o
LIBOUT_FLAG	=
PDBOUT		=

BUILDOPT	+= -fno-strict-aliasing -mms-bitfields
MINIBUILDOPT	+= -fno-strict-aliasing

TESTPREPGCC	= test-prep-gcc

CFLAGS_O	= $(CFLAGS) $(BUILDOPT)
BLINK_FLAGS	= $(PRIV_LINK_FLAGS) $(LINK_FLAGS)

#################### do not edit below this line #######################
############# NO USER-SERVICEABLE PARTS BEYOND THIS POINT ##############

#prevent -j from reaching EUMM/make_ext.pl/"sub makes", Win32 EUMM not parallel
#compatible yet
unexport MAKEFLAGS

a ?= .lib

.SUFFIXES : .c .i $(o) .dll $(a) .exe .rc .res

%$(o): %.c
	$(CC) -c -I$(<D) $(CFLAGS_O) $(OBJOUT_FLAG)$@ $(PDBOUT) $<

%.i: %.c
	$(CC) -c -I$(<D) $(CFLAGS_O) -E $< >$@

%.c: %.y
	$(NOOP)

%.dll: %$(o)
	$(LINK32) -o $@ $(BLINK_FLAGS) $< $(LIBFILES)
	$(IMPLIB) --input-def $(*F).def --output-lib $(*F).a $@

%.res: %.rc
	$(RSC) --use-temp-file --include-dir=. --include-dir=.. -O COFF -D INCLUDE_MANIFEST -i $< -o $@

MINIPERL	= ..\miniperl.exe
HAVEMINIPERL	= .have_miniperl
MINIDIR		= mini
PERLEXE		= ..\perl.exe
WPERLEXE	= ..\wperl.exe
STATICDIR	= .\static.tmp
GLOBEXE		= ..\perlglob.exe
CONFIGPM	= ..\lib\Config.pm
MINIMOD	= ..\lib\ExtUtils\Miniperl.pm
X2P		= ..\x2p\a2p.exe

PERLDEP = $(PERLIMPLIB)


PL2BAT		= bin\pl2bat.pl

UTILS		=			\
		..\utils\h2ph		\
		..\utils\splain		\
		..\utils\dprofpp	\
		..\utils\perlbug	\
		..\utils\pl2pm 		\
		..\utils\c2ph		\
		..\utils\h2xs		\
		..\utils\perldoc	\
		..\utils\perlcc		\
		..\pod\checkpods	\
		..\pod\pod2html		\
		..\pod\pod2latex	\
		..\pod\pod2man		\
		..\pod\pod2text		\
		..\pod\pod2usage	\
		..\pod\podchecker	\
		..\pod\podselect	\
		..\x2p\find2perl	\
		..\x2p\s2p		\
		bin\exetype.pl		\
		bin\runperl.pl		\
		bin\pl2bat.pl		\
		bin\perlglob.pl		\
		bin\search.pl

CFGSH_TMPL	= config.gc
CFGH_TMPL	= config_H.gc
PERLIMPLIB	= $(COREDIR)\libperl__PERL_MINOR_VERSION__$(a)
PERLIMPLIBBASE	= libperl__PERL_MINOR_VERSION__$(a)
INT64		= long long
PERLEXPLIB	= $(COREDIR)\perl__PERL_MINOR_VERSION__.exp
PERLDLL		= ..\perl__PERL_MINOR_VERSION__.dll

# don't let "gmake -n all" try to run "miniperl.exe make_ext.pl"
PLMAKE		= gmake

XCOPY		= xcopy /f /r /i /d /y
RCOPY		= xcopy /f /r /i /e /d /y
NOOP		= @rem

XSUBPP		= ..\$(MINIPERL) -I..\..\lib ..\$(EXTUTILSDIR)\xsubpp \
		-C++ -prototypes

MICROCORE_SRC	=		\
		..\av.c		\
		..\deb.c	\
		..\doio.c	\
		..\doop.c	\
		..\dump.c	\
		..\globals.c	\
		..\gv.c		\
		..\hv.c		\
		..\mg.c		\
		..\op.c		\
		..\perl.c	\
		..\perlapi.c	\
		..\perly.c	\
		..\pp.c		\
		..\pp_ctl.c	\
		..\pp_hot.c	\
		..\pp_sys.c	\
		..\regcomp.c	\
		..\regexec.c	\
		..\run.c	\
		..\scope.c	\
		..\sv.c		\
		..\taint.c	\
		..\toke.c	\
		..\universal.c	\
		..\utf8.c	\
		..\util.c	\
		..\xsutils.c

EXTRACORE_SRC	+= perllib.c

ifeq ($(PERL_MALLOC),define)
EXTRACORE_SRC	+= ..\malloc.c
endif

EXTRACORE_SRC	+= ..\perlio.c

WIN32_SRC	=		\
		.\win32.c	\
		.\win32sck.c	\
		.\win32thread.c 

ifneq ($(CRYPT_SRC), "")
WIN32_SRC	+= $(CRYPT_SRC)
endif

DLL_SRC		= $(DYNALOADER).c

X2P_SRC		=		\
		..\x2p\a2p.c	\
		..\x2p\hash.c	\
		..\x2p\str.c	\
		..\x2p\util.c	\
		..\x2p\walk.c

CORE_NOCFG_H	=		\
		..\av.h		\
		..\cop.h	\
		..\cv.h		\
		..\dosish.h	\
		..\embed.h	\
		..\form.h	\
		..\gv.h		\
		..\handy.h	\
		..\hv.h		\
		..\iperlsys.h	\
		..\mg.h		\
		..\nostdio.h	\
		..\op.h		\
		..\opcode.h	\
		..\perl.h	\
		..\perlapi.h	\
		..\perlsdio.h	\
		..\perlsfio.h	\
		..\perly.h	\
		..\pp.h		\
		..\proto.h	\
		..\regexp.h	\
		..\scope.h	\
		..\sv.h		\
		..\thread.h	\
		..\unixish.h	\
		..\utf8.h	\
		..\util.h	\
		..\warnings.h	\
		..\XSUB.h	\
		..\EXTERN.h	\
		..\perlvars.h	\
		..\intrpvar.h	\
		..\thrdvar.h	\
		.\include\dirent.h	\
		.\include\netdb.h	\
		.\include\sys\socket.h	\
		.\win32.h

CORE_H		= $(CORE_NOCFG_H) .\config.h

MICROCORE_OBJ	= $(MICROCORE_SRC:.c=$(o))
CORE_OBJ	= $(MICROCORE_OBJ) $(EXTRACORE_SRC:.c=$(o))
WIN32_OBJ	= $(WIN32_SRC:.c=$(o))

MINICORE_OBJ	= $(subst ..\,mini\,$(MICROCORE_OBJ))	\
		  $(MINIDIR)\miniperlmain$(o)	\
		  $(MINIDIR)\perlio$(o)
MINIWIN32_OBJ	= $(subst .\,mini\,$(WIN32_OBJ))
MINI_OBJ	= $(MINICORE_OBJ) $(MINIWIN32_OBJ)
DLL_OBJ		= $(DLL_SRC:.c=$(o))
X2P_OBJ		= $(X2P_SRC:.c=$(o))
PERLDLL_OBJ	= $(CORE_OBJ)
PERLEXE_OBJ	= perlmain$(o)
PERLEXEST_OBJ	= perlmainst$(o)

PERLDLL_OBJ	+= $(WIN32_OBJ) $(DLL_OBJ)

ifneq ($(USE_SETARGV),)
SETARGV_OBJ	= setargv$(o)
endif

DYNAMIC_EXT	= Socket IO Fcntl Opcode SDBM_File POSIX attrs Thread B re \
		Data/Dumper Devel/Peek ByteLoader Devel/DProf File/Glob \
		Sys/Hostname Storable
STATIC_EXT	= DynaLoader
NONXS_EXT	= Errno

DYNALOADER	= $(EXTDIR)\DynaLoader\DynaLoader
SOCKET		= $(EXTDIR)\Socket\Socket
FCNTL		= $(EXTDIR)\Fcntl\Fcntl
OPCODE		= $(EXTDIR)\Opcode\Opcode
SDBM_FILE	= $(EXTDIR)\SDBM_File\SDBM_File
IO		= $(EXTDIR)\IO\IO
POSIX		= $(EXTDIR)\POSIX\POSIX
ATTRS		= $(EXTDIR)\attrs\attrs
THREAD		= $(EXTDIR)\Thread\Thread
B		= $(EXTDIR)\B\B
RE		= $(EXTDIR)\re\re
DUMPER		= $(EXTDIR)\Data\Dumper\Dumper
ERRNO		= $(EXTDIR)\Errno\Errno
PEEK		= $(EXTDIR)\Devel\Peek\Peek
BYTELOADER	= $(EXTDIR)\ByteLoader\ByteLoader
DPROF		= $(EXTDIR)\Devel\DProf\DProf
GLOB		= $(EXTDIR)\File\Glob\Glob
HOSTNAME	= $(EXTDIR)\Sys\Hostname\Hostname
STORABLE	= $(EXTDIR)\Storable\Storable

SOCKET_DLL	= $(AUTODIR)\Socket\Socket.dll
FCNTL_DLL	= $(AUTODIR)\Fcntl\Fcntl.dll
OPCODE_DLL	= $(AUTODIR)\Opcode\Opcode.dll
SDBM_FILE_DLL	= $(AUTODIR)\SDBM_File\SDBM_File.dll
IO_DLL		= $(AUTODIR)\IO\IO.dll
POSIX_DLL	= $(AUTODIR)\POSIX\POSIX.dll
ATTRS_DLL	= $(AUTODIR)\attrs\attrs.dll
THREAD_DLL	= $(AUTODIR)\Thread\Thread.dll
B_DLL		= $(AUTODIR)\B\B.dll
DUMPER_DLL	= $(AUTODIR)\Data\Dumper\Dumper.dll
PEEK_DLL	= $(AUTODIR)\Devel\Peek\Peek.dll
RE_DLL		= $(AUTODIR)\re\re.dll
BYTELOADER_DLL	= $(AUTODIR)\ByteLoader\ByteLoader.dll
DPROF_DLL	= $(AUTODIR)\Devel\DProf\DProf.dll
GLOB_DLL	= $(AUTODIR)\File\Glob\Glob.dll
HOSTNAME_DLL	= $(AUTODIR)\Sys\Hostname\Hostname.dll
STORABLE_DLL	= $(AUTODIR)\Storable\Storable.dll

ERRNO_PM	= $(LIBDIR)\Errno.pm

EXTENSION_C	= 		\
		$(SOCKET).c	\
		$(FCNTL).c	\
		$(OPCODE).c	\
		$(SDBM_FILE).c	\
		$(IO).c		\
		$(POSIX).c	\
		$(ATTRS).c	\
		$(THREAD).c	\
		$(RE).c		\
		$(DUMPER).c	\
		$(PEEK).c	\
		$(B).c		\
		$(BYTELOADER).c	\
		$(DPROF).c	\
		$(GLOB).c	\
		$(HOSTNAME).c	\
		$(STORABLE).c

EXTENSION_DLL	= 		\
		$(SOCKET_DLL)	\
		$(FCNTL_DLL)	\
		$(OPCODE_DLL)	\
		$(SDBM_FILE_DLL)\
		$(IO_DLL)	\
		$(POSIX_DLL)	\
		$(ATTRS_DLL)	\
		$(DUMPER_DLL)	\
		$(PEEK_DLL)	\
		$(B_DLL)	\
		$(RE_DLL)	\
		$(THREAD_DLL)	\
		$(BYTELOADER_DLL)	\
		$(DPROF_DLL)	\
		$(GLOB_DLL)	\
		$(HOSTNAME_DLL)	\
		$(STORABLE_DLL)

EXTENSION_PM	=		\
		$(ERRNO_PM)

CFG_VARS	=					\
		"INST_DRV=$(INST_DRV)"			\
		"INST_TOP=$(INST_TOP)"			\
		"INST_VER=$(INST_VER)"			\
		"INST_ARCH=$(INST_ARCH)"		\
		"archname=$(ARCHNAME)"			\
		"cc=$(CC)"				\
		"ld=$(LINK32)"				\
		"ccflags=$(subst ",\",$(EXTRACFLAGS) $(OPTIMIZE) $(DEFINES) $(BUILDOPT))" \
		"cf_email=$(EMAIL)"	 		\
		"d_crypt=$(D_CRYPT)"			\
		"d_mymalloc=$(PERL_MALLOC)"		\
		"libs=$(LIBFILES)"			\
		"incpath=$(subst ",\",$(CCINCDIR))"			\
		"libperl=$(subst ",\",$(PERLIMPLIBBASE))"		\
		"libpth=$(subst ",\",$(CCLIBDIR);$(EXTRALIBDIRS))"	\
		"libc=$(LIBC)"				\
		"make=$(PLMAKE)"				\
		"usethreads=$(USE_ITHREADS)"		\
		"use5005threads=$(USE_5005THREADS)"	\
		"useithreads=$(USE_ITHREADS)"		\
		"usethreads=$(USE_5005THREADS)"		\
		"usemultiplicity=$(USE_MULTI)"		\
		"use64bitint=$(USE_64_BIT_INT)"		\
		"uselargefiles=$(USE_LARGE_FILES)"	\
		"LINK_FLAGS=$(subst ",\",$(LINK_FLAGS))"\
		"optimize=$(subst ",\",$(OPTIMIZE))"

ICWD = -I..\cpan\Cwd -I..\cpan\Cwd\lib

#
# Top targets
#

.PHONY: all

all : .\config.h $(GLOBEXE) $(MINIMOD) $(CONFIGPM) $(PERLEXE) $(X2P) $(EXTENSION_DLL) $(EXTENSION_PM)
	@echo Everything is up to date. '$(MAKE_BARE) test' to run test suite.

$(DYNALOADER)$(o) : $(DYNALOADER).c $(CORE_H) $(EXTDIR)\DynaLoader\dlutils.c

#----------------------------------------------------------------

$(GLOBEXE) : perlglob.c
	$(LINK32) $(OPTIMIZE) $(BLINK_FLAGS) -mconsole -o $@ perlglob.c $(LIBFILES)

..\config.sh : $(CFGSH_TMPL) $(HAVEMINIPERL) config_sh.PL
	$(MINIPERL) -I..\lib config_sh.PL $(CFG_VARS) $(CFGSH_TMPL) > ..\config.sh

$(CONFIGPM) : $(HAVEMINIPERL) ..\config.sh config_h.PL ..\minimod.pl
	cd .. && miniperl.exe -Ilib configpm
	$(XCOPY) *.h $(COREDIR)\\*.*
	$(XCOPY) ..\\ext\\re\\re.pm $(LIBDIR)\\*.*
	$(RCOPY) include $(COREDIR)\\*.*
	$(XCOPY) ..\\*.h $(COREDIR)\\*.*
	-$(MINIPERL) -I..\lib $(ICWD) config_h.PL "ARCHPREFIX=$(ARCHPREFIX)"

.\config.h : $(CONFIGPM)
$(MINIDIR)\.exists : $(CFGH_TMPL)
	if not exist "$(MINIDIR)" mkdir "$(MINIDIR)"
	copy $(CFGH_TMPL) config.h
	@(echo.&& \
	echo #ifndef _config_h_footer_&& \
	echo #define _config_h_footer_&& \
	echo #undef PTRSIZE&& \
	echo #undef SSize_t&& \
	echo #undef HAS_ATOLL&& \
	echo #undef HAS_STRTOLL&& \
	echo #undef HAS_STRTOULL&& \
	echo #undef Size_t_size&& \
	echo #undef IVTYPE&& \
	echo #undef UVTYPE&& \
	echo #undef IVSIZE&& \
	echo #undef UVSIZE&& \
	echo #undef NV_PRESERVES_UV&& \
	echo #undef NV_PRESERVES_UV_BITS&& \
	echo #undef IVdf&& \
	echo #undef UVuf&& \
	echo #undef UVof&& \
	echo #undef UVxf&& \
	echo #undef UVXf&& \
	echo #undef USE_64_BIT_INT&& \
	echo #undef Gconvert&& \
	echo #undef HAS_FREXPL&& \
	echo #undef HAS_ISNANL&& \
	echo #undef HAS_MODFL&& \
	echo #undef HAS_MODFL_PROTO&& \
	echo #undef HAS_SQRTL&& \
	echo #undef HAS_STRTOLD&& \
	echo #undef PERL_PRIfldbl&& \
	echo #undef PERL_PRIgldbl&& \
	echo #undef PERL_PRIeldbl&& \
	echo #undef PERL_SCNfldbl&& \
	echo #undef NVTYPE&& \
	echo #undef NVSIZE&& \
	echo #undef LONG_DOUBLESIZE&& \
	echo #undef NV_OVERFLOWS_INTEGERS_AT&& \
	echo #undef NVef&& \
	echo #undef NVff&& \
	echo #undef NVgf&& \
	echo #undef USE_LONG_DOUBLE)>> config.h
ifeq ($(WIN64),define)
	@(echo #define PTRSIZE ^8&& \
	echo #define SSize_t $(INT64)&& \
	echo #define HAS_ATOLL&& \
	echo #define HAS_STRTOLL&& \
	echo #define HAS_STRTOULL&& \
	echo #define Size_t_size ^8)>> config.h
else
	@(echo #define PTRSIZE ^4&& \
	echo #define SSize_t int&& \
	echo #undef HAS_ATOLL&& \
	echo #undef HAS_STRTOLL&& \
	echo #undef HAS_STRTOULL&& \
	echo #define Size_t_size ^4)>> config.h
endif
ifeq ($(USE_64_BIT_INT),define)
	@(echo #define IVTYPE $(INT64)&& \
	echo #define UVTYPE unsigned $(INT64)&& \
	echo #define IVSIZE ^8&& \
	echo #define UVSIZE ^8)>> config.h
ifeq ($(USE_LONG_DOUBLE),define)
	@(echo #define NV_PRESERVES_UV&& \
	echo #define NV_PRESERVES_UV_BITS 64)>> config.h
else
	@(echo #undef NV_PRESERVES_UV&& \
	echo #define NV_PRESERVES_UV_BITS 53)>> config.h
endif
	@(echo #define IVdf "I64d"&& \
	echo #define UVuf "I64u"&& \
	echo #define UVof "I64o"&& \
	echo #define UVxf "I64x"&& \
	echo #define UVXf "I64X"&& \
	echo #define USE_64_BIT_INT)>> config.h
else
	@(echo #define IVTYPE long&& \
	echo #define UVTYPE unsigned long&& \
	echo #define IVSIZE ^4&& \
	echo #define UVSIZE ^4&& \
	echo #define NV_PRESERVES_UV&& \
	echo #define NV_PRESERVES_UV_BITS 32&& \
	echo #define IVdf "ld"&& \
	echo #define UVuf "lu"&& \
	echo #define UVof "lo"&& \
	echo #define UVxf "lx"&& \
	echo #define UVXf "lX"&& \
	echo #undef USE_64_BIT_INT)>> config.h
endif
ifeq ($(USE_LONG_DOUBLE),define)
	@(echo #define Gconvert^(x,n,t,b^) sprintf^(^(b^),"%%.*""Lg",^(n^),^(x^)^)&& \
	echo #define HAS_FREXPL&& \
	echo #define HAS_ISNANL&& \
	echo #define HAS_MODFL&& \
	echo #define HAS_MODFL_PROTO&& \
	echo #define HAS_SQRTL&& \
	echo #define HAS_STRTOLD&& \
	echo #define PERL_PRIfldbl "Lf"&& \
	echo #define PERL_PRIgldbl "Lg"&& \
	echo #define PERL_PRIeldbl "Le"&& \
	echo #define PERL_SCNfldbl "Lf"&& \
	echo #define NVTYPE long double)>> config.h
ifeq ($(WIN64),define)
	@(echo #define NVSIZE ^16&& \
	echo #define LONG_DOUBLESIZE ^16)>> config.h
else
	@(echo #define NVSIZE ^12&& \
	echo #define LONG_DOUBLESIZE ^12)>> config.h
endif
	@(echo #define NV_OVERFLOWS_INTEGERS_AT 256.0*256.0*256.0*256.0*256.0*256.0*256.0*2.0*2.0*2.0*2.0*2.0*2.0*2.0*2.0&& \
	echo #define NVef "Le"&& \
	echo #define NVff "Lf"&& \
	echo #define NVgf "Lg"&& \
	echo #define USE_LONG_DOUBLE)>> config.h
else
	@(echo #define Gconvert^(x,n,t,b^) sprintf^(^(b^),"%%.*g",^(n^),^(x^)^)&& \
	echo #undef HAS_FREXPL&& \
	echo #undef HAS_ISNANL&& \
	echo #undef HAS_MODFL&& \
	echo #undef HAS_MODFL_PROTO&& \
	echo #undef HAS_SQRTL&& \
	echo #undef HAS_STRTOLD&& \
	echo #undef PERL_PRIfldbl&& \
	echo #undef PERL_PRIgldbl&& \
	echo #undef PERL_PRIeldbl&& \
	echo #undef PERL_SCNfldbl&& \
	echo #define NVTYPE double&& \
	echo #define NVSIZE ^8&& \
	echo #define LONG_DOUBLESIZE ^8&& \
	echo #define NV_OVERFLOWS_INTEGERS_AT 256.0*256.0*256.0*256.0*256.0*256.0*2.0*2.0*2.0*2.0*2.0&& \
	echo #define NVef "e"&& \
	echo #define NVff "f"&& \
	echo #define NVgf "g"&& \
	echo #undef USE_LONG_DOUBLE)>> config.h
endif
ifeq ($(USE_CPLUSPLUS),define)
	@(echo #define USE_CPLUSPLUS&& \
	echo #endif)>> config.h
else
	@(echo #undef USE_CPLUSPLUS&& \
	echo #endif)>> config.h
endif
#separate line since this is sentinal that this target is done
	rem. > $(MINIDIR)\.exists

$(CONFIGPM) : $(HAVEMINIPERL) ..\config.sh config_h.PL ..\minimod.pl
	cd .. && miniperl.exe -Ilib configpm
	$(XCOPY) *.h $(COREDIR)\\*.*
	$(XCOPY) ..\\*.inc $(COREDIR)\\*.*
	$(XCOPY) ..\\ext\\re\\re.pm $(LIBDIR)\\*.*
	$(RCOPY) include $(COREDIR)\\*.*
	$(XCOPY) ..\\*.h $(COREDIR)\\*.*
	-$(MINIPERL) -I..\lib $(ICWD) config_h.PL "INST_VER=$(INST_VER)"

$(MINICORE_OBJ) : $(CORE_NOCFG_H)
	$(CC) -c $(CFLAGS) $(MINIBUILDOPT) -DPERL_EXTERNAL_GLOB -DPERL_IS_MINIPERL $(OBJOUT_FLAG)$@ $(PDBOUT) ..\$(*F).c

$(MINIWIN32_OBJ) : $(CORE_NOCFG_H)
	$(CC) -c $(CFLAGS) $(MINIBUILDOPT) -DPERL_IS_MINIPERL $(OBJOUT_FLAG)$@ $(PDBOUT) $(*F).c

# -DPERL_IMPLICIT_SYS needs C++ for perllib.c
# rules wrapped in .IFs break Win9X build (we end up with unbalanced []s unless
# unless the .IF is true), so instead we use a .ELSE with the default.
# This is the only file that depends on perlhost.h, vmem.h, and vdir.h

perllib$(o)	: perllib.c .\perlhost.h .\vdir.h .\vmem.h
ifeq ($(USE_IMP_SYS),define)
	$(CC) -c -I. $(CFLAGS_O) $(CXX_FLAG) $(OBJOUT_FLAG)$@ $(PDBOUT) perllib.c
else
	$(CC) -c -I. $(CFLAGS_O) $(OBJOUT_FLAG)$@ $(PDBOUT) perllib.c
endif

$(MINI_OBJ)	: $(MINIDIR)\.exists $(CORE_NOCFG_H)

$(WIN32_OBJ)	: $(CORE_H)
$(CORE_OBJ)	: $(CORE_H)
$(DLL_OBJ)	: $(CORE_H)
$(X2P_OBJ)	: $(CORE_H)

perldll.def : $(HAVEMINIPERL) $(CONFIGPM) ..\global.sym ..\pp.sym ..\makedef.pl
	$(MINIPERL) -w ..\makedef.pl PLATFORM=win32 $(OPTIMIZE) $(DEFINES) $(BUILDOPT) \
	    CCTYPE=$(CCTYPE) > perldll.def

$(PERLEXPLIB) : $(PERLIMPLIB)

$(PERLIMPLIB) : perldll.def
	$(IMPLIB) -k -d perldll.def -l $(PERLIMPLIB) -e $(PERLEXPLIB)

$(PERLDLL): perldll.def $(PERLEXPLIB) $(PERLDLL_OBJ)
	$(LINK32) -mdll -o $@ $(BLINK_FLAGS) \
	   $(PERLDLL_OBJ) $(LIBFILES) $(PERLEXPLIB)

$(MINIMOD) : $(HAVEMINIPERL) ..\minimod.pl
	cd .. && miniperl minimod.pl > lib\ExtUtils\Miniperl.pm && cd win32

..\x2p\a2p$(o) : ..\x2p\a2p.c
	$(CC) -I..\x2p $(CFLAGS) $(OBJOUT_FLAG)$@ -c ..\x2p\a2p.c

..\x2p\hash$(o) : ..\x2p\hash.c
	$(CC) -I..\x2p $(CFLAGS) $(OBJOUT_FLAG)$@ -c ..\x2p\hash.c

..\x2p\str$(o) : ..\x2p\str.c
	$(CC) -I..\x2p $(CFLAGS) $(OBJOUT_FLAG)$@ -c ..\x2p\str.c

..\x2p\util$(o) : ..\x2p\util.c
	$(CC) -I..\x2p $(CFLAGS) $(OBJOUT_FLAG)$@ -c ..\x2p\util.c

..\x2p\walk$(o) : ..\x2p\walk.c
	$(CC) -I..\x2p $(CFLAGS) $(OBJOUT_FLAG)$@ -c ..\x2p\walk.c

$(X2P) : $(HAVEMINIPERL) $(X2P_OBJ)
	$(MINIPERL) -I..\lib ..\x2p\find2perl.PL
	$(MINIPERL) -I..\lib ..\x2p\s2p.PL
	$(LINK32) -mconsole -o $@ $(BLINK_FLAGS) $(LIBFILES) $(X2P_OBJ)

perlmain.c : runperl.c
	copy runperl.c perlmain.c

perlmain$(o) : runperl.c $(CONFIGPM)
	$(CC) $(subst -DPERLDLL,-UPERLDLL,$(CFLAGS_O)) $(OBJOUT_FLAG)$@ $(PDBOUT) -c runperl.c

perlmainst$(o) : runperl.c $(CONFIGPM)
	$(CC) $(CFLAGS_O) $(OBJOUT_FLAG)$@ $(PDBOUT) -c runperl.c

$(PERLEXE): $(PERLDLL) $(CONFIGPM) $(PERLEXE_OBJ) $(PERLIMPLIB)
	$(LINK32) -mconsole -o $@ $(BLINK_FLAGS)  \
	    $(PERLEXE_OBJ) $(PERLIMPLIB) $(LIBFILES)
	copy $(PERLEXE) $(WPERLEXE)
	$(MINIPERL) -I..\lib bin\exetype.pl $(WPERLEXE) WINDOWS
	copy splittree.pl ..
	$(MINIPERL) -I..\lib ..\splittree.pl "../LIB" $(AUTODIR)

$(DYNALOADER).c: $(HAVEMINIPERL) $(EXTDIR)\DynaLoader\dl_win32.xs $(CONFIGPM)
	if not exist $(AUTODIR) mkdir $(AUTODIR)
	cd $(EXTDIR)\DynaLoader \
		&& ..\$(MINIPERL) -I..\..\lib DynaLoader_pm.PL \
		&& ..\$(MINIPERL) -I..\..\lib XSLoader_pm.PL
	$(XCOPY) $(EXTDIR)\DynaLoader\DynaLoader.pm $(LIBDIR)\$(NULL)
	$(XCOPY) $(EXTDIR)\DynaLoader\XSLoader.pm $(LIBDIR)\$(NULL)
	cd $(EXTDIR)\DynaLoader \
		&& $(XSUBPP) dl_win32.xs > ..\$(DYNALOADER).c

$(EXTDIR)\DynaLoader\dl_win32.xs: dl_win32.xs
	copy dl_win32.xs $(EXTDIR)\DynaLoader\dl_win32.xs

$(HAVEMINIPERL): $(MINI_OBJ)
	$(LINK32) -mconsole -o $(MINIPERL) $(BLINK_FLAGS) $(MINI_OBJ) $(LIBFILES)
	rem . > $@

$(DUMPER_DLL): $(HAVEMINIPERL) $(DUMPER).xs
	cd $(EXTDIR)\Data\Dumper && ..\..\..\miniperl -I..\..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(DPROF_DLL): $(HAVEMINIPERL) $(DPROF).xs
	cd $(EXTDIR)\Devel\DProf && ..\..\..\miniperl -I..\..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(GLOB_DLL): $(HAVEMINIPERL) $(GLOB).xs
	cd $(EXTDIR)\File\Glob && ..\..\..\miniperl -I..\..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(PEEK_DLL): $(HAVEMINIPERL) $(PEEK).xs
	cd $(EXTDIR)\Devel\Peek && ..\..\..\miniperl -I..\..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(RE_DLL): $(HAVEMINIPERL) $(RE).xs
	cd $(EXTDIR)\re && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(B_DLL): $(HAVEMINIPERL) $(B).xs
	cd $(EXTDIR)\B && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(THREAD_DLL): $(HAVEMINIPERL) $(THREAD).xs
	cd $(EXTDIR)\Thread && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(ATTRS_DLL): $(HAVEMINIPERL) $(ATTRS).xs
	cd $(EXTDIR)\attrs && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(POSIX_DLL): $(HAVEMINIPERL) $(POSIX).xs
	cd $(EXTDIR)\POSIX && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(IO_DLL): $(HAVEMINIPERL) $(IO).xs
	cd $(EXTDIR)\IO && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(SDBM_FILE_DLL) : $(HAVEMINIPERL) $(SDBM_FILE).xs
	cd $(EXTDIR)\SDBM_File && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(FCNTL_DLL): $(HAVEMINIPERL) $(FCNTL).xs
	cd $(EXTDIR)\Fcntl && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(OPCODE_DLL): $(HAVEMINIPERL) $(OPCODE).xs
	cd $(EXTDIR)\Opcode && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(SOCKET_DLL): $(HAVEMINIPERL) $(SOCKET).xs
	cd $(EXTDIR)\Socket && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(HOSTNAME_DLL): $(HAVEMINIPERL) $(HOSTNAME).xs
	cd $(EXTDIR)\Sys\Hostname && ..\..\..\miniperl -I..\..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(BYTELOADER_DLL): $(HAVEMINIPERL) $(BYTELOADER).xs
	cd $(EXTDIR)\ByteLoader && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(STORABLE_DLL): $(HAVEMINIPERL) $(STORABLE).xs
	cd $(EXTDIR)\Storable && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

$(ERRNO_PM): $(HAVEMINIPERL) $(ERRNO)_pm.PL
	cd $(EXTDIR)\Errno && ..\..\miniperl -I..\..\lib Makefile.PL INSTALLDIRS=perl && $(PLMAKE)

#-------------------------------------------------------------------------------

doc: $(PERLEXE)
	$(PERLEXE) -I..\lib ..\installhtml --podroot=.. --htmldir=$(HTMLDIR) \
	    --podpath=pod:lib:utils --htmlroot="file://$(subst :,|,$(INST_HTML))"\
	    --recurse

utils: $(PERLEXE) $(X2P)
	cd ..\utils && $(PLMAKE) PERL=$(MINIPERL)
	copy ..\README.amiga    ..\pod\perlamiga.pod
	copy ..\README.cygwin   ..\pod\perlcygwin.pod
	copy ..\README.dos      ..\pod\perldos.pod
	copy ..\README.hpux     ..\pod\perlhpux.pod
	copy ..\README.machten  ..\pod\perlmachten.pod
	copy ..\README.os2      ..\pod\perlos2.pod
	copy ..\vms\perlvms.pod ..\pod\perlvms.pod
	copy ..\README.win32    ..\pod\perlwin32.pod
	cd ..\pod && $(PLMAKE) -f ..\win32\pod.mak converters
# 	FIXME: it faisl with "gmake: *** [GNUmakefile:872: utils] Error -1073741515"
#	$(PERLEXE) -I..\lib $(PL2BAT) $(UTILS)

install : all installbare installhtml

installbare : utils
	$(PERLEXE) ..\installperl
	if exist $(WPERLEXE) $(XCOPY) $(WPERLEXE) $(INST_BIN)\$(NULL)
	$(XCOPY) $(GLOBEXE) $(INST_BIN)\$(NULL)
	$(XCOPY) "bin\*.bat" $(INST_SCRIPT)\$(NULL)

installhtml : doc
	$(RCOPY) $(HTMLDIR)\*.* $(INST_HTML)\$(NULL)
