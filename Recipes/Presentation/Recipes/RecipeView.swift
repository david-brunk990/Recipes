//
//  DessertsView.swift
//
//  Created by DJ A on 8/16/24.
//

import SwiftUI

enum SortMethod: String, CaseIterable, Hashable {
    case cuisine, name
    
    var keyPath: KeyPath<Recipe, String> {
        switch self {
        case .cuisine:
            return \Recipe.cuisine
        case .name:
            return \Recipe.name
        }
    }
}

struct RecipeView: View {
    @State private var recipesManager = RecipesManager(recipeService: RecipeService(), imageCache: ImageCacheManager.instance)
    @State private var sortOrder: SortMethod = .name
    
    var body: some View {
        NavigationStack {
            VStack {
                if recipesManager.state == .fetchRecipesError {
                    errorBanner
                }
                recipesStack
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                ForEach(SortMethod.allCases, id: \.self) { sortMethod in
                                    Button {
                                        onClickSortMethod(newMethod: sortMethod)
                                    } label: {
                                        HStack {
                                            Text(sortMethod.rawValue.capitalized)
                                            if sortMethod == self.sortOrder {
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "arrow.up.arrow.down")
                            }
                        }
                    }
                    .redacted(reason: recipesManager.recipes == nil ? .placeholder : [])
            }
            .task {
                await recipesManager.fetchRecipes()
            }
            .padding([.leading, .trailing], 8)
            .background(BrandColor.background)
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

// MARK: Subviews
extension RecipeView {
    private var errorBanner: some View {
        Banner(title: "Error getting recipes", bannerColor: .red) {
            withAnimation {
                recipesManager.state = .normal
            }
        }
        .unredacted()
    }
    
    private var emptyList: some View {
        HStack {
            Spacer()
            Text("No Recipes Found")
                .font(.title)
                .foregroundStyle(BrandColor.textColor)
            Spacer()
        }
    }
    
    private var recipesStack: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                if let recipes = recipesManager.recipes {
                    if recipes.isEmpty {
                        emptyList
                    } else {
                        ForEach(recipesManager.recipes?.sorted(by: sortOrder.keyPath) ?? Recipe.testData, id: \.self) { recipe in
                            let image = recipesManager.recipeImages?.first(where: { (uuid, image) in
                                recipe.uuid == uuid
                            })
                            RecipeListCell(recipe: recipe, image: image?.value)
                        }
                    }
                }
            }
            .foregroundStyle(.black)
            .padding()
        }
        .refreshable {
            await recipesManager.fetchRecipes()
        }
    }
}

extension RecipeView {
    private func onClickSortMethod(newMethod: SortMethod) {
        sortOrder = newMethod
    }
}

#Preview {
    RecipeView()
}
