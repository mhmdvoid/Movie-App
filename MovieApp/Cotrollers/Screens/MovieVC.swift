import UIKit


enum ExtraResponse: String{
    case credits = "credits"
    case similar = "similar"
}

class MovieVC: UITableViewController {
    private let c = AnimatorList()
    func startAnimating() {
        addChild(c)
        view.addSubview(c.view)
        c.didMove(toParent: self)
        c.height = c.view.frame.height
        fillToEdege(yourView: c.view)
        c.prepareCustomCell(MovieDetailShimmer.self, reuseIdentifier: "reuseIden")
        
    }
    fileprivate func fillToEdege(yourView: UIView) {
        
        [
            yourView.topAnchor.constraint(equalTo: view.topAnchor),
            yourView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yourView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            yourView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ].forEach { $0.isActive = true }
    }
    
    deinit {
        print("MovidVC deallocate")
    }
    let movieId: Int
    let backButtonString: String
    var service : ServiceI
    
    var theMovie: MovieDetail? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideAnimation()
                self.tableView.reloadData()
            }
        }
    }
    private final func hideAnimation() {
          c.willMove(toParent: nil)
          c.view.removeFromSuperview()
          c.removeFromParent()
      }
//    private let activityIndicator: UIActivityIndicatorView = {
//        let ai = UIActivityIndicatorView(style: .large)
//        ai.color = .systemRed
//        return ai
//    }()
    
    init(service: ServiceI, movieId: Int, backButtonTitle: String) {
        self.movieId = movieId
        self.backButtonString = backButtonTitle
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        startAnimating()
        super.viewDidLoad()
//        view.addSubview(activityIndicator)
//        activityIndicator.center(inView: view)
//        activityIndicator.startAnimating()
        navigationItem.title = "Details"
        setupTableView()
        changeBackButtonTitle(withTitle: backButtonString)
        fetchMovie()
    }
    
    // MARK: API
    fileprivate func fetchMovie() {
        
        service.fetchMovie(withId: movieId, appendTo: [.credits, .similar]) { [weak self] res in
            switch res {
            case .success(let theMovie):
                self?.theMovie = theMovie as? MovieDetail
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
        
    }
    
    
    // MARK: Helpers
    
    private func changeBackButtonTitle(withTitle title: String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        backButton.tintColor = .systemRed
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    fileprivate func setupTableView() {
        tableView.register(multiple: MovieDetailCell.self, MovieHeader.self, MovieFooterContainer.self, MovieTitleCell.self, MovieTitleCell.self)
        
        tableView.contentInset = .init(top: 7, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTitleCell.id) as! MovieTitleCell
            cell.theMovie = theMovie
            cell.backgroundColor = .systemBackground
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieHeader.id) as! MovieHeader
            cell.theMovie = theMovie
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.id) as! MovieDetailCell
            
            cell.theMovie = theMovie
            return cell
        case 3:
            let footerCell = tableView.dequeueReusableCell(withIdentifier: MovieFooterContainer.id) as! MovieFooterContainer
            if let theMovie = theMovie {
                footerCell.dataSource = theMovie.credits.cast
                
                footerCell.sectionTitle = FooterTitleSection(rawValue: indexPath.row)
                footerCell.whichRow = indexPath.row
            }
            return footerCell
        case 4:
            
            let footerCell = tableView.dequeueReusableCell(withIdentifier: MovieFooterContainer.id) as! MovieFooterContainer
            if let theMovie = theMovie {
                if theMovie.similar.results.isEmpty {
                    return .init()
                }
                
                footerCell.sectionTitle = FooterTitleSection(rawValue: indexPath.row)
                
                footerCell.dataSource = theMovie.similar.results
                footerCell.whichRow = indexPath.row
            }
            return footerCell
        default:
            return .init()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row  {
        case 0:
            return UITableView.automaticDimension
            
        case 1:
            return 200
            
        case 2:
            return UITableView.automaticDimension
            
        case 3:
            return 160
            
        case 4:
            if let isEmpty = theMovie?.similar.results.isEmpty { if isEmpty { return .zero } }
            return 220
        default:
            return .zero
        }
    }
}

extension UITableView {
    func register(multiple cells: TableCell.Type...) {
        cells.forEach { cell in
            register(cell.self, forCellReuseIdentifier: cell.id)
        }
    }
}
