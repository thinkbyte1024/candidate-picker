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

    // MARK: Variabel state

    @State private var nameInput: String = ""
    @State private var birthdateInput: Date = .init()
    @State private var selectedGender: Entities.Subject.Gender = .male

    @State private var pickerState = false

    // MARK: Bindings

    @Binding var formState: Bool

    // MARK: fungsi onComplete()

    let onComplete: (String, Date, Entities.Subject.Gender) -> Void

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
                        .tag(Entities.Subject.Gender.male)
                    Text("Female")
                        .tag(Entities.Subject.Gender.female)
                }
                .pickerStyle(.inline)

                Section {
                    Button {
                        if !nameInput.isEmpty {
                            onComplete(nameInput, birthdateInput, selectedGender)
                            formState.toggle()
                        } else {
                            // TODO: Menampilkan peringatan nama kosong
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
                        Text("Cancel")
                    }
                }
            }
        }
    }
}
