//
//  ContentView.swift
//  netflix-clone-github
//
//  Created by Pardip Bhatti on 01/01/26.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash: Bool = true
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false

    var body: some View {
        Group {
            if showSplash {
                NetflixSplashView(showSplash: $showSplash)
                    .transition(.opacity.combined(with: .move(edge: .leading)))
            } else {
                switch onboardingCompleted {
                   case true:
                    AuthCoordinatorView()
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                case false:
                    OnboardingView()
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                }
                
            }
        }
        .animation(.easeIn(duration: 0.5), value: showSplash)
    }
}

#Preview {
    ContentView()
}
