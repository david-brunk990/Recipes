//
//  RecipesManager.swift
//
//  Created by DJ A on 8/16/24.
//

import SwiftUI

@Observable
class RecipesManager {
    
    private let recipeService: RecipeServiceProtocol
    private let imageCache: ImageCacheManager
    
    var recipes: [Recipe]? = nil
    var recipeImages: [String:Image]? = nil
    
    /**
     State property that is observed by views. If the property is set to any other value other than `.normal`, a 5 second `Timer` is invoked, after which the state is set to `.normal`
     */
    var state: RecipesManagerState = .normal {
        didSet {
            if state == .fetchRecipesError {
                let _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
                    self.state = .normal
                }
            }
        }
    }
    
    init(recipeService: RecipeServiceProtocol, imageCache: ImageCacheManager) {
        self.recipeService = recipeService
        self.imageCache = imageCache
    }
}

extension RecipesManager {
    
    @MainActor
    func fetchRecipes() async {
        state = .loading
        do {
            let recipes = try await recipeService.getRecipes()
            self.recipes = recipes
            if let recipeImages, !recipeImages.isEmpty {
                let recipesToCheck = recipes.filter { recipe in
                    !recipeImages.contains { (uuid, image) in
                        recipe.uuid == uuid
                    }
                }
                if !recipesToCheck.isEmpty { self.recipeImages = await imageCache.loadImages(recipes: recipesToCheck) }
                state = .normal
            } else {
                self.recipeImages = await imageCache.loadImages(recipes: recipes)
                state = .normal
            }
        } catch {
            self.recipes = []
            state = .fetchRecipesError
        }
    }
}
