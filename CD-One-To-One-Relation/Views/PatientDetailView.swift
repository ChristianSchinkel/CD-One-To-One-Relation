//
//  PatientDetailView.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2023-01-03.
//

import SwiftUI

struct PatientDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var patient: Patient
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Room.name, ascending: true)],
        animation: .default)
    private var rooms: FetchedResults<Room>
    
    @State private var name: String = ""
    @State private var selectedRoomIndex: Int = 0
    var body: some View {
        Form {
            Section {
                Text("\(patient.name ?? "") has \(patient.toRoom?.name ?? "").")
                TextField("Name", text: $name)
                RoomPickerView(selectedRoomIndex: $selectedRoomIndex)
            }
            .onAppear {
                name = patient.name ?? ""
                selectedRoomIndex = Int(patient.toRoom?.number ?? 0)
        }
            Section {
                Button(action: updateAndSave) {
                    Text("Save")
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func updateAndSave() {
        patient.name = name
        patient.toRoom = self.rooms[selectedRoomIndex]
        
        PersistenceController.shared.save()
        dismiss()
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientDetailView(patient: Patient.examplePatient(context: PersistenceController.preview.container.viewContext))
    }
}
