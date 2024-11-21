
import Testing
@testable import Recipes

struct RecipesManagerTests {
    var service: RecipeServiceMock!
    var manager: RecipesManager!
    
    init() {
        service = RecipeServiceMock()
        manager = RecipesManager(recipeService: service, imageCache: ImageCacheManager.instance)
    }
    
    @Test func recipesManager_fetchRecipes_success() async {
        service.result = .success
        await manager.fetchRecipes()
        #expect(manager.recipes == Recipe.testData)
    }
    
    @Test func recipesManager_fetchRecipes_failure() async {
        service.result = .failure
        await manager.fetchRecipes()
        #expect(manager.recipes == [])
        #expect(manager.state == .fetchRecipesError)
    }
}
