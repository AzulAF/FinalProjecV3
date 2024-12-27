//
//  Persistence.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//
//
//import CoreData
//import Foundation
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "FinalProjectV3") // Cambia por el nombre de tu archivo .xcdatamodeld
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//    }
//}
