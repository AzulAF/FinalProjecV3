//
//  ImageCellOne.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 05/01/25.
//
import UIKit

class ImageCellOne: UICollectionViewCell {
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFit // Ajustar para que la imagen se muestre completa
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageShow: ImagesShow) {
        // Configurar un placeholder inicial
        imageView.image = UIImage(named: "a1")
        
        // Descarga manual de la imagen
        guard let url = URL(string: imageShow.imagen) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error al descargar la imagen: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error: datos inválidos o no se pudo convertir a UIImage")
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
