//
//  API Caller.swift
//  Test1
//
//  Created by Данила Бердников on 19.08.2022.
//

import Foundation
import UIKit

struct Constants {
    static let API_KEY = "9f7d9a831f24d1724a6e9223c68b502c"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<Video, Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Video.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTVs(completion: @escaping (Result<Video, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Video.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    

    func getCast(id: String, type: String, completion: @escaping (Result<Cast, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(type)/\(id)/credits?api_key=9f7d9a831f24d1724a6e9223c68b502c") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Cast.self, from: data)
                completion(.success(results))

            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }

        task.resume()
    }

}
