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
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieCast: UILabel!
    @IBOutlet weak var divisionLineUiView: UIView!
    @IBOutlet weak var detailInformationLabel: UILabel!
    @IBOutlet weak var detailInformationButton: UIButton!
    
    func configureCell() {
        TMDBUiView.layer.borderWidth = 1
        TMDBUiView.layer.cornerRadius = 10
        
        movieImageView.contentMode = .scaleToFill
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] //위쪽 모서리만 둥글게 처리
        movieImageView.layer.masksToBounds = true
        
        ratingLabel.text = "평점"
        ratingLabel.backgroundColor = .systemBlue
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        
        ratingNumberLabel.textAlignment = .center
        ratingNumberLabel.backgroundColor = .white

        releasedDateLabel.font = .systemFont(ofSize: 12)
        genreLabel.font = .systemFont(ofSize: 17, weight: .bold)
        movieTitle.font = .systemFont(ofSize: 17, weight: .bold)
        movieCast.font = .systemFont(ofSize: 14)
        detailInformationLabel.font = .systemFont(ofSize: 14)
        
        clipButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        clipButton.tintColor = .white
    
        divisionLineUiView.backgroundColor = .black
        
        detailInformationButton.setImage(UIImage(systemName: "chevron.compact.right"), for: .normal)
        detailInformationButton.tintColor = .black
        
    }
    
}
