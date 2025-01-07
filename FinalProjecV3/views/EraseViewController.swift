//
//  EraseViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 07/01/25.
//

import UIKit

class EraseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // Variable para almacenar las imágenes seleccionadas
    var imagesToShow2: [ImagesShow] = []
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 1.0, green: 0.453, blue: 1.0, alpha: 1.0)

        // Configurar el UICollectionView
        setupCollectionView()

        // Cargar imágenes desde la función mainmenu
        mainmenu()
        print("Cargan imágenes de menú")
    }

    func setupCollectionView() {
        // Crear el diseño para el UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.bounds.width, height: 200) // Ajusta la altura según sea necesario
        layout.minimumLineSpacing = 0

        // Crear el UICollectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 1.0, green: 0.753, blue: 1.0, alpha: 0.3)

        // Registrar la celda personalizada
        collectionView.register(ImageCellOne.self, forCellWithReuseIdentifier: "ImageCellOne")


        // Agregar el UICollectionView a la vista principal
        view.addSubview(collectionView)

        // Configurar las restricciones del UICollectionView
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
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

    @objc func mainmenu() {
        fetchImages2(from: "https://private-412939-proyectoprueba1.apiary-mock.com/event/maps")
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
}
