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
	-fno-plt

##	-fabi-version=17
#	-fcf-protection=none
#	-fno-stack-protector
#	-fno-stack-clash-protection
	-fno-semantic-interposition
##	-malign-data=cacheline
)
