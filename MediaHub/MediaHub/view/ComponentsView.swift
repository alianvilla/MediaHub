//
//  ComponentsView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import SwiftUI

// MARK: - SectionView (Reusable for Trending & Popular)
struct SectionView: View {
    let title: String
    let medias: [any Media]
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeader(title: title)
            
            if medias.isEmpty {
                LoadingView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(medias, id: \.id) { media in
                            MediaCardView(media: media)
                                
                            
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}

// MARK: - GenreSectionView (For Genre-Based Shows)
struct GenreSectionView: View {
    let title: String
    let medias: [any Media]
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeader(title: title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(medias, id: \.id) { media in
                        MediaCardView(media: media)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

// MARK: - SectionHeader
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(.title3)
                .bold()
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

// MARK: - ShowCardView
struct MediaCardView: View {
    let media: any Media
    
    var body: some View {
        NavigationLink(destination: MediaDetailsView(id: media.id, mediaType: media.mediaType!)) {
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(media.posterPath ?? "")")) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                        .overlay(
                            ProgressView()
                        )
                }
                .frame(width: 150, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 5)
                
                Text(media.title)
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .frame(width: 150)
            }
            .contentShape(Rectangle())
        }
    }
        
}


// MARK: - LoadingView
struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
    }
}

