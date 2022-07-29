import Combine
import SwiftUI

struct FormItemData: Identifiable {
    let id = UUID()
    let binding: Binding<Any>
    let view: AnyView
    let childView: [FormItemData]?
}

struct SubjectFormView: View {

    // MARK: Environments

    @Environment(\.managedObjectContext) private var viewContext

    // MARK: State variable

    @State private var nameInput: String = ""
    @State private var birthdateInput: Date = Date()
    @State private var selectedGender: Int64 = 0

    @State private var pickerState = false

    // MARK: Bindings

    @Binding var formState: Bool

    // MARK: onComplete Function

    let onComplete: (String, Date, Int64) -> Void

    var body: some View {
        NavigationView {
            List {
                TextField("Subject name", text: $nameInput)

                Section("Birthdate") {
                    DatePicker("Birthdate", selection: $birthdateInput, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }

                Picker("Gender", selection: $selectedGender) {
                    Text("Male")
                        .tag(Int64(0))
                    Text("Female")
                        .tag(Int64(1))
                }
                .pickerStyle(.inline)

                Section {
                    Button {
                        if (!nameInput.isEmpty) {
                            formState.toggle()
                            onComplete(nameInput, birthdateInput, selectedGender)
                        } else {
                                // TODO: Show empty name alert
                        }
                    } label: {
                        Text("Submit")
                    }
                }
            }
            .navigationTitle("Add Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        formState.toggle()
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}
