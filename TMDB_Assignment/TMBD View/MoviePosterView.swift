//
//  moviePosterView.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

class MoviePosterView: UIView {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "MoviePosterView", bundle: nil).instantiate(withOwner: self).first as! UIView //first는 xib파일안에 뷰 중 어떤 뷰를 쓸지 지정하는 의미
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
