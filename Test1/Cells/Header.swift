//
//  ada.swift
//  Test1
//
//  Created by Данила Бердников on 25.08.2022.
//

import UIKit
import Kingfisher

class HeaderCollectionReusableView: UICollectionReusableView,  SelfConfigCell {
    
     
    
    static var reusedId: String = "Header"
    
//    var backButton: UIButton = {
//
//        var button = UIButton()
//        button.backgroundColor = .systemRed
//        button.setTitle("Watch Now", for: .normal)
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        return button
//    }()
    
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
    
//    let backButton: UIButton = {
//       let button = UIButton()
//
//        let image = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image , for: .normal)
//        button.tintColor = .red
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    let posterImage = UIImageView()
    let gradientView = Gradient(from: .top, to: .bottom, startColor: #colorLiteral(red: 0.2955428362, green: 0.2955428362, blue: 0.2955428362, alpha: 1), endColor: .backgroundColor())
  //  let navigationView = Gradient(from: .top, to: .bottom, startColor: #colorLiteral(red: 0.65625, green: 0.65625, blue: 0.65625, alpha: 1), endColor: UIColor(white: 0.1, alpha: 0.1))
    
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

        title.text = header.title ?? header.original_name ?? "NO OVERVIEW"
        overview.text = header.overview
        DispatchQueue.main.async {
            self.posterImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(header.backdrop_path ?? "")"))
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
    
    private func setupContraints() {
        posterImage.sizeToFit()
        posterImage.clipsToBounds = true
        
        title.textColor = .titleColor()
        
        overview.textColor = .dateColor()
        self.setNeedsLayout()
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
      //  navigationView.translatesAutoresizingMaskIntoConstraints = false
        
        posterImage.backgroundColor = .red
        
        addSubview(posterImage)
        addSubview(gradientView)
        addSubview(title)
        addSubview(overview)
        addSubview(castHeader)
     //   addSubview(navigationView)
      //  addSubview(backButton)
        
        NSLayoutConstraint.activate([
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            posterImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            posterImage.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            navigationView.topAnchor.constraint(equalTo: self.topAnchor),
//            navigationView.widthAnchor.constraint(equalTo: self.widthAnchor),
//            navigationView.heightAnchor.constraint(equalToConstant: 60)
//        ])
        
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
            castHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            castHeader.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: title.bottomAnchor),
            overview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            overview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            overview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
    }
    
}
