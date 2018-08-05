//
//  ViewController.swift
//  MoviesTask
//
//  Created by TR on 8/3/18.
//  Copyright © 2018 mine. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.primary
        Create_Stack_Contain_Buttons_And_Animated()
        
    }
    
    
    private func Create_Stack_Contain_Buttons_And_Animated()  {
        
        
        let top = CGAffineTransform(translationX: 0, y: -(view.frame.height - view.frame.height / 3))
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: CreateButtons(named: "Open Search" , "Open Favorites" ))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        view.addSubview(backgroundView)
        view.addSubview(stackView)
        
        // constraints Code
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor , constant:20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor , constant:-20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:view.frame.height / 2).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height / 2  - view.frame.height / 5).isActive = true
        
        
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor , constant:0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor , constant:0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:0).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        
        //Animation Code
        
        
        UIView.animate(withDuration: 0.4, delay: 1, options: [], animations: {
            // Add the transformation in this block
            // self.container is your view that you want to animate
            stackView.transform = top
        }, completion: nil)
        
        
        
    }
    
    
    
    private func CreateButtons(named:String...)->[UIButton]{
        
        return named.map { name in
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(name, for: .normal)
            button.backgroundColor = Colors.button
            button.layer.cornerRadius =  5
            button.clipsToBounds = true
            button.setTitleColor(UIColor.white, for: .normal)
            button.sendActions(for: .touchUpInside)
            if name == "Open Search" {
                button.addTarget(self, action: #selector(openSearchView), for: .touchUpInside)
            }else{
                button.addTarget(self, action: #selector(openFavoriteView), for: .touchUpInside)
            }
            
            return button
        }
        
    }
    
    @objc func openSearchView() {
        let newViewController = SearchMoviesViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    
    
    @objc func openFavoriteView() {
        let newViewController = FavoriteMoviesViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        navigationItem.title = "Home"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = Colors.primary
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    
    
}


