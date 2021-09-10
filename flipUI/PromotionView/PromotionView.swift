//
//  PromotionView.swift
//  flipUI
//
//  Created by Илья Тюрин on 09.09.2021.
//

import UIKit

class PromotionView: UIView {

    // MARK: - Locals
    
    private enum Locals {
        
        enum MainTitle {
            
            static let font = UIFont.boldSystemFont(ofSize: 24)
            
        }
        
        enum ExtraInfo {
            
            static let font = UIFont.systemFont(ofSize: 14)
            
        }
        
    }
    
    // MARK: - Properties
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = Locals.MainTitle.font
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(PromotionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let infoTitle: UILabel = {
        let label = UILabel()
        label.font = Locals.ExtraInfo.font
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let policyTitle: UILabel = {
        let label = UILabel()
        label.font = Locals.ExtraInfo.font
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        let stack = UIStackView(arrangedSubviews: [infoTitle, policyTitle])
        stack.spacing = 20
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainTitle)
        addSubview(collectionView)
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            mainTitle.topAnchor.constraint(equalTo: topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            mainTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            collectionView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
            
            stack.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}


extension PromotionView: Configurable {
    
    struct Model {
        
        let mainTitle: String
        let infoTitle: String
        let policyTitle: String
        
    }
    
    func configure(with model: Model) {
        
        mainTitle.text = model.mainTitle
        infoTitle.text = model.infoTitle
        policyTitle.text = model.policyTitle
    }
    
}

extension PromotionView: UICollectionViewDelegate {
    
    
    
}

extension PromotionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PromotionCell
        
        let model = PromotionCell.Model(title: "Новогодний миллиард",
                                        subtitle: "Среди всех билетов, которые ничего не выиграли, мы проведем дополнительный розыгрыш автомобиля",
                                        buttonTittle: "Принять участие")
        
        cell.configure(with: model)
        return cell
    }
    
}

extension PromotionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let aspect: CGFloat = 1.6
        let width = frame.width - 60
        let height = width * aspect
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
}
