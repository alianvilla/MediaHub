//
//  FavoritesView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/3/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var viewModel: MediaViewModel = MediaViewModel()
    
    var body: some View {
            VStack {
                Spacer()
                if viewModel.favoritesAll.isEmpty {
                    Text("No favorites yet")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.favoritesAll, id: \.id) { media in
                                MediaCardView(media: media)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadFavorites()
            }
        }
}

#Preview {
    FavoritesView()
}
