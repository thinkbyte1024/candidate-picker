import Combine
import CoreStore
import SwiftUI

struct MainListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: Candidate.entity(), sortDescriptors: []) private var candidates: FetchedResults<Candidate>

    // MARK: States

    @State private var formState = false
    @State private var settingState = false
    @State private var alertState = false

    // MARK: View utama

    var body: some View {
        NavigationView {
            VStack {
                List {
//                        ForEach(candidates, id: \.self) { item in
//                            NavigationLink {
//                                SubjectDetailView(selectedSubject: item)
//                            } label: {
//                                ItemView(name: item.subjectName, age: Int(Date() - item.birthdate!), score: PMSolver.calculateScore(subject: item))
//                            }
//                        }
                    if !self.getData().isEmpty {
                        ForEach(self.getData(), id: \.subjectName) { item in
                            NavigationLink {
                                SubjectDetailView(selectedSubject: item)
                            } label: {
                                ItemView(
                                    name: item.subjectName,
                                    age: Date.getAgeFromBirthdate(birthdate: item.subjectBirthdate!),
                                    score: (item.behavior != nil && item.intelligence != nil) ? PMSolver.calculateScore(subject: item) : 0
                                )
                            }
                        }
                    } else {
                        Text("No data")
                    }
                }
                .sheet(isPresented: $formState) {
                    SubjectFormView(formState: $formState) { name, birthdate, gender in
//                            withAnimation {
//                                let newItem = Candidate(context: viewContext)
//
//                                newItem.subjectName = name
//                                newItem.birthdate = birthdate
//                                newItem.subjectGender = gender
//
//                                do {
//                                    try viewContext.save()
//                                } catch {
//                                    fatalError()
//                                }
//                            }

                        DataController.datastack.perform { transaction in
                            let newSubject = transaction.create(Into<Entities.Subject>())

                            newSubject.subjectName = name
                            newSubject.subjectBirthdate = birthdate
                            newSubject.gender = gender
                        } completion: { isComplete in
                            switch isComplete {
                                case .success():
//                                        alertState.toggle()
//                                        formState.toggle()
                                    formState = false
                                case .failure:
//                                        alertState.toggle()
//                                        formState.toggle()
                                    alertState = true
                                    formState = false
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
                .alert("Alert", isPresented: $alertState) {
                    Text("There is some problem")
                }

                // MARK: "Add Subject" button

                Divider()

                Button("Add Subject") {
                    formState.toggle()
                }
                .padding()
                .buttonStyle(.bordered)
            }
        }
    }

    // MARK: Data Functions

    private func getData() -> [Entities.Subject] {
        return try! DataController.datastack.fetchAll(From<Entities.Subject>())
    }
}
