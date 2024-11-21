//
//  Endpoint.swift
//
//  Created by DJ A on 11/18/24.
//

import Foundation

enum Endpoint {
    case recipes, recipesMalformed, recipesEmpty
    
    var rawValue: String {
        switch self {
        case .recipes:
            return "/recipes.json"
        case .recipesMalformed:
            return "/recipes-malformed.json"
        case .recipesEmpty:
            return "/recipes-empty.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .recipes, .recipesEmpty, .recipesMalformed:
            return .GET
        }
    }
}
