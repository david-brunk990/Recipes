
import Foundation
@testable import Recipes

enum RecipeServiceMockResult {
    case success, failure
}

class RecipeServiceMock: RecipeServiceProtocol {
    var result: RecipeServiceMockResult!
    
    func getRecipes() async throws -> [Recipe] {
        switch result {
        case .success:
            return Recipe.testData
        case .failure, .none:
            throw RecipeServiceError.unknown
        }
    }
}
