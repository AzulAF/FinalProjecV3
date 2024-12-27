//
//  Marcador+CoreDataProperties.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//
//

import Foundation
import CoreData


extension Marcador {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Marcador> {
        return NSFetchRequest<Marcador>(entityName: "Marcador")
    }

    @NSManaged public var name: String?
    @NSManaged public var artist: String?
    @NSManaged public var cost: String?
    @NSManaged public var tableNumber: String?
    @NSManaged public var tag: String?
    @NSManaged public var type: String?
    @NSManaged public var importance: String?

}

extension Marcador : Identifiable {

}
