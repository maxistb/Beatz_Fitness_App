//
//  Trainingseintrag+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 30.04.23.
//
//

import Foundation
import CoreData


extension Trainingseintrag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trainingseintrag> {
        return NSFetchRequest<Trainingseintrag>(entityName: "Trainingseintrag")
    }

    @NSManaged public var datum: Date?
    @NSManaged public var gewicht: Double
    @NSManaged public var id: UUID?
    @NSManaged public var wiederholungen: Int64
    @NSManaged public var ausgefuehrteUebungen: NSSet?
    @NSManaged public var split: Split?
    @NSManaged public var uebung: Uebung?

}

// MARK: Generated accessors for ausgefuehrteUebungen
extension Trainingseintrag {

    @objc(addAusgefuehrteUebungenObject:)
    @NSManaged public func addToAusgefuehrteUebungen(_ value: AusgefuehrterSatz)

    @objc(removeAusgefuehrteUebungenObject:)
    @NSManaged public func removeFromAusgefuehrteUebungen(_ value: AusgefuehrterSatz)

    @objc(addAusgefuehrteUebungen:)
    @NSManaged public func addToAusgefuehrteUebungen(_ values: NSSet)

    @objc(removeAusgefuehrteUebungen:)
    @NSManaged public func removeFromAusgefuehrteUebungen(_ values: NSSet)

}

extension Trainingseintrag : Identifiable {

}

extension Trainingseintrag {
    var ausgefuehrteSätzeArray: [AusgefuehrterSatz] {
        let ausgefuehrteSätzeSet = ausgefuehrteUebungen as? Set<AusgefuehrterSatz> ?? []
        return ausgefuehrteSätzeSet.sorted { $0.wiederholungen > $1.wiederholungen }
    }
}

