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
    
    /**
     State property that is observed by views. If the property is set to any other value other than `.normal`, a 5 second `Timer` is invoked, after which the state is set to `.normal`
     */
    var state: MealsManagerState = .normal {
        didSet {
            if state != .normal {
                let _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
                    self.state = .normal
                }
            }
        }
    }
    
    init(mealService: MealDBServiceProtocol) {
        self.mealService = mealService
    }
    
    func resetMealDetails() {
        selectedMealDetails = nil
    }
}

extension MealsManager {
    
    /**
     Invokes a `MealDBServiceProtocol` to fetch all desserts from MealDB API and assign to `self.desserts`. If the request is not successful, `MealsManager.state` is set to `.fetchDessertsError`
     */
    @MainActor
    func fetchDesserts() {
        Task {
            do {
                let desserts = try await mealService.getMealsWithCategory(category: .Dessert)
                self.desserts = desserts
            } catch (let error) {
                print("Error fetching desserts: \(error)")
                state = .fetchDessertsError
            }
        }
    }
    
    /**
     Invokes a `MealDBServiceProtocol` to fetch details of a meal from MealDB API and assign to `self.selectedMealDetails`. If the request is not successful, `MealsManager.state` is set to `.fetchMealDetailsError`
     - Parameter mealId: A `String` representing the id of the meal
     */
    @MainActor
    func fetchMealDetails(mealId: String) {
        Task {
            do {
                let details = try await mealService.getMealDetailsById(id: mealId)
                self.selectedMealDetails = details
            } catch (let error) {
                print("Error fetching meal details: \(error)")
                state = .fetchMealDetailsError
            }
        }
    }
}
