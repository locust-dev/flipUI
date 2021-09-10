//
//  CollectionViewController.swift
//  flipUI
//
//  Created by Илья Тюрин on 06.09.2021.
//

import UIKit

protocol CellFlipDelegate {
    func flip(indexPath: IndexPath)
}

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var states: [CardCell.CellState] = []
    private var indexOfCellBeforeDragging = 0
    private var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CardCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let menuIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "menuIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for _ in 0...10 {
            states.append(.front)
        }
        
        drawSelf()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
    }
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        let imageView = UIImageView(image: UIImage(named: "viewBack")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let timerView = TimerView()
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 12
        dateComponents.day = 31
        dateComponents.hour = 23
        dateComponents.minute = 59
        dateComponents.second = 59
        dateComponents.timeZone = TimeZone.current
        let targetDate = Calendar.current.date(from: dateComponents)
        let currentDate = Date()
        let seconds = targetDate?.timeIntervalSince(currentDate)
        
        timerView.configure(with: TimerView.Model(timeInterval: Int(seconds!)))
        
        let rulesView = RulesView()
        rulesView.configure(with: getRulesModel())
        
        let newYearView = NewYearView()
        newYearView.configure(with: getNewYearModel())
        
        let buyButton = BuyButtonView()
        buyButton.configure(with: getBuyButtonModel())
        
        let promotionView = PromotionView()
        promotionView.configure(with: getPromitionModel())
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStack = UIStackView(arrangedSubviews: [
            timerView,
            newYearView,
            collectionView,
            buyButton,
            rulesView,
            promotionView
        ])
        
        mainStack.axis = .vertical
        mainStack.alignment = .center
        mainStack.spacing = 20
        mainStack.setCustomSpacing(40, after: buyButton)
        mainStack.setCustomSpacing(40, after: collectionView)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        
        navigationController?.navigationBar.addSubview(logoImage)
        navigationController?.navigationBar.addSubview(menuIcon)
        
        NSLayoutConstraint.activate([
            
            timerView.heightAnchor.constraint(equalToConstant: 70),
            
            newYearView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            collectionView.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
            
            buyButton.heightAnchor.constraint(equalToConstant: 48),
            buyButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            
            rulesView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            
            promotionView.heightAnchor.constraint(equalToConstant: 650),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            logoImage.centerXAnchor.constraint(equalTo: navigationController!.navigationBar.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: navigationController!.navigationBar.centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 118),
            logoImage.heightAnchor.constraint(equalToConstant: 24),
            
            menuIcon.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor, constant: 19),
            menuIcon.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor),
            menuIcon.widthAnchor.constraint(equalToConstant: 20),
            menuIcon.heightAnchor.constraint(equalToConstant: 20),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    // MARK: - Private methods
    
    private func getPromitionModel() -> PromotionView.Model {
        PromotionView.Model(mainTitle: "Участвуй в акциях Столото",
                            infoTitle: "© 2021 АО «Технологическая Компания «Центр»",
                            policyTitle: "Политика в отношении обработки персональных данных")
    }
    
    private func getNewYearModel() -> NewYearView.Model {
        NewYearView.Model(title: "Собери карточки всех 11 часовых поясов, выиграй 1 000 000 ₽ и другие призы.")
    }
    
    private func getBuyButtonModel() -> BuyButtonView.Model {
        BuyButtonView.Model(title: "Получить все карточки", cost: "3850 ₽")
    }
    
    private func getRulesModel() -> RulesView.Model {
        RulesView.Model(mainTitle: "Участвуй в розыгрышах каждую неделю!",
                        firstStepTitle: "Покупай",
                        firstStep: "каждую неделю билеты на сумму от 350 ₽",
                        secondStepTitle: "Получай",
                        secondStep: "карточку часового пояса, гарантированный приз и участвуй в розыгрыше призов недели",
                        thirdStepTitle: "Собирай",
                        thirdStep: "карточки всех 11 часовых поясов и участвуй в розыгрыше главного приза — 1 000 000 ₽",
                        rulesButtonTitle: "Подробные правила акции")
    }
    
    private func configureCollectionViewLayoutItemSize() {
        
        let ascpectRatio: CGFloat = 1.35
        let width = view.frame.width - 60
        let height = width * ascpectRatio
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = layout.itemSize.width
        let proportionalOffset = layout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
    
}


// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCell
        
        cell.configure(state: states[indexPath.item])
        cell.delegate = self
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let ascpectRatio: CGFloat = 1.35
//        let width = view.frame.width - 60
//        let height = width * ascpectRatio
//        return CGSize(width: width, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
//    }
    
}


// MARK: - CellFlipDelegate
extension MainViewController: CellFlipDelegate {
    
    func flip(indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        
        if states[indexPath.item] == .front {
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            states[indexPath.item] = .back
            cell.configure(state: states[indexPath.item])
        } else {
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            states[indexPath.item] = .front
            cell.configure(state: states[indexPath.item])
        }
    }
    
}


// MARK: - CollectionView paging
extension MainViewController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
        targetContentOffset.pointee = scrollView.contentOffset
        
        let indexOfMajorCell = self.indexOfMajorCell()
        
        let dataSourceCount = collectionView(collectionView, numberOfItemsInSection: states.count)
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = layout.itemSize.width * CGFloat(snapToIndex)
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: velocity.x,
                           options: .allowUserInteraction,
                           animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            layout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
