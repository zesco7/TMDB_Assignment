//
//  moviePosterListViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

/*질문
 -. 테이블뷰 categoryLabel이 왜 배열 첫번째 값으로만 뜨는지? categoryList 배열 인덱싱 잘 되어있고, 데이터 초기화 문제도 없는데?
 -. 컬렉션뷰 배경색 적용 어떻게 하는지? 색상적용해도 반영이 안됨.
 */

class MoviePosterListViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    var categoryList = ["아는 와이프와 비슷한 콘텐츠", "미스터 선샤인과 비슷한 콘텐츠", "액션SF", "미국TV프로그램", "한국TV프로그램"]
    var contentsList : [[Int]] = [
        [Int](1...5),
        [Int](10...15),
        [Int](20...35),
        [Int](30...55),
        [Int](40...85)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.backgroundColor = .black
     
    }
}

extension MoviePosterListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
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
        cell.categoryLabel.text = categoryList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension MoviePosterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCollectionViewCell", for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        cell.moviePosterView.indexLabel.text = "\(contentsList[collectionView.tag][indexPath.item])"
        
        return cell
    }
}
