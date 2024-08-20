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
                    errorBanner
                }
                dessertsStack
            }
            .redacted(reason: mealsManager.desserts == nil ? .placeholder : [])
            .task {
                await mealsManager.fetchDesserts()
            }
            .padding([.leading, .trailing], 8)
            .background(BrandColor.background)
            .navigationTitle("Desserts")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

// MARK: Subviews
extension DessertsView {
    private var errorBanner: some View {
        Banner(title: "Error getting desserts", bannerColor: .red) {
            withAnimation {
                mealsManager.state = .normal
            }
        }
        .unredacted()
    }
    
    private var dessertsStack: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(mealsManager.desserts?.sorted(by: { $0.name < $1.name }) ?? Meal.testMeals, id: \.self) { dessert in
                    NavigationLink(destination: MealDetailView(meal: dessert).environment(mealsManager)) {
                        DessertsListCell(meal: dessert)
                    }
                }
            }
            .foregroundStyle(.black)
            .padding()
        }
        .refreshable {
            await mealsManager.fetchDesserts()
        }
    }
}

#Preview {
    DessertsView()
}
