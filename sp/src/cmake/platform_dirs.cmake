include_guard()

set(PLATSUBDIR
	$<$<BOOL:${WIN32}>:/.>
	$<$<BOOL:${LINUX}>:/linux32>
)

if (WIN32)
	set(PLATSUBDIR /.)
elseif (LINUX)
	set(PLATSUBDIR /linux32)
endif()
