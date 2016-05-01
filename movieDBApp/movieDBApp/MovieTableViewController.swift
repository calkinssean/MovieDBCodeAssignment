//
//  MovieTableViewController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol MoviesAppProtocol {
    
    func passMovie(movie: Movie)
}

class MovieTableViewController: UITableViewController, MoviesAppProtocol {
    
    //MARK: - Properties
    var moviesArray = [Movie]()
    var currentMovie = Movie()
    var apiClient: APIController?
    var searchedText = ""
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiClient = APIController(delegate: self)
        
        //api call with searched text
        apiClient?.getMovieJSON(searchedText)
        
    }
    
    //MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArray.count == 0 {
            
            return 1
            
        } else {
            
            return moviesArray.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150
    }
    
    //Setting up the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Movie Cell", forIndexPath: indexPath) as! MovieTableViewCell
        
        cell.noImageLabel.hidden = true
        
        if moviesArray.count != 0 {
            
            let m = moviesArray[indexPath.row]
            
            cell.activityIndicator.hidden = false
            cell.backdropView.hidden = false
            cell.noResultsLabel.hidden = true
            cell.descriptionLabel.hidden = false
            cell.titleLabel.hidden = false
            
            cell.titleLabel.text = m.title
            cell.descriptionLabel.text = m.overview
            
            cell.loadImageFromURL("https://image.tmdb.org/t/p/w185\(m.poster_path)")
            
            if m.poster_path == "" {
                
                cell.noImageLabel.hidden = false
                cell.activityIndicator.hidden = true
            }
            
        } else {
            
            cell.backdropView.hidden = true
            cell.titleLabel.hidden = true
            cell.descriptionLabel.hidden = true
            cell.noResultsLabel.hidden = false
            cell.activityIndicator.hidden = true
            
        }
        
        return cell
        
    }
    
    //MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.moviesArray.count != 0 {
            
            self.currentMovie = moviesArray[indexPath.row]
            
            performSegueWithIdentifier("ShowMovieDetailView", sender: self)
            
        }
    }
    
    //MARK: - Delegate method
    func passMovie(movie: Movie) {
        
        self.moviesArray.append(movie)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
            
        })
    }
    
    //MARK: - Prepre for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowMovieDetailView" {
            
            let controller = segue.destinationViewController as! MovieDetailViewController
            
            controller.currentMovie = self.currentMovie
            
        }
    }
}
