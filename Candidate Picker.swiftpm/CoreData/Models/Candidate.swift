import CoreData

//@objc enum SubjectGender: Int64 {
//    case Male = 0
//    case Female = 1
//}

@objc(Candidate)
class Candidate: NSManagedObject {
    @NSManaged public var subjectName: String
    @NSManaged public var birthdate: Date?
    @NSManaged public var subjectGender: Int64
    @NSManaged public var intelligence: Intelligence
    @NSManaged public var behavior: Behavior
}

//extension Candidate {
//    public var genderValue: String {
//        switch subjectGender {
//            case 0:
//                return "Male"
//            case 1:
//                return "Female"
//            default:
//                return "Unknown"
//        }
//    }
//}
