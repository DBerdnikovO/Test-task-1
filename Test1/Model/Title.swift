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
    let id: Int
    let title: String?
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let vote_average: Double?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Title, rhs: Title) -> Bool {
        return lhs.id == rhs.id
    }
}
