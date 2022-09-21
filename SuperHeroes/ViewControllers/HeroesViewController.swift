//
//  HeroesViewController.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import UIKit

class HeroesViewController: UIViewController {
    
    // MARK: - Private properties
    private var heroes: [Hero] = [] {
        didSet {
            collectionView.reloadData()
            
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeroesViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FIND YOUR HERO"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.red]
        
        collectionView.backgroundColor = .black
        view.backgroundColor = .black
        view.addSubview(collectionView)
        setCollectionViewDelegates()
        setConstraints()
        fetchHeroes()
    }
    
    
    // Collection View Delegates
    private func setCollectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // Загрузка данных из сети
    private func fetchHeroes() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let superheroes):
                self.heroes = superheroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HeroesViewCell else { return UICollectionViewCell()}
        let hero = heroes[indexPath.row]
        cell.configure(with: hero)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let paddingWith = 20 * (itemsPerRow + 1)
        let availableWith = collectionView.frame.width - paddingWith
        let widthPerItem = availableWith / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}


// MARK: - setConstraints
extension HeroesViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
