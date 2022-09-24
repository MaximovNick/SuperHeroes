//
//  NetworkManager.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchData(completion: @escaping(Result<[Hero], NetworkError>) -> Void) {
        guard let url = URL(string: "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let superheroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(superheroes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    
        func fetchImageData(from url: String?) -> Data? {
            guard let url = URL(string: url ?? "") else { return nil }
            guard let imageData = try? Data(contentsOf: url) else { return nil }
            return imageData
        }
    }
    
    
 

