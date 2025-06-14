//
//  ContentView.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/2/25.
//

import SwiftUI
import Sliders

struct ContentView: View {
    // initialize the classes
    @StateObject private var countDown = CountDownModel()
    @StateObject private var font = fontManager()
    @StateObject private var display = displayManager()
    
    // button boolean variables
    @State private var isStop = true // initialized to be stopped
    @State private var isSlow = false
    @State private var isNormal = false
    @State private var isRacing = false
    
    @State private var secColon = false
    @State private var milliSecColon = false
    
    var background = BackgroundSet()
    
    // time variables
    @State private var hourVal = 0.0
    @State private var minuteVal = 0.0
    @State private var secondVal = 0.0
    @State private var millisecondVal = 0.0
    
    // button sizing variables
    @State private var buttonWidth: CGFloat = 88
    @State private var buttonHeight: CGFloat = 44
    
    var body: some View {
        ZStack {
            // set the color of the background
            if (countDown.remaining_time <= 60 && countDown.remaining_time > 15) && countDown.state == "running" {
                background.setColorToORG(isStop, isSlow, isNormal, isRacing)
            } else if (countDown.remaining_time <= 15) && countDown.state == "running" {
                background.setColorToRED(isStop, isSlow, isNormal, isRacing)
            } else {
                background.setColorToYLW(isStop, isSlow, isNormal, isRacing)
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

// timer countdown class
class CountDownModel: ObservableObject {
    @Published var total_time: Double = 0.0
    @Published var remaining_time: Double
    @Published var state: String
    
    var hours: Int { Int(remaining_time) / 3600 }
    var minutes: Int { (Int(remaining_time) % 3600) / 60 }
    var seconds: Int { Int(remaining_time) % 60 }
    var milliseconds: Int { Int((remaining_time.truncatingRemainder(dividingBy: 1)) * 100) }

    // timer module
    private var timer: Timer?

    init() {
        self.total_time = 0.0
        self.remaining_time = 0.0
        self.state = "idle"
    }

    // startTimer function
    func startTimer(speed: Double) {
        state = "running"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01 / speed, repeats: true) { _ in
            if self.remaining_time > 0 {
                self.remaining_time -= 0.01
            } else {
                print("Timer done!")
                // the state will be left as running until the stop button is pressed
//                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        state = "paused"
    }

    func slowTimer() {
        stopTimer()
        startTimer(speed: 0.5)
    }

    func updateTimeComponent(hour: String?, minute: String?, second: String?, millisecond: String?) {
        let h = Double(hour ?? "\(hours)") ?? 0.0
        let m = Double(minute ?? "\(minutes)") ?? 0.0
        let s = Double(second ?? "\(seconds)") ?? 0.0
        let ms = Double(millisecond ?? "\(milliseconds)") ?? 0.0
        remaining_time = (h * 3600) + (m * 60) + s + (ms / 100)
    }
}

class fontManager : ObservableObject {
    init() {
        registerFonts(String: "DSEG7Classic-Regular")
        registerFonts(String: "DSEG7Classic-Bold")
        registerFonts(String: "digital-7")
    }
    
    func registerFonts(String fontName: String) {
            guard let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf") else {
                print("⚠️ Font file not found.")
                return
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error) {
                print("⚠️ Error registering font: \(String(describing: error))")
            } else {
                print("✅ Font registered successfully")
            }
        }
}

class displayManager : ObservableObject {
    
    // converts the string to a Ones unit string
    func numToOnes(number: Int) -> String {
        let unit = number % 10
        
        if unit == 0 {
            return "0"
        } else {
            return String(unit)
        }
    }
    
    // converts the string to the tens unit string
    func numToTens(number: Int) -> String {
        let tens = number / 10
        
        if tens == 0 {
            return "0"
        } else {
            return String(tens)
        }
    }
}

struct BackgroundSet {
    // _ removes external parameter names
    func setColorToYLW(_ isStop: Bool, _ isSlow: Bool, _ isNormal: Bool, _ isRacing: Bool) -> some View {
        ZStack {
            Image("YLW_EVA_TIMER-BACKGROUND")
                .resizable()
                .scaledToFill()
            
            Image("YLW_EVA_TIMER-MAIN_SCREEN")
                .resizable()
                .scaledToFill()
            
            Image(isStop ? "YLW_EVA_TIMER-STOP_ON" : "YLW_EVA_TIMER-STOP_OFF")
                .resizable()
            
            Image(isSlow ? "YLW_EVA_TIMER-SLOW_ON" : "YLW_EVA_TIMER-SLOW_OFF")
                .resizable()
            
            Image(isNormal ? "YLW_EVA_TIMER-NORMAL_ON" : "YLW_EVA_TIMER-NORMAL_OFF")
                .resizable()
            
            Image(isRacing ? "YLW_EVA_TIMER-RACING_ON" : "YLW_EVA_TIMER-RACING_OFF")
                .resizable()
            
            Image(isStop ? "EVA_TIMER-INTERNAL_OFF" : "YLW_EVA_TIMER-INTERNAL_ON")
                .resizable()
            
            Image("YLW_EVA_TIMER-MESS_ON")
                .resizable()
        }
    }
    
    func setColorToRED(_ isStop: Bool, _ isSlow: Bool, _ isNormal: Bool, _ isRacing: Bool) -> some View {
        ZStack {
            Image("RED_EVA_TIMER-BACKGROUND")
                .resizable()
                .scaledToFill()
            
            Image("RED_EVA_TIMER-MAIN_SCREEN")
                .resizable()
                .scaledToFill()
            
            Image(isStop ? "RED_EVA_TIMER-STOP_ON" : "RED_EVA_TIMER-STOP_OFF")
                .resizable()
            
            Image(isSlow ? "RED_EVA_TIMER-SLOW_ON" : "RED_EVA_TIMER-SLOW_OFF")
                .resizable()
            
            Image(isNormal ? "RED_EVA_TIMER-NORMAL_ON" : "RED_EVA_TIMER-NORMAL_OFF")
                .resizable()
            
            Image(isRacing ? "RED_EVA_TIMER-RACING_ON" : "RED_EVA_TIMER-RACING_OFF")
                .resizable()
            
            Image(isStop ? "RED_TIMER-INTERNAL_OFF" : "RED_EVA_TIMER-INTERNAL_ON")
                .resizable()
            
            Image("RED_EVA_TIMER-MESS_ON")
                .resizable()
        }
    }
    
    func setColorToORG(_ isStop: Bool, _ isSlow: Bool, _ isNormal: Bool, _ isRacing: Bool) -> some View {
        ZStack {
            Image("ORG_EVA_TIMER-BACKGROUND")
                .resizable()
                .scaledToFill()
            
            Image("ORG_EVA_TIMER-MAIN_SCREEN")
                .resizable()
                .scaledToFill()

            Image(isStop ? "ORG_EVA_TIMER-STOP_ON" : "ORG_EVA_TIMER-STOP_OFF")
                .resizable()
            
            Image(isSlow ? "ORG_EVA_TIMER-SLOW_ON" : "ORG_EVA_TIMER-SLOW_OFF")
                .resizable()

            Image(isNormal ? "ORG_EVA_TIMER-NORMAL_ON" : "ORG_EVA_TIMER-NORMAL_OFF")
                .resizable()
            
            Image(isRacing ? "ORG_EVA_TIMER-RACING_ON" : "ORG_EVA_TIMER-RACING_OFF")
                .resizable()

            Image(isStop ? "ORG_TIMER-INTERNAL_OFF" : "ORG_EVA_TIMER-INTERNAL_ON")
                .resizable()
            
            Image("ORG_EVA_TIMER-MESS_ON")
                .resizable()
        }
    }
    
    func setBackground() -> some View {
        ZStack {
            GeometryReader { geometry in
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: 175))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.365,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.46 // Keeps the button at % of the window height
                    )
                
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: 175))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.50,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.46 // Keeps the button at % of the window height
                    )
                
                
                
                Text(":")
                    .font(Font.custom("digital-7", size: 275))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.58,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.48 // Keeps the button at % of the window height
                    )
                
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: 175))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.66,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.46 // Keeps the button at % of the window height
                    )
                
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: 175))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.795,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.46 // Keeps the button at % of the window height
                    )
                
                Text(":")
                    .font(Font.custom("digital-7", size: 110))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.865,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.553 // Keeps the button at % of the window height
                    )
                
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: 60))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.895,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.542 // Keeps the button at % of the window height
                    )
                
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: 60))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: geometry.size.width * 0.943,  // Keeps the button at % of the window width
                        y: geometry.size.height * 0.542 // Keeps the button at % of the window height
                    )
            }
        }
    }
}
