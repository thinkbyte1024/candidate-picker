import CoreStore
import SwiftUI

struct ItemView: View {
    let name: String
    let age: Int
    let score: Double

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.name)
                Text("Age \(String(self.age))")
                    .font(.caption)
            }

            Spacer()

            // 
            Text(score == 0 ? "Not graded" : String(format: "%.2f", score))
                .foregroundColor(score == 0 ? .red : .primary)
        }
    }
}
