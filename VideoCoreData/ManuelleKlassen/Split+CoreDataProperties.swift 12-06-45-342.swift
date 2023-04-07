//
//  Split+CoreDataProperties.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
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
    @NSManaged public var uebung: NSSet?

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
