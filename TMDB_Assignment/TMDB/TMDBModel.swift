//
//  TMDBInformation.swift
//  TMDB_Assignment
//
//  Created by Mac Pro 15 on 2022/09/15.
//

import Foundation

struct TMDBModel {
    let movieImage: String
    let releaseDate: String
    let genre: Any
    let rating: String
    let movieName: String
}

struct GenreModel {
    let genre : [Int: String]
}
