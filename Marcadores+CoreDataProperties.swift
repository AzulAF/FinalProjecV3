//
//  Marcadores+CoreDataProperties.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//
//

import Foundation
import CoreData


extension Marcadores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Marcadores> {
        return NSFetchRequest<Marcadores>(entityName: "Marcadores")
    }

    @NSManaged public var name: String?
    @NSManaged public var artist: String?
    @NSManaged public var cost: String?
    @NSManaged public var tableNumber: String?
    @NSManaged public var tag: String?
    @NSManaged public var type: String?
    @NSManaged public var importance: String?

}

extension Marcadores : Identifiable {

}
