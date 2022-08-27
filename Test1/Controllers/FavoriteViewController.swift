//
//  FavoriteViewController.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    static let shared = FavoriteViewController()
    
    var cast : [Cast:Int] = [:]

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCast(newCast: Cast) {
        cast[newCast] = 0
    }
    
    func getCast() {
        print(cast.count)
    }

}
