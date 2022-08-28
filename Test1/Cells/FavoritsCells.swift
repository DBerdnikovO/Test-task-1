//
//  FavoritsCells.swift
//  Test1
//
//  Created by Данила Бердников on 28.08.2022.
//

import Foundation
import UIKit
import Kingfisher

class FavoritsCells: UICollectionViewCell, SelfConfigCell {
    
    let title : UILabel = {
        let label = UILabel()
        label.textColor = .titleColor()
        return label
    }()
    
    let date : UILabel = {
        let label = UILabel()
        label.textColor = .titleColor()
        return label
    }()

    static var reusedId: String = "FavoritsCells"
    
    let movieImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraints()
        
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let favorit: Cast = value as? Cast else {return}
        
        
        title.text = favorit.title?.original_title ?? favorit.title?.original_name
        date.text = favorit.title?.first_air_date ?? favorit.title?.release_date
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(favorit.title?.poster_path ?? "")"))
        }
    }
    
    private func setupContraints() {
        movieImageView.sizeToFit()
        movieImageView.clipsToBounds = true
        
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 10
        
        title.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.backgroundColor = .red
        
        addSubview(movieImageView)
        addSubview(title)
        addSubview(date)
        
        NSLayoutConstraint.activate([
            //movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 150),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor,constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
}
