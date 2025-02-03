//
//  ProductionCompany.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/3/25.
//

import Foundation

struct ProductionCompany: Codable, Identifiable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    
    // Custom decoding strategy
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        logoPath = try container.decodeIfPresent(String.self, forKey: .logoPath)

        // Handle single string OR array for `origin_country`
        if let singleValue = try? container.decode(String.self, forKey: .originCountry) {
            originCountry = [singleValue] // Convert to array
        } else {
            originCountry = try container.decode([String].self, forKey: .originCountry)
        }
    }
}
