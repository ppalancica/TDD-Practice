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
    
    var cancelables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancelables.removeAll()
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
    
    func test_FeedMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = FeedMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_FeedMockDataService_downloadItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = FeedMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancelables)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_FeedMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = FeedMockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation1 = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw an error URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation1.fulfill()
                    
                    // let urlError = error as? URLError
                    // XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if error as? URLError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancelables)
        
        // Then
        wait(for: [expectation1, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
