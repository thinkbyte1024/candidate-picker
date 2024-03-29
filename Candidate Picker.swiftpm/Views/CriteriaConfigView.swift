import Combine
import SwiftUI

struct CriteriaConfigView: View {
    @ObservedObject private var appSettings = AppSettings()

    @Binding var state: Bool

    // MARK: View
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        Text("Grade Factor")

                        // Slider nilai faktor
                        Slider(value: $appSettings.coreFactor, in: 0...1, step: 0.01)
                            .onChange(of: appSettings.coreFactor) { newValue in
                                appSettings.secondaryFactor = 1 - newValue
                            }

                        Text("Core factor \(String(format: "%.0f", appSettings.coreFactor * 100))%")
                        Text("Secondary factor \(String(format: "%.0f", appSettings.secondaryFactor * 100))%")
                    }
                }

                Section("Criteria Percentage") {
                    VStack {
                        Slider(value: $appSettings.iPercentage, in: 0...1, step: 0.01)
                            .onChange(of: appSettings.iPercentage) { newValue in
                                appSettings.bPercentage = 1 - newValue
                            }

                        Text("Intelligence \(String(format: "%.0f", appSettings.iPercentage * 100))%")
                        Text("Behavior \(String(format: "%.0f", appSettings.bPercentage * 100))%")

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
                        Text("Back")
                    }
                }
            }
        }
    }
}

// Criteria Slider View
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
                    Text("Very poor")
                case 2:
                    Text("Poor")
                case 3:
                    Text("Okay")
                case 4:
                    Text("Good")
                case 5:
                    Text("Excellent")
                default:
                    Text("Unknown")
            }
        }
    }
}
