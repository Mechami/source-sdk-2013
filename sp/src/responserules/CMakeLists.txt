cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(Response DESCRIPTION "Response Rules Runtime" LANGUAGES CXX)
include(source_lib_base)

add_library(responserules STATIC)
add_library(Lib::ResponseRules ALIAS responserules)
target_link_libraries(responserules PRIVATE Lib::Tier1)
target_compile_options(responserules PRIVATE ${OPT_EXCEPTIONS_ENABLE})
target_compile_definitions(responserules PRIVATE
	RR_RUNTIME
)
target_include_directories(responserules PUBLIC
	${SP_SOURCE_DIR}/public/responserules
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public/tier1
	${SP_SOURCE_DIR}/public
)
target_sources(responserules PRIVATE
	runtime/criteriaset.cpp
	runtime/response_system.cpp
	runtime/response_system.h
	runtime/response_types.cpp
	runtime/response_types_internal.cpp
	runtime/response_types_internal.h
	runtime/rr_convars.cpp
	runtime/rr_response.cpp
	runtime/rr_speechconcept.cpp
	runtime/rrrlib.cpp
)
target_sources(responserules PUBLIC FILE_SET public TYPE HEADERS BASE_DIRS ${SP_SOURCE_DIR} FILES
	${SP_SOURCE_DIR}/public/responserules/response_host_interface.h
	${SP_SOURCE_DIR}/public/responserules/response_types.h
	${SP_SOURCE_DIR}/public/responserules/rr_speechconcept.h
)
