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

    var background = BackgroundSet()
    
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
    @State private var buttonWidth: CGFloat = 88
    @State private var buttonHeight: CGFloat = 44
    
    var body: some View {
        ZStack {
            // set the color of the background
            if (countDown.remaining_time <= 30 && countDown.remaining_time > 15) && countDown.state == "running" {
                background.setColor(isStop, isSlow, isNormal, isRacing, "ORG")
            } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                background.setColor(isStop, isSlow, isNormal, isRacing, "RED")
            } else {
                background.setColor(isStop, isSlow, isNormal, isRacing, "YLW")
            }
            background.setBackground()
            
            
            
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
                    y: geometry.size.height * 0.675 // Keeps the button at % of the window height
                )
                .buttonStyle(.bordered)
                
                
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
                    y: geometry.size.height * 0.675 // Keeps the button at % of the window height
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
                    y: geometry.size.height * 0.675 // Keeps the button at % of the window height
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
                    y: geometry.size.height * 0.675 // Keeps the button at % of the window height
                )
                .buttonStyle(.borderless)
                
                
                // NUMBERS DISPLAY
                if (countDown.remaining_time <= 60 && countDown.remaining_time > 15) && countDown.state == "running" {
                    // minute value
                    // tens unit of minute
                    Text(display.numToTens(number: countDown.minutes))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("ORG"))
                    
                        .position(
                            x: geometry.size.width * 0.365,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                    
                    // ones unit of minute
                    Text(display.numToOnes(number: countDown.minutes))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("ORG"))
                        .position(
                            x: geometry.size.width * 0.50,  // Keeps the button at 50% of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at 50% of the window height
                        )
                } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                    // minute value
                    // tens unit of minute
                    Text(display.numToTens(number: countDown.minutes))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("RED"))
                    
                        .position(
                            x: geometry.size.width * 0.365,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                    
                    // ones unit of minute
                    Text(display.numToOnes(number: countDown.minutes))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("RED"))
                        .position(
                            x: geometry.size.width * 0.50,  // Keeps the button at 50% of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at 50% of the window height
                        )
                } else {
                    // minute value
                    // tens unit of minute
                    Text(display.numToTens(number: countDown.minutes))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("YLW"))
                    
                        .position(
                            x: geometry.size.width * 0.365,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                    
                    // ones unit of minute
                    Text(display.numToOnes(number: countDown.minutes))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("YLW"))
                        .position(
                            x: geometry.size.width * 0.50,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                }
                
                if countDown.state == "paused" || countDown.state == "idle" {
                    // slider for minute value
                    ValueSlider(value: $minuteVal, in: 0.0 ... 59.0, step: 1.0)
                        .frame(height: 180)
                        .valueSliderStyle(
                            VerticalValueSliderStyle(
                                thumb: Rectangle(),
                                thumbSize: CGSize(width: 237, height: 50)
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
                            x: geometry.size.width * 0.43,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.457 // Keeps the button at % of the window height
                        )
                }
                
                // seconds val
                
                if (countDown.remaining_time <= 60 && countDown.remaining_time > 15) && countDown.state == "running" {
                    // tens unit of seconds val
                    Text(display.numToTens(number: countDown.seconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("ORG"))
                        .position(
                            x: geometry.size.width * 0.66,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                        .onChange(of: countDown.seconds) {
                            if (countDown.state != "paused") {
                                secColon.toggle()
                            } else {
                                secColon = false
                            }
                        }

                    // ones unit of seconds val
                    Text(display.numToOnes(number: countDown.seconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("ORG"))
                        .position(
                            x: geometry.size.width * 0.795,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                    
                    if secColon == true {
                        Text(":")
                            .font(Font.custom("digital-7", size: 275))
                            .foregroundColor(Color("ORG"))
                            .position(
                                x: geometry.size.width * 0.58,  // Keeps the button at % of the window width
                                y: geometry.size.height * 0.48 // Keeps the button at % of the window height
                            )
                    }
                    
                    
                    
                    
                } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                    // tens unit of seconds val
                    Text(display.numToTens(number: countDown.seconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("RED"))
                        .position(
                            x: geometry.size.width * 0.66,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                        .onChange(of: countDown.seconds) {
                            if (countDown.state != "paused") {
                                secColon.toggle()
                            } else {
                                secColon = false
                            }
                        }

                    // ones unit of seconds val
                    Text(display.numToOnes(number: countDown.seconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("RED"))
                        .position(
                            x: geometry.size.width * 0.795,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                    
                    if secColon == true {
                        Text(":")
                            .font(Font.custom("digital-7", size: 275))
                            .foregroundColor(Color("RED"))
                            .position(
                                x: geometry.size.width * 0.58,  // Keeps the button at % of the window width
                                y: geometry.size.height * 0.48 // Keeps the button at % of the window height
                            )
                    }
                } else {
                    // tens unit of seconds val
                    Text(display.numToTens(number: countDown.seconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("YLW"))
                        .position(
                            x: geometry.size.width * 0.66,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                        .onChange(of: countDown.seconds) {
                            if (countDown.state != "paused") {
                                secColon.toggle()
                            } else {
                                secColon = false
                            }
                        }

                    // ones unit of seconds val
                    Text(display.numToOnes(number: countDown.seconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 175))
                        .foregroundColor(Color("YLW"))
                        .position(
                            x: geometry.size.width * 0.795,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.456 // Keeps the button at % of the window height
                        )
                    
                    if secColon == true {
                        Text(":")
                            .font(Font.custom("digital-7", size: 275))
                            .foregroundColor(Color("YLW"))
                            .position(
                                x: geometry.size.width * 0.58,  // Keeps the button at % of the window width
                                y: geometry.size.height * 0.48 // Keeps the button at % of the window height
                            )
                    }
            
                }
                
                if countDown.state == "paused" || countDown.state == "idle" {
                    // slider for seconds val
                    ValueSlider(value: $secondVal, in: 0.0 ... 59.0, step: 1.0)
                        .frame(height: 180)
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
                            x: geometry.size.width * 0.72,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.457 // Keeps the button at % of the window height
                        )
                }
                
                
                // milliseconds val
                if (countDown.remaining_time <= 60 && countDown.remaining_time > 15) && countDown.state == "running" {
                    // tens unit of milliseconds val
                    Text(display.numToTens(number: countDown.milliseconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 60))
                        .foregroundColor(Color("ORG"))
                        .position(
                            x: geometry.size.width * 0.895,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.545 // Keeps the button at % of the window height
                        )
                    
                    // ones unit of milliseconds val
                    Text(display.numToOnes(number: countDown.milliseconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 60))
                        .foregroundColor(Color("ORG"))
                        .position(
                            x: geometry.size.width * 0.943,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.545 // Keeps the button at % of the window height
                        )
                    
                    if secColon == true {
                        Text(":")
                            .font(Font.custom("digital-7", size: 110))
                            .foregroundColor(Color("ORG"))
                            .position(
                                x: geometry.size.width * 0.865,  // Keeps the button at % of the window width
                                y: geometry.size.height * 0.555 // Keeps the button at % of the window height
                            )
                    }
                    
                } else if countDown.remaining_time <= 15 && countDown.state == "running"{
                    // tens unit of milliseconds val
                    Text(display.numToTens(number: countDown.milliseconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 60))
                        .foregroundColor(Color("RED"))
                        .position(
                            x: geometry.size.width * 0.895,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.545 // Keeps the button at % of the window height
                        )
                    
                    // ones unit of milliseconds val
                    Text(display.numToOnes(number: countDown.milliseconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 60))
                        .foregroundColor(Color("RED"))
                        .position(
                            x: geometry.size.width * 0.943,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.545 // Keeps the button at % of the window height
                        )
                    
                    if secColon == true {
                        Text(":")
                            .font(Font.custom("digital-7", size: 110))
                            .foregroundColor(Color("RED"))
                            .position(
                                x: geometry.size.width * 0.865,  // Keeps the button at % of the window width
                                y: geometry.size.height * 0.555 // Keeps the button at % of the window height
                            )
                    }
                } else {
                    // tens unit of milliseconds val
                    Text(display.numToTens(number: countDown.milliseconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 60))
                        .foregroundColor(Color("YLW"))
                        .position(
                            x: geometry.size.width * 0.895,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.545 // Keeps the button at % of the window height
                        )
                    
                    // ones unit of milliseconds val
                    Text(display.numToOnes(number: countDown.milliseconds))
                        .font(Font.custom("DSEG7Classic-Bold", size: 60))
                        .foregroundColor(Color("YLW"))
                        .position(
                            x: geometry.size.width * 0.943,  // Keeps the button at % of the window width
                            y: geometry.size.height * 0.545 // Keeps the button at % of the window height
                        )
                    
                    if secColon == true {
                        Text(":")
                            .font(Font.custom("digital-7", size: 110))
                            .foregroundColor(Color("YLW"))
                            .position(
                                x: geometry.size.width * 0.865,  // Keeps the button at % of the window width
                                y: geometry.size.height * 0.555 // Keeps the button at % of the window height
                            )
                    }
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
