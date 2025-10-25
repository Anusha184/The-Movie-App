//
//  MovieCellView.swift
//  MovieApp
//
//  Created by Anusha on 24/10/25.
//

import SwiftUI

struct MovieCellView: View {
    @Binding var movie: MovieData
    var viewModel: MovieListViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: posterURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                    ProgressView()
                }
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)
            .shadow(radius: 4)

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title ?? "Unknown Title")
                    .font(.headline)
                    .lineLimit(2)
                
                if let vote = movie.voteAverage {
                    Text("Rating: \(String(format: "%.1f", vote))/10")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Button(action: {
                viewModel.toggleFavorite(movie: movie)
            }) {
                Image(systemName: movie.isFav == true ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
            
        }
        .padding(.vertical, 8)
    }

    private var posterURL: String {
        "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"
    }
}

