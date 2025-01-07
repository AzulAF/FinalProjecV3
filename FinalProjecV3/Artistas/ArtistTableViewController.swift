//
//  ArtistTableViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class ArtistTableViewController: UITableViewController, UITextFieldDelegate {
    var artistasv2: [Artista] = []
    var filteredArtistas: [Artista] = [] // Para los resultados filtrados
    
    let searchSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Piso", "Mesa", "Nombre", "Sellos"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingrese el valor de búsqueda"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtistas()
        setupSearchUI()
        searchTextField.delegate = self
    }
    
    func setupSearchUI() {
        let stackView = UIStackView(arrangedSubviews: [searchSegmentControl, searchTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.tableHeaderView = stackView
        stackView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        searchSegmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc func segmentChanged() {
        searchTextField.text = ""
        switch searchSegmentControl.selectedSegmentIndex {
        case 0: // Piso
            searchTextField.keyboardType = .numberPad
            searchTextField.placeholder = "Ingrese 1 o 2"
        case 1: // Mesa
            searchTextField.keyboardType = .numberPad
            searchTextField.placeholder = "Ingrese un número del 1 al 100"
        case 2: // Nombre
            searchTextField.keyboardType = .default
            searchTextField.placeholder = "Ingrese un nombre (máx. 30 caracteres)"
        case 3: // Sellos
            searchTextField.keyboardType = .default
            searchTextField.placeholder = "Ingrese 'SI' o 'NO'"
        default:
            break
        }
    }
    
    func fetchArtistas() {
        // Método para realizar la solicitud HTTP y decodificar el JSON
        let urlString = "https://private-412939-proyectoprueba1.apiary-mock.com/artistas"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al obtener los datos: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let artistaResponse = try decoder.decode(ArtistaResponse.self, from: data)
                DispatchQueue.main.async {
                    self.artistasv2 = artistaResponse.artistasresp
                    self.filteredArtistas = self.artistasv2
                    self.tableView.reloadData()
                }
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }.resume()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        // Si el campo de texto está vacío, mostrar todos los artistas
        if newText.isEmpty {
            filteredArtistas = artistasv2
            tableView.reloadData()
            return true
        }
        
        switch searchSegmentControl.selectedSegmentIndex {
        case 0: // Piso
            if let value = Int(newText), value == 1 || value == 2 {
                filterArtistas(by: "piso", value: "\(value)")
                return true
            }
            return false
        case 1: // Mesa
            if let value = Int(newText), (1...100).contains(value) {
                filterArtistas(by: "mesa", value: "\(value)")
                return true
            }
            return false
        case 2: // Nombre
            if newText.count <= 30 {
                filterArtistas(by: "nombre", value: newText)
                return true
            }
            return false
        case 3: // Sellos
            // Permitir cualquier texto pero filtrar solo cuando sea "si" o "no"
            if newText.lowercased() == "si" || newText.lowercased() == "no" {
                filterArtistas(by: "sellos", value: newText.lowercased())
            }
            return true // Permitir que se modifique el texto
        default:
            return true
        }
    }

    // AÑADIR FILTRO DE SELLOS
    func filterArtistas(by field: String, value: String) {
        filteredArtistas = artistasv2.filter { artista in
            switch field {
            case "piso":
                return artista.piso == value
            case "mesa":
                return artista.mesa == value
            case "nombre":
                return artista.nombre.lowercased().contains(value.lowercased())
            case "sellos":
                return artista.sellos.lowercased() == value
            default:
                return false
            }
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArtistas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistaTableViewCell else {
            return UITableViewCell()
        }
        
        let artista = filteredArtistas[indexPath.row]
        cell.ArtistName.text = artista.nombre
        cell.ArtistMesa.text = artista.mesa
        cell.ArtistPiso.text = artista.piso
        
        if let imageUrl = URL(string: artista.imagen) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.Artistimg.image = UIImage(data: data)
                    }
                }
            }
        } else {
            cell.Artistimg.image = UIImage(named: "a1")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArtist = filteredArtistas[indexPath.row] // Obtener el artista filtrado
        performSegue(withIdentifier: "showArtist", sender: selectedArtist)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "showArtist":
            if let detailVC = segue.destination as? DetailViewController,
               let selectedArtist = sender as? Artista {
                detailVC.artist = selectedArtist
            }
        default:
            break
        }
    }
}
