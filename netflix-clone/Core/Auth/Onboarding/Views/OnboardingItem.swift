//
//  OnboardingItem.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 28/12/25.
//

import SwiftUI

struct OnboardingItem: View {
    @State private var isPresented: Bool = false
    let image: ImageResource
    let title: String
    let subtText: String
    let color: Color
    
    init(
        image: ImageResource = .onboarding1,
        title: String = "Watch Everywhere",
        subtText: String = "Stream on your phone, tablet, laptop, or TV - it's all here.",
        color: Color = .black
    ) {
        self.image = image
        self.title = title
        self.subtText = subtText
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: 18) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
          Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(color)
            VStack(spacing: 8) {
                Text(subtText)
                    .foregroundStyle(color)
                VStack(spacing: 0) {
                    Text("Create a Netflix account and more at")
                        .foregroundStyle(color)
                    Button("netflix.com/more") {
                        isPresented = true
                    }
                    .foregroundStyle(.blue)
                }
                .font(.body)
                 .multilineTextAlignment(.center)
            }
            .font(.body)
             .multilineTextAlignment(.center)
        }
        .sheet(isPresented: $isPresented, content: {
            SafariSheet(url: URL(string: "https://netflix.com/more")!)
        })
        .padding(.horizontal, 20)
    }
}

#Preview {
    OnboardingItem()
}
