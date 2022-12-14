//
//  SectionHeader.swift
//  Test1
//
//  Created by Данила Бердников on 18.08.2022.
//


import UIKit

final class SectionHeader:UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([  title.topAnchor.constraint(equalTo: self.topAnchor),
                                       title.leadingAnchor.constraint(equalTo: self.leadingAnchor ),
                                       title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                       title.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                                    ] )
        
    }
    
    func configurate(text: String, font: UIFont?, textColor: UIColor?) {
        title.textColor = textColor
        title.font = font
        title.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
