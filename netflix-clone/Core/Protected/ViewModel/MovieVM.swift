//
//  MovieVM.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import Foundation



@Observable
class MovieVM {
    var movieService: MovieServiceProtocol
    var movie: MovieItem?
    var sections: [MovieSection] = []
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        setupSections()
    }
     
    private func setupSections() {
        self.sections = [
            MovieSection(title: "Now Playing", endpoint: .nowPlaying),
            MovieSection(title: "TV Shows", endpoint: .tv),
            MovieSection(title: "TV Airing Today", endpoint: .tvToday),
            MovieSection(title: "Popular on Netflix", endpoint: .popular),
            MovieSection(title: "Top Rated", endpoint: .topRated),
            MovieSection(title: "Coming Soon", endpoint: .upcoming)
        ]
    }
    
    func fetchAllSections() async {
        await withTaskGroup(of: (Int, [MovieItem]).self) { group in
            for (index, section) in sections.enumerated() {
                group.addTask {
                    do {
                        let response = try await self.movieService.getMovies(endPoint: section.endpoint)
                        return (index, response!.results)
                    } catch {
                        print("Error fetching \(section.title): \(error)")
                        return (index, [])
                    }
                }
            }
            
            for await (index, movies) in group {
                sections[index].movies = movies
            }
        }
    }
    
    func fetchMovie(id: Int, type: VideoType) async {
        do {
            self.movie = try await movieService
                .getMovie(id: id, type: type)
        } catch  {
            print("No movide found")
        }
    }
}
