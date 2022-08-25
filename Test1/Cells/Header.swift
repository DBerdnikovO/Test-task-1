//
//  ada.swift
//  Test1
//
//  Created by Данила Бердников on 25.08.2022.
//

import UIKit
import Kingfisher

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    static var toString: String {
        return String(describing: self)
    }
    
    let posterIamge = UIImageView()
    
    static let id = HeaderCollectionReusableView.toString
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    func configure(poster: String) {
        print(poster)
        posterIamge.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(poster)"))
        backgroundColor = .green
        posterIamge.sizeToFit()
        posterIamge.clipsToBounds = true
        
        posterIamge.layer.masksToBounds = true
        posterIamge.layer.cornerRadius = 10
        
        posterIamge.translatesAutoresizingMaskIntoConstraints = false
        addSubview(posterIamge)
        
        NSLayoutConstraint.activate([
            posterIamge.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterIamge.heightAnchor.constraint(equalTo: self.heightAnchor),
            posterIamge.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}
