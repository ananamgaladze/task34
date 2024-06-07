//
//  ImageLoadingView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI

struct ImageLoadingView: View {
    @StateObject var imageLoader: ImageLoader
    
    let imageSize: CGFloat
    
    init(url: String?,imageSize: CGFloat){
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url:url))
        self.imageSize = imageSize
        
    }
    
    var body: some View {
        Group{
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageSize)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                
            } else if imageLoader.errorMessage != nil {
                Text(imageLoader.errorMessage!)
                    .frame(width: imageSize,height: imageSize)
            } else {
                ProgressView()
                    .frame(width: imageSize,height: imageSize)
            }
        }
        .onAppear{
            imageLoader.fetch()
        }
    }
}

#Preview {
    ImageLoadingView(url: nil, imageSize: 10)
}
