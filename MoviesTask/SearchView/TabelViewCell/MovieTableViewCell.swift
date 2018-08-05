//
//  MovieSearchTableViewCell.swift
//  MoviesTask
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 mine. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell{
    
    var movieImage = UIImageView()
    var movieTitle = UILabel()
    var movieYear = UILabel()
    var movieRating = UILabel()
    var containerView = UIView()
    var favButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.clear
        setupMovieImage()
        setupContainerView()
        setupMovieTitle()
        setupMovieYear()
        setupMovieRating()
        setupFavButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutMovieImage()
        layoutContainerView()
        layoutMovieTitle()
        layoutMovieYear()
        layoutMovieRating()
        layoutFavButton()
    }
    
    func setupMovieImage() {
        movieImage.contentMode = .scaleAspectFill
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.clipsToBounds = true
        
        contentView.addSubview(movieImage)
    }
    
    func layoutMovieImage() {
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10),
            movieImage.widthAnchor.constraint(equalToConstant:80),
            movieImage.heightAnchor.constraint(equalToConstant:80)
            ])
    }
    
    func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        
        contentView.addSubview(containerView)
        
    }
    
    func layoutContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo:self.movieImage.trailingAnchor, constant:10),
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20),
            containerView.heightAnchor.constraint(equalToConstant:90)
            ])
    }
    
    func setupMovieTitle() {
        movieTitle.font = UIFont.boldSystemFont(ofSize: 20)
        movieTitle.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(movieTitle)
    }
    
    func layoutMovieTitle() {
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor),
            movieTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor)
            ])
    }
    
    func setupMovieYear() {
        movieYear.font = UIFont.boldSystemFont(ofSize: 14)
        movieYear.textColor = UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        movieYear.layer.cornerRadius = 5
        movieYear.clipsToBounds = true
        
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(movieYear)
    }
    
    func layoutMovieYear() {
        NSLayoutConstraint.activate([
            movieYear.topAnchor.constraint(equalTo:self.movieTitle.bottomAnchor, constant: 13.0),
            movieYear.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor)
            ])
    }
    
    
    func setupMovieRating() {
        movieRating.font = UIFont.boldSystemFont(ofSize: 14)
        movieRating.textColor = UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        movieRating.layer.cornerRadius = 5
        movieRating.clipsToBounds = true
        
        movieRating.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(movieRating)
    }
    
    func layoutMovieRating() {
        NSLayoutConstraint.activate([
            movieRating.topAnchor.constraint(equalTo:self.movieYear.bottomAnchor, constant: 13.0),
            movieRating.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor)
            ])
    }
    
    
    
    
    func  setupFavButton() {
        favButton.setTitle("Like", for: .normal)
        favButton.isEnabled = true
        favButton.layer.cornerRadius = 5
        favButton.backgroundColor = Colors.primary
        favButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favButton)
    }
    
    func layoutFavButton() {
        NSLayoutConstraint.activate([
            favButton.widthAnchor.constraint(equalToConstant:70),
            favButton.heightAnchor.constraint(equalToConstant:36),
            favButton.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20),
            favButton.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            favButton.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5.0)
            ])
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
