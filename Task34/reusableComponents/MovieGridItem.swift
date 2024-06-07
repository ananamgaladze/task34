//
//  MovieGridItem.swift
//  Task34
//
//  Created by ana namgaladze on 06.06.24.
//

import SwiftUI

struct MovieGridItem: View {
    let movie: Movie
    @State private var flipped = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(radius: 5)
                
                if !flipped {
                    ImageLoadingView(url: "https://image.tmdb.org/t/p/w500\(movie.posterPath)", imageSize: 370)
                } else {
                    VStack {
                        HStack {
                            Image(.imdb)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 35)
                            
                            Text(String(format: "%.2f ", movie.voteAverage))
                                .font(.title)
                                .bold()
                        }
                        
                        Text(movie.overview)
                            .font(.body)
                            .padding()
                            .background(Color.bPurple.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    .transition(.opacity)
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    flipped.toggle()
                }
            }
            .frame(height: 370)
            .padding()
            
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .padding(.top, 5)
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 13)
    }
}

