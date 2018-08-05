//
//  SearchMoviesViewModel.swift
//  MoviesTask
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 mine. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

protocol SearchMovieItemViewDelegate {
    
    func onItemSelected(index:Int , view : SearchMoviesViewController) -> (Void)
}

extension  SearchMovieItemViewModel : SearchMovieItemViewDelegate{
    func onItemSelected(index: Int, view: SearchMoviesViewController) {
        
    }
}

protocol SearchMoviesViewDelegate {
    func RequestSearchMoviesApi(name : String ) -> (Void)
    func ShowErrorMessage(errorMessage:String)->(Void)
    func AddtoRealmDataBase()->(Void)
    func DeleteFromRealmDataBase()->(Void)

    
}

class SearchMoviesViewModel : NSObject {
    
    weak var view:SearchMoviesViewController?
    var SearchMovieObject : SearchMovieItemViewModel? = nil
    let realm = RealmService.shared.realm

    @objc dynamic var ShowLoading =  false
    
    init?(view:SearchMoviesViewController   )
    {
        self.view = view
    }
    
}

extension SearchMoviesViewModel:SearchMoviesViewDelegate  {
   
    
    func RequestSearchMoviesApi(name : String) {
        
        self.ShowLoading = true // To update progress bar With KVO
        CallSearchMoviesAPI.load_SearchMovie(name: name , completion: { success in
            if success {
                self.ShowLoading = false
                self.SearchMovieObject = CallSearchMoviesAPI.MovieItem
            } else {
                DispatchQueue.main.async(execute: {
                    self.ShowErrorMessage(errorMessage: CallSearchMoviesAPI.MessageError)
                })

                self.ShowLoading = false
                
            }
        })
        
        
    }
    
    func AddtoRealmDataBase() {
        
        let objects = self.realm.objects(FavoriteMovieItemViewModel.self).filter("Title = %@", self.SearchMovieObject?.Title ?? "_")

        
        if(objects.isEmpty){
        
        
        let newitem = FavoriteMovieItemViewModel(
            Poster: self.SearchMovieObject?.Poster ,
            Title: self.SearchMovieObject?.Title ,
            imdbRating: self.SearchMovieObject?.imdbRating ,
            Released: self.SearchMovieObject?.Released ,
            imdbID: self.SearchMovieObject?.imdbID
        )
        RealmService.shared.create(newitem, completion: { success in
            if success {
                self.ShowLoading = false
                self.SearchMovieObject?.IsAddedToFavorite = true
                DispatchQueue.main.async(execute: {
                    self.ShowErrorMessage(errorMessage: "Added Successfully" )
                })

            } else {
                DispatchQueue.main.async(execute: {
                    self.ShowErrorMessage(errorMessage: "Can't be added" )
                })
                
                self.ShowLoading = false
                self.SearchMovieObject?.IsAddedToFavorite = false

                
            }
        })
        }else{
            
            self.ShowLoading = false
            self.SearchMovieObject?.IsAddedToFavorite = true
            DispatchQueue.main.async(execute: {
                self.ShowErrorMessage(errorMessage: "Added Successfully" )
            })

        }
    }
    
    func DeleteFromRealmDataBase() {
        
        
        for item in self.realm.objects(FavoriteMovieItemViewModel.self){
            
            if(item.Title == self.SearchMovieObject?.Title){
                
                RealmService.shared.delete(item , completion: { success in
                    if success {
                        self.ShowLoading = false
                        self.SearchMovieObject?.IsAddedToFavorite = false
                        DispatchQueue.main.async(execute: {
                            self.ShowErrorMessage(errorMessage: "Deleted Successfully" )
                        })
                        
                    } else {
                        DispatchQueue.main.async(execute: {
                            self.ShowErrorMessage(errorMessage: "Can't be Deleted" )
                        })
                        
                        self.ShowLoading = false
                        self.SearchMovieObject?.IsAddedToFavorite = true
                        
                        
                    }
                })

               break
            }
            
        }
        
        
    }
    
    
        
    func ShowErrorMessage(errorMessage:String) {
        let alert = UIAlertController(title: "Alert", message: errorMessage , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.view?.present(alert, animated: true, completion: nil)
        
    }
    
    
}
