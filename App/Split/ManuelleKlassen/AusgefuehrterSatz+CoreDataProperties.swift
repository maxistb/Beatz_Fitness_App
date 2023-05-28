//
//  AusgefuehrterSatz+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 20.05.23.
//
//

import Foundation
import CoreData


extension AusgefuehrterSatz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AusgefuehrterSatz> {
        return NSFetchRequest<AusgefuehrterSatz>(entityName: "AusgefuehrterSatz")
    }

    @NSManaged public var datum: Date?
    @NSManaged public var gewicht: Double
    @NSManaged public var id: UUID?
    @NSManaged public var uebungname: String?
    @NSManaged public var wiederholungen: Int64
    @NSManaged public var satzIndex: Int64
    @NSManaged public var isAufwaermsatz: Bool
    @NSManaged public var isDropsatz: Bool
    @NSManaged public var gewichteNachUebung: NSSet?
    @NSManaged public var saetze: NSOrderedSet?
    @NSManaged public var trainingseintrag: NSSet?
    @NSManaged public var uebung: NSOrderedSet?
    @NSManaged public var wiederholungenNachUebung: NSSet?

}

// MARK: Generated accessors for gewichteNachUebung
extension AusgefuehrterSatz {

    @objc(addGewichteNachUebungObject:)
    @NSManaged public func addToGewichteNachUebung(_ value: GewichteNachUebung)

    @objc(removeGewichteNachUebungObject:)
    @NSManaged public func removeFromGewichteNachUebung(_ value: GewichteNachUebung)

    @objc(addGewichteNachUebung:)
    @NSManaged public func addToGewichteNachUebung(_ values: NSSet)

    @objc(removeGewichteNachUebung:)
    @NSManaged public func removeFromGewichteNachUebung(_ values: NSSet)

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

// MARK: Generated accessors for uebung
extension AusgefuehrterSatz {

    @objc(insertObject:inUebungAtIndex:)
    @NSManaged public func insertIntoUebung(_ value: Uebung, at idx: Int)

    @objc(removeObjectFromUebungAtIndex:)
    @NSManaged public func removeFromUebung(at idx: Int)

    @objc(insertUebung:atIndexes:)
    @NSManaged public func insertIntoUebung(_ values: [Uebung], at indexes: NSIndexSet)

    @objc(removeUebungAtIndexes:)
    @NSManaged public func removeFromUebung(at indexes: NSIndexSet)

    @objc(replaceObjectInUebungAtIndex:withObject:)
    @NSManaged public func replaceUebung(at idx: Int, with value: Uebung)

    @objc(replaceUebungAtIndexes:withUebung:)
    @NSManaged public func replaceUebung(at indexes: NSIndexSet, with values: [Uebung])

    @objc(addUebungObject:)
    @NSManaged public func addToUebung(_ value: Uebung)

    @objc(removeUebungObject:)
    @NSManaged public func removeFromUebung(_ value: Uebung)

    @objc(addUebung:)
    @NSManaged public func addToUebung(_ values: NSOrderedSet)

    @objc(removeUebung:)
    @NSManaged public func removeFromUebung(_ values: NSOrderedSet)

}

// MARK: Generated accessors for wiederholungenNachUebung
extension AusgefuehrterSatz {

    @objc(addWiederholungenNachUebungObject:)
    @NSManaged public func addToWiederholungenNachUebung(_ value: WiederholungenNachUebung)

    @objc(removeWiederholungenNachUebungObject:)
    @NSManaged public func removeFromWiederholungenNachUebung(_ value: WiederholungenNachUebung)

    @objc(addWiederholungenNachUebung:)
    @NSManaged public func addToWiederholungenNachUebung(_ values: NSSet)

    @objc(removeWiederholungenNachUebung:)
    @NSManaged public func removeFromWiederholungenNachUebung(_ values: NSSet)

}

extension AusgefuehrterSatz : Identifiable {

}
