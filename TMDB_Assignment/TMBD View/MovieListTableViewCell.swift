//
//  MovieListTableViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/20.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    static var identifier = "MovieListTableViewCell"

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        categoryLabel.font = .boldSystemFont(ofSize: 24)
        categoryLabel.text = "아는와이프와 비슷한 콘텐츠"
        categoryLabel.backgroundColor = .clear
        
        movieListCollectionView.backgroundColor = .clear
        movieListCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 130) //셀가로: 화면가로, 셀세로를 콜렉션뷰 세로만큼으로 지정
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
