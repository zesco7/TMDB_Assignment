//
//  IntroFirstViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit

class IntroFirstViewController: UIViewController {
    static var identifier = "IntroFirstViewController"

    @IBOutlet weak var movieIntroduction: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray

        movieIntroduction.text = "비슷한 영화 콘텐츠를 소개해드립니다."
        movieIntroduction.numberOfLines = 0
        movieIntroduction.font = .systemFont(ofSize: 20)
    }
    

}
