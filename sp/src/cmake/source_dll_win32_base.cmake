include_guard()
include(CheckCXXCompilerFlag)

set(LIBCOMMON "${SP_SOURCE_DIR}/lib/common${PLATSUBDIR}")
set(LIBPUBLIC "${SP_SOURCE_DIR}/lib/public${PLATSUBDIR}")

add_compile_definitions(
	COMPILER_MSVC32
	COMPILER_MSVC
	_DLL_EXT=${CMAKE_SHARED_LIBRARY_SUFFIX}
)

check_cxx_compiler_flag(/arch:SSE2 OPT_SSE2)
add_compile_options(
	$<IF:$<BOOL:${OPT_SSE2}>,/arch:SSE2,/arch:SSE>
)
