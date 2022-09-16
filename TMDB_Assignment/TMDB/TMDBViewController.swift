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

/*질문
 -. 이미지주소 앞부분은 TMDB 사이트 어디에 나와있는지? 구글 뒤져서 imageURL 부분 찾음...
 -. 배열로 받은 장르코드 어떻게 해당 장르로 문자변환하는지? 1. AF로 네트워크 통신 또 해야하는지? 2. 코드랑 장르랑 매칭은 어떻게 하는지?
 -. 캐스팅에서 영화코드는 어떻게 받아서 처리하는지?
 -. 테이블뷰에서 UiView 테두리색없이 둥근 모서리 처리 어떻게하는지?
 -. 과제예시에서 화면 상단에 써치바 아니라 네비게이션아이템인건지? 만약 서치바라면 예시처럼 커스텀이 되는지?(구글링에서는 예시처럼 된 커스텀 못찾음)
 -. 받아온 장르데이터를 어떻게 코드에 매칭시키는지? contain 사용? 장르코드 배열 중 첫번째 값이 장르데이터에 있으면 장르로 표시하려고 하는데 조건적용 못하겠음(115행처럼)
 */

class TMDBViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TMDBtableView: UITableView!
    
    var TMDBArray : [TMDBModel] = []
    var movieGenre : [GenreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TMDBtableView.delegate = self
        TMDBtableView.dataSource = self
        searchBar.delegate = self
        TMDBtableView.register(UINib(nibName: "TMDBTableViewCell", bundle: nil), forCellReuseIdentifier: TMDBTableViewCell.identifier)
        
        requestTMDB()
        requestGenre()
    }
    
    func requestTMDB() {
        let url = "\(EndPoint.TMDBURL)api_key=\(APIKey.TMDBAPIKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for data in json["results"].arrayValue {
                    let poster_path = data["poster_path"].stringValue //포스터
                    let release_date = data["release_date"].stringValue //개봉일
                    let genre_ids = data["genre_ids"].arrayObject //장르
                    let vote_average = data["vote_average"].stringValue //평점
                    let title = data["title"].stringValue //제목
                    
                    self.TMDBArray.append(TMDBModel(movieImage: poster_path, releaseDate: release_date, genre: genre_ids!, rating: vote_average, movieName: title))
                }
                self.TMDBtableView.reloadData()
                print(self.TMDBArray[0])
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestGenre() { //장르 데이터 요청
        let url = "\(EndPoint.GenreURL)\(APIKey.TMDBAPIKey)&language=en-US"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for data in json["genres"].arrayValue {
                    let id = data["id"].intValue
                    let name = data["name"].stringValue
                    self.movieGenre.append(GenreModel(genre: [id: name]))
                }
                self.TMDBtableView.reloadData()
                print(self.movieGenre)
                //print(self.movieGenre.contains { $0.genre == 14 })
                
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
        
        //서버통신 시점에서 url변환하면 시간이 더 오래걸릴 수 있기 때문에 셀재사용할 때 url변환하는 것이 좋음
        let imageURL = "https://image.tmdb.org/t/p/w185"
        let url = URL(string: "\(imageURL)\(TMDBArray[indexPath.row].movieImage)") 

        //let castURL = "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(APIKey.TMDBAPIKey)&language=en-US"
        
        cell.movieImageView.kf.setImage(with: url)
        cell.releasedDateLabel.text = TMDBArray[indexPath.row].releaseDate
        cell.genreLabel.text = "\(movieGenre[0].genre.values)"
        //cell.genreLabel.text = "\(TMDBArray[indexPath.row].genre)"
        cell.movieTitle.text = TMDBArray[indexPath.row].movieName
        cell.ratingNumberLabel.text = TMDBArray[indexPath.row].rating
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //
    }
    
    
}
