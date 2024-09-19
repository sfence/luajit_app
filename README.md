`luajit_app`
===========

Test the Apple Silicon MacOS app using LuaJIT.

License
-------

See the LICENSE file for details.

MIT for source code

Testing
-------

1. Go to lib directory.
2. Clone LuaJIT 2.1 from repo to LuaJIT dir: `git clone https://luajit.org/git/luajit.git LuaJIT`
3. Call `./compile_LuaJIT.sh` script to get universal libluajit.a
4. Build `luajit_app` and experiment
5. You can always compare with `./lib/LuaJIT/src/luajit lua_benchmark.lua` for example.
6. You can always apply changes to LuaJIT, recompile it with a compile script, and rebuild your app.

Issues at the time of test app creation
---------------------------------

1. Without extra entitlements like `Allow Execution of JIT-compiled Code` or `Allow Unsigned Executable Memory` script `lua_performance.lua` needs much more time to be done in comparison to the `luajit` standalone binary. (On my M2 processor it is etc 0.15 seconds versus etc 19 seconds.) Rarity I see also the app fails with the reason: `EXC_BAD_ACCESS (SIGKILL (Code Signature Invalid))`
2. With `Allow Unsigned Executable Memory` I see usually that the first run of the app needs 0.15 seconds to finish the benchmark and from some later runs, it drops to, etc 19 seconds.

