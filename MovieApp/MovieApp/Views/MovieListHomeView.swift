//
//  ContentView.swift
//  MovieApp
//
//  Created by Anusha on 24/10/25.
//

import SwiftUI

struct MovieListHomeView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search movies", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .onChange(of: searchText) { oldValue, newValue in
                            Task {
                                if newValue.isEmpty {
                                    await viewModel.fetchMoviesList()
                                } else {
                                    await viewModel.fetchSearchMoviesList(title: newValue)
                                }
                            }
                        }
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()

                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading movies...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        List {
                            ForEach($viewModel.movies) { $movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id, listViewModel: viewModel, movie: $movie)) {
                                    MovieCellView(movie: $movie, viewModel: viewModel)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("Movies")
            .task {
                await viewModel.fetchMoviesList()
            }
        }
    }
}

