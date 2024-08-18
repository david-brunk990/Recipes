//
//  DessertsListCell.swift
//  Meal DB
//
//  Created by DJ A on 8/17/24.
//

import SwiftUI

struct DessertsListCell: View {
    let meal: Meal
    
    var body: some View {
        HStack(spacing: 15) {
            if let url = URL(string: meal.thumbnailUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                        .shadow(color: BrandColor.shadoColor,radius: 5)
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.4)
                        ProgressView()
                    }
                    .frame(width: 45, height: 45)
                    .cornerRadius(4)
                    .shadow(radius: 4, x: 4, y: 4)
                    
                }
                Text(meal.name)
                    .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    DessertsListCell(meal: Meal.testMeal)
}
