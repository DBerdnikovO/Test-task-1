//
//  Cast.swift
//  Test1
//
//  Created by Данила Бердников on 22.08.2022.
//

import Foundation

struct Cast: Hashable, Codable {

    
    let cast : [CastResult]
}

struct CastResult:  Hashable, Codable {
    
    let id: Int
    let name: String?
    let profile_path: String?
    let character: String?
    
    static func == (lhs: CastResult, rhs: CastResult) -> Bool {
        return lhs.id == rhs.id
    }
    
}
