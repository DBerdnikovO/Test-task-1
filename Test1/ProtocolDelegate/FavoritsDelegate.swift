//
//  FavoritsDelegate.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import Foundation

class FavoritsDelegate {
    
    static let shared = FavoritsDelegate()
    
    lazy var cast : [Cast:Int] = [:]

    init() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCast(newCast: Cast) {
        cast[newCast] = 0
    }
    
    func getCast() -> [Cast] {
        return Array(cast.keys)
    }
    
}
