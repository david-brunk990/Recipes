//
//  DessertsGridCell.swift
//  Meal DB
//
//  Created by DJ A on 8/18/24.
//

import SwiftUI

struct DessertsGridCell: View {
    let meal: Meal
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: meal.thumbnailUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 100, height: 100)
                        .cornerRadius(4)
                        .shadow(color: BrandColor.shadoColor,radius: 5)
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.4)
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(4)
                    .shadow(radius: 4, x: 4, y: 4)
                    
                }
                Text(meal.name)
                    .padding([.leading, .bottom])
                    .foregroundStyle(.white)
                    .bold()
                    .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    DessertsGridCell(meal: Meal.testMeal)
}
