include_guard()
include(CheckCXXCompilerFlag)
include(CheckLinkerFlag)

set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN true)
set(CMAKE_CXX_FLAGS_DEBUG "")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "")
set(CMAKE_CXX_FLAGS_RELEASE "")
set(CMAKE_CXX_FLAGS_MINSIZEREL "")
set(LIBCOMMON "${SP_SOURCE_DIR}/lib/common${PLATSUBDIR}")
set(LIBPUBLIC "${SP_SOURCE_DIR}/lib/public${PLATSUBDIR}")

if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
	set(OPT_EXCEPTIONS_ENABLE -fexceptions)
	set(OPT_EXCEPTIONS_DISABLE -fno-exceptions)
endif()

check_cxx_compiler_flag(-Oz OPT_SIZE_AGGRESSIVE)
check_cxx_compiler_flag(-mdaz-ftz OPT_DAZ_FTZ)
add_compile_options(-m32 $<IF:$<BOOL:${OPT_SAVE_TEMPORARIES}>,-save-temps,-pipe> # -save-temps is incompatible with pipes and ccache
	"$<$<CONFIG:debug>:-gdwarf-5;-g3;-Og>"
	"$<$<CONFIG:relwithdebinfo>:-gdwarf;-g;-O3>"
	"$<$<CONFIG:release>:-g0;-O3>"
	"$<$<CONFIG:minsizerel>:-g0;$<IF:$<BOOL:${OPT_SIZE_AGGRESSIVE}>,-Oz,-Os>>"

#	$<$<BOOL:${OPT_SUPPRESS_WARNINGS}>:-w>
	"$<$<BOOL:${OPT_STRICT_COMPILER}>:-Wall;-Wextra;-Werror;-Wfatal-errors;-Wpedantic;-pedantic-errors;-fno-permissive>"
##	-Wno-unused-parameter
##	-Wno-unused-function
##	-Wno-unknown-pragmas
#	-Wno-odr
##	-Wno-ignored-qualifiers
##	-Wconversion
##	-Warith-conversion
	-Wno-narrowing

	# Valve flags
	-Wno-write-strings -Wno-multichar
	-Wno-unknown-pragmas -Wno-unused-parameter -Wno-unused-value
	-Wno-missing-field-initializers -Wno-sign-compare -Wno-reorder
	-Wno-invalid-offsetof -Wno-float-equal -Werror=return-type
	-fdiagnostics-show-option -Wformat -Wformat-security

	-march=nocona
	-mtune=generic

	# Valve flags + extra
	-mfpmath=sse -msse -msse2 -mrecip=none $<$<BOOL:${OPT_DAZ_FTZ}>:-mdaz-ftz>
	-frounding-math	-fsignaling-nans -mieee-fp
)

if (CMAKE_INTERPROCEDURAL_OPTIMIZATION AND OPT_ENABLE_IPA_PTA)
	check_cxx_compiler_flag(-fipa-pta OPT_IPA_PTA)
	add_compile_options(
		$<$<CONFIG:release,minsizerel>:$<$<BOOL:${OPT_IPA_PTA}>:-fipa-pta>>
	)
endif()

add_compile_definitions(
	"$<$<CONFIG:debug,relwithdebinfo>:DEBUG;_DEBUG>"
	"$<$<CONFIG:release,minsizerel>:NDEBUG;_NDEBUG>"
	"$<$<BOOL:${LINUX}>:LINUX;_LINUX>"
	$<$<CXX_COMPILER_ID:GNU,Clang>:GNUC=__GNUC__>
	$<$<BOOL:${DEDICATED}>:DEDICATED>
	_DLL_EXT=${CMAKE_SHARED_LIBRARY_SUFFIX}
	POSIX
	_POSIX
	VPROF_LEVEL=1
	NO_HOOK_MALLOC
	NO_MALLOC_OVERRIDE
	_GLIBCXX_USE_CXX11_ABI=0
)

