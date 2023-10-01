cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(VScript DESCRIPTION "Valve Script Library" LANGUAGES CXX)
include(source_lib_base)

block()
	set(DISABLE_DYNAMIC OFF) # Bug in sq/CMakeLists.txt prevents us from turning this on
	set(CMAKE_POLICY_DEFAULT_CMP0069 NEW) # Required for interprocedural optimization
	set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE) # Disable deprecation warnings for compatibility with old versions of CMake
	add_subdirectory(${PROJECT_SOURCE_DIR}/squirrel ${SP_BINARY_DIR}/vscript/squirrel)

	# Remove the stabs format flag since it conflicts with the dwarf format specified in source_posix_base.cmake
	# Also remove -fno-rtti since it causes an undefined link error with the dedicated server base
	if (UNIX AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
		get_directory_property(CFLAGS DIRECTORY "${PROJECT_SOURCE_DIR}/squirrel" COMPILE_OPTIONS)
		string(REPLACE "-gstabs;" "" CFLAGS "${CFLAGS}")
		string(REPLACE "-fno-rtti;" "" CFLAGS "${CFLAGS}")
		set_target_properties(sq sqstdlib squirrel PROPERTIES COMPILE_OPTIONS "${CFLAGS}")
		set_target_properties(sq_static sqstdlib_static squirrel_static PROPERTIES COMPILE_OPTIONS "${CFLAGS}")
	endif()

	# Exclude all Squirrel projects by default
	# Libs will get pulled in by projects that need them
	set_property(DIRECTORY ${PROJECT_SOURCE_DIR}/squirrel PROPERTY EXCLUDE_FROM_ALL TRUE)
endblock()

add_library(vscript STATIC)
add_library(Lib::VScript ALIAS vscript)
target_link_libraries(vscript PRIVATE Lib::Mathlib squirrel::squirrel_static squirrel::sqstdlib_static)
target_compile_definitions(vscript PRIVATE
	$<$<BOOL:${MAPBASE_VSCRIPT}>:MAPBASE_VSCRIPT>
)
target_include_directories(vscript PUBLIC
	squirrel/include
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public/tier1
	${SP_SOURCE_DIR}/public
)
target_sources(vscript PRIVATE
	vscript.cpp
	vscript_squirrel.cpp
	vscript_squirrel.nut
	vscript_bindings_base.cpp
	vscript_bindings_math.cpp
)
target_sources(vscript PRIVATE FILE_SET private TYPE HEADERS FILES
	vscript_bindings_base.h
	vscript_bindings_math.h
)
target_sources(vscript PUBLIC FILE_SET public TYPE HEADERS BASE_DIRS ${SP_SOURCE_DIR} FILES
	
)
