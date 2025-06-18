//
//  test.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/14/25.
//
import SwiftUI

struct MainScreen {
    //  [minute tens digit, minute seconds digit, seconds tens digit, seconds seconds digit, milliseconds tens digit, milliseconds seconds digit]
    private var xDigitPos: [CGFloat] = [343, 470, 619, 745, 840, 884]
    private var yDigitPos: [CGFloat] = [323, 323, 323, 323, 382, 382]
    private var digitFont: [CGFloat] = [175, 175, 175, 175, 60, 60]
    // [second colon, millisecond colon]
    private var xColPos: [CGFloat] = [544, 811]
    private var yColPos: [CGFloat] = [338, 389]
    // [seconds colon, millisecond colon]
    private var colFont: [CGFloat] = [275, 110]
    
    func SetDigits(_ digit: Int, _ tens: String, _ ones: String, _ color: String) -> some View {
        ZStack {
            // tens unit
            Text(tens)
                .font(Font.custom("DSEG7Classic-Bold", size: digitFont[digit]))
                .foregroundColor(Color(color))
                .position(
                    x: xDigitPos[digit],
                    y: yDigitPos[digit]
                )
            
            // tens unit
            Text(ones)
                .font(Font.custom("DSEG7Classic-Bold", size: digitFont[digit]))
                .foregroundColor(Color(color))
                .position(
                    x: xDigitPos[digit + 1],
                    y: yDigitPos[digit + 1]
                )
        }
    }
    
    // _ removes external parameter names
    func backgroundColor(_ isStop: Bool, _ isSlow: Bool, _ isNormal: Bool, _ isRacing: Bool, _ color: String) -> some View {
        ZStack {
            Image(color + "_EVA_TIMER-BACKGROUND")
                .resizable()
                .scaledToFill()
            
            Image(color + "_EVA_TIMER-MAIN_SCREEN")
                .resizable()
                .scaledToFill()
            
            Image(isStop ? color + "_EVA_TIMER-STOP_ON" : color + "_EVA_TIMER-STOP_OFF")
                .resizable()
            
            Image(isSlow ? color + "_EVA_TIMER-SLOW_ON" : color + "_EVA_TIMER-SLOW_OFF")
                .resizable()
            
            Image(isNormal ? color + "_EVA_TIMER-NORMAL_ON" : color + "_EVA_TIMER-NORMAL_OFF")
                .resizable()
            
            Image(isRacing ? color + "_EVA_TIMER-RACING_ON" : color + "_EVA_TIMER-RACING_OFF")
                .resizable()
            
            Image(isStop ? "EVA_TIMER-INTERNAL_OFF" : color + "_EVA_TIMER-INTERNAL_ON")
                .resizable()
            
            Image(color + "_EVA_TIMER-MESS_ON")
                .resizable()
        }
    }
    
    func setBackground() -> some View {
        ZStack {
            // background for the digits
            ForEach((0...5), id: \.self) { digit in
                Text("8")
                    .font(Font.custom("DSEG7Classic-Bold", size: digitFont[digit]))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: xDigitPos[digit],
                        y: yDigitPos[digit]
                    )
            }
            
            // background for the colons
            ForEach((0...1), id: \.self) { digit in
                Text(":")
                    .font(Font.custom("digital-7", size: colFont[digit]))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .position(
                        x: xColPos[digit],
                        y: yColPos[digit]
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
