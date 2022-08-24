//
//  Cast.swift
//  Test1
//
//  Created by Данила Бердников on 22.08.2022.
//

import Foundation

struct Cast: Hashable, Codable {

    
    var cast: [CastResult]
    
}

struct CastResult: Hashable, Codable {
    
    
    let id: Int
    let name: String?
    let profile_path: String?
    let character: String?
    var overview: String?
    let backdrop_path: String?
    
    static func == (lhs: CastResult, rhs: CastResult) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
