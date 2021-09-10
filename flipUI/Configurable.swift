//
//  Configurable.swift
//  flipUI
//
//  Created by Илья Тюрин on 08.09.2021.
//

protocol Configurable {
  
    associatedtype Model
    
    func configure(with model: Model)
}
