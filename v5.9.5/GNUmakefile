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
USE_PERLIO	:= define
USE_LARGE_FILES	:= define
#USE_64_BIT_INT	:= define
#USE_LONG_DOUBLE :=define
#USE_NO_REGISTRY := define
CCTYPE		:= GCC
#CFG		:= Debug
#USE_PERLCRT	= define
#USE_SETARGV	:= define
CRYPT_SRC	= .\fcrypt.c
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
USE_PERLIO	?= undef
USE_LARGE_FILES	?= undef
USE_64_BIT_INT	?= undef
USE_LONG_DOUBLE	?= undef
USE_NO_REGISTRY	?= undef

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

ifeq ($(USE_MULTI),define)
ARCHNAME	= MSWin32-$(ARCHITECTURE)-multi
else
ifeq ($(USE_PERLIO),define)
ARCHNAME	= MSWin32-$(ARCHITECTURE)-perlio
else
ARCHNAME	= MSWin32-$(ARCHITECTURE)
endif
endif

ifeq ($(USE_PERLIO),define)
BUILDOPT	+= -DUSE_PERLIO
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
PERLEXESTATIC	= ..\perl-static.exe
STATICDIR	= .\static.tmp
GLOBEXE		= ..\perlglob.exe
CONFIGPM	= ..\lib\Config.pm
MINIMOD	= ..\lib\ExtUtils\Miniperl.pm
X2P		= ..\x2p\a2p.exe
GENUUDMAP	= ..\generate_uudmap.exe
PERLEXE_RES	= .\perlexe.res
PERLDLL_RES	=

# Unicode data files generated by mktables
FIRSTUNIFILE	= ..\lib\unicore\Canonical.pl
UNIDATAFILES	= ..\lib\unicore\Canonical.pl ..\lib\unicore\Exact.pl \
		   ..\lib\unicore\Properties ..\lib\unicore\Decomposition.pl \
		   ..\lib\unicore\CombiningClass.pl ..\lib\unicore\Name.pl \
		   ..\lib\unicore\PVA.pl

# Directories of Unicode data files generated by mktables
UNIDATADIR1	= ..\lib\unicore\To
UNIDATADIR2	= ..\lib\unicore\lib

PERLEXE_ICO	= .\perlexe.ico
PERLEXE_RES	= .\perlexe.res
PERLDLL_RES	=


PERLDEP = $(PERLIMPLIB)


PL2BAT		= bin\pl2bat.pl

UTILS		=			\
		..\utils\h2ph		\
		..\utils\splain		\
		..\utils\dprofpp	\
		..\utils\perlbug	\
		..\utils\pl2pm 		\
		..\utils\c2ph		\
		..\utils\pstruct	\
		..\utils\h2xs		\
		..\utils\perldoc	\
		..\utils\perlivp	\
		..\utils\libnetcfg	\
		..\utils\enc2xs		\
		..\utils\piconv		\
		..\utils\config_data	\
		..\utils\corelist	\
		..\utils\cpan		\
		..\utils\xsubpp		\
		..\utils\prove		\
		..\utils\ptar		\
		..\utils\ptardiff	\
		..\utils\cpanp-run-perl	\
		..\utils\cpanp		\
		..\utils\cpan2dist	\
		..\utils\shasum		\
		..\utils\instmodsh	\
		..\pod\checkpods	\
		..\pod\pod2html		\
		..\pod\pod2latex	\
		..\pod\pod2man		\
		..\pod\pod2text		\
		..\pod\pod2usage	\
		..\pod\podchecker	\
		..\pod\podselect	\
		..\x2p\find2perl	\
		..\x2p\psed		\
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
PERLSTATICLIB	= ..\libperl__PERL_MINOR_VERSION__s$(a)
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
		..\mro.c	\
		..\hv.c		\
		..\locale.c	\
		..\mathoms.c	\
		..\mg.c		\
		..\numeric.c	\
		..\op.c		\
		..\pad.c	\
		..\perl.c	\
		..\perlapi.c	\
		..\perly.c	\
		..\pp.c		\
		..\pp_ctl.c	\
		..\pp_hot.c	\
		..\pp_pack.c	\
		..\pp_sort.c	\
		..\pp_sys.c	\
		..\reentr.c	\
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
		.\win32thread.c	\
		.\win32io.c

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
		..\regcomp.h	\
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
		.\include\dirent.h	\
		.\include\netdb.h	\
		.\include\sys\socket.h	\
		.\win32.h

