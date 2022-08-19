//
//  MovieCells.swift
//  Test1
//
//  Created by Данила Бердников on 19.08.2022.
//

import UIKit
import Kingfisher


class MovieCells: UICollectionViewCell, SelfConfigCell {
    static var reusedId: String = "MovieCell"
    
    let movieImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let movie: Title = value as? Title else {return}
        
      
        movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
        print( "https://image.tmdb.org/t/p/w500/\(movie.poster_path!)")
    }
    
    private func setupContraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.backgroundColor = .red
        
        addSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    
}
