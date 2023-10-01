cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(Common DESCRIPTION "Common utilities" LANGUAGES C CXX)
include(source_lib_base)

add_library(common STATIC)
add_library(Lib::Common ALIAS common)
#target_link_libraries(common PUBLIC Lib::Tier0 Lib::Tier1 Lib::Mathlib)
#target_compile_options(common PRIVATE -Wall -Wextra -Wpedantic)
target_include_directories(common PUBLIC
#	${SP_SOURCE_DIR}/utils/common
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public/tier1
	${SP_SOURCE_DIR}/public
)
target_sources(common PRIVATE
	$<$<BOOL:${WIN32}>:consolewnd.cpp>
	$<$<BOOL:${WIN32}>:MySqlDatabase.cpp>
	$<$<BOOL:${WIN32}>:mstristrip.cpp>
	$<$<BOOL:${WIN32}>:utilmatlib.cpp>
	bsplib.cpp
	cmdlib.cpp
	filesystem_tools.cpp
	map_shared.cpp
	mpi_stats.cpp
	pacifier.cpp
	physdll.cpp
	polylib.cpp
	scratchpad_helpers.cpp
	scriplib.cpp
	threads.cpp
	tools_minidump.cpp
	vmpi_tools_shared.cpp
)
target_sources(common PUBLIC FILE_SET public TYPE HEADERS FILES
	$<$<BOOL:${WIN32}>:consolewnd.h>
	$<$<BOOL:${WIN32}>:MySqlDatabase.h>
	$<$<BOOL:${WIN32}>:mstristrip.h>
	$<$<BOOL:${WIN32}>:utilmatlib.h>
	bsplib.h
	cmdlib.h
	filesystem_tools.h
	ISQLDBReplyTarget.h
	map_shared.h
	movie.h
	mpi_stats.h
	pacifier.h
	physdll.h
	polylib.h
	qfiles.h
	scratchpad_helpers.h
	scriplib.h
	threads.h
	tools_minidump.h
	vmpi_tools_shared.h
	wadlib.h
)
