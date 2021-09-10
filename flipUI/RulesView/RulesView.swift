//
//  RulesView.swift
//  flipUI
//
//  Created by Илья Тюрин on 08.09.2021.
//

import UIKit

class RulesView: UIView {

    // MARK: - Locals
    
    private enum Locals {
        
        static let stolotoOrange = UIColor(named: "stolotoOrange")
        static let mainTitleFont = UIFont.boldSystemFont(ofSize: 24)
        static let stepTitleFont = UIFont.boldSystemFont(ofSize: 20)
        static let stepFont = UIFont.systemFont(ofSize: 16)
        static let buttonFont = UIFont.boldSystemFont(ofSize: 16)
        static let stepCountFont = UIFont.systemFont(ofSize: 18)
        
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Properties
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Locals.mainTitleFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let firstStepTitle: UILabel = {
        let label = UILabel()
        label.textColor = Locals.stolotoOrange
        label.font = Locals.stepTitleFont
        return label
    }()
    
    private let secondStepTitle: UILabel = {
        let label = UILabel()
        label.textColor = Locals.stolotoOrange
        label.font = Locals.stepTitleFont
        return label
    }()
    
    private let thirdStepTitle: UILabel = {
        let label = UILabel()
        label.textColor = Locals.stolotoOrange
        label.font = Locals.stepTitleFont
        return label
    }()
    
    private let firstStep: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Locals.stepFont
        label.numberOfLines = 0
        return label
    }()
    
    private let secondStep: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Locals.stepFont
        label.numberOfLines = 0
        return label
    }()
        
    private let thirdStep: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Locals.stepFont
        label.numberOfLines = 0
        return label
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Locals.buttonFont
        button.backgroundColor = Locals.stolotoOrange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Locals.buttonFont
        button.backgroundColor = Locals.stolotoOrange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let thirdButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Locals.buttonFont
        button.backgroundColor = Locals.stolotoOrange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rulesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Locals.buttonFont
        button.backgroundColor = UIColor(white: 0.7, alpha: 0.25)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let lineOne: UIView = {
        let view = UIView()
        view.backgroundColor = Locals.stolotoOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lineTwo: UIView = {
        let view = UIView()
        view.backgroundColor = Locals.stolotoOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        backgroundColor = .clear
    
        let firstStack = UIStackView(arrangedSubviews: [firstStepTitle, firstStep])
        firstStack.axis = .vertical
        firstStack.spacing = 5
        
        let secondStack = UIStackView(arrangedSubviews: [secondStepTitle, secondStep])
        secondStack.axis = .vertical
        secondStack.spacing = 5
        
        let thirdStack = UIStackView(arrangedSubviews: [thirdStepTitle, thirdStep])
        thirdStack.axis = .vertical
        thirdStack.spacing = 5
   
        let stepsStack = UIStackView(arrangedSubviews: [firstStack, secondStack, thirdStack])
        stepsStack.axis = .vertical
        stepsStack.spacing = 36
        stepsStack.translatesAutoresizingMaskIntoConstraints = false
  
        addSubview(mainTitle)
        addSubview(lineOne)
        addSubview(lineTwo)
        addSubview(stepsStack)
        addSubview(firstButton)
        addSubview(secondButton)
        addSubview(thirdButton)
        addSubview(rulesButton)
       
        NSLayoutConstraint.activate([
            
            mainTitle.topAnchor.constraint(equalTo: topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stepsStack.topAnchor.constraint(equalTo: firstButton.topAnchor),
            stepsStack.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: 15),
            stepsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            firstButton.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 26),
            firstButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstButton.heightAnchor.constraint(equalToConstant: 40),
            firstButton.widthAnchor.constraint(equalToConstant: 40),
            
            secondButton.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor),
            secondButton.centerYAnchor.constraint(equalTo: secondStepTitle.centerYAnchor),
            secondButton.heightAnchor.constraint(equalToConstant: 40),
            secondButton.widthAnchor.constraint(equalToConstant: 40),
            
            thirdButton.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor),
            thirdButton.centerYAnchor.constraint(equalTo: thirdStepTitle.centerYAnchor),
            thirdButton.heightAnchor.constraint(equalToConstant: 40),
            thirdButton.widthAnchor.constraint(equalToConstant: 40),
            
            rulesButton.topAnchor.constraint(equalTo: stepsStack.bottomAnchor, constant: 26),
            rulesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            rulesButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rulesButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            rulesButton.heightAnchor.constraint(equalToConstant: 48),
          
            lineOne.topAnchor.constraint(equalTo: firstButton.bottomAnchor),
            lineOne.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor),
            lineOne.bottomAnchor.constraint(equalTo: secondButton.topAnchor),
            lineOne.widthAnchor.constraint(equalToConstant: 2),
            
            lineTwo.topAnchor.constraint(equalTo: secondButton.bottomAnchor),
            lineTwo.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor),
            lineTwo.bottomAnchor.constraint(equalTo: thirdButton.topAnchor),
            lineTwo.widthAnchor.constraint(equalToConstant: 2),
        ])
    }

}


extension RulesView: Configurable {
    
    struct Model {
        
        let mainTitle: String
        
        let firstStepTitle: String
        let firstStep: String
        
        let secondStepTitle: String
        let secondStep: String
        
        let thirdStepTitle: String
        let thirdStep: String
        
        let rulesButtonTitle: String
        
    }
    
    func configure(with model: Model) {
        
        mainTitle.text = model.mainTitle
        
        firstButton.setTitle("1", for: .normal)
        secondButton.setTitle("2", for: .normal)
        thirdButton.setTitle("3", for: .normal)
        
        firstStepTitle.text = model.firstStepTitle
        firstStep.text = model.firstStep
        
        secondStepTitle.text = model.secondStepTitle
        secondStep.text = model.secondStep
        
        thirdStepTitle.text = model.thirdStepTitle
        thirdStep.text = model.thirdStep
        
        rulesButton.setTitle(model.rulesButtonTitle, for: .normal)
        
    }
    
}
