//
//  ContentView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
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
            
            Text("Home")
                .tabItem{
                    Label("Favorites", systemImage: "star")
                }
        }
        .tint(.red).opacity(0.8)
    }
}

#Preview {
    ContentView()
}
