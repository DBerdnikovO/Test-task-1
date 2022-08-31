//
//  FavoritsCells.swift
//  Test1
//
//  Created by Данила Бердников on 28.08.2022.
//

import UIKit
import Kingfisher

final class FavoritsCells: UICollectionViewCell, SelfConfigCell {
    
    let title : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false

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
        
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let favorit: Cast = value as? Cast else {return}
        self.backgroundColor = .favoritBackgroundColor()
        
        title.text = favorit.title?.original_name ?? favorit.title?.title
        date.text = reFormat(from: (favorit.title?.first_air_date ?? favorit.title?.release_date) ?? "ERROR DATA")
        
          movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(favorit.title?.poster_path ?? "")"))
        movieImageView.contentMode = .scaleAspectFill
        
    }
    
    private func setupContraints() {
        movieImageView.sizeToFit()
        movieImageView.clipsToBounds = true
        
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 10
        
        date.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.backgroundColor = .red
        
        addSubview(movieImageView)
        addSubview(title)
        addSubview(date)
        
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 96),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            title.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            title.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
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
