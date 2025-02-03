//
//  Movie.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import Foundation

struct Movie: Media {
    var status: String?
    
    
    var genres: [Genre]?
    var originCountry: [String]?
    var originalLanguage: String?
    var productionCompanies: [ProductionCompany]?
    var runtime: Int?
    var mediaType: String? = "movie"
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity, genres, runtime, status
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case productionCompanies = "production_companies"
    }
}


