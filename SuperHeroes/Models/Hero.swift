//
//  Hero.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import Foundation

// MARK: - WelcomeElement
struct Hero: Codable {
    let id: Int
    let name, slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
    
    var stats: String {
                      """
                      Intelligence: \(powerstats.intelligence)
                      Strength: \(powerstats.strength)
                      Speed: \(powerstats.speed)
                      Durability: \(powerstats.durability)
                      Power: \(powerstats.power)
                      Combat: \(powerstats.combat)
                      """
    }
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender: Gender
    let race: String?
    let height, weight: [String]
    let eyeColor, hairColor: String
}

enum Gender: String, Codable {
    case empty = "-"
    case female = "Female"
    case male = "Male"
}

// MARK: - Biography
struct Biography: Codable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance: String
    let publisher: String?
    let alignment: Alignment
}

enum Alignment: String, Codable {
    case bad = "bad"
    case empty = "-"
    case good = "good"
    case neutral = "neutral"
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String
}

// MARK: - Images
struct Images: Codable {
    let xs, sm, md, lg: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power, combat: Int
    

}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}
