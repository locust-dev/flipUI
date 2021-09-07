//
//  TimerView.swift
//  flipUI
//
//  Created by Илья Тюрин on 07.09.2021.
//

import UIKit

class TimerView: UIView {

    // MARK: - Properties
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00 : 00 : 00"
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func draw(_ rect: CGRect) {
        drawSelf()
    }

    func drawSelf() {
        
        backgroundColor = .purple
        
        addSubview(timerLabel)
        
        
        NSLayoutConstraint.activate([
        
            timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
}
