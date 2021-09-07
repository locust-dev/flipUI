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

class CollectionViewController: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for _ in 0...10 {
            states.append(.front)
        }
        
        drawSelf()
    }
    
    
    // MARK: - Properties
    
    var states: [CollectionViewCell.CellState] = []
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    
    // MARK: - Drawing
    
    func drawSelf() {
        
        //let timerView = TimerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        let imageView = UIImageView(image: UIImage(named: "viewBack")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        view.addSubview(imageView)
        view.addSubview(collectionView)
        //view.addSubview(timerView)
        
        collectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
    }

}


// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.configure(state: states[indexPath.item])
        cell.delegate = self
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 260, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let topBottom = (collectionView.frame.height - 350) / 2
        let leftRight = (view.frame.width - 260) / 2
        return UIEdgeInsets(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
}


// MARK: - CellFlipDelegate
extension CollectionViewController: CellFlipDelegate {
   
    func flip(indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        
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
