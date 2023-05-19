//
//  GewichteNachUebung+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.05.23.
//
//

import Foundation
import CoreData


extension GewichteNachUebung {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GewichteNachUebung> {
        return NSFetchRequest<GewichteNachUebung>(entityName: "GewichteNachUebung")
    }

    @NSManaged public var gewichte: Double
    @NSManaged public var uebungname: String?
    @NSManaged public var gewichteArray: NSSet?

}

// MARK: Generated accessors for gewichteArray
extension GewichteNachUebung {

    @objc(addGewichteArrayObject:)
    @NSManaged public func addToGewichteArray(_ value: AusgefuehrterSatz)

    @objc(removeGewichteArrayObject:)
    @NSManaged public func removeFromGewichteArray(_ value: AusgefuehrterSatz)

    @objc(addGewichteArray:)
    @NSManaged public func addToGewichteArray(_ values: NSSet)

    @objc(removeGewichteArray:)
    @NSManaged public func removeFromGewichteArray(_ values: NSSet)

}

extension GewichteNachUebung : Identifiable {

}
