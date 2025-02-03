//
//  Network.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/3/25.
//

import Foundation

struct Network: Codable, Identifiable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
