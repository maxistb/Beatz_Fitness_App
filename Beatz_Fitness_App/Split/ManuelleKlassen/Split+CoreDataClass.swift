//
//  Split+CoreDataClass.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//
//

import Foundation
import CoreData

@objc(Split)
public class Split: NSManagedObject {
    @NSManaged var trainingseintraege: NSSet?
}

extension Split {
    static func create(with name: String, in context: NSManagedObjectContext) -> Split {
        let split = Split(context: context)
        split.name = name
        return split
    }
    
    func addToTrainingseintraege(_ trainingseintrag: Trainingseintrag) {
        let trainingseintraegeSet = trainingseintraege?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
        trainingseintraegeSet.add(trainingseintrag)
        trainingseintraege = trainingseintraegeSet.copy() as? NSSet
    }
}
