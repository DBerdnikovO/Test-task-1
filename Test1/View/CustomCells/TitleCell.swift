//
//  ada.swift
//  Test1
//
//  Created by Данила Бердников on 25.08.2022.
//

import UIKit
import Kingfisher

class TitleCell: UICollectionReusableView,  SelfConfigCell {
    
     
    
    static var reusedId: String = "Header"
    
    let castHeader: UILabel = {
        let label = UILabel()
        label.text = "Casts"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .titleColor()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let title: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 40)
            label.textAlignment = .center
            label.textColor = .black
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let overview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .natural
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 20
        return label
    }()
    
    let details: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .dateColor()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let posterImage = UIImageView()
    let gradientView = Gradient(from: .top, to: .bottom, startColor: #colorLiteral(red: 0.2955428362, green: 0.2955428362, blue: 0.2955428362, alpha: 1), endColor: .backgroundColor())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraints()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let header: Title = value as? Title else {return}

        details.text = reFormat(from: (header.release_date ?? header.first_air_date) ?? "ERROR")
        title.text = header.title ?? header.original_name
        overview.text = header.overview
        DispatchQueue.main.async {
            self.posterImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(header.backdrop_path ?? "")"))
            self.posterImage.contentMode = .scaleAspectFill
        }
    }
    

    
    private func setupContraints() {
        posterImage.sizeToFit()
        posterImage.clipsToBounds = true
        
        title.textColor = .titleColor()
        
        overview.textColor = .dateColor()
        self.setNeedsLayout()
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        posterImage.backgroundColor = .red
        
        addSubview(posterImage)
        addSubview(gradientView)
        addSubview(title)
        addSubview(details)
        addSubview(overview)
        addSubview(castHeader)
        
        NSLayoutConstraint.activate([
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            posterImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            posterImage.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: -10),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: gradientView.topAnchor),
            title.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 20),
            details.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
       
        NSLayoutConstraint.activate([
            castHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            castHeader.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: details.bottomAnchor, constant: 5),
            overview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            overview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            overview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
    }
    
    func reFormat(from dateStr: String) -> String? {
      let fromFormatter = DateFormatter()
      fromFormatter.dateFormat = "yyyy-MM-dd"

      let toFormatter = DateFormatter()
        toFormatter.locale = Locale(identifier: "en_US_POSIX")
      toFormatter.dateFormat = "yyyy"

        
        
        
        
      guard let date = fromFormatter.date(from: dateStr) else { return nil }

      return toFormatter.string(from: date)
    }
}
