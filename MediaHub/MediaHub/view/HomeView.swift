//
//  Home.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: MediaViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                SectionView(title: "Trending 🔥", medias: viewModel.allTrending)
                
                SectionView(title: "Now Playing", medias: viewModel.allNowPlaying)
                
                SectionView(title: "Upcoming Movies", medias: viewModel.upcomingAll)
                
                SectionView(title: "Top Rated", medias: viewModel.topRatedAll)
                
                
            }
            .onAppear {
                viewModel.loadTrendingAll()
                viewModel.loadNowPlayingAll()
                viewModel.loadTopRatedAll()
                viewModel.loadUpcomingAll()
            }
        }
    }
}

#Preview {
    HomeView()
    
}
