//
//  OnboardingView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 26/12/25.
//

import SwiftUI
import SwiftUINavigation

struct OnboardingItemModel: Identifiable {
    var id: UUID = UUID()
    var image: ImageResource
    var title: String
    var subText: String
    var tag: Int
    
    static let sampleData: [OnboardingItemModel] = [
        .init(
            image: .onboarding1,
            title: "Watch Everywhere",
            subText: "Stream on your phone, tablet, laptop and TV.",
            tag: 0
        ),
        .init(
            image: .onboarding2,
            title: "There's plan for every fan",
            subText: "Join today, no reason to wait",
            tag: 1
        ),
        .init(
            image: .onboarding3,
            title: "Cancel online anytime",
            subText: "Join today, no reason to wait",
            tag: 2
        )
    ]
}

struct OnboardingView: View {
    
    @Environment(\.authCoordinator) var navigate
    
    var data = OnboardingItemModel.sampleData
    
    @Environment(\.authCoordinator) var navigation
    @State var selectedIndex: Int = 0
    @State var changePageBG: Bool = false
    @State var index = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HeaderView(textColor: .white)
                Spacer()
                PageView(pages: data.count, index: $index) {
                    ForEach(data, id: \.id) { item in
                        OnboardingItem(
                            image: item.image,
                            title: item.title,
                            subtText: item.subText,
                            color: .white
                        )
                        .tag(item.tag)
                    }
                }
                .padding(.bottom, 8)
                Spacer()
                ButtonNetflix(
                    text: "SIGN IN"
                ) {
                    navigate.push(.signin)
                }
                .padding(.bottom, 20)
                
                
            }
            .padding(.horizontal, 8)
        }
    }
}


#Preview {
    OnboardingView()
}




