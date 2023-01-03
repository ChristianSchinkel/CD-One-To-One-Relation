//
//  Room+Extension.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2023-01-02.
//

import Foundation
import CoreData

extension Room {
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func exampleRoom(context: NSManagedObjectContext) -> Room {
        let room = Room(context: context)
        room.id = UUID()
        room.name = "Room 1"
        room.number = Int16(1)
        
        return room
    }
}
