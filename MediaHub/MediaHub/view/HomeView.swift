//
//  Home.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = MediaViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                SectionView(title: "Trending 🔥", medias: viewModel.allTrending)
            }
            .onAppear {
                viewModel.loadTrendingAll()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
    
}
