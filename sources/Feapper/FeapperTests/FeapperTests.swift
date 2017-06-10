//
//  FeapperTests.swift
//  FeapperTests
//
//  Created by mathieu lecoupeur on 10/06/2017.
//  Copyright © 2017 mathieu lecoupeur. All rights reserved.
//

import XCTest
@testable import Feapper

class FeapperTests: XCTestCase, FeapperDelegate {
    
    var featureOnExpectation:XCTestExpectation?
    var featureOffExpectation:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        let featureJSON = JSONHelper.loadJSON(filename: "featuresConfig", bundle: Bundle(for: FeapperTests.self))
        if featureJSON != nil {
            Feapper.shared.setup(json: featureJSON!)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFFSetup() {
        
        XCTAssertTrue(Feapper.shared.isFeatureEnabled(featureId: "Feature"))
        XCTAssertFalse(Feapper.shared.isFeatureEnabled(featureId: "OtherFeature"))
    }
    
    func testFFAddHasRemoveFeature() {
        
        XCTAssertFalse(Feapper.shared.hasFeature(featureId: "ThirdFeature"))
        Feapper.shared.addFeature(featureId: "ThirdFeature")
        XCTAssertTrue(Feapper.shared.hasFeature(featureId: "ThirdFeature"))
        Feapper.shared.removeFeature(featureId: "ThirdFeature")
        XCTAssertFalse(Feapper.shared.hasFeature(featureId: "ThirdFeature"))
    }
    
    func testFFRegister() {
        
        featureOnExpectation = XCTestExpectation(description: "Feature has been enabled")
        Feapper.shared.register(delegate: self, featureId: "Feature")
        wait(for: [featureOnExpectation!], timeout: 5.0)
        
        featureOffExpectation = XCTestExpectation(description: "Feature has been disabled")
        Feapper.shared.register(delegate: self, featureId: "OtherFeature")
        wait(for: [featureOffExpectation!], timeout: 5.0)
    }
    
    func testFFFlipOn() {
        
        Feapper.shared.register(delegate: self, featureId: "OtherFeature")
        featureOnExpectation = XCTestExpectation(description: "Feature has been enabled")
        Feapper.shared.flipOn(featureId: "OtherFeature")
        wait(for: [featureOnExpectation!], timeout: 5.0)
    }
    
    func testFFFlipOff() {
        
        Feapper.shared.register(delegate: self, featureId: "Feature")
        featureOffExpectation = XCTestExpectation(description: "Feature has been disabled")
        Feapper.shared.flipOff(featureId: "Feature")
        wait(for: [featureOffExpectation!], timeout: 5.0)
    }
    
    // MARK: - FeatureFlipperDelegate
    func featureEnabled(featureId: String) {
        
        featureOnExpectation?.fulfill()
    }
    
    func featureDisabled(featureId: String) {
        
        featureOffExpectation?.fulfill()
    }
}
