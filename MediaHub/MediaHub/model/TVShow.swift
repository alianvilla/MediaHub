//
//  TVShow.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import Foundation

struct TVShow: Media {
    var releaseDate: String
    
    var genres: [Genre]?
    var originCountry: [String]?
    var originalLanguage: String?
    var productionCompanies: [ProductionCompany]?
    var runtime: Int?
    var type: String? // "Scripted"
    var lastAirDate: String?
    var networks: [Network]?
    var numberOfSeasons: Int?
    var numeroDeEpisodios: Int?
    var status: String?
    var mediaType: String? = "tv"
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity, genres, runtime, status, type, networks
        case title = "name"
        case releaseDate = "first_air_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case productionCompanies = "production_companies"
        case lastAirDate = "last_air_date"
        case numberOfSeasons = "number_of_seasons"
        case numeroDeEpisodios = "numero_de_episodios"
    }
}
