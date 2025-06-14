//
//  Timer.swift
//  EVA_timer
//
//  Created by Cameron Zheng on 6/14/25.
//

import SwiftUI

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
