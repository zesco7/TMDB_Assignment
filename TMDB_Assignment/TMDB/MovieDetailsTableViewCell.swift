//
//  MovieDetailsTableViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/16.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    static var identifier = "MovieDetailsTableViewCell"
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
