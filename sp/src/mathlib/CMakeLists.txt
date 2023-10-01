cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(Mathlib DESCRIPTION "Math library" LANGUAGES CXX)
include(source_lib_base)

add_library(mathlib STATIC)
add_library(Lib::Mathlib ALIAS mathlib)
target_link_libraries(mathlib PUBLIC Lib::Tier0 Lib::Tier1)
target_compile_definitions(mathlib PRIVATE
	MATHLIB_LIB
)
target_include_directories(mathlib PUBLIC
	${SP_SOURCE_DIR}/public/mathlib
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public
)
target_sources(mathlib PRIVATE
	color_conversion.cpp
	halton.cpp
	lightdesc.cpp
	mathlib_base.cpp
	powsse.cpp
	sparse_convolution_noise.cpp
	sseconst.cpp
	$<$<OR:$<BOOL:${WIN32}>,$<BOOL:${UNIX}>>:sse.cpp>
	ssenoise.cpp
	$<$<OR:$<BOOL:${WIN32}>,$<BOOL:${LINUX}>>:3dnow.cpp>
	anorms.cpp
	bumpvects.cpp
	IceKey.cpp
	imagequant.cpp
	polyhedron.cpp
	quantize.cpp
	randsse.cpp
	spherical.cpp
	simdvectormatrix.cpp
	vector.cpp
	vmatrix.cpp
	almostequal.cpp
)
target_sources(mathlib PRIVATE FILE_SET private TYPE HEADERS FILES
	noisedata.h
	$<$<OR:$<BOOL:${WIN32}>,$<BOOL:${UNIX}>>:sse.h>
	$<$<OR:$<BOOL:${WIN32}>,$<BOOL:${LINUX}>>:3dnow.h>
)
target_sources(mathlib PUBLIC FILE_SET public TYPE HEADERS BASE_DIRS ${SP_SOURCE_DIR} FILES
	$<$<OR:$<BOOL:${WIN32}>,$<BOOL:${LINUX}>>:${SP_SOURCE_DIR}/public/mathlib/amd3dx.h>
	${SP_SOURCE_DIR}/public/mathlib/anorms.h
	${SP_SOURCE_DIR}/public/mathlib/bumpvects.h
	${SP_SOURCE_DIR}/public/mathlib/compressed_3d_unitvec.h
	${SP_SOURCE_DIR}/public/mathlib/compressed_light_cube.h
	${SP_SOURCE_DIR}/public/mathlib/compressed_vector.h
	${SP_SOURCE_DIR}/public/mathlib/halton.h
	${SP_SOURCE_DIR}/public/mathlib/IceKey.H
	${SP_SOURCE_DIR}/public/mathlib/lightdesc.h
	${SP_SOURCE_DIR}/public/mathlib/math_pfns.h
	${SP_SOURCE_DIR}/public/mathlib/mathlib.h
	${SP_SOURCE_DIR}/public/mathlib/noise.h
	${SP_SOURCE_DIR}/public/mathlib/polyhedron.h
	${SP_SOURCE_DIR}/public/mathlib/quantize.h
	${SP_SOURCE_DIR}/public/mathlib/simdvectormatrix.h
	${SP_SOURCE_DIR}/public/mathlib/spherical_geometry.h
	${SP_SOURCE_DIR}/public/mathlib/ssemath.h
	${SP_SOURCE_DIR}/public/mathlib/ssequaternion.h
	${SP_SOURCE_DIR}/public/mathlib/vector.h
	${SP_SOURCE_DIR}/public/mathlib/vector2d.h
	${SP_SOURCE_DIR}/public/mathlib/vector4d.h
	${SP_SOURCE_DIR}/public/mathlib/vmatrix.h
	${SP_SOURCE_DIR}/public/mathlib/vplane.h
)
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
	# This is necessary to support a reference to Pow_FixedPoint_Exponent_SIMD from Lib::Particles
	# That uses a mangled name from an older version of the ABI
	set_property(SOURCE powsse.cpp APPEND PROPERTY COMPILE_OPTIONS -fabi-compat-version=3)
endif()
