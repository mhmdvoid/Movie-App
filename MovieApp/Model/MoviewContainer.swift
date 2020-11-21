//
//  MoviewContainer.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 13/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//
import UIKit

struct MovieManager: Codable {
    let page: Int
    let total_results: Int
    let results: [MovieResult]
    let dates: Dates?
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}


struct MovieResult: Codable {
    
    let vote_count: Int
    let poster_path: String?
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let title: String
    let vote_average: Double
    let overview: String
    let release_date: String
    
    
}
