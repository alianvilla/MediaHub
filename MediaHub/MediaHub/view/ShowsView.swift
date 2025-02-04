//
//  ShowsView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import SwiftUI

struct ShowsView: View {
    
    @EnvironmentObject var viewModel: MediaViewModel
    
    var body: some View {
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Trending Section
                    SectionView(title: "Trending 🔥", medias: viewModel.showsTrending)
                    
                    // MARK: Popular Shows Section
                    SectionView(title: "Popular", medias: viewModel.showsPopular)
                    
                    SectionView(title: "Airing today", medias: viewModel.airingTodayShows)
                    
                    // MARK: Genre-Based Shows
                    if viewModel.showsByGenre.isEmpty {
                        LoadingView()
                    } else {
                        ForEach(Array(viewModel.showsByGenre.enumerated()), id: \.offset) { index, shows in
                            if index < viewModel.genreTvShows.count {
                                GenreSectionView(title: viewModel.genreTvShows[index].name, medias: shows)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .onAppear {
                viewModel.loadTrendingShows()
                viewModel.loadPopularShows()
                viewModel.loadGenreShows()
                viewModel.loadAiringTodayShows()
            }
            
                
    }
}


#Preview {
    ShowsView()
}
