//
//  MealDetailView.swift
//  Meal DB
//
//  Created by DJ A on 8/17/24.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(MealsManager.self) private var mealsManager
    
    let meal: Meal
    
    var body: some View {
        let details = mealsManager.selectedMealDetails
        
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(details?.name ?? "No name available")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                Text("Instructions")
                    .bold()
                Text(details?.instructions ?? dummyInstructions)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                
                Text("Ingredients")
                    .bold()
                ForEach(details?.ingredients.sorted(by: >) ?? MealDetail.testIngredients, id: \.key) { ingredient, measurement in
                    Text("\(ingredient) - \(measurement)")
                        .font(.system(size: 14))
        
                }
            }
            .redacted(reason: details == nil ? .placeholder : [])
        }
        
        .padding()
        .task {
            mealsManager.fetchMealDetails(mealId: meal.id)
        }
    }
    
    private let dummyInstructions = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}

#Preview {
    MealDetailView(meal: Meal.testMeal)
        .environment(MealsManager(mealService: MealDBService()))
}
