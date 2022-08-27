//
//  FeedViewModel.swift
//  SwiftUI-Unit-Testing
//
//  Created by Pavel Palancica on 8/27/22.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    let feedDataService: FeedDataServiceType
    var cancelables = Set<AnyCancellable>()
    
    init(isPremium: Bool, feedDataService: FeedDataServiceType = FeedMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.feedDataService = feedDataService
    }
    
    func addItem(_ item: String) {
        guard !item.isEmpty else { return }
        dataArray.append(item)
    }
    
    func selectItem(_ item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(_ item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item here!!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        feedDataService.downloadItemsWithEscaping { [weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }
    
    func downloadWithCombine() {
        feedDataService.downloadItemsWithCombine()
            .sink { _ in
                //
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancelables) // Storing the subscriber in cancelables
    }
}
