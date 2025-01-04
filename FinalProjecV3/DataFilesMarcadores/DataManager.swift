//
//  DataManager.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    private override init() {
        super.init()
    }
    
    func listadodeMarcadores() -> [Marcadores]{
        var lista = [Marcadores]()
        print("Carga lista")
        do {
            lista = try persistentContainer.viewContext.fetch(Marcadores.fetchRequest())
        } catch { print ("Error al cargar lista") }
        return lista
    }
    

    
    func llenaBDMarcadores() {
        print("llenando base")
        let ud = UserDefaults.standard
        if ud.integer(forKey: "BD-OK") != 1 { // La base de datos no se ha descargado
            if InternetMonitor.shared.hayConexion {
                print("si hay conexion")
                if let laURL = URL(string: "https://private-bf9787-marcadorestest.apiary-mock.com/event/marcadortest") {
                    let sesion = URLSession(configuration: .default)
                    let tarea = sesion.dataTask(with: URLRequest(url: laURL)) { data, response, error in
                        if error != nil {
                            print("No se pudo descargar \(error?.localizedDescription ?? "")")
                            return
                        }
                        do {
                            //let tmp = try JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
                            //
                            //self.saveMarcador(tmp)

                            
                        } catch { print ("No era JSON.") }
                        ud.set(1, forKey: "BD-OK")
                    }
                    tarea.resume()
                }
            }
            
        }
    }
    
    

    
    func saveMarcador(_ arregloJSON:[[String: Any]]) {
            print("Se guarda el marcador")
        guard let entidadDesc = NSEntityDescription.entity(forEntityName: "Marcadores", in: persistentContainer.viewContext)
        else {
            return
        }
        print("Se guardan los nuevos marcadores")
        var cont: Int = 0
        for dict in arregloJSON {
            var marcadorcin = NSManagedObject(entity: entidadDesc, insertInto: persistentContainer.viewContext) as! Marcadores
            marcadorcin.initiate(dict)
            cont += 1
            print(cont)
        }
        saveContext()
        
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FinalProjecV3")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
