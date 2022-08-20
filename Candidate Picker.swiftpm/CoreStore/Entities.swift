import CoreStore
import SwiftUI

final class Entities {

    // Nilai kecerdasan
    final class Intelligence: CoreStoreObject {

        @Field.Relationship("subject", inverse: \Entities.Subject.$intelligence)
        var subject: Entities.Subject?

        @Field.Stored("commonSense")
        var commonSense: Int = 0

        @Field.Stored("creativity")
        var creativity: Int = 0

        @Field.Stored("concentration")
        var concentration: Int = 0

        @Field.Stored("reasoning")
        var reasoning: Int = 0

        @Field.Stored("anticipation")
        var anticipation: Int = 0
    }

    // Nilai perilaku
    final class Behavior: CoreStoreObject {
        @Field.Relationship("subject", inverse: \Entities.Subject.$behavior)
        var subject: Entities.Subject?

        @Field.Stored("compliance")
        var compliance: Int = 0

        @Field.Stored("influence")
        var influence: Int = 0

        @Field.Stored("steadiness")
        var steadiness: Int = 0

        @Field.Stored("dominance")
        var dominance: Int = 0
    }

    // Data kandidat
    final class Subject: CoreStoreObject, Identifiable {
        @Field.Stored("subjectId", dynamicInitialValue: { UUID() })
        var subjectId: UUID

        @Field.Stored("subjectName")
        var subjectName: String = ""

        @Field.Stored("subjectBirthdate")
        var subjectBirthdate: Date?

//        @Field.Stored("subjectAge")
//        var subjectAge: Int = 21

        @Field.Stored("subjectGender")
        var gender: Entities.Subject.Gender = .male

        @Field.Relationship("intelligence")
        var intelligence: Entities.Intelligence?

        @Field.Relationship("behavior")
        var behavior: Entities.Behavior?
    }
}


// Jenis kelamin
extension Entities.Subject {
    enum Gender: String, CaseIterable, ImportableAttributeType, FieldStorableType {
        case male
        case female

        var genderValue: String {
            switch self {
                case .male:
                    return "Male"
                case .female:
                    return "Female"
            }
        }
    }
}
