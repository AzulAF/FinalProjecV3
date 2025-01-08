//
//  AddMarcadorViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 20/12/24.
//

import UIKit
import CoreData


class AddMarcadorViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    var marcador: Marcadores? {
        didSet {
            
        }
    }

    
    @IBOutlet weak var NewNombre: UITextField!
    
    
    @IBOutlet weak var NewArtista: UITextField!
    
    
    @IBOutlet weak var NewCosto: UITextField!
    
    @IBOutlet weak var NewImportancia: UITextField!
    
    @IBOutlet weak var NewMesa: UITextField!
    
    @IBOutlet weak var NewTag: UITextField!
    
    @IBOutlet weak var NewTipo: UITextField!
    
    @IBOutlet weak var SaveMarcadorButton: UIButton!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    
    @IBAction func SaveMarcador(_ sender: Any) {
        
    guard SaveMarcadorButton.isEnabled else {
            showValidationError()
            return
        }

        let name = NewNombre.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let artista = NewArtista.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let costo = NewCosto.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let importancia = NewImportancia.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let mesaText = NewMesa.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let tag = NewTag.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let tipo = NewTipo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let mesa: String
        if let mesaValue = Int(mesaText), (1...100).contains(mesaValue) {
            mesa = "\(mesaValue)"
        } else {
            mesa = mesaText
        }

        if let marcador = marcador {
            marcador.name = name
            marcador.artist = artista
            marcador.cost = costo
            marcador.importance = importancia
            marcador.tableNumber = mesa
            marcador.tag = tag
            marcador.type = tipo
        } else {
            let NewMarcadorFull = Marcadores(context: DataManager.shared.persistentContainer.viewContext)
            NewMarcadorFull.name = name
            NewMarcadorFull.artist = artista
            NewMarcadorFull.cost = costo
            NewMarcadorFull.importance = importancia
            NewMarcadorFull.tableNumber = mesa
            NewMarcadorFull.tag = tag
            NewMarcadorFull.type = tipo
        }
        DataManager.shared.saveContext()
        navigationController?.popViewController(animated: true)
        let successAlert = UIAlertController(
            title: "Se añadió marcador",
            message: "Marcador guardado exitosamente.",
            preferredStyle: .alert
        )
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(successAlert, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            validateInputs()
        }
    
    func showValidationError() {
        var errorMessage = "Favor de llenar el siguiente campo:\n"
        
        if NewNombre.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Nombre\n"
        }
        if NewArtista.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Artista\n"
        }
        if NewCosto.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Costo\n"
        }
        if NewImportancia.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Importancia\n"
        }
        if let mesaText = NewMesa.text?.trimmingCharacters(in: .whitespacesAndNewlines), let mesa = Int(mesaText), !(1...100).contains(mesa) {
            errorMessage += "- Mesa (debe ser entre 1 - 00 si es un número)\n"
        } else if NewMesa.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Mesa\n"
        }
        if NewTag.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Tag\n"
        }
        if NewTipo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            errorMessage += "- Tipo\n"
        }
        
        let alert = UIAlertController(title: "Información faltante", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func validateInputs() {
        let nameValid = !(NewNombre.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let artistaValid = !(NewArtista.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let costoValid = !(NewCosto.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let importanciaValid = !(NewImportancia.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let mesaText = NewMesa.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let mesaValid = (mesaText != nil && (Int(mesaText!) == nil || (Int(mesaText!) != nil && (1...100).contains(Int(mesaText!)!))))
        let tagValid = !(NewTag.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let tipoValid = !(NewTipo.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)

        SaveMarcadorButton.isEnabled = nameValid && artistaValid && costoValid && importanciaValid && mesaValid && tagValid && tipoValid
    }


        
    
    @objc func mesaTextChanged(_ textField: UITextField) {
        if let text = textField.text, let number = Int(text), (1...100).contains(number) {
            warningLabel.isHidden = true
            validateInputs()
        } else if let text = textField.text, Int(text) == nil {
            warningLabel.isHidden = true
            validateInputs()
        } else {
            warningLabel.isHidden = false
        }
    }

        let importanciaOptions = ["Mucha", "Media", "Poca"]
        var importanciaPicker = UIPickerView()

    override func viewDidLoad() {
           super.viewDidLoad()
            view.backgroundColor = UIColor(named: "element_bg")
            warningLabel.isHidden = true
            warningLabel.textColor = .red
            warningLabel.text = "Porfavor ingrese un numero de 1 - 100."
           [NewNombre, NewArtista, NewCosto, NewImportancia, NewMesa, NewTag, NewTipo].forEach { textField in
               textField?.delegate = self
               textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
           }
            if let marcador = marcador {
                NewNombre.text = marcador.name
                NewArtista.text = marcador.artist
                NewCosto.text = marcador.cost
                NewImportancia.text = marcador.importance
                NewMesa.text = marcador.tableNumber
                NewTag.text = marcador.tag
                NewTipo.text = marcador.type
                SaveMarcadorButton.setTitle("Actualizar", for: .normal)
            }
            importanciaPicker.delegate = self
            importanciaPicker.dataSource = self
            importanciaPicker.backgroundColor = .systemGray6
            NewImportancia.inputView = importanciaPicker
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(donePickingImportance))
            toolbar.setItems([doneButton], animated: true)
            toolbar.isUserInteractionEnabled = true
            NewImportancia.inputAccessoryView = toolbar
            SaveMarcadorButton.isEnabled = false
            NewMesa.addTarget(self, action: #selector(mesaTextChanged(_:)), for: .editingChanged)
            validateInputs()
        
       }
    
    // MARK: - UIPickerView DataSource & Delegate

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return importanciaOptions.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return importanciaOptions[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            NewImportancia.text = importanciaOptions[row]
            validateInputs()
        }

        // MARK: - Finalizar selección
        @objc func donePickingImportance() {
            if NewImportancia.text?.isEmpty ?? true {
                NewImportancia.text = importanciaOptions.first
            }
            NewImportancia.resignFirstResponder()
        }
    
}
