//
//  MealDBServiceProtocol.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import Foundation

protocol MealDBServiceProtocol {
    func getMealsWithCategory(category: MealDBCategory) async throws -> [Meal]
    func getMealDetailsById(id: String) async throws -> MealDetail
}