check_linker_flag(CXX "-fuse-ld=gold" LD_GOLD_SUPPORT)
add_link_options(-m32 $<$<BOOL:${LD_GOLD_SUPPORT}>:-fuse-ld=gold> -static-libgcc
#	$<$<BOOL:${CMAKE_INTERPROCEDURAL_OPTIMIZATION}>:-fuse-linker-plugin>
	$<$<CONFIG:debug,relwithdebinfo>:LINKER:-O0>
	"$<$<CONFIG:release,minsizerel>:LINKER:-O3;LINKER:--strip-all>"
	$<$<BOOL:${OPT_STRICT_COMPILER}>:LINKER:--detect-odr-violations>
	LINKER:--version-script=${SP_SOURCE_DIR}/devtools/version_script.linux.txt
	LINKER:--as-needed
	LINKER:--build-id
	LINKER:--discard-all
	LINKER:--gc-sections
	LINKER:--relax
	LINKER:--rosegment
	LINKER:-Bsymbolic
	LINKER:-Bsymbolic-functions
	LINKER:-z,combreloc # Default with gold
	LINKER:-z,relro # Default with gold
	LINKER:-z,now
#	LINKER:-z,report-relative-reloc
#	LINKER:-z,separate-code
	LINKER:-z,loadfltr
	LINKER:-z,origin
#	LINKER:-z,textoff # Eliminates PIC/Non-PIC linker warnings for static libs we can't rebuild (Default with gold)
	LINKER:--fatal-warnings
#	LINKER:--error-limit=1
	LINKER:--no-undefined
	LINKER:--icf=safe
	LINKER:--icf-iterations=49
#	LINKER:--threads
#	LINKER:-Map=

	LINKER:--wrap=fopen LINKER:--wrap=freopen LINKER:--wrap=open    LINKER:--wrap=creat    LINKER:--wrap=access  LINKER:--wrap=__xstat
	LINKER:--wrap=stat  LINKER:--wrap=lstat   LINKER:--wrap=fopen64 LINKER:--wrap=open64   LINKER:--wrap=opendir LINKER:--wrap=__lxstat
	LINKER:--wrap=chmod LINKER:--wrap=chown   LINKER:--wrap=lchown  LINKER:--wrap=symlink  LINKER:--wrap=link    LINKER:--wrap=__lxstat64
	LINKER:--wrap=mknod LINKER:--wrap=utimes  LINKER:--wrap=unlink  LINKER:--wrap=rename   LINKER:--wrap=utime   LINKER:--wrap=__xstat64
	LINKER:--wrap=mount LINKER:--wrap=mkfifo  LINKER:--wrap=mkdir   LINKER:--wrap=rmdir    LINKER:--wrap=scandir LINKER:--wrap=realpath
)

link_directories(BEFORE
	${LIBCOMMON}
	${LIBPUBLIC}
)

find_library(DL dl)
if (DL)
	add_library(Lib::DL STATIC IMPORTED)
	set_target_properties(Lib::DL PROPERTIES IMPORTED_LOCATION ${DL})
	link_libraries(Lib::DL)
endif()
find_library(PThreads pthread)
if (PThreads)
	add_library(Lib::PThreads STATIC IMPORTED)
	set_target_properties(Lib::PThreads PROPERTIES IMPORTED_LOCATION ${PThreads})
	link_libraries(Lib::PThreads)
endif()

set_target_properties(Lib::DMXLoader PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/dmxloader.a)
set_target_properties(Lib::Particles PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/particles.a)
set_target_properties(Lib::Tier0 PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/libtier0.so IMPORTED_NO_SONAME TRUE)
set_target_properties(Lib::Tier2 PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/tier2.a)
set_target_properties(Lib::Tier3 PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/tier3.a)
set_target_properties(Lib::SteamAPI PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/libsteam_api.so IMPORTED_SONAME libsteam_api.so)
set_target_properties(Lib::VStdLib PROPERTIES IMPORTED_LOCATION ${LIBPUBLIC}/libvstdlib.so IMPORTED_NO_SONAME TRUE)
