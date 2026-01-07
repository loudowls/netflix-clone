//
//  ChipsCategoriesFilters.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import SwiftUI

struct ChipsCategoriesFilters: View {
    @State private var selectedCategory: String = ""
    @State var showAllCategories: Bool = false
    let categories = ["Shows", "Movies"]
    
    var body: some View {
        HStack {
            if !selectedCategory.isEmpty {
                
                Circle()
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text("X")
                            .foregroundStyle(.white)
                    }
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 0.5))
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        selectedCategory = ""
                    }
                ChipsView(
                    title: selectedCategory,
                    isSelected: true
                )
            } else {
                ForEach(categories.filter { $0 != selectedCategory }, id: \.self) { category in
                    ChipsView(
                        title: category,
                        isSelected: false
                    ) {
                        selectedCategory = category
                    }
                }
            }
            
            ChipsView(
                title: "Categories",
                isSelected: false
            ) {
                showAllCategories = true
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 20)
        .fullScreenCover(isPresented: $showAllCategories, content: {
            VStack {
                
                Text("List of categories")
                Button("Close") {
                    showAllCategories = false
                }
            }
            
        })
    }
}

#Preview {
    ChipsCategoriesFilters()
}
