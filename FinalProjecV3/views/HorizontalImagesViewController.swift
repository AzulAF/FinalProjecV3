//
//  HorizontalImagesViewController.swift
//  FinalProjecV3
//
//  Created by Azul Alfaro on 05/01/25.
//
import UIKit

class HorizontalImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var images: [ImagesShow] = []
    private var collectionView: UICollectionView!
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        guard let currentIndexPath = visibleIndexPaths.first else { return }
        if currentIndexPath.row == images.count - 1 {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.2078, green: 0.1843, blue: 0.1843, alpha: 0.7)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
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
