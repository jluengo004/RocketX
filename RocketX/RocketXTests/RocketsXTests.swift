//
//  RocketsXTests.swift
//  RocketXTests
//
//  Created by Jon Luengo Muntion on 19/2/21.
//

import XCTest
@testable import RocketX

class RocketsXTests: XCTestCase {
    
    var rocketsVC: RocketsCollectionViewController? = nil

    override func setUpWithError() throws {
        rocketsVC = RocketsCollectionViewController(nibName: "RocketsCollectionViewController", bundle: nil)
        rocketsVC?.rockets = [Rocket(), Rocket(), Rocket(), Rocket()]
        rocketsVC?.loadView()
        rocketsVC?.viewDidLoad()
    }

    override func tearDownWithError() throws {
        rocketsVC = nil
    }
    
    func testEmptyRocketCase() throws {
        rocketsVC?.rockets = nil
        rocketsVC?.checkIfRocketsEmpty()
        XCTAssertTrue(rocketsVC?.rockets?[0].flickrImages?[0] == "LoadingRocket")
        let indexPath = IndexPath(row: 0, section: 0)
        let rocketCell = rocketsVC?.collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCollectionViewCell
        XCTAssertNoThrow(rocketCell.hideForEmptyRocket(hide: true))
    }
    
    func testPageControlCreation() throws {
        rocketsVC?.pageController.numberOfPages = (rocketsVC?.rockets!.count)!
        XCTAssertTrue(rocketsVC?.pageController.numberOfPages == 4)
    }
    
    func testOpenWiki() throws {
        rocketsVC?.collectionView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let rocketCell = rocketsVC?.collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCollectionViewCell
        rocketCell.wikipediaURL = URL(string:"https://en.wikipedia.org/wiki/Falcon_1")
        XCTAssertNoThrow(rocketCell.navigateToWikipedia(rocketCell.wikipediaButton))
        XCTAssertNoThrow(rocketsVC?.openWikiWebView(url: rocketCell.wikipediaURL))
    }
    
    func testOpenGallery() throws {
        rocketsVC?.collectionView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let rocketCell = rocketsVC?.collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCollectionViewCell
        rocketCell.galleryImgStrings = [   "https://imgur.com/DaCfMsj.jpg",
                                           "https://imgur.com/azYafd8.jpg"
                                       ]
        let galleryImgStrings: [URL] = [   URL(string: "https://imgur.com/DaCfMsj.jpg")!,
                                           URL(string: "https://imgur.com/azYafd8.jpg")!
                                        ]
        XCTAssertNoThrow(rocketCell.imageTapped())
        XCTAssertNoThrow(rocketsVC?.openGallery(galleryImgUrls: galleryImgStrings))
    }
    
    func testReloadRockets() throws {
        rocketsVC?.collectionView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let rocketCell = rocketsVC?.collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCollectionViewCell
        XCTAssertNoThrow(rocketCell.reload(rocketCell.reloadButton))
        XCTAssertNoThrow(rocketsVC?.reloadRockets())
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
