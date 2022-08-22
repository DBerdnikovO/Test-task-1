//
//  UIStackView.swift
//  Test1
//
//  Created by Данила Бердников on 23.08.2022.
//

import Foundation
import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        
    }
}
