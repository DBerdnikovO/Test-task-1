//
//  FavoritsDelegate.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import Foundation

class FavoritsDelegate {
    
    static let shared = FavoritsDelegate()
    
    var cast : [Cast:Int] = [:]

    init() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCast(newCast: Cast) {
        cast[newCast] = newCast.title?.id
    }
    
    func getIdFav() -> [Int] {
        return Array(cast.values)
    }
    
    func getCast() -> [Cast] {
        return Array(cast.keys)
    }
    
    func deleteFav(deletecast: Cast) {
        for key in cast.keys{
            if key == deletecast {
                cast.removeValue(forKey: key)
            }
        }
    }
    
}
