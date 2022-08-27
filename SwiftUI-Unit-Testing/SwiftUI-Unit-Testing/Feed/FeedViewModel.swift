//
//  FeedViewModel.swift
//  SwiftUI-Unit-Testing
//
//  Created by Pavel Palancica on 8/27/22.
//

import Foundation
import UIKit

class FeedViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
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
}
