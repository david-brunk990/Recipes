//
//  RecipeServiceProtocol.swift
//
//  Created by DJ A on 8/16/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRecipes() async throws -> [Recipe]
}
