import Combine
import CoreStore
import SwiftUI

struct MainListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Candidate.entity(), sortDescriptors: []) private var candidates: FetchedResults<Candidate>

    // MARK: States

    @State private var formState = false
    @State private var settingState = false
    @State private var alertState = false

    // MARK: Main View

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    List {
                        ForEach(candidates, id: \.self) { item in
                            NavigationLink {
                                SubjectDetailView(selectedSubject: item)
                            } label: {
                                ItemView(name: item.subjectName, age: Int(Date() - item.birthdate!), score: PMSolver.calculateScore(subject: item))
                            }

                        }
        //                ForEach(self.getData(), id: \.subjectName) { item in
        //                    NavigationLink {
        //                        SubjectDetailView(selectedSubject: candidates)
        //                    } label: {
        //                        ItemView(
        //                            name: item.subjectName,
        //                            age: Int((Date() - item.subjectBirthdate!) / 31557600),
        //                            score: PMSolver.calculateScore(subject: item)
        //                        )
        //                    }
        //                }

        //                Section {
        //                    Button {
        //                        formState.toggle()
        //                    } label: {
        //                        Text("Add Subject")
        //                    }
        //                }
                    }
                    .alert("Alert", isPresented: $alertState) {
                        Text("Test")
                    }
                    .sheet(isPresented: $formState) {
                        SubjectFormView(formState: $formState) { name, birthdate, gender in
                            withAnimation {
                                let newItem = Candidate(context: viewContext)

                                newItem.subjectName = name
                                newItem.birthdate = birthdate
                                newItem.subjectGender = gender
                                do {
                                    try viewContext.save()
                                } catch {
                                    fatalError()
                                }
                            }
        //                    DataController.datastack.perform { transaction in
        //                        withAnimation {
        //                            let newSubject = transaction.create(Into<Entities.Subject>())
        //
        //                            newSubject.subjectName = name
        //                            newSubject.subjectBirthdate = birthdate
        //                            newSubject.gender = gender
        //                        }
        //                    } completion: { isComplete in
        //                        switch isComplete {
        //                            case .success():
        //                                alertState.toggle()
        //                                formState.toggle()
        //                            case .failure:
        //                                alertState.toggle()
        //                                formState.toggle()
        //                        }
        //                    }

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
                
                Divider()

                Button {
                    formState.toggle()
                } label: {
                    Text("Add Subject")
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
