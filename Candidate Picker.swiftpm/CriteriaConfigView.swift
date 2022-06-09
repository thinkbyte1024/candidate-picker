import Combine
import SwiftUI

struct CriteriaConfigView: View {
    @ObservedObject private var appSettings = AppSettings()

    @Binding var state: Bool

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        Text("Grade Factor")

                        // Factor value slider
                        Slider(value: $appSettings.coreFactor, in: 0...1, step: 0.01)
                            .onChange(of: appSettings.coreFactor) { newValue in
                                print("Core Factor: \(appSettings.coreFactor)\nSecondary Factor: \(appSettings.secondaryFactor)")
                                appSettings.secondaryFactor = 1 - newValue
                            }

                        Text("Core factor \(String(format: "%.2f", appSettings.coreFactor))%")
                        Text("Secondary factor \(String(format: "%.2f", appSettings.secondaryFactor))%")
                    }
                }

                Section("Intelligence") {
                    CriteriaGradeSlider(text: "Common Sense", value: $appSettings.commonSense)
                    CriteriaGradeSlider(text: "Creativity", value: $appSettings.creativity)
                    CriteriaGradeSlider(text: "Concentration", value: $appSettings.concentration)
                    CriteriaGradeSlider(text: "Reasoning", value: $appSettings.reasoning)
                    CriteriaGradeSlider(text: "Anticipation", value: $appSettings.anticipation)
                }

                Section("Behavior") {
                    CriteriaGradeSlider(text: "Compliance", value: $appSettings.compliance)
                    CriteriaGradeSlider(text: "Influence", value: $appSettings.influence)
                    CriteriaGradeSlider(text: "Steadiness", value: $appSettings.steadiness)
                    CriteriaGradeSlider(text: "Dominance", value: $appSettings.dominance)
                }
            }
            .navigationTitle("App Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        state = false
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

private struct CriteriaGradeSlider: View {
    let text: String
    @Binding var value: Double

    var body: some View {
        VStack {
            Text(text)
            Slider(value: $value, in: 1...5, step: 1) {
                Text(text)
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
