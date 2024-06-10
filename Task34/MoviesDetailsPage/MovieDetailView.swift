//
//  MovieDetailView.swift
//  Task34
//
//  Created by ana namgaladze on 07.06.24.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                movieBackdrop
                moviePosterPathAndName
                movieDetails
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchMovieDetails(movie: movie)
            }
        }
    }
    
    private var movieBackdrop: some View {
        ZStack {
            ImageLoadingView(url: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)", imageSize: 200)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 16,
                        bottomTrailingRadius: 16,
                        topTrailingRadius: 0
                    )
                )
                .padding()
                .overlay(
                    HStack {
                        Image(systemName: "star")
                        Text(String(format: "%.1f", movie.voteAverage))
                            .bold()
                    }
                        .foregroundColor(.orange)
                        .padding(4)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .padding([.trailing, .bottom])
                        .padding(),
                    alignment: .bottomTrailing
                )
        }
    }
    
    private var moviePosterPathAndName: some View {
        VStack {
            HStack {
                Spacer().frame(width: 29)
                ImageLoadingView(url: "https://image.tmdb.org/t/p/w500\(movie.posterPath)", imageSize: 120)
                    .frame(width: 95)
                    .cornerRadius(16)
                
                VStack {
                    Spacer()
                    Text(movie.title)
                        .font(.system(size: 18))
                        .bold()
                }
                .padding(.bottom, 15)
                Spacer()
            }
            .padding(.leading)
            .padding(.top, -80)
        }
    }
    
    private var movieInfo: some View {
        HStack {
            Image(.calendar)
                .resizable()
                .frame(width: 16, height: 16)
            Text(String(movie.releaseDate.prefix(4)))
            
            Divider()
                .frame(height: 16)
                .background(Color.gray)
            
            Image(.clock)
                .resizable()
                .frame(width: 16, height: 16)
            Text("\(movie.runtime ?? 0) Minutes")
            
            Divider()
                .frame(height: 16)
                .background(Color.gray)
            
            Image(.tkt)
                .resizable()
                .frame(width: 16, height: 16)
            Text(movie.genres?.first?.name ?? "")
        }
        .padding(.top, 15)
        .padding(.horizontal, 24)
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    
    private var aboutMovieStack: some View {
        HStack {
            Text("About Movie")
                .font(.system(size: 18))
                .bold()
            Spacer()
            HeartButton(movie: movie)
        }
        .padding([.top, .leading], 24)
    }
    
    private var movieDetails: some View {
        VStack(spacing: 16) {
            movieInfo
            aboutMovieStack
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
                .padding(.horizontal)
            Text(movie.overview)
                .font(.body)
                .padding()
        }
    }
}

struct HeartButton: View {
    @State private var isFavourite = false
    let movie: Movie
    @EnvironmentObject var favoritesViewModel: FavouritesViewModel
    
    var body: some View {
        Button(action: {
            isFavourite.toggle()
            if isFavourite {
                favoritesViewModel.addToFavorites(movie)
            } else {
                favoritesViewModel.removeFromFavorites(movie)
            }
        }) {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .foregroundColor(isFavourite ? .red : .primary)
                .font(.system(size: 20))
        }
        .padding(.trailing, 29)
        .onAppear {
            isFavourite = favoritesViewModel.isFavorite(movie)
        }
    }
}


#Preview {
    ContentView()
}
