//
//  Uebung+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 09.04.23.
//
//

import Foundation
import CoreData


extension Uebung {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Uebung> {
        return NSFetchRequest<Uebung>(entityName: "Uebung")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var saetze: Int64
    @NSManaged public var order: Int64
    @NSManaged public var origin: Split?

}

extension Uebung : Identifiable {

}
