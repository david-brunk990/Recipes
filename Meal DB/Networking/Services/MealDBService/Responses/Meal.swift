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
    
    static let testMeal = Meal(
        name: "Apple & Blackberry Crumble",
        thumbnailUrl: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
        id: "52893"
    )
    
    static let testMeals = [
        Meal(
            name: "Apple & Blackberry Crumble",
            thumbnailUrl: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
            id: "52893"),
        Meal(
            name: "Apam balik",
            thumbnailUrl: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
            id: "53049"
        )
    ]
}
