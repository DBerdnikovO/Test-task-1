//
//  FavoriteViewController.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getCount())
    }

    func getCount() -> Int {
        return FavoritsDelegate.shared.getCast().count
    }
}
