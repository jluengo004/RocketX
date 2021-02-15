//
//  RocketsCollectionViewController.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class RocketsCollectionViewController: UICollectionViewController {
    
    public var rockets: Rockets? = nil;
    private let reuseIdentifier = "RocketCell"
    private let sectionInsets = UIEdgeInsets(top: 25.0, left: 10.0, bottom: 50.0, right: 10.0)
    private let itemsPerRow: CGFloat = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SpaceX Rockets"
        

        self.clearsSelectionOnViewWillAppear = false

        self.collectionView.register(UINib(nibName: "RocketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rockets?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RocketCollectionViewCell
        
        let rocket = rockets![indexPath.row]
        cell.nameLabel.text = rocket.name
        cell.descriptionLabel.text = rocket.description
        
        if let imageString = rocket.flickrImages?[1]{
            if let imageURL = URL(string: imageString ) {
                if let imageData = try? Data(contentsOf: imageURL) {
                    cell.image.image = UIImage(data: imageData)
                }
            }
        }

        return cell
    }
    
}

extension RocketsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
