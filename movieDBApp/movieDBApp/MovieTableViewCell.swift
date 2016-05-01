//
//  MovieTableViewCell.swift
//  movieDBApp
//
//  Created by Sean Calkins on 4/30/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Load image from URL
    func loadImageFromURL(urlString: String) {
        
        if urlString.isEmpty == false {
        
            dispatch_async(dispatch_get_main_queue(), {
                
                if let url = NSURL(string: urlString) {
                    
                    if let data = NSData(contentsOfURL: url) {
                        
                        self.movieImageView.image = UIImage(data: data)
                    }
                }
            })
        } else {
            debugPrint("Invalid \(urlString)")
        }
    }

}
