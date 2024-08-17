//
//  MealDBEndpoint.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import Foundation

enum MealDBEndpoint {
    case getMealsWithCategory(category: MealDBCategory)
    case getMealDetailsById(id: String)
    
    var rawValue: String {
        switch self {
        case .getMealsWithCategory(let category):
            return "/filter.php/?c=\(category.rawValue)"
        case .getMealDetailsById(let id):
            return "/lookup.php?i=\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMealsWithCategory, .getMealDetailsById:
            return .GET
        }
    }
}
