//
//  HeroViewCell.swift
//  SuperHeroes
//
//  Created by Nikolai Maksimov on 19.09.2022.
//

import UIKit

class HeroViewCell: UICollectionViewCell {
    
    var heroCellViewModel: HeroCellViewModelProtocol! {
        didSet {
            heroNameLabel.text = heroCellViewModel.heroNameLabel
            DispatchQueue.global().async { [unowned self] in
                guard let imageData = self.heroCellViewModel.heroImageData else { return }
                DispatchQueue.main.async {
                    self.heroImageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let heroNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Marker Felt Wide", size: 18)
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heroImageView.addSubview(activityIndicator)
        addSubview(heroImageView)
        addSubview(heroNameLabel)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setConstraints
extension HeroViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            heroNameLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 0),
            heroNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            heroNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            heroNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor)
        ])
    }
}
