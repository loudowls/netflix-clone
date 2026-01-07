//
//  VideoCollectionView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import SwiftUI
import Kingfisher
import SwiftUINavigation


enum CurrentMovie: Identifiable {
    case movie(MovieItem)
    
    var movie: MovieItem {
        switch self {
        case .movie(let movie):
            return movie
        }
    }
    
    var id: Int { movie.id }
    
}


struct VideoCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.homeCoordinator) var coordinator
    var movieVM: MovieVM
    var text: String = "Movies"
    let rows : [GridItem] = [
        .init(.flexible()),
    ]
    @State var movieID: CurrentMovie?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(movieVM.sections) { section in
                Text(section.title)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 12) {
                        ForEach(section.movies) { movie in
                            MovieItemCard(movie: movie) { item in
                                movieID = .movie(item)
                            }
                        }
                    }
                }
                .padding(0)
            }
        }
        .sheet(
            item: $movieID,
            content: { item in
                VStack(spacing: 0) {
                    ZStack(alignment: .topTrailing) {
                        KFImage(movieVM.movie?.posterURL)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .clipped()
                            .overlay {
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(.black.opacity(0.5))
                                    .overlay {
                                        Image(systemName: "play.fill")
                                            .font(.title3)
                                            .foregroundStyle(.white)
                                    }
                            }
                            .overlay {
                                LinearGradient(
                                    colors: [.black.opacity(0.5), .clear],
                                    startPoint: .topTrailing,
                                    endPoint: .bottom
                                )
                            }
                        
                        Button {
                            movieID = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        .padding(.top)
                        .padding(.trailing)

                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(movieVM.movie?.title ?? movieVM.movie?.name ?? "")
                            .font(.title)
                            .foregroundStyle(.white)
                        
                        ButtonNetflix(text: "Play") {
                            Image(systemName: "play.fill")
                                .foregroundStyle(.white)
                        } action: {
                            if let key = movieVM.movie?.videos?.results?.first?.key {
                                movieID = nil
                                coordinator
                                    .push(
                                        .moveDetails(
                                            key: key)
                                    )
                            }
                        }
                        
                        ButtonNetflix(
                            text: "Download",
                            configuration: .init(
                                backgroundColor: .buttonGrayDark
                            )
                        ) {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundStyle(.white)
                        } action: {}
                        
                        Text(movieVM.movie?.overview ?? "")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    Spacer()
                }
                .background {
                    LinearGradient(
                        colors: [
                            .buttonGrayDark,
                            .black.opacity(0.9),
                            .netflixRed.opacity(0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
                .task {
                    await movieVM.fetchMovie(
                        id: item.id,
                        type: item.movie.title != nil ? .movie : .tv
                    )
                }
                
            })
    }
}

#Preview {
    VideoCollectionView(movieVM: MovieVM(movieService: MovieService()))
}
