//
//  Title.swift
//  Test1
//
//  Created by Данила Бердников on 19.08.2022.
//

import Foundation

struct Video: Hashable, Codable {

  let results: [Title]
}

struct Title: Hashable, Codable {
    var id: Int
    var title: String?
    var media_type: String?
    var backdrop_path: String?
    var original_name: String?
    var poster_path: String?
    var overview: String?
    var release_date: String?
    var vote_average: Double?
    var first_air_date: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Title, rhs: Title) -> Bool {
        return lhs.id == rhs.id
    }
    
}
