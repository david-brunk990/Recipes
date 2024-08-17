//
//  DessertsView.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import SwiftUI

struct DessertsView: View {
    @State private var mealsManager = MealsManager(mealService: MealDBService())
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Desserts")
                    .font(.largeTitle)
                if let desserts = mealsManager.desserts {
                    List {
                        ForEach(desserts, id: \.self) { dessert in
                            NavigationLink(destination: MealDetailView(meal: dessert).environment(mealsManager)) {
                                Text(dessert.name)
                                
                            }
                            .isDetailLink(true)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text("No desserts available")
                    Spacer()
                }
            }
            .task {
                mealsManager.fetchDesserts()
            }
            .padding()
        }
        
    }
}

#Preview {
    DessertsView()
}
