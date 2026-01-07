//
//  PageView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 26/12/25.
//

import SwiftUI

struct PageView<Content: View>: View {
    let pages: Int
    @Binding var index: Int
    let content: Content
    
    init(
        pages: Int,
        index: Binding<Int>,
        @ViewBuilder content: () -> Content
    ) {
        self.pages = pages
        self._index = index
        self.content = content()
    }
    
//    init(
//        pages: Int,
//        index: Binding<Int>,
//        @ViewBuilder content: () -> Content
//    ) {
//        self.pages = pages
//        self._index = index
//        self.content = content()
//    }
    
    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $index) {
                content
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            PageIndicators(count: pages, index: index)
        }
    }
}


struct PageIndicators: View {
    let count: Int
    var index: Int
   
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { i in
                Circle()
                    .fill(i == index ? Color.white : Color.gray.opacity(0.5))
                    .frame(width: i == index ? 10 : 8, height: i == index ? 10 : 8)
                    .animation(.spring(duration: 0.25), value: index)
            }
        }
        
    }
}
