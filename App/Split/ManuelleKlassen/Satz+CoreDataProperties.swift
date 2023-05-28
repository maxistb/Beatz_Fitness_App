//
//  Satz+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 27.04.23.
//
//

import Foundation
import CoreData


extension Satz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Satz> {
        return NSFetchRequest<Satz>(entityName: "Satz")
    }

    @NSManaged public var gewicht: Int64
    @NSManaged public var wiederholungen: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var uebung: Uebung?
    @NSManaged public var ausgefuehrteuebung: AusgefuehrterSatz?
    @NSManaged public var order: Int64
}

extension Satz : Identifiable {

}