CORE_H		= $(CORE_NOCFG_H) .\config.h

UUDMAP_H       = ..\uudmap.h

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
GENUUDMAP_OBJ  = $(GENUUDMAP:.exe=$(o))
PERLDLL_OBJ	= $(CORE_OBJ)
PERLEXE_OBJ	= perlmain$(o)
PERLEXEST_OBJ	= perlmainst$(o)

PERLDLL_OBJ	+= $(WIN32_OBJ) $(DLL_OBJ)

ifneq ($(USE_SETARGV),)
SETARGV_OBJ	= setargv$(o)
endif

ifeq ($(ALL_STATIC),define)
STATIC_EXT	= * !Win32 !SDBM_File !Encode
else
#STATIC_EXT	= Cwd Compress/Raw/Zlib
STATIC_EXT	= Win32CORE
endif

DYNALOADER	= $(EXTDIR)\DynaLoader\DynaLoader

CFG_VARS	=					\
		"INST_TOP=$(INST_TOP)"			\
		"INST_VER=$(INST_VER)"			\
		"INST_ARCH=$(INST_ARCH)"		\
		"archname=$(ARCHNAME)"			\
		"cc=$(CC)"				\
		"ld=$(LINK32)"				\
		"ccflags=$(subst ",\",$(EXTRACFLAGS) $(OPTIMIZE) $(DEFINES) $(BUILDOPT))" \
		"usecplusplus=$(USE_CPLUSPLUS)"		\
		"cf_email=$(EMAIL)"			\
		"d_mymalloc=$(PERL_MALLOC)"		\
		"libs=$(LIBFILES)"			\
		"incpath=$(subst ",\",$(CCINCDIR))"			\
		"libperl=$(subst ",\",$(PERLIMPLIBBASE))"		\
		"libpth=$(subst ",\",$(CCLIBDIR);$(EXTRALIBDIRS))"	\
		"libc=$(LIBC)"				\
		"make=$(PLMAKE)"				\
		"_o=$(o)"				\
		"obj_ext=$(o)"				\
		"_a=$(a)"				\
		"lib_ext=$(a)"				\
		"static_ext=$(STATIC_EXT)"		\
		"usethreads=$(USE_ITHREADS)"		\
		"useithreads=$(USE_ITHREADS)"		\
		"usemultiplicity=$(USE_MULTI)"		\
		"useperlio=$(USE_PERLIO)"		\
		"use64bitint=$(USE_64_BIT_INT)"		\
		"uselongdouble=$(USE_LONG_DOUBLE)"	\
		"uselargefiles=$(USE_LARGE_FILES)"	\
		"usesitecustomize=$(USE_SITECUST)"	\
		"LINK_FLAGS=$(subst ",\",$(LINK_FLAGS))"\
		"optimize=$(subst ",\",$(OPTIMIZE))"	\
		"ARCHPREFIX=$(ARCHPREFIX)"		\
		"WIN64=$(WIN64)"

ICWD = -I..\cpan\Cwd -I..\cpan\Cwd\lib

#
# Top targets
#

.PHONY: all

all : .\config.h $(GLOBEXE) $(MINIMOD) $(CONFIGPM) $(PERLEXE) $(X2P) Extensions
	@echo Everything is up to date. '$(MAKE_BARE) test' to run test suite.

..\regcomp$(o) : ..\regnodes.h ..\regcharclass.h

..\regexec$(o) : ..\regnodes.h ..\regcharclass.h

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
	$(MINIPERL) -I..\lib buildext.pl --create-perllibst-h
	$(MINIPERL) -w ..\makedef.pl PLATFORM=win32 $(OPTIMIZE) $(DEFINES) $(BUILDOPT) \
	    CCTYPE=$(CCTYPE) > perldll.def

$(PERLEXPLIB) : $(PERLIMPLIB)

$(PERLIMPLIB) : perldll.def
	$(IMPLIB) -k -d perldll.def -l $(PERLIMPLIB) -e $(PERLEXPLIB)

$(PERLDLL): perldll.def $(PERLEXPLIB) $(PERLDLL_OBJ) Extensions_static
	$(LINK32) -mdll -o $@ $(BLINK_FLAGS) \
	   $(PERLDLL_OBJ) $(shell type Extensions_static) $(LIBFILES) $(PERLEXPLIB)

