import CoreStore
import SwiftUI

struct ItemView: View {
    private let name: String
    private let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    var body: some View {
        HStack {
            Text(self.name)
            Spacer()
            Text("Age \(String(self.age))")
        }
    }
}
