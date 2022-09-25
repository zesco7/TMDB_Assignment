//
//  IntroSecondViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit

class IntroSecondViewController: UIViewController {
    static var identifier = "IntroSecondViewController"

    @IBOutlet weak var contentsRecommendationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray

        contentsRecommendationButton.setTitle("비슷한 영화모음 보러가기", for: .normal)
        contentsRecommendationButton.setTitleColor(UIColor.black, for: .normal)
        contentsRecommendationButton.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    @IBAction func contentsRecommendationButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MoviePosterListViewController") as! MoviePosterListViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
