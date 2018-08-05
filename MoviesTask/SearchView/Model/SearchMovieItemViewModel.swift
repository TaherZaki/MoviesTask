//
//  MovieModel.swift
//  MoviesTask
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 mine. All rights reserved.
//

import Foundation
struct SearchMovieItemViewModel: Decodable {
    let Poster: String?
    let Title: String?
    let imdbRating:String?
    let Released:String?
    let Response:String?
    let Error:String?
    let imdbID:String?
    var IsAddedToFavorite:Bool?

}
