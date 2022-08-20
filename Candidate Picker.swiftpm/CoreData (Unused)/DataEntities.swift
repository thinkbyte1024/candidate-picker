import CoreData
import SwiftUI

struct DataEntities {
    public static var CandidateEntity: NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = "Candidate"
        entity.managedObjectClassName = "Candidate"
        
        let nameAttr = NSAttributeDescription()
        nameAttr.name = "subjectName"
        nameAttr.type = .string

        let birthdateAttr = NSAttributeDescription()
        birthdateAttr.name = "birthdate"
        birthdateAttr.type = .date
        birthdateAttr.defaultValue = Date()
        
        let genderAttr = NSAttributeDescription()
        genderAttr.name = "subjectGender"
        genderAttr.type = .integer64

        let intelligence = NSRelationshipDescription()
        intelligence.name = "intelligence"
        intelligence.isOptional = true
        intelligence.minCount = 0
        intelligence.maxCount = 1
        intelligence.destinationEntity = DataEntities.IntelligenceEntity
        intelligence.inverseRelationship = DataEntities.IntelligenceEntity.relationshipsByName["candidate"]

        let behavior = NSRelationshipDescription()
        behavior.name = "behavior"
        behavior.isOptional = true
        behavior.minCount = 0
        behavior.maxCount = 1
        behavior.destinationEntity = DataEntities.BehaviorEntity
        behavior.inverseRelationship = DataEntities.BehaviorEntity.relationshipsByName["candidate"]

        let entityList = [nameAttr, birthdateAttr, genderAttr, intelligence, behavior]

        for item in entityList {
            entity.properties.append(item)
        }
        
        return entity
    }
    
    public static var IntelligenceEntity: NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = "Intelligence"
        entity.managedObjectClassName = "Intelligence"
        
        let CSAttr = NSAttributeDescription()
        CSAttr.name = "commonSense"
        CSAttr.type = .integer64
        
        let creativityAttr = NSAttributeDescription()
        creativityAttr.name = "creativity"
        creativityAttr.type = .integer64
        
        let concentrationAttr = NSAttributeDescription()
        concentrationAttr.name = "concentration"
        concentrationAttr.type = .integer64
        
        let reasoningAttr = NSAttributeDescription()
        reasoningAttr.name = "reasoning"
        reasoningAttr.type = .integer64
        
        let anticipationAttr = NSAttributeDescription()
        anticipationAttr.name = "anticipation"
        anticipationAttr.type = .integer64

        let candidate = NSRelationshipDescription()
        candidate.name = "candidate"
        candidate.isOptional = true
        candidate.minCount = 0
        candidate.maxCount = 1
        candidate.destinationEntity = DataEntities.CandidateEntity
        candidate.inverseRelationship = DataEntities.CandidateEntity.relationshipsByName["intelligence"]

        let entityList = [CSAttr, creativityAttr, concentrationAttr, reasoningAttr, anticipationAttr, candidate]

        for item in entityList {
            entity.properties.append(item)
        }
        
        return entity
    }
    
    public static var BehaviorEntity: NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = "Behavior"
        entity.managedObjectClassName = "Behavior"
        
        let complianceAttr = NSAttributeDescription()
        complianceAttr.name = "compliance"
        complianceAttr.type = .integer64
        
        let influenceAttr = NSAttributeDescription()
        influenceAttr.name = "influence"
        influenceAttr.type = .integer64
        
        let steadinessAttr = NSAttributeDescription()
        steadinessAttr.name = "steadiness"
        steadinessAttr.type = .integer64
        
        let dominanceAttr = NSAttributeDescription()
        dominanceAttr.name = "dominance"
        dominanceAttr.type = .integer64

        let candidate = NSRelationshipDescription()
        candidate.name = "candidate"
        candidate.isOptional = true
        candidate.minCount = 0
        candidate.maxCount = 1
        candidate.destinationEntity = DataEntities.CandidateEntity
        candidate.inverseRelationship = DataEntities.CandidateEntity.relationshipsByName["behavior"]
        
        let entityList = [complianceAttr, influenceAttr, steadinessAttr, dominanceAttr, candidate]

        for item in entityList {
            entity.properties.append(item)
        }
        
        return entity
    }
}
