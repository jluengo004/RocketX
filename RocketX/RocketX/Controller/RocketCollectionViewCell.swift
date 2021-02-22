//
//  RocketCollectionViewCell.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import UIKit

protocol RocketCellDelegate {
    func openWikiWebView(url: URL)
    func reloadRockets()
    func openGallery(galleryImgUrls: [URL])
}

class RocketCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var firstFlightLabel: UILabel!
    
    @IBOutlet weak var wikipediaButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var delegate: RocketCellDelegate?
    var galleryImgStrings: [String] = []
    var wikipediaURL: URL!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.hidesWhenStopped = true
        spinner.color = UIColor.red
        
        wikipediaButton.setTitle(NSLocalizedString("wikipedia_button", comment: ""), for: .normal)
        
        reloadButton.isHidden = true
        
        image.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapRecognizer.numberOfTapsRequired = 2
        image.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func imageTapped() {
        var galleryImgUrls: [URL] = []
        for imageString in galleryImgStrings {
            galleryImgUrls.append(URL(string: imageString)!)
        }
        delegate?.openGallery(galleryImgUrls: galleryImgUrls)
    }
    
    @IBAction func reload(_ sender: UIButton) {
        spinner.startAnimating()
        delegate?.reloadRockets()
    }
    
    @IBAction func navigateToWikipedia(_ sender: UIButton) {
        delegate?.openWikiWebView(url: wikipediaURL)
    }
    
    public func hideForEmptyRocket(hide: Bool) {
        nameLabel.isHidden = hide
        descriptionLabel.isHidden = hide
        heightLabel.isHidden = hide
        diameterLabel.isHidden = hide
        massLabel.isHidden = hide
        activeLabel.isHidden = hide
        launchCostLabel.isHidden = hide
        firstFlightLabel.isHidden = hide
        wikipediaButton.isHidden = hide
        reloadButton.isHidden = !hide
    }
}
