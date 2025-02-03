//
//  MediaDetailsView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import SwiftUI

struct MediaDetailsView: View {
    let id: Int
    let mediaType: String
    @StateObject var viewModel: MediaViewModel = MediaViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let details = viewModel.mediaDetails {
                    
                    // MARK: - Title
                    Text(details.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // MARK: - Backdrop Image
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(details.backdropPath ?? "")")) { image in
                        image.resizable()
                            .scaledToFit()
                            .shadow(color: .gray, radius: 4)
                    } placeholder: {
                        Color.gray
                            .overlay(ProgressView())
                    }
                    .frame(maxWidth: .infinity)
                    
                    // MARK: - Movie / TV Show Info
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("📅 Release Date:")
                                .bold()
                            Text("\(formatDate(details.releaseDate))")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                        HStack {
                            Text("⭐ Rating:")
                                .bold()
                            Text("\(String(format: "%.1f", details.voteAverage)) / 10")
                        }
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                        
                        if let genres = details.genres {
                            HStack {
                                Text("🎭 Genres:")
                                    .bold()
                                Text(genres.map { $0.name }.joined(separator: ", "))
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        
                        HStack {
                            Text("🔥 Popularity:")
                                .bold()
                            Text("\(Int(details.popularity))")
                        }
                        .font(.subheadline)
                        .foregroundColor(.orange)
                        
                        if let status = details.status {
                            HStack {
                                Text("📌 Status:")
                                    .bold()
                                Text(status)
                            }
                            .font(.subheadline)
                            .foregroundColor(.green)
                        }
                        
                        if let runtime = details.runtime {
                            HStack {
                                Text("⏳ Duration:")
                                    .bold()
                                Text("\(runtime) min")
                            }
                            .font(.subheadline)
                            .foregroundColor(.red)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - Overview
                    Text("Overview")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    Text(details.overview)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - Production Companies
                    if let companies = details.productionCompanies, !companies.isEmpty {
                        Text("Production Companies")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(companies) { company in
                                    VStack {
                                        if let logoPath = company.logoPath {
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(logoPath)")) { image in
                                                image.resizable()
                                                    .scaledToFit()
                                                    .frame(width: 80, height: 80)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    .shadow(radius: 2)
                                            } placeholder: {
                                                Color.gray
                                                    .frame(width: 80, height: 80)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                            }
                                        }
                                        Text(company.name)
                                            .font(.caption)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .frame(width: 100)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    ProgressView("Loading...")
                        .padding(.top, 50)
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            viewModel.loadMediaById(id: id, mediaType: mediaType)
        }
    }
    
    // MARK: - Helper Function for Date Formatting
    private func formatDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }
        return dateString
    }
    
    // MARK: - Helper Function for Currency Formatting
    private func formatCurrency(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }
}

#Preview {
    MediaDetailsView(id: 226636, mediaType: "tv")
}
