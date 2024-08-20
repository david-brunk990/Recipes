//
//  MealDetailView.swift
//  Meal DB
//
//  Created by DJ A on 8/17/24.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(MealsManager.self) private var mealsManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let meal: Meal
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .topLeading) {
                    if let url = URL(string: meal.thumbnailUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(4)
                        } placeholder: {
                            ZStack {
                                Color.gray.opacity(0.4).shadow(radius: 3, x: 3, y: 3)
                                ProgressView()
                            }
                        }
                    }
                    VStack {
                        HStack {
                            backButton
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            mealNameText
                            Spacer()
                        }
                    }
                    .padding(.top, 60)
                    .padding([.bottom, .leading])
                    
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    if mealsManager.state == .fetchMealDetailsError {
                        errorBanner
                    }
                    ingredientsTitleText
                    ingredients
                    Divider()
                    
                    instructionsTitleText
                    instructions

                }
                .padding([.top, .leading, .trailing])
            }
            .redacted(reason: mealsManager.selectedMealDetails == nil ? .placeholder : [])
        }
        .background(BrandColor.background)
        .navigationBarHidden(true)
        .scrollIndicators(.hidden)
        .onDisappear {
            mealsManager.resetMealDetails()
        }
        .task {
            await mealsManager.fetchMealDetails(mealId: meal.id)
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private let dummyInstructions = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}

// MARK: Subviews
extension MealDetailView {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.backward.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .shadow(radius: 2, x: 2, y: 2)
        }
        .unredacted()
    }
    
    private var mealNameText: some View {
        Text(meal.name)
            .bold()
            .font(.title)
            .foregroundStyle(.white)
            .shadow(radius: 2, x: 2, y: 2)
    }
    
    private var errorBanner: some View {
        Banner(title: "Error fetching dessert details", bannerColor: .red) {
            withAnimation {
                mealsManager.state = .normal
            }
        }
        .unredacted()
    }
    
    private var ingredientsTitleText: some View {
        Text("Ingredients")
            .bold()
    }
    
    private var ingredients: some View {
        ForEach(mealsManager.selectedMealDetails?.ingredients.sorted(by: >) ?? MealDetail.testIngredients, id: \.key) { ingredient, measurement in
            Text("- \(measurement) \(ingredient)")
                .font(.system(size: 14))
        }
    }
    
    private var instructionsTitleText: some View {
        Text("Instructions")
            .bold()
    }
    
    private var instructions: some View {
        Text(mealsManager.selectedMealDetails?.instructions ?? dummyInstructions)
            .lineSpacing(10)
            .font(.system(size: 14))
    }
}

#Preview {
    MealDetailView(meal: Meal.testMeal)
        .environment(MealsManager(mealService: MealDBService()))
}
