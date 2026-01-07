//
//  MovieService.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import Foundation

let BASE_URL = "https://api.themoviedb.org/3/movie"
let API_KEY = "57d960071f3e257046db9988950a4280"

let THUMBNAIL_BASE_URL = "https://image.tmdb.org/t/p/w500"

protocol MovieServiceProtocol: Sendable {
    func getMovies(endPoint: APIEndPoints) async throws -> Movie?
    func getMovie(id: Int, type: VideoType) async throws -> MovieItem?
}

struct MovieService: MovieServiceProtocol, @unchecked Sendable {
    func getMovies(endPoint: APIEndPoints) async throws -> Movie? {
        guard let url = try getMoviesURLString(type: endPoint) else {
            throw AuthErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
//        print(String(data: data, encoding: .utf8))
        try validateREsponse(response)
        
        
        do {
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decorder.decode(Movie.self, from: data)
        } catch  {
            throw AuthErrors.invalidResponse
        }
    }

    func getMovie(id: Int, type: VideoType) async throws -> MovieItem? {
        guard let url = try getMovieDetailsURLString(id: id, type: type) else {
            throw AuthErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateREsponse(response)
        
        do {
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            return try decorder.decode(MovieItem.self, from: data)
        } catch  {
            throw AuthErrors.invalidJSON
        }
    }
}

extension MovieService {
   
    private func validateREsponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AuthErrors.invalidURL
        }
    }
    
    private func buildURLComponents() throws -> URLComponents {
        guard var components = URLComponents(string: BASE_URL) else {
            throw AuthErrors.invalidURL
        }
        components.path = "/3"
        components.queryItems = [
            .init(name: "api_key", value: API_KEY)
        ]
        return components
    }
    
    private func getMoviesURLString(type: APIEndPoints) throws -> URL? {
        do {
            var components = try buildURLComponents()
            components.path += type.path
            return components.url
        } catch  {
            throw AuthErrors.invalidURL
        }
    }
    
    private func getMovieDetailsURLString(id: Int, type: VideoType) throws -> URL? {
        
        do {
            var components = try buildURLComponents()
            components.path += type == .movie ? "/movie/\(id)" : "/tv/\(id)"
            components.queryItems?
                .append(.init(name: "append_to_response", value: "videos"))
            return components.url
        } catch  {
            throw AuthErrors.invalidURL
        }
    }
}

enum APIEndPoints: String, Sendable {
    case nowPlaying = "/movie/now_playing"
    case popular = "/movie/popular"
    case topRated = "/movie/top_rated"
    case upcoming = "/movie/upcoming"
    case tv = "/tv/top_rated"
    case tvToday = "/tv/airing_today"
    
    var path: String { rawValue }
}


enum VideoType {
    case movie
    case tv 
}
