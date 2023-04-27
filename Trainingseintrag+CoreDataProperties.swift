//
//  Trainingseintrag+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 27.04.23.
//
//

import Foundation
import CoreData


extension Trainingseintrag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trainingseintrag> {
        return NSFetchRequest<Trainingseintrag>(entityName: "Trainingseintrag")
    }

    @NSManaged public var datum: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var wiederholungen: Int64
    @NSManaged public var gewicht: Double
    @NSManaged public var split: Split?
    @NSManaged public var ausgefuehrteUebungen: NSSet?
    @NSManaged public var uebung: Uebung?

}

// MARK: Generated accessors for ausgefuehrteUebungen
extension Trainingseintrag {

    @objc(addAusgefuehrteUebungenObject:)
    @NSManaged public func addToAusgefuehrteUebungen(_ value: AusgefuehreUebung)

    @objc(removeAusgefuehrteUebungenObject:)
    @NSManaged public func removeFromAusgefuehrteUebungen(_ value: AusgefuehreUebung)

    @objc(addAusgefuehrteUebungen:)
    @NSManaged public func addToAusgefuehrteUebungen(_ values: NSSet)

    @objc(removeAusgefuehrteUebungen:)
    @NSManaged public func removeFromAusgefuehrteUebungen(_ values: NSSet)

}

extension Trainingseintrag : Identifiable {

}
