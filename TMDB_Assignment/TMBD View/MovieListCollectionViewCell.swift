//
//  MovieListCollectionViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/20.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var MoviePosterView: MoviePosterView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        MoviePosterView.backgroundColor = .clear
        MoviePosterView.moviePosterImageView.backgroundColor = .green
        MoviePosterView.layer.cornerRadius = 10
    }
}
