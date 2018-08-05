//
//  SearchViewController.swift
//  MoviesTask
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 mine. All rights reserved.
//

import UIKit
class SearchMoviesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate {
   
    var searchBar:UISearchBar!
    var myTableView: UITableView!
    var Movie : SearchMovieItemViewModel?
    var viewModel : SearchMoviesViewModel?
    private static var observerContext = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateViews()

     self.viewModel = SearchMoviesViewModel.init(view: self)
        
    self.viewModel?.addObserver(self, forKeyPath: #keyPath(SearchMoviesViewModel.ShowLoading), options: .new, context: &SearchMoviesViewController.observerContext)

        // Do any additional setup after loading the view.
    }

    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(context == &SearchMoviesViewController.observerContext){
            DispatchQueue.main.async {
                self.myTableView.reloadData()}
        }
    }
    
    private func CreateViews(){
        
        self.view.backgroundColor = Colors.primary
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = " Movie name..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = Colors.primary
        self.navigationController?.navigationBar.topItem?.title = " "
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = (self.view.frame.height - barHeight)
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight ))
        myTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)

        
    }
    
    
    
 
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if(searchBar.text != nil){
        if(!(searchBar.text?.isEmpty)!){
            
            viewModel?.RequestSearchMoviesApi(name: String(describing: searchBar.text!.lowercased()))
            
        //print("searchText \(String(describing: searchBar.text!.lowercased()))")
        }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.viewModel?.SearchMovieObject != nil){
            return 1

        }else{
            return 0

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell =  tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MovieTableViewCell
        
        moviecell.movieTitle.text = self.viewModel?.SearchMovieObject?.Title
        moviecell.movieYear.text = self.viewModel?.SearchMovieObject?.Released
        if(self.viewModel?.SearchMovieObject?.imdbRating != nil){
            moviecell.movieRating.text = (self.viewModel?.SearchMovieObject?.imdbRating!)! + "/10"
        }
        
        if(self.viewModel?.SearchMovieObject?.IsAddedToFavorite)!{
           
            moviecell.favButton.setTitle("Dislike", for: .normal)
            moviecell.favButton.backgroundColor = Colors.button

            
        }else{
            
            moviecell.favButton.setTitle("Like", for: .normal)
            moviecell.favButton.backgroundColor = Colors.primary

            
        }
        
        moviecell.favButton.addTarget(self, action: #selector(AddOrRemove), for: .touchUpInside)

        displayMovieImage(Url: (self.viewModel?.SearchMovieObject?.Poster)!, movieCell: moviecell)
        
        
        return moviecell

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(self.viewModel?.ShowLoading)!{
            return 44.0
        }else{
            
            return 0.0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.color = Colors.primary
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: (self.myTableView.bounds.width), height: CGFloat(44))
        
        if(self.viewModel?.ShowLoading)!{
            
            return spinner
            
        }else{
            
            return nil
        }
        
        
    }
    
    
    @objc func AddOrRemove (sender: UIButton) {
        if(self.viewModel?.SearchMovieObject?.IsAddedToFavorite)!{
            self.viewModel?.DeleteFromRealmDataBase()
        }else{
            self.viewModel?.AddtoRealmDataBase()
        }
    }

    
    
    private func displayMovieImage(Url:String, movieCell: MovieTableViewCell) {
        let url: String = (URL(string:Url )?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                movieCell.movieImage.image = image
            })
        }).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
