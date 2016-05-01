//
//  ViewController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var movieDBImageView: UIImageView!
    
    var searchedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movieDBImageView.transform = CGAffineTransformIdentity
        self.movieDBImageView.alpha = 1
        
    }
    
    @IBAction func searchTapped(sender: UIButton) {
        
        if let text = self.textField.text {
         
            let movieSearched = text.stringByReplacingOccurrencesOfString(" ", withString: "+", options: .CaseInsensitiveSearch, range: nil)
            
            if let escapedSearchTerm = movieSearched.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()) {
                
                self.searchedText = escapedSearchTerm
                
            }
        }
        
        UIView.animateWithDuration(1, animations: {
            
            self.movieDBImageView.transform = CGAffineTransformMakeScale(10, 10)
            self.movieDBImageView.alpha = 0
            
        }) { (animated) in
            
            UIView.animateWithDuration(0, animations: {
                
                self.performSegueWithIdentifier("ShowMovieTableViewSegue", sender: self)
                
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMovieTableViewSegue" {
            
            let controller = segue.destinationViewController as! MovieTableViewController
            controller.searchedText = self.searchedText
            
        }
    }
}

