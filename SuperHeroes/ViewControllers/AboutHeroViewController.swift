//
//  AboutHeroViewController.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 08.10.2022.
//

import UIKit

class AboutHeroViewController: UIViewController {
    
    var hero: Hero!
    
    private let heroImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var biographyButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Biography", attributes:  attributes)
        buttonConfiguration.baseBackgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        return UIButton(configuration: buttonConfiguration, primaryAction: UIAction { _ in
        })
        
    }()
    
    private var appearanceButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Appearance", attributes:  attributes)
        buttonConfiguration.baseBackgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        return UIButton(configuration: buttonConfiguration, primaryAction: UIAction { _ in
        })
        
    }()
    
    private var powerStatsButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Show power stats", attributes:  attributes)
        buttonConfiguration.baseBackgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        return UIButton(configuration: buttonConfiguration, primaryAction: UIAction { _ in
        })
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = hero.name
        
        setupSubviews()
        setConstraints()
        fetchImage(from: hero.images.md)
    }
    
    private func setupSubviews() {
        view.addSubview(heroImageView)
        view.addSubview(appearanceButton)
        view.addSubview(biographyButton)
        view.addSubview(powerStatsButton)
    }
    
    private func fetchImage(from url: String) {
        guard let url = URL(string: url) else { return }
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                self.heroImageView.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            heroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            heroImageView.heightAnchor.constraint(equalToConstant: 400),
        ])
        
        biographyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            biographyButton.bottomAnchor.constraint(equalTo: appearanceButton.topAnchor, constant: -20),
            biographyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            biographyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            biographyButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        appearanceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appearanceButton.bottomAnchor.constraint(equalTo: powerStatsButton.topAnchor, constant: -20),
            appearanceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            appearanceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            appearanceButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        powerStatsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            powerStatsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            powerStatsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            powerStatsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            powerStatsButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
