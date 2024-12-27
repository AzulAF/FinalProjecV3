//
//  AddMarcadorViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//

import UIKit

//botones


class AddMarcadorViewController: UIViewController {
    
    
    @IBOutlet weak var NewNombre: UITextField!
    
    //@IBOutlet weak var NewArtista: UITextField!
    
    
    @IBOutlet weak var NewArtista: UITextField!
    
    
    @IBOutlet weak var NewCosto: UITextField!
    
    @IBOutlet weak var NewImportancia: UITextField!
    
    @IBOutlet weak var NewMesa: UITextField!
    
    @IBOutlet weak var NewTag: UITextField!
    
    @IBOutlet weak var NewTipo: UITextField!
    
    
    
    
    
    @IBAction func SaveMarcador(_ sender: Any) {
        
        guard let name = NewNombre.text, !name.isEmpty,
              let artista = NewArtista.text, !name.isEmpty,
              let costo = NewCosto.text, !name.isEmpty,
              let importancia = NewImportancia.text, !name.isEmpty,
              let mesa = NewMesa.text, !name.isEmpty,
              let tag = NewTag.text, !name.isEmpty,
              let tipo = NewTipo.text, !name.isEmpty else {
            return
        }
        //si llega a funcionar
        
        let successAlert = UIAlertController(
            title: "Se añadio marcador",
            message: "Se añadio correctamente",
            preferredStyle: .alert
        )
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(successAlert, animated: true)
        
        //guardamos la informacion
        
        let NewMarcadorFull = Marcadores(context: DataManager.shared.persistentContainer.viewContext)
        NewMarcadorFull.artist = artista
        NewMarcadorFull.name = name
        NewMarcadorFull.cost = costo
        NewMarcadorFull.importance = importancia
        NewMarcadorFull.tableNumber = mesa
        NewMarcadorFull.tag = tag
        NewMarcadorFull.type = tipo
        DataManager.shared.saveContext()
        
        let textFields = [NewNombre, NewArtista, NewCosto, NewImportancia, NewMesa, NewTag, NewTipo]
        textFields.forEach { $0?.text = "" }

        
        
        
    }
        
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
