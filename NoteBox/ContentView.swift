//
//  ContentView.swift
//  NoteBox
//
//  Created by Laryokkk on 26/06/23.
//

import SwiftUI

struct ContentView: View {
    struct Note: Hashable, Identifiable {
        let id = UUID()
        let title: String
    }
    
    
    struct Task: Identifiable {
        let name: String
        let notes: [Note]
        let id = UUID()
    }
    
    @State private var singleSelection: UUID?
    @State var checkState: Bool = false
    
    var body: some View {
        NavigationView {
            List(selection: $singleSelection) {
                ForEach(tasks) { task in
                    Section(header: Text("Random \(task.name) cool frase")) {
                        ForEach(task.notes) { note in
                            HStack {
                                Text(note.title)
                            }
                        }
                        
                        Button(action: {
                           // add to an array
                        }) {
                            Text("Add")
                        }
                        .buttonStyle(DefaultButtonStyle())
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Random cool frase")
        }
    }
    
    private let tasks: [Task] = [
        Task(
            name: "Pacific",
            notes: [
                Note(title: "Australasian Mediterranean"),
                Note(title: "Philippine"),
                Note(title: "Coral"),
                Note(title: "South China")
            ]
        ),
        Task(
            name: "Atlantic",
            notes: [
                Note(title: "American Mediterranean"),
                Note(title: "Sargasso"),
                Note(title: "Caribbean")
            ]
        ),
        Task(
            name: "Indian",
            notes: [
                Note(title: "Bay of Bengal")
            ]
        ),
        Task(
            name: "Southern",
            notes: [
                Note(title: "Weddell")
            ]
        ),
        Task(
            name: "Arctic",
            notes: [
                Note(title: "Greenland")
            ]
        )
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
