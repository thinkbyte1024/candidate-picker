import SwiftUI

fileprivate struct IntelligenceGrade {
    let csDiff: Double
    let concentrationDiff: Double
    let creativityDiff: Double
    let reasoningDiff: Double
    let anticipationDiff: Double

    let coreFactor: Double
    let secondaryFactor: Double
}

fileprivate struct BehaviorGrade {
    let complianceDiff: Double
    let influenceDiff: Double
    let steadinessDiff: Double
    let dominanceDiff: Double

    let coreFactor: Double
    let secondaryFactor: Double
}

struct EligibilityView: View {
    var appSettings = AppSettings()

    var selectedSubject: Entities.Subject?

        // MARK: Views

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text(selectedSubject?.subjectName ?? "Unidentified")
                        .font(.title)
                    Text(selectedSubject?.subjectBirthdate?.formatted(date: .long, time: .omitted) ?? "Unknown")
                        .font(.caption)
                }
            }

            Section("Intelligence") {
                HStack {
                    Text("Core Factor")
                    Spacer()
                    Text(String(format: "%.2f", calculateIntelligence(subject: selectedSubject!).coreFactor))
                }
                HStack {
                    Text("Secondary Factor")
                    Spacer()
                    Text(String(format: "%.2f", calculateIntelligence(subject: selectedSubject!).secondaryFactor))
                }
            }

            Section("Behavior") {
                HStack {
                    Text("Core Factor")
                    Spacer()
                    Text(String(format: "%.2f", calculateBehavior(subject: selectedSubject!).coreFactor))
                }
                HStack {
                    Text("Secondary Factor")
                    Spacer()
                    Text(String(format: "%.2f", calculateBehavior(subject: selectedSubject!).secondaryFactor))
                }
            }

            Section {
                HStack {
                    Text("Total Score")
                    Spacer()
                    Text(String(format: "%.2f", calculateTotalScore(coreFactorReq: appSettings.coreFactor, secondaryFactorReq: appSettings.secondaryFactor)))
                }
            }
        }
    }

        // MARK: Functions

    private func calculateIntelligence(subject: Entities.Subject) -> IntelligenceGrade {
        let appSettings = AppSettings()

        let csDiff = gapDifference(category: subject.intelligence!.commonSense - Int(appSettings.commonSense))
        let concentrationDiff = gapDifference(category: subject.intelligence!.concentration - Int(appSettings.concentration))
        let creativityDiff = gapDifference(category: subject.intelligence!.creativity - Int(appSettings.creativity))
        let reasoningDiff = gapDifference(category: subject.intelligence!.reasoning - Int(appSettings.reasoning))
        let anticipationDiff = gapDifference(category: subject.intelligence!.anticipation - Int(appSettings.anticipation))

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

    private func calculateBehavior(subject: Entities.Subject) -> BehaviorGrade {
        let appSettings = AppSettings()

        let complianceDiff = gapDifference(category: subject.behavior!.compliance - Int(appSettings.compliance))
        let influenceDiff = gapDifference(category: subject.behavior!.influence - Int(appSettings.influence))
        let steadinessDiff = gapDifference(category: subject.behavior!.steadiness - Int(appSettings.steadiness))
        let dominanceDiff = gapDifference(category: subject.behavior!.dominance - Int(appSettings.dominance))

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

    private func calculateTotalScore(coreFactorReq: Double, secondaryFactorReq: Double) -> Double {
        return (coreFactorReq * Double(calculateIntelligence(subject: selectedSubject!).coreFactor)) + (secondaryFactorReq * Double(calculateBehavior(subject: selectedSubject!).secondaryFactor))
    }

    private func gapDifference(category: Int) -> Double {
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
