//
//  APIController.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import Foundation

class APIController {
    
    var moviesArray = [Movie]()
    var delegate: MoviesAppProtocol?

    init(delegate: MovieTableViewController) {
        
        self.delegate = delegate
        
    }
    
    func getMovieJSON(searchedMovie: String) {
        
        let urlString = "http://api.themoviedb.org/3/search/movie?query=\(searchedMovie)&api_key=4d1355b8a171e371b07a28ed85403734"
        
        if let url = NSURL(string: urlString) {
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) in
                
                if error != nil {
                    
                    debugPrint("There was an error dataTaskWithURL")
                    
                } else {
                    
                    if let data = data {
                        
                        do {
                            
                            if let dict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONDictionary {
                                
                                if let results = dict["results"] as? JSONArray {
                                    
                                    for result in results {
                                        
                                        let m = Movie(dict: result)
                                        
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