//
//  HeroesViewCell.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import UIKit

class HeroesViewCell: UICollectionViewCell {
    
    private var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Marker Felt Wide", size: 18)
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = .white
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private var imageURL: URL? {
        didSet {
            heroImageView.image = nil
            updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heroImageView.addSubview(activityIndicator)
        addSubview(heroImageView)
        addSubview(mainLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with hero: Hero) {
        mainLabel.text = hero.name
        imageURL = URL(string: hero.images.lg)
    }
    
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                if imageURL == self.imageURL {
                    self.heroImageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(cacheImage))
            return
        }
        
        // Download image from url
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - setConstraints
extension HeroesViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 0),
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor)
        ])
    }
}
