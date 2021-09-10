//
//  TimerView.swift
//  flipUI
//
//  Created by Илья Тюрин on 07.09.2021.
//

import UIKit

protocol TimerViewDelegate: AnyObject {
    func configure(timeModel: TimerViewHandler.TimeModel)
}

class TimerView: UIView {

    // MARK: - Locals
    
    private enum Locals {
        
        static let timerFont = UIFont.boldSystemFont(ofSize: 22)
        static let separator = ":"
        
        enum Titles {
            
            static let daysTitle = "дней"
            static let hoursTitle = "часов"
            static let minutuesTitle = "минут"
            static let secondsTitle = "секунд"
            static let titlesFont = UIFont.systemFont(ofSize: 10)
            
        }
        
        enum MainTitle {
            
            static let title = "До главного розыгрыша осталось"
            static let font = UIFont.systemFont(ofSize: 12)
            
        }
    }
    
    
    // MARK: - Properties
    
    var handler: TimerViewHandler?
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Locals.MainTitle.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let days: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = Locals.timerFont
        return label
    }()
    
    private let hours: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = Locals.timerFont
        return label
    }()
    
    private let minutes: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = Locals.timerFont
        return label
    }()
    
    private let seconds: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = Locals.timerFont
        return label
    }()
    
    private let daysTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.Titles.titlesFont
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hoursTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.Titles.titlesFont
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minutesTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.Titles.titlesFont
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.Titles.titlesFont
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorThree: UILabel = {
        let label = UILabel()
        label.font = Locals.timerFont
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let separatorOne: UILabel = {
        let label = UILabel()
        label.font = Locals.timerFont
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let separatorTwo: UILabel = {
        let label = UILabel()
        label.font = Locals.timerFont
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Drawing
    
    func drawSelf() {
        
        backgroundColor = .clear
        
        let timeStack = UIStackView(arrangedSubviews: [
            days,
            separatorOne,
            hours,
            separatorTwo,
            minutes,
            separatorThree,
            seconds
        ])
        
        timeStack.translatesAutoresizingMaskIntoConstraints = false
        timeStack.distribution = .fill
        
        addSubview(timeStack)
        addSubview(daysTitle)
        addSubview(hoursTitle)
        addSubview(minutesTitle)
        addSubview(secondsTitle)
        addSubview(mainTitle)
       
        NSLayoutConstraint.activate([
            
            mainTitle.centerXAnchor.constraint(equalTo: timeStack.centerXAnchor),
            mainTitle.bottomAnchor.constraint(equalTo: timeStack.topAnchor, constant: -6),
            
            timeStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            days.widthAnchor.constraint(equalToConstant: 44),
            hours.widthAnchor.constraint(equalToConstant: 44),
            minutes.widthAnchor.constraint(equalToConstant: 44),
            seconds.widthAnchor.constraint(equalToConstant: 44),
            
            separatorOne.widthAnchor.constraint(equalToConstant: 8),
            separatorTwo.widthAnchor.constraint(equalToConstant: 8),
            separatorThree.widthAnchor.constraint(equalToConstant: 8),
            
            daysTitle.topAnchor.constraint(equalTo: days.bottomAnchor, constant: 5),
            daysTitle.centerXAnchor.constraint(equalTo: days.centerXAnchor),
            
            hoursTitle.topAnchor.constraint(equalTo: hours.bottomAnchor, constant: 5),
            hoursTitle.centerXAnchor.constraint(equalTo: hours.centerXAnchor),
            
            minutesTitle.topAnchor.constraint(equalTo: minutes.bottomAnchor, constant: 5),
            minutesTitle.centerXAnchor.constraint(equalTo: minutes.centerXAnchor),
            
            secondsTitle.topAnchor.constraint(equalTo: seconds.bottomAnchor, constant: 5),
            secondsTitle.centerXAnchor.constraint(equalTo: seconds.centerXAnchor)
        ])
    }
    
}



// MARK: - Configurable
extension TimerView: Configurable {
    
    struct Model {
        
        let timeInterval: Int
        
    }
    
    func configure(with model: Model) {
        
        handler = TimerViewHandler(timeInterval: model.timeInterval)
        handler?.delegate = self
        
        daysTitle.text = Locals.Titles.daysTitle
        hoursTitle.text = Locals.Titles.hoursTitle
        minutesTitle.text = Locals.Titles.minutuesTitle
        secondsTitle.text = Locals.Titles.secondsTitle
        
        separatorOne.text = Locals.separator
        separatorTwo.text = Locals.separator
        separatorThree.text = Locals.separator
        
        mainTitle.text = Locals.MainTitle.title
    }
    
}


// MARK: - TimerViewDelegate
extension TimerView: TimerViewDelegate {
    
    func configure(timeModel: TimerViewHandler.TimeModel) {
        
        days.text = timeModel.days
        hours.text = timeModel.hours
        minutes.text = timeModel.minutes
        seconds.text = timeModel.seconds
        
    }
    
}
