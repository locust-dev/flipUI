//
//  BuyButtonView.swift
//  flipUI
//
//  Created by Илья Тюрин on 08.09.2021.
//

import UIKit

class BuyButtonView: UIButton {

    // MARK: - Locals
    
    private enum Locals {
        
        static let separator = UIImage(named: "buttonTitleLine")!
        static let color = UIColor(named: "stolotoOrange")
        
        static let cornerRadius: CGFloat = 12

        static let mainFont = UIFont.boldSystemFont(ofSize: 16)
        static let costFont = UIFont.systemFont(ofSize: 16)
    }
    
    
    // MARK: - Properties
    
    private let buttonTitle: UILabel = {
        let label = UILabel()
        label.font = Locals.mainFont
        label.textAlignment = .center
        return label
    }()
    
    private let buttonCost: UILabel = {
        let label = UILabel()
        label.font = Locals.costFont
        label.textAlignment = .center
        return label
    }()

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        let separator = UIImageView(image: Locals.separator)
        
        let buttonStack = UIStackView(arrangedSubviews: [buttonTitle, separator, buttonCost])
        buttonStack.spacing = 5
        buttonStack.distribution = .fillProportionally
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = Locals.color
        layer.cornerRadius = Locals.cornerRadius
        
        addSubview(buttonStack)
       
        NSLayoutConstraint.activate([
            
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            buttonStack.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        
        ])
    }
    
}


// MARK: - Configurable
extension BuyButtonView: Configurable {
    
    struct Model {
        
        let title: String
        let cost: String
        
    }
    
    func configure(with model: Model) {
        buttonTitle.text = model.title
        buttonCost.text = model.cost
    }
    
}
