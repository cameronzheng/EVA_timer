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
//                    minWidth: 683, maxWidth: 2732,
//                    minHeight: 512, maxHeight: 2048
                    
                    minWidth: 938, maxWidth: 938,
                    minHeight: 650, maxHeight: 650
                    
//                    width: 938, height: 550
                )
//                .windowResizability(.contentSize)
                .toolbar(removing: .title)
                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
            
        }
        .windowResizability(.contentSize)
        // Positioning the window
//        .defaultWindowPlacement { content, context in
//            #if os(macOS)
//            let displayBounds = context.defaultDisplay.visibleRect
////            let size = content.sizeThatFits(.unspecified)
//            let position = CGPoint(
//                x: displayBounds.midX, // - (size.width / 2),
//                y: displayBounds.maxY //- size.height - 20
//            )
//            return WindowPlacement(position)
//            #endif
//        }
    }
}

