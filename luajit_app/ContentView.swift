//
//  ContentView.swift
//  luajit_app
//
//  MIT License Copyright (c) 2024 SFENCE

import SwiftUI
import UniformTypeIdentifiers
import Foundation

extension UTType {
	static var scriptLua : UTType {
		UTType(importedAs: "sfence-software.scriptLua")
	}
}

struct ContentView: View {
	@State private var isFileImporterPresented = false
	@State private var
			captString = "LUA OUTPUT HERE"
	@State private var selectedFileURL: URL?
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Lua output here:")
            TextEditor(text: $captString)
						Button("Lua performance") {
							if let fileURL = Bundle.main.url(forResource: "lua_benchmark", withExtension: "lua") {
								captString = captureLuaOutput(fileURL.path)
							}
						}
            Button("Do Lua script") {
							isFileImporterPresented = true
            }
						.fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.scriptLua]) { result in
							switch result {
							case .success(let url):
									selectedFileURL = url
									print("Selected file: \(url.path)")
								captString = captureLuaOutput(url.path)
							case .failure(let error):
								print("Failed to select file: \(error.localizedDescription)")
							}
						}
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
