//
//  Split+CoreDataProperties.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
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
    @NSManaged public var uebung: Uebung?

}

extension Split : Identifiable {

}
