import CoreStore
import SwiftUI

struct SubjectDetailView: View {
    var selectedSubject: Entities.Subject? = nil
    
    private var subjectIntelligence: Entities.Intelligence?
    private var subjectBehavior: Entities.Behavior?

    init(selectedSubject: Entities.Subject?) {
        self.selectedSubject = selectedSubject!
        self.subjectIntelligence = selectedSubject?.intelligence
        self.subjectBehavior = selectedSubject?.behavior
    }
    
    // MARK: View

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(selectedSubject?.subjectName ?? "Unidentified")
                }

                HStack {
                    Text("Birthdate")
                    Spacer()
                    Text(String((selectedSubject?.subjectBirthdate?.formatted(date: .abbreviated, time: .omitted))!))
                }

                HStack {
                    Text("Gender")
                    Spacer()
                    Text(selectedSubject?.gender.genderValue ?? Entities.Subject.Gender.male.genderValue)
                }
            }

            if (subjectIntelligence != nil && subjectBehavior != nil) {
                Section {
                    NavigationLink {
                        EligibilityView(selectedSubject: selectedSubject)
                    } label: {
                        Text("View candidate eligibility")
                    }
                }

                Section("Intelligence") {
                    GradeView(label: "Common Sense", number: subjectIntelligence?.commonSense)
                    GradeView(label: "Creativity", number: subjectIntelligence?.creativity)
                    GradeView(label: "Concentration", number: subjectIntelligence?.concentration)
                    GradeView(label: "Reasoning", number: subjectIntelligence?.reasoning)
                    GradeView(label: "Anticipation", number: subjectIntelligence?.anticipation)
                }

                Section("Behavior") {
                    GradeView(label: "Compliance", number: subjectBehavior?.compliance)
                    GradeView(label: "Influence", number: subjectBehavior?.influence)
                    GradeView(label: "Steadiness", number: subjectBehavior?.steadiness)
                    GradeView(label: "Dominance", number: subjectBehavior?.dominance)
                }
            } else {
                Section {
                    // Grading subject button
                    NavigationLink {
                        GradeFormView(currentSubject: selectedSubject!)
                    } label: {
                        Text("Grade subject")
                    }
                }
            }
        }
        .navigationTitle("Candidate Info")
    }
}

fileprivate struct GradeView: View {
    let label: String
    let number: Int?

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(String(number ?? 0))
        }
    }
}
