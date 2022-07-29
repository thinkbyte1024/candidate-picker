import SwiftUI

struct EligibilityView: View {
    var appSettings = AppSettings()

    @ObservedObject var selectedSubject: Candidate

        // MARK: Views

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text(selectedSubject.subjectName )
                        .font(.title)
                    Text(selectedSubject.birthdate?.formatted(date: .long, time: .omitted) ?? "Unknown")
                        .font(.caption)
                }
            }

            Section("Intelligence") {
                HStack {
                    Text("Core Factor")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.calculateIntelligence(subject: selectedSubject).coreFactor))
                }

                HStack {
                    Text("Secondary Factor")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.calculateIntelligence(subject: selectedSubject).secondaryFactor))
                }

                HStack {
                    Text("Intelligence Score")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.intelligenceTotalScore(subject: selectedSubject, coreFactorReq: appSettings.coreFactor, secondaryFactorReq: appSettings.secondaryFactor)))
                }
            }

            Section("Behavior") {
                HStack {
                    Text("Core Factor")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.calculateBehavior(subject: selectedSubject).coreFactor))
                }
                
                HStack {
                    Text("Secondary Factor")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.calculateBehavior(subject: selectedSubject).secondaryFactor))
                }

                HStack {
                    Text("Behavior Score")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.behaviorTotalScore(subject: selectedSubject, coreFactorReq: appSettings.coreFactor, secondaryFactorReq: appSettings.secondaryFactor)))
                }
            }

            Section {
                HStack {
                    Text("Total Score")
                    Spacer()
                    Text(String(format: "%.2f", PMSolver.calculateScore(subject: selectedSubject)))
                }
            }
        }
    }
}
