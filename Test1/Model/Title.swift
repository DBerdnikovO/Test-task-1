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
    let backdrop_path: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let vote_average: Double?
    let first_air_date: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Title, rhs: Title) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: Int = 0,title: String? = nil,  media_type: String? = nil, backdrop_path: String? = nil,
    original_name: String? = nil,original_title: String? = nil,  poster_path: String? = nil, overview: String? = nil,
         vote_count: Int? = nil, release_date: String? = nil, vote_average: Double? = nil, first_air_date: String? = nil) {
        
        self.id = id
        self.title = title
        self.media_type = media_type
        self.backdrop_path = backdrop_path
        self.original_name = original_name
        self.original_title = original_title
        self.poster_path = poster_path
        self.overview = overview
        self.vote_count = vote_count
        self.release_date = release_date
        self.vote_average = vote_average
        self.first_air_date = first_air_date
    }
}
