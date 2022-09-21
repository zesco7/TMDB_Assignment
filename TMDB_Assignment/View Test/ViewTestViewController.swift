//
//  ViewTestViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/21.
//

import UIKit

class ViewTestViewController: UIViewController {

    @IBOutlet weak var starCollectionView: UICollectionView!
    @IBOutlet weak var starTableView: UITableView!
    
    var colorList : [UIColor] = [.green, .brown, .blue, .yellow, .systemPink]
    var titleList = ["인기콘텐츠1", "인기콘텐츠2", "인기콘텐츠3", "인기콘텐츠4", "인기콘텐츠5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starCollectionView.delegate = self
        starCollectionView.dataSource = self
        starCollectionView.register(UINib(nibName: "StarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StarCollectionViewCell")
        starCollectionView.collectionViewLayout = starCollectionViewLayout()
        starCollectionView.isPagingEnabled = true
        
        starTableView.delegate = self
        starTableView.dataSource = self
    }
}

extension ViewTestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == starCollectionView ? colorList.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCollectionViewCell", for: indexPath) as? StarCollectionViewCell else { return UICollectionViewCell() }

        if collectionView == starCollectionView {
        cell.starView.starImageView.backgroundColor = colorList[indexPath.item]
        } else {
            cell.starView.starImageView.backgroundColor = collectionView.tag.isMultiple(of: 2) ? .black : .white
        }
        
        return cell
    }
    
    func starCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: starCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
}

extension ViewTestViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return colorList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StarTableViewCell", for: indexPath) as? StarTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .green
        cell.contentsCollectionView.delegate = self
        cell.contentsCollectionView.dataSource = self
        cell.contentsCollectionView.register(UINib(nibName: "StarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StarCollectionViewCell")
        cell.contentsCollectionView.tag = indexPath.section
        cell.titleLabel.text = titleList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}
