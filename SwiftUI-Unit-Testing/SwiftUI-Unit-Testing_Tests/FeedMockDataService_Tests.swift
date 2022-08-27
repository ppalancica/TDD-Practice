//
//  FeedMockDataService_Tests.swift
//  SwiftUI-Unit-Testing_Tests
//
//  Created by Pavel Palancica on 8/28/22.
//

import XCTest
import Combine

@testable import SwiftUI_Unit_Testing

class FeedMockDataService_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_FeedMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items1: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService1 = FeedMockDataService(items: items1)
        let dataService2 = FeedMockDataService(items: items2)
        let dataService3 = FeedMockDataService(items: items3)
        
        // Then
        XCTAssertFalse(dataService1.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
}
