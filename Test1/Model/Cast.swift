//
//  Cast.swift
//  Test1
//
//  Created by Данила Бердников on 22.08.2022.
//

import Foundation

struct Cast: Hashable, Codable {

    
    var cast: [CastResult]?
    var title: Title?
    
    
    public init(title model: Title?, cast: [CastResult]?) {
        
        self.cast = cast
        self.title = model
    }
    
}

struct CastResult: Hashable, Codable {
    
    
    let id: Int

    let title: String?
    let profile_path: String?
    let character: String?
    let name: String
    
    static func == (lhs: CastResult, rhs: CastResult) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
