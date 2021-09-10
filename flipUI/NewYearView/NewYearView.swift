//
//  NewYearView.swift
//  flipUI
//
//  Created by Илья Тюрин on 08.09.2021.
//

import UIKit

class NewYearView: UIView {

    // MARK: - Locals
    
    private enum Locals {
        
        static let image = UIImage(named: "newYear")
        static let font = UIFont.systemFont(ofSize: 16)
        
    }
    
    
    // MARK: - Properties
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = Locals.image
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = Locals.font
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
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
        
        backgroundColor = .clear
        
        let stack = UIStackView(arrangedSubviews: [image, title])
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 95)
            
        ])
    }

}


// MARK: - Configurable
extension NewYearView: Configurable {
    
    struct Model {
        
        let title: String
        
    }
    
    func configure(with model: Model) {
        title.text = model.title
    }
    
}
