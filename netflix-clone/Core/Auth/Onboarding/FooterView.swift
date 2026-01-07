//
//  FooterView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 26/12/25.
//

import SwiftUI
import SafariServices

struct FooterView: View {
    @State var openURL: Bool = false
    var body: some View {
        VStack {
            Text("Create a Netflix account and more.")
                .foregroundStyle(.white)
            HStack {
                Text("Go to")
                    .foregroundStyle(.white)
                Button {
                    openURL = true
                } label: {
                    Text("netflix.com/more")
                        .foregroundStyle(.blue)
                }
            }
        }
        .font(.system(size: 18, weight: .medium, design: .default))
        .font(.body)
        .frame(maxWidth: .infinity, maxHeight: 80) 
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.red.opacity(0.7),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
        )
        .padding()
        .sheet(isPresented: $openURL) {
            SafariSheet(url: URL(string: "https://netflix.com/more")!)
        }
    }
}

#Preview {
    FooterView()
}



