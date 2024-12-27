//
//  Marcadores+CoreDataClass.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//
//

import Foundation
import CoreData

@objc(Marcadores)
public class Marcadores: NSManagedObject {
    func initiate(_ dict: Dictionary<String, Any>){
        self.name = (dict["name"] as? String) ?? ""
        self.artist = (dict["artist"] as? String) ?? ""
        self.cost = (dict["cost"] as? String) ?? ""
        self.tableNumber = (dict["tableNumber"]as? String) ?? ""
        self.tag = (dict["tag"]as? String) ?? ""
        self.type = (dict["type"]as? String) ?? ""
        self.importance = (dict["importance"]as? String) ?? ""
        
    }

}
