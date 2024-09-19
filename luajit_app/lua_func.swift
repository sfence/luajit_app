//
//  lua_func.swift
//  luajit_app
//
///  MIT License Copyright (c) 2024 SFENCE

import Foundation

var output = ""

// Define the OutputCatcher typealias
typealias OutputCatcher = @convention(c) (UnsafePointer<CChar>) -> Void


// Define the outputCatcher function
func outputCatcher(lua_output: UnsafePointer<CChar>) -> Void {
	let outputString = String(cString: lua_output)
	output += outputString
	output += "\n"
	print(outputString)
}

func outputCatcherWtf() -> Void {
	let outputString = String(cString: getCatched())
	output += outputString
	output += "\n"
	print(outputString)
}

// Function to capture Lua output
func captureLuaOutput(_ script: String) -> String {
	output = ""

	// Create a function pointer to outputCatcher
	let myLuaCapture: OutputCatcher = outputCatcher

	// Call the C function
	//do_lua_script(script, nil)
	//do_lua_script(script, myLuaCapture)
	
	let myLuaCaptureWtf: OutputCatcherWtf = outputCatcherWtf
	
	do_lua_script_wtf(script, myLuaCaptureWtf)

	return output
}
