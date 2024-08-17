//
//  MealsManager.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import Foundation

@Observable
class MealsManager {
    
    private let mealService: MealDBServiceProtocol
    
    var desserts: [Meal]? = nil
    var selectedMealDetails: MealDetail? = nil
    
    init(mealService: MealDBServiceProtocol) {
        self.mealService = mealService
    }
}

extension MealsManager {
    
    @MainActor
    func fetchDesserts() {
        Task {
            do {
                let desserts = try await mealService.getMealsWithCategory(category: .Dessert)
                self.desserts = desserts
            } catch (let error) {
                print("Error getting desserts: \(error)")
            }
        }
    }
    
    @MainActor
    func fetchMealDetails(mealId: String) {
        Task {
            do {
                let details = try await mealService.getMealDetailsById(id: mealId)
                self.selectedMealDetails = details
            } catch (let error) {
                print("Error getting meal details: \(error)")
            }
        }
    }
}
