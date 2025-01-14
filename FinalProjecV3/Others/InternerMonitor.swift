//
//  InternetMonitor.swift
//  Mod7PractFinalV1
//
//  Created by Azul Alfaro on 23/10/24.
//
//

import Foundation
import Network

class InternetMonitor:NSObject {
    static let shared = InternetMonitor()
    
    var hayConexion = true {
        didSet {
            if oldValue != hayConexion {
                NotificationCenter.default.post(name: .conexionCambio, object: nil)
            }
        }
    }
    var tipoConexionWiFi = false
    private var monitor = NWPathMonitor()
    
    private override init() {
        print("Inicia conexion")
        super.init()
        self.monitor.pathUpdateHandler = { ruta in
            self.hayConexion = ruta.status == .satisfied
            self.tipoConexionWiFi = ruta.usesInterfaceType(.wifi)
        }
        monitor.start(queue:DispatchQueue.global(qos: .background))
    }
}
extension Notification.Name {
    static let conexionCambio = Notification.Name("conexionCambio")
}
