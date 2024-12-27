//
//  DetailViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var DetailNombre: UITextView!
    
//    @IBOutlet weak var DetailImage: UIImageView!
//    
//    @IBOutlet weak var DetailPiso: UITextView!
//    
//    @IBOutlet weak var DetailMesa: UITextView!
//    
//    @IBOutlet weak var DetailSellos: UITextView!
//    
//    @IBOutlet weak var DetailPagos: UITextView!
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    @IBOutlet weak var DetailDescripcion: UITextView!
    
    @IBOutlet weak var DetailPiso: UILabel!
    
    @IBOutlet weak var DetailMesa: UILabel!
    
    @IBOutlet weak var DetailSellos: UILabel!
    
    @IBOutlet weak var DetailPagos: UITextView!
    
    
    
    
    // Property to hold the selected artist
       var artist: Artista?

       override func viewDidLoad() {
           super.viewDidLoad()
           var pagoefectivoproof = "Disponible"
           var pagootroproof = "Disponible"
           var pagotarjetaproof = "Disponible"
           
           if (artist?.pagoefectivo == "" || artist?.pagotarjeta == "" || artist?.pagootro == ""){
               if artist?.pagoefectivo == ""{pagoefectivoproof = "No disponible"}
               if artist?.pagootro == ""{pagootroproof = "No disponible"}
               if artist?.pagotarjeta == ""{pagotarjetaproof = "No disponible"}
           }
           // Configure the view with the artist's data
           if let artist = artist {
               DetailNombre.text = artist.nombre
               DetailPiso.text = artist.piso
               DetailMesa.text = artist.mesa
               DetailSellos.text = artist.sellos
               DetailPagos.text = """
                   Efectivo: \(pagoefectivoproof)
                   Tarjeta: \(pagotarjetaproof)
                   Otros: \(pagootroproof)
               """
               
               if let imageUrl = URL(string: artist.imagen) {
                   // Load image (you can use a library like SDWebImage or Kingfisher here)
                   DispatchQueue.global().async {
                       if let data = try? Data(contentsOf: imageUrl) {
                           DispatchQueue.main.async {
                               self.DetailImage.image = UIImage(data: data)
                           }
                       }
                   }
               } else {
                   DetailImage.image = UIImage(named: "a1") // Fallback image
               }
           }
       }
   }
