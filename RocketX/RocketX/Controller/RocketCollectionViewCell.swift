//
//  RocketCollectionViewCell.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import UIKit

protocol RocketCellDelegate {
    func openWikiWebView(url: URL)
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
    
    var delegate: RocketCellDelegate?
    
    var wikipediaURL: URL!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wikipediaButton.setTitle(NSLocalizedString("wikipedia_button", comment: ""), for: .normal)
    }

    @IBAction func navigateToWikipedia(_ sender: UIButton) {
        delegate?.openWikiWebView(url: wikipediaURL)
    }
}
