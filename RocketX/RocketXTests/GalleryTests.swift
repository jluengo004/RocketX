//
//  GalleryTests.swift
//  RocketXTests
//
//  Created by Jon Luengo Muntion on 22/2/21.
//

import Foundation
import XCTest
@testable import RocketX

class GalleryTests: XCTestCase {
    
    var galleryVC: GalleryCollectionViewController? = nil

    override func setUpWithError() throws {
        galleryVC = GalleryCollectionViewController(nibName: "GalleryCollectionViewController", bundle: nil)
        galleryVC?.galleryImgUrl = [   URL(string: "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg")!,
                                       URL(string: "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg")!,
                                       URL(string: "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg")!,
                                       URL(string: "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg")!
                                ]
        galleryVC?.loadView()
        galleryVC?.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testReorderGallery() throws {
        galleryVC?.collectionView((galleryVC?.collectionView)!, didSelectItemAt: IndexPath(row: 2, section: 1))
        XCTAssertTrue(((galleryVC?.galleryImgUrl = [  URL(string: "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg")!,
                                                      URL(string: "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg")!,
                                                      URL(string: "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg")!,
                                                      URL(string: "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg")!
        ]) != nil) )
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
