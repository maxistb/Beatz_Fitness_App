//
//  Trainingseintrag+CoreDataProperties.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.04.23.
//
//

import Foundation
import CoreData


extension Trainingseintrag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trainingseintrag> {
        return NSFetchRequest<Trainingseintrag>(entityName: "Trainingseintrag")
    }

    @NSManaged public var datum: Date?
    @NSManaged public var notizen: String?
    @NSManaged public var id: UUID?
    @NSManaged public var split: Split?

}

extension Trainingseintrag : Identifiable {

}
