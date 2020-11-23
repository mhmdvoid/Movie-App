import UIKit

class MovieVC: UITableViewController {
    
    let theMovieId: Int
    let backButtonString: String
    var movieGeners: [Generis]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var theMovie: MovieDetail? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    
    
    init(theMovieId: Int, backButtonTitle: String) {
        self.theMovieId = theMovieId
        self.backButtonString = backButtonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Details"
        setupTableView()
        
        fetchMovie()
    }
    
    // MARK: API
    fileprivate func fetchMovie() {
        MovieService.shared.fetchMovie(withId: theMovieId) { (result) in
            switch result {
            case .success(let theMovie):
                self.theMovie = theMovie
                self.movieGeners = theMovie.genres
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
    
    fileprivate func setupTableView() {
        tableView.register(MovieDetailCell.self , forCellReuseIdentifier: MovieDetailCell.movieCellId)
        tableView.register(MovieHeader.self , forCellReuseIdentifier: MovieHeader.headerCell)
        tableView.separatorStyle = .none
        setupFooter()
    }
    
    fileprivate func setupFooter() {
        let footer = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 250))
        footer
            .backgroundColor = .red
        tableView.tableFooterView = footer
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieHeader.headerCell) as! MovieHeader
            
            cell.theMovie = theMovie
            cell.geners = self.movieGeners
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.movieCellId) as! MovieDetailCell
        cell.theMovie = theMovie
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 220 : UITableView.automaticDimension
    }
}
