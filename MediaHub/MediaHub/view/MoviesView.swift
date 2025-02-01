
//
//  Movies.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import SwiftUI

public struct MoviesView: View {
    
    @StateObject private var viewModel: MediaViewModel = MediaViewModel()
    
    public var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Trending Section
                    SectionView(title: "Trending 🔥", medias: viewModel.moviesTrending)
                    
                    // MARK: Popular Shows Section
                    SectionView(title: "Popular", medias: viewModel.moviesPopular)
                    
                    // MARK: Genre-Based Shows
                    if viewModel.moviesByGenre.isEmpty {
                        LoadingView()
                    } else {
                        ForEach(Array(viewModel.moviesByGenre.enumerated()), id: \.offset) { index, movies in
                            if index < viewModel.genreMovies.count {
                                GenreSectionView(title: viewModel.genreMovies[index].name, medias: movies)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .onAppear {
                viewModel.loadTrendingMovies()
                viewModel.loadPopularMovies()
                viewModel.loadGenreMovies()
            }
        
        
    }
}

#Preview {
    MoviesView()
}
