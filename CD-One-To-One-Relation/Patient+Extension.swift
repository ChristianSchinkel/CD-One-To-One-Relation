//
//  Patient+Extension.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2023-01-03.
//

import Foundation
import CoreData

extension Patient {
    /// Used to create en example in the preview-canvas. Useful to create an example with an array or many relationships.
    static func examplePatient(context: NSManagedObjectContext) -> Patient {
        let patient = Patient(context: context)
        patient.id = UUID()
        patient.name = "ExamplePatientName"
        
        return patient
    }
}
