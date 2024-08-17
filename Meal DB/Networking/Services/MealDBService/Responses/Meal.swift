//
//  Meal.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import Foundation

struct Meal: Codable, Hashable {
    let name: String
    let thumbnailUrl: String
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnailUrl = "strMealThumb"
        case id = "idMeal"
    }
}
