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
        
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(favorit.title?.poster_path ?? "")"))
        }
    }
    
    private func setupContraints() {
        movieImageView.sizeToFit()
        movieImageView.clipsToBounds = true
        
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 10
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.backgroundColor = .red
        
        addSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            //movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
    }
    
    
}
