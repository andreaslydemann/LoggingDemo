import UIKit
import CoreData

final class CategoryViewController: UITableViewController {
    
    private var categories = [Category]()
    private var coreDataConnection: CoreDataConnection!
    private var logService: LogService!
    
    convenience init(coreDataConnection: CoreDataConnection, logService: LogService) {
        self.init()
        self.coreDataConnection = coreDataConnection
        self.logService = logService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        loadCategories()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self)
        tableView.backgroundColor = UIColor(named: "Secondary")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 65
    }
    
    func setupNavigationBar() {
        navigationItem.title = "TodoApp"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonPressed))
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Active")!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary")
        navigationController?.navigationBar.tintColor = UIColor(named: "Action")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - TableView DataSource Methods

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.backgroundColor = UIColor(named: "Primary")
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView?.tintColor = UIColor(named: "Primary")
        cell.textLabel?.text = categories[indexPath.row].title
        
        return cell
    }
}

// MARK: - TableView Delegate Methods

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            guard let self = self else { return }
            
            self.coreDataConnection.deleteManagedObject(managedObject: self.categories[indexPath.row]) { result in
                if result {
                    self.categories.remove(at: indexPath.row)
                    self.saveCategories()
                    
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        
        return UISwipeActionsConfiguration(actions: [contextItem])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemListViewController(selectedCategory: categories[indexPath.row], coreDataConnection: .shared)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Data Manipulation Methods

extension CategoryViewController {
    func createNewCategory() -> Category {
        return Category(context: self.coreDataConnection.persistentContainer.viewContext)
    }
    
    func saveCategories() {
        self.coreDataConnection.saveContext()
    }
    
    func loadCategories() {
        if let categories = coreDataConnection.fetchManagedObjects(Category.self) as? [Category] {
            self.categories = categories
            tableView.reloadData()
        }
    }
}

// MARK: - Add New Categories

extension CategoryViewController {
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (field) in
            textField = field
            textField.placeholder = "Some category"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            let newCategory = self.createNewCategory()
            newCategory.title = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            self.tableView.reloadData()
            
            self.logService.info("Category was added.")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
