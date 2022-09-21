//
//  StarView.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

class StarView: UIView {

    @IBOutlet weak var starImageView: UIImageView!
    
    required init?(coder: NSCoder) { //required 붙어있으면 프로토콜내에서 초기화 등록 된것임
        super.init(coder: coder)
        
        let view = UINib(nibName: "StarView", bundle: nil).instantiate(withOwner: self).first as! UIView //first는 xib파일안에 뷰 중 어떤 뷰를 쓸지 지정하는 의미
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view) //CardView파일에 view를 추가해달라는 의미
}
}
