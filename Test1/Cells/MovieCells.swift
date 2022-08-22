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
    
    //Название
    //Дата выхода
    let title = UILabel(text: "title")
    let date = UILabel(text: "date")
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
        guard let movie: Title = value as? Title else {return}
        title.text = movie.original_title
        title.textColor = .titleColor()
        
        date.text = reFormat(from: movie.release_date ?? "ERROR")
        date.textColor = .dateColor()
        
        movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path!)"))
    }
    
    private func setupContraints() {
        movieImageView.sizeToFit()
        movieImageView.clipsToBounds = true
        
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 10
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.backgroundColor = .red
        
        addSubview(movieImageView)
        addSubview(title)
        addSubview(date)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 200),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: movieImageView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: title.bottomAnchor),
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func reFormat(from dateStr: String) -> String? {
      let fromFormatter = DateFormatter()
      fromFormatter.dateFormat = "yyyy-MM-dd"

      let toFormatter = DateFormatter()
        toFormatter.locale = Locale(identifier: "en_US_POSIX")
      toFormatter.dateFormat = "MMM d, yyyy"

        
        
        
        
      guard let date = fromFormatter.date(from: dateStr) else { return nil }

      return toFormatter.string(from: date)
    }

    
    
}
