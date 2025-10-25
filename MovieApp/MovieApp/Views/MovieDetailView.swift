//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Anusha on 25/10/25.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel
    @Binding var movieData: MovieData
    var listViewModel: MovieListViewModel
    
    init(movieId: Int, listViewModel: MovieListViewModel, movie: Binding<MovieData>) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
        self._movieData = movie
        self.listViewModel = listViewModel
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let movie = viewModel.movie {
                VStack(alignment: .leading, spacing: 16) {
                    
                    if let trailerKey = viewModel.trailerKey {
                        VideoPlayerView(youtubeKey: trailerKey)
                            .frame(height: 200)
                            .cornerRadius(12)
                    }
                    
                    HStack {
                        Text(movie.title ?? "")
                            .font(.title2)
                            .bold()
                        Spacer()
                        
                        Button(action: {
                            listViewModel.toggleFavorite(movie: movie)
                        }) {
                            Image(systemName: movieData.isFav == true ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    
                    if let genreNames = movie.genres?.compactMap({ $0.name }).joined(separator: ", ") {
                        Text("Genres: \(genreNames)")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        if let vote = movie.voteAverage {
                            Text("Rating: \(String(format: "%.1f", vote))/10")
                        }
                        
                        if let runtime = movie.runtime {
                            Text("• \(runtime) min")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Text(movie.overview ?? "")
                        .font(.body)
                        .padding(.top, 8)
                }
                .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationTitle("Movie Details")
        .task {
            await viewModel.fetchDetails()
        }
    }
}
