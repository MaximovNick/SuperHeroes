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
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
    private lazy var heroImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .center
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Biography"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
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
        contentView.addSubview(firstLabel)
        contentView.addSubview(biographyLabel)
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
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            firstLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        ])
        
    }
}
