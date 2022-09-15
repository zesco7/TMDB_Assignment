//
//  TMDBTableViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/15.
//

import UIKit

class TMDBTableViewCell: UITableViewCell {
    static var identifier = "TMDBTableViewCell"

    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var TMDBUiView: UIView!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieCast: UILabel!
    @IBOutlet weak var divisionLineUiView: UIView!
    @IBOutlet weak var detailInformationLabel: UILabel!
    @IBOutlet weak var detailInformationButton: UIButton!
    
    func configureCell() {
        ratingLabel.text = "평점"
        ratingLabel.backgroundColor = .purple
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        
        ratingNumberLabel.textAlignment = .center

        releasedDateLabel.font = .systemFont(ofSize: 12)
        genreLabel.font = .systemFont(ofSize: 17, weight: .bold)
        movieTitle.font = .systemFont(ofSize: 17, weight: .bold)
        movieCast.font = .systemFont(ofSize: 14)
        detailInformationLabel.font = .systemFont(ofSize: 14)
        
        clipButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        clipButton.tintColor = .systemGray5

        divisionLineUiView.backgroundColor = .black
        
        detailInformationButton.tintColor = .black
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
