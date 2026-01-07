//
//  MovieDetails.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 31/12/25.
//

import SwiftUI

struct MovieDetails: View {
    var key: String
    var body: some View {
        VStack {
            YouTubeView(youtubeID: key)
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    MovieDetails(key: "hsxgDO2mvng")
}
