//
//  CallSearchMoviesAPI.swift
//  MoviesTask
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 mine. All rights reserved.
//

import Foundation
class CallSearchMoviesAPI  {
    
    static var MovieItem:SearchMovieItemViewModel? = nil
    static var MessageError = "Check your connection"
    
    static func load_SearchMovie( name:String  ,  completion:@escaping (Bool) -> ()){
        
        
        let jsonUrlString = Urls.SearchMovies_Url  + "&t=" + name
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode == 200){
                    
                    guard let data = data else { return }
                    do {
                        
                        let Decoded = try JSONDecoder().decode(SearchMovieItemViewModel.self, from: data)
                        
                        if(Decoded.Response == "True"){
                            MovieItem = Decoded
                            MovieItem?.IsAddedToFavorite = false
                            completion(true)
                        }else{
                            MessageError = Decoded.Error!
                            completion(false)
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                        
                        completion(false)
                        
                    }
                    
                    
                }else{
                    
                    completion(false)
                    
                }
            }else{
                completion(false)
                
            }
            
            }.resume()
    }
    
    
    
}
