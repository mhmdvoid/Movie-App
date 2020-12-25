import UIKit

// Consumer class
class MovieService: ServiceI{
    static let shared = MovieService()
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "088955d1b779a7505b0c05185c5a2c84"
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchMovies(with endpoint: APIEndpoint, completion: @escaping (Result<MovieManager, Error>) -> ()) {
        let formattedURL = "\(baseURL)movie/\(endpoint.endpointDescription)?api_key=\(apiKey)"
        
        guard let url = URL(string: formattedURL) else {
            print("FAKE URL")
            return
            
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true

        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { (data, res , e) in
            
            // Call back for fetching data// Fetching is done we call the completion
            if let e = e {
                
                return completion(.failure(e))
            }
            guard let data = data else {
                print("FAKE DATA")
                return
                
            }
            
            do {
                let movieData = try JSONDecoder().decode(MovieManager.self, from: data)
                
                completion(.success(movieData))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            
        }
        
        task.resume()
        
    }
    
    func downloadCachedImage(fromUrl imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: imageUrl)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data , res, e) in
            guard let self = self ,
                e == nil ,
                let response = res as? HTTPURLResponse, response.statusCode == 200,
                let data = data ,
                let image = UIImage(data: data) else  {
                    completion(nil)
                    return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
    
    func fetchMovie(withId movieId: Int, appendTo: [ExtraResponse],  completion: @escaping (Result<Any, Error>) -> () ) {
        
        let stringArray = appendTo.map { $0.rawValue }
        let newString = stringArray.joined(separator: ",")
        let formattedURL = "\(baseURL)movie/\(movieId)?api_key=\(apiKey)&append_to_response=\(newString)"

        guard let url = URL(string: formattedURL) else {
            print("FAKE URL")
            return
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true

        let session = URLSession(configuration: configuration)
        
        
        let task = session.dataTask(with: url) { (data, res , e) in
            if let e = e {
                
                return completion(.failure(e))
            }
            guard let data = data else {
                print("FAKE DATA")
                return
            }
            
            do {
                let theMovie = try JSONDecoder().decode(MovieDetail.self , from: data)
                completion(.success(theMovie))
                
            } catch (let jsonError)  {
                completion(.failure(jsonError))  // Enum with associated values or with callBack
                
            }
            
        }
        task.resume()
    }
}


// let's create a dependency inversion principle

protocol ServiceI{
    // Abstraction shouldn't depend on details
//    associatedtype E
    func fetchMovie(withId movieId: Int, appendTo: [ExtraResponse], completion: @escaping (Result<Any, Error>) -> ())
}

//class DetailConcreteObj: ServiceI {
//    // this is a low-level that depends on the abstraction
//    private let baseURL = "https://api.themoviedb.org/3/"
//    private let apiKey = "088955d1b779a7505b0c05185c5a2c84"
//    func fetch(completion: @escaping (Result<Any, Error>) -> ()) {
//        let formattedURL = "\(baseURL)movie/\("popular")?api_key=\(apiKey)"
//
//        guard let url = URL(string: formattedURL) else {
//            print("FAKE URL")
//            return
//
//        }
//        URLSession.shared.dataTask(with: url) { (data , res , e ) in
//
//            if let e = e {
//                completion(.failure(e))
//                return
//            }
//
//
//            guard let data = data else {return}
//            do {
//                let decodedData = try JSONDecoder().decode(MovieManager.self , from: data)
//                completion(.success(decodedData ))
//            } catch let jsonError {
//                completion(.failure(jsonError))
//            }
//        }.resume()
//    }
//}
//
//// High level moduls
//class ConsumerController {
//
//    var service: ServiceI
//    init (service: ServiceI)
//    {
//        self.service = service
//        service.fetch { (<#Result<Any, Error>#>) in
//            <#code#>
//        }
//    }
//
//}

