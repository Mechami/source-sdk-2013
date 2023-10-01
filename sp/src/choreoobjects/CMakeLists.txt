cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(Choreoobjects DESCRIPTION "Choreography library" LANGUAGES CXX)
include(source_lib_base)

option(OPT_CHOREOOBJECTS_LZMA_FOR_SCENEIMAGE "[Broken] Enable LZMA compression support for Choreoobject scene files" OFF)

# Note:
# Choreoobjects has references to some old Quake code in utils/scriplib.h|cpp
add_library(choreoobjects STATIC)
add_library(Lib::Choreoobjects ALIAS choreoobjects)
target_link_libraries(choreoobjects PUBLIC Lib::Tier1 Lib::Tier2)
target_compile_definitions(choreoobjects PRIVATE
	$<$<BOOL:${OPT_CHOREOOBJECTS_LZMA_FOR_SCENEIMAGE}>:USE_LZMA>
)
target_include_directories(choreoobjects PRIVATE
	${SP_SOURCE_DIR}/utils/common
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public/tier1
	${SP_SOURCE_DIR}/public
	${SP_SOURCE_DIR}/common
)
target_sources(choreoobjects PRIVATE
	${SP_SOURCE_DIR}/game/shared/choreoactor.cpp
	${SP_SOURCE_DIR}/game/shared/choreochannel.cpp
	${SP_SOURCE_DIR}/game/shared/choreoevent.cpp
	${SP_SOURCE_DIR}/game/shared/choreoscene.cpp
	${SP_SOURCE_DIR}/game/shared/sceneimage.cpp
)
target_sources(choreoobjects PRIVATE FILE_SET private TYPE HEADERS BASE_DIRS ${SP_SOURCE_DIR}/game/shared FILES
	${SP_SOURCE_DIR}/game/shared/choreoactor.h
	${SP_SOURCE_DIR}/game/shared/choreochannel.h
	${SP_SOURCE_DIR}/game/shared/choreoevent.h
	${SP_SOURCE_DIR}/game/shared/choreoscene.h
	${SP_SOURCE_DIR}/game/shared/sceneimage.h
)
target_sources(choreoobjects PUBLIC FILE_SET public TYPE HEADERS BASE_DIRS ${SP_SOURCE_DIR}/game/shared FILES
	${SP_SOURCE_DIR}/game/shared/ichoreoeventcallback.h
)
