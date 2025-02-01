//
//  TVShow.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import Foundation

struct TVShow: Media {
    var mediaType: String?
    let id: Int
    let title: String
    let overview: String
    let firstAirDate: String
    let posterPath: String?
    let backdropPath: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity
        case title = "name"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }
}
