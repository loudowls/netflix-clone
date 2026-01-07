//
//  Home.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import SwiftUI

struct Home: View {
    var movieVM: MovieVM
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .bgLightGray,
                    .black
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                TopBar(text: "For Pardip", textColor: .white)
                ScrollView(showsIndicators: false) {
                    MainCardView()
                    VStack {
                        VideoCollectionView(movieVM: movieVM)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .task {
            await movieVM.fetchAllSections()
//            await movieVM.fetchMovies(type: .popular)
        }
    }
}

#Preview {
    Home(movieVM: MovieVM(movieService: MovieService()))
}
