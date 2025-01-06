//
//  HorizontalImagesViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 05/01/25.
//
import UIKit

class HorizontalImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Variable para recibir las imágenes desde el controlador anterior
    var images: [ImagesShow] = []
    
    // Crear una colección de vista
    private var collectionView: UICollectionView!
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        guard let currentIndexPath = visibleIndexPaths.first else { return }
        
        if currentIndexPath.row == images.count - 1 { // Última imagen
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar el color de fondo semitransparente (rosa con transparencia)
        view.backgroundColor = UIColor(red: 1.0, green: 0.753, blue: 1.0, alpha: 0.7)
        
        // Configurar el diseño de la colección
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Desplazamiento horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height) // Tamaño de cada celda
        layout.minimumLineSpacing = 0 // Sin espacio entre celdas
        
        // Inicializar la colección
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true // Permitir desplazamiento tipo "paginación"
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Establecer fondo transparente para el collectionView
        collectionView.backgroundColor = .clear
        
        // Agregar la colección a la vista
        view.addSubview(collectionView)
        
        // Configurar las restricciones de diseño
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    // MARK: - Métodos de UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let imageUrl = images[indexPath.row].imagen
        cell.configure(with: imageUrl)
        return cell
    }
    
    // MARK: - Métodos de UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
