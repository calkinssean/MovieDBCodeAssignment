//
//  ViewController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var movieDBImageView: UIImageView!
    
    //MARK: - Properties
    var searchedText = ""
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //return image to regluar size/alpha before view appears
        self.movieDBImageView.transform = CGAffineTransformIdentity
        self.movieDBImageView.alpha = 1
        
    }
    
    //MARK: - Search tapped
    @IBAction func searchTapped(sender: UIButton) {
        
        self.animateAndPerformSegue()
    }
    
    //MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == self.textField {
            
            textField.resignFirstResponder()
            
            self.animateAndPerformSegue()
            
        }
        
        return true
    }
    
    //MARK: - Animate and perform segue
    func animateAndPerformSegue() {
        
        if self.textField.text != "" {
            
            //animation make the image 10x bigger and fade out
            UIView.animateWithDuration(1, animations: {
                
                self.movieDBImageView.transform = CGAffineTransformMakeScale(10, 10)
                self.movieDBImageView.alpha = 0
                
            }) { (animated) in
                
                UIView.animateWithDuration(0, animations: {
                    
                    self.performSegueWithIdentifier("ShowMovieTableViewSegue", sender: self)
                    
                })
            }
        } else {
            presentAlert("Please enter a movie title")
        }
    }
    
    //MARK: - Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMovieTableViewSegue" {
            
            if let text = self.textField.text {
                
                //replace spaces with "+" for search
                let movieSearched = text.stringByReplacingOccurrencesOfString(" ", withString: "+", options: .CaseInsensitiveSearch, range: nil)
                
                if let escapedSearchTerm = movieSearched.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()) {
                    
                    self.searchedText = escapedSearchTerm
                    
                    let controller = segue.destinationViewController as! MovieTableViewController
                    controller.searchedText = self.searchedText
                    
                }
            }
        }
    }
    
    //MARK: - Present alert
    func presentAlert(message: String) {
        
        let alert = UIAlertController(title: "\(message)",
                                      message: nil,
                                      preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Ok", style: .Default) { (action: UIAlertAction) -> Void in
            
        }
        
        alert.addAction(action)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }
}

