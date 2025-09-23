//
//  BilibiliLiveStremCodeSwiftApp.swift
//  BilibiliLiveStremCodeSwift
//
//  Created by sosoorin on 2025/9/23.
//

import SwiftUI

@main
struct BilibiliLiveStremCodeSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light) // 可以根据需要调整
        }
        .windowStyle(.hiddenTitleBar) // macOS上隐藏标题栏，iOS上无效果
    }
}
