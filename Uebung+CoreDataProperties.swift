//
//  Uebung+CoreDataProperties.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//
//

import Foundation
import CoreData


extension Uebung {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Uebung> {
        return NSFetchRequest<Uebung>(entityName: "Uebung")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

}

extension Uebung : Identifiable {

}
