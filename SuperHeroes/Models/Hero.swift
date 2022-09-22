//
//  Hero.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import Foundation

// MARK: - WelcomeElement
struct Hero: Codable {
    let name: String
    let powerstats: Powerstats
    let images: Images
}

// MARK: - Images
struct Images: Codable {
    let xs, sm, md, lg: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability: Int
    let power, combat: Int
}