$(PERLSTATICLIB): $(PERLDLL_OBJ) Extensions_static
	$(LIB32) $(LIB_FLAGS) $@ $(PERLDLL_OBJ)
	if exist $(STATICDIR) rmdir /s /q $(STATICDIR)
	for %%i in ($(shell type Extensions_static)) do \
		@mkdir $(STATICDIR) && cd $(STATICDIR) && \
		$(ARCHPREFIX)ar x ..\%%i && \
		$(ARCHPREFIX)ar q ..\$@ *$(o) && \
		cd .. && rmdir /s /q $(STATICDIR)
	$(XCOPY) $(PERLSTATICLIB) $(COREDIR)

$(PERLEXE_ICO): $(HAVEMINIPERL) ..\uupacktool.pl $(PERLEXE_ICO).packd
	$(MINIPERL) -I..\lib ..\uupacktool.pl -u $(PERLEXE_ICO).packd $(PERLEXE_ICO)

$(PERLEXE_RES): perlexe.rc $(PERLEXE_ICO)

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

$(X2P) : $(HAVEMINIPERL) $(X2P_OBJ) Extensions
	$(MINIPERL) -I..\lib ..\x2p\find2perl.PL
	$(MINIPERL) -I..\lib ..\x2p\s2p.PL
	$(LINK32) -mconsole -o $@ $(BLINK_FLAGS) $(LIBFILES) $(X2P_OBJ)

$(MINIDIR)\globals$(o) : $(UUDMAP_H)

$(UUDMAP_H) : $(GENUUDMAP)
	$(GENUUDMAP) > $(UUDMAP_H)

$(GENUUDMAP) : $(GENUUDMAP_OBJ)
	$(LINK32) $(CFLAGS_O) -o $@ $(GENUUDMAP_OBJ) \
	$(BLINK_FLAGS) $(LIBFILES)

perlmain.c : runperl.c
	copy runperl.c perlmain.c

perlmain$(o) : runperl.c $(CONFIGPM)
	$(CC) $(subst -DPERLDLL,-UPERLDLL,$(CFLAGS_O)) $(OBJOUT_FLAG)$@ $(PDBOUT) -c runperl.c

perlmainst$(o) : runperl.c $(CONFIGPM)
	$(CC) $(CFLAGS_O) $(OBJOUT_FLAG)$@ $(PDBOUT) -c runperl.c

$(PERLEXE): $(PERLDLL) $(CONFIGPM) $(PERLEXE_OBJ) $(PERLEXE_RES) $(PERLIMPLIB)
	$(LINK32) -mconsole -o $@ $(BLINK_FLAGS)  \
	    $(PERLEXE_OBJ) $(PERLEXE_RES) $(PERLIMPLIB) $(LIBFILES)
	copy $(PERLEXE) $(WPERLEXE)
	$(MINIPERL) -I..\lib bin\exetype.pl $(WPERLEXE) WINDOWS
	copy splittree.pl ..
	$(MINIPERL) -I..\lib ..\splittree.pl "../LIB" $(AUTODIR)

$(PERLEXESTATIC): $(PERLSTATICLIB) $(CONFIGPM) $(PERLEXEST_OBJ) $(PERLEXE_RES)
	$(LINK32) -mconsole -o $@ $(BLINK_FLAGS) \
	    $(PERLEXEST_OBJ) $(PERLEXE_RES) $(PERLSTATICLIB) $(LIBFILES)

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


MakePPPort: $(HAVEMINIPERL) $(CONFIGPM)
	$(MINIPERL) -I..\lib ..\mkppport

$(HAVEMINIPERL): $(MINI_OBJ)
	$(LINK32) -mconsole -o $(MINIPERL) $(BLINK_FLAGS) $(MINI_OBJ) $(LIBFILES)
	rem . > $@

#most of deps of this target are in DYNALOADER and therefore omitted here
Extensions : buildext.pl $(HAVEMINIPERL) $(PERLDEP) $(CONFIGPM)
	$(XCOPY) ..\\*.h $(COREDIR)\\*.*
	$(MINIPERL) -I..\lib $(ICWD) buildext.pl "$(PLMAKE)" $(PERLDEP) $(EXTDIR) --dynamic
	-if exist ext $(MINIPERL) -I..\lib $(ICWD) buildext.pl "$(PLMAKE)" $(PERLDEP) ext --dynamic

