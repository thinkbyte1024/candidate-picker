import CoreData

@objc(Intelligence)
class Intelligence: NSManagedObject {
    @NSManaged public var commonSense: Int
    @NSManaged public var creativity: Int
    @NSManaged public var concentration: Int
    @NSManaged public var reasoning: Int
    @NSManaged public var anticipation: Int
    @NSManaged public var candidate: Candidate
}
