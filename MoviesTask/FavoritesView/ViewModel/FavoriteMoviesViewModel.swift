//
//  FavoritesMoviesViewModel.swift
//  MoviesTask
//
//  Created by TR on 8/5/18.
//  Copyright © 2018 mine. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

protocol FavoriteMovieItemViewDelegate {
    
    func onItemSelected(index:Int , view : FavoriteMoviesViewController) -> (Void)
}

extension  FavoriteMovieItemViewModel : FavoriteMovieItemViewDelegate{
    func onItemSelected(index: Int, view: FavoriteMoviesViewController) {
        
    }
}

protocol FavoriteMoviesViewDelegate {
    func GetAllDataFromRealmDataBase()->(Void)
    func DeleteFromRealmDataBase(Item:FavoriteMovieItemViewModel)->(Void)
    func ShowErrorMessage(errorMessage:String)->(Void)
}

class FavoriteMoviesViewModel : NSObject {
    
    weak var view:FavoriteMoviesViewController?
    let realm = RealmService.shared.realm
    var favoriteMovies : Results<FavoriteMovieItemViewModel>!
    @objc dynamic var ShowLoading =  false
    
    init?(view:FavoriteMoviesViewController   )
    {
        self.view = view
    }
    
}

extension FavoriteMoviesViewModel:FavoriteMoviesViewDelegate  {
    
    func GetAllDataFromRealmDataBase() {
        
        self.favoriteMovies = realm.objects(FavoriteMovieItemViewModel.self)
        self.ShowLoading = false
        
    }
    
    
    func DeleteFromRealmDataBase(Item:FavoriteMovieItemViewModel ) {
        
                RealmService.shared.delete(Item , completion: { success in
                    if success {
                        self.ShowLoading = false
                        DispatchQueue.main.async(execute: {
                            self.ShowErrorMessage(errorMessage: "Deleted Successfully" )
                        })
                        
                    } else {
                        DispatchQueue.main.async(execute: {
                            self.ShowErrorMessage(errorMessage: "Can't be Deleted" )
                        })
                        
                        self.ShowLoading = false
                        
                        
                    }
                })
                
        
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
