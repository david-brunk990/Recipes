//
//  MealDBServiceMock.swift
//  Meal DBTests
//
//  Created by DJ A on 8/19/24.
//

import Foundation
@testable import Meal_DB

enum MealDBServiceMockResult {
    case success, failure
}

class MealDBServiceMock: MealDBServiceProtocol {
    var result: MealDBServiceMockResult!
    
    func getMealsWithCategory(category: Meal_DB.MealDBCategory) async throws -> [Meal_DB.Meal] {
        switch result {
        case .failure:
            throw MealDBServiceError.unknown
        case .success:
            return Meal.testMeals
        case .none:
            throw MealDBServiceError.unknown
        }
    }
    
    func getMealDetailsById(id: String) async throws -> Meal_DB.MealDetail {
        switch result {
        case .success:
            return MealDetail.testMealDetail
        case .failure:
            throw MealDBServiceError.unknown
        case .none:
            throw MealDBServiceError.unknown
        }
    }
    
    
}
