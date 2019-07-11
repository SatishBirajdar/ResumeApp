//
//  ResumeAppTests.swift
//  ResumeAppTests
//
//  Created by Satish Birajdar on 2019-07-10.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import XCTest
@testable import ResumeApp

class APIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    // make sure the host URL is correct
    func testGetBiodataWithExpectedHostAndURLString(){
        let apiManager = APIManager()
        apiManager.getBiodata { biodatas, error in
            XCTAssertEqual(apiManager.chachedURL?.host, "www.mocky.io")
            XCTAssertEqual(apiManager.chachedURL?.absoluteString, "https://www.mocky.io/v2/5d27aa2e320000570071bc42")
        }
    }
    
    // make sure getBiodata request sucess give [biodata] type
    func testGetBiodataSucessReturnsCandidateDetails(){
        let apiManager = APIManager()
        var biodatasResponse: [Biodata]?
        let biodataExpectation = expectation(description: "biodata")
        apiManager.getBiodata { biodatas, error in
            biodatasResponse = biodatas
            biodataExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(biodatasResponse)
        }
    }
}
