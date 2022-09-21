//
//  moviePosterListViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

/*질문
 -. 테이블뷰 categoryLabel이 왜 배열 첫번째 값으로만 뜨는지? categoryList 배열 인덱싱 잘 되어있고, 데이터 초기화 문제도 없는데? -> 해결: indexPath.row 아니라 indexPath.section으로 인덱스 설정해야함.(태그순서대로 적용되어야하기 때문)
 -. 컬렉션뷰 배경색 적용 어떻게 하는지? 색상적용해도 반영이 안됨.
 -. 콘텐츠제목 만들때 self.categoryList = APIManager.shared.movieList.map { $0.0 } 처럼 빈배열에 값받아와서 작성하면 굳이 불필요한 통신을 한번 더 요청하는 게 되는건지?
 -. 
 */

class MoviePosterListViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    var contentsList : [[Int]] = [
        [Int](1...5),
        [Int](10...15),
        [Int](20...35),
        [Int](30...55),
        [Int](40...85)
    ]
    
    var posterList = Array<[String]>()
    var categoryList = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.backgroundColor = .black
        
        APIManager.shared.requestRecommendations { poster_path in
            dump(poster_path)
            self.posterList = poster_path
            self.categoryList = APIManager.shared.movieList.map { $0.0 }
            
            DispatchQueue.main.async {
                self.movieListTableView.reloadData() //네트워크 통신 후 데이터갱신
            }
        }
        
    }
}

extension MoviePosterListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return posterList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePosterListTableViewCell", for: indexPath) as? MoviePosterListTableViewCell else { return UITableViewCell() }
        cell.contentsCollectionView.delegate = self
        cell.contentsCollectionView.dataSource = self
        cell.contentsCollectionView.register(UINib(nibName: "ContentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ContentsCollectionViewCell")
        cell.contentsCollectionView.tag = indexPath.section
        //cell.categoryLabel.text = "\(categoryList[indexPath.section])의 비슷한 콘텐츠"
        cell.categoryLabel.text = "\(APIManager.shared.movieList[indexPath.section].0)의 비슷한 콘텐츠"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension MoviePosterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCollectionViewCell", for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        //cell.moviePosterView.indexLabel.text = "\(contentsList[collectionView.tag][indexPath.item])"
        
        let url = URL(string: "\(EndPoint.imageURL)\(posterList[collectionView.tag][indexPath.item])")
        cell.moviePosterView.moviePosterImageView.kf.setImage(with: url)
        
        return cell
    }
}
