//
//  Media.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import Foundation


protocol Media: Codable, Identifiable {
    var id: Int { get }
    var title: String { get }
    var releaseDate: String { get }
    var overview: String { get }
    var popularity: Double { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    var mediaType: String? { get }
    var genres: [Genre]? {get}
    var originCountry: [String]? {get}
    var originalLanguage: String? {get}
    var productionCompanies: [ProductionCompany]? {get}
    var runtime: Int? {get}
    var status: String? {get}
}


struct MediaResponse<T: Media>: Codable {
    let results: [T]
}

typealias MediaCompletionHandler<T> = (Result<[T], Error>) -> Void


