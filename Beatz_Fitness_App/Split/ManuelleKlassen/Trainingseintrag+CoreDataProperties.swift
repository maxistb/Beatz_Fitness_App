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
    @NSManaged public var notizen: String
    @NSManaged public var satzReihenfolge: Int64
    @NSManaged public var ausgefuehrteUebungen: NSSet?
    @NSManaged public var split: Split
    @NSManaged public var uebung: NSSet?

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

// MARK: Generated accessors for uebung
extension Trainingseintrag {

    @objc(addUebungObject:)
    @NSManaged public func addToUebung(_ value: Uebung)

    @objc(removeUebungObject:)
    @NSManaged public func removeFromUebung(_ value: Uebung)

    @objc(addUebung:)
    @NSManaged public func addToUebung(_ values: NSSet)

    @objc(removeUebung:)
    @NSManaged public func removeFromUebung(_ values: NSSet)

}

extension Trainingseintrag : Identifiable {

}

extension Trainingseintrag {
    var ausgefuehrteSätzeArray: [AusgefuehrterSatz] {
        let ausgefuehrteSätzeSet = ausgefuehrteUebungen as? Set<AusgefuehrterSatz> ?? []
        return ausgefuehrteSätzeSet.sorted { $0.satzIndex < $1.satzIndex }
    }
}
