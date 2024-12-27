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
        let cell = tableView.dequeueReusableCell(withIdentifier: "marcadorCell", for: indexPath) as!
        MarcadoresTableViewCell
        cell.MarcadorNombre.text = marcadores[indexPath.row].name
        cell.MarcadorCosto.text = marcadores[indexPath.row].cost
        cell.MarcadorMesa.text = marcadores[indexPath.row].tableNumber
        cell.MarcadorImportancia.text = marcadores[indexPath.row].importance
        cell.MarcadorTipo.text = marcadores[indexPath.row].type
        cell.MarcadorArtista.text = marcadores[indexPath.row].artist
        cell.MarcadorTag.text = marcadores[indexPath.row].tag
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return marcadores.count
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //no hay necesidad de hacer una vista extra donde se visualice el marcador compleo
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {return}
        if (identifier == "createMarcador"){
            if let fin = segue.destination as? AddMarcadorViewController{
                //se pasan los datos al add marcasdor view
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
