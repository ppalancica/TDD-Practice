//
//  FeedMockDataService.swift
//  SwiftUI-Unit-Testing
//
//  Created by Pavel Palancica on 8/28/22.
//

import Foundation
import Combine

class FeedMockDataService: FeedDataServiceType {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "Item 1", "Item 2", "Item 3"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
}
