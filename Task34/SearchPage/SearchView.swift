//
//  SearchView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        TextField(viewModel.placeholderText, text: $viewModel.searchTerm)
                            
                        Image(.rloop)
                            .foregroundColor(Color.gray)
                    }
                    .padding()
                    .frame(height: 42)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.searchb)
                    )
                    .padding(.horizontal)
                    
                    Menu {
                        ForEach(FilterType.allCases, id: \.self) { filter in
                            Button(filter.rawValue) {
                                viewModel.selectedFilter = filter
                            }
                        }
                    } label: {
                        Image(.elips)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                .padding(.top, 10)
                
                Spacer()
                if viewModel.searchTerm.isEmpty {
                    VStack {
                        Text("Use the magic search!")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .bold()
                            .padding()
                        Text("I will do my best to search everything relevant,\nI promise!")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                } else if viewModel.filteredMovies.isEmpty {
                    VStack {
                        Text("Oh no, isn't this so embarrassing?")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .bold()
                            .padding()
                        Text(viewModel.errorMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredMovies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCell(movie: movie)
                                        .padding(.horizontal)
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    viewModel.searchTerm = ""
                                })
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .onAppear {
                viewModel.selectedFilter = .name
            }
        }
    }
}




#Preview {
    ContentView()
}
