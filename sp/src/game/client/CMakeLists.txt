cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project("Client (${GAMENAME})" DESCRIPTION "Client binary" LANGUAGES CXX)

# Todo:
# Add source_replay
# Add protobuf_include

include(source_base)
include(source_dll_base)

add_library(client SHARED $<TARGET_OBJECTS:base>)
target_precompile_headers(client PRIVATE ${SP_SOURCE_DIR}/game/client/cbase.h)
set_target_properties(client PROPERTIES PREFIX "")

if (MAPBASE)
	add_library(mapbase_client OBJECT)
	target_link_libraries(client mapbase)
	target_link_libraries(mapbase_client PRIVATE Lib::Tier2
		$<$<BOOL:${MAPBASE_VSCRIPT}>:Lib::VScript>
		$<$<BOOL:${NEW_RESPONSE_SYSTEM}>:Lib::ResponseRules>
		Lib::Raytrace
	)
	target_compile_options(mapbase_client PRIVATE ${OPT_EXCEPTIONS_ENABLE})
	target_sources(mapbase_client PRIVATE
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/logic_script_client.cpp>
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/vscript_consts_shared.cpp>
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/vscript_consts_weapons.cpp>
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/vscript_funcs_hl2.cpp>
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/vscript_funcs_shared.cpp>
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/vscript_singletons.cpp>
		$<$<BOOL:${MAPBASE_VSCRIPT}>:${SP_SOURCE_DIR}/game/shared/mapbase/weapon_custom_scripted.cpp>
		${SP_SOURCE_DIR}/game/shared/hl2mp/weapon_slam.cpp
		${SP_SOURCE_DIR}/game/shared/hl2mp/weapon_stunstick.cpp
		${SP_SOURCE_DIR}/game/shared/mapbase/mapbase_game_log.cpp 
		${SP_SOURCE_DIR}/game/shared/mapbase/mapbase_rpc.cpp 
		${SP_SOURCE_DIR}/game/shared/mapbase/mapbase_shared.cpp 
		${SP_SOURCE_DIR}/game/shared/mapbase/mapbase_usermessages.cpp 
		${SP_SOURCE_DIR}/game/shared/mapbase/MapEdit.cpp 
		${SP_SOURCE_DIR}/game/shared/mapbase/matchers.cpp 
		${SP_SOURCE_DIR}/game/shared/mapbase/singleplayer_animstate.cpp
		mapbase/c_func_clientclip.cpp
		mapbase/c_func_fake_worldportal.cpp
		mapbase/c_point_glow.cpp
		mapbase/c_vgui_text_display.cpp
		mapbase/mapbase_autocubemap.cpp
		mapbase/vscript_vgui.cpp
		mapbase/vscript_vgui.nut
	)
endif()
