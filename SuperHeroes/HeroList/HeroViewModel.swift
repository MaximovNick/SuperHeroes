//
//  HeroViewModel.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 23.09.2022.
//

import Foundation

protocol HeroViewModelProtocol {
    
    func fetchHero(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getHeroCellViewModel(at indexPath: IndexPath) -> HeroCellViewModelProtocol
}

class HeroViewModel: HeroViewModelProtocol {
    
    private var heroes: [Hero] = []
    
    func fetchHero(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        heroes.count
    }
    
    func getHeroCellViewModel(at indexPath: IndexPath) -> HeroCellViewModelProtocol {
        HeroCellViewModel(hero: heroes[indexPath.row])
    }
}
