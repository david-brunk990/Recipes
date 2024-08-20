//
//  MealsManagerTests.swift
//  Meal DBTests
//
//  Created by DJ A on 8/16/24.
//

import Testing
@testable import Meal_DB

struct MealsManagerTests {
    var service: MealDBServiceMock!
    var manager: MealsManager!
    
    init() {
        service = MealDBServiceMock()
        manager = MealsManager(mealService: service)
    }

    @Test func mealsManager_fetchDesserts_success() async {
        service.result = .success
        await manager.fetchDesserts()
        #expect(manager.desserts == Meal.testMeals)
    }
    
    @Test func mealsManager_fetchDesserts_failure() async {
        service.result = .failure
        await manager.fetchDesserts()
        #expect(manager.desserts == nil)
        #expect(manager.state == .fetchDessertsError)
    }
    
    @Test func mealsManager_fetchMealDetails_success() async {
        service.result = .success
        await manager.fetchMealDetails(mealId: "1")
        #expect(manager.selectedMealDetails == MealDetail.testMealDetail)
    }
    
    @Test func mealsManager_fetchMealDetails_failure() async {
        service.result = .failure
        await manager.fetchMealDetails(mealId: "1")
        #expect(manager.selectedMealDetails == nil)
        #expect(manager.state == .fetchMealDetailsError)
    }
}
