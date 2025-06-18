//
//  EVA_timerApp.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/2/25.
//

import SwiftUI

@main
struct EVA_timerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: 938, maxWidth: 938,
                    minHeight: 650, maxHeight: 650
                )
                .toolbar(removing: .title)
                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
            
        }
        .windowResizability(.contentSize)
    }
}

