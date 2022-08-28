//
//  FeedViewModel_Tests.swift
//  SwiftUI-Unit-Testing_Tests
//
//  Created by Pavel Palancica on 8/27/22.
//

import XCTest
import Combine

@testable import SwiftUI_Unit_Testing

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[class or struct]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

// https://www.appsloveworld.com/swift/100/123/strange-compilation-error-with-testable-import

class FeedViewModel_Tests: XCTestCase {
    
    var viewModel: FeedViewModel?
    var cancelables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel = FeedViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewModel = nil
    }
    
    // MARK: - userIsPremium Tests
    
    func test_FeedViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = FeedViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_FeedViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = FeedViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_FeedViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = FeedViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_FeedViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = FeedViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    // MARK: - dataArray Tests
    
    func test_FeedViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_FeedViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 0..<100) // Not just a value like 10
        for _ in 0..<loopCount {
            vm.addItem(UUID().uuidString)
        }

        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount) // Most important
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    func test_FeedViewModel_dataArray_shouldAddItems_OLDER() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(UUID().uuidString) // Generates random strings containing 36 characters
        // Strings like "Item 1", "Apple", "Orange" are not really random
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        // XCTAssertGreaterThanOrEqual
        // XCTAssertLessThan
        // XCTAssertLessThanOrEqual
    }

    func test_FeedViewModel_dataArray_shouldNotAddBlankString_v1() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem("")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_FeedViewModel_dataArray_shouldNotAddBlankString_v2() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem("")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_FeedViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_FeedViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem_v1() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        vm.selectItem(UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_FeedViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem_v2() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        // select valid item
        let newItem = UUID().uuidString
        vm.addItem(newItem)
        vm.selectItem(newItem)
        
        // select invalid item
        vm.selectItem(UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_FeedViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let newItem = UUID().uuidString
        vm.addItem(newItem)
        vm.selectItem(newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }

    func test_FeedViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        vm.selectItem(randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_FeedViewModel_saveItem_shouldThrowError_itemNotFound_v1() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(UUID().uuidString))
        
        XCTAssertThrowsError(try vm.saveItem(UUID().uuidString), "Should throw Item Not Found error!") { error in

            let returnedError = error as? FeedViewModel.DataError
            XCTAssertEqual(returnedError, FeedViewModel.DataError.itemNotFound)
        }
    }
    
    func test_FeedViewModel_saveItem_shouldThrowError_itemNotFound_v2() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(UUID().uuidString))
        
        XCTAssertThrowsError(try vm.saveItem(UUID().uuidString), "Should throw Item Not Found error!") { error in

            let returnedError = error as? FeedViewModel.DataError
            XCTAssertEqual(returnedError, FeedViewModel.DataError.itemNotFound)
        }
    }
    
    func test_FeedViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(UUID().uuidString)
        }
        
        // Then
        // another way to test thrown errors
        do {
            try vm.saveItem("")
        } catch let error {
            let returnedError = error as? FeedViewModel.DataError
            XCTAssertEqual(returnedError, FeedViewModel.DataError.noData)
        }
    }
    
    func test_FeedViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(randomItem))
        
        do {
            try vm.saveItem(randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_FeedViewModel_downloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        vm.downloadWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_FeedViewModel_downloadWithCombine_shouldReturnItems_v1() {
        // Given
        let vm = FeedViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_FeedViewModel_downloadWithCombine_shouldReturnItems_v2() {
        // Given
        let items = [
            UUID().uuidString,
            UUID().uuidString,
            UUID().uuidString,
            UUID().uuidString,
            UUID().uuidString
        ]
        let dataService: FeedDataServiceType = FeedMockDataService(items: items)
        let vm = FeedViewModel(isPremium: Bool.random(), feedDataService: dataService)
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
}
