import SwiftUI
import Foundation
import CoreStore

struct GradeFormView: View {
    @Environment(\.dismiss) var dismiss

    // MARK: View input

    let currentSubject: Entities.Subject?

    // MARK: Intelligence input

    @State private var CSInput: Double = 3
    @State private var CreativityInput: Double = 3
    @State private var ConcentrationInput: Double = 3
    @State private var ReasoningInput: Double = 3
    @State private var AnticipationInput: Double = 3

    // MARK: Behavior input

    @State private var ComplianceInput: Double = 3
    @State private var InfluenceInput: Double = 3
    @State private var SteadinessInput: Double = 3
    @State private var DominanceInput: Double = 3

    // MARK: Alert states

    @State private var saveMessage = "Notice"
    @State private var saveState = false

    init(currentSubject: Entities.Subject) {
        
        // Set current subject
        self.currentSubject = currentSubject
    }

    var body: some View {
        Form {
            Section("Intelligence") {
                GradeSlider(label: "Common Sense", value: $CSInput)
                GradeSlider(label: "Creativity", value: $CreativityInput)
                GradeSlider(label: "Concentration", value: $ConcentrationInput)
                GradeSlider(label: "Reasoning", value: $ReasoningInput)
                GradeSlider(label: "Anticipation", value: $AnticipationInput)
            }

            Section("Behavior") {
                GradeSlider(label: "Compliance", value: $ComplianceInput)
                GradeSlider(label: "Influence", value: $InfluenceInput)
                GradeSlider(label: "Steadiness", value: $SteadinessInput)
                GradeSlider(label: "Dominance", value: $DominanceInput)
            }

            Section {
                Button {
//                    DataController.datastack.perform { transaction in
//                        let gradedSubject = transaction.edit(currentSubject)
//                        let intelligence = transaction.create(Into<Entities.Intelligence>())
//                        let behavior = transaction.create(Into<Entities.Behavior>())
//
//                        intelligence.commonSense = Int(CSInput)
//                        intelligence.creativity = Int(CreativityInput)
//                        intelligence.concentration = Int(ConcentrationInput)
//                        intelligence.reasoning = Int(ReasoningInput)
//                        intelligence.anticipation = Int(AnticipationInput)
//
//                        behavior.compliance = Int(ComplianceInput)
//                        behavior.influence = Int(InfluenceInput)
//                        behavior.steadiness = Int(SteadinessInput)
//                        behavior.dominance = Int(DominanceInput)
//
//                        gradedSubject?.intelligence = Optional(intelligence)
//                        gradedSubject?.behavior = Optional(behavior)
//                    } completion: { completed in
//                        switch completed {
//                            case .success:
//                                saveMessage = "Candidate has successfully graded"
//                                saveState.toggle()
//                            case .failure:
//                                saveMessage = "An error occured during grading"
//                                saveState.toggle()
//                        }
//                    }


                } label: {
                    Text("Submit grade")
                }
            }
        }
        .alert(saveMessage, isPresented: $saveState) {
            Button {
                dismiss()
            } label: {
                Text("OK")
            }
        }
    }
}

private struct GradeSlider: View {
    var label: String
    @Binding var value: Double

    var body: some View {
        VStack {
            Text(label)
            Slider(value: $value, in: 1 ... 5, step: 1) {
                Text(label)
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("5")
            }

            switch value {
                case 1:
                    Text("Very bad")
                case 2:
                    Text("Bad")
                case 3:
                    Text("Okay")
                case 4:
                    Text("Good")
                case 5:
                    Text("Very good")
                default:
                    Text("Unknown")
            }
        }
    }
}

//struct GradeForm_Previews: PreviewProvider {
//    static var previews: some View {
//        GradeForm()
//    }
//}
