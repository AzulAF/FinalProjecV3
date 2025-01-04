//
//  Marcadores+CoreDataProperties.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 04/01/25.
//
//

import Foundation
import CoreData


extension Marcadores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Marcadores> {
        return NSFetchRequest<Marcadores>(entityName: "Marcadores")
    }

    @NSManaged public var artist: String?
    @NSManaged public var cost: String?
    @NSManaged public var importance: String?
    @NSManaged public var name: String?
    @NSManaged public var tableNumber: String?
    @NSManaged public var tag: String?
    @NSManaged public var type: String?
    @NSManaged public var mdescription: String?

}

extension Marcadores : Identifiable {

}
