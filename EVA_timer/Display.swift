//
//  test.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/14/25.
//
import SwiftUI

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
