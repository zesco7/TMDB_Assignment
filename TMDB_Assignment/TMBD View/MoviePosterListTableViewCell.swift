//
//  MoviePosterListTableViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

class MoviePosterListTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        categoryLabel.text = "카테고리"
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = .clear
        contentsCollectionView.collectionViewLayout = contentsCollectionViewLayout()
        self.backgroundColor = .black
    }
    
    func contentsCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 130) //셀가로: 화면가로, 셀세로를 콜렉션뷰 세로만큼으로 지정
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
