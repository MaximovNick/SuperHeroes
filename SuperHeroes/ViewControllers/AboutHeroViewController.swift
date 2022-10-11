//
//  AboutHeroViewController.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 08.10.2022.
//

import UIKit

class AboutHeroViewController: UIViewController {
    
    var hero: Hero! {
        didSet {
            biographyLabel.text = hero.biography.biography
            powerStatsLabel.text = hero.powerstats.powerStats
            appearanceLabel.text = hero.appearance.appearance
            workLabel.text = hero.work.work
            connectionLabel.text = hero.connections.connections
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.contentSize = contentSize
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height - 60)
    }
    
    private lazy var heroImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .center
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var biographyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Biography"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Power Stats"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var powerStatsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var appearanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Appearance"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var appearanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var workTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Work"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var workLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var connectionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Connections"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var connectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = hero.name
        view.backgroundColor = .black
        setupSubviews()
        setConstraints()
        fetchImage(from: hero.images.md)
    }
    
    private func setupSubviews() {
        view.addSubview(heroImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(biographyTitleLabel)
        contentView.addSubview(biographyLabel)
        contentView.addSubview(statsTitleLabel)
        contentView.addSubview(powerStatsLabel)
        contentView.addSubview(appearanceTitleLabel)
        contentView.addSubview(appearanceLabel)
        contentView.addSubview(workTitleLabel)
        contentView.addSubview(workLabel)
        contentView.addSubview(connectionsTitleLabel)
        contentView.addSubview(connectionLabel)
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
}

// MARK: - Constraints
extension AboutHeroViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            heroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            heroImageView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            biographyTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            biographyTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            biographyTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: biographyTitleLabel.bottomAnchor, constant: 10),
            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            statsTitleLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 20),
            statsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            statsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            powerStatsLabel.topAnchor.constraint(equalTo: statsTitleLabel.bottomAnchor, constant: 10),
            powerStatsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            powerStatsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            appearanceTitleLabel.topAnchor.constraint(equalTo: powerStatsLabel.bottomAnchor, constant: 20),
            appearanceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            appearanceTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            appearanceLabel.topAnchor.constraint(equalTo: appearanceTitleLabel.bottomAnchor, constant: 10),
            appearanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            appearanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            workTitleLabel.topAnchor.constraint(equalTo: appearanceLabel.bottomAnchor, constant: 20),
            workTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            workTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            workLabel.topAnchor.constraint(equalTo: workTitleLabel.bottomAnchor, constant: 10),
            workLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            workLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            connectionsTitleLabel.topAnchor.constraint(equalTo: workLabel.bottomAnchor, constant: 20),
            connectionsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            connectionsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            connectionLabel.topAnchor.constraint(equalTo: connectionsTitleLabel.bottomAnchor, constant: 10),
            connectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            connectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
    }
}
