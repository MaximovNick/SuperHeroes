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
    
    // MARK: - Private Properties
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
        createLabel(title: "Biography", size: 18, color: .red, textAlignment: .center)
    }()
    
    private lazy var biographyLabel: UILabel = {
        createLabel(size: 14, color: .white, textAlignment: .left)
    }()
    
    private lazy var statsTitleLabel: UILabel = {
        createLabel(title: "Power Stats", size: 18, color: .red, textAlignment: .center)
    }()
    
    private lazy var powerStatsLabel: UILabel = {
        createLabel(size: 14, color: .white, textAlignment: .left)
    }()
    
    private lazy var appearanceTitleLabel: UILabel = {
        createLabel(title: "Appearance", size: 18, color: .red, textAlignment: .center)
    }()
    
    private lazy var appearanceLabel: UILabel = {
        createLabel(title: "", size: 14, color: .white, textAlignment: .left)
    }()
    
    private lazy var workTitleLabel: UILabel = {
        createLabel(title: "Work", size: 18, color: .red, textAlignment: .center)
    }()
    
    private lazy var workLabel: UILabel = {
        createLabel(size: 14, color: .white, textAlignment: .left)
    }()
    
    private lazy var connectionsTitleLabel: UILabel = {
        createLabel(title: "Connections", size: 18, color: .red, textAlignment: .center)
    }()
    
    private lazy var connectionLabel: UILabel = {
        createLabel(size: 14, color: .white, textAlignment: .left)
    }()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = hero.name
        view.backgroundColor = .black
        setupSubviews()
        setConstraints()
        fetchImage(from: hero.images.md)
    }
    
    // MARK: - Private Methods
    private func createLabel(title: String? = nil, size: CGFloat, color: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.textColor = color
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
