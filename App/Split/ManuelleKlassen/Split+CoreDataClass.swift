//
//  Split+CoreDataClass.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 19.05.23.
//
//

import Foundation
import CoreData

@objc(Split)
public class Split: NSManagedObject {
    @NSManaged var trainingseintraege: NSSet?
    
}

extension Split {
    static func create(with name: String, in context: NSManagedObjectContext) -> Split {
        let split = Split(context: context)
        split.name = name
        return split
    }
}

