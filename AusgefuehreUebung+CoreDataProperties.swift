//
//  AusgefuehreUebung+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 27.04.23.
//
//

import Foundation
import CoreData


extension AusgefuehreUebung {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AusgefuehreUebung> {
        return NSFetchRequest<AusgefuehreUebung>(entityName: "AusgefuehreUebung")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var uebung: Uebung?
    @NSManaged public var saetze: NSOrderedSet?
    @NSManaged public var trainingseintrag: Trainingseintrag?

}

// MARK: Generated accessors for saetze
extension AusgefuehreUebung {

    @objc(insertObject:inSaetzeAtIndex:)
    @NSManaged public func insertIntoSaetze(_ value: Satz, at idx: Int)

    @objc(removeObjectFromSaetzeAtIndex:)
    @NSManaged public func removeFromSaetze(at idx: Int)

    @objc(insertSaetze:atIndexes:)
    @NSManaged public func insertIntoSaetze(_ values: [Satz], at indexes: NSIndexSet)

    @objc(removeSaetzeAtIndexes:)
    @NSManaged public func removeFromSaetze(at indexes: NSIndexSet)

    @objc(replaceObjectInSaetzeAtIndex:withObject:)
    @NSManaged public func replaceSaetze(at idx: Int, with value: Satz)

    @objc(replaceSaetzeAtIndexes:withSaetze:)
    @NSManaged public func replaceSaetze(at indexes: NSIndexSet, with values: [Satz])

    @objc(addSaetzeObject:)
    @NSManaged public func addToSaetze(_ value: Satz)

    @objc(removeSaetzeObject:)
    @NSManaged public func removeFromSaetze(_ value: Satz)

    @objc(addSaetze:)
    @NSManaged public func addToSaetze(_ values: NSOrderedSet)

    @objc(removeSaetze:)
    @NSManaged public func removeFromSaetze(_ values: NSOrderedSet)

}

extension AusgefuehreUebung : Identifiable {

}
