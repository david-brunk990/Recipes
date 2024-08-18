//
//  Banner.swift
//  Meal DB
//
//  Created by DJ A on 8/17/24.
//

import SwiftUI

struct Banner: View {
    let title: String
    let bannerColor: Color
    let action: () -> ()
    
    var body: some View {
        ZStack {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: "x.circle.fill").foregroundStyle(.white)
                }
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 4).foregroundStyle(bannerColor))
    }
}

#Preview {
    Banner(title: "Error", bannerColor: .red) {
        
    }
}
