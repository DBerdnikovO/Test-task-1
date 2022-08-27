//
//  FavoritCells.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import Foundation
import UIKit

class FavoritCells: UIViewController, SelfConfigCell {
    
    var castArray  = [Cast]()
    
    static var reusedId: String = "FavoritCell"
    
    func configure<U>(with value: U) where U : Hashable {
        guard let favorite: Cast = value as? Cast else {return}
        castArray.append(favorite)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(castArray)
    }
    
}
