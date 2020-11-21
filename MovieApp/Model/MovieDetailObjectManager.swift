import UIKit

struct MovieDetail: Codable {
    let adult: Bool
    let backdrop_path: String?
    let belongs_to_collection: BelongToCollection?
    let budget: Int
    let genres: [Generis]
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let original_language: String
    let original_title: String
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompany]
    let production_countries: [ProductionCountry]
    let release_date: String
    let revenue: Int
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

struct BelongToCollection: Codable {
    let id: Int
    let name: String?
    
    let poster_path: String?
    let backdrop_path: String?

}


struct Generis: Codable {
    let id: Int
    let name: String
    
}

struct ProductionCompany: Codable {


    let name: String
    let id: Int
    let logo_path: String?
    let origin_country: String
}


struct ProductionCountry: Codable {
    let name: String
}


struct SpokenLanguage: Codable {
    let name: String
}
