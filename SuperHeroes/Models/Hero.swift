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
    let fullName: String
    let alterEgos: String
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String?
    let alignment: Alignment
    
    var biography: String {
                          """
                          Full name: \(fullName)
                          Alter egos: \(alterEgos)
                          Place of birth: \(placeOfBirth)
                          First appearance: \(firstAppearance)
                          Publisher: \(publisher ?? "")
                          """
    }
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
    let power: Int
    let combat: Int
    
    var powerStats: String {
                            """
                            Intelligence: \(intelligence)
                            Strength: \(strength)
                            Speed: \(speed)
                            Durability: \(durability)
                            Power: \(power)
                            Combat: \(combat)
                            """
    }
}

// MARK: - Work
struct Work: Codable {
    let occupation: String
    let base: String
}
