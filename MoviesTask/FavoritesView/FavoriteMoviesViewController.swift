//
//  FavoritesViewController.swift
//  MoviesTask
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 mine. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource   {
  
    var myTableView: UITableView!
    var viewModel : FavoriteMoviesViewModel?
    private static var observerContext = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateViews()

        self.viewModel = FavoriteMoviesViewModel.init(view: self)
        
        self.viewModel?.addObserver(self, forKeyPath: #keyPath(FavoriteMoviesViewModel.ShowLoading), options: .new, context: &FavoriteMoviesViewController.observerContext)
        
        self.viewModel?.GetAllDataFromRealmDataBase()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(context == &FavoriteMoviesViewController.observerContext){
            DispatchQueue.main.async {
                self.myTableView.reloadData()}
        }
    }
    
    private func CreateViews(){
        
        self.view.backgroundColor = Colors.primary
        navigationItem.title = "My Favorites"
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = Colors.primary
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.favoriteMovies.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell =  tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MovieTableViewCell
        
        let movie = self.viewModel?.favoriteMovies[indexPath.row]
        moviecell.movieTitle.text = movie?.Title
        moviecell.movieYear.text = movie?.Released
        if(movie?.imdbRating != nil){
            moviecell.movieRating.text = (movie?.imdbRating!)! + "/10"
        }
        let idx: Int = indexPath.row
        moviecell.favButton.tag = idx
        moviecell.favButton.setTitle("Dislike", for: .normal)
        moviecell.favButton.backgroundColor = Colors.button

        moviecell.favButton.addTarget(self, action: #selector(Remove), for: .touchUpInside)
        
        displayMovieImage(Url: (movie?.Poster)!, movieCell: moviecell)

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
    
    
    @objc func Remove (sender: UIButton) {
        
        self.viewModel?.DeleteFromRealmDataBase(Item: (self.viewModel?.favoriteMovies[sender.tag])!)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
