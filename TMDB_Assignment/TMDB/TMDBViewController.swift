//
//  TMDBViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/15.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TMDBViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TMDBtableView: UITableView!
    
    var TMDBArray : [TMDBModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TMDBtableView.delegate = self
        TMDBtableView.dataSource = self
        searchBar.delegate = self
        TMDBtableView.register(UINib(nibName: "TMDBTableViewCell", bundle: nil), forCellReuseIdentifier: TMDBTableViewCell.identifier)
        
        requestTMDB()
    }
    
    func requestTMDB() {
        let url = "\(EndPoint.TMDBURL)api_key=\(APIKey.TMDBAPIKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for data in json["results"].arrayValue {
                    let release_date = data["release_date"].stringValue //개봉일
                    let genre_ids = data["genre_ids"].stringValue //장르
                    let vote_average = data["vote_average"].stringValue //평점
                    let title = data["title"].stringValue //제목
                    self.TMDBArray.append(TMDBModel(releaseDate: release_date, genre: genre_ids, rating: vote_average, name: title))
                }
                self.TMDBtableView.reloadData()
                print(self.TMDBArray)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBarAttribute() {
        
    }
}

extension TMDBViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TMDBArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBTableViewCell.identifier, for: indexPath) as? TMDBTableViewCell else { return UITableViewCell() }
        
        cell.configureCell()
        
        cell.releasedDateLabel.text = TMDBArray[indexPath.row].releaseDate
        cell.genreLabel.text = TMDBArray[indexPath.row].genre
        cell.movieTitle.text = TMDBArray[indexPath.row].name
        cell.ratingNumberLabel.text = TMDBArray[indexPath.row].rating
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
    
    
}
