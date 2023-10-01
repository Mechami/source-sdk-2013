include_guard()

if (NOT DEDICATED AND NOT WIN32)
	set(GL TRUE)
endif()

if (GL AND NOT DEDICATED)
	set(SDL TRUE)
endif()

if (WIN32)
	add_compile_definitions(
		$<IF:$<BOOL:${QUICKTIME_WIN32}>,QUICKTIME_VIDEO,BINK_VIDEO>
		AVI_VIDEO
		WMV_VIDEO
	)
elseif (LINUX)
	add_compile_definitions(
		BINK_VIDEO
	)
endif()

add_compile_definitions(
	"$<$<BOOL:${GL}>:GL_GLEXT_PROTOTYPES;DX_TO_GL_ABSTRACTION>"
	$<$<BOOL:${SDL}>:USE_SDL>
)

if (SDL OR DEDICATED)
	include_directories(
		${SP_SOURCE_DIR}/thirdparty/SDL2
	)
endif()
