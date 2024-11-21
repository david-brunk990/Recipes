//
//  RecipeListCell.swift
//
//  Created by DJ A on 11/18/24.
//

import SwiftUI

struct RecipeListCell: View {
    let recipe: Recipe
    let image: Image?
    
    private let imageSize: CGFloat = 50
    
    var body: some View {
        HStack(spacing: 15) {
            if let image {
                image
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.gray)
                    .shadow(radius: 2, x: 1, y: 1)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.gray.opacity(0.4))
                    Image(systemName: "photo")
                        .foregroundStyle(.gray)
                }
                .frame(width: imageSize, height: imageSize)
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(BrandColor.textColor)
                Text(recipe.cuisine)
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(BrandColor.textColor)
            }
            
            Spacer()
        }
    }
}

#Preview {
    RecipeListCell(recipe: Recipe.testRecipe, image: nil)
}
