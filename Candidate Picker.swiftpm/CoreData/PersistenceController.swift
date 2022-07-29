import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        // Model creation
        let model = NSManagedObjectModel()
        model.entities = [DataEntities.CandidateEntity, DataEntities.IntelligenceEntity, DataEntities.BehaviorEntity]
        
        // Create persistence container
        let container = NSPersistentContainer(name: "Candidates", managedObjectModel: model)
        
        // Don't store data in device (Preview purposes only)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                // Handling errors
                fatalError("failed with: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        self.container = container
    }
}
