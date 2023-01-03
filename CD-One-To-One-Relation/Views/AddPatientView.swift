//
//  AddPatientView.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2023-01-02.
//

import SwiftUI

struct AddPatientView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Room.name, ascending: true)],
        animation: .default)
    private var rooms: FetchedResults<Room>
    
    @State private var patientName: String = ""
    @State var selectedRoomIndex: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $patientName)
                } header: {
                    Text("Patient Id")
                }
                
                RoomPickerView(selectedRoomIndex: $selectedRoomIndex)
//                Section {
//                    RoomPickerView(selectedRoom: $selectedRoomIndex)
//                } header: {
//                    Text("Room")
//                }
                
                Section {
                    Button {
                        addPatient() // action
                    } label: {
                        Text("Add Patient")
                    }
                }
            }
            .navigationTitle("Add Patien")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addPatient() {
        // Pick a room
        let pickedRoom = self.rooms[selectedRoomIndex]
        // add a patient
        let newPatient = Patient(context: viewContext)
        newPatient.id = UUID()
        newPatient.name = patientName
        // Add the room to patient.
        newPatient.toRoom = pickedRoom
        
        PersistenceController.shared.save()
        dismiss()
    }
}

struct AddPatientView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
