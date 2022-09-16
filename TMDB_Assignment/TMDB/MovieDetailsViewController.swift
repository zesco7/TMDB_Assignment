//
//  MovieDetailsViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/16.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    static var identifier = "MovieDetailsViewController"

    @IBOutlet weak var movieDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        movieDetailTableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: MovieDetailsTableViewCell.identifier)
        
    }
    

}
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 100
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Cast"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.identifier, for: indexPath) as? MovieDetailsTableViewCell else { return UITableViewCell() }
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
