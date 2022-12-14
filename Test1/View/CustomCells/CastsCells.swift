//
//  CastCells.swift
//  Test1
//
//  Created by Данила Бердников on 24.08.2022.
//

import UIKit
import Kingfisher

final class CastsCells: UICollectionViewCell, SelfConfigCell {
    
    static var reusedId: String = "CastCells"
    
    let avatarImage : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameActor: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            label.textAlignment = .center
        label.textColor = .titleColor()
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let roleActor: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
    label.textColor = .titleColor()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraints()

        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let cast: CastResult = value as? CastResult else {return}

        roleActor.text = cast.character
        roleActor.textColor = .dateColor()
        nameActor.text = cast.name

        avatarImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(cast.profile_path ?? "")"))
        avatarImage.contentMode = .scaleAspectFill
        
    }
    private func setupContraints() {
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImage)
        addSubview(nameActor)
        addSubview(roleActor)
        
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        NSLayoutConstraint.activate(([
            nameActor.topAnchor.constraint(equalTo: avatarImage.bottomAnchor,constant: 5),
            nameActor.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameActor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ]))
        NSLayoutConstraint.activate([
            roleActor.bottomAnchor.constraint(equalTo: self.bottomAnchor),
           // roleActor.topAnchor.constraint(equalTo: nameActor.bottomAnchor),
            roleActor.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            roleActor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    
    }
    
    
}
