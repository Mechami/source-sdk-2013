cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(SP VERSION 7.1 DESCRIPTION "Mapbase (Singleplayer branch)" HOMEPAGE_URL "https://moddb.com/mods/mapbase" LANGUAGES CXX)
include(${SP_SOURCE_DIR}/cmake/config.cmake)

#add_subdirectory(${SP_SOURCE_DIR}/game/client ${SP_BINARY_DIR}/game/client)
add_subdirectory(${SP_SOURCE_DIR}/game/server ${SP_BINARY_DIR}/game/server)
add_subdirectory(${SP_SOURCE_DIR}/mathlib ${SP_BINARY_DIR}/mathlib)
add_subdirectory(${SP_SOURCE_DIR}/tier1 ${SP_BINARY_DIR}/tier1)
add_subdirectory(${SP_SOURCE_DIR}/raytrace ${SP_BINARY_DIR}/raytrace)
add_subdirectory(${SP_SOURCE_DIR}/responserules ${SP_BINARY_DIR}/responserules)
add_subdirectory(${SP_SOURCE_DIR}/vscript ${SP_BINARY_DIR}/vscript)
add_subdirectory(${SP_SOURCE_DIR}/choreoobjects ${SP_BINARY_DIR}/choreoobjects)
#add_subdirectory(${SP_SOURCE_DIR}/utils/common ${SP_BINARY_DIR}/utils/common)

add_custom_target(games)
add_dependencies(games
	server
#	client
	mathlib
	raytrace
	tier1
#	vgui_controls
	vscript
)
add_custom_target(everything)
add_dependencies(everything
	server
#	client
#	captioncompiler
#	fgdlib
#	shaders
#	glview
#	height2normal
	mathlib
#	motionmapper
#	phonemeextractor
#	qc_eyes
	raytrace
#	serverplugin_empty
#	tgadiff
	tier1
#	vbsp
#	vgui_controls
#	vrad_dll
#	vrad_launcher
	vscript
#	vtfdiff
#	vvis_dll
#	vvis_launcher
	choreoobjects
	responserules
)
add_custom_target(utils)
#add_dependencies(utils
#	captioncompiler
#	glview
#	height2normal
#	motionmapper
#	phonemeextractor
#	qc_eyes
#	tgadiff
#	vbsp
#	vrad_dll
#	vrad_launcher
#	vtfdiff
#	vvis_dll
#	vvis_launcher
#)
add_custom_target(libs)
add_dependencies(libs
#	fgdlib
	mathlib
	raytrace
	tier1
	vscript
	choreoobjects
	responserules
)

# TODO:
# Change games to potentially be implemented as a feature property on library targets or custom configuration type
# Alternatively make dll code an object library and make hl2/episodic code targets reference that instead
# Refactor cmake build files to be more intuitive than VPC scripts
# Implement source_video_base.cmake and remove OPTIONAL flags from include directives
# Modify code (including mathlib) to be C++14/17/20/23 conformant
# Look into making build more deterministic for use with ccache
# Compare preprocessed source files for non-deterministic changes
# Fix mathlib to use internal copy of vec3_origin
# Move episodic, hl2 and mapbase libs to their own *.cmake
# Modify vscript to pull in mapbase
# Add client dll script
# Add tools and utils
# Potentially add support for unit tests of headers
# Change OPT_ENABLE_IPA_PTA to check for CMAKE_INTERPROCEDURAL_OPTIMIZATION first
# Move compiler-specific flags into gcc.cmake and msvc.cmake, respectively
# Consider creating mandoc page for build system options
project(Mapbase)
