import Combine
import Foundation

class AppSettings: ObservableObject {

        // MARK: Factor variables

    @Published var coreFactor: Double {
        didSet {
            UserDefaults.standard.set(coreFactor, forKey: "CoreFactor")
        }
    }

    @Published var secondaryFactor: Double {
        didSet {
            UserDefaults.standard.set(secondaryFactor, forKey: "SecondaryFactor")
        }
    }

        // MARK: Profile targets (Intelligence)

    // Intelligence percentage
    @Published var iPercentage: Double {
        didSet {
            UserDefaults.standard.set(iPercentage, forKey: "IPercentage")
        }
    }

    @Published var commonSense: Double {
        didSet {
            UserDefaults.standard.set(commonSense, forKey: "ICommonSense")
        }
    }

    @Published var creativity: Double {
        didSet {
            UserDefaults.standard.set(creativity, forKey: "ICreativity")
        }
    }

    @Published var concentration: Double {
        didSet {
            UserDefaults.standard.set(concentration, forKey: "IConcentration")
        }
    }

    @Published var reasoning: Double {
        didSet {
            UserDefaults.standard.set(reasoning, forKey: "IReasoning")
        }
    }

    @Published var anticipation: Double {
        didSet {
            UserDefaults.standard.set(anticipation, forKey: "IAnticipation")
        }
    }

        // MARK: Profile targets (Behavior)

    // Behavior percentage
    @Published var bPercentage: Double {
        didSet {
            UserDefaults.standard.set(bPercentage, forKey: "BPercentage")
        }
    }

    @Published var compliance: Double {
        didSet {
            UserDefaults.standard.set(compliance, forKey: "BCompliance")
        }
    }

    @Published var influence: Double {
        didSet {
            UserDefaults.standard.set(influence, forKey: "BInfluence")
        }
    }

    @Published var steadiness: Double {
        didSet {
            UserDefaults.standard.set(steadiness, forKey: "BSteadiness")
        }
    }

    @Published var dominance: Double {
        didSet {
            UserDefaults.standard.set(dominance, forKey: "BDominance")
        }
    }

        // MARK: Initializers

    init() {
        coreFactor = UserDefaults.standard.object(forKey: "CoreFactor") as? Double ?? 0.6
        secondaryFactor = UserDefaults.standard.object(forKey: "SecondaryFactor") as? Double ?? 0.4

        iPercentage = UserDefaults.standard.object(forKey: "IPercentage") as? Double ?? 0.35
        bPercentage = UserDefaults.standard.object(forKey: "BPercentage") as? Double ?? 0.65

        commonSense = UserDefaults.standard.object(forKey: "ICommonSense") as? Double ?? 3
        creativity = UserDefaults.standard.object(forKey: "ICreativity") as? Double ?? 3
        concentration = UserDefaults.standard.object(forKey: "IConcentration") as? Double ?? 3
        reasoning = UserDefaults.standard.object(forKey: "IReasoning") as? Double ?? 3
        anticipation = UserDefaults.standard.object(forKey: "IAnticipation") as? Double ?? 3

        compliance = UserDefaults.standard.object(forKey: "BCompliance") as? Double ?? 3
        influence = UserDefaults.standard.object(forKey: "BInfluence") as? Double ?? 3
        steadiness = UserDefaults.standard.object(forKey: "BSteadiness") as? Double ?? 3
        dominance = UserDefaults.standard.object(forKey: "BDominance") as? Double ?? 3
    }
}
