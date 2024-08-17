//
//  MealDetail.swift
//  Meal DB
//
//  Created by DJ A on 8/16/24.
//

import Foundation

struct MealDetail: Codable {
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let thumbnailUrl: String
    let sourceUrl: String
    
    // MARK: Ingredients
    let ingredient1: String
    let ingredient2: String
    let ingredient3: String
    let ingredient4: String
    let ingredient5: String
    let ingredient6: String
    let ingredient7: String
    let ingredient8: String
    let ingredient9: String
    let ingredient10: String
    let ingredient11: String
    let ingredient12: String
    let ingredient13: String
    let ingredient14: String
    let ingredient15: String
    let ingredient16: String
    let ingredient17: String
    let ingredient18: String
    let ingredient19: String
    let ingredient20: String
    
    // MARK: Measurements
    let measure1: String
    let measure2: String
    let measure3: String
    let measure4: String
    let measure5: String
    let measure6: String
    let measure7: String
    let measure8: String
    let measure9: String
    let measure10: String
    let measure11: String
    let measure12: String
    let measure13: String
    let measure14: String
    let measure15: String
    let measure16: String
    let measure17: String
    let measure18: String
    let measure19: String
    let measure20: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decode(String.self, forKey: .area)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl) ?? ""
        self.ingredient1 = try container.decodeIfPresent(String.self, forKey: .ingredient1) ?? ""
        self.ingredient2 = try container.decodeIfPresent(String.self, forKey: .ingredient2) ?? ""
        self.ingredient3 = try container.decodeIfPresent(String.self, forKey: .ingredient3) ?? ""
        self.ingredient4 = try container.decodeIfPresent(String.self, forKey: .ingredient4) ?? ""
        self.ingredient5 = try container.decodeIfPresent(String.self, forKey: .ingredient5) ?? ""
        self.ingredient6 = try container.decodeIfPresent(String.self, forKey: .ingredient6) ?? ""
        self.ingredient7 = try container.decodeIfPresent(String.self, forKey: .ingredient7) ?? ""
        self.ingredient8 = try container.decodeIfPresent(String.self, forKey: .ingredient8) ?? ""
        self.ingredient9 = try container.decodeIfPresent(String.self, forKey: .ingredient9) ?? ""
        self.ingredient10 = try container.decodeIfPresent(String.self, forKey: .ingredient10) ?? ""
        self.ingredient11 = try container.decodeIfPresent(String.self, forKey: .ingredient11) ?? ""
        self.ingredient12 = try container.decodeIfPresent(String.self, forKey: .ingredient12) ?? ""
        self.ingredient13 = try container.decodeIfPresent(String.self, forKey: .ingredient13) ?? ""
        self.ingredient14 = try container.decodeIfPresent(String.self, forKey: .ingredient14) ?? ""
        self.ingredient15 = try container.decodeIfPresent(String.self, forKey: .ingredient15) ?? ""
        self.ingredient16 = try container.decodeIfPresent(String.self, forKey: .ingredient16) ?? ""
        self.ingredient17 = try container.decodeIfPresent(String.self, forKey: .ingredient17) ?? ""
        self.ingredient18 = try container.decodeIfPresent(String.self, forKey: .ingredient18) ?? ""
        self.ingredient19 = try container.decodeIfPresent(String.self, forKey: .ingredient19) ?? ""
        self.ingredient20 = try container.decodeIfPresent(String.self, forKey: .ingredient20) ?? ""
        
        self.measure1 = try container.decodeIfPresent(String.self, forKey: .measure1) ?? ""
        self.measure2 = try container.decodeIfPresent(String.self, forKey: .measure2) ?? ""
        self.measure3 = try container.decodeIfPresent(String.self, forKey: .measure3) ?? ""
        self.measure4 = try container.decodeIfPresent(String.self, forKey: .measure4) ?? ""
        self.measure5 = try container.decodeIfPresent(String.self, forKey: .measure5) ?? ""
        self.measure6 = try container.decodeIfPresent(String.self, forKey: .measure6) ?? ""
        self.measure7 = try container.decodeIfPresent(String.self, forKey: .measure7) ?? ""
        self.measure8 = try container.decodeIfPresent(String.self, forKey: .measure8) ?? ""
        self.measure9 = try container.decodeIfPresent(String.self, forKey: .measure9) ?? ""
        self.measure10 = try container.decodeIfPresent(String.self, forKey: .measure10) ?? ""
        self.measure11 = try container.decodeIfPresent(String.self, forKey: .measure11) ?? ""
        self.measure12 = try container.decodeIfPresent(String.self, forKey: .measure12) ?? ""
        self.measure13 = try container.decodeIfPresent(String.self, forKey: .measure13) ?? ""
        self.measure14 = try container.decodeIfPresent(String.self, forKey: .measure14) ?? ""
        self.measure15 = try container.decodeIfPresent(String.self, forKey: .measure15) ?? ""
        self.measure16 = try container.decodeIfPresent(String.self, forKey: .measure16) ?? ""
        self.measure17 = try container.decodeIfPresent(String.self, forKey: .measure17) ?? ""
        self.measure18 = try container.decodeIfPresent(String.self, forKey: .measure18) ?? ""
        self.measure19 = try container.decodeIfPresent(String.self, forKey: .measure19) ?? ""
        self.measure20 = try container.decodeIfPresent(String.self, forKey: .measure20) ?? ""
    }
    
    var ingredients: [String:String] {
        var result = [String:String]()
        
        let ingredients = [
            ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6, ingredient7, ingredient8, ingredient9, ingredient10,
            ingredient11, ingredient12, ingredient13, ingredient14, ingredient15, ingredient16, ingredient17, ingredient18, ingredient19, ingredient20
        ]
        
        let measurements = [
            measure1, measure2, measure3, measure4, measure5, measure6, measure7, measure8, measure9, measure10,
            measure11, measure12, measure13, measure14, measure15, measure16, measure17, measure18, measure19, measure20
        ]
        
        for i in 0..<20 {
            let ingredient = ingredients[i]
            let measurement = measurements[i]
            
            if !ingredient.isEmpty, !measurement.isEmpty {
                result[ingredient] = measurement
            }
        }
        return result
    }
    
    static let testIngredients = [
        "test1":"test",
        "test2":"test",
        "test3":"test",
        "test4":"test"
    ].sorted(by: >)
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailUrl = "strMealThumb"
        case sourceUrl = "strSource"
        
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
}
