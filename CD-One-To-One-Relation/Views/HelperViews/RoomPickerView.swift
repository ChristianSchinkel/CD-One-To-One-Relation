//
//  RoomPickerView.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2023-01-02.
//

import SwiftUI

struct RoomPickerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Room.name, ascending: true)],
        animation: .default)
    private var rooms: FetchedResults<Room>
    @Binding var selectedRoomIndex: Int
    
    var body: some View {
        Picker(selection: $selectedRoomIndex, label: Text("Select room")) {
            ForEach(0 ..< rooms.count, id: \.self) {
                Text(self.rooms[$0].name ?? "Not Selected").tag($0) // MARK: This solved the problem with the nil in picker, I think. I should implement this instead of the problems picker have worked out before.
                
            }
        }
    }
}

struct RoomPickerView_Previews: PreviewProvider {

    @State static private var selectedRoomIndex: Int = 0
    
    static var previews: some View {
        RoomPickerView(selectedRoomIndex: self.$selectedRoomIndex).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
