//
//  Sweet_Sweets_ManiaTests.swift
//  Sweet Sweets ManiaTests
//
//  Created by Ilija Mihajlovic on 5/24/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import XCTest

@testable import Sweet_Sweets_Mania

//Still Testing
class Sweet_Sweets_ManiaTests: XCTestCase {
    var userProf: WelcomeScene!

    override func setUp() {
        super.setUp()
        userProf = WelcomeScene()
        userProf.addNodes()
        userProf.setupNodes()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class..
        userProf = nil
        super.tearDown()
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        
    XCTAssert(userProf.signInAnonymouslyButton != nil)
       
        
    }

    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
