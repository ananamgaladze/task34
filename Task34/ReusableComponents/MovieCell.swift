//
//  MovieCell.swift
//  Task34
//
//  Created by ana namgaladze on 10.06.24.
//

import SwiftUI

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ImageLoadingView(url: "https://image.tmdb.org/t/p/w500\(movie.posterPath)", imageSize: 130)
                .frame(width: 95)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.orange)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .foregroundColor(.orange)
                }
                .font(.subheadline)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(.tkt)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(movie.genres?.first?.name ?? "Unknown")
                    }
                    HStack {
                        Image(.calendar)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(String(movie.releaseDate.prefix(4)))
                    }
                    HStack {
                        Image(.clock)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("\(movie.runtime ?? 0) Minutes")
                    }
                }
                .font(.subheadline)
                .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}
