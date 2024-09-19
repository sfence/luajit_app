//
//  lua_bridge.c
//  luajit_app
//
//  MIT License Copyright (c) 2024 SFENCE



#include "lua_bridge.h"

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#include <stdio.h>
#include <string.h>

static OutputCatcher catchOutput;

// Function to capture Lua output
static int capture_output(lua_State *L) {
	const char *str = lua_tostring(L, -1);
	if (str) {
		catchOutput(str);
	}
	return 0;
}

void do_lua_script(const char *script_file, OutputCatcher callback) {
	catchOutput = callback;
	
	lua_State *L = luaL_newstate(); // Create a new Lua state
	luaL_openlibs(L); // Load Lua libraries

	// Redirect Lua print function to capture_output
	lua_pushcfunction(L, capture_output);
	lua_setglobal(L, "print");

	// Run the Lua script
	if (luaL_dofile(L, script_file) != LUA_OK) {
		catchOutput("Error: ");
		capture_output(L);
		catchOutput("\n");
		lua_pop(L, 1); // Remove error message from stack
	}

	lua_close(L); // Close the Lua state
	return;
}

static const char *catched_invalid = "";
static const char *catched;

static OutputCatcherWtf catchOutputWtf;

// Function to capture Lua output
static int capture_output_wtf(lua_State *L) {
	const char *str = lua_tostring(L, -1);
	if (str) {
		catched = str;
		catchOutputWtf();
		catched = catched_invalid;
	}
	return 0;
}

void do_lua_script_wtf(const char *script_file, OutputCatcherWtf callback) {
	catchOutputWtf = callback;
	
	lua_State *L = luaL_newstate(); // Create a new Lua state
	luaL_openlibs(L); // Load Lua libraries

	// Redirect Lua print function to capture_output
	lua_pushcfunction(L, capture_output_wtf);
	lua_setglobal(L, "print");

	// Run the Lua script
	if (luaL_dofile(L, script_file) != LUA_OK) {
		catched = "Error: ";
		catchOutputWtf();
		capture_output_wtf(L);
		catched = "\n";
		catchOutputWtf();
		catched = catched_invalid;
		lua_pop(L, 1); // Remove error message from stack
	}

	lua_close(L); // Close the Lua state
	return;
}

const char *getCatched(void) {
	return catched;
}
