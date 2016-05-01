//
//  MovieDetailViewController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var posterPathImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var noPosterPathLabel: UILabel!
    
    //MARK: - Properties
    var currentMovie = Movie()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.currentMovie.backdrop_path == "" {
            
            self.noImageLabel.hidden = false
            
        }
        
        if self.currentMovie.poster_path == "" {
            
            self.noPosterPathLabel.hidden = false
        }
        
        self.loadImageFromURL("https://image.tmdb.org/t/p/w185\(currentMovie.poster_path)", imageView: self.posterPathImageView)
        
        self.loadImageFromURL("https://image.tmdb.org/t/p/w185\(currentMovie.backdrop_path)", imageView: self.backdropImageView)
        
        self.movieTitleLabel.text = currentMovie.title
        
        self.movieDescriptionLabel.text = currentMovie.overview
        
        self.ratingLabel.text = "\(currentMovie.vote_average)/10"
        
    }
    
    //MARK: - Load image from url
    func loadImageFromURL(urlString: String, imageView: UIImageView) {
        
        //Check for valid url string
        if urlString.isEmpty == false {
            
            if let url = NSURL(string: urlString) {
                
                let session = NSURLSession.sharedSession()
                
                let task = session.dataTaskWithURL(url, completionHandler: {
                    
                    (data, response, error) in
                    
                    //If there is an error, skip the rest of the code
                    if error != nil {
                        
                        debugPrint("An error occurred \(error)")
                        return
                    }
                    
                    let theFinalImage = UIImage(data: data!)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        imageView.image = theFinalImage
                    })
                })
                task.resume()
                
            } else {
                print("Not a valid url")
            }
        } else {
            debugPrint("Invalid \(urlString)")
        }
    }
}
