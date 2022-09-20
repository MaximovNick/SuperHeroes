//
//  ImageCache.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 20.09.2022.
//

import Foundation
import UIKit

struct ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
