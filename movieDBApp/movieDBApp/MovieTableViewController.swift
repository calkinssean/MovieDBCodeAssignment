//
//  MovieTableViewController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

protocol MoviesAppProtocol {
    func passMovie(movie: Movie)
}

class MovieTableViewController: UITableViewController, MoviesAppProtocol {
    
    var moviesArray = [Movie]()
    var currentMovie = Movie()
    var apiClient: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiClient = APIController(delegate: self)
        
        }
    
    //MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let m = moviesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Movie Cell", forIndexPath: indexPath) as! MovieTableViewCell
        
        cell.titleLabel.text = m.title
        cell.descriptionLabel.text = m.overview
        cell.loadImageFromURL("https://image.tmdb.org/t/p/w185\(m.poster_path)")
        
        return cell
        
    }
    
    //MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.currentMovie = moviesArray[indexPath.row]
        print(currentMovie.title)
        performSegueWithIdentifier("ShowMovieDetailView", sender: self)
        
    }
    
    func passMovie(movie: Movie) {
        
        self.moviesArray.append(movie)
        print("pass movie called")
        
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