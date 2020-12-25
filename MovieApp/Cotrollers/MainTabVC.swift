import UIKit


// Main tab bar tutorial
class MainTabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemRed

        setupTabBar()
    }
    
    fileprivate func setupTabBar() {
        
        let homeList = generateNavController(vc: HomeList(), navTitle: nil, barTitle: "Home", withImage: UIImage(systemName: "house"))
        let searchVC = generateNavController(vc: AnotherVC(), navTitle: "", barTitle: "Search", withImage: UIImage(systemName: "magnifyingglass"))
        viewControllers = [homeList, searchVC]
    }
    
    fileprivate func generateNavController(vc: UIViewController, navTitle: String?, barTitle: String, withImage image: UIImage?) -> UINavigationController {
        if let nav = navTitle {
            vc.navigationItem.title = nav 
        }
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.title = barTitle
        if let image = image {
            navigationController.tabBarItem.image = image
        }
        return navigationController
    }
}


class AnotherVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
