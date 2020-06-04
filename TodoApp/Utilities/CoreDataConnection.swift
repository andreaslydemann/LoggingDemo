import UIKit
import CoreData

final class CoreDataConnection: NSObject {
    
    override private init() { }
    
    static let shared = CoreDataConnection()
    
    static let kFilename = "TodoApp"
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataConnection.kFilename)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createManagedObject(_ entityName: String )->NSManagedObject {
        let managedContext =
            CoreDataConnection.shared.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
        
        let item = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        return item
    }
    
    func deleteManagedObject( managedObject: NSManagedObject, completion:(_ result: Bool ) -> Void) {
        let managedContext =
            CoreDataConnection.shared.persistentContainer.viewContext
        
        managedContext.delete(managedObject)
        
        do {
            try managedContext.save()
            
            completion(true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func fetchManagedObjects<T: NSManagedObject>(_ entity: T.Type,
                                     predicate: NSPredicate? = nil,
                                     sortDescriptor: [NSSortDescriptor]? = nil,
                                     context: NSManagedObjectContext = CoreDataConnection.shared.persistentContainer.viewContext) -> NSMutableArray? {
        
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        
        if sortDescriptor != nil {
            fetchRequest.sortDescriptors = sortDescriptor!
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let searchResult = try context.fetch(fetchRequest)
            if searchResult.count > 0 {
                // returns mutable copy of result array
                return NSMutableArray.init(array: searchResult)
            } else {
                // returns nil in case no object found
                return nil
            }
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
