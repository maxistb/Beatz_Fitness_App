//
//  Uebung+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 23.04.23.
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
    @NSManaged public var order: Int64
    @NSManaged public var saetze: Int64
    @NSManaged public var videoURL: String?
    @NSManaged public var origin: Split?
    @NSManaged public var satz: NSSet?
    
    

}

// MARK: Generated accessors for satz
extension Uebung {

    @objc(addSatzObject:)
    @NSManaged public func addToSatz(_ value: Satz)

    @objc(removeSatzObject:)
    @NSManaged public func removeFromSatz(_ value: Satz)

    @objc(addSatz:)
    @NSManaged public func addToSatz(_ values: NSSet)

    @objc(removeSatz:)
    @NSManaged public func removeFromSatz(_ values: NSSet)

}

extension Uebung : Identifiable {

}
