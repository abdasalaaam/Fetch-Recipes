//
//  RecipeModel.swift
//  Fetch-RecipeApp
//
//  Created by Abud Salem on 10/1/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    var id: String { uuid }
    let uuid: String
    let cuisine: String
    let name: String
    let photoURL: URL
    let photoURLSmall: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case cuisine = "cuisine"
        case name = "name"
        case photoURL = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}


