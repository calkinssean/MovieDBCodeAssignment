//
//  APIController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import Foundation

class APIController {
    
    //MARK: - Properties
    var moviesArray = [Movie]()
    var delegate: MoviesAppProtocol?

    init(delegate: MovieTableViewController) {
        
        self.delegate = delegate
        
    }
    
    //MARK: - Get movie JSON
    func getMovieJSON(searchedMovie: String) {
        
        let urlString = "http://api.themoviedb.org/3/search/movie?query=\(searchedMovie)&api_key=4d1355b8a171e371b07a28ed85403734"
        
        if let url = NSURL(string: urlString) {
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) in
                
                //check for error
                if error != nil {
                    
                    debugPrint("There was an error dataTaskWithURL")
                    
                } else {
                    
                    if let data = data {
                        
                        do {
                            
                            if let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONDictionary {
                                
                                if let results = dict["results"] as? JSONArray {
                                    
                                    for result in results {
                                        
                                        //Create a movie object with JSONArray dictionary
                                        let m = Movie(dict: result)
                                        
                                        //Pass movie to table view controller
                                        self.delegate?.passMovie(m)
                                        
                                    }
                                }
                                
                            } else {
                                
                                debugPrint("I couldn't parse the dictionary")
                            
                            }
                            
                        } catch {
                            
                            debugPrint("Couldn't parse the json")
                            
                        }
                    }
                }
            })
            
            task.resume()
            
        } else {
            
            debugPrint("invalid url")
            
        }
    }
}