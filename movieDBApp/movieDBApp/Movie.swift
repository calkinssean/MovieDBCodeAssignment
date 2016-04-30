//
//  Movie.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import Foundation

class Movie {
    var poster_path: String = ""
    var overview: String = ""
    var release_date: String = ""
    var genre_ids: [Int] = []
    var movieId: Int = 0
    var original_title: String = ""
    var original_language: String = ""
    var title: String = ""
    var backdrop_path: String = ""
    var popularity: Double = 0
    var vote_count: Int = 0
    var vote_average: Double = 0
    
    init() {
    }
    
    init(dict: JSONDictionary) {
        
        if let poster_path = dict["poster_path"] as? String {
            self.poster_path = poster_path
        } else {
            print("error with poster path")
        }
        if let overview = dict["overview"] as? String {
            self.overview = overview
        } else {
            print("error with overview")
        }
        if let release_date = dict["release_date"] as? String {
            self.release_date = release_date
        } else {
            print("error with release_date")
        }
        if let genre_ids = dict["genre_ids"] as? [Int] {
            self.genre_ids = genre_ids
        } else {
            print("error with genre_ids")
        }
        if let movieId = dict["id"] as? Int {
            self.movieId = movieId
        } else {
            print("error with movieId")
        }
        if let original_language = dict["original_language"] as? String {
            self.original_language = original_language
        } else {
            print("error with original_language")
        }
        if let title = dict["title"] as? String {
            self.title = title
        } else {
            print("error with title")
        }
        if let backdrop_path = dict["backdrop_path"] as? String {
            self.backdrop_path = backdrop_path
        } else {
            print("error with backdrop_path")
        }
        if let popularity = dict["popularity"] as? Double {
            self.popularity = popularity
        } else {
            print("error with popularity")
        }
        if let vote_count = dict["vote_count"] as? Int {
            self.vote_count = vote_count
        } else {
            print("error with vote_count")
        }
        if let vote_average = dict["vote_average"] as? Double {
            self.vote_average = vote_average
        } else {
            print("error with vote_average")
        }
    }
}