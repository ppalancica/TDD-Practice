//
//  FeedView.swift
//  SwiftUI-Unit-Testing
//
//  Created by Pavel Palancica on 8/27/22.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject private var vm: FeedViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: FeedViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text("aaa")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(isPremium: true)
    }
}
