cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(Tier1 DESCRIPTION "Valve CUtl Standard Template Library" LANGUAGES CXX)
include(source_lib_base)

add_library(tier1 STATIC)
add_library(Lib::Tier1 ALIAS tier1)
target_link_libraries(tier1 PUBLIC Lib::VStdLib Lib::Tier0)
target_compile_options(tier1 PRIVATE ${OPT_EXCEPTIONS_ENABLE})
target_compile_definitions(tier1 PRIVATE
	TIER1_STATIC_LIB
)
target_include_directories(tier1 PUBLIC
	${SP_SOURCE_DIR}/public/tier0
	${SP_SOURCE_DIR}/public/tier1
	${SP_SOURCE_DIR}/public
)
target_sources(tier1 PRIVATE
	bitbuf.cpp
	newbitbuf.cpp
	byteswap.cpp
	characterset.cpp
	checksum_crc.cpp
	checksum_md5.cpp
	checksum_sha1.cpp
	commandbuffer.cpp
	convar.cpp
	datamanager.cpp
	diff.cpp
	generichash.cpp
	ilocalize.cpp
	interface.cpp
	interval.cpp
	KeyValues.cpp
	kvpacker.cpp
	lzmaDecoder.cpp
	$<$<NOT:$<BOOL:${SOURCESDK}>>:processor_detect.cpp>
	mempool.cpp
	memstack.cpp
	NetAdr.cpp
	splitstring.cpp
	$<$<BOOL:${WIN32}>:processor_detect.cpp>
	$<$<BOOL:${UNIX}>:processor_detect_linux.cpp>
	$<$<BOOL:${LINUX}>:qsort_s.cpp>
	rangecheckedvar.cpp
	reliabletimer.cpp
	stringpool.cpp
	strtools.cpp
	tier1.cpp
	tokenreader.cpp
	sparsematrix.cpp
	uniqueid.cpp
	utlbuffer.cpp
	utlbufferutil.cpp
	utlstring.cpp
	utlsymbol.cpp
#	$<$<BOOL:${LINUX}>:pathmatch.cpp>
	snappy.cpp
	snappy-sinksource.cpp
	snappy-stubs-internal.cpp
	$<$<BOOL:${MAPBASE}>:mapbase_con_groups.cpp>
	$<$<BOOL:${MAPBASE}>:mapbase_matchers_base.cpp>
)
target_sources(tier1 PRIVATE FILE_SET private TYPE HEADERS FILES
	snappy-stubs-internal.h
	snappy-internal.h
)
target_sources(tier1 PUBLIC FILE_SET public TYPE HEADERS BASE_DIRS ${SP_SOURCE_DIR} FILES
	${SP_SOURCE_DIR}/public/tier1/bitbuf.h
	${SP_SOURCE_DIR}/public/tier1/byteswap.h
	${SP_SOURCE_DIR}/public/tier1/callqueue.h
	${SP_SOURCE_DIR}/public/tier1/characterset.h
	${SP_SOURCE_DIR}/public/tier1/checksum_crc.h
	${SP_SOURCE_DIR}/public/tier1/checksum_md5.h
	${SP_SOURCE_DIR}/public/tier1/checksum_sha1.h
	${SP_SOURCE_DIR}/public/tier1/CommandBuffer.h
	${SP_SOURCE_DIR}/public/tier1/convar.h
	${SP_SOURCE_DIR}/public/tier1/datamanager.h
	${SP_SOURCE_DIR}/public/datamap.h
	${SP_SOURCE_DIR}/public/tier1/delegates.h
	${SP_SOURCE_DIR}/public/tier1/diff.h
	${SP_SOURCE_DIR}/public/tier1/fmtstr.h
	${SP_SOURCE_DIR}/public/tier1/functors.h
	${SP_SOURCE_DIR}/public/tier1/generichash.h
	${SP_SOURCE_DIR}/public/tier1/iconvar.h
	${SP_SOURCE_DIR}/public/tier1/ilocalize.h
	${SP_SOURCE_DIR}/public/tier1/interface.h
	${SP_SOURCE_DIR}/public/tier1/KeyValues.h
	${SP_SOURCE_DIR}/public/tier1/kvpacker.h
	${SP_SOURCE_DIR}/public/tier1/lzmaDecoder.h
	${SP_SOURCE_DIR}/public/tier1/lzss.h
	${SP_SOURCE_DIR}/public/tier1/mempool.h
	${SP_SOURCE_DIR}/public/tier1/memstack.h
	${SP_SOURCE_DIR}/public/tier1/netadr.h
	${SP_SOURCE_DIR}/public/tier1/processor_detect.h
	${SP_SOURCE_DIR}/public/tier1/rangecheckedvar.h
	${SP_SOURCE_DIR}/public/tier1/refcount.h
	${SP_SOURCE_DIR}/public/tier1/smartptr.h
	${SP_SOURCE_DIR}/public/tier1/snappy.h
	${SP_SOURCE_DIR}/public/tier1/snappy-sinksource.h
	${SP_SOURCE_DIR}/public/tier1/stringpool.h
	${SP_SOURCE_DIR}/public/tier1/strtools.h
	${SP_SOURCE_DIR}/public/tier1/tier1.h
	${SP_SOURCE_DIR}/public/tier1/tokenreader.h
	$<$<BOOL:${WIN32}>:${SP_SOURCE_DIR}/public/tier1/uniqueid.h>
	${SP_SOURCE_DIR}/public/tier1/utlbidirectionalset.h
	${SP_SOURCE_DIR}/public/tier1/utlblockmemory.h
	${SP_SOURCE_DIR}/public/tier1/utlbuffer.h
	${SP_SOURCE_DIR}/public/tier1/utlbufferutil.h
	${SP_SOURCE_DIR}/public/tier1/utlcommon.h
	${SP_SOURCE_DIR}/public/tier1/utldict.h
	${SP_SOURCE_DIR}/public/tier1/utlenvelope.h
	${SP_SOURCE_DIR}/public/tier1/utlfixedmemory.h
	${SP_SOURCE_DIR}/public/tier1/utlhandletable.h
	${SP_SOURCE_DIR}/public/tier1/utlhash.h
	${SP_SOURCE_DIR}/public/tier1/utlhashtable.h
	${SP_SOURCE_DIR}/public/tier1/utllinkedlist.h
	${SP_SOURCE_DIR}/public/tier1/utlmap.h
	${SP_SOURCE_DIR}/public/tier1/utlmemory.h
	${SP_SOURCE_DIR}/public/tier1/utlmultilist.h
	${SP_SOURCE_DIR}/public/tier1/utlpriorityqueue.h
	${SP_SOURCE_DIR}/public/tier1/utlqueue.h
	${SP_SOURCE_DIR}/public/tier1/utlrbtree.h
	${SP_SOURCE_DIR}/public/tier1/UtlSortVector.h
	${SP_SOURCE_DIR}/public/tier1/utlstack.h
	${SP_SOURCE_DIR}/public/tier1/utlstring.h
	${SP_SOURCE_DIR}/public/tier1/UtlStringMap.h
	${SP_SOURCE_DIR}/public/tier1/utlsymbol.h
	${SP_SOURCE_DIR}/public/tier1/utlsymbollarge.h
	${SP_SOURCE_DIR}/public/tier1/utlvector.h
	$<$<BOOL:${MAPBASE}>:${SP_SOURCE_DIR}/public/tier1/mapbase_con_groups.h>
	$<$<BOOL:${MAPBASE}>:${SP_SOURCE_DIR}/public/tier1/mapbase_matchers_base.h>
	$<$<BOOL:${WINDOWS}>:${SP_SOURCE_DIR}/common/xbox/xboxstubs.h>
)

if (WIN32)
	add_library(External::Rpcrt4 STATIC IMPORTED)
	find_library(RPCRT4 Rpcrt4.lib REGISTRY_VIEW 32 REQUIRED)
	set_target_properties(External::Rpcrt4 PROPERTIES IMPORTED_LOCATION ${RPCRT4})
	target_link_libraries(tier1 External::Rpcrt4)
endif()
