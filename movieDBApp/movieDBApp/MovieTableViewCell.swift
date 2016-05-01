//
//  MovieTableViewCell.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var backdropView: UIView!
    
    //MARK: - Load image from URL
    func loadImageFromURL(urlString: String) {
        
        //check for existing url string
        if urlString.isEmpty == false {
            
            if let url = NSURL(string: urlString) {
                
                let session = NSURLSession.sharedSession()
                
                let task = session.dataTaskWithURL(url, completionHandler: {
                    
                    (data, response, error) in
                    
                    //skip the rest of the code if there is an error
                    if error != nil {
                        
                        debugPrint("An error occurred \(error)")
                        return
                    }
                    
                    //create image from data
                    let image = UIImage(data: data!)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.movieImageView.image = image
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
