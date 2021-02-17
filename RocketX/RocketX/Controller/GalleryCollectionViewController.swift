//
//  GalleryCollectionViewController.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 17/2/21.
//

import UIKit

private let reuseIdentifier = "GalleryCell"

class GalleryCollectionViewController: UICollectionViewController {
    
    var galleryImgUrl: [URL] = []
    var loadingRocketString = "LoadingRocket"
    var loadingRocket: UIImage! = nil
    private let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 25, right: 10)
    var itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingRocket = UIImage(named: loadingRocketString)

        self.collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return galleryImgUrl.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
    
        cell.image.sd_setImage(with: galleryImgUrl[indexPath.row], completed: nil)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedIndexPassed = 0
        if (indexPath.row > 0) {
            let imageBackup = galleryImgUrl
            galleryImgUrl[0] = imageBackup[indexPath.row]
            for i in 1...galleryImgUrl.count - 1 {
                galleryImgUrl[i] = imageBackup[i + selectedIndexPassed - 1]
                if (i == indexPath.row) {
                    selectedIndexPassed = 1
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    
}
    
extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0) {
            let paddingSpace = sectionInsets.left
            let availableWidth = view.frame.width - paddingSpace

            return CGSize(width: availableWidth, height: availableWidth)
        }

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
}
