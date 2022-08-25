//
//  Footer.swift
//  Test1
//
//  Created by Данила Бердников on 25.08.2022.
//

import UIKit

final class FooterCollectionReusableView: UICollectionReusableView {
    
    static var toString: String {
        return String(describing: self)
    }
    static let id = FooterCollectionReusableView.toString
    
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
    
    
    func configure() {
        backgroundColor = .backgroundColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let button = UIButton(frame: CGRect(x: (self.frame.size.width - 180) / 2, y: 30,width: 180,height: 50))
        button.backgroundColor = .systemRed
         button.setTitle("Watch Now", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        addSubview(button)
    }
    
}
