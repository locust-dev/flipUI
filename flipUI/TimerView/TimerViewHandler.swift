//
//  TimerViewLogic.swift
//  flipUI
//
//  Created by Илья Тюрин on 07.09.2021.
//

import Foundation

final class TimerViewHandler {
  
    // MARK: - Properties
    
    var timer: Timer?
    var targetSeconds: Int
    weak var delegate: TimerViewDelegate?
    
    
    // MARK: - Life cycle
    
    init(timeInterval: Int) {
        targetSeconds = timeInterval
        createTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
   
    // MARK: - Private methods
    
    @objc private func startTimer() {
        targetSeconds -= 1
        timeFormatter(seconds: targetSeconds)
    }
    
    private func createTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(startTimer),
                                     userInfo: nil,
                                     repeats: true)
        
        
        guard let timer = timer else {
            return
        }
        
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.2
    }
    
    private func timeFormatter(seconds: Int) {
        
        let afterDays = seconds % 86400
        let hoursInt = afterDays / 3600
        let minutesInt = afterDays % 3600 / 60
        let secondsInt = afterDays % 3600 % 60
        
        let days = String(seconds / 86400)
        let hours = addZero(hoursInt)
        let minutes = addZero(minutesInt)
        let seconds = addZero(secondsInt)
        
        let timeModel = TimeModel(days: days,
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds)
        
        delegate?.configure(timeModel: timeModel)
    }
    
    private func addZero(_ number: Int) -> String {
        switch number {
        case 0...9: return "0\(String(number))"
        default: return String(number)
        }
    }
    
}


// MARK: - Model
extension TimerViewHandler {
    
    struct TimeModel {
        
        let days: String
        let hours: String
        let minutes: String
        let seconds: String
        
    }
    
}
