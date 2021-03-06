//
//  SplashViewController.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import UIKit

//TODO: check Internet conectivity
class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRocketsData()
    }
    
    //Loads Rockets while showing Splash Screen
    func loadRocketsData() {
        Services().getAllRockets(timeOut: 5.0) { (rockets, error) in
            self.loadRocketsScreen(with: rockets)
        }
    }
    
    private func loadRocketsScreen(with rockets: Rockets?) {
        DispatchQueue.main.async {
            let rocketsVC = RocketsCollectionViewController(nibName: "RocketsCollectionViewController", bundle: nil)
            rocketsVC.rockets = rockets
            
            let nav = UINavigationController(rootViewController: rocketsVC)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
        }
    }

}
