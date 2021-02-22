//
//  RocketXTests.swift
//  RocketXTests
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import XCTest
@testable import RocketX

class RocketXTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetRocketsService() throws {
        let service = Services()
        XCTAssertNoThrow(service.getAllRockets(timeOut: 60, completion: { (rockets, nil) in
            XCTAssertNotNil(rockets)
        }))
    }

    func testGetRocketsSplash() throws {
        let splashVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
        splashVC.loadViewIfNeeded()
        XCTAssertNoThrow(splashVC.loadRocketsData())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
