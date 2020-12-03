//
//  Cast.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 26/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import Foundation
import UIKit

struct Credit: Codable {
    let cast: [Cast]
}
struct Cast: Codable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let known_for_department: String
    let name: String
    let original_name: String
    let popularity: Double
    let profile_path: String?
    let cast_id: Int
    let character: String
    let credit_id: String
}

//
//protocol Service {
////    associatedtype T
//    func fetchAll(completion: @escaping (Result<Any, Error>) -> () )
//    func fetchDetails(_ with: Any, completion: @escaping (Result<Any, Error>) -> ())
//}
//extension Service {
//    func fetchAll(completion: @escaping (Result<Any, Error>) -> () ) {
//        
//    }
//}
//class MovieAPI: Service {
//    func fetchAll(completion: @escaping (Result<Any, Error>) -> ()) {
//        <#code#>
//    }
//    func fetchDetails(_ with: Any, completion: @escaping (Result<Any, Error>) -> ()) {
//        
//    }
//    
//
//    
//}
