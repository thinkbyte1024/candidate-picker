import Foundation

// Unusable class, for now
final class AppFormatter {
    static func formatPercent(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSDecimalNumber(value: number))!
    }
}
