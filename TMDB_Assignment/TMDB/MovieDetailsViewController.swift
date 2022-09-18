//
//  MovieDetailsViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/16.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

/*질문
 -. TMDB화면에서 받은 데이터가 일치하지 않는 이유? 클릭했을 때 시점에서 UserDefaults데이터 받아왔는데 인덱스불일치가 일어날수 있나? -> 해결: 화면전환시 이동전화면에서 데이터 받아와서 이동예정화면 프로퍼티에 저장하고 그 값을 화면에 띄움.(UserDefaults도 데이터 저장을 할 수는 있지만 성격에 맞지 않으므로 사용X)
 */
class MovieDetailsViewController: UIViewController {
    static var identifier = "MovieDetailsViewController"

    @IBOutlet weak var movieDetailTableView: UITableView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movieID: Int? //화면전환시 TMDB 정보수신: 영화ID
    var movieImage: String? //화면전환시 TMDB 정보수신: 영화이미지
    var castArray : [CastModel] = []
    var startPage = 0
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        movieDetailTableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: MovieDetailsTableViewCell.identifier)
    
        let headerImageURL = URL(string: "\(EndPoint.imageURL)" + movieImage!)
        self.movieImageView.kf.setImage(with: headerImageURL)
        
        requestCast(movieId: movieID!)
        movieImageViewAttribute()
    }
    
    func requestCast(movieId: Int) {
        let castUrl = "\(EndPoint.CastURL)\(movieId)/credits?api_key=\(APIKey.TMDBAPIKey)&language=en-US"
        AF.request(castUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for data in json["cast"].arrayValue {
                    let profile_path = data["profile_path"].stringValue
                    let name = data["name"].stringValue
                    let character = data["character"].stringValue
                    self.castArray.append(CastModel(profile: profile_path, actor: name, character: character))
                }
                
                self.movieDetailTableView.reloadData()
                //print(self.castArray)
                
            case .failure(let error):
                print(error)
            }
            //let castURL = "https://api.themoviedb.org/3/movie/852448/images?api_key=9a2ad201c752108bc7ef6648ba28b7ef&language=en-US"
        }
    }

    func movieImageViewAttribute() {
        movieImageView.contentMode = .scaleToFill
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return castArray.count
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
        let imageURL = "https://image.tmdb.org/t/p/w185"
        let profileURL = URL(string: "\(imageURL)"+castArray[indexPath.row].profile)
        cell.actorImageView.kf.setImage(with: profileURL)
        
        cell.actorName.text = castArray[indexPath.row].actor
        cell.characterName.text = castArray[indexPath.row].character
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
