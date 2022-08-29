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
    
    var like: Bool?
    
    let id: Int

    var overview: String?
    let title: String?
    let original_title: String?
    let profile_path: String?
    var castInfo: [CastResult]?
    let character: String?
    let name: String
    let first_air_date: String?
    
    static func == (lhs: CastResult, rhs: CastResult) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
