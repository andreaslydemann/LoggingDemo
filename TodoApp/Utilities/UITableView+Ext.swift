import UIKit

public extension UITableView {
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func register(_ cellClasses: [AnyClass]) {
        cellClasses.forEach { register($0) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
