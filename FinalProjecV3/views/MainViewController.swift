//
//  MainViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBAction func lista(_ sender: Any) {
        performSegue(withIdentifier: "artistaslista", sender: self)
    }
    
    
    @IBAction func marcador(_ sender: Any) {
        performSegue(withIdentifier: "marcadoreslista", sender: self)
    }
    
    
    //aqui  imagenes principales
    
    
    @IBOutlet weak var MapaTouch: UIImageView!
    
    @IBOutlet weak var InvitadosTouch: UIImageView!
    
    @IBOutlet weak var NoticiasTouch: UIImageView!
    
    @IBOutlet weak var AvisosTouch: UIImageView!
    
    @IBOutlet weak var TalleresTouch: UIImageView!
    
    @IBOutlet weak var HorariosTouch: UIImageView!
    
    
    
    // Variable para almacenar las imágenes seleccionadas
    var imagesToShow: [ImagesShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configurar el color de fondo semitransparente (rosa con transparencia)
        view.backgroundColor = UIColor(red: 1.0, green: 0.753, blue: 1.0, alpha: 1.0)
        
        // Agregar gestos a las imágenes
        addTapGesture(to: MapaTouch, action: #selector(mapTapped))
        addTapGesture(to: InvitadosTouch, action: #selector(invitedTapped))
        addTapGesture(to: NoticiasTouch, action: #selector(newsTapped))
        addTapGesture(to: AvisosTouch, action: #selector(warningsTapped))
        addTapGesture(to: TalleresTouch, action: #selector(workshopsTapped))
        addTapGesture(to: HorariosTouch, action: #selector(scheduleTapped))
    }
    
    func addTapGesture(to imageView: UIImageView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func mapTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/maps")
    }
    
    @objc func invitedTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/maps")
    }
    
    @objc func newsTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/maps")
    }
    
    @objc func warningsTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/maps")
    }
    
    @objc func workshopsTapped() {
        fetchImages(from: "https://link-to-workshops-images.json")
    }
    
    @objc func scheduleTapped() {
        fetchImages(from: "https://link-to-schedule-images.json")
    }
    
    func fetchImages(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al obtener los datos: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let imagesResponse = try decoder.decode(ImagesShowResponse.self, from: data)
                DispatchQueue.main.async {
                    self.imagesToShow = imagesResponse.imagesResponse
                    self.performSegue(withIdentifier: "showOption", sender: self)
                }
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }.resume()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOption" {
            if let destinationVC = segue.destination as? HorizontalImagesViewController {
                destinationVC.images = imagesToShow // Enviar las imágenes al siguiente ViewController
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
