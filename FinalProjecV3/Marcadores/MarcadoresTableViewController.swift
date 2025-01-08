//
//  MarcadoresTableViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//
import UIKit

class MarcadoresTableViewController: UITableViewController {
    var marcadores = [Marcadores]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        marcadores = DataManager.shared.listadodeMarcadores()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marcadorCell", for: indexPath) as! MarcadoresTableViewCell
        let marcador = marcadores[indexPath.row]
        cell.MarcadorNombre.text = marcador.name
        cell.MarcadorCosto.text = marcador.cost
        cell.MarcadorMesa.text = marcador.tableNumber
        cell.MarcadorImportancia.text = marcador.importance
        cell.MarcadorTipo.text = marcador.type
        cell.MarcadorArtista.text = marcador.artist
        cell.MarcadorTag.text = marcador.tag
        switch marcador.importance?.lowercased() {
        case "mucha":
            cell.backgroundColor = UIColor(named: "rojo")
        case "media":
            cell.backgroundColor = UIColor(named: "naranja")
        case "poca":
            cell.backgroundColor = UIColor(named: "verde")
        default:
            cell.backgroundColor = UIColor(named: "element_bg")
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "subtitles")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marcadores.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "editMarcadorSegue", sender: indexPath)
        //Cambiar segue para no crear instancia nueva, solo llenar una con lo que ya tenemos
        let selectedMarcador = marcadores[indexPath.row]
        let addMarcadorVC = storyboard?.instantiateViewController(withIdentifier: "AddMarcadorViewController") as! AddMarcadorViewController
        addMarcadorVC.marcador = selectedMarcador
        navigationController?.pushViewController(addMarcadorVC, animated: true)
    }

    // Preparar los datos para el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editMarcadorSegue",
              let destination = segue.destination as? AddMarcadorViewController,
              let selectedIndexPath = sender as? IndexPath else { return }
        destination.marcador = marcadores[selectedIndexPath.row]
        
        
    }
}
