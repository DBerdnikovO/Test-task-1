//
//  CastCells.swift
//  Test1
//
//  Created by Данила Бердников on 24.08.2022.
//

import UIKit
import Kingfisher

class CastCells: UICollectionViewCell, SelfConfigCell {
    
    static var reusedId: String = "CastCells"
    
    let avatarImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraints()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let cast: CastResult = value as? CastResult else {return}

        DispatchQueue.main.async {
            self.avatarImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(cast.profile_path ?? "")"))
        }
    }
    private func setupContraints() {
        avatarImage.sizeToFit()
        avatarImage.clipsToBounds = true
        
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 10
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false

        avatarImage.backgroundColor = .red
        
        addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            avatarImage.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

       
    }
    
    
}
