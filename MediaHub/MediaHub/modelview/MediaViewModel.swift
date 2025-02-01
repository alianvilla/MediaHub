//
//  MediaModelView.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 1/31/25.
//
import Foundation

@MainActor
class MediaViewModel: ObservableObject {
    @Published var allTrending: [any Media] = []
    @Published var moviesTrending: [Movie] = []
    @Published var moviesPopular: [Movie] = []
    @Published var showsTrending: [TVShow] = []
    @Published var showsPopular: [TVShow] = []
    @Published var errorMessage: String? = nil
    @Published var showsByGenre: [[TVShow]] = []
    @Published var moviesByGenre: [[Movie]] = []
    @Published var genreTvShows: [Genre] = []
    @Published var genreMovies: [Genre] = []
    
    private let query = [
        URLQueryItem(name: "language", value: "en-US")
    ]
    
//    MARK: Fetch Genres Shows
    func loadGenreShows() {
        Task {
            do {
                let data = try await APIClient.fetchData(from: "genre/tv/list", queryItems: query)
                
                let decodedResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
                
                genreTvShows = decodedResponse.genres
                
                print("✅ Loaded Genres: \(genreTvShows.count)")
                
                await loadShowsByGenre()
                
            } catch {
                errorMessage = error.localizedDescription
                print("❌ Error fetching genres: \(error.localizedDescription)")
            }
            
        }
    }
    
// MARK: Fetch Shows by Genre
        func loadShowsByGenre() async {
            var tempShowsByGenre: [[TVShow]] = []
            
            await withTaskGroup(of: (Int, [TVShow]).self) { group in
                for genre in genreTvShows {
                    group.addTask {
                        do {
                            let data = try await APIClient.fetchData(from: "discover/tv", queryItems: [
                                URLQueryItem(name: "language", value: "en-US"),
                                URLQueryItem(name: "with_genres", value: "\(genre.id)")
                            ])
                            
                            let decodedResponse = try JSONDecoder().decode(MediaResponse<TVShow>.self, from: data)
                            
                            return (genre.id, decodedResponse.results)
                            
                        } catch {
                            print("❌ Error fetching shows for genre \(genre.name): \(error.localizedDescription)")
                            return (genre.id, [])
                        }
                    }
                }
                
                for await (_, shows) in group {
                    tempShowsByGenre.append(shows)
                }
            }
            
            showsByGenre = tempShowsByGenre
            print("✅ Loaded \(showsByGenre.count) genre categories")
        }
    
    
    
    
    
//    MARK: Fetch Popular Shows
    func loadTrendingShows() {
        Task {
            do {
                let data = try await APIClient.fetchData(from: "trending/tv/day", queryItems: query)
                
                let decodedResponse = try JSONDecoder().decode(MediaResponse<TVShow>.self, from: data)
                
                DispatchQueue.main.async {
                    self.showsTrending = decodedResponse.results
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("❌ Error fetching trending shows: \(error.localizedDescription)")
                }
            }
        }
    }

    func loadPopularShows() {
        Task {
            do {
                let data = try await APIClient.fetchData(from: "tv/popular", queryItems: query)
                
                let decodedResponse = try JSONDecoder().decode(MediaResponse<TVShow>.self, from: data)
                
                DispatchQueue.main.async {
                    self.showsPopular = decodedResponse.results
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("❌ Error fetching popular shows: \(error.localizedDescription)")
                }
            }
        }
    }

//    MARK: Fetch Genres Movies
    func loadGenreMovies() {
        Task {
            do {
                let data = try await APIClient.fetchData(from: "genre/movie/list", queryItems: query)
                
                let decodedResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
                
                genreMovies = decodedResponse.genres
                
                print("✅ Loaded Genres: \(genreMovies.count)")
                
                await loadMoviesByGenre()
                
            } catch {
                errorMessage = error.localizedDescription
                print("❌ Error fetching genres: \(error.localizedDescription)")
            }
            
        }
    }
    
// MARK: Fetch Movies by Genre
        func loadMoviesByGenre() async {
            var tempMoviesByGenre: [[Movie]] = []
            
            await withTaskGroup(of: (Int, [Movie]).self) { group in
                for genre in genreMovies {
                    group.addTask {
                        do {
                            let data = try await APIClient.fetchData(from: "discover/movie", queryItems: [
                                URLQueryItem(name: "language", value: "en-US"),
                                URLQueryItem(name: "with_genres", value: "\(genre.id)")
                            ])
                            
                            let decodedResponse = try JSONDecoder().decode(MediaResponse<Movie>.self, from: data)
                            
                            return (genre.id, decodedResponse.results)
                            
                        } catch {
                            print("❌ Error fetching shows for genre \(genre.name): \(error.localizedDescription)")
                            return (genre.id, [])
                        }
                    }
                }
                
                for await (_, movie) in group {
                    tempMoviesByGenre.append(movie)
                }
            }
            
            moviesByGenre = tempMoviesByGenre
            print("✅ Loaded \(moviesByGenre.count) genre categories")
        }
    
    
    
    
    
//    MARK: Fetch Popular Movies
    func loadTrendingMovies() {
        Task {
            do {
                let data = try await APIClient.fetchData(from: "trending/movie/day", queryItems: query)
                
                let decodedResponse = try JSONDecoder().decode(MediaResponse<Movie>.self, from: data)
                
                DispatchQueue.main.async {
                    self.moviesTrending = decodedResponse.results
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("❌ Error fetching trending shows: \(error.localizedDescription)")
                }
            }
        }
    }

    func loadPopularMovies() {
        Task {
            do {
                let data = try await APIClient.fetchData(from: "movie/popular", queryItems: query)
                
                let decodedResponse = try JSONDecoder().decode(MediaResponse<Movie>.self, from: data)
                
                DispatchQueue.main.async {
                    self.moviesPopular = decodedResponse.results
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("❌ Error fetching popular shows: \(error.localizedDescription)")
                }
            }
        }
    }
    
//    MARK: Fetch trending ALL
    func loadTrendingAll() {
        Task {
                await withTaskGroup(of: [any Media].self) { group in
                    // Fetch Trending Movies
                    group.addTask {
                        do {
                            let data = try await APIClient.fetchData(from: "trending/movie/day", queryItems: self.query)
                            let decodedResponse = try JSONDecoder().decode(MediaResponse<Movie>.self, from: data)
                            return decodedResponse.results
                        } catch {
                            print("❌ Error fetching trending movies: \(error.localizedDescription)")
                            return []
                        }
                    }
                    
                    // Fetch Trending TV Shows
                    group.addTask {
                        do {
                            let data = try await APIClient.fetchData(from: "trending/tv/day", queryItems: self.query)
                            let decodedResponse = try JSONDecoder().decode(MediaResponse<TVShow>.self, from: data)
                            return decodedResponse.results
                        } catch {
                            print("❌ Error fetching trending shows: \(error.localizedDescription)")
                            return []
                        }
                    }
                    
                    var combinedTrending: [any Media] = []
                    
                    for await results in group {
                        combinedTrending.append(contentsOf: results)
                    }
                    
                    combinedTrending.shuffle()
                    self.allTrending = combinedTrending
                }
            }
    }
    
}



