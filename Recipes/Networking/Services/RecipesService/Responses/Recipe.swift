//
//  Recipe.swift
//
//  Created by DJ A on 11/18/24.
//

import Foundation

struct Recipe: Codable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let uuid: String
    let youtubeUrl: String?
    
    static let testData: [Recipe] = [
        Recipe(cuisine: "cuisine", name: "name", uuid: "1234", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: ""),
        Recipe(cuisine: "cuisine", name: "name", uuid: "1234", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: ""),
        Recipe(cuisine: "cuisine", name: "name", uuid: "1234", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: ""),
        Recipe(cuisine: "cuisine", name: "name", uuid: "1234", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: ""),
        Recipe(cuisine: "cuisine", name: "name", uuid: "1234", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: ""),
    ]
    
    static let testRecipe = Recipe(cuisine: "cuisine", name: "name", uuid: "1234", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: "")

    init(cuisine: String, name: String, uuid: String, photoUrlLarge: String, photoUrlSmall: String, sourceUrl: String, youtubeUrl: String) {
        self.cuisine = cuisine
        self.name = name
        self.uuid = uuid
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
    
    private enum CodingKeys: String, CodingKey {
        case cuisine, name, uuid
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}
