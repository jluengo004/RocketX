//
//  RocketsCollectionViewController.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "RocketCell"

class RocketsCollectionViewController: UICollectionViewController {
    
    public var rockets: Rockets? = nil;
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private let itemsPerRow: CGFloat = 1
    var pageController: UIPageControl!
    var loadingRocket: UIImage! = nil
    var loadingRocketString = "LoadingRocket"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingRocket = UIImage(named: loadingRocketString)
        checkIfRocketsEmpty()
        
        self.edgesForExtendedLayout = []
        
        self.title = "SpaceX Rockets"
        
        
        self.clearsSelectionOnViewWillAppear = false
        self.collectionView.register(UINib(nibName: "RocketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        createPageControl()
    }
    
    private func checkIfRocketsEmpty() {
        if (rockets == nil) {
            let emptyRocket = Rocket()
            emptyRocket.flickrImages = [loadingRocketString]
            rockets = [emptyRocket]
            let alert = UIAlertController(title: NSLocalizedString("conection_error", comment: ""), message:  NSLocalizedString("rocket_empty_message", comment: "") , preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
        }
    }
    
    private func createPageControl() {
        pageController = UIPageControl(frame: CGRect(x: 50, y: self.view.bounds.maxY * 0.39, width: self.view.frame.width - 100, height: 50))
        pageController.currentPage = 0
        self.view.addSubview(pageController)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rocketCount = rockets?.count ?? 0
        pageController.numberOfPages = rocketCount
        return rocketCount
    }

    
    //TODO: rocket! to rocket?
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RocketCollectionViewCell
        
        cell.delegate = self
        let rocket = rockets![indexPath.row]
        
        if (rocket.flickrImages?[0] == loadingRocketString) {
            cell.hideForEmptyRocket(hide: true)
            cell.reloadButton.setTitle(NSLocalizedString("reload", comment: ""), for: .normal)
            cell.image.image = UIImage(named: loadingRocketString)
            return cell
        }
        
        if (cell.nameLabel.isHidden) {
            cell.hideForEmptyRocket(hide: false)
        }
        
        cell.nameLabel.text = rocket.name
        cell.descriptionLabel.text = rocket.description
        cell.galleryImgStrings = rocket.flickrImages ?? []
        
        if rocket.wikipedia != nil, let wikiURL = URL(string: rocket.wikipedia!) {
            cell.wikipediaURL = wikiURL
        }
        cell.heightLabel.text = String(format: NSLocalizedString("height.by_meters", comment: ""), rocket.height?.meters as! CVarArg)
        cell.diameterLabel.text = String(format: NSLocalizedString("diameter.by_meters", comment: ""), rocket.diameter?.meters as! CVarArg)
        cell.massLabel.text = String(format: NSLocalizedString("mass.by_meters", comment: ""), rocket.mass?.kg as! CVarArg)
        cell.activeLabel.text = String(format: NSLocalizedString("active.by_bool", comment: ""), rocket.active ?? false ? "Yes" : "No" )
        cell.launchCostLabel.text = String(format: NSLocalizedString("launch_cost.by_cost", comment: ""), rocket.costPerLaunch as! CVarArg)
        cell.firstFlightLabel.text = String(format: NSLocalizedString("first_flight.by_date", comment: ""), rocket.firstFlight as! CVarArg)
        
        if let imageString = rocket.flickrImages?[0]{
            if let imageURL = URL(string: imageString ) {
                cell.image.sd_setImage(with: imageURL, placeholderImage: self.loadingRocket, options: .highPriority, context: nil)
            }
        }
        
        return cell
    }
    
}

extension RocketsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (translation.x < 0) {
            //Scrolling from right to left
            if (pageController.currentPage < pageController.numberOfPages) {
                pageController.currentPage += 1
            }
            
        } else {
            //Scrolling from left to right
            if (pageController.currentPage != 0) {
                pageController.currentPage -= 1
            }
        }
    }
}

extension RocketsCollectionViewController: RocketCellDelegate {
    func openGallery(galleryImgUrls: [URL]) {
        DispatchQueue.main.async {
            let galleryVC = GalleryCollectionViewController(nibName: "GalleryCollectionViewController", bundle: nil)
            galleryVC.galleryImgUrl = galleryImgUrls
            
            self.navigationController?.pushViewController(galleryVC, animated: true)
            
        }
    }
    
    func reloadRockets() {
        Services().getAllRockets(timeOut: 60.0) { (rockets, error) in
            DispatchQueue.main.async {
                self.rockets = rockets
                self.checkIfRocketsEmpty()
                self.collectionView.reloadData()
            }
        }
    }
    
    func openWikiWebView(url: URL) {
        DispatchQueue.main.async {
            let webVC = WebViewController(nibName: "WebViewController", bundle: nil)
            webVC.wikipediaURL = url
            
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }
    }
    
}
