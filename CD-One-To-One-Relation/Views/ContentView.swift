//
//  ContentView.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2022-12-22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Room.name, ascending: true)],
        animation: .default)
    private var rooms: FetchedResults<Room>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Patient.name, ascending: true)],
        animation: .default)
    private var patients: FetchedResults<Patient>
    @State private var selection: Int = 1
//    @State private var countRooms: Int = 1
    
    @State private var showAddPatientView: Bool = false // whether the sheet is shown or not.
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                List {
                    ForEach(rooms, id: \.self) {
                        Text($0.name ?? "")
                    }
                    .onDelete(perform: deleteRooms)
                }
                .tabItem { Label("Rooms", systemImage: "bed.double") }.tag(1)
                
                
                List {
                    ForEach(patients, id: \.self) { patient in
                        NavigationLink {
                            PatientDetailView(patient: patient)
                        } label: {
                            Text((patient.name ?? "") + (patient.toRoom?.name ?? ""))
                        }
                        
                    }
                    .onDelete(perform: deletePatient)
                }
                .tabItem { Label("Patients", systemImage: "person") }.tag(2)
                
            }
            .navigationTitle("Rooms & Patients")
            // MARK: - Sheets:
            .sheet(isPresented: $showAddPatientView) {
                AddPatientView()
            }
            // MARK: - Toolbar:
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: addRoom) {
                        Image(systemName: "bed.double.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
//                        addPatient()
                        showAddPatientView.toggle()
                    } label: {
                        Image(systemName: "person")
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func saveViewContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    private func addRoom() {
        withAnimation {
            let count = rooms.count
            let newRoom = Room(context: viewContext)
            newRoom.name = "Room \(count)"
            newRoom.id = UUID()
            newRoom.number = Int16(count)
            
            saveViewContext()
        }
    }
    private func addPatient() {
        withAnimation {
            let newRoom = Room(context: viewContext)
            newRoom.id = UUID()
            newRoom.name = "Room 1"
            newRoom.number = Int16(1)

            let newPatient = Patient(context: viewContext)
            newPatient.id = UUID()
            newPatient.name = "Patient 1"
            newPatient.toRoom = newRoom
            
            saveViewContext()
        }
    }
    
    
    private func deleteRooms(offsets: IndexSet) {
        withAnimation {
            offsets.map { rooms[$0] }.forEach(viewContext.delete)
            
            saveViewContext()
        }
    }
    private func deletePatient(offsets: IndexSet) {
        withAnimation {
            offsets.map { patients[$0] }.forEach(viewContext.delete)
            
            saveViewContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
