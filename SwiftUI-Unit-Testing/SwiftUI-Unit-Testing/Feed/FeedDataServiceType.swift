//
//  FeedDataServiceType.swift
//  SwiftUI-Unit-Testing
//
//  Created by Pavel Palancica on 8/28/22.
//

import Foundation
import Combine

protocol FeedDataServiceType {
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}
