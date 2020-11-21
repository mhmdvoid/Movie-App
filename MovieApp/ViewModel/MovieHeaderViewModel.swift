import UIKit

// the logic and computed + dynamic data will be displayed into the view = to populate the view UI with computed data 
struct MovieViewModel {
    let movie: MovieDetail
    
    var scoreBreakdown: String {
        let movieVoteAverage = "\(Int(movie.vote_average * 10))%"
        return movieVoteAverage
    }
    var ratingsNumber: String {
        let voteCount: Int = movie.vote_count
        return "\(voteCount) ratings"
    }
    
    var moviePoster: URL? {
        guard let poster = movie.poster_path else { return nil }
        
        let formattedUrl = "https://image.tmdb.org/t/p/\(IMAGE_QUALITY)\(poster)"
        
        return URL(string: formattedUrl)
      
    }
    
    var movieOverview: NSAttributedString? {
        guard let overview = movie.overview else { return nil}
        let attributedText = NSMutableAttributedString(string: "Overview:\n", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        
        attributedText.append(NSAttributedString(string: overview, attributes: [.font: UIFont.systemFont(ofSize: 16)]))
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 4
//        let range = NSMakeRange(0, attributedText.length)
//        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        return attributedText
    }
    
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = movie.overview
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
