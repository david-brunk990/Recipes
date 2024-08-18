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
                if mealsManager.state == .fetchDessertsError {
                    Banner(title: "Error getting desserts", bannerColor: .red) {
                        withAnimation {
                            mealsManager.state = .normal
                        }
                    }
                    .unredacted()
                }
                List {
                    ForEach(mealsManager.desserts ?? Meal.testMeals, id: \.self) { dessert in
                        NavigationLink(destination: MealDetailView(meal: dessert).environment(mealsManager)) {
                            DessertsListCell(meal: dessert)
                        }
                    }
                    .listRowBackground(BrandColor.background)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .redacted(reason: mealsManager.desserts == nil ? .placeholder : [])
            .task {
                mealsManager.fetchDesserts()
            }
            .padding([.leading, .trailing], 8)
            .background(BrandColor.background)
            .navigationTitle("Desserts")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    DessertsView()
}
