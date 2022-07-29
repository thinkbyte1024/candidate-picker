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

    static func calculateIntelligence(subject: Candidate) -> IntelligenceGrade {
        let appSettings = AppSettings()

            // BUG: Problem in using this method in MainView / ItemView

        let csDiff = gapDifference(category: (subject.intelligence.commonSense ) - Int(appSettings.commonSense))
        let concentrationDiff = gapDifference(category: (subject.intelligence.concentration ) - Int(appSettings.concentration))
        let creativityDiff = gapDifference(category: (subject.intelligence.creativity ) - Int(appSettings.creativity))
        let reasoningDiff = gapDifference(category: (subject.intelligence.reasoning ) - Int(appSettings.reasoning))
        let anticipationDiff = gapDifference(category: (subject.intelligence.anticipation ) - Int(appSettings.anticipation))

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

    static func calculateBehavior(subject: Candidate) -> BehaviorGrade {
        let appSettings = AppSettings()

            // BUG: Problem in using this method in MainView / ItemView

        let complianceDiff = gapDifference(category: (subject.behavior.compliance) - Int(appSettings.compliance))
        let influenceDiff = gapDifference(category: (subject.behavior.influence) - Int(appSettings.influence))
        let steadinessDiff = gapDifference(category: (subject.behavior.steadiness) - Int(appSettings.steadiness))
        let dominanceDiff = gapDifference(category: (subject.behavior.dominance) - Int(appSettings.dominance))

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

    static func intelligenceTotalScore(subject: Candidate, coreFactorReq: Double, secondaryFactorReq: Double) -> Double {
        return (coreFactorReq * Double(calculateIntelligence(subject: subject).coreFactor)) + (secondaryFactorReq * Double(calculateIntelligence(subject: subject).secondaryFactor))
    }

    static func behaviorTotalScore(subject: Candidate, coreFactorReq: Double, secondaryFactorReq: Double) -> Double {
        return (coreFactorReq * Double(calculateBehavior(subject: subject).coreFactor)) + (secondaryFactorReq * Double(calculateBehavior(subject: subject).secondaryFactor))
    }

    static func calculateScore(subject: Candidate) -> Double {
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
