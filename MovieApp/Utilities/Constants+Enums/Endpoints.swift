import UIKit

public enum APIEndpoint: Int, CaseIterable {
    case popular
    case nowPlaying
    case topRated
    case upcoming
//    "https://api.themoviedb.org/3/movie/now_playing?api_key=088955d1b779a7505b0c05185c5a2c84&language=en-US"
    
    var endpointDescription: String {
        switch self {
        case .popular:
            return "popular"
        case .nowPlaying:
            return "now_playing"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
    
    var headerTitle: String {
        switch self {
        case .popular :
            return "Popular"
        case .nowPlaying :
            return "Now Playing"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
