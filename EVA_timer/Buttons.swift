//
//  Buttons.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/17/25.
//

import SwiftUI

struct Buttons: View {
    @EnvironmentObject var countDown: CountDownModel
    
    @Binding var isStop: Bool // now receives binding
    @Binding var isSlow: Bool
    @Binding var isNormal: Bool
    @Binding var isRacing: Bool
    
//    // button sizing variables
    var buttonWidth: CGFloat = 90
    var buttonHeight: CGFloat = 44
    
    var body: some View {
//        Text(countDown.state)
        // setting the button logic
        GeometryReader { geometry in
            // STOP BUTTON
            Button {
                isStop = true
                isSlow = false
                isNormal = false
                isRacing = false
                
                countDown.stopTimer()
            } label: {
                Text("")
                    .frame(width: buttonWidth, height: buttonHeight)
            }
            .position(
                x: geometry.size.width * 0.381,  // Keeps the button at % of the window width
                y: geometry.size.height * 0.665 // Keeps the button at % of the window height
            )
            .buttonStyle(.borderless)
            
            // SLOW BUTTON
            Button {
                isSlow.toggle()
                isNormal = false
                isRacing = false
                
                // if clicked again, stop the timer
                isSlow ? countDown.slowTimer() : countDown.stopTimer()
                
                // if we are paused, set the image to stop
                if (countDown.state == "paused") {
                    isStop = true
                } else {
                    isStop = false
                }
            } label: {
                Text("")
                    .frame(width: buttonWidth, height: buttonHeight)
            }
            .position(
                x: geometry.size.width * 0.5095,  // Keeps the button at % of the window width
                y: geometry.size.height * 0.665 // Keeps the button at % of the window height
            )
            .buttonStyle(.borderless)
            
            // NORMAL BUTTON
            Button {
                isSlow = false
                isNormal.toggle()
                isRacing = false
                
                // if clicked again, stop the timer
                isNormal ? countDown.startTimer(speed: 1.0) : countDown.stopTimer()
                
                // if we are paused, set the image to stop
                if (countDown.state == "paused") {
                    isStop = true
                } else {
                    isStop = false
                }
            } label: {
                Text("")
                    .frame(width: buttonWidth, height: buttonHeight)
            }
            .position(
                x: geometry.size.width * 0.637,  // Keeps the button at % of the window width
                y: geometry.size.height * 0.665 // Keeps the button at % of the window height
            )
            .buttonStyle(.borderless)
            
            // RACING BUTTON
            Button {
                isSlow = false
                isNormal = false
                isRacing.toggle()
                
                // if clicked again, stop the timer
                isRacing ? countDown.startTimer(speed: 2.0) : countDown.stopTimer()
                
                // if we are paused, set the image to stop
                if (countDown.state == "paused") {
                    isStop = true
                } else {
                    isStop = false
                }
            } label: {
                Text("")
                    .frame(width: buttonWidth, height: buttonHeight)
            }
            .position(
                x: geometry.size.width * 0.765,  // Keeps the button at % of the window width
                y: geometry.size.height * 0.665 // Keeps the button at % of the window height
            )
            .buttonStyle(.borderless)
        }
    }
}
