//
//  HomeCoordinatorView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 31/12/25.
//

import SwiftUI
import SwiftUINavigation

struct HomeCoordinatorView: View {
    var movieVM: MovieVM
    
    var body: some View {
        CoordinatorView(
            environmentKeyPath: \.homeCoordinator,
            rootView: {
                Home(movieVM: movieVM)
            }) { destination in
                switch(destination) {
                case .moveDetails(let key):
                    MovieDetails(key: key)
                        .toolbar(.hidden, for: .tabBar)
                }
            }
    }
}
