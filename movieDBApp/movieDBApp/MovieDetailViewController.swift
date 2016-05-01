//
//  MovieDetailViewController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var currentMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadImageFromURL("https://image.tmdb.org/t/p/w185\(currentMovie.poster_path)", imageView: self.backdropImageView)
        
        self.movieTitleLabel.text = currentMovie.title
        
        self.movieDescriptionLabel.text = currentMovie.overview
      
    }


    func loadImageFromURL(urlString: String, imageView: UIImageView) {
        
        if urlString.isEmpty == false {
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if let url = NSURL(string: urlString) {
                    
                    if let data = NSData(contentsOfURL: url) {
                        
                        let image = UIImage(data: data)
                        
                        imageView.image = image
                    }
                }
            })
        } else {
            debugPrint("Invalid \(urlString)")
        }
    }
    
}
