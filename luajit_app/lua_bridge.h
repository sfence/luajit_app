//
//  lua_bridge.h
//  luajit_app
//
//  MIT License Copyright (c) 2024 SFENCE

// Bridging-Header.h

#include <stdint.h>

typedef void (*OutputCatcher)(const char *output);

void do_lua_script(const char *script_file, OutputCatcher callback);

typedef void (*OutputCatcherWtf)(void);

void do_lua_script_wtf(const char *script_file, OutputCatcherWtf callback);

const char *getCatched(void);
