import UIKit
import CoreData

class CDIdea {
  static let coreData = CDIdea()
  private var appDelegate: AppDelegate!
  private var manageContext:NSManagedObjectContext!
  private var idea:NSEntityDescription!
  
  private init() {
    appDelegate = UIApplication.shared.delegate as! AppDelegate
    manageContext = appDelegate.persistentContainer.viewContext
    idea = NSEntityDescription.entity(forEntityName: "Idea", in: manageContext)
  }
  
  func all() -> [Idea] {
    let fetchRequest: NSFetchRequest<Idea> = Idea.fetchRequest()
    do {
      return try manageContext.fetch(fetchRequest)
    } catch {
      fatalError("ERROR: Cannot readAll Idea \(error)")
    }
  }
  
  func read(id: Int) -> Optional<Idea> {
    let fetchRequest: NSFetchRequest<Idea> = Idea.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "%K=%@", "id", "\(id)")
    do {
      return try manageContext.fetch(fetchRequest).first
    } catch {
      fatalError("ERROR: Cannot read Idea id:\(id), error: \(error)")
    }
  }
  
  func add(_ newIdea: [String:Any]) {
    let newRecord = NSManagedObject(entity: idea, insertInto: manageContext) as? Idea
    newRecord?.setValue(newIdea["name"] as! String, forKey: "name")
    newRecord?.setValue(newIdea["memo"] as! String, forKey: "memo")
    newRecord?.setValue(newIdea["pic1"] as! Int16, forKey: "pic1")
    newRecord?.setValue(newIdea["pic2"] as! Int16, forKey: "pic2")
    newRecord?.setValue(NSDate(), forKey: "created_at")
    newRecord?.setValue(NSDate(), forKey: "updated_at")
    do {
      try manageContext.save()
    } catch {
      fatalError("ERROR: Cannot add Idea. \(idea), error = \(error)")
    }
  }
  
  func update(_ targetIdea: Idea) {
    targetIdea.updated_at = NSDate()
    do {
      try manageContext.save()
    } catch {
      fatalError("ERROR: Cannot update Idea. \(idea), error = \(error)")
    }
  }
  
  func delete(_ targetIdea: Idea) {
    do {
      manageContext.delete(targetIdea)
      try manageContext.save()
    } catch {
      fatalError("ERROR: Cannot delete Idea. \(idea), error = \(error)")
    }
  }
  
}
