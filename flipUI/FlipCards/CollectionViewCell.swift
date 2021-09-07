//
//  CollectionViewCell.swift
//  flipUI
//
//  Created by Илья Тюрин on 06.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let stolotoOrange = UIColor(named: "stolotoOrange")
        static let lightImage = UIImage(named: "cardLightBack")!
        static let flipToBackImage = UIImage(named: "flipToBack")!
        static let flipToFrontImage = UIImage(named: "flipToFront")!
        static let boughtCheckbox = UIImage(named: "boughtCheckbox")!
        static let prizeImage = UIImage(named: "prizeImage")!
        
        enum TimeZone {
            
            static let font = UIFont.boldSystemFont(ofSize: 18)
            
        }
        
        enum BuyButton {
            
            static let font = UIFont.boldSystemFont(ofSize: 16)
            static let line = UIImage(named: "buttonTitleLine")!
            
        }
        
        enum ButtonCost {
            
            static let font = UIFont.systemFont(ofSize: 16)
            
        }
        
        enum InfoTitle {
            
            static let font = UIFont.systemFont(ofSize: 12)
            
        }
        
        enum IsDrawingOn {
            
            static let font = UIFont.boldSystemFont(ofSize: 12)
            static let textColor = UIColor(white: 0.1, alpha: 0.6)
            
        }
    }
    
    
    // MARK: - State
    
    enum CellState {
        case front
        case back
    }
    
    func configure(state: CellState) {
        switch state {
        case .front: drawFront()
        case .back: drawBack()
        }
    }
    
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        flipToBack.layer.cornerRadius = flipToBack.frame.height / 2
        boughtButton.layer.cornerRadius = boughtButton.frame.height / 2
        prizeImage.layer.cornerRadius = prizeImage.frame.height / 2
        timeAbbreviation.layer.cornerRadius = timeAbbreviation.frame.height / 2
        time.layer.cornerRadius = time.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawFront()
        
        let model = Model(alreadyBought: 4, buyButtonTitle: "Получить карточку", cardCost: "350 ₽", isDrawingOnTitle: "Участвует в розыгрыше", drawingDate: "01.10.2021", drawingStatus: true, timeZone: "Камчатское время", timeAbbreviation: "МСК+7", time: "15:00", cities: "Колыма, Магадан, Хабаровск, Чита", weekNumber: 2, prize: "фотоаппарат (10 шт)")
        
        
        configure(model: model)
    }
    
    
    // MARK: - Properties
    
    var delegate: CellFlipDelegate?
    
    
    // MARK: - Front
    
    private let frontView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let whiteFrontView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let frontImage: UIImageView = {
        let image = UIImageView()
        image.image = Locals.lightImage
        image.layer.cornerRadius = 18
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let timeZone: UILabel = {
        let label = UILabel()
        label.font = Locals.TimeZone.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Locals.stolotoOrange
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonTitle: UILabel = {
        let label = UILabel()
        label.font = Locals.BuyButton.font
        return label
    }()
    
    private let buttonCost: UILabel = {
        let label = UILabel()
        label.font = Locals.ButtonCost.font
        return label
    }()
    
    private let weekCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.InfoTitle.font
        return label
    }()
    
    private let prize: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.InfoTitle.font
        return label
    }()
    
    private let drawingDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.InfoTitle.font
        return label
    }()
    
    private let isDrawingOn: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.titleLabel?.font = Locals.IsDrawingOn.font
        button.setTitleColor(Locals.IsDrawingOn.textColor, for: .normal)
        button.backgroundColor = Locals.stolotoOrange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var flipToBack: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(flip), for: .touchUpInside)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let boughtButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let boughtTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Locals.InfoTitle.font
        return label
    }()
    
    private let buttonStack: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.spacing = 6
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()

    
    // MARK: - Back
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let prizeImage: UIImageView = {
        let image = UIImageView()
        image.image = Locals.prizeImage
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let timeAbbreviation: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 0.243, green: 0.149, blue: 0.533, alpha: 1)
        button.titleLabel?.font = Locals.InfoTitle.font
        return button
    }()
    
    private let time: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = .white
        button.titleLabel?.font = Locals.InfoTitle.font
        button.setTitleColor(Locals.IsDrawingOn.textColor, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    private let citiesLabel: UILabel = {
        let label = UILabel()
        label.textColor = Locals.IsDrawingOn.textColor
        label.font = Locals.InfoTitle.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var flipToFront: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(flip), for: .touchUpInside)
        button.setImage(Locals.flipToFrontImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func drawFront() {
        
        backView.removeFromSuperview()
        contentView.addSubview(frontView)
        
        let infoStack = UIStackView(arrangedSubviews: [weekCount, prize, drawingDate])
        infoStack.axis = .vertical
        infoStack.spacing = 5
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let flipImage = UIImageView(image: Locals.flipToBackImage)
        flipImage.translatesAutoresizingMaskIntoConstraints = false
        
//        let checkbox = UIImageView()
//        checkbox.image = Locals.boughtCheckbox
//        checkbox.translatesAutoresizingMaskIntoConstraints = false
        
        let boughtStack = UIStackView(arrangedSubviews: [boughtTitle])
        boughtStack.distribution = .equalSpacing
        boughtStack.spacing = 6
        boughtStack.translatesAutoresizingMaskIntoConstraints = false
        
        frontView.addSubview(frontImage)
        frontView.addSubview(whiteFrontView)
        frontView.addSubview(timeZone)
        frontView.addSubview(buyButton)
        frontView.addSubview(infoStack)
        frontView.addSubview(isDrawingOn)
        frontView.addSubview(flipToBack)
        frontView.addSubview(boughtButton)
        
        flipToBack.addSubview(flipImage)
        boughtButton.addSubview(boughtStack)
        
        //        let lineImageView = UIImageView(image: Locals.BuyButton.line)
        //        lineImageView.backgroundColor = .clear
        
        drawBuyButton()
        
        NSLayoutConstraint.activate([
            
            frontView.topAnchor.constraint(equalTo: contentView.topAnchor),
            frontView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            frontImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            frontImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            frontImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            frontImage.heightAnchor.constraint(equalToConstant: 248),
            
            whiteFrontView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteFrontView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            whiteFrontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            whiteFrontView.heightAnchor.constraint(equalToConstant: 135),
            
            timeZone.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeZone.bottomAnchor.constraint(equalTo: whiteFrontView.topAnchor, constant: -12),
            
            infoStack.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -11),
            infoStack.centerXAnchor.constraint(equalTo: buyButton.centerXAnchor),
            
            isDrawingOn.bottomAnchor.constraint(equalTo: timeZone.topAnchor, constant: -10),
            isDrawingOn.centerXAnchor.constraint(equalTo: timeZone.centerXAnchor),
            isDrawingOn.heightAnchor.constraint(equalToConstant: 20),
            isDrawingOn.widthAnchor.constraint(equalToConstant: 162),
            
            flipToBack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            flipToBack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            flipToBack.heightAnchor.constraint(equalToConstant: 26),
            flipToBack.widthAnchor.constraint(equalToConstant: 26),
            
            flipImage.topAnchor.constraint(equalTo: flipToBack.topAnchor, constant: 7),
            flipImage.leadingAnchor.constraint(equalTo: flipToBack.leadingAnchor, constant: 7),
            flipImage.trailingAnchor.constraint(equalTo: flipToBack.trailingAnchor, constant: -7),
            flipImage.bottomAnchor.constraint(equalTo: flipToBack.bottomAnchor, constant: -7),
            
            boughtButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            boughtButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            boughtButton.heightAnchor.constraint(equalToConstant: 26),
            boughtButton.widthAnchor.constraint(equalToConstant: 134),
            
            boughtStack.topAnchor.constraint(equalTo: boughtButton.topAnchor, constant: 7),
            boughtStack.leadingAnchor.constraint(equalTo: boughtButton.leadingAnchor, constant: 7),
            boughtStack.trailingAnchor.constraint(equalTo: boughtButton.trailingAnchor, constant: -7),
            boughtStack.bottomAnchor.constraint(equalTo: boughtButton.bottomAnchor, constant: -7)
        ])
        
    }
    
    func drawBack() {
        
        frontView.removeFromSuperview()
        contentView.addSubview(backView)
        
        let infoStack = UIStackView(arrangedSubviews: [prize, drawingDate])
        infoStack.axis = .vertical
        infoStack.spacing = 5
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let timeButtonsStack = UIStackView(arrangedSubviews: [timeAbbreviation, time])
        timeButtonsStack.spacing = 5
        timeButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        let timeZoneStack = UIStackView(arrangedSubviews: [timeButtonsStack, timeZone, citiesLabel])
        timeZoneStack.axis = .vertical
        timeZoneStack.alignment = .leading
        timeZoneStack.spacing = 6
        timeZoneStack.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(infoStack)
        backView.addSubview(prizeImage)
        backView.addSubview(timeZoneStack)
        backView.addSubview(flipToFront)
        
        drawBuyButton()
        
        NSLayoutConstraint.activate([

            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            infoStack.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -18),
            infoStack.centerXAnchor.constraint(equalTo: buyButton.centerXAnchor),
            
            prizeImage.bottomAnchor.constraint(equalTo: infoStack.topAnchor, constant: -20),
            prizeImage.centerXAnchor.constraint(equalTo: infoStack.centerXAnchor),
            prizeImage.heightAnchor.constraint(equalToConstant: 110),
            prizeImage.widthAnchor.constraint(equalToConstant: 110),
            
            timeZoneStack.topAnchor.constraint(equalTo: backView.topAnchor, constant: 13),
            timeZoneStack.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            timeZoneStack.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
            
            timeAbbreviation.widthAnchor.constraint(equalToConstant: 68),
            time.widthAnchor.constraint(equalToConstant: 57),
            
            flipToFront.centerYAnchor.constraint(equalTo: timeButtonsStack.centerYAnchor),
            flipToFront.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
            flipToFront.heightAnchor.constraint(equalToConstant: 16),
            flipToFront.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    
    // MARK: - Private methods
    
    private func drawBuyButton() {
        
        buyButton.removeFromSuperview()
        buttonStack.addArrangedSubview(buttonTitle)
        buttonStack.addArrangedSubview(buttonCost)
        buyButton.addSubview(buttonStack)
        contentView.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            
            buttonStack.leadingAnchor.constraint(equalTo: buyButton.leadingAnchor, constant: 10),
            buttonStack.trailingAnchor.constraint(equalTo: buyButton.trailingAnchor, constant: -10),
            buttonStack.bottomAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: -12),
            buttonStack.topAnchor.constraint(equalTo: buyButton.topAnchor, constant: 12),
            
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            buyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            buyButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
    }
    
    @objc private func flip() {
        if let collectionView = self.superview as? UICollectionView {
            if let indexPath = collectionView.indexPath(for: self) {
                delegate?.flip(indexPath: indexPath)
            }
        }
    }
    
}


// MARK: - Configurable
extension CollectionViewCell {
    
    struct Model {
        
        let alreadyBought: Int
        
        let buyButtonTitle: String
        let cardCost: String
        
        let isDrawingOnTitle: String
        let drawingDate: String
        let drawingStatus: Bool
        
        let timeZone: String
        let timeAbbreviation: String
        let time: String
        
        let cities: String
        let weekNumber: Int
        let prize: String
        
    }
    
    func configure(model: Model) {
        
        timeZone.text = model.timeZone
        buttonTitle.text = model.buyButtonTitle
        buttonCost.text = model.cardCost
        
        weekCount.text = "\(model.weekNumber) неделя"
        prize.text = "Приз \(model.prize)"
        drawingDate.text = "Дата розыгрыша \(model.drawingDate)"
        
        isDrawingOn.setTitle(model.isDrawingOnTitle, for: .normal)
        boughtTitle.text = "Куплено \(model.alreadyBought) шт."
        
        timeAbbreviation.setTitle(model.timeAbbreviation, for: .normal)
        time.setTitle(model.time, for: .normal)
        citiesLabel.text = model.cities
    }
    
    

}
