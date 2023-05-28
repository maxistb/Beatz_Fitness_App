//
//  Split+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 19.05.23.
//
//

import Foundation
import CoreData


extension Split {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Split> {
        return NSFetchRequest<Split>(entityName: "Split")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var order: Int64
    @NSManaged public var notizen: String?
    @NSManaged public var uebung: NSSet?

    var getUebungen: [Uebung] {
        get {
            let uebungen = uebung?.allObjects as? [Uebung] ?? []
            return uebungen.sorted { $0.order < $1.order }
        }
    }

}

// MARK: Generated accessors for uebung
extension Split {

    @objc(addUebungObject:)
    @NSManaged public func addToUebung(_ value: Uebung)

    @objc(removeUebungObject:)
    @NSManaged public func removeFromUebung(_ value: Uebung)

    @objc(addUebung:)
    @NSManaged public func addToUebung(_ values: NSSet)

    @objc(removeUebung:)
    @NSManaged public func removeFromUebung(_ values: NSSet)

}

extension Split : Identifiable {

}
