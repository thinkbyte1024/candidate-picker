import CoreStore
import Foundation
class DataController {
    static let datastack: DataStack = {
        let datastack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<Entities.Subject>("Subjects"),
                    Entity<Entities.Intelligence>("Intelligence"),
                    Entity<Entities.Behavior>("Behavior")
                ],
                versionLock: [
                    "Behavior": [0x92f3c814d5ce8156, 0xe44eeb395baaeb20, 0x7e53224fd15161db, 0x199e850636568292],
                    "Intelligence": [0xb6366f2de6b719a6, 0xfbe9201238425653, 0x3abf9a27ed0d6c2d, 0x4ec3ce89ce6fbc93],
                    "Subjects": [0x6b7e0b5ed1bb9646, 0xd7627a26ab2b1e, 0x8080a4b926b47c3a, 0x92aa242709d709b5]
                ]

            )
        )

        try! datastack.addStorageAndWait()
        return datastack
    }()

        // MARK: SAMPLE DATA PREVIEW

    // Data preview (Not for production)
    static let preview: DataStack = {
        let datastack = DataController.datastack

//        try! datastack.perform(
//            synchronous: { transaction in
//                try transaction.deleteAll(From<Entities.Subject>())
//            }
//        )

        try! datastack.perform(
            synchronous: { transaction in
                try transaction.deleteAll(From<Entities.Subject>())

                for index in 1 ... 5 {
                    let newSubject = transaction.create(Into<Entities.Subject>())

                    newSubject.subjectName = "Subject #\(index)"
                    newSubject.subjectBirthdate = Date()
//                    newSubject.subjectAge = index + 20
                }
            }
        )

        return datastack
    }()
}
