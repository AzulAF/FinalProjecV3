//
//  ArtistTableViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class ArtistTableViewController: UITableViewController {
    var artistas = [Artista]()
    var artistasv2: [Artista] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtistas()


    }
    
    func fetchArtistas(){
        //Método para realizar la solicitud HTTP y decodificar el JSON
            
        let urlString = "https://private-412939-proyectoprueba1.apiary-mock.com/artistas"
        
        guard let url = URL(string: urlString) else { return }
        
        // Realizamos la solicitud HTTP
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Verificamos si hubo un error
            if let error = error {
                print("Error al obtener los datos: \(error)")
                return
            }
            
            // Verificamos que los datos no sean nulos
            guard let data = data else { return }
            
            // Intentamos decodificar los datos JSON en la estructura ArtistaResponse
            do {
                let decoder = JSONDecoder()
                let artistaResponse = try decoder.decode(ArtistaResponse.self, from: data)
                
                // Asignamos los artistas al array de artistas
                DispatchQueue.main.async {
                    self.artistasv2 = artistaResponse.artistasresp
                    self.tableView.reloadData()  // Recargamos la tabla
                }
                
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }.resume()  // Inicia la solicitud
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistasv2.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as?
                ArtistaTableViewCell else{
            return UITableViewCell()
        }
        cell.ArtistName.text = artistasv2[indexPath.row].nombre
        //cell.Artistimg.text = artistas[indexPath.row].imagen
        cell.ArtistMesa.text = artistasv2[indexPath.row].mesa
        cell.ArtistPiso.text = artistasv2[indexPath.row].piso
        
        if let imageUrl = URL(string: artistasv2[indexPath.row].imagen) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.Artistimg.image = UIImage(data: data)
                    }
                }
            }
        } else {
            cell.Artistimg.image = UIImage(named: "a1") // Fallback image
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArtist = artistasv2[indexPath.row] // Get the selected artist
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


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
