//
//  ContentsCollectionViewCell.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

/*질문
 -. setupUI 실행되는데 컬렉션뷰 배경색 적용 왜 안되는지?(검정뿐만 아니라 다른색상 전부 적용안됨)
 */
class ContentsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePosterView: MoviePosterView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        moviePosterView.backgroundColor = .black
        moviePosterView.indexLabel.font = .systemFont(ofSize: 30)
        moviePosterView.indexLabel.textColor = .red
    }

}
