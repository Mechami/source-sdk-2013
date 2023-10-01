cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(Raytrace DESCRIPTION "Raytrace library" LANGUAGES CXX)
include(source_lib_base)

add_library(raytrace OBJECT)
add_library(Lib::Raytrace ALIAS raytrace)
target_link_libraries(raytrace PUBLIC Lib::Tier0 Lib::Tier1 Lib::Mathlib)
target_include_directories(raytrace PUBLIC
	${SP_SOURCE_DIR}/utils/common
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public/tier1
	${SP_SOURCE_DIR}/public
)
target_sources(raytrace PRIVATE
	raytrace.cpp
	trace2.cpp
	trace3.cpp
)
