import Foundation

final class PMSolver {
    struct IntelligenceGrade {
        let csDiff: Double
        let concentrationDiff: Double
        let creativityDiff: Double
        let reasoningDiff: Double
        let anticipationDiff: Double

        let coreFactor: Double
        let secondaryFactor: Double
    }

    struct BehaviorGrade {
        let complianceDiff: Double
        let influenceDiff: Double
        let steadinessDiff: Double
        let dominanceDiff: Double

        let coreFactor: Double
        let secondaryFactor: Double
    }

    static func calculateIntelligence(subject: Entities.Subject) -> IntelligenceGrade {
        let appSettings = AppSettings()

            // BUG: Problem in using this method in MainView / ItemView

        let csDiff = gapDifference(category: (subject.intelligence?.commonSense ?? 0) - Int(appSettings.commonSense))
        let concentrationDiff = gapDifference(category: (subject.intelligence?.concentration ?? 0) - Int(appSettings.concentration))
        let creativityDiff = gapDifference(category: (subject.intelligence?.creativity ?? 0) - Int(appSettings.creativity))
        let reasoningDiff = gapDifference(category: (subject.intelligence?.reasoning ?? 0) - Int(appSettings.reasoning))
        let anticipationDiff = gapDifference(category: (subject.intelligence?.anticipation ?? 0) - Int(appSettings.anticipation))

        // Core Factor (Common Sense, Creativity, Reasoning)
        let coreFactor = (csDiff + creativityDiff + reasoningDiff) / 3

        // Secondary Factor (Concentration, Anticipation)
        let secondaryFactor = (concentrationDiff + anticipationDiff) / 2


        return IntelligenceGrade(
            csDiff: csDiff,
            concentrationDiff: concentrationDiff,
            creativityDiff: creativityDiff,
            reasoningDiff: reasoningDiff,
            anticipationDiff: anticipationDiff,
            coreFactor: coreFactor,
            secondaryFactor: secondaryFactor
        )
    }

    static func calculateBehavior(subject: Entities.Subject) -> BehaviorGrade {
        let appSettings = AppSettings()

            // BUG: Problem in using this method in MainView / ItemView

        let complianceDiff = gapDifference(category: (subject.behavior?.compliance ?? 0) - Int(appSettings.compliance))
        let influenceDiff = gapDifference(category: (subject.behavior?.influence ?? 0) - Int(appSettings.influence))
        let steadinessDiff = gapDifference(category: (subject.behavior?.steadiness ?? 0) - Int(appSettings.steadiness))
        let dominanceDiff = gapDifference(category: (subject.behavior?.dominance ?? 0) - Int(appSettings.dominance))

        // Core Factor (Compliance, Influence, Steadiness)
        let coreFactor = (complianceDiff + influenceDiff + steadinessDiff) / 3

        // Secondary Factor (Dominance)
        let secondaryFactor = dominanceDiff

        return BehaviorGrade(
            complianceDiff: complianceDiff,
            influenceDiff: influenceDiff,
            steadinessDiff: steadinessDiff,
            dominanceDiff: dominanceDiff,
            coreFactor: coreFactor,
            secondaryFactor: secondaryFactor
        )
    }

    static func intelligenceTotalScore(subject: Entities.Subject, coreFactorReq: Double, secondaryFactorReq: Double) -> Double {
        return (coreFactorReq * Double(calculateIntelligence(subject: subject).coreFactor)) + (secondaryFactorReq * Double(calculateIntelligence(subject: subject).secondaryFactor))
    }

    static func behaviorTotalScore(subject: Entities.Subject, coreFactorReq: Double, secondaryFactorReq: Double) -> Double {
        return (coreFactorReq * Double(calculateBehavior(subject: subject).coreFactor)) + (secondaryFactorReq * Double(calculateBehavior(subject: subject).secondaryFactor))
    }

    static func calculateScore(subject: Entities.Subject) -> Double {
        let appSettings = AppSettings()

        let iScore = intelligenceTotalScore(subject: subject, coreFactorReq: appSettings.coreFactor, secondaryFactorReq: appSettings.secondaryFactor)
        let bScore = behaviorTotalScore(subject: subject, coreFactorReq: appSettings.coreFactor, secondaryFactorReq: appSettings.secondaryFactor)

        return ((appSettings.iPercentage * iScore) + (appSettings.bPercentage * bScore))
    }

    static func gapDifference(category: Int) -> Double {
        switch category {
            case 0:
                return 5
            case 1:
                return 4.5
            case -1:
                return 4
            case 2:
                return 3.5
            case -2:
                return 3
            case 3:
                return 2.5
            case -3:
                return 2
            case 4:
                return 1.5
            case -4:
                return 1
            default:
                return -1
        }
    }
}
