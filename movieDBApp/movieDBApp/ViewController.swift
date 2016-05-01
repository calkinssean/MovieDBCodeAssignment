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
    
    var moviesArray = [Movie]()
    var movieAPI: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func searchTapped(sender: UIButton) {
        
        self.moviesArray.removeAll()
        
        if let text = self.textField.text {
            
            movieAPI.getMovieJSON(text)
            
            self.moviesArray = movieAPI!.moviesArray
        
        }
        performSegueWithIdentifier("ShowMovieTableViewSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMovieTableViewSegue" {
            
            let controller = segue.destinationViewController as! MovieTableViewController
            
            controller.moviesArray.removeAll()
            
            controller.moviesArray = self.moviesArray
        }
    }
    
}

