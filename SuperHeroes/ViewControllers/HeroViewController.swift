//
//  HeroViewController.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import UIKit

class HeroViewController: UIViewController {
    
    // MARK: - Private properties
    private var heroes: [Hero] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeroViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        
        setConstraints()
        setCollectionViewDelegates()
        setupNavigationBar()
        fetchHeroes()
    }
    
    // MARK: - Private Methods
    private func setCollectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        
        title = "FIND YOUR HERO"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.font: UIFont(name: "Chalkduster", size: 20) ?? "", .foregroundColor: UIColor.red]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
    
    private func fetchHeroes() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HeroViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HeroViewCell else { return UICollectionViewCell() }
        
        let hero = heroes[indexPath.row]
        
        cell.backgroundColor = .black
        cell.configure(with: hero)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heroes[indexPath.row]
        let powerStatsVC = AboutHeroViewController()

        navigationController?.pushViewController(powerStatsVC, animated: true)
        powerStatsVC.hero = hero 
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HeroViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - Constraints
extension HeroViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
