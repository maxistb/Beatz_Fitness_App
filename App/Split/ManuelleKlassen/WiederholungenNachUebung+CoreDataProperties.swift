//
//  WiederholungenNachUebung+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.05.23.
//
//

import Foundation
import CoreData


extension WiederholungenNachUebung {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WiederholungenNachUebung> {
        return NSFetchRequest<WiederholungenNachUebung>(entityName: "WiederholungenNachUebung")
    }

    @NSManaged public var wiederholungen: Int64
    @NSManaged public var uebungname: String?
    @NSManaged public var wiederholungenArray: NSSet?

}

// MARK: Generated accessors for wiederholungenArray
extension WiederholungenNachUebung {

    @objc(addWiederholungenArrayObject:)
    @NSManaged public func addToWiederholungenArray(_ value: AusgefuehrterSatz)

    @objc(removeWiederholungenArrayObject:)
    @NSManaged public func removeFromWiederholungenArray(_ value: AusgefuehrterSatz)

    @objc(addWiederholungenArray:)
    @NSManaged public func addToWiederholungenArray(_ values: NSSet)

    @objc(removeWiederholungenArray:)
    @NSManaged public func removeFromWiederholungenArray(_ values: NSSet)

}

extension WiederholungenNachUebung : Identifiable {

}
