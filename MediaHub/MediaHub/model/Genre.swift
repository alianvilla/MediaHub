//
//  Genre.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import Foundation

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
