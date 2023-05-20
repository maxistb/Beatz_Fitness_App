//
//  Uebung+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 19.05.23.
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
    @NSManaged public var notizen: String?
    @NSManaged public var ausgefuehrteuebung: NSOrderedSet?
    @NSManaged public var origin: Split?
    @NSManaged public var satz: NSOrderedSet?
    @NSManaged public var trainingseintrag: Trainingseintrag?

}

// MARK: Generated accessors for ausgefuehrteuebung
extension Uebung {

    @objc(insertObject:inAusgefuehrteuebungAtIndex:)
    @NSManaged public func insertIntoAusgefuehrteuebung(_ value: AusgefuehrterSatz, at idx: Int)

    @objc(removeObjectFromAusgefuehrteuebungAtIndex:)
    @NSManaged public func removeFromAusgefuehrteuebung(at idx: Int)

    @objc(insertAusgefuehrteuebung:atIndexes:)
    @NSManaged public func insertIntoAusgefuehrteuebung(_ values: [AusgefuehrterSatz], at indexes: NSIndexSet)

    @objc(removeAusgefuehrteuebungAtIndexes:)
    @NSManaged public func removeFromAusgefuehrteuebung(at indexes: NSIndexSet)

    @objc(replaceObjectInAusgefuehrteuebungAtIndex:withObject:)
    @NSManaged public func replaceAusgefuehrteuebung(at idx: Int, with value: AusgefuehrterSatz)

    @objc(replaceAusgefuehrteuebungAtIndexes:withAusgefuehrteuebung:)
    @NSManaged public func replaceAusgefuehrteuebung(at indexes: NSIndexSet, with values: [AusgefuehrterSatz])

    @objc(addAusgefuehrteuebungObject:)
    @NSManaged public func addToAusgefuehrteuebung(_ value: AusgefuehrterSatz)

    @objc(removeAusgefuehrteuebungObject:)
    @NSManaged public func removeFromAusgefuehrteuebung(_ value: AusgefuehrterSatz)

    @objc(addAusgefuehrteuebung:)
    @NSManaged public func addToAusgefuehrteuebung(_ values: NSOrderedSet)

    @objc(removeAusgefuehrteuebung:)
    @NSManaged public func removeFromAusgefuehrteuebung(_ values: NSOrderedSet)

}

// MARK: Generated accessors for satz
extension Uebung {

    @objc(insertObject:inSatzAtIndex:)
    @NSManaged public func insertIntoSatz(_ value: Satz, at idx: Int)

    @objc(removeObjectFromSatzAtIndex:)
    @NSManaged public func removeFromSatz(at idx: Int)

    @objc(insertSatz:atIndexes:)
    @NSManaged public func insertIntoSatz(_ values: [Satz], at indexes: NSIndexSet)

    @objc(removeSatzAtIndexes:)
    @NSManaged public func removeFromSatz(at indexes: NSIndexSet)

    @objc(replaceObjectInSatzAtIndex:withObject:)
    @NSManaged public func replaceSatz(at idx: Int, with value: Satz)

    @objc(replaceSatzAtIndexes:withSatz:)
    @NSManaged public func replaceSatz(at indexes: NSIndexSet, with values: [Satz])

    @objc(addSatzObject:)
    @NSManaged public func addToSatz(_ value: Satz)

    @objc(removeSatzObject:)
    @NSManaged public func removeFromSatz(_ value: Satz)

    @objc(addSatz:)
    @NSManaged public func addToSatz(_ values: NSOrderedSet)

    @objc(removeSatz:)
    @NSManaged public func removeFromSatz(_ values: NSOrderedSet)

}

extension Uebung : Identifiable {

}
