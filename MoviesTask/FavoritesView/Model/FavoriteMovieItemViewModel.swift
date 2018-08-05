//
//  FavoriteMovieItemViewModel.swift
//  MoviesTask
//
//  Created by TR on 8/5/18.
//  Copyright © 2018 mine. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class FavoriteMovieItemViewModel: Object {
    
    dynamic var Poster: String? = nil
    dynamic var Title: String? = nil
    dynamic var imdbRating:String? = nil
    dynamic var Released:String? = nil
    dynamic var imdbID:String? = nil

    
    convenience init(Poster: String? , Title: String? , imdbRating: String? , Released: String? , imdbID: String? ) {
        self.init()
        self.Poster = Poster
        self.Title = Title
        self.imdbRating = imdbRating
        self.Released = Released
        self.imdbID = imdbID

    }
    
    
}