Extensions_static : buildext.pl $(HAVEMINIPERL) $(CONFIGPM)
	$(XCOPY) ..\\*.h $(COREDIR)\\*.*
	$(MINIPERL) -I..\lib $(ICWD) buildext.pl "$(PLMAKE)" $(PERLDEP) $(EXTDIR) --static
	-if exist ext $(MINIPERL) -I..\lib $(ICWD) buildext.pl "$(PLMAKE)" $(PERLDEP) ext --static
	$(MINIPERL) -I..\lib buildext.pl --list-static-libs > Extensions_static

#-------------------------------------------------------------------------------

doc: $(PERLEXE)
	$(PERLEXE) -I..\lib ..\installhtml --podroot=.. --htmldir=$(HTMLDIR) \
	    --podpath=pod:lib:utils --htmlroot="file://$(subst :,|,$(INST_HTML))"\
	    --recurse

utils: $(PERLEXE) $(X2P)
	cd ..\utils && $(PLMAKE) PERL=$(MINIPERL)
	copy ..\README.aix      ..\pod\perlaix.pod
	copy ..\README.amiga    ..\pod\perlamiga.pod
	copy ..\README.apollo   ..\pod\perlapollo.pod
	copy ..\README.beos     ..\pod\perlbeos.pod
	copy ..\README.bs2000   ..\pod\perlbs2000.pod
	copy ..\README.ce       ..\pod\perlce.pod
	copy ..\README.cn       ..\pod\perlcn.pod
	copy ..\README.cygwin   ..\pod\perlcygwin.pod
	copy ..\README.dgux     ..\pod\perldgux.pod
	copy ..\README.dos      ..\pod\perldos.pod
	copy ..\README.epoc     ..\pod\perlepoc.pod
	copy ..\README.freebsd  ..\pod\perlfreebsd.pod
	copy ..\README.hpux     ..\pod\perlhpux.pod
	copy ..\README.hurd     ..\pod\perlhurd.pod
	copy ..\README.irix     ..\pod\perlirix.pod
	copy ..\README.jp       ..\pod\perljp.pod
	copy ..\README.ko       ..\pod\perlko.pod
	copy ..\README.machten  ..\pod\perlmachten.pod
	copy ..\README.macos    ..\pod\perlmacos.pod
	copy ..\README.macosx   ..\pod\perlmacosx.pod
	copy ..\README.mint     ..\pod\perlmint.pod
	copy ..\README.mpeix    ..\pod\perlmpeix.pod
	copy ..\README.netware  ..\pod\perlnetware.pod
	copy ..\README.os2      ..\pod\perlos2.pod
	copy ..\README.os390    ..\pod\perlos390.pod
	copy ..\README.os400    ..\pod\perlos400.pod
	copy ..\README.plan9    ..\pod\perlplan9.pod
	copy ..\README.qnx      ..\pod\perlqnx.pod
	copy ..\README.solaris  ..\pod\perlsolaris.pod
	copy ..\README.tru64    ..\pod\perltru64.pod
	copy ..\README.tw       ..\pod\perltw.pod
	copy ..\README.uts      ..\pod\perluts.pod
	copy ..\README.vmesa    ..\pod\perlvmesa.pod
	copy ..\README.vms      ..\pod\perlvms.pod
	copy ..\README.vos      ..\pod\perlvos.pod
	copy ..\README.win32    ..\pod\perlwin32.pod
	copy ..\pod\perl__PERL_VERSION__delta.pod ..\pod\perldelta.pod
	cd ..\lib && $(PERLEXE) -Dtls lib_pm.PL
	cd ..\pod && $(PLMAKE) -f ..\win32\pod.mak converters
	$(PERLEXE) -I..\lib $(PL2BAT) $(UTILS)

install : all installbare installhtml

installbare : utils
	$(PERLEXE) ..\installperl
	if exist $(WPERLEXE) $(XCOPY) $(WPERLEXE) $(INST_BIN)\$(NULL)
	if exist $(PERLEXESTATIC) $(XCOPY) $(PERLEXESTATIC) $(INST_BIN)\$(NULL)
	$(XCOPY) $(GLOBEXE) $(INST_BIN)\$(NULL)
	if exist ..\perl*.pdb $(XCOPY) ..\perl*.pdb $(INST_BIN)\$(NULL)
	if exist ..\x2p\a2p.pdb $(XCOPY) ..\x2p\a2p.pdb $(INST_BIN)\$(NULL)
	$(XCOPY) "bin\*.bat" $(INST_SCRIPT)\$(NULL)

installhtml : doc
	$(RCOPY) $(HTMLDIR)\*.* $(INST_HTML)\$(NULL)
