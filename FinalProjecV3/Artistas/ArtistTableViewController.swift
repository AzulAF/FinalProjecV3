//
//  ArtistTableViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class ArtistTableViewController: UITableViewController, UITextFieldDelegate {
    // Variables para almacenar artistas y artistas filtrados.
    var artistasv2: [Artista] = []
    var filteredArtistas: [Artista] = []
    // Control de segmentación para seleccionar el criterio de búsqueda.
    let searchSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Piso", "Mesa", "Nombre", "Sellos"])
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.selectedSegmentIndex = 0
        return control
    }()
    // Campo de texto para ingresar el valor de búsqueda.
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingrese el valor de búsqueda"
        textField.borderStyle = .roundedRect
        return textField
    }()

    // Configura la interfaz, establece el delegado del campo de texto y obtiene datos iniciales.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "purpleProject")
        // Obtiene los datos iniciales desde la API.
        fetchArtistas()
        // Configura la interfaz de búsqueda.
        setupSearchUI()
        searchTextField.delegate = self
    }
    // Configura la interfaz de búsqueda añadiendo el control de segmento y el campo de texto.
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
    // Método llamado al cambiar el segmento seleccionado.
    // Configura el placeholder y el tipo de teclado del campo de texto según el segmento seleccionado.
    @objc func segmentChanged() {
        searchTextField.text = "" //Limpia texto
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
    // Obtiene los datos de artistas desde una API, los decodifica y los carga en la tabla.
    func fetchArtistas() {
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
    // Método delegado que se llama al cambiar el texto del campo de búsqueda.
    // Filtra los artistas según el segmento seleccionado y el texto ingresado.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let newText = currentText.replacingCharacters(in: range, with: string)
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
            if newText.lowercased() == "si" || newText.lowercased() == "no" {
                filterArtistas(by: "sellos", value: newText.lowercased())
            }
            return true
        default:
            return true
        }
    }

    // AÑADIR FILTRO DE SELLOS (añadido)
    // Filtra los artistas según un campo y valor especificados.
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
    // Devuelve el número de secciones en la tabla (en este caso, siempre es 1).
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Devuelve el número de filas en la sección, basado en los artistas filtrados.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArtistas.count
    }
    // Configura las celdas de la tabla con los datos de los artistas filtrados.
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
    // Maneja la selección de una fila en la tabla y realiza la transición a otra vista.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArtist = filteredArtistas[indexPath.row] // Obtener el artista filtrado
        performSegue(withIdentifier: "showArtist", sender: selectedArtist)
    }
    // Prepara los datos para la transición a otra vista mediante un segue.
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
