include_guard()
include(source_posix_base)

function(target_base_sources target)
	target_sources("${target}" PRIVATE
		${SP_SOURCE_DIR}/public/tier0/memoverride.cpp
		${SP_SOURCE_DIR}/devtools/gcc9+support.cpp
	)
endfunction()

add_compile_options(
	-fno-omit-frame-pointer -mno-omit-leaf-frame-pointer
)
