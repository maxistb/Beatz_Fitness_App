//
//  AusgefuehrterSatz+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 30.04.23.
//
//

import Foundation
import CoreData


extension AusgefuehrterSatz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AusgefuehrterSatz> {
        return NSFetchRequest<AusgefuehrterSatz>(entityName: "AusgefuehrterSatz")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var gewicht: Double
    @NSManaged public var wiederholungen: Int64
    @NSManaged public var saetze: NSOrderedSet?
    @NSManaged public var trainingseintrag: NSSet?
    @NSManaged public var uebung: Uebung?

}

// MARK: Generated accessors for saetze
extension AusgefuehrterSatz {

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

// MARK: Generated accessors for trainingseintrag
extension AusgefuehrterSatz {

    @objc(addTrainingseintragObject:)
    @NSManaged public func addToTrainingseintrag(_ value: Trainingseintrag)

    @objc(removeTrainingseintragObject:)
    @NSManaged public func removeFromTrainingseintrag(_ value: Trainingseintrag)

    @objc(addTrainingseintrag:)
    @NSManaged public func addToTrainingseintrag(_ values: NSSet)

    @objc(removeTrainingseintrag:)
    @NSManaged public func removeFromTrainingseintrag(_ values: NSSet)

}

extension AusgefuehrterSatz : Identifiable {

}
