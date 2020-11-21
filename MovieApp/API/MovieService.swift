import UIKit


class MovieService {
    static let shared = MovieService()
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "088955d1b779a7505b0c05185c5a2c84"
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchMovies(with endpoint: APIEndpoint, completion: @escaping (Result<MovieManager, Error>) -> ()) {
        let formattedURL = "\(baseURL)movie/\(endpoint.endpointDescription)?api_key=\(apiKey)"
        print("URL \(formattedURL)")
        guard let url = URL(string: formattedURL) else {
            print("FAKE URL")
            return
            
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, res , e) in
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
    
    
    func fetchMovie(withId movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> () ) {
        let formattedURL = "\(baseURL)movie/\(movieId)?api_key=\(apiKey)"
        print("URL \(formattedURL)")
        guard let url = URL(string: formattedURL) else {
            print("FAKE URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
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
