//
//  HeroCellViewModel.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 23.09.2022.
//

import Foundation


protocol HeroCellViewModelProtocol {
    
    var heroNameLabel: String { get }
    var heroImageData: Data? { get }
    init(hero: Hero)
}

class HeroCellViewModel: HeroCellViewModelProtocol {
    
    var heroNameLabel: String {
        hero.name
    }
    
    var heroImageData: Data? {
        NetworkManager.shared.fetchImageData(from: hero.images.lg)
    }
    
    private let hero: Hero
    
    required init(hero: Hero) {
        self.hero = hero
    }
}
