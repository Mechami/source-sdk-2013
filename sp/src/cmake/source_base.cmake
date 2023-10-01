include_guard()

option(MAPBASE "Equivalent to (and required for) our MAPBASE preprocessor defined below" ON)
option(MAPBASE_RPC "Toggles Mapbase's Rich Presence Client implementations (requires discord-rpc.dll in game bin)" OFF)
option(MAPBASE_VSCRIPT "Toggles VScript implementation (note: interfaces still exist, just the provided implementation is not present)" ON)
option(NEW_RESPONSE_SYSTEM "Toggles the new Response System library based on the Alien Swarm SDK" ON)

add_compile_definitions(
	$<$<BOOL:${SOURCESDK}>:SOURCESDK>
	$<$<BOOL:${STAGING_ONLY}>:STAGING_ONLY>
	$<$<BOOL:${TF_BETA}>:TF_BETA>
	$<$<BOOL:${SOURCESDK}>:RAD_TELEMETRY_DISABLED>

	$<$<BOOL:${MAPBASE}>:MAPBASE>
	$<$<BOOL:${MAPBASE_RPC}>:MAPBASE_RPC>
	$<$<BOOL:${MAPBASE_VSCRIPT}>:MAPBASE_VSCRIPT>
	$<$<BOOL:${NEW_RESPONSE_SYSTEM}>:NEW_RESPONSE_SYSTEM>
)
