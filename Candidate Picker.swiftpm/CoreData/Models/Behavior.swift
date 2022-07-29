import CoreData

@objc(Behavior)
class Behavior: NSManagedObject {
    @NSManaged public var compliance: Int
    @NSManaged public var influence: Int
    @NSManaged public var steadiness: Int
    @NSManaged public var dominance: Int
    @NSManaged public var candidate: Candidate
}
