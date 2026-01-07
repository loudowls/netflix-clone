//
//  ContentView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI

struct ContentView: View {
    var authVM: AuthVM = AuthVM(service: AuthService())
    @State private var showSplash = true
    
    var body: some View { 
        VStack {
            switch showSplash {
            case true:
                NetflixSplashView(isActive: $showSplash)
                    .transition(.opacity.combined(with: .move(edge: .leading)))
            case false:
                if authVM.isAuthenticated {
                    TabView {
                        HomeCoordinatorView(movieVM: MovieVM(movieService: MovieService()))
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                            .tag(0)
                       
                        Profile(authVM: authVM)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Profile")
                            }
                            .tag(1)
                    }
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                } else {
                    AuthCoordinatorView(authVM: authVM)
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                }
            }
        }
        .animation(.easeIn(duration: 0.7), value: showSplash)
    }
}

#Preview {
    ContentView()
}


