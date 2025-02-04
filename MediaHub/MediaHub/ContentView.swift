//
//  ContentView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: MediaViewModel = MediaViewModel()
    
    var body: some View {
        NavigationStack{
            TabView{
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }
                
                MoviesView()
                    .tabItem{
                        Label("Movies", systemImage: "movieclapper")
                    }
                
                ShowsView()
                    .tabItem{
                        Label("Shows", systemImage: "play.tv")
                    }
                
                FavoritesView()
                    .tabItem{
                        Label("Favorites", systemImage: "star")
                    }
            }
            .tint(.red).opacity(0.8)
        }
        .environmentObject(viewModel)
        
    }
}

#Preview {
    ContentView()
}
