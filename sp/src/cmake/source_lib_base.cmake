include_guard()
include(platform_dirs)
include(source_base)
include(lib_macros)

add_compile_definitions(
	$<$<NOT:$<BOOL:${PUBLISH}>>:DEV_BUILD>
	$<$<AND:$<BOOL:${PROFILE}>,$<NOT:$<BOOL:${RETAIL}>>>:_PROFILE>
	$<$<AND:$<BOOL:${RETAIL}>,$<BOOL:${RETAILASSERTS}>>:RETAIL_ASSERTS>
	FRAME_POINTER_OMISSION_DISABLED # This is now always true.
)

add_imported_libraries()

if (UNIX)
	include(source_lib_posix_base)
elseif (WIN32)
	include(source_lib_win32_base)
endif()

link_imported_libraries()

include(source_video_base)
