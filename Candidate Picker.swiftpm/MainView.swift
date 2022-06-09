import Combine
import CoreStore
import SwiftUI

struct MainView: View {
//    private let dataObserver = Entities.Subject.observe(options: [.new]) { (subject, change) }

    // MARK: States

    @State private var formState = false
    @State private var settingState = false
    @State private var alertState = false

    // MARK: Main View

    var body: some View {
        NavigationView {
            List {
                ForEach(self.getData(), id: \.subjectName) { item in
                    NavigationLink {
                        SubjectDetail(selectedSubject: item)
                    } label: {
                        ItemView(
                            name: item.subjectName,
                            age: Int((Date() - item.subjectBirthdate!) / 31557600)
                        )
                    }
                }

                Section {
                    Button {
                        formState.toggle()
                    } label: {
                        Text("Add Subject")
                    }
                }
            }
            .alert("Alert", isPresented: $alertState) {
                Text("Test")
            }
            .sheet(isPresented: $formState) {
                SubjectForm(formState: $formState) { name, birthdate, gender in
                    DataController.datastack.perform { transaction in
                        withAnimation {
                            let newSubject = transaction.create(Into<Entities.Subject>())

                            newSubject.subjectName = name
                            newSubject.subjectBirthdate = birthdate
                            newSubject.gender = gender
                        }
                    } completion: { isComplete in
                        switch isComplete {
                            case .success():
//                                alertState.toggle()
                                formState.toggle()
                            case .failure:
                                alertState.toggle()
                                formState.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $settingState) {
                CriteriaConfigView(state: $settingState)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        settingState.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }

    // MARK: Functions

    private func getData() -> [Entities.Subject] {
        return try! DataController.datastack.fetchAll(From<Entities.Subject>())
    }
}
