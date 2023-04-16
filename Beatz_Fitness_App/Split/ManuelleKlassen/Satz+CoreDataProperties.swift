//
//  Satz+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.04.23.
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
    @NSManaged public var uebung: Uebung?

}

extension Satz : Identifiable {

}
