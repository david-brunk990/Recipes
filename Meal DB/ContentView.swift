//
//  ContentView.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var mealsManager = MealsManager(mealService: MealDBService())
    
    var body: some View {
        VStack {
            Text("Desserts")
                .font(.largeTitle)
            if let desserts = mealsManager.desserts {
                List {
                    ForEach(desserts, id: \.self) { dessert in
                        Text(dessert.name)
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

#Preview {
    ContentView()
}
