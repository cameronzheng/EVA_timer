//
//  ContentView.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/2/25.
//

import SwiftUI
import Sliders

struct ContentView: View {
    // initialize
    @StateObject private var countDown = CountDownModel()
    @StateObject private var font = fontManager()
    @StateObject private var display = displayManager()

    var mainScreen = MainScreen()
    
    // button boolean variables
    @State private var isStop = true // initialized to be stopped
    @State private var isSlow = false
    @State private var isNormal = false
    @State private var isRacing = false
    
    @State private var secColon = false
    @State private var milliSecColon = false
    
    
    // time variables
//    @State private var hourVal = 0.0
    @State private var minuteVal = 0.0
    @State private var secondVal = 0.0
    @State private var millisecondVal = 0.0
    
    // button sizing variables
    @State private var buttonWidth: CGFloat = 90
    @State private var buttonHeight: CGFloat = 44
    
    var body: some View {
        ZStack {
            
            // setting the background
            // set the color of the background
            if (countDown.remaining_time <= 30 && countDown.remaining_time > 15) && countDown.state == "running" {
                mainScreen.backgroundColor(isStop, isSlow, isNormal, isRacing, "ORG")
            } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                mainScreen.backgroundColor(isStop, isSlow, isNormal, isRacing, "RED")
            } else {
                mainScreen.backgroundColor(isStop, isSlow, isNormal, isRacing, "YLW")
            }
            mainScreen.setBackground() // sets the background digits
            
            
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
                
                // display the numbers
                // NUMBERS DISPLAY
                let minTens = display.numToTens(number: countDown.minutes)
                let minOnes = display.numToOnes(number: countDown.minutes)
                
                if (countDown.remaining_time <= 60 && countDown.remaining_time > 15) && countDown.state == "running" {
                    mainScreen.SetDigits(0, minTens, minOnes, "ORG")
                } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                    mainScreen.SetDigits(0, minTens, minOnes, "RED")
                } else {
                    mainScreen.SetDigits(0, minTens, minOnes, "YLW")
                }
                
                // slider for the numbers
                if countDown.state == "paused" || countDown.state == "idle" {
                    // slider for minute value
                    ValueSlider(value: $minuteVal, in: 0.0 ... 59.0, step: 1.0)
                        .frame(height: 170)
                        .valueSliderStyle(
                            VerticalValueSliderStyle(
                                thumb: Rectangle(),
                                thumbSize: CGSize(width: 235, height: 50)
                            )
                        )
                        .opacity(0.4) // sets the transparency of the slider
                        .onChange(of: minuteVal) { // updates the minuteVal on the screen
                            if countDown.state == "paused" || countDown.state == "idle" { countDown.updateTimeComponent(hour: nil, minute: String(minuteVal), second: nil, millisecond: nil)
                            }
                        }
                        // only change the minute value when paused or idle
                        .disabled(countDown.state != "paused" && countDown.state != "idle")
                        .frame(width: 64, height: 100)
                        .padding()
                        .position(
//                            x: geometry.size.width * 0.433,  // Keeps the button at % of the window width
//                            y: geometry.size.height * 0.457 // Keeps the button at % of the window height
                            x: 405,
                            y: 323
                        )
                }
                
                // displaying the seconds
                // seconds val
                let secTens = display.numToTens(number: countDown.seconds)
                let secOnes = display.numToOnes(number: countDown.seconds)
                
                if (countDown.remaining_time <= 30 && countDown.remaining_time > 15) && countDown.state == "running" {
                    mainScreen.SetDigits(2, secTens, secOnes, "ORG")
                } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                    mainScreen.SetDigits(2, secTens, secOnes, "RED")
                } else {
                    mainScreen.SetDigits(2, secTens, secOnes, "YLW")
                }
                
                // slider for the seconds
                if countDown.state == "paused" || countDown.state == "idle" {
                    // slider for seconds val
                    ValueSlider(value: $secondVal, in: 0.0 ... 59.0, step: 1.0)
                        .frame(height: 170)
                        .valueSliderStyle(
                            VerticalValueSliderStyle(
                                thumb: Rectangle(),
                                thumbSize: CGSize(width: 237, height: 50)
                            )
                        )
                        .opacity(0.4) // transparency of the slider
                        .onChange(of: secondVal) {
                            if countDown.state == "paused" || countDown.state == "idle" { countDown.updateTimeComponent(hour: nil, minute: nil, second: String(secondVal), millisecond: nil)
                            }
                        }
                        // only change if the timer is paused or idled
                        .disabled(countDown.state != "paused" && countDown.state != "idle")
                        .frame(width: 64, height: 100)
                        .padding()
                        .position(
                            x: 682,
                            y: 323
                        )
                }
                
                // displaying the milliseconds
                // milliseconds val
                let msecTens = display.numToTens(number: countDown.milliseconds)
                let msecOnes = display.numToOnes(number: countDown.milliseconds)
                
                if (countDown.remaining_time <= 60 && countDown.remaining_time > 15) && countDown.state == "running" {
                    mainScreen.SetDigits(4, msecTens, msecOnes, "ORG")
                } else if countDown.remaining_time <= 15 && countDown.state == "running"{
                    mainScreen.SetDigits(4, msecTens, msecOnes, "RED")
                } else {
                    mainScreen.SetDigits(4, msecTens, msecOnes, "YLW")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .frame(
            minWidth: 938, maxWidth: 938,
            minHeight: 650, maxHeight: 650
        )
}
