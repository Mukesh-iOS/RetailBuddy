//
//  Retail_BuddyTests.swift
//  Retail BuddyTests
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import XCTest
@testable import Retail_Buddy

class Retail_BuddyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProductDetailsFromMock() {
        
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            XCTAssertNotNil(data, "Data is nil")
            let manifestData = try? JSONSerialization.jsonObject(with:data! , options: .mutableContainers)
            XCTAssertNotNil(manifestData, "Manifest Json is Invalid")
            guard (manifestData as? [String : Any]) != nil else {
                
                XCTFail("Unexpected json format")
                return
            }
        } else {
            
            XCTFail("Problem in path formation")
        }
    }
    
    func testElectronicsDetailsFromMock() {
        
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                XCTAssertNotNil(jsonResult)
                
                guard let categories = (jsonResult?.value(forKey: ProductIdentifiers.categories.rawValue) as? NSArray)?.firstObject as? NSDictionary else {
                    
                    XCTFail("Couldn't fetch values for categories")
                    return
                }
                
                let electronics = categories.value(forKey: ProductIdentifiers.electronics.rawValue) as? Array<Any>
                XCTAssertEqual(electronics?.count, 5)
                
                guard let electronicsInfo = electronics else {
                    
                    XCTFail("Couldn't fetch values for electronics")
                    return
                }
                
                for case let item as Dictionary<String, Any> in electronicsInfo {
                    
                    XCTAssertNotNil(item[Identification.price.rawValue] as? String)
                    XCTAssertNotNil(item[Identification.productId.rawValue] as? NSInteger)
                    XCTAssertNotNil(item[Identification.title.rawValue] as? String)
                    XCTAssertNotNil(item[Identification.productType.rawValue] as? String)
                }
            } catch let error as NSError {
                
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("Path cannot be found")
        }
    }
    
    func testFurnituresDetailsFromMock() {
        
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                XCTAssertNotNil(jsonResult)
                
                guard let categories = (jsonResult?.value(forKey: ProductIdentifiers.categories.rawValue) as? NSArray)?.firstObject as? NSDictionary else {
                    
                    XCTFail("Couldn't fetch values for categories")
                    return
                }
                
                let furnitures = categories.value(forKey: ProductIdentifiers.furnitures.rawValue) as? Array<Any>
                XCTAssertEqual(furnitures?.count, 5)
                
                guard let furnituresInfo = furnitures else {
                    
                    XCTFail("Couldn't fetch values for electronics")
                    return
                }
                
                for case let item as Dictionary<String, Any> in furnituresInfo {
                    
                    XCTAssertNotNil(item[Identification.price.rawValue] as? String)
                    XCTAssertNotNil(item[Identification.productId.rawValue] as? NSInteger)
                    XCTAssertNotNil(item[Identification.title.rawValue] as? String)
                    XCTAssertNotNil(item[Identification.productType.rawValue] as? String)
                }
            } catch let error as NSError {
                
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("Path cannot be found")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
