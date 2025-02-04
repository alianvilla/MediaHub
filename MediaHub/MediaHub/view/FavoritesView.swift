//
//  FavoritesView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/3/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var viewModel: MediaViewModel
    
    var body: some View {
            VStack {
                Spacer()
                if viewModel.favoritesAll.isEmpty {
                    Text("No favorites yet")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 10),  // Column 1
                            GridItem(.flexible(), spacing: 10)   // Column 2
                        ], spacing: 16) { // Row spacing
                            ForEach(viewModel.favoritesAll, id: \.id) { media in
                                MediaCardView(media: media)
                            }
                        }
                        .padding()
                    }
                }
            }
            .environmentObject(MediaViewModel())
            .onAppear {
                Task {
                    await viewModel.loadFavorites()
                }
            }
            
        }
}

#Preview {
    FavoritesView().environmentObject(MediaViewModel())
}
