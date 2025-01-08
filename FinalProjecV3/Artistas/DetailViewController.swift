//
//  DetailViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Conexiones a las vistas de la interfaz mediante IBOutlets.
    @IBOutlet weak var DetailNombre: UITextView!
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    @IBOutlet weak var DetailDescripcion: UITextView!
    
    @IBOutlet weak var DetailPiso: UILabel!
    
    @IBOutlet weak var DetailMesa: UILabel!
    
    @IBOutlet weak var DetailSellos: UILabel!
    
    @IBOutlet weak var DetailPagos: UITextView!
    
    // Variable para recibir los datos del artista seleccionado.
   var artist: Artista?
    // Configura las vistas utilizando los datos del artista y establece valores predeterminados en caso de datos faltantes.
   override func viewDidLoad() {
       super.viewDidLoad()
       // Variables para representar la disponibilidad de los métodos de pago.
       var pagoefectivoproof = "Disponible"
       var pagootroproof = "Disponible"
       var pagotarjetaproof = "Disponible"
       // Verifica si algún método de pago está vacío y actualiza el texto correspondiente.
       if (artist?.pagoefectivo == "" || artist?.pagotarjeta == "" || artist?.pagootro == ""){
           if artist?.pagoefectivo == ""{pagoefectivoproof = "No disponible"}
           if artist?.pagootro == ""{pagootroproof = "No disponible"}
           if artist?.pagotarjeta == ""{pagotarjetaproof = "No disponible"}
       }
       // Configura las vistas con los datos del artista si están disponibles.
       if let artist = artist {
           var placeholdertext = "Lorem Ipsum"
           // Asigna los valores del artista a las vistas correspondientes.
           DetailNombre.text = artist.nombre
           DetailPiso.text = artist.piso
           DetailMesa.text = artist.mesa
           // Si los tags están vacíos, se usa el texto por defecto.
           if artist.tags == "" {
               DetailDescripcion.text = placeholdertext
           } else{
               DetailDescripcion.text = "" + artist.tags
           }
           DetailSellos.text = artist.sellos
           // Detalla los métodos de pago disponibles.
           DetailPagos.text = """
               Efectivo: \(pagoefectivoproof)
               Tarjeta: \(pagotarjetaproof)
               Otros: \(pagootroproof)
           """
           // Carga y asigna la imagen del artista desde la URL, o usa una imagen por defecto si la URL no es válida.
           if let imageUrl = URL(string: artist.imagen) {
               DispatchQueue.global().async {
                   if let data = try? Data(contentsOf: imageUrl) {
                       DispatchQueue.main.async {
                           self.DetailImage.image = UIImage(data: data)
                       }
                   }
               }
           } else {
               DetailImage.image = UIImage(named: "a1")
           }
       }
   }
}
