//
//  MainViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 21/12/24.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var titulo: UILabel!
    
    //@IBOutlet weak var collectionViewPlaceholder: UICollectionView!
    @IBOutlet weak var buttonmarcadores: UIButton!
    
    
    @IBOutlet weak var buttonlista: UIButton!
    
    
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
    

    var imagesToShow: [ImagesShow] = []
    var imagesToShow2: [ImagesShow] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Observa cambios en la conectividad
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleConexionCambio),
                                               name: .conexionCambio,
                                               object: nil)
        
        // Comprueba el estado inicial de la conexión
        verificarConexion()
        buttonlista.tintColor = UIColor(named: "colorEnabled") // Replace with your desired color
        buttonmarcadores.tintColor = UIColor(named: "colorEnabled")
        titulo?.layer.cornerRadius = 10
        titulo?.layer.masksToBounds = true
        titulo?.layer.borderWidth = 2
        titulo?.layer.borderColor = UIColor.black.cgColor
        titulo.backgroundColor = UIColor.white
        //Gestos
        addTapGesture(to: MapaTouch, action: #selector(mapTapped))
        addTapGesture(to: InvitadosTouch, action: #selector(invitedTapped))
        addTapGesture(to: NoticiasTouch, action: #selector(newsTapped))
        addTapGesture(to: AvisosTouch, action: #selector(warningsTapped))
        addTapGesture(to: TalleresTouch, action: #selector(workshopsTapped))
        addTapGesture(to: HorariosTouch, action: #selector(scheduleTapped))
        setupCollectionView()
        mainmenu()
        print("cargan imagenes de menu")

    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.bounds.width, height: 200)
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //cambiar color de fondo?
        collectionView.backgroundColor = UIColor(red: 1.0, green: 0.753, blue: 1.0, alpha: 0.0)
        collectionView.register(ImageCellOne.self, forCellWithReuseIdentifier: "ImageCellOne")
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
        // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesToShow2.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCellOne", for: indexPath) as! ImageCellOne
        let imageShow = imagesToShow2[indexPath.item]
        cell.configure(with: imageShow)
        return cell
    }
    
    func addTapGesture(to imageView: UIImageView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func mapTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/mapas2")
    }
    
    @objc func invitedTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/invitados")
    }
    
    @objc func newsTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/noticias")
    }
    
    @objc func warningsTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/avisos")
    }
    
    @objc func workshopsTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/talleres")
    }
    
    @objc func scheduleTapped() {
        fetchImages(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/horarios")
    }
    
    @objc func mainmenu() {
        fetchImages2(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/maps")

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
    
    func fetchImages2(from urlString: String) {
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
                    self.imagesToShow2 = imagesResponse.imagesResponse
                    self.collectionView.reloadData()
                    print("Se ha cargado la lista")
                    print(self.imagesToShow2)
                    
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
                destinationVC.images = imagesToShow 
            }
        }
    }
    

    //Para internet
    
    deinit {
            NotificationCenter.default.removeObserver(self, name: .conexionCambio, object: nil)
        }
        
        @objc private func handleConexionCambio() {
            verificarConexion()
        }
        
        private func verificarConexion() {
            if !InternetMonitor.shared.hayConexion {
                mostrarAlerta(titulo: "Sin conexión a Internet",
                              mensaje: "No tienes conexión a Internet. Por favor, verifica tu red.")
            } else if !InternetMonitor.shared.tipoConexionWiFi {
                mostrarAlerta(titulo: "Usando datos móviles",
                              mensaje: "Estás usando datos móviles. Esto podría consumir tu plan.")
            }
        }
        
        private func mostrarAlerta(titulo: String, mensaje: String) {
            let alerta = UIAlertController(title: titulo,
                                            message: mensaje,
                                            preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
    
}
