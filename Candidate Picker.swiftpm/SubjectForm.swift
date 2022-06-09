import Combine
import SwiftUI

struct FormItemData: Identifiable {
    let id = UUID()
    let binding: Binding<Any>
    let view: AnyView
    let childView: [FormItemData]?
}

struct SubjectForm: View {

    // MARK: State variable

    @State private var nameInput: String = ""
    @State private var birthdateInput: Date = Date()
    @State private var selectedGender: Entities.Subject.Gender = .male

    @State private var pickerState = false

    // MARK: Bindings

    @Binding var formState: Bool

    // MARK: onComplete Function

    let onComplete: (String, Date, Entities.Subject.Gender) -> Void

    var body: some View {
        NavigationView {
            List {
                TextField("Subject name", text: $nameInput)

                DatePicker("Birthdate", selection: $birthdateInput, displayedComponents: [.date])

                Picker("Gender", selection: $selectedGender) {
                    Text("Male")
                        .tag(Entities.Subject.Gender.male)
                    Text("Female")
                        .tag(Entities.Subject.Gender.female)
                }
                .pickerStyle(.inline)

                Section {
                    Button {
                        if (nameInput.isEmpty) {
                            // TODO: Show empty name alert
                        } else {
                            onComplete(nameInput, birthdateInput, selectedGender)
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
