//
//  MovieListViewController.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/20.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")


    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.MoviePosterView.moviePosterImageView.backgroundColor = .brown
        
        return cell
    }
    
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .yellow
        cell.movieListCollectionView.backgroundColor = .blue
        cell.movieListCollectionView.delegate = self
        cell.movieListCollectionView.dataSource = self
        cell.movieListCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        
        return cell
    }
    
    
}
