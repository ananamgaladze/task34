//
//  ImageLoader.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import Foundation
import SwiftUI

final class ImageLoader: ObservableObject {
    
    let url: String?
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init(url: String?) {
        self.url = url
    }
    
    func fetch() {
        guard image == nil && !isLoading else {
            return
        }
        
        guard let url = url, let fetchURL = URL(string: url) else {
            self.errorMessage = "Bad Response"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let request  = URLRequest(url: fetchURL,cachePolicy: .returnCacheDataElseLoad)
        
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response,error) in
            DispatchQueue.main.async {
                
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                }else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self?.errorMessage = "wrongResponse"
                }else if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.errorMessage = "uiuiui nametania"
                }
            }
            
        }
        .resume()
    }
}
