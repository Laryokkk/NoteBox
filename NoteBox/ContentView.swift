//
//  ContentView.swift
//  NoteBox
//
//  Created by Laryokkk on 26/06/23.
//

import SwiftUI
import Firebase

struct Note: Hashable, Identifiable {
    let id: UUID
    let title: String
}

struct TaskGroup: Identifiable {
    let id: UUID
    let name: String
    let notes: [Note]
}

final class ContentViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskGroup] = []
    
    private var db = Firestore.firestore()
    
    func saveTasksToFirebase() {
        for taskGroup in tasks {
            let taskDocument = db.collection("tasks").document()
            taskDocument.setData([
                "name": taskGroup.name
            ])
            
            for note in taskGroup.notes {
                taskDocument.collection("notes").addDocument(data: [
                    "title": note.title
                ])
            }
        }
    }
    
    init() {
        loadDataFromFirebase()
    }
    
    private func loadDataFromFirebase() {
        db.collection("tasks").getDocuments { snapshot, error in
            if let error = error {
                print("Error loading tasks: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            var loadedTasks: [TaskGroup] = []
            
            for document in documents {
                let taskId = document.documentID
                let taskName = document.data()["name"] as? String ?? ""
                
                var loadedNotes: [Note] = []
                document.reference.collection("notes").getDocuments { snapshot, error in
                    if let error = error {
                        print("Error loading notes: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let noteDocuments = snapshot?.documents else {
                        print("No note documents found")
                        return
                    }
                    
                    for noteDocument in noteDocuments {
                        let noteId = noteDocument.documentID
                        let noteTitle = noteDocument.data()["title"] as? String ?? ""
                        let note = Note(id: UUID(uuidString: noteId) ?? UUID(), title: noteTitle)
                        loadedNotes.append(note)
                    }
                    
                    let taskGroup = TaskGroup(id: UUID(uuidString: taskId) ?? UUID(), name: taskName, notes: loadedNotes)
                    loadedTasks.append(taskGroup)
                    
                    self.tasks = loadedTasks
                }
            }
        }
    }
}

struct ContentView: View {
    
    @State private var singleSelection: UUID?
    @State private var isShowingSheet = false
    @State private var sheetTitle: String = ""
    @State private var sheetTextField: String = ""
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(selection: $singleSelection) {
                ForEach(viewModel.tasks) { task in
                    Section(header: Text(task.name)) {
                        ForEach(task.notes) { note in
                            HStack {
                                Text(note.title)
                                    .swipeActions(edge: .leading) {
                                        Button(role: .destructive) {
                                            // Todo
                                        } label: {
                                            Label("Done", systemImage: "archivebox.fill")
                                        }
                                        .tint(.green)
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            // Todo
                                        } label: {
                                            Label("Done", systemImage: "archivebox.fill")
                                        }
                                        .tint(.green)
                                    }
                            }
                        }
                        Button(action: {
                            isShowingSheet.toggle()
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .frame(height: 24)
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        .sheet(
                            isPresented: $isShowingSheet,
                            onDismiss: didDismiss)
                        {
                            VStack(alignment: .leading, spacing: 25) {
                                Text(sheetTitle)
                                    .font(.title)
                                
                                TextField(
                                    "Task title...",
                                    text: $sheetTextField
                                )
                                
                                Button(action: { isShowingSheet.toggle() }) {
                                    Text("Save")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 24)
                                }
                                .buttonStyle(BorderedProminentButtonStyle())
                            }
                            .onAppear {
                                sheetTitle = task.name
                            }
                            .presentationDetents([.fraction(0.3)])
                            .presentationDragIndicator(.hidden)
                            .padding(50)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Random cool frase")
        }
    }
    
    func didDismiss() {
        viewModel.saveTasksToFirebase()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
